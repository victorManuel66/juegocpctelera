.area _CODE

.globl _laser
.include "cpctelera.h.s"
.include "Player.h.s"
.include "main.h.s"

velocidad: .db -4                                         ;; Velocidad del disparo (0xFC)

laserX:    .db 0x26                                       ;; Posición X del disparo
laserY:    .db 189                                        ;; Posición Y del disparo (0xBD)

draw_laser::
    ld de, #0xC000
    ld  a, (laserX)
    ld  c, a
    ld  a,(laserY)
    ld  b, a
    call cpct_getScreenPtr_asm

    ex de,hl
    ld hl, #_laser
    ld bc, #0x0401
    call cpct_drawSprite_asm

    ret

erase_laser::
    ld de, #0xC000
    ld  a, (laserX)
    ld  c, a
    ld  a,(laserY)
    ld  b, a
    call cpct_getScreenPtr_asm

    ex de, hl
    ld a, #0x00
    ld bc, #0x0401
    call cpct_drawSolidBox_asm

    ret

update_laser::
    ld hl, #velocidad
    ld  a, (laserY)
    add a,(hl)
    cp #9                                         ;; Ver si ha llegado al final de la pantalla
    jr z, destruirLaser
    ld (laserY), a
    call erase_laser                              ;; Borrar para que no quede ratro
    ret
destruirLaser:
    ld a, #0xBD
    ld (laserY), a                                ;; Coordenada Y del laser reseteada a #0xBD
    call disparando
    xor  a
    ld (hl), a                                    ;; La posición de memoria disparando reseteada a cero
    jp nodisparar                                 ;; Borra el último dibujo del sprite, y me da la impresion de que esto no esta muy bien


posXlaserPtr::
    ld hl, #laserX                                 ;; Devuelvo la dirección de laserX en HL
    ret

posYlaserPtr::
    ld hl, #laserY                                 ;; Devuelve la dirección de laserY en HL
    ret