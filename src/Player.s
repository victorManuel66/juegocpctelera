.module Player
.area _CODE

.include "cpctelera.h.s"
.include "keyboard/keyboard.h.s"
.include "laser.h.s"
.include "datos.h.s"



anchoSprite = 6

.globl _spr

Player::
    PlayerX:     .db 0x26                               ;; Coodenada X del player
    PlayerY:     .db 0xC1                               ;; Coordenada Y del player
    PlayerAlto:  .db 0x06                               ;; Alto del Sprite en bytes del player
    PlayerAncho: .db 0x05                               ;; Ancho del Sprte en bytes del player
    ptrSpPlayer: .dw _spr                               ;; Puntero a los datos del Sprite del player
    vidas:       .db 0x03                               ;; Vidas del jugador

TeclaDe::        .dw Key_D
TeclaIz::        .dw Key_A
TeclaDi::        .dw Key_Space


disparo:       .db 0x00                     ;; Si hay un cero no se esta disparando, si hay un 1 se esta disparando

update_player::
    call cpct_scanKeyboard_asm
    ld hl,(TeclaDe)
    call cpct_isKeyPressed_asm
    jr z, teclaA
    ld  a, PlayX(ix)
    cp  #50-anchoSprite                                 
    jr z, teclaA                            ;; Si es cero es que el sprite esta en el límite derecho
    inc a
    ld PlayX(ix), a
teclaA:
    ld hl,(TeclaIz)
    call cpct_isKeyPressed_asm
    jr z,teclaSpc
    ld  a, PlayX(ix)
    dec a
    cp #4                                  
    jr z, teclaSpc                           ;; Si es cero es que el sprite esta en el límite izquierdo
    ld PlayX(ix), a
    
teclaSpc::
    ld hl, (TeclaDi)
    call cpct_isKeyPressed_asm
    ret z
    ld  a, (disparo)
    or  a
    ret nz                                   ;; No puede volver a disparar hasta que este a cero
    ld  a, #0x01
    ld (disparo), a                          ;; Si llego hasta aqui es que comienza un disparo                         
    ld  a, PlayX(ix)                         ;; El lugar donde se encuentra la nave
    call posXlaserPtr                        ;; La posición de memoria donde esta la posición X del laser
    inc a
    inc a                                    ;; Necesario para desplazar dos posiciones a la derecha el disparo
    ld (hl), a                               ;; Ahora la X del player y del laser son la misma
    call sonidoLaser 
    ret

draw_player::
    call draw_sprite
    ret

draw_sprite:
    ;; Calcula la posición de memoria donde dibujar el sprite
    ld de, #0xC000
    ld  c, PlayX(ix)                          ;; En C la coordenada X del player
    ld  b, PlayY(ix)                          ;; En B la coordenada Y del player 
    call cpct_getScreenPtr_asm                ;; Devuelve en HL la posición de memoria

    ;; Dibujamos el Sprite en pantalla
    ex de, hl                                 ;; Por que la dirección esta en HL pero se necesita en DE
    ld  l, SprPlayLo(ix)                      ;; Parte baja de la dirección de memoria donde esta el sprite
    ld  h, SprPlayHi(ix)                      ;; Parte alta de la dirección de memoria donde esta el sprite
    ld  b, PlayAlto(ix)                       ;; El alto del sprite en B
    ld  c, PlayAncho(ix)                      ;; el ancho del sprite en C
    call cpct_drawSprite_asm
    ret

erase_player::
    ;; Calcula la posición de memoria donde borrar el sprite
    ld de, #0xC000
    ld  c, PlayX(ix)                          ;; Coordenada X del sprite en C
    ld  b, PlayY(ix)                          ;; Coordenada Y del sprite en B
    call cpct_getScreenPtr_asm                ;; Devuelve en HL la posición de memoria

    ex de,hl                                  ;; Necesario por que la dirección de video debe estar en DE
    ld  a, #0x00                              ;; Pintar con color cero
    ld bc, #0x0606                            ;; 12 x 6 píxeles
    call cpct_drawSolidBox_asm
    ret

posXplayerPtr::
    ld hl, #PlayerX
    ret
disparando::
    ld hl, #disparo
    ret
sonidoLaser:
    ;; A = No Channel (0,1,2)
    ;; L = Instrument Number (>0)
    ;; H = Volume (0...F)
    ;; E = Note (0...143)
    ;; D = Speed (0 = As original, 1...255 = new Speed (1 is the fastest))
    ;; BC = Inverted Pitch (-#FFFF -> FFFF). 0 is no pitch. The higher the pitch, the lower the sound.
    ld  a, #0x02
    ld hl, #0x0F02
    ld de, #0x0047
    ld bc, #0x0000
    call cpct_akp_SFXPlay_asm
    ret