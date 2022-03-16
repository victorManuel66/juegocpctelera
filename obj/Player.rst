ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module Player
                              2 .area _CODE
                              3 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "cpctelera.h.s"
                              1 .globl cpct_disableFirmware_asm
                              2 .globl cpct_setVideoMode_asm
                              3 .globl cpct_setPalette_asm
                              4 .globl cpct_drawSprite_asm
                              5 .globl cpct_getScreenPtr_asm
                              6 .globl cpct_scanKeyboard_asm
                              7 .globl cpct_isKeyPressed_asm
                              8 .globl cpct_waitVSYNC_asm
                              9 .globl cpct_drawSolidBox_asm
                             10 .globl cpct_etm_setTileset2x4_asm
                             11 .globl cpct_etm_drawTileBox2x4_asm
                             12 .globl cpct_getRandom_xsp40_u8_asm
                             13 .globl cpct_akp_SFXInit_asm
                             14 .globl cpct_akp_musicInit_asm
                             15 .globl cpct_akp_musicPlay_asm
                             16 .globl cpct_akp_SFXPlay_asm
                             17 .globl cpct_akp_SFXStop_asm
                             18 .globl cpct_akp_stop_asm
                             19 .globl cpct_drawStringM0_asm
                             20 .globl cpct_setDrawCharM0_asm
                             21 .globl cpct_isAnyKeyPressed_asm
                             22 .globl cpct_drawCharM0_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              5 .include "keyboard/keyboard.h.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
                              3 ;;  Copyright (C) 2017 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 .module cpct_keyboard
                             19 
                             20 ;;
                             21 ;; Constant: Key Definitions (asm)
                             22 ;;
                             23 ;;    Definitions of the KeyCodes required by <cpct_isKeyPressed> 
                             24 ;; function for assembler programs. These are 16-bit values that define 
                             25 ;; matrix line in the keyboard layout (Most Significant Byte) and bit to
                             26 ;; be tested in that matrix line status for the given key (Least Significant
                             27 ;; byte). Each matrix line in the keyboard returns a byte containing the
                             28 ;; status of 8 keys, 1 bit each.
                             29 ;;
                             30 ;; CPCtelera include file:
                             31 ;;    _keyboard/keyboard.h.s_
                             32 ;;
                             33 ;; Keycode constant names:
                             34 ;; (start code)
                             35 ;;  KeyCode | Constant        || KeyCode | Constant      || KeyCode |  Constant
                             36 ;; -------------------------------------------------------------------------------
                             37 ;;   0x0100 | Key_CursorUp    ||  0x0803 | Key_P         ||  0x4006 |  Key_B
                             38 ;;          |                 ||         |               ||     ''  |  Joy1_Fire3
                             39 ;;   0x0200 | Key_CursorRight ||  0x1003 | Key_SemiColon ||  0x8006 |  Key_V
                             40 ;;   0x0400 | Key_CursorDown  ||  0x2003 | Key_Colon     ||  0x0107 |  Key_4
                             41 ;;   0x0800 | Key_F9          ||  0x4003 | Key_Slash     ||  0x0207 |  Key_3
                             42 ;;   0x1000 | Key_F6          ||  0x8003 | Key_Dot       ||  0x0407 |  Key_E
                             43 ;;   0x2000 | Key_F3          ||  0x0104 | Key_0         ||  0x0807 |  Key_W
                             44 ;;   0x4000 | Key_Enter       ||  0x0204 | Key_9         ||  0x1007 |  Key_S
                             45 ;;   0x8000 | Key_FDot        ||  0x0404 | Key_O         ||  0x2007 |  Key_D
                             46 ;;   0x0101 | Key_CursorLeft  ||  0x0804 | Key_I         ||  0x4007 |  Key_C
                             47 ;;   0x0201 | Key_Copy        ||  0x1004 | Key_L         ||  0x8007 |  Key_X
                             48 ;;   0x0401 | Key_F7          ||  0x2004 | Key_K         ||  0x0108 |  Key_1
                             49 ;;   0x0801 | Key_F8          ||  0x4004 | Key_M         ||  0x0208 |  Key_2
                             50 ;;   0x1001 | Key_F5          ||  0x8004 | Key_Comma     ||  0x0408 |  Key_Esc
                             51 ;;   0x2001 | Key_F1          ||  0x0105 | Key_8         ||  0x0808 |  Key_Q
                             52 ;;   0x4001 | Key_F2          ||  0x0205 | Key_7         ||  0x1008 |  Key_Tab
                             53 ;;   0x8001 | Key_F0          ||  0x0405 | Key_U         ||  0x2008 |  Key_A
                             54 ;;   0x0102 | Key_Clr         ||  0x0805 | Key_Y         ||  0x4008 |  Key_CapsLock
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             55 ;;   0x0202 | Key_OpenBracket ||  0x1005 | Key_H         ||  0x8008 |  Key_Z
                             56 ;;   0x0402 | Key_Return      ||  0x2005 | Key_J         ||  0x0109 |  Joy0_Up
                             57 ;;   0x0802 | Key_CloseBracket||  0x4005 | Key_N         ||  0x0209 |  Joy0_Down
                             58 ;;   0x1002 | Key_F4          ||  0x8005 | Key_Space     ||  0x0409 |  Joy0_Left
                             59 ;;   0x2002 | Key_Shift       ||  0x0106 | Key_6         ||  0x0809 |  Joy0_Right
                             60 ;;          |                 ||     ''  | Joy1_Up       ||         |
                             61 ;;   0x4002 | Key_BackSlash   ||  0x0206 | Key_5         ||  0x1009 |  Joy0_Fire1
                             62 ;;          |                 ||     ''  | Joy1_Down     ||         |
                             63 ;;   0x8002 | Key_Control     ||  0x0406 | Key_R         ||  0x2009 |  Joy0_Fire2
                             64 ;;          |                 ||     ''  | Joy1_Left     ||         |
                             65 ;;   0x0103 | Key_Caret       ||  0x0806 | Key_T         ||  0x4009 |  Joy0_Fire3
                             66 ;;          |                 ||     ''  | Joy1 Right    ||
                             67 ;;   0x0203 | Key_Hyphen      ||  0x1006 | Key_G         ||  0x8009 |  Key_Del
                             68 ;;          |                 ||     ''  | Joy1_Fire1    ||
                             69 ;;   0x0403 | Key_At          ||  0x2006 | Key_F         ||
                             70 ;;          |                 ||     ''  | Joy1_Fire2    ||
                             71 ;; -------------------------------------------------------------------------------
                             72 ;;  Table 1. KeyCodes defined for each possible key, ordered by KeyCode
                             73 ;; (end)
                             74 ;;
                             75 
                             76 ;; Matrix Line 0x00
                     0100    77 Key_CursorUp     = #0x0100  ;; Bit 0 (01h) => | 0000 0001 |
                     0200    78 Key_CursorRight  = #0x0200  ;; Bit 1 (02h) => | 0000 0010 |
                     0400    79 Key_CursorDown   = #0x0400  ;; Bit 2 (04h) => | 0000 0100 |
                     0800    80 Key_F9           = #0x0800  ;; Bit 3 (08h) => | 0000 1000 |
                     1000    81 Key_F6           = #0x1000  ;; Bit 4 (10h) => | 0001 0000 |
                     2000    82 Key_F3           = #0x2000  ;; Bit 5 (20h) => | 0010 0000 |
                     4000    83 Key_Enter        = #0x4000  ;; Bit 6 (40h) => | 0100 0000 |
                     8000    84 Key_FDot         = #0x8000  ;; Bit 7 (80h) => | 1000 0000 |
                             85 ;; Matrix Line 0x01
                     0101    86 Key_CursorLeft   = #0x0101
                     0201    87 Key_Copy         = #0x0201
                     0401    88 Key_F7           = #0x0401
                     0801    89 Key_F8           = #0x0801
                     1001    90 Key_F5           = #0x1001
                     2001    91 Key_F1           = #0x2001
                     4001    92 Key_F2           = #0x4001
                     8001    93 Key_F0           = #0x8001
                             94 ;; Matrix Line 0x02
                     0102    95 Key_Clr          = #0x0102
                     0202    96 Key_OpenBracket  = #0x0202
                     0402    97 Key_Return       = #0x0402
                     0802    98 Key_CloseBracket = #0x0802
                     1002    99 Key_F4           = #0x1002
                     2002   100 Key_Shift        = #0x2002
                     4002   101 Key_BackSlash    = #0x4002
                     8002   102 Key_Control      = #0x8002
                            103 ;; Matrix Line 0x03
                     0103   104 Key_Caret        = #0x0103
                     0203   105 Key_Hyphen       = #0x0203
                     0403   106 Key_At           = #0x0403
                     0803   107 Key_P            = #0x0803
                     1003   108 Key_SemiColon    = #0x1003
                     2003   109 Key_Colon        = #0x2003
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                     4003   110 Key_Slash        = #0x4003
                     8003   111 Key_Dot          = #0x8003
                            112 ;; Matrix Line 0x04
                     0104   113 Key_0            = #0x0104
                     0204   114 Key_9            = #0x0204
                     0404   115 Key_O            = #0x0404
                     0804   116 Key_I            = #0x0804
                     1004   117 Key_L            = #0x1004
                     2004   118 Key_K            = #0x2004
                     4004   119 Key_M            = #0x4004
                     8004   120 Key_Comma        = #0x8004
                            121 ;; Matrix Line 0x05
                     0105   122 Key_8            = #0x0105
                     0205   123 Key_7            = #0x0205
                     0405   124 Key_U            = #0x0405
                     0805   125 Key_Y            = #0x0805
                     1005   126 Key_H            = #0x1005
                     2005   127 Key_J            = #0x2005
                     4005   128 Key_N            = #0x4005
                     8005   129 Key_Space        = #0x8005
                            130 ;; Matrix Line 0x06
                     0106   131 Key_6            = #0x0106
                     0106   132 Joy1_Up          = #0x0106
                     0206   133 Key_5            = #0x0206
                     0206   134 Joy1_Down        = #0x0206
                     0406   135 Key_R            = #0x0406
                     0406   136 Joy1_Left        = #0x0406
                     0806   137 Key_T            = #0x0806
                     0806   138 Joy1_Right       = #0x0806
                     1006   139 Key_G            = #0x1006
                     1006   140 Joy1_Fire1       = #0x1006
                     2006   141 Key_F            = #0x2006
                     2006   142 Joy1_Fire2       = #0x2006
                     4006   143 Key_B            = #0x4006
                     4006   144 Joy1_Fire3       = #0x4006
                     8006   145 Key_V            = #0x8006
                            146 ;; Matrix Line 0x07
                     0107   147 Key_4            = #0x0107
                     0207   148 Key_3            = #0x0207
                     0407   149 Key_E            = #0x0407
                     0807   150 Key_W            = #0x0807
                     1007   151 Key_S            = #0x1007
                     2007   152 Key_D            = #0x2007
                     4007   153 Key_C            = #0x4007
                     8007   154 Key_X            = #0x8007
                            155 ;; Matrix Line 0x08
                     0108   156 Key_1            = #0x0108
                     0208   157 Key_2            = #0x0208
                     0408   158 Key_Esc          = #0x0408
                     0808   159 Key_Q            = #0x0808
                     1008   160 Key_Tab          = #0x1008
                     2008   161 Key_A            = #0x2008
                     4008   162 Key_CapsLock     = #0x4008
                     8008   163 Key_Z            = #0x8008
                            164 ;; Matrix Line 0x09
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                     0109   165 Joy0_Up          = #0x0109
                     0209   166 Joy0_Down        = #0x0209
                     0409   167 Joy0_Left        = #0x0409
                     0809   168 Joy0_Right       = #0x0809
                     1009   169 Joy0_Fire1       = #0x1009
                     2009   170 Joy0_Fire2       = #0x2009
                     4009   171 Joy0_Fire3       = #0x4009
                     8009   172 Key_Del          = #0x8009
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                              6 .include "laser.h.s"
                              1 .globl draw_laser
                              2 .globl erase_laser
                              3 .globl update_laser
                              4 .globl posXlaserPtr
                              5 .globl posYlaserPtr
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                              7 .include "datos.h.s"
                     0013     1 tamagno_enemy = 0x13                               ;; Tamaño del array de entidades
   4988 03                    2 num_enemigos: .db 0x03                             ;; Número de enemigos
                              3 
                              4 ;; Constantes del array del enemigo
                     0000     5 .equ enemiX,      0
                     0001     6 .equ enemiY,      1
                     0002     7 .equ enemiAlto,   2
                     0003     8 .equ enemiAncho,  3
                     0004     9 .equ SpriteBajo,  4
                     0005    10 .equ SpriteAlto,  5
                     0006    11 .equ enemiVelo,   6
                     0007    12 .equ temporiza,   7
                     0008    13 .equ StatusAni,   8
                     0009    14 .equ frame1Bajo,  9
                     000A    15 .equ frame1Alto, 10
                     000B    16 .equ frame2Bajo, 11
                     000C    17 .equ frame2Alto, 12
                     000D    18 .equ frame3Bajo, 13
                     000E    19 .equ frame3Alto, 14
                     000F    20 .equ frame4Bajo, 15
                     0010    21 .equ frame4Alto, 16
                     0011    22 .equ frame5Bajo, 17
                     0012    23 .equ frame5Alto, 18
                             24 
                             25 ;; Constantes del Player
                     0000    26 .equ PlayX,      0
                     0001    27 .equ PlayY,      1
                     0002    28 .equ PlayAlto,   2
                     0003    29 .equ PlayAncho,  3
                     0004    30 .equ SprPlayLo,  4
                     0005    31 .equ SprPlayHi,  5
                     0006    32 .equ PlayVidas,  6
                     0007    33 .equ FPS,        7
                             34 
                             35 
                             36 
                             37 
                             38 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                              8 
                              9 
                             10 
                     0006    11 anchoSprite = 6
                             12 
                             13 .globl _spr
                             14 
   4989                      15 Player::
   4989 26                   16     PlayerX:     .db 0x26                               ;; Coodenada X del player
   498A C1                   17     PlayerY:     .db 0xC1                               ;; Coordenada Y del player
   498B 06                   18     PlayerAlto:  .db 0x06                               ;; Alto del Sprite en bytes del player
   498C 05                   19     PlayerAncho: .db 0x05                               ;; Ancho del Sprte en bytes del player
   498D 5A 49                20     ptrSpPlayer: .dw _spr                               ;; Puntero a los datos del Sprite del player
   498F 03                   21     vidas:       .db 0x03                               ;; Vidas del jugador
                             22 
   4990 07 20                23 TeclaDe::        .dw Key_D
   4992 08 20                24 TeclaIz::        .dw Key_A
   4994 05 80                25 TeclaDi::        .dw Key_Space
                             26 
                             27 
   4996 00                   28 disparo:       .db 0x00                     ;; Si hay un cero no se esta disparando, si hay un 1 se esta disparando
                             29 
   4997                      30 update_player::
   4997 CD 4D 60      [17]   31     call cpct_scanKeyboard_asm
   499A 2A 90 49      [16]   32     ld hl,(TeclaDe)
   499D CD BF 54      [17]   33     call cpct_isKeyPressed_asm
   49A0 28 0B         [12]   34     jr z, teclaA
   49A2 DD 7E 00      [19]   35     ld  a, PlayX(ix)
   49A5 FE 2C         [ 7]   36     cp  #50-anchoSprite                                 
   49A7 28 04         [12]   37     jr z, teclaA                            ;; Si es cero es que el sprite esta en el límite derecho
   49A9 3C            [ 4]   38     inc a
   49AA DD 77 00      [19]   39     ld PlayX(ix), a
   49AD                      40 teclaA:
   49AD 2A 92 49      [16]   41     ld hl,(TeclaIz)
   49B0 CD BF 54      [17]   42     call cpct_isKeyPressed_asm
   49B3 28 0B         [12]   43     jr z,teclaSpc
   49B5 DD 7E 00      [19]   44     ld  a, PlayX(ix)
   49B8 3D            [ 4]   45     dec a
   49B9 FE 04         [ 7]   46     cp #4                                  
   49BB 28 03         [12]   47     jr z, teclaSpc                           ;; Si es cero es que el sprite esta en el límite izquierdo
   49BD DD 77 00      [19]   48     ld PlayX(ix), a
                             49     
   49C0                      50 teclaSpc::
   49C0 2A 94 49      [16]   51     ld hl, (TeclaDi)
   49C3 CD BF 54      [17]   52     call cpct_isKeyPressed_asm
   49C6 C8            [11]   53     ret z
   49C7 3A 96 49      [13]   54     ld  a, (disparo)
   49CA B7            [ 4]   55     or  a
   49CB C0            [11]   56     ret nz                                   ;; No puede volver a disparar hasta que este a cero
   49CC 3E 01         [ 7]   57     ld  a, #0x01
   49CE 32 96 49      [13]   58     ld (disparo), a                          ;; Si llego hasta aqui es que comienza un disparo                         
   49D1 DD 7E 00      [19]   59     ld  a, PlayX(ix)                         ;; El lugar donde se encuentra la nave
   49D4 CD D7 4D      [17]   60     call posXlaserPtr                        ;; La posición de memoria donde esta la posición X del laser
   49D7 3C            [ 4]   61     inc a
   49D8 3C            [ 4]   62     inc a                                    ;; Necesario para desplazar dos posiciones a la derecha el disparo
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   49D9 77            [ 7]   63     ld (hl), a                               ;; Ahora la X del player y del laser son la misma
   49DA CD 1D 4A      [17]   64     call sonidoLaser 
   49DD C9            [10]   65     ret
                             66 
   49DE                      67 draw_player::
   49DE CD E2 49      [17]   68     call draw_sprite
   49E1 C9            [10]   69     ret
                             70 
   49E2                      71 draw_sprite:
                             72     ;; Calcula la posición de memoria donde dibujar el sprite
   49E2 11 00 C0      [10]   73     ld de, #0xC000
   49E5 DD 4E 00      [19]   74     ld  c, PlayX(ix)                          ;; En C la coordenada X del player
   49E8 DD 46 01      [19]   75     ld  b, PlayY(ix)                          ;; En B la coordenada Y del player 
   49EB CD 39 60      [17]   76     call cpct_getScreenPtr_asm                ;; Devuelve en HL la posición de memoria
                             77 
                             78     ;; Dibujamos el Sprite en pantalla
   49EE EB            [ 4]   79     ex de, hl                                 ;; Por que la dirección esta en HL pero se necesita en DE
   49EF DD 6E 04      [19]   80     ld  l, SprPlayLo(ix)                      ;; Parte baja de la dirección de memoria donde esta el sprite
   49F2 DD 66 05      [19]   81     ld  h, SprPlayHi(ix)                      ;; Parte alta de la dirección de memoria donde esta el sprite
   49F5 DD 46 02      [19]   82     ld  b, PlayAlto(ix)                       ;; El alto del sprite en B
   49F8 DD 4E 03      [19]   83     ld  c, PlayAncho(ix)                      ;; el ancho del sprite en C
   49FB CD 88 5D      [17]   84     call cpct_drawSprite_asm
   49FE C9            [10]   85     ret
                             86 
   49FF                      87 erase_player::
                             88     ;; Calcula la posición de memoria donde borrar el sprite
   49FF 11 00 C0      [10]   89     ld de, #0xC000
   4A02 DD 4E 00      [19]   90     ld  c, PlayX(ix)                          ;; Coordenada X del sprite en C
   4A05 DD 46 01      [19]   91     ld  b, PlayY(ix)                          ;; Coordenada Y del sprite en B
   4A08 CD 39 60      [17]   92     call cpct_getScreenPtr_asm                ;; Devuelve en HL la posición de memoria
                             93 
   4A0B EB            [ 4]   94     ex de,hl                                  ;; Necesario por que la dirección de video debe estar en DE
   4A0C 3E 00         [ 7]   95     ld  a, #0x00                              ;; Pintar con color cero
   4A0E 01 06 06      [10]   96     ld bc, #0x0606                            ;; 12 x 6 píxeles
   4A11 CD 51 5F      [17]   97     call cpct_drawSolidBox_asm
   4A14 C9            [10]   98     ret
                             99 
   4A15                     100 posXplayerPtr::
   4A15 21 89 49      [10]  101     ld hl, #PlayerX
   4A18 C9            [10]  102     ret
   4A19                     103 disparando::
   4A19 21 96 49      [10]  104     ld hl, #disparo
   4A1C C9            [10]  105     ret
   4A1D                     106 sonidoLaser:
                            107     ;; A = No Channel (0,1,2)
                            108     ;; L = Instrument Number (>0)
                            109     ;; H = Volume (0...F)
                            110     ;; E = Note (0...143)
                            111     ;; D = Speed (0 = As original, 1...255 = new Speed (1 is the fastest))
                            112     ;; BC = Inverted Pitch (-#FFFF -> FFFF). 0 is no pitch. The higher the pitch, the lower the sound.
   4A1D 3E 02         [ 7]  113     ld  a, #0x02
   4A1F 21 02 0F      [10]  114     ld hl, #0x0F02
   4A22 11 47 00      [10]  115     ld de, #0x0047
   4A25 01 00 00      [10]  116     ld bc, #0x0000
   4A28 CD 93 5C      [17]  117     call cpct_akp_SFXPlay_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   4A2B C9            [10]  118     ret
