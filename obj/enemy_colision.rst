ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _CODE
                              2 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              3 .include "datos.h.s"
                     0013     1 tamagno_enemy = 0x13                               ;; Tamaño del array de entidades
   4A36 03                    2 num_enemigos: .db 0x03                             ;; Número de enemigos
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
                             33 
                             34 
                             35 
                             36 
                             37 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              4 .include "Player.h.s"
                              1 .globl draw_player
                              2 .globl update_player
                              3 .globl erase_player
                              4 .globl disparando
                              5 .globl posXplayerPtr
                              6 .globl posYenemyPtr
                              7 .globl Player
                              8 .globl TeclaIz
                              9 .globl TeclaDe
                             10 .globl TeclaDi
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              5 .include "cpctelera.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              6 .include "destroyEnemy.h.s"
                              1 .globl destruyeEnemigo
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              7 .include "destruyePlayer.h.s"
                              1 .globl destruyePlayer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                              8 .include "enemy.h.s"
                              1 .globl draw_enemy
                              2 .globl calXenemy
                              3 .globl erase_enemy
                              4 .globl update_enemy
                              5 .globl posXenemyPtr
                              6 .globl posYenemyPtr
                              7 .globl enemy
                              8 .globl enemy2
                              9 .globl enemy3
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                              9 
                             10 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             11 ;; ESTA RUTINA SÓLO COMPRUEBA SI EL ENEMIGO CHOCA CONTRA EL PLAYER ;;
                             12 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             13 
   4A37                      14 colision_enemy::
   4A37 FD 21 36 4A   [14]   15     ld iy, #num_enemigos
   4A3B FD 5E 00      [19]   16     ld  e, 0(iy)                         
   4A3E                      17 sigui_enemy:
   4A3E D5            [11]   18     push de                                        ;; Preservo E 
   4A3F CD 4D 4A      [17]   19     call colision                                  ;; Borrar una entidad enemigo enemigo
   4A42 D1            [10]   20     pop  de                                        ;; Recupero número de entidades enemigas
   4A43 1D            [ 4]   21     dec e                                          ;; Resta uno al total de entidades enemigas
   4A44 C8            [11]   22     ret z                                          ;; Si no quedan enemigos vuelve
   4A45 01 13 00      [10]   23     ld bc, #tamagno_enemy                          ;; El tamaño de los datos de un enemigo
   4A48 DD 09         [15]   24     add ix,bc                                      ;; Se suma a Ix oara deslazar el puntero
   4A4A 18 F2         [12]   25     jr sigui_enemy                                 ;; Siguiente enemigo a borrar
   4A4C C9            [10]   26     ret
                             27 
   4A4D                      28 colision:
   4A4D DD 7E 08      [19]   29     ld  a, StatusAni(ix)                           ;; Comprobar el estado de la animación 
   4A50 FE 00         [ 7]   30     cp #0x00                                       ;; Si no es cero es que esta explotando 
   4A52 C0            [11]   31     ret nz                                         ;; Por lo tanto vuelve por que no hay que comprobar colosiones
   4A53 DD 46 00      [19]   32     ld  b, enemiX(ix)                              ;; Posición X del enemigo
   4A56 DD 7E 03      [19]   33     ld  a, enemiAncho(ix)                          ;; Ancho del enemigo
   4A59 80            [ 4]   34     add a, b                                       ;; Se suman
   4A5A 47            [ 4]   35     ld  b, a                                       ;; En resultado se guarda en B
   4A5B CD 15 4A      [17]   36     call posXplayerPtr                             ;; Obtenemos la posición X del player
   4A5E 7E            [ 7]   37     ld  a, (hl)                                    ;; Guardar la coordena X en A
   4A5F B8            [ 4]   38     cp  b                                          ;; Las comparamos
   4A60 28 03         [12]   39     jr  z, verSiMenor                              ;; Si es igual 
   4A62 38 01         [12]   40     jr  c, verSiMenor                              ;; o mayor
   4A64 C9            [10]   41     ret                                            ;; Si no lo son, no puede haber colisión
   4A65                      42 verSiMenor:
   4A65 DD 46 00      [19]   43     ld  b, 0(ix)                                   ;; Posición X del enemigo
   4A68 C6 05         [ 7]   44     add a, #0x05                                   ;; Ancho del player (mejorable)
   4A6A B8            [ 4]   45     cp  b                                          ;; Comparar
   4A6B 28 03         [12]   46     jr  z, verSiColY                               ;; Si es igual
   4A6D 30 01         [12]   47     jr  nc, verSiColY                              ;; o menor
   4A6F C9            [10]   48     ret                                            ;; Si llega aquí no puede haber colisión
                             49 
   4A70                      50 verSiColY:
   4A70 DD 46 01      [19]   51     ld  b, enemiY(ix)                              ;; La coordenada Y del sprite del enemigo en B
   4A73 DD 7E 02      [19]   52     ld  a, enemiAlto(ix)                           ;; La altura del sprite del enemigo en A
   4A76 80            [ 4]   53     add a, b                                       ;; Se suma a la coordenada X del enemigo, resultado en A
   4A77 47            [ 4]   54     ld  b, a                                       ;; Lo guardo en B
   4A78 3E C1         [ 7]   55     ld  a, #0xC1                                   ;; C1 es la posición Y del player, que nunca cambia durante el juego (mejor usar constantes)
   4A7A B8            [ 4]   56     cp  b                                          ;; Se comparan, y si son iguales
   4A7B 28 03         [12]   57     jr  z, choque                                  ;; Colisionaron
   4A7D 38 01         [12]   58     jr  c, choque                                  ;; Si A es menor que B tambien hay colisión
   4A7F C9            [10]   59     ret
   4A80                      60 choque:                                            ;; Si llego hasta aquí es que hubo colisión
   4A80 CD 2D 4A      [17]   61     call destruyeEnemigo
   4A83 CD 8A 4A      [17]   62     call destruyePlayer
                             63 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             64  
                             65   
   4A86 C9            [10]   66     ret
