.area _CODE

.include "cpctelera.h.s"
.include "datos.h.s"

.globl _enemigo
.globl _explo1
.globl _explo2
.globl _explo3
.globl _explo4
.globl _explo5

.macro EntEnemigas name, x, y, h, w, _enemigo, velo, tiem, sta, animac1, animac2, animac3, animac4, animac5
  name::
    name'X:      .db x
    name'Y:      .db y
    name'H:      .db h
    name'W:      .db w
    name'spr:    .dw _enemigo
    name'vel:    .db velo
    name'tiemp:  .db tiem
    name'status: .db sta
    name'ani1:   .dw animac1
    name'ani2:   .dw animac2
    name'ani3:   .dw animac3
    name'ani4:   .dw animac4
    name'ani5:   .dw animac5
.endm

EntEnemigas enemy, 0x00, 0x09, 0x08, 0x03, _enemigo, 0x01, 0x00, 0x00, _explo1, _explo2, _explo3, _explo4, _explo5
EntEnemigas enemy2, 0x00, 0x09, 0x08, 0x03, _enemigo, 0x01, 0x00, 0x00, _explo1, _explo2, _explo3, _explo4, _explo5
EntEnemigas enemy3, 0x00, 0x09, 0x08, 0x03, _enemigo, 0x01, 0x00, 0x00, _explo1, _explo2, _explo3, _explo4, _explo5



;;
;;enemy::
;;    enemyX:     .db 0x00                               ;; Este será un número aleatorio entre 4 y 48
;;    enemyY:     .db 0x09                               ;; Coordenada Y del enemigo
;;    enemyAlto:  .db 0x08                               ;; Alto del Sprite en bytes del enemigo
;;    enemyAncho: .db 0x03                               ;; Ancho del Sprte en bytes del enemigo
;;    ptrSprite:  .dw _enemigo                           ;; Puntero a los datos del Sprite del enemigo
;;    velocidad:  .db 0x01                               ;; Velocidad del enemigo
;;    duraAnim:   .db 0x00                               ;; Tiempo que dura cada animación
;;    estadoAni:  .db 0x00                               ;; Estado de la animación
;;    anima1:     .dw _explo1                            ;; Primer frame de la animación
;;    anima2:     .dw _explo2                            ;; Segundo frame de la animación
;;    anima3:     .dw _explo3                            ;; Tercer frame de la animación
;;    anima4:     .dw _explo4                            ;; Cuarto frame de la animación
;;    anima5:     .dw _explo5                            ;; Quinto frame de la animación
;;enemy2::
;;    enemyX2:     .db 0x00                              ;; Este será un número aleatorio entre 4 y 48
;;    enemyY2:     .db 0x09                              ;; Coordenada Y del enemigo
;;    enemyAlto2:  .db 0x08                              ;; Alto del Sprite en bytes del enemigo
;;    enemyAncho2: .db 0x03                              ;; Ancho del Sprte en bytes del enemigo
;;    ptrSprite2:  .dw _enemigo                          ;; Puntero a los datos del Sprite del enemigo
;;    velocidad2:  .db 0x01                              ;; Velocidad del enemigo
;;    duraAnim2:   .db 0x00                              ;; Tiempo que dura cada animación
;;    estadoAni2:  .db 0x00                              ;; Estado de la animación
;;    anima1_2:    .dw _explo1                           ;; Primer frame de la animación
;;    anima2_2:    .dw _explo2                           ;; Segundo frame de la animación
;;    anima3_2:    .dw _explo3                           ;; Tercer frame de la animación
;;    anima4_2:    .dw _explo4                           ;; Cuarto frame de la animación
;;    anima5_2:    .dw _explo5                           ;; Quinto frame de la animación
;;enemy3::
;;    enemyX3:     .db 0x00                              ;; Este será un número aleatorio entre 4 y 48
;;    enemyY3:     .db 0x09                              ;; Coordenada Y del enemigo
;;    enemyAlto3:  .db 0x08                              ;; Alto del Sprite en bytes del enemigo
;;    enemyAncho3: .db 0x03                              ;; Ancho del Sprte en bytes del enemigo
;;    ptrSprite3:  .dw _enemigo                          ;; Puntero a los datos del Sprite del enemigo
;;    velocidad3:  .db 0x01                              ;; Velocidad del enemigo
;;    duraAnim3:   .db 0x00                              ;; Tiempo que dura cada animación
;;    estadoAni3:  .db 0x00                              ;; Estado de la animación
;;    anima1_3:    .dw _explo1                           ;; Primer frame de la animación
;;    anima2_3:    .dw _explo2                           ;; Segundo frame de la animación
;;    anima3_3:    .dw _explo3                           ;; Tercer frame de la animación
;;    anima4_3:    .dw _explo4                           ;; Cuarto frame de la animación
;;    anima5_3:    .dw _explo5                           ;; Quinto frame de la animación
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;          ESTA RUTINA NECESITA EN IX LA DIRECCIÓN DE INICIO DE LOS DATOS DE LA ENTIDAD ENEMIGO            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                   
calXenemy::
    call cpct_getRandom_xsp40_u8_asm                   ;; Devuelve en A un numero pseudo aleatorio de 8 bits
    cp #0x05                                           ;; Comparo con el valor mmímimo
    jr c, menorCuatro                                  ;; Si es menor que cuatro salta a menorCuatro
    cp #0x2f                                           ;; Comparo con 48 decimal
    jr nc, mayor47                                     ;; Si no hay acarreo es que es mayor de 48
    jr fin                                             ;; Si llego aquí es porque es mayor que 4 y menor de 48                         
