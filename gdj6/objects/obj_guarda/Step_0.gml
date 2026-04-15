event_inherited();

spd=2
if hit=0
{
	
if obj_player.x>x
{x+=spd image_xscale=-1}else{x-=spd image_xscale=1}

sprite_index=spr_enemy
}
