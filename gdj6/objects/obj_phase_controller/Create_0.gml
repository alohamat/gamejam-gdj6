if (variable_global_exists("phase_instance")) {
	instance_destroy(self);
	exit;
}
else {
	global.phase_instance = self;
}

enum Phase {
    DAY,
    NIGHT
}

phase = Phase.DAY;

day_number = 1;
night_number = 0;