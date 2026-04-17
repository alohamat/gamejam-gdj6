// Só recria as traps se tiver dados salvos
if (ds_list_size(obj_game.traps) > 0) {
    for (var i = 0; i < ds_list_size(obj_game.traps); i++) {
        var data = obj_game.traps[| i];
        instance_create_layer(data[? "x"], data[? "y"], "Instances", data[? "type"]);
    }
}