phase_timer++;

if (phase_timer >= phase_duration) {
    phase_timer = 0;

    if (phase == Phase.DAY) {
        phase = Phase.NIGHT;
        night_number++;
    } else {
        phase = Phase.DAY;
        day_number++;
    }

    event_user(0); // avisa geral
}