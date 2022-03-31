.area _CODE

.include "cpctelera.h.s"
.include "enemy.h.s"
.include "laser.h.s"
.include "Player.h.s"
.include "datos.h.s"
.include "destroyEnemy.h.s"
.include "marcador.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ESTA RUTINA COMPRUEBA SI EL LASER COLISONA CONTRA EL ENEMIGO ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

laser_colision::
    ld iy, #num_enemigos
    ld  e, 0(iy)                                    ;; Cargar E con el contenido de la posición de memoria num_enemigos                        
sigui_enemy:
    push de                                         ;; Preservo E por que el sonido corrompe DE
    call laser_coli                                 ;; Ver si collisiona un enemigo
    pop  de                                         ;; Recupero número de entidades enemigas
    dec e                                           ;; Resta uno al total de entidades enemigas
    ret z                                           ;; Si no quedan enemigos vuelve
    ld bc, #tamagno_enemy                           ;; El tamaño de los datos de un enemigo
    add ix,bc                                       ;; Se suma a IX para desplazar el puntero
    jr sigui_enemy                                  ;; Siguiente enemigo
 
laser_coli: 
    ld  a, StatusAni(ix)                            ;; Comprobar el estado de la animación 
    cp #0x00                                        ;; Si no es cero es que esta explotando 
    ret nz                                          ;; Por lo tanto vuelve por que no hay que comprobar colosiones
    ld  b, enemiX(ix)                               ;; En B coordenada X del enemigo                                
    call posXlaserPtr                               ;; HL la dirección de la coordenada Y del laser
    ld  a,(hl)                                      ;; el valor al acumulador
    cp  b                                           ;; Se comparan
    ret c                                           ;; Si A<B no hay colisión en eje X
    inc b
    inc b                                           ;; Suma dos al ancho del enemigo. Esto es mejorable, sumando el ancho de cualquier sprite
    cp  b                                           ;; Para ver si A>B
    jr  z, verY                                     ;; Si son iguales hay colision en X
    ret nc                                          ;; Si A>B ho hay colision en el eje X
verY:
    ld  a, 1(ix)                                    ;; En A la coordenada Y del enemigo
    add a, #0x08                                    ;; por que el enemigo tiene 8 bytes de alto, esto también es mejorable
    ld  b, a                                        ;; ahora en B
    call posYlaserPtr                               ;; HL la dirección de la coordenada Y del laser
    ld  a, (hl)                                     ;; el valor al acumulador
    cp  a,b                                         ;; se comparan
    ret nc                                          ;; Si A>B no hay colisión

    ;; Si llegas aquí es que ha habido colision

    push ix                                         ;; Por que explosion corrompe IX
    call explosion                                  ;; Sonido de explosion
    pop ix


    ;; Destruir el laser
    call posYlaserPtr                               ;; Posición de memoria coordenada Y del laser
    ld  b,(hl)                                      ;; Registro B con la posición Y del laser
    ld  a, #0xBD                                    ;; Coordenada Y del laser reseteada
    ld (hl), a                                      ;; Coordenada Y del laser ahora hay un nueve
    call posXlaserPtr                               ;; Pedir la posición X de láser
    ld c,(hl)                                       ;; Se guarda en C
    ld de, #0xC000                                  ;; DE tiene la posición de inicio de la pantalla
    call cpct_getScreenPtr_asm                      ;; Calcular la posición de memoria
    ex de, hl
    ld  a, #0x00
    ld bc, #0x0401
    call cpct_drawSolidBox_asm                      ;; Se dibuja un cuadrado en color del fondo para borrar el láser
    call disparando                                 ;; Para acceder a la posición de memoria disparando
    xor a                                           ;; Se pone a cero para indicar que ya no se esta disparando
    ld (hl),a                                       ;; Y se guarda en disparando
    
    ;; Destruir el alien
    call destruyeEnemigo                            ;; Destruye al alien enemigo
    call suma                                       ;; Suma puntos al marcador
    
    ret

explosion:
    ld  a, #0x02                                    ;; Para el efecto que esta sonando en el canal 2
    call cpct_akp_SFXStop_asm
    ;; A = No Channel (0,1,2)
    ;; L = Instrument Number (>0)
    ;; H = Volume (0...F)
    ;; E = Note (0...143)
    ;; D = Speed (0 = As original, 1...255 = new Speed (1 is the fastest))
    ;; BC = Inverted Pitch (-#FFFF -> FFFF). 0 is no pitch. The higher the pitch, the lower the sound.
    ld  a, #0x01
    ld hl, #0x0F04
    ld de, #0x0014
    ld bc, #0x0000
    call cpct_akp_SFXPlay_asm
    ret
