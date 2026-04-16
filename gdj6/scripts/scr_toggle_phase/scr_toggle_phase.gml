function scr_toggle_phase(){
	if (obj_phase_controller.phase == Phase.DAY) {
    obj_phase_controller.phase = Phase.NIGHT;
    obj_phase_controller.night_number += 1;
} else {
    obj_phase_controller.phase = Phase.DAY;
    obj_phase_controller.day_number += 1;
}
with (all) {
    if (object_index != obj_phase_controller) {
        event_user(0);
    }
}
}