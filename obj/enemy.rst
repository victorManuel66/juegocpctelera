ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _CODE
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



                              4 .include "datos.h.s"
                     0013     1 tamagno_enemy = 0x13                               ;; Tamaño del array de entidades
   4DDF 03                    2 num_enemigos: .db 0x03                             ;; Número de enemigos
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              5 
                              6 .globl _enemigo
                              7 .globl _explo1
                              8 .globl _explo2
                              9 .globl _explo3
                             10 .globl _explo4
                             11 .globl _explo5
                             12 
                             13 .macro EntEnemigas name, x, y, h, w, _enemigo, velo, tiem, sta, animac1, animac2, animac3, animac4, animac5
                             14   name::
                             15     name'X:      .db x
                             16     name'Y:      .db y
                             17     name'H:      .db h
                             18     name'W:      .db w
                             19     name'spr:    .dw _enemigo
                             20     name'vel:    .db velo
                             21     name'tiemp:  .db tiem
                             22     name'status: .db sta
                             23     name'ani1:   .dw animac1
                             24     name'ani2:   .dw animac2
                             25     name'ani3:   .dw animac3
                             26     name'ani4:   .dw animac4
                             27     name'ani5:   .dw animac5
                             28 .endm
                             29 
   4DE0                      30 EntEnemigas enemy, 0x00, 0x09, 0x08, 0x03, _enemigo, 0x01, 0x00, 0x00, _explo1, _explo2, _explo3, _explo4, _explo5
   0001                       1   enemy::
   4DE0 00                    2     enemyX:      .db 0x00
   4DE1 09                    3     enemyY:      .db 0x09
   4DE2 08                    4     enemyH:      .db 0x08
   4DE3 03                    5     enemyW:      .db 0x03
   4DE4 2E 49                 6     enemyspr:    .dw _enemigo
   4DE6 01                    7     enemyvel:    .db 0x01
   4DE7 00                    8     enemytiemp:  .db 0x00
   4DE8 00                    9     enemystatus: .db 0x00
   4DE9 16 49                10     enemyani1:   .dw _explo1
   4DEB FE 48                11     enemyani2:   .dw _explo2
   4DED E6 48                12     enemyani3:   .dw _explo3
   4DEF CE 48                13     enemyani4:   .dw _explo4
   4DF1 B6 48                14     enemyani5:   .dw _explo5
   4DF3                      31 EntEnemigas enemy2, 0x00, 0x09, 0x08, 0x03, _enemigo, 0x01, 0x00, 0x00, _explo1, _explo2, _explo3, _explo4, _explo5
   0014                       1   enemy2::
   4DF3 00                    2     enemy2X:      .db 0x00
   4DF4 09                    3     enemy2Y:      .db 0x09
   4DF5 08                    4     enemy2H:      .db 0x08
   4DF6 03                    5     enemy2W:      .db 0x03
   4DF7 2E 49                 6     enemy2spr:    .dw _enemigo
   4DF9 01                    7     enemy2vel:    .db 0x01
   4DFA 00                    8     enemy2tiemp:  .db 0x00
   4DFB 00                    9     enemy2status: .db 0x00
   4DFC 16 49                10     enemy2ani1:   .dw _explo1
   4DFE FE 48                11     enemy2ani2:   .dw _explo2
   4E00 E6 48                12     enemy2ani3:   .dw _explo3
   4E02 CE 48                13     enemy2ani4:   .dw _explo4
   4E04 B6 48                14     enemy2ani5:   .dw _explo5
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   4E06                      32 EntEnemigas enemy3, 0x00, 0x09, 0x08, 0x03, _enemigo, 0x01, 0x00, 0x00, _explo1, _explo2, _explo3, _explo4, _explo5
   0027                       1   enemy3::
   4E06 00                    2     enemy3X:      .db 0x00
   4E07 09                    3     enemy3Y:      .db 0x09
   4E08 08                    4     enemy3H:      .db 0x08
   4E09 03                    5     enemy3W:      .db 0x03
   4E0A 2E 49                 6     enemy3spr:    .dw _enemigo
   4E0C 01                    7     enemy3vel:    .db 0x01
   4E0D 00                    8     enemy3tiemp:  .db 0x00
   4E0E 00                    9     enemy3status: .db 0x00
   4E0F 16 49                10     enemy3ani1:   .dw _explo1
   4E11 FE 48                11     enemy3ani2:   .dw _explo2
   4E13 E6 48                12     enemy3ani3:   .dw _explo3
   4E15 CE 48                13     enemy3ani4:   .dw _explo4
   4E17 B6 48                14     enemy3ani5:   .dw _explo5
                             33 
                             34 
                             35 
                             36 ;;
                             37 ;;enemy::
                             38 ;;    enemyX:     .db 0x00                               ;; Este será un número aleatorio entre 4 y 48
                             39 ;;    enemyY:     .db 0x09                               ;; Coordenada Y del enemigo
                             40 ;;    enemyAlto:  .db 0x08                               ;; Alto del Sprite en bytes del enemigo
                             41 ;;    enemyAncho: .db 0x03                               ;; Ancho del Sprte en bytes del enemigo
                             42 ;;    ptrSprite:  .dw _enemigo                           ;; Puntero a los datos del Sprite del enemigo
                             43 ;;    velocidad:  .db 0x01                               ;; Velocidad del enemigo
                             44 ;;    duraAnim:   .db 0x00                               ;; Tiempo que dura cada animación
                             45 ;;    estadoAni:  .db 0x00                               ;; Estado de la animación
                             46 ;;    anima1:     .dw _explo1                            ;; Primer frame de la animación
                             47 ;;    anima2:     .dw _explo2                            ;; Segundo frame de la animación
                             48 ;;    anima3:     .dw _explo3                            ;; Tercer frame de la animación
                             49 ;;    anima4:     .dw _explo4                            ;; Cuarto frame de la animación
                             50 ;;    anima5:     .dw _explo5                            ;; Quinto frame de la animación
                             51 ;;enemy2::
                             52 ;;    enemyX2:     .db 0x00                              ;; Este será un número aleatorio entre 4 y 48
                             53 ;;    enemyY2:     .db 0x09                              ;; Coordenada Y del enemigo
                             54 ;;    enemyAlto2:  .db 0x08                              ;; Alto del Sprite en bytes del enemigo
                             55 ;;    enemyAncho2: .db 0x03                              ;; Ancho del Sprte en bytes del enemigo
                             56 ;;    ptrSprite2:  .dw _enemigo                          ;; Puntero a los datos del Sprite del enemigo
                             57 ;;    velocidad2:  .db 0x01                              ;; Velocidad del enemigo
                             58 ;;    duraAnim2:   .db 0x00                              ;; Tiempo que dura cada animación
                             59 ;;    estadoAni2:  .db 0x00                              ;; Estado de la animación
                             60 ;;    anima1_2:    .dw _explo1                           ;; Primer frame de la animación
                             61 ;;    anima2_2:    .dw _explo2                           ;; Segundo frame de la animación
                             62 ;;    anima3_2:    .dw _explo3                           ;; Tercer frame de la animación
                             63 ;;    anima4_2:    .dw _explo4                           ;; Cuarto frame de la animación
                             64 ;;    anima5_2:    .dw _explo5                           ;; Quinto frame de la animación
                             65 ;;enemy3::
                             66 ;;    enemyX3:     .db 0x00                              ;; Este será un número aleatorio entre 4 y 48
                             67 ;;    enemyY3:     .db 0x09                              ;; Coordenada Y del enemigo
                             68 ;;    enemyAlto3:  .db 0x08                              ;; Alto del Sprite en bytes del enemigo
                             69 ;;    enemyAncho3: .db 0x03                              ;; Ancho del Sprte en bytes del enemigo
                             70 ;;    ptrSprite3:  .dw _enemigo                          ;; Puntero a los datos del Sprite del enemigo
                             71 ;;    velocidad3:  .db 0x01                              ;; Velocidad del enemigo
                             72 ;;    duraAnim3:   .db 0x00                              ;; Tiempo que dura cada animación
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             73 ;;    estadoAni3:  .db 0x00                              ;; Estado de la animación
                             74 ;;    anima1_3:    .dw _explo1                           ;; Primer frame de la animación
                             75 ;;    anima2_3:    .dw _explo2                           ;; Segundo frame de la animación
                             76 ;;    anima3_3:    .dw _explo3                           ;; Tercer frame de la animación
                             77 ;;    anima4_3:    .dw _explo4                           ;; Cuarto frame de la animación
                             78 ;;    anima5_3:    .dw _explo5                           ;; Quinto frame de la animación
                             79 ;;
                             80 
                             81 
                             82 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             83 ;;          ESTA RUTINA NECESITA EN IX LA DIRECCIÓN DE INICIO DE LOS DATOS DE LA ENTIDAD ENEMIGO            ;;
                             84 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                   
   4E19                      85 calXenemy::
   4E19 CD 1C 5F      [17]   86     call cpct_getRandom_xsp40_u8_asm                   ;; Devuelve en A un numero pseudo aleatorio de 8 bits
   4E1C FE 05         [ 7]   87     cp #0x05                                           ;; Comparo con el valor mmímimo
   4E1E 38 06         [12]   88     jr c, menorCuatro                                  ;; Si es menor que cuatro salta a menorCuatro
   4E20 FE 2F         [ 7]   89     cp #0x2f                                           ;; Comparo con 48 decimal
   4E22 30 06         [12]   90     jr nc, mayor47                                     ;; Si no hay acarreo es que es mayor de 48
   4E24 18 06         [12]   91     jr fin                                             ;; Si llego aquí es porque es mayor que 4 y menor de 48                         
   4E26                      92 menorCuatro:
   4E26 C6 05         [ 7]   93     add a,#0x05
   4E28 18 02         [12]   94     jr fin
   4E2A                      95 mayor47:
   4E2A 18 ED         [12]   96     jr calXenemy
   4E2C                      97 fin:
   4E2C DD 77 00      [19]   98     ld enemiX(ix), a                                        ;; Guarda la nueva coordenada X para el enemigo
   4E2F C9            [10]   99     ret
                            100 
   4E30                     101 draw_enemy::
   4E30 FD 21 DF 4D   [14]  102     ld  iy, #num_enemigos
   4E34 FD 5E 00      [19]  103     ld  e, 0(iy)
   4E37                     104 sigui_enemy_draw:                         
   4E37 D5            [11]  105     push de                                            ;; draw_enemi_sprite corrompe DE
   4E38 CD 46 4E      [17]  106     call draw_enemy_sprite                             ;; Dibujar una entidad enemigo
   4E3B D1            [10]  107     pop de                                             ;; Recuperar DE con el total de entidades enemigas restantes
   4E3C 1D            [ 4]  108     dec e                                              ;; Resta uno al total de entidades enemigas
   4E3D C8            [11]  109     ret z                                              ;; Si no quedan enemigos vuelve
   4E3E 01 13 00      [10]  110     ld bc, #tamagno_enemy                              ;; El tamaño de los datos de un enemigo
   4E41 DD 09         [15]  111     add ix,bc                                          ;; Se suma a Ix oara deslazar el puntero
   4E43 18 F2         [12]  112     jr sigui_enemy_draw                                ;; Siguiente enemigo a dibujar
   4E45 C9            [10]  113     ret
                            114 
   4E46                     115 draw_enemy_sprite:                                 
   4E46 11 00 C0      [10]  116     ld de, #0xC000                                     ;; Inicio de la memoria de video                                
   4E49 DD 46 01      [19]  117     ld  b, enemiY(ix)                                  ;; Coordenada Y del enemigo en B
   4E4C DD 4E 00      [19]  118     ld  c, enemiX(ix)                                  ;; Coordenada X del enemigo en C
   4E4F CD 39 60      [17]  119     call cpct_getScreenPtr_asm
                            120 
   4E52 EB            [ 4]  121     ex de, hl
   4E53 3E 00         [ 7]  122     ld  a, #0x00                                       ;; *********** El Sprite de la nave *****************
   4E55 DD BE 08      [19]  123     cp StatusAni(ix)                                   ;; *********** El estatus de la animación ************
   4E58 20 08         [12]  124     jr nz, frameExplo1                                 ;; *********** Si no es el sprite de la nave, ve a explosion 1 *****************
   4E5A DD 6E 04      [19]  125     ld  l, SpriteBajo(ix)
   4E5D DD 66 05      [19]  126     ld  h, SpriteAlto(ix)                              ;; En HL direccion del Sprite del enemigo
   4E60 18 3E         [12]  127     jr dibuja                                          ;; ************ Dibuja el sprite de la nave *****************************
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   4E62                     128 frameExplo1:
   4E62 3C            [ 4]  129     inc  a                                             ;; Ver si el el fotograma 1 de a animación
   4E63 DD BE 08      [19]  130     cp StatusAni(ix)                                   ;; *********** El estatus de la animación ************
   4E66 20 08         [12]  131     jr nz, frameExplo2                                 ;; ******** Si no es explosión 1 ver si es explosión 2 *********************
   4E68 DD 6E 09      [19]  132     ld  l, frame1Bajo(ix)                              ;; *********** Byte bajo de la dirección del sprite **********************
   4E6B DD 66 0A      [19]  133     ld  h, frame1Alto(ix)                              ;; *********** Byte alto de la dirección del sprite **********************
   4E6E 18 30         [12]  134     jr dibuja
   4E70                     135 frameExplo2:
   4E70 3C            [ 4]  136     inc  a                                             ;; *********** Ver si es el fotograma 2 de la animación *********
   4E71 DD BE 08      [19]  137     cp StatusAni(ix)                                   ;; *********** El estatus de la animación ************
   4E74 20 08         [12]  138     jr nz, frameExplo3                                 ;; ******** Si no es explosión 2 ver si es explosión 3 *********************
   4E76 DD 6E 0B      [19]  139     ld  l, frame2Bajo(ix)                              ;; *********** Byte bajo de la dirección del sprite **********************
   4E79 DD 66 0C      [19]  140     ld  h, frame2Alto(ix)                              ;; *********** Byte alto de la dirección del sprite **********************
   4E7C 18 22         [12]  141     jr dibuja
   4E7E                     142 frameExplo3:
   4E7E 3C            [ 4]  143     inc  a                                             ;; ************* Ver si es el fotograma 3 de la animación *******************
   4E7F DD BE 08      [19]  144     cp StatusAni(ix)                                   ;; ************* El estatus de la animación    *******************************
   4E82 20 08         [12]  145     jr nz, frameExplo4                                 ;; ********** Si no es la explosión 3 ver si es la 5 ********************
   4E84 DD 6E 0D      [19]  146     ld  l, frame3Bajo(ix)                              ;; *********** Byte bajo de la dirección del sprite **********************
   4E87 DD 66 0E      [19]  147     ld  h, frame3Alto(ix)                              ;; *********** Byte alto de la dirección del sprite **********************
   4E8A 18 14         [12]  148     jr dibuja
   4E8C                     149 frameExplo4:
   4E8C 3C            [ 4]  150     inc  a                                             ;; ************* Ver si es el fotograma 4 de la animación *******************
   4E8D DD BE 08      [19]  151     cp StatusAni(ix)                                   ;; ************* El estatus de la animación    *******************************
   4E90 20 08         [12]  152     jr nz, frameExplo5                                 ;; ********** Si no es la explosión 4 ver si es la 5 ********************
   4E92 DD 6E 0F      [19]  153     ld  l, frame4Bajo(ix)                              ;; *********** Byte bajo de la dirección del sprite **********************
   4E95 DD 66 10      [19]  154     ld  h, frame4Alto(ix)                              ;; *********** Byte alto de la dirección del sprite **********************
   4E98 18 06         [12]  155     jr dibuja
   4E9A                     156 frameExplo5:
   4E9A DD 6E 11      [19]  157     ld  l, frame5Bajo(ix)                              ;; *********** Byte bajo de la dirección del sprite **********************
   4E9D DD 66 12      [19]  158     ld  h, frame5Alto(ix)                              ;; *********** Byte alto de la dirección del sprite **********************
   4EA0                     159 dibuja:
   4EA0 DD 46 02      [19]  160     ld  b, enemiAlto(ix)                               ;; Alto enemigo en B (en bytes)
   4EA3 DD 4E 03      [19]  161     ld  c, enemiAncho(ix)                              ;; Ancho enemigo en C (en bytes)
   4EA6 CD 88 5D      [17]  162     call cpct_drawSprite_asm
                            163 
                            164 
   4EA9 C9            [10]  165     ret                                                ;; Aquí acaba draeçw_enemy_sprite
                            166 
   4EAA                     167 erase_enemy::
   4EAA FD 21 DF 4D   [14]  168     ld iy, #num_enemigos
   4EAE FD 5E 00      [19]  169     ld  e, 0(iy)                           
   4EB1                     170 sigui_enemy:
   4EB1 D5            [11]  171     push de
   4EB2 CD C0 4E      [17]  172     call erase_enemy_sprite                           ;; Borrar una entidad enemigo enemigo
   4EB5 D1            [10]  173     pop  de   
   4EB6 1D            [ 4]  174     dec e                                             ;; Resta uno al total de entidades enemigas
   4EB7 C8            [11]  175     ret z                                             ;; Si no quedan enemigos vuelve
   4EB8 01 13 00      [10]  176     ld bc, #tamagno_enemy                             ;; El tamaño de los datos de un enemigo
   4EBB DD 09         [15]  177     add ix,bc                                         ;; Se suma a Ix oara deslazar el puntero
   4EBD 18 F2         [12]  178     jr sigui_enemy                                    ;; Siguiente enemigo a borrar
   4EBF C9            [10]  179     ret
                            180 
   4EC0                     181 erase_enemy_sprite:
   4EC0 11 00 C0      [10]  182     ld de, #0xC000                                    ;; Inicio de la memoria de video
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   4EC3 DD 46 01      [19]  183     ld  b, enemiY(ix)                                 ;; Coordenada Y del enemigo
   4EC6 DD 4E 00      [19]  184     ld  c, enemiX(ix)                                 ;; Coordenada X del enemigo
   4EC9 CD 39 60      [17]  185     call cpct_getScreenPtr_asm
                            186 
   4ECC EB            [ 4]  187     ex de,hl                                          ;; Necesario por que la dirección de video debe estar en DE
   4ECD 3E 00         [ 7]  188     ld  a, #0x00                                      ;; Pintar con color cero
   4ECF DD 46 02      [19]  189     ld  b, enemiAlto(ix)                              ;; Alto del Sprite del enemigo en B (en bytes)
   4ED2 DD 4E 03      [19]  190     ld  c, enemiAncho(ix)                             ;; Ancho del Sprite del enemigo en C (en bytes)
   4ED5 CD 51 5F      [17]  191     call cpct_drawSolidBox_asm                        ;; Dibujar una caja con el color del fondo
                            192 
   4ED8 C9            [10]  193     ret
                            194 
   4ED9                     195 update_enemy::
   4ED9 FD 21 DF 4D   [14]  196     ld iy, #num_enemigos
   4EDD FD 5E 00      [19]  197     ld  e, 0(iy)                                      ;; En E el números de enemigos          
   4EE0                     198 sigui_update:   
   4EE0 D5            [11]  199     push de                                           ;; Preservo E 
   4EE1 CD F2 4E      [17]  200     call update_spr_enemy                             ;; Actualiza posición X e Y de los enemigos
   4EE4 CD 0C 4F      [17]  201     call update_tempo_enemy                           ;; Actualiza el tiempo que se ve el fotograma
   4EE7 D1            [10]  202     pop  de                                           ;; Recupero número de entidades enemigas
   4EE8 1D            [ 4]  203     dec e                                             ;; Resta uno al total de entidades enemigas
   4EE9 C8            [11]  204     ret z                                             ;; Si no quedan enemigos vuelve
   4EEA 01 13 00      [10]  205     ld bc, #tamagno_enemy                             ;; El tamaño de los datos de un enemigo
   4EED DD 09         [15]  206     add ix,bc                                         ;; Se suma a IX para deslazar el puntero
   4EEF 18 EF         [12]  207     jr sigui_update                                   ;; Siguiente enemigo a actualizar posición
   4EF1 C9            [10]  208     ret
                            209 
   4EF2                     210 update_spr_enemy:
   4EF2 DD 7E 01      [19]  211     ld  a, enemiY(ix)                                 ;; En el acumulador la coordenada Y del enemigo
   4EF5 DD 46 06      [19]  212     ld  b, enemiVelo(ix)                              ;; El valor de la velocidad del enemigo
   4EF8 80            [ 4]  213     add a, b                                          ;; Se suma resultado en A
   4EF9 FE C8         [ 7]  214     cp  #200
   4EFB 28 06         [12]  215     jr z, otroAlien                                   ;; Si A == 0
   4EFD 30 04         [12]  216     jr nc, otroAlien                                  ;; || A > 200 que se cree otro alien
   4EFF DD 77 01      [19]  217     ld enemiY(ix), a                                  ;; Se guarda la nueva posición Y del enemigo
   4F02 C9            [10]  218     ret
   4F03                     219 otroAlien:
   4F03 3E 09         [ 7]  220     ld  a, #0x09                                      ;; Reset de la coordenada Y del enemigo
   4F05 DD 77 01      [19]  221     ld  enemiY(ix), a                                 ;; Se guarda
   4F08 CD 19 4E      [17]  222     call calXenemy                                    ;; Calcula de forma aleatoria otra coordenada X
   4F0B C9            [10]  223     ret
                            224 
   4F0C                     225 update_tempo_enemy:
   4F0C DD 7E 08      [19]  226     ld  a, StatusAni(ix)                              ;;  Comprobar el estado de la animación
   4F0F FE 00         [ 7]  227     cp #0x00                                          ;;  Si es cero, no esta explotando 
   4F11 C8            [11]  228     ret z                                             ;;  Por lo tanto vuelve 
   4F12 DD 7E 07      [19]  229     ld  a, temporiza(ix)                              ;;  Valor actual del temporizador
   4F15 FE 02         [ 7]  230     cp  #0x02                                         ;;  Ver si han pasado el número de ciclos
   4F17 20 28         [12]  231     jr nz, masCiclos                                  ;;  Si no ha llegado sigue sumando ciclos
   4F19 DD 36 07 00   [19]  232     ld  temporiza(ix), #0x00                          ;;  El temporizador a cero
   4F1D DD 34 08      [23]  233     inc StatusAni(ix)                                 ;;  El siguiente fotograma de la animación 
   4F20 DD 7E 08      [19]  234     ld a, StatusAni(ix)                               ;;  El estado de la animación al acumulador
   4F23 FE 05         [ 7]  235     cp #0x05                                          ;;  Ver si es la 6 animación
   4F25 20 19         [12]  236     jr nz, vuelve                                     ;;  Si no lo es siguiente animación
   4F27 11 00 C0      [10]  237     ld de, #0xC000                                    ;;  Inicio de la memoria de video                          
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   4F2A DD 46 01      [19]  238     ld  b, enemiY(ix)                                 ;;  En B la coordenada Y del sprite
   4F2D 3E 09         [ 7]  239     ld  a, #0x09                                      ;;  Reset de la coordenada Y del enemigo
   4F2F DD 77 01      [19]  240     ld  enemiY(ix), a                                 ;;  Se guarda en la coordenada Y del enemigo
   4F32 CD 19 4E      [17]  241     call calXenemy                                    ;;  Nueva coordenada X aleatoria para el enemigo
   4F35 CD 39 60      [17]  242     call cpct_getScreenPtr_asm                        ;;  Borra el último sprite de la animación
   4F38 DD 36 08 00   [19]  243     ld StatusAni(ix), #0x00                           ;;  Vuelta al fotograma cero
   4F3C DD 36 06 01   [19]  244     ld enemiVelo(ix), #0x01                           ;;  Activar la velocidad del enemigo
                            245     
   4F40                     246 vuelve:
   4F40 C9            [10]  247     ret
   4F41                     248 masCiclos:
   4F41 DD 34 07      [23]  249     inc temporiza(ix)                                 ;; Aumenta en uno el temporizador
   4F44 C9            [10]  250     ret
                            251 
   4F45                     252 posXenemyPtr::
   4F45 DD 21 E0 4D   [14]  253     ld ix, #enemyX                                     ;; Devuelve en HL la dirección de enemyX  
   4F49 C9            [10]  254     ret
                            255 
   4F4A                     256 posYenemyPtr::
   4F4A DD 21 E1 4D   [14]  257     ld ix, #enemyY                                    ;; Devuelve en HL la dirección de enemyY
   4F4E C9            [10]  258     ret
