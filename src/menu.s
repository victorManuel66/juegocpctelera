.area _CODE

.include "video/video_macros.h.s"
.include "video/colours.h.s"
.include "cpctelera.h.s"
.include "mensajes.h.s"
.include "keyboard/keyboard.h.s"
.include "Player.h.s"

.globl _cpct_keyboardStatusBuffer           ;; Array que contiene el estado del teclado

menu::
    cpctm_clearScreen_asm 0x00              ;; Borra la pantalla
    cpctm_setBorder_asm HW_BLACK            ;; Borde de la pantalla a negro

    ld hl, #0x0006
    call cpct_setDrawCharM0_asm             ;; Establecer color del fondo y de la pluma

    ld de, #0xC000
    ld bc, #0x4C0F                          ;; Coordenada Y en B, coordenada X en C
    call cpct_getScreenPtr_asm

    ld iy, #writeMenu1                      ;; Dirección del texto
    call cpct_drawStringM0_asm              ;; Escribe

    ld de, #0xC000
    ld bc, #0x550F                          ;; Coordenada Y en B, coordenada X en C
    call cpct_getScreenPtr_asm

    ld iy, #writeMenu2                      ;; Dirección del texto
    call cpct_drawStringM0_asm              ;; Escribe

    ld de, #0xC000
    ld bc, #0x5E0F                          ;; Coordenada Y en B, coordenada X en C
    call cpct_getScreenPtr_asm

    ld iy, #writeMenu3                      ;; Dirección del texto
    call cpct_drawStringM0_asm              ;; Escribe

cont:
    call cpct_scanKeyboard_asm              ;; Escanea el teclado

    ld hl, #Key_1
    call cpct_isKeyPressed_asm
    jr  nz, Pulsado1
    ld hl, #Key_2
    call cpct_isKeyPressed_asm
    jr  nz, Pulsado2
    ld hl, #Key_3
    call cpct_isKeyPressed_asm
    jr  nz, Pulsado3
    jr  cont
Pulsado1:
    ld  a, #0x01
    ret
Pulsado2:
    call cpct_scanKeyboard_asm                 ;; Para resetear el teclado
    jr redefine
Pulsado3:
    ;; Asignar izquierda
    ld hl, #Joy0_Left
    ld (TeclaIz), hl
    ld hl, #Joy0_Right
    ld (TeclaDe), hl
    ld hl, #Joy0_Fire1
    ld (TeclaDi), hl
    ret

redefine:
    cpctm_clearScreen_asm 0x00              ;; Borra la pantalla

    ld de, #0xC000
    ld bc, #0x4C0A
    call cpct_getScreenPtr_asm

    ld iy, #izqui                     ;; Dirección del texto
    call cpct_drawStringM0_asm        ;; Escribe
keyleft:
    call delay
    call cpct_scanKeyboard_asm        ;; Escaneo el teclado
    call cpct_isAnyKeyPressed_asm
    jr z, keyleft
    call drawKey                      ;; Localiza la tecla que ha pulsado el usuario
    ld (TeclaIz), hl                  ;; HL contiene el cpct_keyID
    push  de                          ;; Preservar el valor devuelto por drawKey
    ld de, #0xC000
    ld bc, #0x4C26
    call cpct_getScreenPtr_asm        ;; Hace un locate 
    ld  bc, #0x0006
    pop  de                           ;; Recuperar de la pila el caracter devuelto por drawKeyLeft
    call cpct_drawCharM0_asm          ;; Imprime la tecla

    
    ld de, #0xC000
    ld bc, #0x550A
    call cpct_getScreenPtr_asm
    ld iy, #dere                      ;; Dirección del texto
    call cpct_drawStringM0_asm        ;; Escribe
    call delay                        ;; Para que a scanKeyBoard no sea tan rápido

keyright:
    call cpct_scanKeyboard_asm        ;; Escaneo el teclado
    call cpct_isAnyKeyPressed_asm
    jr  z, keyright
    call drawKey                      ;; Localiza la tecla que ha pulsado el usuario
    ld (TeclaDe), hl                  ;; HL contiene el cpct_keyID
    push de                           ;; Preservar el valor devuelto por drawKey
    ld de, #0xC000
    ld bc, #0x5426
    call cpct_getScreenPtr_asm        ;; Hace un locate 
    ld  bc, #0x0006
    pop  de                           ;; Recuperar de la pila el caracter devuelto por drawKeyLeft
    call cpct_drawCharM0_asm          ;; Imprime la tecla
    call delay                        ;; Para que a scanKeyBoard no sea tan rápido

    ld de, #0xC000
    ld bc, #0x5E0A
    call cpct_getScreenPtr_asm
    ld iy, #fue                       ;; Dirección del texto
    call cpct_drawStringM0_asm        ;; Escribe
