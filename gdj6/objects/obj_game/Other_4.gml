// Apaga os guardas do editor (se tiver algum colocado manualmente)
// e spawna via código baseado na noite

/*var guard_count = 2 + (obj_game.night * 2); // noite 1 = 4, noite 2 = 6...

repeat (guard_count) {
    var gx = irandom_range(100, room_width - 100);
    var gy = irandom_range(obj_player.y, obj_player.y);
    instance_create_layer(gx, gy, "Instances", obj_guarda);
}