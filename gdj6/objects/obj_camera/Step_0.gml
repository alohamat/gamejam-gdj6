if (instance_exists(follow)) {
    xTo = follow.x;
    yTo = follow.y;
}

x += (xTo - x) / 2;
y += (yTo - y) / 2;

var camX = clamp(x - camWidth  * 0.5, 0, room_width  - camWidth);
var camY = clamp(y - camHeight * 0.5, 0, room_height - camHeight);

camera_set_view_pos(view_camera[0], camX, camY);