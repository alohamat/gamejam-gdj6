// Busca a instância atual do player nesse room
if (instance_exists(obj_player)) {
    follow = instance_find(obj_player, 0);
}
camWidth  = camera_get_view_width(view_camera[0]);
camHeight = camera_get_view_height(view_camera[0]);