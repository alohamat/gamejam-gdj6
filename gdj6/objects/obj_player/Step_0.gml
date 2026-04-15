//versão certa

move =-keyboard_check(vk_left)+keyboard_check(vk_right)

hsp =3*move

if place_meeting(x+hsp,y,obj_chao)
{
while !place_meeting(x+sign(hsp),y,obj_chao)
{
	x+=sign(hsp)
}
hsp=0
}
x+=hsp

if place_meeting(x,y+vsp,obj_chao)
{
while !place_meeting(x,y+sign(vsp),obj_chao)
{
	y+=sign(vsp)
}
vsp=0
}
y+=vsp

//pra ele se virar quando for pra outro lado
if move != 0 && attack=0
{
	image_xscale=move
}

if place_meeting(x, y + 1, obj_chao)
{
    if (attack == 0 && keyboard_check_pressed(ord("Z")))
    {
        vsp = -7;
    }
}
else
{
    vsp += 0.3;
}

y=round(y)

if (keyboard_check_pressed(ord("X")) && attack == 0)
{
    attack = 1;
    
    var d = instance_create_depth(x, y, depth - 1, obj_ataque);
    d.x = x;
    d.y = y;
    d.image_xscale = image_xscale;
}