keyfire:
    ;call delay                        ;; Para que a scanKeyBoard no sea tan rápido
    call cpct_scanKeyboard_asm        ;; Escaneo el teclado
    call cpct_isAnyKeyPressed_asm
    jr  z, keyfire
    call drawKey                      ;; Localiza la tecla que ha pulsado el usuario
    ld (TeclaDi), hl                  ;; HL contiene el cpct_keyID
    push de                           ;; Preservar el valor devuelto por drawKey
    ld de, #0xC000
    ld bc, #0x5C26
    call cpct_getScreenPtr_asm        ;; Hace un locate 
    ld  bc, #0x0006
    pop  de                           ;; Recuperar de la pila el caracter devuelto por drawKeyLeft
    call cpct_drawCharM0_asm          ;; Imprime la tecla

    call delay                        ;; Para que a scanKeyBoard no sea tan rápido

    jp menu

delay:
    ld  b, #0x96
espera:
    halt
    djnz espera
    ret

drawKey:
    ld hl, #_cpct_keyboardStatusBuffer

    ld  b, #0x00                     ;; Contador de los bytes del array
otraLinea:                           ;; Primero hay que encontrar la línea
    ld   a, (hl)                     ;; El byte al acumulador
    inc hl                           ;; Apunta al siguiente elemento de la tabla
    inc  b                           ;; Para que B conozca el indice del array
    cp  #0xFF                        ;; Ver si se pulso la tecla de esa línea
    jr  z, otraLinea
    call whoKey                      ;; Ahora hay que buscar la tecla

    ret

whoKey:
    push af                          ;; Guardar tecla pulsada
    ld  a, b                         ;; Llevamos la fila al acumulador
    cp  #0x0A                        ;; Última fila
    jp  z, _49
    cp  #0x09
    jp  z, _48
    cp  #0x08
    jp  z, _47
    cp  #0x07
    jp  z, _46
    cp  #0x06
    jp  z, _45
    cp  #0x05
    jp  z, _44
    cp  #0x04
    jp  z, _43
    cp  #0x03
    jp  z, _42
    cp  #0x02
    jp  z, _41
    cp  #0x01
    jp  z, _40
_49:
    pop af                          ;; Recupero tecla pulsada
    ld  b, #0x7F                    
    cp  b
    jr  nz, bit6
    ld  e, #254
    ld  hl, #Key_Del
    ret
bit6:
    rrc b
    cp  b
    jr nz, bit5
    ld  e, #255
    ld  hl, #Joy0_Fire3
    ret
bit5:
    rrc b
    cp  b
    jr nz, bit4
    ld  e, #253
    ld  hl, #Joy0_Fire2
    ret
bit4:
    rrc b
    cp  b
    jr nz, bit3
    ld  e, #252
    ld  hl, #Joy0_Fire1
    ret
bit3:
    rrc b
    cp  b
    jr nz, bit2
    ld  e, #243
    ld  hl, #Joy0_Right
    ret
bit2:
    rrc b
    cp  b
    jr nz, bit1
    ld  e, #242
    ld  hl, #Joy0_Left
    ret
bit1:
    rrc b
    cp  b
    jr nz, bit0
    ld  e, #241
    ld  hl, #Joy0_Down
    ret
bit0:
    rrc b
    cp  b
    ret nz
    ld  e, #240
    ld  hl, #Joy0_Up
    ret

_48:
    pop af                          ;; Recupero tecla pulsada
    ld  b, #0x7F                    
    cp  b
    jr  nz, _48bit6
    ld  e, #90
    ld  hl, #Key_Z
    ret
_48bit6:
    rrc b
    cp  b
    jr nz, _48bit5
    ld  e, #233
    ld  hl, #Key_CapsLock
    ret
_48bit5:
    rrc b
    cp  b
    jr nz, _48bit4
    ld  e, #65
    ld  hl, #Key_A
    ret
_48bit4:
    rrc b
    cp  b
    jr nz, _48bit3
    ld  e, #62
    ld  hl, #Key_Tab
    ret
_48bit3:
    rrc b
    cp  b
    jr nz, _48bit2
    ld  e, #81
    ld  hl, #Key_Q
    ret
_48bit2:
    rrc b
    cp  b
    jr nz, _48bit1
    ld  e, #127
    ld  hl, #Key_Esc
    ret
_48bit1:
    rrc b
    cp  b
    jr nz, _48bit0
    ld  e, #50
    ld  hl, #Key_2
    ret
_48bit0:
    rrc b
    cp  b
    ret nz
    ld  e, #49
    ld  hl, #Key_1
    ret
_47:
    pop af                          ;; Recupero tecla pulsada
    ld  b, #0x7F                    
    cp  b
    jr  nz, _47bit6
    ld  e, #88
    ld  hl, #Key_X
    ret
