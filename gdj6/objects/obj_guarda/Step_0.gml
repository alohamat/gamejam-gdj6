event_inherited();

var px = obj_player.x;
var py = obj_player.y;
var player = obj_player;

// --- VISÃO COM BLOQUEIO POR PAREDES ---
var dist  = point_distance(x, y, px, py);
var angle_to_player = point_direction(x, y, px, py);
var facing_angle    = (image_xscale < 0) ? 0 : 180;
var angle_diff      = abs(angle_difference(facing_angle, angle_to_player));

var can_see_player = false;
if (player.form != "human") {
    var player_in_cone = (dist < vision_range) && (angle_diff < vision_angle / 2);
    var wall_between = collision_line(x, y, px, py, obj_parede, false, true);
    can_see_player = player_in_cone && !wall_between && !player.hidden;
}

// --- STATE MACHINE ---
switch (state) {
    case GUARD_STATE.PATROL:
        if (patrol_is_idle) {
            patrol_idle_timer--;
            if (patrol_idle_timer <= 0) {
                patrol_is_idle = false;
                patrol_dir = -patrol_dir;
                patrol_walk_timer = irandom_range(90, 180);
            }
        } else {
            // Movimento com colisão
            var move_spd = spd * patrol_dir;
            if (!place_meeting(x + move_spd, y, obj_parede)) {
                x += move_spd;
            }
            patrol_walk_timer--;

            if (patrol_walk_timer <= 0 || x > room_width - 32 || x < 32) {
                patrol_is_idle = true;
                patrol_idle_timer = irandom_range(60, 120);
            }
        }

        image_xscale = (patrol_dir > 0) ? -1 : 1;
        sprite_index = spr_enemy;

        if (can_see_player) {
            state = GUARD_STATE.ALERT;
            alert_timer = 0;
        }
        break;

    case GUARD_STATE.ALERT:
        alert_timer++;
        image_xscale = (px > x) ? -1 : 1;
        sprite_index = spr_guarda_alertado;

        if (!can_see_player) {
            state = GUARD_STATE.PATROL;
            patrol_base_y = y;
        } else if (alert_timer >= alert_duration) {
            state = GUARD_STATE.ATTACK;
        }
        break;

    case GUARD_STATE.ATTACK:
        if (px > x) {
            if (!place_meeting(x + spd_attack, y, obj_parede)) x += spd_attack;
            image_xscale = -1;
        } else {
            if (!place_meeting(x - spd_attack, y, obj_parede)) x -= spd_attack;
            image_xscale = 1;
        }
        sprite_index = spr_enemy;

        if (can_see_player) {
            lose_timer = 0;
        } else {
            lose_timer++;
            if (lose_timer >= lose_duration) {
                lose_timer = 0;
                state = GUARD_STATE.PATROL;
                patrol_base_y = y;
            }
        }
        break;
}