hsp = 0;
vsp = 0;

x_prev = x;
y_prev = y;

attack = 0;
hit = 0;
hitcool = 50;

hidden = false;
arbusto_atual = noone;
HP = 100;

is_crouching = false;
is_climbing = false;
wall_jump_timer = 0;
can_stand = true;

form = "human";

spd_human = 2.2;
spd_werewolf = 3.2;
jump_power = -7;
climb_speed = 2;

mask_normal_x1 = bbox_left - x;
mask_normal_y1 = bbox_top - y;
mask_normal_x2 = bbox_right - x;
mask_normal_y2 = bbox_bottom - y;