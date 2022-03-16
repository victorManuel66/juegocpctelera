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



                              4 
   4B19 00                    5 decenas:  .db 0x00
   4B1A 00                    6 centenas: .db 0x00
   4B1B 00                    7 millares: .db 0x00
   4B1C 00                    8 diezmil:  .db 0x00
                              9 
   4B1D                      10 suma::
   4B1D 21 19 4B      [10]   11     ld hl, #decenas
   4B20 34            [11]   12     inc (hl)
   4B21 3E 0A         [ 7]   13     ld a, #0x0A
   4B23 BE            [ 7]   14     cp (hl)
   4B24 20 25         [12]   15     jr nz, guarda
   4B26 3E 00         [ 7]   16     ld  a, #0x00
   4B28 32 19 4B      [13]   17     ld (decenas), a
   4B2B 21 1A 4B      [10]   18     ld hl, #centenas
   4B2E 34            [11]   19     inc (hl)
   4B2F 3E 0A         [ 7]   20     ld  a, #0x0A
   4B31 BE            [ 7]   21     cp (hl)
   4B32 20 17         [12]   22     jr nz, guarda
   4B34 3E 00         [ 7]   23     ld  a, #0x00
   4B36 32 1A 4B      [13]   24     ld (centenas), a
   4B39 21 1B 4B      [10]   25     ld hl, #millares
   4B3C 34            [11]   26     inc (hl)
   4B3D 3E 0A         [ 7]   27     ld  a, #0x0A
   4B3F BE            [ 7]   28     cp (hl)
   4B40 20 09         [12]   29     jr nz, guarda
   4B42 3E 00         [ 7]   30     ld a, #0x00
   4B44 32 1B 4B      [13]   31     ld (millares), a
   4B47 21 1C 4B      [10]   32     ld hl, #diezmil
   4B4A 34            [11]   33     inc (hl)
   4B4B                      34 guarda:
   4B4B 3A 19 4B      [13]   35     ld  a, (decenas)
   4B4E CD 64 4B      [17]   36     call printdecena
   4B51 3A 1A 4B      [13]   37     ld  a, (centenas)
   4B54 CD 7C 4B      [17]   38     call printcentena
   4B57 3A 1B 4B      [13]   39     ld  a, (millares)
   4B5A CD 94 4B      [17]   40     call printmillares
   4B5D 3A 1C 4B      [13]   41     ld  a, (diezmil)
   4B60 CD AC 4B      [17]   42     call printdiezmil
                             43 
   4B63 C9            [10]   44     ret
                             45 
   4B64                      46 printdecena:
   4B64 C6 30         [ 7]   47     add #0x30                            ;; El codigo ASCII de '0'
   4B66 F5            [11]   48     push af
   4B67 21 02 00      [10]   49     ld hl, #0x0002
   4B6A CD 16 60      [17]   50     call cpct_setDrawCharM0_asm
   4B6D 11 00 C0      [10]   51     ld de, #0xC000
   4B70 01 43 5C      [10]   52     ld bc, #0x5C43
   4B73 CD 39 60      [17]   53     call cpct_getScreenPtr_asm
   4B76 F1            [10]   54     pop af
   4B77 5F            [ 4]   55     ld  e, a
   4B78 CD B8 5E      [17]   56     call cpct_drawCharM0_asm
   4B7B C9            [10]   57     ret
                             58 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



   4B7C                      59 printcentena:
   4B7C C6 30         [ 7]   60     add #0x30                            ;; El codigo ASCII de '0'
   4B7E F5            [11]   61     push af
   4B7F 21 02 00      [10]   62     ld hl, #0x0002
   4B82 CD 16 60      [17]   63     call cpct_setDrawCharM0_asm
   4B85 11 00 C0      [10]   64     ld de, #0xC000
   4B88 01 3F 5C      [10]   65     ld bc, #0x5C3F
   4B8B CD 39 60      [17]   66     call cpct_getScreenPtr_asm
   4B8E F1            [10]   67     pop af
   4B8F 5F            [ 4]   68     ld  e, a
   4B90 CD B8 5E      [17]   69     call cpct_drawCharM0_asm
   4B93 C9            [10]   70     ret
                             71 
   4B94                      72 printmillares:
   4B94 C6 30         [ 7]   73     add #0x30                            ;; El codigo ASCII de '0'
   4B96 F5            [11]   74     push af
   4B97 21 02 00      [10]   75     ld hl, #0x0002
   4B9A CD 16 60      [17]   76     call cpct_setDrawCharM0_asm
   4B9D 11 00 C0      [10]   77     ld de, #0xC000
   4BA0 01 3B 5C      [10]   78     ld bc, #0x5C3B
   4BA3 CD 39 60      [17]   79     call cpct_getScreenPtr_asm
   4BA6 F1            [10]   80     pop af
   4BA7 5F            [ 4]   81     ld  e, a
   4BA8 CD B8 5E      [17]   82     call cpct_drawCharM0_asm
   4BAB C9            [10]   83     ret
                             84 
   4BAC                      85 printdiezmil:
   4BAC C6 30         [ 7]   86     add #0x30                            ;; El codigo ASCII de '0'
   4BAE F5            [11]   87     push af
   4BAF 21 02 00      [10]   88     ld hl, #0x0002
   4BB2 CD 16 60      [17]   89     call cpct_setDrawCharM0_asm
   4BB5 11 00 C0      [10]   90     ld de, #0xC000
   4BB8 01 37 5C      [10]   91     ld bc, #0x5C37
   4BBB CD 39 60      [17]   92     call cpct_getScreenPtr_asm
   4BBE F1            [10]   93     pop af
   4BBF 5F            [ 4]   94     ld  e, a
   4BC0 CD B8 5E      [17]   95     call cpct_drawCharM0_asm
   4BC3 C9            [10]   96     ret
