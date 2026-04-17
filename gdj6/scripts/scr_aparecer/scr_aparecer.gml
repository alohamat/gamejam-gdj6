function scr_aparecer() {
    image_alpha = 1;

    if (arbusto_atual != noone) {
        arbusto_atual.sprite_index = spr_arbusto1;
        arbusto_atual = noone;
    }
}