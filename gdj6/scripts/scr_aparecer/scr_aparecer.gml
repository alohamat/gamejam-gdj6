function scr_aparecer() {
    image_alpha = 1;
    if (arbusto_atual != noone) {
        if (object_get_name(arbusto_atual.object_index) == "obj_vent") {
            arbusto_atual.sprite_index = spr_vent;
        } else {
            arbusto_atual.sprite_index = spr_arbusto1;
        }
        arbusto_atual = noone;
    }
}