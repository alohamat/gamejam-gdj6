function scr_esconder() {
    var arb = instance_place(x, y, obj_arbusto);

    if (arb != noone) {
        image_alpha = 0;
        arb.sprite_index = spr_arbustoescondido;
        arbusto_atual = arb;
    }
}