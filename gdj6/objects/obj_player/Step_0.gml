// --- RASTEJAR ---
can_stand = !place_meeting(x, y - 1, obj_chao);
if keyboard_check_pressed(ord("C")) {
    if is_crouching && can_stand {
        is_crouching = false;
        y -= 8;
    } else if !is_crouching {
        is_crouching = true;
    }
}
if is_crouching {
    mask_index = spr_player_rastejando;
    sprite_index = spr_player_rastejando;
    spd = 1;
} else {
    mask_index = spr_player;
    sprite_index = spr_player;
    spd = 3;
}

// --- ESCALAR ---
if (wall_jump_timer > 0) {
    wall_jump_timer -= 1;  // Countdown each step
    is_climbing = false;
} else if (!is_crouching) {
    is_climbing = (place_meeting(x+1, y, obj_parede) || place_meeting(x-1, y, obj_parede));
} else {
    is_climbing = false;
}


// --- MOVIMENTO HORIZONTAL ---
move = -keyboard_check(vk_left) + keyboard_check(vk_right);
if hit==0
{
if is_climbing || place_meeting(x, y+1, obj_chao) {
    hsp = spd * move;
} else {
    hsp += (spd * move - hsp) * 0.1;
	}
}
if place_meeting(x+hsp, y, obj_chao) || place_meeting(x+hsp, y, obj_parede) {
    while !place_meeting(x+sign(hsp), y, obj_chao) && !place_meeting(x+sign(hsp), y, obj_parede) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

// --- PULO E GRAVIDADE ---
if place_meeting(x, y+1, obj_chao) {
	wall_jump_timer = 0;
	if (attack == 0 && hit == 0 && keyboard_check_pressed(ord("Z"))) {
    vsp = -7;
	
    }
} else if is_climbing {
    vsp = -2 * keyboard_check(vk_up) + 2 * keyboard_check(vk_down);
   if (attack == 0 && keyboard_check_pressed(ord("Z"))) {
    is_climbing = false;
    wall_jump_timer = 12;  // ~12 frames cooldown (adjust as needed)
    vsp = -7;
    if (place_meeting(x+1, y, obj_parede)) {
        hsp = -6;
    } else {
        hsp = 6;
    }
}

} else {
    vsp += 0.3;
}

// --- MOVIMENTO VERTICAL ---
if place_meeting(x, y+vsp, obj_chao) || place_meeting(x, y+vsp, obj_parede) {
    while !place_meeting(x, y+sign(vsp), obj_chao) && !place_meeting(x, y+sign(vsp), obj_parede) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;

// --- VIRAR SPRITE ---
if move != 0 && attack == 0 && !is_climbing && hit==0{
    image_xscale = move;
}

y = round(y);

// --- ATACAR ---
if keyboard_check_pressed(ord("X")) && attack == 0 && hit==0{
    attack = 1;
    var d = instance_create_depth(x, y, depth-1, obj_ataque);
    d.x = x;
    d.y = y;
    d.image_xscale = image_xscale;
}

if hitcool > 0{hitcool-=1}

if hit==0 {
    if is_crouching {
        sprite_index = spr_player_rastejando;
    } else {
        sprite_index = spr_player;
    }
}

depth =-99999

if (HP <=0){
	(room_goto(rm_Gameover))
}

// --- ESCONDER ---
// Esconder no arbusto
if place_meeting(x, y, obj_arbusto) && keyboard_check_pressed(vk_up) {
    hidden = true;
}

// Sair do arbusto (qualquer direção ou botão que faça sentido)
if !place_meeting(x, y, obj_arbusto) {
    hidden = false;
}