if hitcool >0{hitcool-=1}

if HP<=0{
	instance_destroy()
	on_death();
}