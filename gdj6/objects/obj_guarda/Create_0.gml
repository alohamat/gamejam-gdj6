enum GUARD_STATE {
    PATROL,
    ALERT,
    ATTACK
}

state       = GUARD_STATE.PATROL
spd         = 0.5
spd_attack  = 1.2
HP = 100;
STR = 20;
hit = 0;
hitcool = 0;

patrol_dir        = 1      // 1 = direita, -1 = esquerda
patrol_walk_timer = 120    // quanto tempo anda (2 segundos)
patrol_idle_timer = 0      // quanto tempo fica parado
patrol_is_idle    = false

// Visão
vision_range = 220     // distância máxima do cone
vision_angle = 110     // ângulo total do cone (55° pra cada lado)

// Alert / desistência
alert_timer    = 0
alert_duration = 60   // 1 segundo em 60fps — tempo até atacar
lose_timer     = 0
lose_duration  = 240   // 4 segundos sem ver o player até desistir