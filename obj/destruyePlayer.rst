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



                              5 
                              6 
                              7 .globl _playerexplo1
                              8 .globl _playerexplo2
                              9 .globl _playerexplo3
                             10 .globl _playerexplo4
                             11 .globl _playerexplo5
                             12 
   4A87 3E                   13 segundBorrado: .db 0x3E                            ;; Segunda coordenada de la nave a borrar en el marcador
   4A88 45                   14 primerBorrado: .db 0x45                            ;; Tercera coordenada de la nave a borrar en el marcador
   4A89 01                   15 aBorrar:       .db 0x01                            ;; La primera nave a borrar
                             16 
                             17 
   4A8A                      18 destruyePlayer::
                             19     ;; A = No Channel (0,1,2)
                             20     ;; L = Instrument Number (>0)
                             21     ;; H = Volume (0...F)
                             22     ;; E = Note (0...143)
                             23     ;; D = Speed (0 = As original, 1...255 = new Speed (1 is the fastest))
                             24     ;; BC = Inverted Pitch (-#FFFF -> FFFF). 0 is no pitch. The higher the pitch, the lower the sound.
   4A8A 3E 02         [ 7]   25     ld  a, #0x02
   4A8C 21 03 0F      [10]   26     ld hl, #0x0F03
   4A8F 11 14 00      [10]   27     ld de, #0x0014
   4A92 01 00 00      [10]   28     ld bc, #0x0000
   4A95 CD 93 5C      [17]   29     call cpct_akp_SFXPlay_asm
                             30 
                             31 
   4A98 11 00 C0      [10]   32     ld de, #0xC000                                  ;; Inicio de la memoria de video                          
   4A9B CD 15 4A      [17]   33     call posXplayerPtr
   4A9E 4E            [ 7]   34     ld  c,(hl)                                      ;; Coordenada X en C
   4A9F 3E C1         [ 7]   35     ld  a, #0xC1
   4AA1 47            [ 4]   36     ld  b, a                                        ;; Coordenada Y en B
   4AA2 CD 39 60      [17]   37     call cpct_getScreenPtr_asm
                             38 
   4AA5 EB            [ 4]   39     ex de, hl
   4AA6 21 2A 48      [10]   40     ld hl, #_playerexplo2                                 ;; Siguiente sprite
   4AA9 D5            [11]   41     push de                                               ;; Se preserva DE por que lo corrompe cpct_drawSprite_asm
   4AAA CD F9 4A      [17]   42     call anima
   4AAD CD 00 4B      [17]   43     call espera
   4AB0 D1            [10]   44     pop de                                                ;; Se recupera DE que continien la coordenada de pantalla a dibujar
   4AB1 21 0C 48      [10]   45     ld hl, #_playerexplo3                                 ;; Siguiente sprite
   4AB4 D5            [11]   46     push de                                               ;; Se preserva DE por que lo corrompe cpct_drawSprite_asm 
   4AB5 CD F9 4A      [17]   47     call anima
   4AB8 CD 00 4B      [17]   48     call espera
   4ABB D1            [10]   49     pop de                                                ;; Se recupera DE que continien la coordenada de pantalla a dibujar
   4ABC D5            [11]   50     push de                                               ;; Se preserva DE por que lo corrompe cpct_drawSprite_asm
   4ABD 21 EE 47      [10]   51     ld hl, #_playerexplo4
   4AC0 CD F9 4A      [17]   52     call anima
   4AC3 CD 00 4B      [17]   53     call espera
   4AC6 D1            [10]   54     pop de                                                ;; Se recupera DE que continien la coordenada de pantalla a dibujar
   4AC7 21 D0 47      [10]   55     ld hl, #_playerexplo5
   4ACA CD F9 4A      [17]   56     call anima
   4ACD CD 00 4B      [17]   57     call espera
                             58     
   4AD0 DD 21 89 49   [14]   59     ld ix, #Player
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   4AD4 DD 7E 06      [19]   60     ld  a, 6(ix)                                         ;; Cargo el número de vidas del player
   4AD7 3D            [ 4]   61     dec a                                                ;; resto una
   4AD8 DD 77 06      [19]   62     ld 6(ix), a                                          ;; Se vuelve a guardar
                             63 
   4ADB 3A 89 4A      [13]   64     ld  a,(aBorrar)                                      ;; La primera nave a borrar
   4ADE FE 01         [ 7]   65     cp  #0x01                                            ;; Ver si es el primera muerte
   4AE0 20 0D         [12]   66     jr nz, borraDos
   4AE2 3A 88 4A      [13]   67     ld  a, (primerBorrado)
   4AE5 4F            [ 4]   68     ld  c, a                                             ;; La coordenada X nave a borrar en C
   4AE6 CD 07 4B      [17]   69     call borraNave
   4AE9 3E 02         [ 7]   70     ld  a, #0x02
   4AEB 32 89 4A      [13]   71     ld  (aBorrar), a
   4AEE C9            [10]   72     ret
   4AEF                      73 borraDos:
   4AEF FE 02         [ 7]   74     cp #0x02
   4AF1 3A 87 4A      [13]   75     ld  a,(segundBorrado)
   4AF4 4F            [ 4]   76     ld  c, a
   4AF5 CD 07 4B      [17]   77     call borraNave
                             78    
   4AF8 C9            [10]   79     ret
                             80 
   4AF9                      81 anima:
   4AF9 01 05 06      [10]   82     ld bc, #0x0605                                        ;; Medidas en bytes del player
   4AFC CD 88 5D      [17]   83     call cpct_drawSprite_asm
   4AFF C9            [10]   84     ret
                             85 
   4B00                      86 espera:
   4B00 3E 14         [ 7]   87     ld a, #0x14
   4B02                      88 otro:
   4B02 76            [ 4]   89     halt
   4B03 3D            [ 4]   90     dec a
   4B04 20 FC         [12]   91     jr nz,otro
   4B06 C9            [10]   92     ret
                             93 
   4B07                      94 borraNave:
   4B07 11 00 C0      [10]   95     ld de, #0xC000
   4B0A 06 A6         [ 7]   96     ld  b, #0xA6
   4B0C CD 39 60      [17]   97     call cpct_getScreenPtr_asm
   4B0F EB            [ 4]   98     ex de,hl
   4B10 3E 00         [ 7]   99     ld  a, #0x00
   4B12 01 05 06      [10]  100     ld bc, #0x0605
   4B15 CD 51 5F      [17]  101     call cpct_drawSolidBox_asm
   4B18 C9            [10]  102     ret
