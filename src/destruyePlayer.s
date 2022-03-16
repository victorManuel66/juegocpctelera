.area _CODE

.include "cpctelera.h.s"
.include "Player.h.s"


.globl _playerexplo1
.globl _playerexplo2
.globl _playerexplo3
.globl _playerexplo4
.globl _playerexplo5

segundBorrado: .db 0x3E                            ;; Segunda coordenada de la nave a borrar en el marcador
primerBorrado: .db 0x45                            ;; Tercera coordenada de la nave a borrar en el marcador
aBorrar:       .db 0x01                            ;; La primera nave a borrar


destruyePlayer::
    ;; A = No Channel (0,1,2)
    ;; L = Instrument Number (>0)
    ;; H = Volume (0...F)
    ;; E = Note (0...143)
    ;; D = Speed (0 = As original, 1...255 = new Speed (1 is the fastest))
    ;; BC = Inverted Pitch (-#FFFF -> FFFF). 0 is no pitch. The higher the pitch, the lower the sound.
    ld  a, #0x02
    ld hl, #0x0F03
    ld de, #0x0014
    ld bc, #0x0000
    call cpct_akp_SFXPlay_asm


    ld de, #0xC000                                  ;; Inicio de la memoria de video                          
    call posXplayerPtr
    ld  c,(hl)                                      ;; Coordenada X en C
    ld  a, #0xC1
    ld  b, a                                        ;; Coordenada Y en B
    call cpct_getScreenPtr_asm

    ex de, hl
    ld hl, #_playerexplo2                                 ;; Siguiente sprite
    push de                                               ;; Se preserva DE por que lo corrompe cpct_drawSprite_asm
    call anima
    call espera
    pop de                                                ;; Se recupera DE que continien la coordenada de pantalla a dibujar
    ld hl, #_playerexplo3                                 ;; Siguiente sprite
    push de                                               ;; Se preserva DE por que lo corrompe cpct_drawSprite_asm 
    call anima
    call espera
    pop de                                                ;; Se recupera DE que continien la coordenada de pantalla a dibujar
    push de                                               ;; Se preserva DE por que lo corrompe cpct_drawSprite_asm
    ld hl, #_playerexplo4
    call anima
    call espera
    pop de                                                ;; Se recupera DE que continien la coordenada de pantalla a dibujar
    ld hl, #_playerexplo5
    call anima
    call espera
    
    ld ix, #Player
    ld  a, 6(ix)                                         ;; Cargo el número de vidas del player
    dec a                                                ;; resto una
    ld 6(ix), a                                          ;; Se vuelve a guardar

    ld  a,(aBorrar)                                      ;; La primera nave a borrar
    cp  #0x01                                            ;; Ver si es el primera muerte
    jr nz, borraDos
    ld  a, (primerBorrado)
    ld  c, a                                             ;; La coordenada X nave a borrar en C
    call borraNave
    ld  a, #0x02
    ld  (aBorrar), a
    ret
borraDos:
    cp #0x02
    ld  a,(segundBorrado)
    ld  c, a
    call borraNave
   
    ret

anima:
    ld bc, #0x0605                                        ;; Medidas en bytes del player
    call cpct_drawSprite_asm
    ret

espera:
    ld a, #0x14
otro:
    halt
    dec a
    jr nz,otro
    ret

borraNave:
    ld de, #0xC000
    ld  b, #0xA6
    call cpct_getScreenPtr_asm
    ex de,hl
    ld  a, #0x00
    ld bc, #0x0605
    call cpct_drawSolidBox_asm
    ret