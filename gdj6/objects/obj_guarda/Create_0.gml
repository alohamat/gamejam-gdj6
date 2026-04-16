enum GUARD_STATE {
    PATROL,
    ALERT,
    ATTACK
}

state       = GUARD_STATE.PATROL
spd         = 1.5
spd_attack  = 2.8
HP = 100;
STR = 20;
hitcool = 0;

// Patrulha senoidal
patrol_x_speed = 1.5   // velocidade horizontal
patrol_sine_amp = 40   // amplitude vertical (o quanto ondula)
patrol_sine_spd = 0.04 // frequência da onda
patrol_sine_t   = 0    // tempo acumulado

// Visão
vision_range = 220     // distância máxima do cone
vision_angle = 110     // ângulo total do cone (55° pra cada lado)

// Alert / desistência
alert_timer    = 0
alert_duration = 60   // 1 segundo em 60fps — tempo até atacar
lose_timer     = 0
lose_duration  = 240   // 4 segundos sem ver o player até desistir