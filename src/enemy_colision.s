.module enemy_colision
.area _CODE

.include "datos.h.s"
.include "Player.h.s"
.include "cpctelera.h.s"
.include "destroyEnemy.h.s"
.include "destruyePlayer.h.s"
.include "enemy.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ESTA RUTINA SÓLO COMPRUEBA SI EL ENEMIGO CHOCA CONTRA EL PLAYER ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

colision_enemy::
    ld iy, #num_enemigos
    ld  e, 0(iy)                         
sigui_enemy:
    push de                                        ;; Preservo E 
    call colision                                  ;; Borrar una entidad enemigo enemigo
    pop  de                                        ;; Recupero número de entidades enemigas
    dec e                                          ;; Resta uno al total de entidades enemigas
    ret z                                          ;; Si no quedan enemigos vuelve
    ld bc, #tamagno_enemy                          ;; El tamaño de los datos de un enemigo
    add ix,bc                                      ;; Se suma a Ix oara deslazar el puntero
    jr sigui_enemy                                 ;; Siguiente enemigo a borrar
    ret

colision:
    ld  a, StatusAni(ix)                           ;; Comprobar el estado de la animación 
    cp #0x00                                       ;; Si no es cero es que esta explotando 
    ret nz                                         ;; Por lo tanto vuelve por que no hay que comprobar colosiones
    ld  b, enemiX(ix)                              ;; Posición X del enemigo
    ld  a, enemiAncho(ix)                          ;; Ancho del enemigo
    add a, b                                       ;; Se suman
    ld  b, a                                       ;; En resultado se guarda en B
    call posXplayerPtr                             ;; Obtenemos la posición X del player
    ld  a, (hl)                                    ;; Guardar la coordena X en A
    cp  b                                          ;; Las comparamos
    jr  z, verSiMenor                              ;; Si es igual 
    jr  c, verSiMenor                              ;; o mayor
    ret                                            ;; Si no lo son, no puede haber colisión
verSiMenor:
    ld  b, 0(ix)                                   ;; Posición X del enemigo
    add a, #0x05                                   ;; Ancho del player (mejorable)
    cp  b                                          ;; Comparar
    jr  z, verSiColY                               ;; Si es igual
    jr  nc, verSiColY                              ;; o menor
    ret                                            ;; Si llega aquí no puede haber colisión

verSiColY:
    ld  b, enemiY(ix)                              ;; La coordenada Y del sprite del enemigo en B
    ld  a, enemiAlto(ix)                           ;; La altura del sprite del enemigo en A
    add a, b                                       ;; Se suma a la coordenada X del enemigo, resultado en A
    ld  b, a                                       ;; Lo guardo en B
    ld  a, #0xC1                                   ;; C1 es la posición Y del player, que nunca cambia durante el juego (mejor usar constantes)
    cp  b                                          ;; Se comparan, y si son iguales
    jr  z, choque                                  ;; Colisionaron
    jr  c, choque                                  ;; Si A es menor que B tambien hay colisión
    ret
choque:                                            ;; Si llego hasta aquí es que hubo colisión
    call destruyeEnemigo
    call destruyePlayer

 
  
    ret