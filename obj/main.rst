ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module principal
                              2 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              3 .include "cpctelera.h.s"
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



                              5 .include "laser.h.s"
                              1 .globl draw_laser
                              2 .globl erase_laser
                              3 .globl update_laser
                              4 .globl posXlaserPtr
                              5 .globl posYlaserPtr
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              6 .include "enemy.h.s"
                              1 .globl draw_enemy
                              2 .globl calXenemy
                              3 .globl erase_enemy
                              4 .globl update_enemy
                              5 .globl posXenemyPtr
                              6 .globl posYenemyPtr
                              7 .globl enemy
                              8 .globl enemy2
                              9 .globl enemy3
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              7 .include "laserColision.h.s"
                              1 .globl laser_colision
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                              8 .include "enemy_colision.h.s"
                              1 .globl colision_enemy
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                              9 .include "destruyePlayer.h.s"
                              1 .globl destruyePlayer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             10 .include "mensajes.h.s"
                              1 .globl gameover
                              2 .globl escore
                              3 .globl new
                              4 .globl lives
                              5 .globl writeMenu1
                              6 .globl writeMenu2
                              7 .globl writeMenu3
                              8 .globl izqui
                              9 .globl dere
                             10 .globl fue
                             11 .globl puntos
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                             11 .include "menu.h.s"
                              1 .globl menu
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             12 .include "destroyEnemy.h.s"
                              1 .globl destruyeEnemigo
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                             13 .include "datos.h.s"
                     0013     1 tamagno_enemy = 0x13                               ;; Tamaño del array de entidades
   4C23 03                    2 num_enemigos: .db 0x03                             ;; Número de enemigos
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                             14 
                             15 .area _DATA
                             16 .area _CODE
                             17 
                             18 .globl _tileset
                             19 .globl _fondo
                             20 .globl _Newexplo
                             21 .globl _spr
                             22 
                             23 
                             24 
                             25 
   4C24                      26 paleta:
   4C24 14 14 1D 18 0C 1C    27    .db 20,20,29,24,12,28,11,2,0,14,0,0,19,10,0,27
        0B 02 00 0E 00 00
        13 0A 00 1B
                             28 
   4C34                      29 _main::
                             30    ;; Disable firmware to prevent it from interfering with string drawing
   4C34 CD 41 5F      [17]   31    call cpct_disableFirmware_asm
                             32    ;; Cambiamos a modo de video 0
   4C37 0E 00         [ 7]   33    ld  c, #0x00
   4C39 CD 07 5F      [17]   34    call cpct_setVideoMode_asm
                             35    ;; Asignamos colores a la paleta
   4C3C 21 24 4C      [10]   36    ld hl, #paleta
   4C3F 11 10 00      [10]   37    ld de, #0x10
   4C42 CD AC 54      [17]   38    call cpct_setPalette_asm
                             39    ;; Inicializar sonidos SFX
   4C45 11 40 00      [10]   40    ld de, #_Newexplo
   4C48 CD 6D 5C      [17]   41    call cpct_akp_SFXInit_asm
   4C4B 11 40 00      [10]   42    ld de, #_Newexplo
   4C4E CD E1 5B      [17]   43    call cpct_akp_musicInit_asm
                             44 
   4C51 CD C7 4F      [17]   45    call menu
                             46 
   4C54                      47 newGame:
                             48    ;; Dibujar la pantalla
   4C54 21 66 48      [10]   49    ld hl, #_tileset
   4C57 CD B4 5E      [17]   50    call cpct_etm_setTileset2x4_asm
   4C5A 21 00 40      [10]   51    ld hl, #_fondo
   4C5D E5            [11]   52    push hl
   4C5E 21 00 C0      [10]   53    ld hl, #0xC000
   4C61 E5            [11]   54    push hl
   4C62 01 00 00      [10]   55    ld bc, #0x0000
   4C65 11 28 32      [10]   56    ld de, #0x3228
   4C68 3E 28         [ 7]   57    ld  a, #0x28
   4C6A CD 28 5E      [17]   58    call cpct_etm_drawTileBox2x4_asm
                             59 
                             60    ;; Marcador
   4C6D 21 02 00      [10]   61    ld hl, #0x0002
   4C70 CD 16 60      [17]   62    call cpct_setDrawCharM0_asm                                    ;; Colores del texto
                             63 
   4C73 11 00 C0      [10]   64    ld de, #0xC000
   4C76 01 3B 14      [10]   65    ld bc, #0x143B
   4C79 CD 39 60      [17]   66    call cpct_getScreenPtr_asm                                     ;; Posición de pantalla donde escribir
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   4C7C FD 21 CE 4B   [14]   67    ld iy, #new
   4C80 CD FE 5C      [17]   68    call cpct_drawStringM0_asm
   4C83 11 00 C0      [10]   69    ld de, #0xC000
   4C86 01 37 1B      [10]   70    ld bc, #0x1B37
   4C89 CD 39 60      [17]   71    call cpct_getScreenPtr_asm                                     ;; Posición de pantalla donde escribir
   4C8C FD 21 D2 4B   [14]   72    ld iy, #escore
   4C90 CD FE 5C      [17]   73    call cpct_drawStringM0_asm
   4C93 11 00 C0      [10]   74    ld de, #0xC000
   4C96 01 37 4E      [10]   75    ld bc, #0x4E37
   4C99 CD 39 60      [17]   76    call cpct_getScreenPtr_asm                                     ;; Posición de pantalla donde escribir
   4C9C FD 21 D2 4B   [14]   77    ld iy, #escore
   4CA0 CD FE 5C      [17]   78    call cpct_drawStringM0_asm
   4CA3 11 00 C0      [10]   79    ld de, #0xC000
   4CA6 01 37 8A      [10]   80    ld bc, #0x8A37
   4CA9 CD 39 60      [17]   81    call cpct_getScreenPtr_asm                                     ;; Posición de pantalla donde escribir
   4CAC FD 21 D8 4B   [14]   82    ld iy, #lives                                                  
   4CB0 CD FE 5C      [17]   83    call cpct_drawStringM0_asm                                     ;; Escribe vidas
   4CB3 11 00 C0      [10]   84    ld de, #0xC000
   4CB6 01 37 5C      [10]   85    ld bc, #0x5C37
   4CB9 CD 39 60      [17]   86    call cpct_getScreenPtr_asm
   4CBC FD 21 1D 4C   [14]   87    ld iy, #puntos
   4CC0 CD FE 5C      [17]   88    call cpct_drawStringM0_asm                                    ;; Dibuja los puntos
                             89 
                             90    ;; dibujar las naves en el marcador
   4CC3 01 37 A6      [10]   91    ld bc, #0xA637                                                 ;; En B coordenada Y en C coordenada X
   4CC6 3E 03         [ 7]   92    ld  a, #0x03                                                   ;; El número de naves a dibujar
   4CC8                      93 nextShip:
   4CC8 F5            [11]   94    push af                                                        ;; Preservo A por que las llamadas a cpctelera lo corrompen
   4CC9 C5            [11]   95    push bc                                                        ;; Lo mismo para BC
   4CCA 11 00 C0      [10]   96    ld de, #0xC000
   4CCD CD 39 60      [17]   97    call cpct_getScreenPtr_asm                                     ;; Posición de pantalla donde escribir
   4CD0 EB            [ 4]   98    ex de, hl                                                      ;; Necesario por cpct_drawSprite
   4CD1 21 5A 49      [10]   99    ld hl, #_spr                                                   ;; Dirección donde esta el sprite
   4CD4 01 05 06      [10]  100    ld bc, #0x0605                                                 ;; B alto y C ancho del sprite
   4CD7 CD 88 5D      [17]  101    call cpct_drawSprite_asm                                       ;; dibuja el sprite
   4CDA C1            [10]  102    pop bc
   4CDB 3E 07         [ 7]  103    ld  a, #0x07
   4CDD 81            [ 4]  104    add a, c
   4CDE 4F            [ 4]  105    ld  c,a
   4CDF F1            [10]  106    pop af
   4CE0 3D            [ 4]  107    dec  a
   4CE1 20 E5         [12]  108    jr nz, nextShip
                            109 
                            110    
                            111 
   4CE3 DD 21 E0 4D   [14]  112    ld ix, #enemy
   4CE7 CD 19 4E      [17]  113    call calXenemy                                        ;; Pide una coordenada X para enemy
   4CEA DD 21 F3 4D   [14]  114    ld ix, #enemy2
   4CEE CD 19 4E      [17]  115    call calXenemy                                        ;; Pide una coordenada X para enemy2
   4CF1 DD 21 06 4E   [14]  116    ld ix, #enemy3                       
   4CF5 CD 19 4E      [17]  117    call calXenemy                                        ;; Pide una coordenada X para enemy3
                            118 
   4CF8                     119    main_loop:
   4CF8 DD 21 89 49   [14]  120       ld ix, #Player                                     ;; IX contiene el inicio de los datos del Player    
   4CFC CD FF 49      [17]  121       call erase_player                                  ;; Borra el sprite de la posición actual
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



   4CFF DD 21 E0 4D   [14]  122       ld ix, #enemy                                      ;; IX ahora apunta al inicio de los datos enemigo
   4D03 CD AA 4E      [17]  123       call erase_enemy                                   ;; Borra al enemigo
                            124 
   4D06 DD 21 89 49   [14]  125       ld ix, #Player                                     ;; IX contiene el inicio de los datos del Player
   4D0A CD 97 49      [17]  126       call update_player                                 ;; Calcula la nueva posición
   4D0D DD 21 E0 4D   [14]  127       ld ix, #enemy                                      ;; IX ahora apunta al inicio de los datos enemigo
   4D11 CD D9 4E      [17]  128       call update_enemy                                  ;; Calcula la nueva posición del enemigo
   4D14 DD 21 E0 4D   [14]  129       ld ix, #enemy                                      ;; IX contiene el inicio de los datos del enemy
   4D18 CD 37 4A      [17]  130       call colision_enemy                                ;; Ver si los enemigos colisionan
                            131    
                            132 
   4D1B DD 21 89 49   [14]  133       ld ix, #Player                                     ;; IX contiene inicio de los datos del Player
   4D1F CD DE 49      [17]  134       call draw_player                                   ;; Dibuja el sprite en la nueva posición
   4D22 DD 21 E0 4D   [14]  135       ld ix, #enemy                                      ;; IX ahora apunta al inicio de los datos del enemigo
   4D26 CD 30 4E      [17]  136       call draw_enemy                                    ;; Dibuja al enemigo
                            137   
                            138 
   4D29 CD 19 4A      [17]  139       call disparando                                    ;; Comprobar si esta disparando
   4D2C 7E            [ 7]  140       ld  a, (hl)
   4D2D FE 01         [ 7]  141       cp #0x01                                           ;; Si esta a uno es que tiene que disparar
   4D2F 20 10         [12]  142       jr nz, nodisparar
                            143 
   4D31 CD A0 4D      [17]  144       call erase_laser                                   ;; Borra el disparo
   4D34 CD B8 4D      [17]  145       call update_laser                                  ;; Actualiza el disparo
   4D37 CD 87 4D      [17]  146       call draw_laser                                    ;; Dibuja el disparo
   4D3A DD 21 E0 4D   [14]  147       ld ix, #enemy
   4D3E CD 50 4F      [17]  148       call laser_colision                                ;; Ver si laser colision
                            149 
   4D41                     150 nodisparar::
   4D41 CD 14 5F      [17]  151       call cpct_waitVSYNC_asm                            ;; Sincronización
   4D44 CD D7 54      [17]  152       call cpct_akp_musicPlay_asm                        ;; Tocar música para usar los efectos de sonidoa
                            153 
   4D47 DD 21 89 49   [14]  154       ld ix, #Player  
   4D4B DD 7E 06      [19]  155       ld  a, 6(ix)                                       ;; El número de vidas restantes
   4D4E FE 00         [ 7]  156       cp  #0x00                                          ;; Ver si estan a cero las vidas
   4D50 20 A6         [12]  157       jr nz, main_loop                                   ;; Continua mientras haya vidas
                            158 
                            159 
   4D52 21 04 00      [10]  160       ld hl, #0x0004
   4D55 CD 16 60      [17]  161       call cpct_setDrawCharM0_asm
                            162 
   4D58 11 00 C0      [10]  163       ld de, #0xC000                                     ;; Inicio de la memoria de video
   4D5B 01 0A 64      [10]  164       ld bc, #0x640A                                     ;; Coordenadas X y Y donde escribir
   4D5E CD 39 60      [17]  165       call cpct_getScreenPtr_asm                         ;; Obtener dirección de momoria de video
                            166       
   4D61 FD 21 C4 4B   [14]  167       ld iy, #gameover
   4D65 CD FE 5C      [17]  168       call cpct_drawStringM0_asm                         ;; Excribe el mensaje
                            169 
   4D68 CD 3A 5C      [17]  170       call cpct_akp_stop_asm                             ;; Para el sonido
                            171 
   4D6B                     172 espera:
   4D6B CD 4D 60      [17]  173       call cpct_scanKeyboard_asm                         ;; Escanear al teclado
   4D6E CD FA 5E      [17]  174       call cpct_isAnyKeyPressed_asm                      ;; Ver si se pulso una tecla
   4D71 FE 00         [ 7]  175       cp #0x00                                           ;; Si en A hay un cero es que no se pulso una tecla
   4D73 28 F6         [12]  176       jr  z, espera                                      ;; vuelve a espera hasta que se pulse una tecla
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



                            177 
   4D75 CD C7 4F      [17]  178       call menu
                            179 
   4D78 DD 21 89 49   [14]  180       ld ix, #Player                                     ;; Puntero al inicio de datos del jugador
   4D7C DD 36 06 03   [19]  181       ld 6(ix), #0x03                                    ;; Número de vidas de nuevo a tres
                            182 
                            183 
   4D80 C3 54 4C      [10]  184       jp newGame                                         ;; Jugar de nuevo