menorCuatro:
    add a,#0x05
    jr fin
mayor47:
    jr calXenemy
fin:
    ld enemiX(ix), a                                        ;; Guarda la nueva coordenada X para el enemigo
    ret

draw_enemy::
    ld  iy, #num_enemigos
    ld  e, 0(iy)
sigui_enemy_draw:                         
    push de                                            ;; draw_enemi_sprite corrompe DE
    call draw_enemy_sprite                             ;; Dibujar una entidad enemigo
    pop de                                             ;; Recuperar DE con el total de entidades enemigas restantes
    dec e                                              ;; Resta uno al total de entidades enemigas
    ret z                                              ;; Si no quedan enemigos vuelve
    ld bc, #tamagno_enemy                              ;; El tamaño de los datos de un enemigo
    add ix,bc                                          ;; Se suma a Ix oara deslazar el puntero
    jr sigui_enemy_draw                                ;; Siguiente enemigo a dibujar
    ret

draw_enemy_sprite:                                 
    ld de, #0xC000                                     ;; Inicio de la memoria de video                                
    ld  b, enemiY(ix)                                  ;; Coordenada Y del enemigo en B
    ld  c, enemiX(ix)                                  ;; Coordenada X del enemigo en C
    call cpct_getScreenPtr_asm

    ex de, hl
    ld  a, #0x00                                       ;; *********** El Sprite de la nave *****************
    cp StatusAni(ix)                                   ;; *********** El estatus de la animación ************
    jr nz, frameExplo1                                 ;; *********** Si no es el sprite de la nave, ve a explosion 1 *****************
    ld  l, SpriteBajo(ix)
    ld  h, SpriteAlto(ix)                              ;; En HL direccion del Sprite del enemigo
    jr dibuja                                          ;; ************ Dibuja el sprite de la nave *****************************
frameExplo1:
    inc  a                                             ;; Ver si el el fotograma 1 de a animación
    cp StatusAni(ix)                                   ;; *********** El estatus de la animación ************
    jr nz, frameExplo2                                 ;; ******** Si no es explosión 1 ver si es explosión 2 *********************
    ld  l, frame1Bajo(ix)                              ;; *********** Byte bajo de la dirección del sprite **********************
    ld  h, frame1Alto(ix)                              ;; *********** Byte alto de la dirección del sprite **********************
    jr dibuja
frameExplo2:
    inc  a                                             ;; *********** Ver si es el fotograma 2 de la animación *********
    cp StatusAni(ix)                                   ;; *********** El estatus de la animación ************
    jr nz, frameExplo3                                 ;; ******** Si no es explosión 2 ver si es explosión 3 *********************
    ld  l, frame2Bajo(ix)                              ;; *********** Byte bajo de la dirección del sprite **********************
    ld  h, frame2Alto(ix)                              ;; *********** Byte alto de la dirección del sprite **********************
    jr dibuja
frameExplo3:
    inc  a                                             ;; ************* Ver si es el fotograma 3 de la animación *******************
    cp StatusAni(ix)                                   ;; ************* El estatus de la animación    *******************************
    jr nz, frameExplo4                                 ;; ********** Si no es la explosión 3 ver si es la 5 ********************
    ld  l, frame3Bajo(ix)                              ;; *********** Byte bajo de la dirección del sprite **********************
    ld  h, frame3Alto(ix)                              ;; *********** Byte alto de la dirección del sprite **********************
    jr dibuja
frameExplo4:
    inc  a                                             ;; ************* Ver si es el fotograma 4 de la animación *******************
    cp StatusAni(ix)                                   ;; ************* El estatus de la animación    *******************************
    jr nz, frameExplo5                                 ;; ********** Si no es la explosión 4 ver si es la 5 ********************
    ld  l, frame4Bajo(ix)                              ;; *********** Byte bajo de la dirección del sprite **********************
    ld  h, frame4Alto(ix)                              ;; *********** Byte alto de la dirección del sprite **********************
    jr dibuja
frameExplo5:
    ld  l, frame5Bajo(ix)                              ;; *********** Byte bajo de la dirección del sprite **********************
    ld  h, frame5Alto(ix)                              ;; *********** Byte alto de la dirección del sprite **********************
dibuja:
    ld  b, enemiAlto(ix)                               ;; Alto enemigo en B (en bytes)
    ld  c, enemiAncho(ix)                              ;; Ancho enemigo en C (en bytes)
    call cpct_drawSprite_asm


    ret                                                ;; Aquí acaba draeçw_enemy_sprite

