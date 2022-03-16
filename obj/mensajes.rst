ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _CODE
                              2 
   4BC4                       3 gameover::
   4BC4 47 41 4D 45 20 4F     4     .ascii "GAME OVER"
        56 45 52
   4BCD 00                    5     .db 0
   4BCE                       6 new::
   4BCE 6E 65 77              7     .ascii "new"
   4BD1 00                    8     .db 0
   4BD2                       9 escore::
   4BD2 73 63 6F 72 65       10     .ascii "score"
   4BD7 00                   11     .db 0
   4BD8                      12 lives::
   4BD8 6C 69 76 65 73       13     .ascii "lives"
   4BDD 00                   14     .db 0
   4BDE                      15 writeMenu1::
   4BDE 31 2E 2D 20 50 6C    16     .ascii "1.- Play"
        61 79
   4BE6 00                   17     .db 0
   4BE7                      18 writeMenu2::
   4BE7 32 2E 2D 20 52 65    19     .ascii "2.- Redefine"
        64 65 66 69 6E 65
   4BF3 00                   20     .db 0
   4BF4                      21 writeMenu3::
   4BF4 33 2E 2D 20 4A 6F    22     .ascii "3.- Joystick"
        79 73 74 69 63 6B
   4C00 00                   23     .db 0
   4C01                      24 izqui::
   4C01 4C 65 66 74 20 20    25     .ascii "Left  :  "
        3A 20 20
   4C0A 00                   26     .db 0
   4C0B                      27 dere::
   4C0B 52 69 67 68 74 20    28     .ascii "Right : "
        3A 20
   4C13 00                   29     .db 0
   4C14                      30 fue::
   4C14 46 69 72 65 20 20    31     .ascii "Fire  : "
        3A 20
   4C1C 00                   32     .db 0
   4C1D                      33 puntos::
   4C1D 30 30 30 30 30       34     .ascii "00000"
   4C22 00                   35     .db 0
                             36 
