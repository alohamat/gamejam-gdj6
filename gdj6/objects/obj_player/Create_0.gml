hsp=0;
vsp=0;
attack = 0;
hit = 0;
hitcool = 0;
hidden = false;
HP = 100;
hitcool=50
spd = 3;
is_crouching = false;
is_climbing = false;
wall_jump_timer = 0;  // 0 = pode escalar, >0 = acabou de pular
can_stand = true;

// guarda as dimensões originais da hitbox
mask_normal_x1 = bbox_left - x;
mask_normal_y1 = bbox_top - y;
mask_normal_x2 = bbox_right - x;
mask_normal_y2 = bbox_bottom - y;