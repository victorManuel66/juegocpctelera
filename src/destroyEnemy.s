.module destroyEnemy
.area _CODE

.include "datos.h.s"
.include "enemy.h.s"


destruyeEnemigo::

    ld enemiVelo(ix), #0x00                          ;; El enemigo se para
    ld StatusAni(ix), #0x01                          ;; Dibujar el primer fotograma de la explosión.      
    
    ret

