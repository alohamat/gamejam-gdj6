show_debug_message("TRIGGER ATIVADO");
if (can_trigger) {
    can_trigger = false;

    var controller = instance_find(obj_phase_controller, 0);

    if (controller.phase == Phase.DAY) {
        controller.phase = Phase.NIGHT;
        controller.night_number += 1;
    } else {
        controller.phase = Phase.DAY;
        controller.day_number += 1;
    }

    // 🔥 BROADCAST
    with (all) {
        if (object_index != obj_phase_controller) {
            event_user(0);
        }
    }
}