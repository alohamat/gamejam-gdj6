if (variable_global_exists("phase_instance"))
{
	
	if (global.phase_instance.phase == Phase.DAY) {
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
	else {
		var _id = layer_get_id("Backgrounds_3");
		layer_set_visible(_id, true);
		layer_set_visible(layer_get_id("Backgrounds_1"), true)
		layer_set_visible(layer_get_id("BackgroundPredio"), true)
		layer_set_visible(layer_get_id("Backgrounds_1_1"), true)
		layer_set_visible(layer_get_id("Backgrounds_2"), true)
		
		layer_set_visible("BackgroundMuroSol_1", false)
		layer_set_visible(layer_get_id("BackgroundMuroSol"), false)
		layer_set_visible(layer_get_id("Backgrounds_2_1"), false)
	}
	
	global.phase_instance.alarm[0] = 1;
}