.include "enemy.h.s"
.include "datos.h.s"
.include "video/video_macros.h.s"
.include "video/colours.h.s"

.area _CODE

segundos: .dw 0x00


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;; EN IX DIRECCIÓN ENEMIGO ;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
situaEnemigos::
    ld  a, (num_enemigos)
next:
    call pideX
    dec a
    ret z
    ld  bc, #tamagno_enemy
    add ix, bc
    jr next

pideX:
    push af                                                ;; Preservar A por que calXenemy lo modifica
    call calXenemy
    pop  af                                                ;; Se recupera el antiguo valor de A
    ret

reloj::
    ld  hl, (segundos)                                     ;; Número de segundos transcurridos
    ld  a, h
    cp #0x0B
    jr nz, suma
    ld  a, l
    cp #0xB8
    jr nz, suma
    cpctm_setBorder_asm HW_WHITE
    ld (hl), #0x0000
    ret
suma:
    inc hl
    ld (segundos), hl
    ret