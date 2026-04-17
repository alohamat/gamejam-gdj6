function scr_toggle_phase(controller) {
	
    if (controller.phase == Phase.DAY) {
        controller.phase = Phase.NIGHT;
        controller.night_number += 1;
		var _id = layer_get_id("Backgrounds_3");
		layer_set_visible(_id, true);
		layer_set_visible(layer_get_id("Backgrounds_1"), true)
		layer_set_visible(layer_get_id("BackgroundPredio"), true)
		layer_set_visible(layer_get_id("Backgrounds_1_1"), true)
		layer_set_visible(layer_get_id("Backgrounds_2"), true)
		
		layer_set_visible("BackgroundMuroSol_1", false)
		layer_set_visible(layer_get_id("BackgroundMuroSol"), false)
		layer_set_visible(layer_get_id("Backgrounds_2_1"), false)
    } else {
        controller.phase = Phase.DAY;
        controller.day_number += 1;
		var _id = layer_get_id("Backgrounds_3");
		layer_set_visible(_id, false);
		layer_set_visible(layer_get_id("Backgrounds_1"), false)
		layer_set_visible(layer_get_id("BackgroundPredio"), false)
		layer_set_visible(layer_get_id("Backgrounds_1_1"), false)
		layer_set_visible(layer_get_id("Backgrounds_2"), false)
		layer_set_visible(layer_get_id("BackgroundMuroSol_1"), true)
		layer_set_visible(layer_get_id("BackgroundMuroSol"), true)
		layer_set_visible(layer_get_id("Backgrounds_2_1"), true)
    }

    //with (all) {
    //    if (object_index != obj_phase_controller) {
    //        event_user(0);
    //    }
    //}
}