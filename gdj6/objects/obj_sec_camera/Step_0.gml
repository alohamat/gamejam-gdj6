var cone_length = 150;
var cone_angle  = 45; // graus pra cada lado
var cam_dir   = 0;  // ângulo que a câmera aponta, muda conforme quiser

// Checa se o player tá dentro do cone
var dist  = point_distance(x, y, obj_player.x, obj_player.y);
var angle = point_direction(x, y, obj_player.x, obj_player.y);
var diff  = angle_difference(cam_dir, angle);

if (dist < cone_length && abs(diff) < cone_angle) {
    // Player detectado!
    // game over, alarme, o que quiser
    show_debug_message("Detectado!");
}