_47bit6:
    rrc b
    cp  b
    jr nz, _47bit5
    ld  e, #67
    ld  hl, #Key_C
    ret
_47bit5:
    rrc b
    cp  b
    jr nz, _47bit4
    ld  e, #68
    ld  hl, #Key_D
    ret
_47bit4:
    rrc b
    cp  b
    jr nz, _47bit3
    ld  e, #83
    ld  hl, #Key_S
    ret
_47bit3:
    rrc b
    cp  b
    jr nz, _47bit2
    ld  e, #87
    ld  hl, #Key_W
    ret
_47bit2:
    rrc b
    cp  b
    jr nz, _47bit1
    ld  e, #69
    ld  hl, #Key_E
    ret
_47bit1:
    rrc b
    cp  b
    jr nz, _47bit0
    ld  e, #51
    ld  hl, #Key_3
    ret
_47bit0:
    rrc b
    cp  b
    ret nz
    ld  e, #52
    ld  hl, #Key_4
    ret
_46:
    pop af                          ;; Recupero tecla pulsada
    ld  b, #0x7F                    
    cp  b
    jr  nz, _46bit6
    ld  e, #86
    ld  hl, #Key_V
    ret
_46bit6:
    rrc b
    cp  b
    jr nz, _46bit5
    ld  e, #66
    ld  hl, #Key_B
    ret
_46bit5:
    rrc b
    cp  b
    jr nz, _46bit4
    ld  e, #70
    ld  hl, #Key_F
    ret
_46bit4:
    rrc b
    cp  b
    jr nz, _46bit3
    ld  e, #71
    ld  hl, #Key_G
    ret
_46bit3:
    rrc b
    cp  b
    jp nz, _46bit2
    ld  e, #84
    ld  hl, #Key_T
    ret
_46bit2:
    rrc b
    cp  b
    jr nz, _46bit1
    ld  e, #82
    ld  hl, #Key_R
    ret
_46bit1:
    rrc b
    cp  b
    jr nz, _46bit0
    ld  e, #53
    ld  hl, #Key_5
    ret
_46bit0:
    rrc b
    cp  b
    ret nz
    ld  e, #54
    ld  hl, #Key_6
    ret
_45:
    pop af                          ;; Recupero tecla pulsada
    ld  b, #0x7F                    
    cp  b
    jr  nz, _45bit6
    ld  e, #127
    ld  hl, #Key_Space
    ret
_45bit6:
    rrc b
    cp  b
    jr nz, _45bit5
    ld  e, #78
    ld  hl, #Key_N
    ret
_45bit5:
    rrc b
    cp  b
    jr nz, _45bit4
    ld  e, #74
    ld  hl, #Key_J
    ret
_45bit4:
    rrc b
    cp  b
    jr nz, _45bit3
    ld  e, #72
    ld  hl, #Key_H
    ret
_45bit3:
    rrc b
    cp  b
    jr nz, _45bit2
    ld  e, #89
    ld  hl, #Key_Y
    ret
_45bit2:
    rrc b
    cp  b
    jr nz, _45bit1
    ld  e, #85
    ld  hl, #Key_U
    ret
_45bit1:
    rrc b
    cp  b
    jr nz, _45bit0
    ld  e, #55
    ld  hl, #Key_7
    ret
_45bit0:
    rrc b
    cp  b
    ret nz
    ld  e, #56
    ld  hl, #Key_8
    ret
_44:
    pop af                          ;; Recupero tecla pulsada
    ld  b, #0x7F                    
    cp  b
    jr  nz, _44bit6
    ld  e, #44
    ld  hl, #Key_Comma
    ret
_44bit6:
    rrc b
    cp  b
    jr nz, _44bit5
    ld  e, #77
    ld  hl, #Key_M
    ret
_44bit5:
    rrc b
    cp  b
    jr nz, _44bit4
    ld  e, #75
    ld  hl, #Key_K
    ret
_44bit4:
    rrc b
    cp  b
    jr nz, _44bit3
    ld  e, #76
    ld  hl, #Key_L
    ret
_44bit3:
    rrc b
    cp  b
    jr nz, _44bit2
    ld  e, #73
    ld  hl, #Key_I
    ret
_44bit2:
    rrc b
    cp  b
    jr nz, _44bit1
    ld  e, #79
    ld  hl, #Key_O
    ret
_44bit1:
    rrc b
    cp  b
    jr nz, _44bit0
    ld  e, #57
    ld  hl, #Key_9
    ret
_44bit0:
    rrc b
    cp  b
    ret nz
    ld  e, #48
    ld  hl, #Key_0
    ret
_43:
    pop af                          ;; Recupero tecla pulsada
    ld  b, #0x7F                    
    cp  b
    jr  nz, _43bit6
    ld  e, #46
    ld  hl, #Key_Dot
    ret
