function scr_toggle_phase(controller) {
    if (controller.phase == Phase.DAY) {
        controller.phase = Phase.NIGHT;
        controller.night_number += 1;
    } else {
        controller.phase = Phase.DAY;
        controller.day_number += 1;
    }

    with (all) {
        if (object_index != obj_phase_controller) {
            event_user(0);
        }
    }
}