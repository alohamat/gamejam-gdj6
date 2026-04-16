event_inherited();

var px = obj_player.x;
var py = obj_player.y;

// --- VISÃO: checa se o player está no cone ---
var dist  = point_distance(x, y, px, py);
var angle_to_player = point_direction(x, y, px, py);
var facing_angle    = (image_xscale < 0) ? 0 : 180; // olhando direita = 0°, esquerda = 180°
var angle_diff      = abs(angle_difference(facing_angle, angle_to_player));

var player_hidden = obj_player.hidden; // variável hidden do player
var can_see_player = (dist < vision_range) && (angle_diff < vision_angle / 2) && !player_hidden;

// --- STATE MACHINE ---
switch (state) {

  case GUARD_STATE.PATROL:
    // Onda senoidal só na velocidade horizontal
    patrol_sine_t += patrol_sine_spd;
    var sine_speed = sin(patrol_sine_t) * patrol_x_speed;
    x += sine_speed;

    // Inverte direção nas bordas da room
    if x > room_width - 32 { patrol_sine_t = -patrol_sine_t; x = room_width - 32; }
    if x < 32              { patrol_sine_t = -patrol_sine_t; x = 32; }

    // Sprite vira conforme direção atual
    if sine_speed > 0.1       { image_xscale = -1; }
    else if sine_speed < -0.1 { image_xscale =  1; }

    sprite_index = spr_enemy;

    if can_see_player {
        state       = GUARD_STATE.ALERT;
        alert_timer = 0;
    }
break;

    case GUARD_STATE.ALERT:
        // Fica parado, "percebeu algo"
        alert_timer++;

        // Continua olhando pro player durante o alerta
        image_xscale = (px > x) ? -1 : 1;
		sprite_index = spr_guarda_alertado

        if !can_see_player {
            // Perdeu o player antes de atacar, volta a patrulhar
            state = GUARD_STATE.PATROL;
            patrol_base_y = y;
        } else if alert_timer >= alert_duration {
            state = GUARD_STATE.ATTACK;
        }
    break;

    case GUARD_STATE.ATTACK:
        // Vai em direção ao player (comportamento que já tinha)
        if px > x { x += spd_attack; image_xscale = -1; }
        else       { x -= spd_attack; image_xscale =  1; }

        sprite_index = spr_enemy;

        if can_see_player {
            lose_timer = 0;
        } else {
            lose_timer++;
            if lose_timer >= lose_duration {
                lose_timer    = 0;
                state         = GUARD_STATE.PATROL;
                patrol_base_y = y;
            }
        }
    break;
}