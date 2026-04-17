function scr_esconder() {
    var arb = instance_place(x, y, obj_arbusto);
    var vent = instance_place(x, y, obj_vent);

    if (arb != noone) {
        image_alpha = 0;
        arb.sprite_index = spr_arbustoescondido;
        arbusto_atual = arb;
    } else if (vent != noone) {
        image_alpha = 0;
        vent.sprite_index = spr_ventescondido;
        arbusto_atual = vent;
    }
}