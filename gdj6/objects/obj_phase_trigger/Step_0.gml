// countdown
if (cooldown > 0) {
    cooldown--;
}

// detecta player
if (place_meeting(x, y, obj_player)) {

    if (can_trigger && cooldown <= 0) {

        var controller = instance_find(obj_phase_controller, 0);

        // troca fase
        if (controller.phase == 0) {
            controller.phase = 1;
        } else {
            controller.phase = 0;
        }

        // broadcast
        with (obj_player) {
            event_user(0);
        }

        show_debug_message("TROCOU FASE");

        // trava
        can_trigger = false;
        cooldown = cooldown_max;
    }

} else {
    // só libera quando o player sai
    can_trigger = true;
}