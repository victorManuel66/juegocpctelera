                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module exploEnemyV1_3
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _explo3
                             12 ;--------------------------------------------------------
                             13 ; special function registers
                             14 ;--------------------------------------------------------
                             15 ;--------------------------------------------------------
                             16 ; ram data
                             17 ;--------------------------------------------------------
                             18 	.area _DATA
                             19 ;--------------------------------------------------------
                             20 ; ram data
                             21 ;--------------------------------------------------------
                             22 	.area _INITIALIZED
                             23 ;--------------------------------------------------------
                             24 ; absolute external ram data
                             25 ;--------------------------------------------------------
                             26 	.area _DABS (ABS)
                             27 ;--------------------------------------------------------
                             28 ; global & static initialisations
                             29 ;--------------------------------------------------------
                             30 	.area _HOME
                             31 	.area _GSINIT
                             32 	.area _GSFINAL
                             33 	.area _GSINIT
                             34 ;--------------------------------------------------------
                             35 ; Home
                             36 ;--------------------------------------------------------
                             37 	.area _HOME
                             38 	.area _HOME
                             39 ;--------------------------------------------------------
                             40 ; code
                             41 ;--------------------------------------------------------
                             42 	.area _CODE
                             43 	.area _CODE
   48E6                      44 _explo3:
   48E6 C0                   45 	.db #0xc0	; 192
   48E7 C0                   46 	.db #0xc0	; 192
   48E8 C0                   47 	.db #0xc0	; 192
   48E9 C0                   48 	.db #0xc0	; 192
   48EA C0                   49 	.db #0xc0	; 192
   48EB C0                   50 	.db #0xc0	; 192
   48EC D5                   51 	.db #0xd5	; 213
   48ED C0                   52 	.db #0xc0	; 192
   48EE EA                   53 	.db #0xea	; 234
   48EF C0                   54 	.db #0xc0	; 192
   48F0 C0                   55 	.db #0xc0	; 192
   48F1 C0                   56 	.db #0xc0	; 192
   48F2 C0                   57 	.db #0xc0	; 192
   48F3 C0                   58 	.db #0xc0	; 192
   48F4 C0                   59 	.db #0xc0	; 192
   48F5 D5                   60 	.db #0xd5	; 213
   48F6 C0                   61 	.db #0xc0	; 192
   48F7 EA                   62 	.db #0xea	; 234
   48F8 C0                   63 	.db #0xc0	; 192
   48F9 C0                   64 	.db #0xc0	; 192
   48FA C0                   65 	.db #0xc0	; 192
   48FB C0                   66 	.db #0xc0	; 192
   48FC C0                   67 	.db #0xc0	; 192
   48FD C0                   68 	.db #0xc0	; 192
                             69 	.area _INITIALIZER
                             70 	.area _CABS (ABS)