_43bit6:
    rrc b
    cp  b
    jr nz, _43bit5
    ld  e, #47
    ld  hl, #Key_Slash
    ret
_43bit5:
    rrc b
    cp  b
    jr nz, _43bit4
    ld  e, #58
    ld  hl, #Key_Colon
    ret
_43bit4:
    rrc b
    cp  b
    jr nz, _43bit3
    ld  e, #59
    ld  hl, #Key_SemiColon
    ret
_43bit3:
    rrc b
    cp  b
    jr nz, _43bit2
    ld  e, #80
    ld  hl, #Key_P
    ret
_43bit2:
    rrc b
    cp  b
    jr nz, _43bit1
    ld  e, #64
    ld  hl, #Key_At
    ret
_43bit1:
    rrc b
    cp  b
    jr nz, _43bit0
    ld  e, #45
    ld  hl, #Key_Hyphen
    ret
_43bit0:
    rrc b
    cp  b
    ret nz
    ld  e, #160
    ld  hl, #Key_Caret
    ret
_42:
    pop af                          ;; Recupero tecla pulsada
    ld  b, #0x7F                    
    cp  b
    jr  nz, _42bit6
    ld  e, #127
    ld  hl, #Key_Control
    ret
_42bit6:
    rrc b
    cp  b
    jr nz, _42bit5
    ld  e, #92
    ld  hl, #Key_BackSlash
    ret
_42bit5:
    rrc b
    cp  b
    jr nz, _42bit4
    ld  e, #134
    ld  hl, #Key_Shift
    ret
_42bit4:
    rrc b
    cp  b
    jr nz, _42bit3
    ld  e, #131
    ld  hl, #Key_F4
    ret
_42bit3:
    rrc b
    cp  b
    jr nz, _42bit2
    ld  e, #93
    ld  hl, #Key_CloseBracket
    ret
_42bit2:
    rrc b
    cp  b
    jr nz, _42bit1
    ld  e, #96
    ld  hl, #Key_Return
    ret
_42bit1:
    rrc b
    cp  b
    jr nz, _42bit0
    ld  e, #91
    ld  hl, #Key_OpenBracket
    ret
_42bit0:
    rrc b
    cp  b
    ret nz
    ld  e, #253
    ld  hl, #Key_Clr
    ret
_41:
    pop af                          ;; Recupero tecla pulsada
    ld  b, #0x7F                    
    cp  b
    jr  nz, _41bit6
    ld  e, #130
    ld  hl, #Key_F0
    ret
_41bit6:
    rrc b
    cp  b
    jr nz, _41bit5
    ld  e, #132
    ld  hl, #Key_F2
    ret
_41bit5:
    rrc b
    cp  b
    jr nz, _41bit4
    ld  e, #131
    ld  hl, #Key_F1
    ret
_41bit4:
    rrc b
    cp  b
    jr nz, _41bit3
    ld  e, #135
    ld  hl, #Key_F5
    ret
_41bit3:
    rrc b
    cp  b
    jr nz, _41bit2
    ld  e, #138
    ld  hl, #Key_F8
    ret
_41bit2:
    rrc b
    cp  b
    jr nz, _41bit1
    ld  e, #137
    ld  hl, #Key_F7
    ret
_41bit1:
    rrc b
    cp  b
    jr nz, _41bit0
    ld  e, #147
    ld  hl, #Key_Copy
    ret
_41bit0:
    rrc b
    cp  b
    ret nz
    ld  e, #242
    ld  hl, #Key_CursorLeft
    ret
_40:
    pop af                          ;; Recupero tecla pulsada
    ld  b, #0x7F                    
    cp  b
    jr  nz, _40bit6
    ld  e, #144
    ld  hl, #Key_FDot
    ret
_40bit6:
    rrc b
    cp  b
    jr nz, _40bit5
    ld  e, #233
    ld  hl, #Key_Enter
    ret
_40bit5:
    rrc b
    cp  b
    jr nz, _40bit4
    ld  e, #133
    ld  hl, #Key_F3
    ret
_40bit4:
    rrc b
    cp  b
    jr nz, _40bit3
    ld  e, #136
    ld  hl, #Key_F6
    ret
_40bit3:
    rrc b
    cp  b
    jr nz, _40bit2
    ld  e, #139
    ld  hl, #Key_F9
    ret
_40bit2:
    rrc b
    cp  b
    jr nz, _40bit1
    ld  e, #241
    ld  hl, #Key_CursorDown
    ret
_40bit1:
    rrc b
    cp  b
    jr nz, _40bit0
    ld  e, #243
    ld  hl, #Key_CursorRight
    ret
_40bit0:
    rrc b
    cp  b
    ret nz
    ld  e, #240
    ld  hl, #Key_CursorUp
    ret