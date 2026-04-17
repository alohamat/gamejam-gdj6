// Impede execução duplicada se houver mais de uma instância
if (instance_number(obj_game) > 1) {
    instance_destroy();
    exit;
}

// Só recria as traps se tiver dados salvos
if (ds_list_size(obj_game.traps) > 0) {
    for (var i = 0; i < ds_list_size(obj_game.traps); i++) {
        var data = obj_game.traps[| i];
        instance_create_layer(data[? "x"], data[? "y"], "Instances", data[? "type"]);
    }
}
    // pega todos os spawn points em ordem aleatória
    var pontos = ds_list_create();
    with (obj_spawn_point) { ds_list_add(pontos, id); }
    ds_list_shuffle(pontos);

    // spawna até o limite de guardas
    var quantidade = min(global.num_guardas, ds_list_size(pontos));
    for (var i = 0; i < quantidade; i++) {
        var ponto = pontos[| i];
        instance_create_depth(ponto.x, ponto.y, 0, obj_guarda);
    }

    ds_list_destroy(pontos);