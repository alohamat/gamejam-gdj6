// =====================================================
// COMUM A QUALQUER FORMA
// =====================================================

if (hitcool > 0) {
    hitcool -= 1;
}

if (HP <= 0) {
    room_goto(rm_Gameover);
}

// verifica se mudou de posição
var moving = (x != x_prev) || (y != y_prev);

if (hidden && moving) {
    hidden = false;
    scr_aparecer();
}

// atualiza posição
x_prev = x;
y_prev = y;

// Esconder no arbusto
if (keyboard_check_pressed(vk_up) && !(form == "human")) {
    if (!hidden) {
        if (place_meeting(x, y, obj_arbusto)) {
            hidden = true;
            scr_esconder();
        }
    } else {
        hidden = false;
        scr_aparecer();
    }
}

// Reset básico
can_stand = !place_meeting(x, y - 1, obj_chao) && !place_meeting(x, y - 1, obj_parede);

move = -keyboard_check(vk_left) + keyboard_check(vk_right);

// =====================================================
// FORMA HUMANA
// =====================================================
if (form == "human") {

    attack = 0;
    is_crouching = false;
    is_climbing = false;
    wall_jump_timer = 0;

    mask_index = spr_player_human;
    sprite_index = spr_player_human;
    spd = spd_human;

    // Movimento horizontal simples
    if (hit == 0) {
        if (place_meeting(x, y + 1, obj_chao)) {
            hsp = spd * move;
        } else {
            hsp += (spd * move - hsp) * 0.1;
        }
    }

    if (place_meeting(x + hsp, y, obj_chao) || place_meeting(x + hsp, y, obj_parede)) {
        while (!place_meeting(x + sign(hsp), y, obj_chao) && !place_meeting(x + sign(hsp), y, obj_parede)) {
            x += sign(hsp);
        }
        hsp = 0;
    }
    x += hsp;

    // Gravidade / pulo normal
    if (place_meeting(x, y + 1, obj_chao)) {
        wall_jump_timer = 0;
        if (keyboard_check_pressed(ord("Z"))) {
            vsp = jump_power;
        }
    } else {
        vsp += 0.3;
    }

    // Movimento vertical
    if (place_meeting(x, y + vsp, obj_chao) || place_meeting(x, y + vsp, obj_parede)) {
        while (!place_meeting(x, y + sign(vsp), obj_chao) && !place_meeting(x, y + sign(vsp), obj_parede)) {
            y += sign(vsp);
        }
        vsp = 0;
    }
    y += vsp;

    // Virar sprite
    if (move != 0 && hit == 0) {
        image_xscale = move;
    }
}

// =====================================================
// FORMA LOBISOMEM
// =====================================================
else {

    mask_index = spr_player;
    sprite_index = spr_player;
    spd = spd_werewolf;

    // Crouch — só o lobisomem agacha
    if (keyboard_check_pressed(ord("C"))) {
    if (is_crouching && can_stand) {
        is_crouching = false;
        y -= 8;
    } else if (!is_crouching) {
        is_crouching = true;
        is_climbing = false; // <- cancela o climb
        wall_jump_timer = 30; // <- dá o timer pra não grudar de volta imediatamente
    }
}

    if (is_crouching) {
        mask_index = spr_player_rastejando;
        sprite_index = spr_player_rastejando;
        spd = 1.3;
    }

    // Movimento horizontal
    if (hit == 0) {
        if (is_climbing || place_meeting(x, y + 1, obj_chao)) {
            hsp = spd * move;
        } else {
            hsp += (spd * move - hsp) * 0.1;
        }
    }

    if (place_meeting(x + hsp, y, obj_chao) || place_meeting(x + hsp, y, obj_parede)) {
        while (!place_meeting(x + sign(hsp), y, obj_chao) && !place_meeting(x + sign(hsp), y, obj_parede)) {
            x += sign(hsp);
        }
        hsp = 0;
    }
    x += hsp;

    // Escalar
    if (wall_jump_timer > 0) {
        wall_jump_timer -= 1;
        is_climbing = false;
    } else {
        is_climbing = (place_meeting(x + 1, y, obj_parede) || place_meeting(x - 1, y, obj_parede));
    }

    // Vertical / pulo / gravidade
    if (place_meeting(x, y + 1, obj_chao)) {
        wall_jump_timer = 0;

        if (attack == 0 && hit == 0 && !is_crouching && keyboard_check_pressed(ord("Z"))) {
            vsp = jump_power;
        }

    } else if (is_climbing) {
        vsp = (-2 * keyboard_check(vk_up)) + (2 * keyboard_check(vk_down));

        if (attack == 0 && keyboard_check_pressed(ord("Z"))) {
            is_climbing = false;
            wall_jump_timer = 12;
            vsp = jump_power;

            if (place_meeting(x + 1, y, obj_parede)) {
                hsp = -6;
            } else {
                hsp = 6;
            }
        }

    } else {
        vsp += 0.3;
    }

    if (place_meeting(x, y + vsp, obj_chao) || place_meeting(x, y + vsp, obj_parede)) {
        while (!place_meeting(x, y + sign(vsp), obj_chao) && !place_meeting(x, y + sign(vsp), obj_parede)) {
            y += sign(vsp);
        }
        vsp = 0;
    }
    y += vsp;

    // Virar sprite
    if (move != 0 && hit == 0 && !is_climbing) {
        image_xscale = move;
    }

    // Ataque
    if (keyboard_check_pressed(ord("X")) && attack == 0 && hit == 0) {
        attack = 1;
        var d = instance_create_depth(x, y, depth - 1, obj_ataque);
        d.x = x;
        d.y = y;
        d.image_xscale = image_xscale;
    }
}

// Exemplo: spawnar espinho onde o mouse tá
if (mouse_check_button_pressed(mb_left)) {
    var trap_obj = obj_sec_camera; // ou obj_camera_seguranca
    var inst = instance_create_layer(mouse_x, mouse_y, "Instances", trap_obj);
    
    // Salva no obj_game
    var data = ds_map_create();
    data[? "type"] = trap_obj;
    data[? "x"]    = mouse_x;
    data[? "y"]    = mouse_y;
    ds_list_add(obj_game.traps, data);
}

y = round(y);
depth = -99999;
