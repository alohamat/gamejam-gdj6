// Antes de trocar de room, anota de onde veio
obj_player.came_from = room;

if (room == Room1) {
    room_goto(rm_predio);
} else {
    room_goto(Room1);
}