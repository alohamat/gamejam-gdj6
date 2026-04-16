if hit = 0 && hitcool = 0 {
    var backstab = false;

    // Sprite padrão olha ESQUERDA
    // image_xscale = -1 → inimigo olha direita → costas à esquerda → other.x < x
    // image_xscale =  1 → inimigo olha esquerda → costas à direita → other.x > x
    if (image_xscale == -1 && other.x < x) { backstab = true; }
    if (image_xscale ==  1 && other.x > x) { backstab = true; }

    if backstab {
        HP = 0; // self = inimigo
    } else {
        HP -= other.STR;
    }
	show_debug_message("backstab=" + string(backstab) + " | enemy_xscale=" + string(image_xscale) + " | other.x=" + string(other.x) + " | self.x=" + string(x) + " | HP=" + string(HP));

    hit = 1;
    hitcool = 30;
    sprite_index = spr_enemy_hit;
    alarm[0] = 30;
}