erase_enemy::
    ld iy, #num_enemigos
    ld  e, 0(iy)                           
sigui_enemy:
    push de
    call erase_enemy_sprite                           ;; Borrar una entidad enemigo enemigo
    pop  de   
    dec e                                             ;; Resta uno al total de entidades enemigas
    ret z                                             ;; Si no quedan enemigos vuelve
    ld bc, #tamagno_enemy                             ;; El tamaño de los datos de un enemigo
    add ix,bc                                         ;; Se suma a Ix oara deslazar el puntero
    jr sigui_enemy                                    ;; Siguiente enemigo a borrar
    ret

erase_enemy_sprite:
    ld de, #0xC000                                    ;; Inicio de la memoria de video
    ld  b, enemiY(ix)                                 ;; Coordenada Y del enemigo
    ld  c, enemiX(ix)                                 ;; Coordenada X del enemigo
    call cpct_getScreenPtr_asm

    ex de,hl                                          ;; Necesario por que la dirección de video debe estar en DE
    ld  a, #0x00                                      ;; Pintar con color cero
    ld  b, enemiAlto(ix)                              ;; Alto del Sprite del enemigo en B (en bytes)
    ld  c, enemiAncho(ix)                             ;; Ancho del Sprite del enemigo en C (en bytes)
    call cpct_drawSolidBox_asm                        ;; Dibujar una caja con el color del fondo

    ret

update_enemy::
    ld iy, #num_enemigos
    ld  e, 0(iy)                                      ;; En E el números de enemigos          
sigui_update:   
    push de                                           ;; Preservo E 
    call update_spr_enemy                             ;; Actualiza posición X e Y de los enemigos
    call update_tempo_enemy                           ;; Actualiza el tiempo que se ve el fotograma
    pop  de                                           ;; Recupero número de entidades enemigas
    dec e                                             ;; Resta uno al total de entidades enemigas
    ret z                                             ;; Si no quedan enemigos vuelve
    ld bc, #tamagno_enemy                             ;; El tamaño de los datos de un enemigo
    add ix,bc                                         ;; Se suma a IX para deslazar el puntero
    jr sigui_update                                   ;; Siguiente enemigo a actualizar posición
    ret

update_spr_enemy:
    ld  a, enemiY(ix)                                 ;; En el acumulador la coordenada Y del enemigo
    ld  b, enemiVelo(ix)                              ;; El valor de la velocidad del enemigo
    add a, b                                          ;; Se suma resultado en A
    cp  #200
    jr z, otroAlien                                   ;; Si A == 0
    jr nc, otroAlien                                  ;; || A > 200 que se cree otro alien
    ld enemiY(ix), a                                  ;; Se guarda la nueva posición Y del enemigo
    ret
otroAlien:
    ld  a, #0x09                                      ;; Reset de la coordenada Y del enemigo
    ld  enemiY(ix), a                                 ;; Se guarda
    call calXenemy                                    ;; Calcula de forma aleatoria otra coordenada X
    ret

update_tempo_enemy:
    ld  a, StatusAni(ix)                              ;;  Comprobar el estado de la animación
    cp #0x00                                          ;;  Si es cero, no esta explotando 
    ret z                                             ;;  Por lo tanto vuelve 
    ld  a, temporiza(ix)                              ;;  Valor actual del temporizador
    cp  #0x02                                         ;;  Ver si han pasado el número de ciclos
    jr nz, masCiclos                                  ;;  Si no ha llegado sigue sumando ciclos
    ld  temporiza(ix), #0x00                          ;;  El temporizador a cero
    inc StatusAni(ix)                                 ;;  El siguiente fotograma de la animación 
    ld a, StatusAni(ix)                               ;;  El estado de la animación al acumulador
    cp #0x05                                          ;;  Ver si es la 6 animación
    jr nz, vuelve                                     ;;  Si no lo es siguiente animación
    ld de, #0xC000                                    ;;  Inicio de la memoria de video                          
    ld  b, enemiY(ix)                                 ;;  En B la coordenada Y del sprite
    ld  a, #0x09                                      ;;  Reset de la coordenada Y del enemigo
    ld  enemiY(ix), a                                 ;;  Se guarda en la coordenada Y del enemigo
    call calXenemy                                    ;;  Nueva coordenada X aleatoria para el enemigo
    call cpct_getScreenPtr_asm                        ;;  Borra el último sprite de la animación
    ld StatusAni(ix), #0x00                           ;;  Vuelta al fotograma cero
    ld enemiVelo(ix), #0x01                           ;;  Activar la velocidad del enemigo
    
vuelve:
    ret
masCiclos:
    inc temporiza(ix)                                 ;; Aumenta en uno el temporizador
    ret

posXenemyPtr::
    ld ix, #enemyX                                     ;; Devuelve en HL la dirección de enemyX  
    ret

posYenemyPtr::
    ld ix, #enemyY                                    ;; Devuelve en HL la dirección de enemyY
    ret
