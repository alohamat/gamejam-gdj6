if hit=0 && hitcool =0 && !(form == "human")
{
	hit=1
	sprite_index=spr_playerhit
	alarm[0]=20
	
	vsp=-3		
	
	if other.x>x{hsp=-2}else{hsp=2}
	
	hitcool=50
	
	HP-=other.STR;
}