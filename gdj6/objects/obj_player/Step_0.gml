// =====================================================
// COMUM A QUALQUER FORMA
// =====================================================

if (hitcool > 0) {
    hitcool -= 1;
}

if (HP <= 0) {
    room_goto(rm_Gameover);
}

// Esconder no arbusto
if (place_meeting(x, y, obj_arbusto)) {
    if (keyboard_check_pressed(vk_up)) {
        hidden = true;
    }
} else {
    hidden = false;
}

// Reset básico
can_stand = !place_meeting(x, y - 1, obj_chao);

move = -keyboard_check(vk_left) + keyboard_check(vk_right);

// =====================================================
// FORMA HUMANA
// =====================================================
if (form == "human") {

    attack = 0;
    is_climbing = false;
    wall_jump_timer = 0;

    // Crouch
    if (keyboard_check_pressed(ord("C")) && !(form == "human")) {
        if (is_crouching && can_stand) {
            is_crouching = false;
            y -= 8;
        } else if (!is_crouching) {
            is_crouching = true;
        }
    }

    if (is_crouching) {
        mask_index = spr_player_rastejando;
        sprite_index = spr_player_rastejando;
        spd = 1.3;
    } else {
        mask_index = spr_player_human;
        sprite_index = spr_player_human;
        spd = spd_human;
    }

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

    // Armadilha
    if (mouse_check_button_pressed(mb_left)) {
        // instance_create_layer(mouse_x, mouse_y, "Instances", obj_trap);
    }
}

// =====================================================
// FORMA LOBISOMEM
// =====================================================
else {

    // Estado do lobo
    is_crouching = false;

    mask_index = spr_player;
    sprite_index = spr_player; // troca depois por sprite próprio do lobo, se tiver
    spd = spd_werewolf;

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

        if (attack == 0 && hit == 0 && keyboard_check_pressed(ord("Z"))) {
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

    // Ataque só no lobisomem
    if (keyboard_check_pressed(ord("X")) && attack == 0 && hit == 0) {
        attack = 1;
        var d = instance_create_depth(x, y, depth - 1, obj_ataque);
        d.x = x;
        d.y = y;
        d.image_xscale = image_xscale;
    }

    if (mouse_check_button_pressed(mb_left)) {
        // nada aqui no lobo, ou outra habilidade depois
    }
}

y = round(y);
depth = -99999;