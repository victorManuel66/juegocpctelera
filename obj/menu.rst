ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _CODE
                              2 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              3 .include "video/video_macros.h.s"
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
                             18 
                             19 ;;//////////////////////////////////////////////////////////////////////
                             20 ;;//////////////////////////////////////////////////////////////////////
                             21 ;; File: Macros (asm)
                             22 ;;//////////////////////////////////////////////////////////////////////
                             23 ;;//////////////////////////////////////////////////////////////////////
                             24 
                             25 ;;//////////////////////////////////////////////////////////////////////
                             26 ;; Group: Video memory manipulation
                             27 ;;//////////////////////////////////////////////////////////////////////
                             28 
                             29 ;;
                             30 ;; Constant: CPCT_VMEM_START_ASM
                             31 ;;
                             32 ;;    The address where screen video memory starts by default in the Amstrad CPC.
                             33 ;;
                             34 ;;    This address is exactly 0xC000, and this macro represents this number but
                             35 ;; automatically converted to <u8>* (Pointer to unsigned byte). You can use this
                             36 ;; macro for any function requiring the start of video memory, like 
                             37 ;; <cpct_getScreenPtr>.
                             38 ;;
                     C000    39 CPCT_VMEM_START_ASM = 0xC000
                             40 
                             41 ;;
                             42 ;; Constants: Video Memory Pages
                             43 ;;
                             44 ;; Useful constants defining some typical Video Memory Pages to be used as 
                             45 ;; parameters for <cpct_setVideoMemoryPage>
                             46 ;;
                             47 ;; cpct_pageCO - Video Memory Page 0xC0 (0xC0··)
                             48 ;; cpct_page8O - Video Memory Page 0x80 (0x80··)
                             49 ;; cpct_page4O - Video Memory Page 0x40 (0x40··)
                             50 ;; cpct_page0O - Video Memory Page 0x00 (0x00··)
                             51 ;;
                     0030    52 cpct_pageC0_asm = 0x30
                     0020    53 cpct_page80_asm = 0x20
                     0010    54 cpct_page40_asm = 0x10
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                     0000    55 cpct_page00_asm = 0x00
                             56 
                             57 ;;
                             58 ;; Macro: cpctm_memPage6_asm
                             59 ;;
                             60 ;;    Macro that encodes a video memory page in the 6 Least Significant bits (LSb)
                             61 ;; of a byte, required as parameter for <cpct_setVideoMemoryPage>. It loads resulting
                             62 ;; value into a given 8-bits register.
                             63 ;;
                             64 ;; ASM Definition:
                             65 ;; .macro <cpct_memPage6_asm> *REG8*, *PAGE*
                             66 ;;
                             67 ;; Parameters (1 byte):
                             68 ;; (__) REG8 - 8bits register where result will be loaded
                             69 ;; (1B) PAGE - Video memory page wanted 
                             70 ;;
                             71 ;; Known issues:
                             72 ;;   * This macro can only be used from assembler code. It is not accessible from 
                             73 ;; C scope. For C programs, please refer to <cpct_memPage6>
                             74 ;;   * This macro will work *only* with constant values, as its value needs to
                             75 ;; be calculated in compilation time. If fed with variable values, it will give 
                             76 ;; an assembler error.
                             77 ;;
                             78 ;; Destroyed Registers:
                             79 ;;    REG8
                             80 ;;
                             81 ;; Size of generated code:
                             82 ;;    2 bytes 
                             83 ;;
                             84 ;; Time Measures:
                             85 ;;    * 2 microseconds
                             86 ;;    * 8 CPU Cycles
                             87 ;;
                             88 ;; Details:
                             89 ;;  This is just a macro that shifts *PAGE* 2 bits to the right, to leave it
                             90 ;; with just 6 significant bits. For more information, check functions
                             91 ;; <cpct_setVideoMemoryPage> and <cpct_setVideoMemoryOffset>.
                             92 ;;
                             93 .macro cpctm_memPage6_asm REG8, PAGE 
                             94    ld REG8, #PAGE / 4      ;; [2] REG8 = PAGE/4
                             95 .endm
                             96 
                             97 ;;
                             98 ;; Macro: cpctm_screenPtr_asm
                             99 ;;
                            100 ;;    Macro that calculates the video memory location (byte pointer) of a 
                            101 ;; given pair of coordinates (*X*, *Y*). Value resulting from calculation 
                            102 ;; will be loaded into a 16-bits register.
                            103 ;;
                            104 ;; ASM Definition:
                            105 ;;    .macro <cpctm_screenPtr_asm> *REG16*, *VMEM*, *X*, *Y*
                            106 ;;
                            107 ;; Parameters:
                            108 ;;    (__) REG16 - 16-bits register where the resulting value will be loaded
                            109 ;;    (2B) VMEM  - Start of video memory buffer where (*X*, *Y*) coordinates will be calculated
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                            110 ;;    (1B) X     - X Coordinate of the video memory location *in bytes* (*BEWARE! NOT in pixels!*)
                            111 ;;    (1B) Y     - Y Coordinate of the video memory location in pixels / bytes (they are same amount)
                            112 ;;
                            113 ;; Parameter Restrictions:
                            114 ;;    * *REG16* has to be a 16-bits register that can perform ld REG16, #value.
                            115 ;;    * *VMEM* will normally be the start of the video memory buffer where you want to 
                            116 ;; draw something. It could theoretically be any 16-bits value. 
                            117 ;;    * *X* must be in the range [0-79] for normal screen sizes (modes 0,1,2). Screen is
                            118 ;; always 80 bytes wide in these modes and this function is byte-aligned, so you have to 
                            119 ;; give it a byte coordinate (*NOT a pixel one!*).
                            120 ;;    * *Y* must be in the range [0-199] for normal screen sizes (modes 0,1,2). Screen is 
                            121 ;; always 200 pixels high in these modes. Pixels and bytes always coincide in vertical
                            122 ;; resolution, so this coordinate is the same in bytes that in pixels.
                            123 ;;    * If you give incorrect values to this function, the returned pointer could
                            124 ;; point anywhere in memory. This function will not cause any damage by itself, 
                            125 ;; but you may destroy important parts of your memory if you use its result to 
                            126 ;; write to memory, and you gave incorrect parameters by mistake. Take always
                            127 ;; care.
                            128 ;;
                            129 ;; Known issues:
                            130 ;;   * This macro can only be used from assembler code. It is not accessible from 
                            131 ;; C scope. For C programs, please refer to <cpct_getScreenPtr>
                            132 ;;   * This macro will work *only* with constant values, as calculations need to be 
                            133 ;; performed at assembler time.
                            134 ;;
                            135 ;; Destroyed Registers:
                            136 ;;    REG16
                            137 ;;
                            138 ;; Size of generated code:
                            139 ;;    3 bytes 
                            140 ;;
                            141 ;; Time Measures:
                            142 ;;    * 3 microseconds
                            143 ;;    * 12 CPU Cycles
                            144 ;;
                            145 ;; Details:
                            146 ;;    This macro does the same calculation than the function <cpct_getScreenPtr>. However,
                            147 ;; as it is a macro, if all 3 parameters (*VMEM*, *X*, *Y*) are constants, the calculation
                            148 ;; will be done at compile-time. This will free the binary from code or data, just putting in
                            149 ;; the result of this calculation (2 bytes with the resulting address). It is highly 
                            150 ;; recommended to use this macro instead of the function <cpct_getScreenPtr> when values
                            151 ;; involved are all constant. 
                            152 ;;
                            153 ;; Recommendations:
                            154 ;;    All constant values - Use this macro <cpctm_screenPtr_asm>
                            155 ;;    Any variable value  - Use the function <cpct_getScreenPtr>
                            156 ;;
                            157 .macro cpctm_screenPtr_asm REG16, VMEM, X, Y 
                            158    ld REG16, #VMEM + 80 * (Y / 8) + 2048 * (Y & 7) + X   ;; [3] REG16 = screenPtr
                            159 .endm
                            160 
                            161 ;;
                            162 ;; Macro: cpctm_screenPtrSym_asm
                            163 ;;
                            164 ;;    Macro that calculates the video memory location (byte pointer) of a 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                            165 ;; given pair of coordinates (*X*, *Y*). Value resulting from calculation 
                            166 ;; will be assigned to the given ASZ80 local symbol.
                            167 ;;
                            168 ;; ASM Definition:
                            169 ;;    .macro <cpctm_screenPtr_asm> *SYM*, *VMEM*, *X*, *Y*
                            170 ;;
                            171 ;; Parameters:
                            172 ;;    (__) SYM   - ASZ80 local symbol to assign the result from the calculation to
                            173 ;;    (2B) VMEM  - Start of video memory buffer where (*X*, *Y*) coordinates will be calculated
                            174 ;;    (1B) X     - X Coordinate of the video memory location *in bytes* (*BEWARE! NOT in pixels!*)
                            175 ;;    (1B) Y     - Y Coordinate of the video memory location in pixels / bytes (they are same amount)
                            176 ;;
                            177 ;; Parameter Restrictions:
                            178 ;;    * *SYM* need to be a valid symbol according to ASZ80 rules for symbols
                            179 ;;    * *VMEM* will normally be the start of the video memory buffer where you want to 
                            180 ;; draw something. It could theoretically be any 16-bits value. 
                            181 ;;    * *X* must be in the range [0-79] for normal screen sizes (modes 0,1,2). Screen is
                            182 ;; always 80 bytes wide in these modes and this function is byte-aligned, so you have to 
                            183 ;; give it a byte coordinate (*NOT a pixel one!*).
                            184 ;;    * *Y* must be in the range [0-199] for normal screen sizes (modes 0,1,2). Screen is 
                            185 ;; always 200 pixels high in these modes. Pixels and bytes always coincide in vertical
                            186 ;; resolution, so this coordinate is the same in bytes that in pixels.
                            187 ;;    * If you give incorrect values to this function, the returned pointer could
                            188 ;; point anywhere in memory. This function will not cause any damage by itself, 
                            189 ;; but you may destroy important parts of your memory if you use its result to 
                            190 ;; write to memory, and you gave incorrect parameters by mistake. Take always
                            191 ;; care.
                            192 ;;
                            193 ;; Known issues:
                            194 ;;   * This macro can only be used from assembler code. It is not accessible from 
                            195 ;; C scope. For C programs, please refer to <cpct_getScreenPtr>
                            196 ;;   * This macro will work *only* with constant values, as calculations need to be 
                            197 ;; performed at assembler time.
                            198 ;;
                            199 ;; Destroyed Registers:
                            200 ;;    none
                            201 ;;
                            202 ;; Size of generated code:
                            203 ;;    none (symbols are compile-time, do not generate code)
                            204 ;;
                            205 ;; Time Measures:
                            206 ;;    - not applicable -
                            207 ;;
                            208 ;; Details:
                            209 ;;    This macro does the same calculation than the function <cpct_getScreenPtr>. However,
                            210 ;; as it is a macro, and as its parameters (*VMEM*, *X*, *Y*) must be constants, the calculation
                            211 ;; will be performed at compile-time. This will free the binary from code or data, just putting in
                            212 ;; the result of this calculation (2 bytes with the resulting address). It is highly 
                            213 ;; recommended to use this macro instead of the function <cpct_getScreenPtr> when values
                            214 ;; involved are all constant. 
                            215 ;;
                            216 ;; Recommendations:
                            217 ;;    All constant values - Use this macro <cpctm_screenPtrSym_asm> or <cpctm_screenPtr_asm> 
                            218 ;;    Any variable value  - Use the function <cpct_getScreenPtr>
                            219 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            220 .macro cpctm_screenPtrSym_asm SYM, VMEM, X, Y 
                            221    SYM = #VMEM + 80 * (Y / 8) + 2048 * (Y & 7) + X 
                            222 .endm
                            223 
                            224 ;;
                            225 ;; Macro: cpctm_setCRTCReg
                            226 ;;
                            227 ;;    Macro that sets a new value for a given CRTC register.
                            228 ;;
                            229 ;; ASM Definition:
                            230 ;;    .macro <cpctm_setCRTCReg> *HEXREG*, *HEXVAL*
                            231 ;;
                            232 ;; Parameters:
                            233 ;;    (1B) HEXREG - New value to be set for the register (in hexadecimal)
                            234 ;;    (1B) HEXVAL - Number of the register to be set (in hexadecimal)
                            235 ;;
                            236 ;; Parameter Restrictions:
                            237 ;;    * *HEXREG* has to be an hexadecimal value from 00 to 1F
                            238 ;;    * *HEXVAL* has to be an hexadecimal value. Its valid range will depend
                            239 ;;          upon the selected register that will be modified. 
                            240 ;;
                            241 ;; Known issues:
                            242 ;;   * This macro can *only* be used from assembler code. It is not accessible from 
                            243 ;; C scope. 
                            244 ;;   * This macro can only be used with *constant values*. As given values are 
                            245 ;; concatenated with a number, they must also be hexadecimal numbers. If a 
                            246 ;; register or other value is given, this macro will not work.
                            247 ;;   * Using values out of range have unpredicted behaviour and can even 
                            248 ;; potentially cause damage to real Amstrad CPC monitors. Please, use with care.
                            249 ;;
                            250 ;; Destroyed Registers:
                            251 ;;    BC
                            252 ;;
                            253 ;; Size of generated code:
                            254 ;;    10 bytes 
                            255 ;;
                            256 ;; Time Measures:
                            257 ;;    * 14 microseconds
                            258 ;;    * 56 CPU Cycles
                            259 ;;
                            260 ;; Details:
                            261 ;;    This macro expands to two CRTC commands: Register selection and Register setting.
                            262 ;; It selects the register given as first parameter, then sets its new value to 
                            263 ;; that given as second parameter. Both given parameters must be of exactly 1 byte
                            264 ;; in size and the have to be provided in hexadecimal. This is due to the way
                            265 ;; that macro expansion and concatenation works. Given values will be concatenated
                            266 ;; with another 8-bit hexadecimal value to form a unique 16-bits hexadecimal value.
                            267 ;; Therefore, any parameter given will always be considered hexadecimal.
                            268 ;;
                            269 .macro cpctm_setCRTCReg_asm HEXREG, HEXVAL
                            270    ld    bc, #0xBC'HEXREG  ;; [3] B=0xBC CRTC Select Register, C=register number to be selected
                            271    out  (c), c             ;; [4] Select register
                            272    ld    bc, #0xBD'HEXVAL  ;; [3] B=0xBD CRTC Set Register, C=Value to be set
                            273    out  (c), c             ;; [4] Set the value
                            274 .endm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            275 
                            276 ;;//////////////////////////////////////////////////////////////////////
                            277 ;; Group: Setting the border
                            278 ;;//////////////////////////////////////////////////////////////////////
                            279 
                            280 ;;
                            281 ;; Macro: cpctm_setBorder_asm
                            282 ;;
                            283 ;;   Changes the colour of the screen border.
                            284 ;;
                            285 ;; ASM Definition:
                            286 ;;   .macro <cpctm_setBorder_asm> HWC 
                            287 ;;
                            288 ;; Input Parameters (1 Byte):
                            289 ;;   (1B) HWC - Hardware colour value for the screen border in *hexadecimal [00-1B]*.
                            290 ;;
                            291 ;; Known issues:
                            292 ;;   * *Beware!* *HWC* colour value must be given in *hexadecimal*, as it is
                            293 ;; substituted in place, and must be in the range [00-1B].
                            294 ;;   * This macro can only be used from assembler code. It is not accessible from 
                            295 ;; C scope. For C programs, please refer to <cpct_setBorder>
                            296 ;;   * This macro will work *only* with constant values, as calculations need to be 
                            297 ;; performed at assembler time.
                            298 ;;
                            299 ;; Destroyed Registers:
                            300 ;;    AF, B, HL
                            301 ;;
                            302 ;; Size of generated code:
                            303 ;;    * 16 bytes 
                            304 ;;     6b - generated code
                            305 ;;    10b - cpct_setPALColour_asm code
                            306 ;;
                            307 ;; Time Measures:
                            308 ;;    * 28 microseconds
                            309 ;;    * 112 CPU Cycles
                            310 ;;
                            311 ;; Details:
                            312 ;;   This is not a real function, but an assembler macro. Beware of using it along
                            313 ;; with complex expressions or calculations, as it may expand in non-desired
                            314 ;; ways.
                            315 ;;
                            316 ;;   For more information, check the real function <cpct_setPALColour>, which
                            317 ;; is called when using <cpctm_setBorder_asm> (It is called using 16 as *pen*
                            318 ;; argument, which identifies the border).
                            319 ;;
                            320 .macro cpctm_setBorder_asm HWC
                            321    .radix h
                            322    cpctm_setBorder_raw_asm \HWC ;; [28] Macro that does the job, but requires a number value to be passed
                            323    .radix d
                            324 .endm
                            325 .macro cpctm_setBorder_raw_asm HWC
                            326    .globl cpct_setPALColour_asm
                            327    ld   hl, #0x'HWC'10         ;; [3]  H=Hardware value of desired colour, L=Border INK (16)
                            328    call cpct_setPALColour_asm  ;; [25] Set Palette colour of the border
                            329 .endm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            330 
                            331 ;;//////////////////////////////////////////////////////////////////////
                            332 ;; Group: Screen clearing
                            333 ;;//////////////////////////////////////////////////////////////////////
                            334 
                            335 ;;
                            336 ;; Macro: cpctm_clearScreen_asm
                            337 ;;
                            338 ;;    Macro to simplify clearing the screen.
                            339 ;;
                            340 ;; ASM Definition:
                            341 ;;   .macro <cpctm_clearScreen_asm> COL
                            342 ;;
                            343 ;; Input Parameters (1 byte):
                            344 ;;   (1B) COL - Colour pattern to be used for screen clearing. 
                            345 ;;
                            346 ;; Parameters:
                            347 ;;    *COL* - Any 8-bits value or the A register are valid. Typically, a 0x00 is used 
                            348 ;; to fill up all the screen with 0's (firmware colour 0). However, you may use it in 
                            349 ;; combination with <cpct_px2byteM0>, <cpct_px2byteM1> or a manually created colour pattern.
                            350 ;;
                            351 ;; Known issues:
                            352 ;;   * This macro can only be used from assembler code. It is not accessible from 
                            353 ;; C scope. For C programs, please refer to <cpct_clearScreen>
                            354 ;;
                            355 ;; Details:
                            356 ;;   Fills up all the standard screen (range [0xC000-0xFFFF]) with *COL* byte, the colour 
                            357 ;; pattern given.
                            358 ;;
                            359 ;; Destroyed Registers:
                            360 ;;    BC, DE, HL
                            361 ;;
                            362 ;; Size of generated code:
                            363 ;;    13 bytes 
                            364 ;;
                            365 ;; Time Measures:
                            366 ;;    98309 microseconds (*4.924 VSYNCs* on a 50Hz display).
                            367 ;;    393236 CPU Cycles 
                            368 ;;
                            369 .macro cpctm_clearScreen_asm COL
                            370    ld    hl, #0xC000    ;; [3] HL Points to Start of Video Memory
                            371    ld    de, #0xC001    ;; [3] DE Points to the next byte
                            372    ld    bc, #(0x4000-1);; [3] BC = 16383 bytes to be copied
                            373    ld   (hl), #COL      ;; [3] First Byte = given Colour
                            374    ldir                 ;; [98297] Perform the copy
                            375 .endm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                              4 .include "video/colours.h.s"
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
                             18 
                             19 ;;//////////////////////////////////////////////////////////////////////
                             20 ;;//////////////////////////////////////////////////////////////////////
                             21 ;; File: Colours (asm)
                             22 ;;//////////////////////////////////////////////////////////////////////
                             23 ;;//////////////////////////////////////////////////////////////////////
                             24 ;;
                             25 ;;    Constants and utilities to manage the 27 colours from
                             26 ;; the CPC Palette comfortably in assembler.
                             27 ;;
                             28 ;;
                             29 
                             30 ;; Constant: Firmware colour values
                             31 ;;
                             32 ;;    Enumerates all 27 firmware colours for assembler programs
                             33 ;;
                             34 ;; Values:
                             35 ;; (start code)
                             36 ;;   [=================================================]
                             37 ;;   | Identifier        | Val| Identifier        | Val|
                             38 ;;   |-------------------------------------------------|
                             39 ;;   | FW_BLACK          |  0 | FW_BLUE           |  1 |
                             40 ;;   | FW_BRIGHT_BLUE    |  2 | FW_RED            |  3 |
                             41 ;;   | FW_MAGENTA        |  4 | FW_MAUVE          |  5 |
                             42 ;;   | FW_BRIGHT_RED     |  6 | FW_PURPLE         |  7 |
                             43 ;;   | FW_BRIGHT_MAGENTA |  8 | FW_GREEN          |  9 |
                             44 ;;   | FW_CYAN           | 10 | FW_SKY_BLUE       | 11 |
                             45 ;;   | FW_YELLOW         | 12 | FW_WHITE          | 13 |
                             46 ;;   | FW_PASTEL_BLUE    | 14 | FW_ORANGE         | 15 |
                             47 ;;   | FW_PINK           | 16 | FW_PASTEL_MAGENTA | 17 |
                             48 ;;   | FW_BRIGHT_GREEN   | 18 | FW_SEA_GREEN      | 19 |
                             49 ;;   | FW_BRIGHT_CYAN    | 20 | FW_LIME           | 21 |
                             50 ;;   | FW_PASTEL_GREEN   | 22 | FW_PASTEL_CYAN    | 23 |
                             51 ;;   | FW_BRIGHT_YELLOW  | 24 | FW_PASTEL_YELLOW  | 25 |
                             52 ;;   | FW_BRIGHT_WHITE   | 26 |                   |    |
                             53 ;;   [=================================================]
                             54 ;; (end code)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                             55 
                     0000    56 FW_BLACK          =  0
                     0001    57 FW_BLUE           =  1
                     0002    58 FW_BRIGHT_BLUE    =  2
                     0003    59 FW_RED            =  3
                     0004    60 FW_MAGENTA        =  4
                     0005    61 FW_MAUVE          =  5
                     0006    62 FW_BRIGHT_RED     =  6
                     0007    63 FW_PURPLE         =  7
                     0008    64 FW_BRIGHT_MAGENTA =  8
                     0009    65 FW_GREEN          =  9
                     000A    66 FW_CYAN           = 10
                     000B    67 FW_SKY_BLUE       = 11
                     000C    68 FW_YELLOW         = 12
                     000D    69 FW_WHITE          = 13
                     000E    70 FW_PASTEL_BLUE    = 14
                     000F    71 FW_ORANGE         = 15
                     0010    72 FW_PINK           = 16
                     0011    73 FW_PASTEL_MAGENTA = 17
                     0012    74 FW_BRIGHT_GREEN   = 18
                     0013    75 FW_SEA_GREEN      = 19
                     0014    76 FW_BRIGHT_CYAN    = 20
                     0015    77 FW_LIME           = 21
                     0016    78 FW_PASTEL_GREEN   = 22
                     0017    79 FW_PASTEL_CYAN    = 23
                     0018    80 FW_BRIGHT_YELLOW  = 24
                     0019    81 FW_PASTEL_YELLOW  = 25
                     001A    82 FW_BRIGHT_WHITE   = 26
                             83 
                             84 ;; Constant: Hardware colour values
                             85 ;;
                             86 ;;    Enumerates all 27 hardware colours for assembler programs
                             87 ;;
                             88 ;; Values:
                             89 ;; (start code)
                             90 ;;   [=====================================================]
                             91 ;;   | Identifier        | Value| Identifier        | Value|
                             92 ;;   |-----------------------------------------------------|
                             93 ;;   | HW_BLACK          | 0x14 | HW_BLUE           | 0x04 |
                             94 ;;   | HW_BRIGHT_BLUE    | 0x15 | HW_RED            | 0x1C |
                             95 ;;   | HW_MAGENTA        | 0x18 | HW_MAUVE          | 0x1D |
                             96 ;;   | HW_BRIGHT_RED     | 0x0C | HW_PURPLE         | 0x05 |
                             97 ;;   | HW_BRIGHT_MAGENTA | 0x0D | HW_GREEN          | 0x16 |
                             98 ;;   | HW_CYAN           | 0x06 | HW_SKY_BLUE       | 0x17 |
                             99 ;;   | HW_YELLOW         | 0x1E | HW_WHITE          | 0x00 |
                            100 ;;   | HW_PASTEL_BLUE    | 0x1F | HW_ORANGE         | 0x0E |
                            101 ;;   | HW_PINK           | 0x07 | HW_PASTEL_MAGENTA | 0x0F |
                            102 ;;   | HW_BRIGHT_GREEN   | 0x12 | HW_SEA_GREEN      | 0x02 |
                            103 ;;   | HW_BRIGHT_CYAN    | 0x13 | HW_LIME           | 0x1A |
                            104 ;;   | HW_PASTEL_GREEN   | 0x19 | HW_PASTEL_CYAN    | 0x1B |
                            105 ;;   | HW_BRIGHT_YELLOW  | 0x0A | HW_PASTEL_YELLOW  | 0x03 |
                            106 ;;   | HW_BRIGHT_WHITE   | 0x0B |                   |      |
                            107 ;;   [=====================================================]
                            108 ;; (end code)
                            109 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                     0014   110 HW_BLACK          = 0x14
                     0004   111 HW_BLUE           = 0x04
                     0015   112 HW_BRIGHT_BLUE    = 0x15
                     001C   113 HW_RED            = 0x1C
                     0018   114 HW_MAGENTA        = 0x18
                     001D   115 HW_MAUVE          = 0x1D
                     000C   116 HW_BRIGHT_RED     = 0x0C
                     0005   117 HW_PURPLE         = 0x05
                     000D   118 HW_BRIGHT_MAGENTA = 0x0D
                     0016   119 HW_GREEN          = 0x16
                     0006   120 HW_CYAN           = 0x06
                     0017   121 HW_SKY_BLUE       = 0x17
                     001E   122 HW_YELLOW         = 0x1E
                     0000   123 HW_WHITE          = 0x00
                     001F   124 HW_PASTEL_BLUE    = 0x1F
                     000E   125 HW_ORANGE         = 0x0E
                     0007   126 HW_PINK           = 0x07
                     000F   127 HW_PASTEL_MAGENTA = 0x0F
                     0012   128 HW_BRIGHT_GREEN   = 0x12
                     0002   129 HW_SEA_GREEN      = 0x02
                     0013   130 HW_BRIGHT_CYAN    = 0x13
                     001A   131 HW_LIME           = 0x1A
                     0019   132 HW_PASTEL_GREEN   = 0x19
                     001B   133 HW_PASTEL_CYAN    = 0x1B
                     000A   134 HW_BRIGHT_YELLOW  = 0x0A
                     0003   135 HW_PASTEL_YELLOW  = 0x03
                     000B   136 HW_BRIGHT_WHITE   = 0x0B
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                              6 .include "mensajes.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                              7 .include "keyboard/keyboard.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



                     0109   165 Joy0_Up          = #0x0109
                     0209   166 Joy0_Down        = #0x0209
                     0409   167 Joy0_Left        = #0x0409
                     0809   168 Joy0_Right       = #0x0809
                     1009   169 Joy0_Fire1       = #0x1009
                     2009   170 Joy0_Fire2       = #0x2009
                     4009   171 Joy0_Fire3       = #0x4009
                     8009   172 Key_Del          = #0x8009
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



                              8 .include "Player.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



                              9 
                             10 .globl _cpct_keyboardStatusBuffer           ;; Array que contiene el estado del teclado
                             11 
   4FC7                      12 menu::
   0000                      13     cpctm_clearScreen_asm 0x00              ;; Borra la pantalla
   4FC7 21 00 C0      [10]    1    ld    hl, #0xC000    ;; [3] HL Points to Start of Video Memory
   4FCA 11 01 C0      [10]    2    ld    de, #0xC001    ;; [3] DE Points to the next byte
   4FCD 01 FF 3F      [10]    3    ld    bc, #(0x4000-1);; [3] BC = 16383 bytes to be copied
   4FD0 36 00         [10]    4    ld   (hl), #0x00      ;; [3] First Byte = given Colour
   4FD2 ED B0         [21]    5    ldir                 ;; [98297] Perform the copy
   000D                      14     cpctm_setBorder_asm HW_BLACK            ;; Borde de la pantalla a negro
                              1    .radix h
   000D                       2    cpctm_setBorder_raw_asm \HW_BLACK ;; [28] Macro that does the job, but requires a number value to be passed
                              1    .globl cpct_setPALColour_asm
   4FD4 21 10 14      [10]    2    ld   hl, #0x1410         ;; [3]  H=Hardware value of desired colour, L=Border INK (16)
   4FD7 CD CB 54      [17]    3    call cpct_setPALColour_asm  ;; [25] Set Palette colour of the border
                              3    .radix d
                             15 
   4FDA 21 06 00      [10]   16     ld hl, #0x0006
   4FDD CD 16 60      [17]   17     call cpct_setDrawCharM0_asm             ;; Establecer color del fondo y de la pluma
                             18 
   4FE0 11 00 C0      [10]   19     ld de, #0xC000
   4FE3 01 0F 4C      [10]   20     ld bc, #0x4C0F                          ;; Coordenada Y en B, coordenada X en C
   4FE6 CD 39 60      [17]   21     call cpct_getScreenPtr_asm
                             22 
   4FE9 FD 21 DE 4B   [14]   23     ld iy, #writeMenu1                      ;; Dirección del texto
   4FED CD FE 5C      [17]   24     call cpct_drawStringM0_asm              ;; Escribe
                             25 
   4FF0 11 00 C0      [10]   26     ld de, #0xC000
   4FF3 01 0F 55      [10]   27     ld bc, #0x550F                          ;; Coordenada Y en B, coordenada X en C
   4FF6 CD 39 60      [17]   28     call cpct_getScreenPtr_asm
                             29 
   4FF9 FD 21 E7 4B   [14]   30     ld iy, #writeMenu2                      ;; Dirección del texto
   4FFD CD FE 5C      [17]   31     call cpct_drawStringM0_asm              ;; Escribe
                             32 
   5000 11 00 C0      [10]   33     ld de, #0xC000
   5003 01 0F 5E      [10]   34     ld bc, #0x5E0F                          ;; Coordenada Y en B, coordenada X en C
   5006 CD 39 60      [17]   35     call cpct_getScreenPtr_asm
                             36 
   5009 FD 21 F4 4B   [14]   37     ld iy, #writeMenu3                      ;; Dirección del texto
   500D CD FE 5C      [17]   38     call cpct_drawStringM0_asm              ;; Escribe
                             39 
   5010                      40 cont:
   5010 CD 4D 60      [17]   41     call cpct_scanKeyboard_asm              ;; Escanea el teclado
                             42 
   5013 21 08 01      [10]   43     ld hl, #Key_1
   5016 CD BF 54      [17]   44     call cpct_isKeyPressed_asm
   5019 20 12         [12]   45     jr  nz, Pulsado1
   501B 21 08 02      [10]   46     ld hl, #Key_2
   501E CD BF 54      [17]   47     call cpct_isKeyPressed_asm
   5021 20 0D         [12]   48     jr  nz, Pulsado2
   5023 21 07 02      [10]   49     ld hl, #Key_3
   5026 CD BF 54      [17]   50     call cpct_isKeyPressed_asm
   5029 20 0A         [12]   51     jr  nz, Pulsado3
   502B 18 E3         [12]   52     jr  cont
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 20.
Hexadecimal [16-Bits]



   502D                      53 Pulsado1:
   502D 3E 01         [ 7]   54     ld  a, #0x01
   502F C9            [10]   55     ret
   5030                      56 Pulsado2:
   5030 CD 4D 60      [17]   57     call cpct_scanKeyboard_asm                 ;; Para resetear el teclado
   5033 18 13         [12]   58     jr redefine
   5035                      59 Pulsado3:
                             60     ;; Asignar izquierda
   5035 21 09 04      [10]   61     ld hl, #Joy0_Left
   5038 22 92 49      [16]   62     ld (TeclaIz), hl
   503B 21 09 08      [10]   63     ld hl, #Joy0_Right
   503E 22 90 49      [16]   64     ld (TeclaDe), hl
   5041 21 09 10      [10]   65     ld hl, #Joy0_Fire1
   5044 22 94 49      [16]   66     ld (TeclaDi), hl
   5047 C9            [10]   67     ret
                             68 
   5048                      69 redefine:
   0081                      70     cpctm_clearScreen_asm 0x00              ;; Borra la pantalla
   5048 21 00 C0      [10]    1    ld    hl, #0xC000    ;; [3] HL Points to Start of Video Memory
   504B 11 01 C0      [10]    2    ld    de, #0xC001    ;; [3] DE Points to the next byte
   504E 01 FF 3F      [10]    3    ld    bc, #(0x4000-1);; [3] BC = 16383 bytes to be copied
   5051 36 00         [10]    4    ld   (hl), #0x00      ;; [3] First Byte = given Colour
   5053 ED B0         [21]    5    ldir                 ;; [98297] Perform the copy
                             71 
   5055 11 00 C0      [10]   72     ld de, #0xC000
   5058 01 0A 4C      [10]   73     ld bc, #0x4C0A
   505B CD 39 60      [17]   74     call cpct_getScreenPtr_asm
                             75 
   505E FD 21 01 4C   [14]   76     ld iy, #izqui                     ;; Dirección del texto
   5062 CD FE 5C      [17]   77     call cpct_drawStringM0_asm        ;; Escribe
   5065                      78 keyleft:
   5065 CD F1 50      [17]   79     call delay
   5068 CD 4D 60      [17]   80     call cpct_scanKeyboard_asm        ;; Escaneo el teclado
   506B CD FA 5E      [17]   81     call cpct_isAnyKeyPressed_asm
   506E 28 F5         [12]   82     jr z, keyleft
   5070 CD F7 50      [17]   83     call drawKey                      ;; Localiza la tecla que ha pulsado el usuario
   5073 22 92 49      [16]   84     ld (TeclaIz), hl                  ;; HL contiene el cpct_keyID
   5076 D5            [11]   85     push  de                          ;; Preservar el valor devuelto por drawKey
   5077 11 00 C0      [10]   86     ld de, #0xC000
   507A 01 26 4C      [10]   87     ld bc, #0x4C26
   507D CD 39 60      [17]   88     call cpct_getScreenPtr_asm        ;; Hace un locate 
   5080 01 06 00      [10]   89     ld  bc, #0x0006
   5083 D1            [10]   90     pop  de                           ;; Recuperar de la pila el caracter devuelto por drawKeyLeft
   5084 CD B8 5E      [17]   91     call cpct_drawCharM0_asm          ;; Imprime la tecla
                             92 
                             93     
   5087 11 00 C0      [10]   94     ld de, #0xC000
   508A 01 0A 55      [10]   95     ld bc, #0x550A
   508D CD 39 60      [17]   96     call cpct_getScreenPtr_asm
   5090 FD 21 0B 4C   [14]   97     ld iy, #dere                      ;; Dirección del texto
   5094 CD FE 5C      [17]   98     call cpct_drawStringM0_asm        ;; Escribe
   5097 CD F1 50      [17]   99     call delay                        ;; Para que a scanKeyBoard no sea tan rápido
                            100 
   509A                     101 keyright:
   509A CD 4D 60      [17]  102     call cpct_scanKeyboard_asm        ;; Escaneo el teclado
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 21.
Hexadecimal [16-Bits]



   509D CD FA 5E      [17]  103     call cpct_isAnyKeyPressed_asm
   50A0 28 F8         [12]  104     jr  z, keyright
   50A2 CD F7 50      [17]  105     call drawKey                      ;; Localiza la tecla que ha pulsado el usuario
   50A5 22 90 49      [16]  106     ld (TeclaDe), hl                  ;; HL contiene el cpct_keyID
   50A8 D5            [11]  107     push de                           ;; Preservar el valor devuelto por drawKey
   50A9 11 00 C0      [10]  108     ld de, #0xC000
   50AC 01 26 54      [10]  109     ld bc, #0x5426
   50AF CD 39 60      [17]  110     call cpct_getScreenPtr_asm        ;; Hace un locate 
   50B2 01 06 00      [10]  111     ld  bc, #0x0006
   50B5 D1            [10]  112     pop  de                           ;; Recuperar de la pila el caracter devuelto por drawKeyLeft
   50B6 CD B8 5E      [17]  113     call cpct_drawCharM0_asm          ;; Imprime la tecla
   50B9 CD F1 50      [17]  114     call delay                        ;; Para que a scanKeyBoard no sea tan rápido
                            115 
   50BC 11 00 C0      [10]  116     ld de, #0xC000
   50BF 01 0A 5E      [10]  117     ld bc, #0x5E0A
   50C2 CD 39 60      [17]  118     call cpct_getScreenPtr_asm
   50C5 FD 21 14 4C   [14]  119     ld iy, #fue                       ;; Dirección del texto
   50C9 CD FE 5C      [17]  120     call cpct_drawStringM0_asm        ;; Escribe
   50CC                     121 keyfire:
                            122     ;call delay                        ;; Para que a scanKeyBoard no sea tan rápido
   50CC CD 4D 60      [17]  123     call cpct_scanKeyboard_asm        ;; Escaneo el teclado
   50CF CD FA 5E      [17]  124     call cpct_isAnyKeyPressed_asm
   50D2 28 F8         [12]  125     jr  z, keyfire
   50D4 CD F7 50      [17]  126     call drawKey                      ;; Localiza la tecla que ha pulsado el usuario
   50D7 22 94 49      [16]  127     ld (TeclaDi), hl                  ;; HL contiene el cpct_keyID
   50DA D5            [11]  128     push de                           ;; Preservar el valor devuelto por drawKey
   50DB 11 00 C0      [10]  129     ld de, #0xC000
   50DE 01 26 5C      [10]  130     ld bc, #0x5C26
   50E1 CD 39 60      [17]  131     call cpct_getScreenPtr_asm        ;; Hace un locate 
   50E4 01 06 00      [10]  132     ld  bc, #0x0006
   50E7 D1            [10]  133     pop  de                           ;; Recuperar de la pila el caracter devuelto por drawKeyLeft
   50E8 CD B8 5E      [17]  134     call cpct_drawCharM0_asm          ;; Imprime la tecla
                            135 
   50EB CD F1 50      [17]  136     call delay                        ;; Para que a scanKeyBoard no sea tan rápido
                            137 
   50EE C3 C7 4F      [10]  138     jp menu
                            139 
   50F1                     140 delay:
   50F1 06 96         [ 7]  141     ld  b, #0x96
   50F3                     142 espera:
   50F3 76            [ 4]  143     halt
   50F4 10 FD         [13]  144     djnz espera
   50F6 C9            [10]  145     ret
                            146 
   50F7                     147 drawKey:
   50F7 21 CF 5E      [10]  148     ld hl, #_cpct_keyboardStatusBuffer
                            149 
   50FA 06 00         [ 7]  150     ld  b, #0x00                     ;; Contador de los bytes del array
   50FC                     151 otraLinea:                           ;; Primero hay que encontrar la línea
   50FC 7E            [ 7]  152     ld   a, (hl)                     ;; El byte al acumulador
   50FD 23            [ 6]  153     inc hl                           ;; Apunta al siguiente elemento de la tabla
   50FE 04            [ 4]  154     inc  b                           ;; Para que B conozca el indice del array
   50FF FE FF         [ 7]  155     cp  #0xFF                        ;; Ver si se pulso la tecla de esa línea
   5101 28 F9         [12]  156     jr  z, otraLinea
   5103 CD 07 51      [17]  157     call whoKey                      ;; Ahora hay que buscar la tecla
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 22.
Hexadecimal [16-Bits]



                            158 
   5106 C9            [10]  159     ret
                            160 
   5107                     161 whoKey:
   5107 F5            [11]  162     push af                          ;; Guardar tecla pulsada
   5108 78            [ 4]  163     ld  a, b                         ;; Llevamos la fila al acumulador
   5109 FE 0A         [ 7]  164     cp  #0x0A                        ;; Última fila
   510B CA 3B 51      [10]  165     jp  z, _49
   510E FE 09         [ 7]  166     cp  #0x09
   5110 CA 93 51      [10]  167     jp  z, _48
   5113 FE 08         [ 7]  168     cp  #0x08
   5115 CA EB 51      [10]  169     jp  z, _47
   5118 FE 07         [ 7]  170     cp  #0x07
   511A CA 43 52      [10]  171     jp  z, _46
   511D FE 06         [ 7]  172     cp  #0x06
   511F CA 9C 52      [10]  173     jp  z, _45
   5122 FE 05         [ 7]  174     cp  #0x05
   5124 CA F4 52      [10]  175     jp  z, _44
   5127 FE 04         [ 7]  176     cp  #0x04
   5129 CA 4C 53      [10]  177     jp  z, _43
   512C FE 03         [ 7]  178     cp  #0x03
   512E CA A4 53      [10]  179     jp  z, _42
   5131 FE 02         [ 7]  180     cp  #0x02
   5133 CA FC 53      [10]  181     jp  z, _41
   5136 FE 01         [ 7]  182     cp  #0x01
   5138 CA 54 54      [10]  183     jp  z, _40
   513B                     184 _49:
   513B F1            [10]  185     pop af                          ;; Recupero tecla pulsada
   513C 06 7F         [ 7]  186     ld  b, #0x7F                    
   513E B8            [ 4]  187     cp  b
   513F 20 06         [12]  188     jr  nz, bit6
   5141 1E FE         [ 7]  189     ld  e, #254
   5143 21 09 80      [10]  190     ld  hl, #Key_Del
   5146 C9            [10]  191     ret
   5147                     192 bit6:
   5147 CB 08         [ 8]  193     rrc b
   5149 B8            [ 4]  194     cp  b
   514A 20 06         [12]  195     jr nz, bit5
   514C 1E FF         [ 7]  196     ld  e, #255
   514E 21 09 40      [10]  197     ld  hl, #Joy0_Fire3
   5151 C9            [10]  198     ret
   5152                     199 bit5:
   5152 CB 08         [ 8]  200     rrc b
   5154 B8            [ 4]  201     cp  b
   5155 20 06         [12]  202     jr nz, bit4
   5157 1E FD         [ 7]  203     ld  e, #253
   5159 21 09 20      [10]  204     ld  hl, #Joy0_Fire2
   515C C9            [10]  205     ret
   515D                     206 bit4:
   515D CB 08         [ 8]  207     rrc b
   515F B8            [ 4]  208     cp  b
   5160 20 06         [12]  209     jr nz, bit3
   5162 1E FC         [ 7]  210     ld  e, #252
   5164 21 09 10      [10]  211     ld  hl, #Joy0_Fire1
   5167 C9            [10]  212     ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 23.
Hexadecimal [16-Bits]



   5168                     213 bit3:
   5168 CB 08         [ 8]  214     rrc b
   516A B8            [ 4]  215     cp  b
   516B 20 06         [12]  216     jr nz, bit2
   516D 1E F3         [ 7]  217     ld  e, #243
   516F 21 09 08      [10]  218     ld  hl, #Joy0_Right
   5172 C9            [10]  219     ret
   5173                     220 bit2:
   5173 CB 08         [ 8]  221     rrc b
   5175 B8            [ 4]  222     cp  b
   5176 20 06         [12]  223     jr nz, bit1
   5178 1E F2         [ 7]  224     ld  e, #242
   517A 21 09 04      [10]  225     ld  hl, #Joy0_Left
   517D C9            [10]  226     ret
   517E                     227 bit1:
   517E CB 08         [ 8]  228     rrc b
   5180 B8            [ 4]  229     cp  b
   5181 20 06         [12]  230     jr nz, bit0
   5183 1E F1         [ 7]  231     ld  e, #241
   5185 21 09 02      [10]  232     ld  hl, #Joy0_Down
   5188 C9            [10]  233     ret
   5189                     234 bit0:
   5189 CB 08         [ 8]  235     rrc b
   518B B8            [ 4]  236     cp  b
   518C C0            [11]  237     ret nz
   518D 1E F0         [ 7]  238     ld  e, #240
   518F 21 09 01      [10]  239     ld  hl, #Joy0_Up
   5192 C9            [10]  240     ret
                            241 
   5193                     242 _48:
   5193 F1            [10]  243     pop af                          ;; Recupero tecla pulsada
   5194 06 7F         [ 7]  244     ld  b, #0x7F                    
   5196 B8            [ 4]  245     cp  b
   5197 20 06         [12]  246     jr  nz, _48bit6
   5199 1E 5A         [ 7]  247     ld  e, #90
   519B 21 08 80      [10]  248     ld  hl, #Key_Z
   519E C9            [10]  249     ret
   519F                     250 _48bit6:
   519F CB 08         [ 8]  251     rrc b
   51A1 B8            [ 4]  252     cp  b
   51A2 20 06         [12]  253     jr nz, _48bit5
   51A4 1E E9         [ 7]  254     ld  e, #233
   51A6 21 08 40      [10]  255     ld  hl, #Key_CapsLock
   51A9 C9            [10]  256     ret
   51AA                     257 _48bit5:
   51AA CB 08         [ 8]  258     rrc b
   51AC B8            [ 4]  259     cp  b
   51AD 20 06         [12]  260     jr nz, _48bit4
   51AF 1E 41         [ 7]  261     ld  e, #65
   51B1 21 08 20      [10]  262     ld  hl, #Key_A
   51B4 C9            [10]  263     ret
   51B5                     264 _48bit4:
   51B5 CB 08         [ 8]  265     rrc b
   51B7 B8            [ 4]  266     cp  b
   51B8 20 06         [12]  267     jr nz, _48bit3
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 24.
Hexadecimal [16-Bits]



   51BA 1E 3E         [ 7]  268     ld  e, #62
   51BC 21 08 10      [10]  269     ld  hl, #Key_Tab
   51BF C9            [10]  270     ret
   51C0                     271 _48bit3:
   51C0 CB 08         [ 8]  272     rrc b
   51C2 B8            [ 4]  273     cp  b
   51C3 20 06         [12]  274     jr nz, _48bit2
   51C5 1E 51         [ 7]  275     ld  e, #81
   51C7 21 08 08      [10]  276     ld  hl, #Key_Q
   51CA C9            [10]  277     ret
   51CB                     278 _48bit2:
   51CB CB 08         [ 8]  279     rrc b
   51CD B8            [ 4]  280     cp  b
   51CE 20 06         [12]  281     jr nz, _48bit1
   51D0 1E 7F         [ 7]  282     ld  e, #127
   51D2 21 08 04      [10]  283     ld  hl, #Key_Esc
   51D5 C9            [10]  284     ret
   51D6                     285 _48bit1:
   51D6 CB 08         [ 8]  286     rrc b
   51D8 B8            [ 4]  287     cp  b
   51D9 20 06         [12]  288     jr nz, _48bit0
   51DB 1E 32         [ 7]  289     ld  e, #50
   51DD 21 08 02      [10]  290     ld  hl, #Key_2
   51E0 C9            [10]  291     ret
   51E1                     292 _48bit0:
   51E1 CB 08         [ 8]  293     rrc b
   51E3 B8            [ 4]  294     cp  b
   51E4 C0            [11]  295     ret nz
   51E5 1E 31         [ 7]  296     ld  e, #49
   51E7 21 08 01      [10]  297     ld  hl, #Key_1
   51EA C9            [10]  298     ret
   51EB                     299 _47:
   51EB F1            [10]  300     pop af                          ;; Recupero tecla pulsada
   51EC 06 7F         [ 7]  301     ld  b, #0x7F                    
   51EE B8            [ 4]  302     cp  b
   51EF 20 06         [12]  303     jr  nz, _47bit6
   51F1 1E 58         [ 7]  304     ld  e, #88
   51F3 21 07 80      [10]  305     ld  hl, #Key_X
   51F6 C9            [10]  306     ret
   51F7                     307 _47bit6:
   51F7 CB 08         [ 8]  308     rrc b
   51F9 B8            [ 4]  309     cp  b
   51FA 20 06         [12]  310     jr nz, _47bit5
   51FC 1E 43         [ 7]  311     ld  e, #67
   51FE 21 07 40      [10]  312     ld  hl, #Key_C
   5201 C9            [10]  313     ret
   5202                     314 _47bit5:
   5202 CB 08         [ 8]  315     rrc b
   5204 B8            [ 4]  316     cp  b
   5205 20 06         [12]  317     jr nz, _47bit4
   5207 1E 44         [ 7]  318     ld  e, #68
   5209 21 07 20      [10]  319     ld  hl, #Key_D
   520C C9            [10]  320     ret
   520D                     321 _47bit4:
   520D CB 08         [ 8]  322     rrc b
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 25.
Hexadecimal [16-Bits]



   520F B8            [ 4]  323     cp  b
   5210 20 06         [12]  324     jr nz, _47bit3
   5212 1E 53         [ 7]  325     ld  e, #83
   5214 21 07 10      [10]  326     ld  hl, #Key_S
   5217 C9            [10]  327     ret
   5218                     328 _47bit3:
   5218 CB 08         [ 8]  329     rrc b
   521A B8            [ 4]  330     cp  b
   521B 20 06         [12]  331     jr nz, _47bit2
   521D 1E 57         [ 7]  332     ld  e, #87
   521F 21 07 08      [10]  333     ld  hl, #Key_W
   5222 C9            [10]  334     ret
   5223                     335 _47bit2:
   5223 CB 08         [ 8]  336     rrc b
   5225 B8            [ 4]  337     cp  b
   5226 20 06         [12]  338     jr nz, _47bit1
   5228 1E 45         [ 7]  339     ld  e, #69
   522A 21 07 04      [10]  340     ld  hl, #Key_E
   522D C9            [10]  341     ret
   522E                     342 _47bit1:
   522E CB 08         [ 8]  343     rrc b
   5230 B8            [ 4]  344     cp  b
   5231 20 06         [12]  345     jr nz, _47bit0
   5233 1E 33         [ 7]  346     ld  e, #51
   5235 21 07 02      [10]  347     ld  hl, #Key_3
   5238 C9            [10]  348     ret
   5239                     349 _47bit0:
   5239 CB 08         [ 8]  350     rrc b
   523B B8            [ 4]  351     cp  b
   523C C0            [11]  352     ret nz
   523D 1E 34         [ 7]  353     ld  e, #52
   523F 21 07 01      [10]  354     ld  hl, #Key_4
   5242 C9            [10]  355     ret
   5243                     356 _46:
   5243 F1            [10]  357     pop af                          ;; Recupero tecla pulsada
   5244 06 7F         [ 7]  358     ld  b, #0x7F                    
   5246 B8            [ 4]  359     cp  b
   5247 20 06         [12]  360     jr  nz, _46bit6
   5249 1E 56         [ 7]  361     ld  e, #86
   524B 21 06 80      [10]  362     ld  hl, #Key_V
   524E C9            [10]  363     ret
   524F                     364 _46bit6:
   524F CB 08         [ 8]  365     rrc b
   5251 B8            [ 4]  366     cp  b
   5252 20 06         [12]  367     jr nz, _46bit5
   5254 1E 42         [ 7]  368     ld  e, #66
   5256 21 06 40      [10]  369     ld  hl, #Key_B
   5259 C9            [10]  370     ret
   525A                     371 _46bit5:
   525A CB 08         [ 8]  372     rrc b
   525C B8            [ 4]  373     cp  b
   525D 20 06         [12]  374     jr nz, _46bit4
   525F 1E 46         [ 7]  375     ld  e, #70
   5261 21 06 20      [10]  376     ld  hl, #Key_F
   5264 C9            [10]  377     ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 26.
Hexadecimal [16-Bits]



   5265                     378 _46bit4:
   5265 CB 08         [ 8]  379     rrc b
   5267 B8            [ 4]  380     cp  b
   5268 20 06         [12]  381     jr nz, _46bit3
   526A 1E 47         [ 7]  382     ld  e, #71
   526C 21 06 10      [10]  383     ld  hl, #Key_G
   526F C9            [10]  384     ret
   5270                     385 _46bit3:
   5270 CB 08         [ 8]  386     rrc b
   5272 B8            [ 4]  387     cp  b
   5273 C2 7C 52      [10]  388     jp nz, _46bit2
   5276 1E 54         [ 7]  389     ld  e, #84
   5278 21 06 08      [10]  390     ld  hl, #Key_T
   527B C9            [10]  391     ret
   527C                     392 _46bit2:
   527C CB 08         [ 8]  393     rrc b
   527E B8            [ 4]  394     cp  b
   527F 20 06         [12]  395     jr nz, _46bit1
   5281 1E 52         [ 7]  396     ld  e, #82
   5283 21 06 04      [10]  397     ld  hl, #Key_R
   5286 C9            [10]  398     ret
   5287                     399 _46bit1:
   5287 CB 08         [ 8]  400     rrc b
   5289 B8            [ 4]  401     cp  b
   528A 20 06         [12]  402     jr nz, _46bit0
   528C 1E 35         [ 7]  403     ld  e, #53
   528E 21 06 02      [10]  404     ld  hl, #Key_5
   5291 C9            [10]  405     ret
   5292                     406 _46bit0:
   5292 CB 08         [ 8]  407     rrc b
   5294 B8            [ 4]  408     cp  b
   5295 C0            [11]  409     ret nz
   5296 1E 36         [ 7]  410     ld  e, #54
   5298 21 06 01      [10]  411     ld  hl, #Key_6
   529B C9            [10]  412     ret
   529C                     413 _45:
   529C F1            [10]  414     pop af                          ;; Recupero tecla pulsada
   529D 06 7F         [ 7]  415     ld  b, #0x7F                    
   529F B8            [ 4]  416     cp  b
   52A0 20 06         [12]  417     jr  nz, _45bit6
   52A2 1E 7F         [ 7]  418     ld  e, #127
   52A4 21 05 80      [10]  419     ld  hl, #Key_Space
   52A7 C9            [10]  420     ret
   52A8                     421 _45bit6:
   52A8 CB 08         [ 8]  422     rrc b
   52AA B8            [ 4]  423     cp  b
   52AB 20 06         [12]  424     jr nz, _45bit5
   52AD 1E 4E         [ 7]  425     ld  e, #78
   52AF 21 05 40      [10]  426     ld  hl, #Key_N
   52B2 C9            [10]  427     ret
   52B3                     428 _45bit5:
   52B3 CB 08         [ 8]  429     rrc b
   52B5 B8            [ 4]  430     cp  b
   52B6 20 06         [12]  431     jr nz, _45bit4
   52B8 1E 4A         [ 7]  432     ld  e, #74
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 27.
Hexadecimal [16-Bits]



   52BA 21 05 20      [10]  433     ld  hl, #Key_J
   52BD C9            [10]  434     ret
   52BE                     435 _45bit4:
   52BE CB 08         [ 8]  436     rrc b
   52C0 B8            [ 4]  437     cp  b
   52C1 20 06         [12]  438     jr nz, _45bit3
   52C3 1E 48         [ 7]  439     ld  e, #72
   52C5 21 05 10      [10]  440     ld  hl, #Key_H
   52C8 C9            [10]  441     ret
   52C9                     442 _45bit3:
   52C9 CB 08         [ 8]  443     rrc b
   52CB B8            [ 4]  444     cp  b
   52CC 20 06         [12]  445     jr nz, _45bit2
   52CE 1E 59         [ 7]  446     ld  e, #89
   52D0 21 05 08      [10]  447     ld  hl, #Key_Y
   52D3 C9            [10]  448     ret
   52D4                     449 _45bit2:
   52D4 CB 08         [ 8]  450     rrc b
   52D6 B8            [ 4]  451     cp  b
   52D7 20 06         [12]  452     jr nz, _45bit1
   52D9 1E 55         [ 7]  453     ld  e, #85
   52DB 21 05 04      [10]  454     ld  hl, #Key_U
   52DE C9            [10]  455     ret
   52DF                     456 _45bit1:
   52DF CB 08         [ 8]  457     rrc b
   52E1 B8            [ 4]  458     cp  b
   52E2 20 06         [12]  459     jr nz, _45bit0
   52E4 1E 37         [ 7]  460     ld  e, #55
   52E6 21 05 02      [10]  461     ld  hl, #Key_7
   52E9 C9            [10]  462     ret
   52EA                     463 _45bit0:
   52EA CB 08         [ 8]  464     rrc b
   52EC B8            [ 4]  465     cp  b
   52ED C0            [11]  466     ret nz
   52EE 1E 38         [ 7]  467     ld  e, #56
   52F0 21 05 01      [10]  468     ld  hl, #Key_8
   52F3 C9            [10]  469     ret
   52F4                     470 _44:
   52F4 F1            [10]  471     pop af                          ;; Recupero tecla pulsada
   52F5 06 7F         [ 7]  472     ld  b, #0x7F                    
   52F7 B8            [ 4]  473     cp  b
   52F8 20 06         [12]  474     jr  nz, _44bit6
   52FA 1E 2C         [ 7]  475     ld  e, #44
   52FC 21 04 80      [10]  476     ld  hl, #Key_Comma
   52FF C9            [10]  477     ret
   5300                     478 _44bit6:
   5300 CB 08         [ 8]  479     rrc b
   5302 B8            [ 4]  480     cp  b
   5303 20 06         [12]  481     jr nz, _44bit5
   5305 1E 4D         [ 7]  482     ld  e, #77
   5307 21 04 40      [10]  483     ld  hl, #Key_M
   530A C9            [10]  484     ret
   530B                     485 _44bit5:
   530B CB 08         [ 8]  486     rrc b
   530D B8            [ 4]  487     cp  b
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 28.
Hexadecimal [16-Bits]



   530E 20 06         [12]  488     jr nz, _44bit4
   5310 1E 4B         [ 7]  489     ld  e, #75
   5312 21 04 20      [10]  490     ld  hl, #Key_K
   5315 C9            [10]  491     ret
   5316                     492 _44bit4:
   5316 CB 08         [ 8]  493     rrc b
   5318 B8            [ 4]  494     cp  b
   5319 20 06         [12]  495     jr nz, _44bit3
   531B 1E 4C         [ 7]  496     ld  e, #76
   531D 21 04 10      [10]  497     ld  hl, #Key_L
   5320 C9            [10]  498     ret
   5321                     499 _44bit3:
   5321 CB 08         [ 8]  500     rrc b
   5323 B8            [ 4]  501     cp  b
   5324 20 06         [12]  502     jr nz, _44bit2
   5326 1E 49         [ 7]  503     ld  e, #73
   5328 21 04 08      [10]  504     ld  hl, #Key_I
   532B C9            [10]  505     ret
   532C                     506 _44bit2:
   532C CB 08         [ 8]  507     rrc b
   532E B8            [ 4]  508     cp  b
   532F 20 06         [12]  509     jr nz, _44bit1
   5331 1E 4F         [ 7]  510     ld  e, #79
   5333 21 04 04      [10]  511     ld  hl, #Key_O
   5336 C9            [10]  512     ret
   5337                     513 _44bit1:
   5337 CB 08         [ 8]  514     rrc b
   5339 B8            [ 4]  515     cp  b
   533A 20 06         [12]  516     jr nz, _44bit0
   533C 1E 39         [ 7]  517     ld  e, #57
   533E 21 04 02      [10]  518     ld  hl, #Key_9
   5341 C9            [10]  519     ret
   5342                     520 _44bit0:
   5342 CB 08         [ 8]  521     rrc b
   5344 B8            [ 4]  522     cp  b
   5345 C0            [11]  523     ret nz
   5346 1E 30         [ 7]  524     ld  e, #48
   5348 21 04 01      [10]  525     ld  hl, #Key_0
   534B C9            [10]  526     ret
   534C                     527 _43:
   534C F1            [10]  528     pop af                          ;; Recupero tecla pulsada
   534D 06 7F         [ 7]  529     ld  b, #0x7F                    
   534F B8            [ 4]  530     cp  b
   5350 20 06         [12]  531     jr  nz, _43bit6
   5352 1E 2E         [ 7]  532     ld  e, #46
   5354 21 03 80      [10]  533     ld  hl, #Key_Dot
   5357 C9            [10]  534     ret
   5358                     535 _43bit6:
   5358 CB 08         [ 8]  536     rrc b
   535A B8            [ 4]  537     cp  b
   535B 20 06         [12]  538     jr nz, _43bit5
   535D 1E 2F         [ 7]  539     ld  e, #47
   535F 21 03 40      [10]  540     ld  hl, #Key_Slash
   5362 C9            [10]  541     ret
   5363                     542 _43bit5:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 29.
Hexadecimal [16-Bits]



   5363 CB 08         [ 8]  543     rrc b
   5365 B8            [ 4]  544     cp  b
   5366 20 06         [12]  545     jr nz, _43bit4
   5368 1E 3A         [ 7]  546     ld  e, #58
   536A 21 03 20      [10]  547     ld  hl, #Key_Colon
   536D C9            [10]  548     ret
   536E                     549 _43bit4:
   536E CB 08         [ 8]  550     rrc b
   5370 B8            [ 4]  551     cp  b
   5371 20 06         [12]  552     jr nz, _43bit3
   5373 1E 3B         [ 7]  553     ld  e, #59
   5375 21 03 10      [10]  554     ld  hl, #Key_SemiColon
   5378 C9            [10]  555     ret
   5379                     556 _43bit3:
   5379 CB 08         [ 8]  557     rrc b
   537B B8            [ 4]  558     cp  b
   537C 20 06         [12]  559     jr nz, _43bit2
   537E 1E 50         [ 7]  560     ld  e, #80
   5380 21 03 08      [10]  561     ld  hl, #Key_P
   5383 C9            [10]  562     ret
   5384                     563 _43bit2:
   5384 CB 08         [ 8]  564     rrc b
   5386 B8            [ 4]  565     cp  b
   5387 20 06         [12]  566     jr nz, _43bit1
   5389 1E 40         [ 7]  567     ld  e, #64
   538B 21 03 04      [10]  568     ld  hl, #Key_At
   538E C9            [10]  569     ret
   538F                     570 _43bit1:
   538F CB 08         [ 8]  571     rrc b
   5391 B8            [ 4]  572     cp  b
   5392 20 06         [12]  573     jr nz, _43bit0
   5394 1E 2D         [ 7]  574     ld  e, #45
   5396 21 03 02      [10]  575     ld  hl, #Key_Hyphen
   5399 C9            [10]  576     ret
   539A                     577 _43bit0:
   539A CB 08         [ 8]  578     rrc b
   539C B8            [ 4]  579     cp  b
   539D C0            [11]  580     ret nz
   539E 1E A0         [ 7]  581     ld  e, #160
   53A0 21 03 01      [10]  582     ld  hl, #Key_Caret
   53A3 C9            [10]  583     ret
   53A4                     584 _42:
   53A4 F1            [10]  585     pop af                          ;; Recupero tecla pulsada
   53A5 06 7F         [ 7]  586     ld  b, #0x7F                    
   53A7 B8            [ 4]  587     cp  b
   53A8 20 06         [12]  588     jr  nz, _42bit6
   53AA 1E 7F         [ 7]  589     ld  e, #127
   53AC 21 02 80      [10]  590     ld  hl, #Key_Control
   53AF C9            [10]  591     ret
   53B0                     592 _42bit6:
   53B0 CB 08         [ 8]  593     rrc b
   53B2 B8            [ 4]  594     cp  b
   53B3 20 06         [12]  595     jr nz, _42bit5
   53B5 1E 5C         [ 7]  596     ld  e, #92
   53B7 21 02 40      [10]  597     ld  hl, #Key_BackSlash
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 30.
Hexadecimal [16-Bits]



   53BA C9            [10]  598     ret
   53BB                     599 _42bit5:
   53BB CB 08         [ 8]  600     rrc b
   53BD B8            [ 4]  601     cp  b
   53BE 20 06         [12]  602     jr nz, _42bit4
   53C0 1E 86         [ 7]  603     ld  e, #134
   53C2 21 02 20      [10]  604     ld  hl, #Key_Shift
   53C5 C9            [10]  605     ret
   53C6                     606 _42bit4:
   53C6 CB 08         [ 8]  607     rrc b
   53C8 B8            [ 4]  608     cp  b
   53C9 20 06         [12]  609     jr nz, _42bit3
   53CB 1E 83         [ 7]  610     ld  e, #131
   53CD 21 02 10      [10]  611     ld  hl, #Key_F4
   53D0 C9            [10]  612     ret
   53D1                     613 _42bit3:
   53D1 CB 08         [ 8]  614     rrc b
   53D3 B8            [ 4]  615     cp  b
   53D4 20 06         [12]  616     jr nz, _42bit2
   53D6 1E 5D         [ 7]  617     ld  e, #93
   53D8 21 02 08      [10]  618     ld  hl, #Key_CloseBracket
   53DB C9            [10]  619     ret
   53DC                     620 _42bit2:
   53DC CB 08         [ 8]  621     rrc b
   53DE B8            [ 4]  622     cp  b
   53DF 20 06         [12]  623     jr nz, _42bit1
   53E1 1E 60         [ 7]  624     ld  e, #96
   53E3 21 02 04      [10]  625     ld  hl, #Key_Return
   53E6 C9            [10]  626     ret
   53E7                     627 _42bit1:
   53E7 CB 08         [ 8]  628     rrc b
   53E9 B8            [ 4]  629     cp  b
   53EA 20 06         [12]  630     jr nz, _42bit0
   53EC 1E 5B         [ 7]  631     ld  e, #91
   53EE 21 02 02      [10]  632     ld  hl, #Key_OpenBracket
   53F1 C9            [10]  633     ret
   53F2                     634 _42bit0:
   53F2 CB 08         [ 8]  635     rrc b
   53F4 B8            [ 4]  636     cp  b
   53F5 C0            [11]  637     ret nz
   53F6 1E FD         [ 7]  638     ld  e, #253
   53F8 21 02 01      [10]  639     ld  hl, #Key_Clr
   53FB C9            [10]  640     ret
   53FC                     641 _41:
   53FC F1            [10]  642     pop af                          ;; Recupero tecla pulsada
   53FD 06 7F         [ 7]  643     ld  b, #0x7F                    
   53FF B8            [ 4]  644     cp  b
   5400 20 06         [12]  645     jr  nz, _41bit6
   5402 1E 82         [ 7]  646     ld  e, #130
   5404 21 01 80      [10]  647     ld  hl, #Key_F0
   5407 C9            [10]  648     ret
   5408                     649 _41bit6:
   5408 CB 08         [ 8]  650     rrc b
   540A B8            [ 4]  651     cp  b
   540B 20 06         [12]  652     jr nz, _41bit5
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 31.
Hexadecimal [16-Bits]



   540D 1E 84         [ 7]  653     ld  e, #132
   540F 21 01 40      [10]  654     ld  hl, #Key_F2
   5412 C9            [10]  655     ret
   5413                     656 _41bit5:
   5413 CB 08         [ 8]  657     rrc b
   5415 B8            [ 4]  658     cp  b
   5416 20 06         [12]  659     jr nz, _41bit4
   5418 1E 83         [ 7]  660     ld  e, #131
   541A 21 01 20      [10]  661     ld  hl, #Key_F1
   541D C9            [10]  662     ret
   541E                     663 _41bit4:
   541E CB 08         [ 8]  664     rrc b
   5420 B8            [ 4]  665     cp  b
   5421 20 06         [12]  666     jr nz, _41bit3
   5423 1E 87         [ 7]  667     ld  e, #135
   5425 21 01 10      [10]  668     ld  hl, #Key_F5
   5428 C9            [10]  669     ret
   5429                     670 _41bit3:
   5429 CB 08         [ 8]  671     rrc b
   542B B8            [ 4]  672     cp  b
   542C 20 06         [12]  673     jr nz, _41bit2
   542E 1E 8A         [ 7]  674     ld  e, #138
   5430 21 01 08      [10]  675     ld  hl, #Key_F8
   5433 C9            [10]  676     ret
   5434                     677 _41bit2:
   5434 CB 08         [ 8]  678     rrc b
   5436 B8            [ 4]  679     cp  b
   5437 20 06         [12]  680     jr nz, _41bit1
   5439 1E 89         [ 7]  681     ld  e, #137
   543B 21 01 04      [10]  682     ld  hl, #Key_F7
   543E C9            [10]  683     ret
   543F                     684 _41bit1:
   543F CB 08         [ 8]  685     rrc b
   5441 B8            [ 4]  686     cp  b
   5442 20 06         [12]  687     jr nz, _41bit0
   5444 1E 93         [ 7]  688     ld  e, #147
   5446 21 01 02      [10]  689     ld  hl, #Key_Copy
   5449 C9            [10]  690     ret
   544A                     691 _41bit0:
   544A CB 08         [ 8]  692     rrc b
   544C B8            [ 4]  693     cp  b
   544D C0            [11]  694     ret nz
   544E 1E F2         [ 7]  695     ld  e, #242
   5450 21 01 01      [10]  696     ld  hl, #Key_CursorLeft
   5453 C9            [10]  697     ret
   5454                     698 _40:
   5454 F1            [10]  699     pop af                          ;; Recupero tecla pulsada
   5455 06 7F         [ 7]  700     ld  b, #0x7F                    
   5457 B8            [ 4]  701     cp  b
   5458 20 06         [12]  702     jr  nz, _40bit6
   545A 1E 90         [ 7]  703     ld  e, #144
   545C 21 00 80      [10]  704     ld  hl, #Key_FDot
   545F C9            [10]  705     ret
   5460                     706 _40bit6:
   5460 CB 08         [ 8]  707     rrc b
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 32.
Hexadecimal [16-Bits]



   5462 B8            [ 4]  708     cp  b
   5463 20 06         [12]  709     jr nz, _40bit5
   5465 1E E9         [ 7]  710     ld  e, #233
   5467 21 00 40      [10]  711     ld  hl, #Key_Enter
   546A C9            [10]  712     ret
   546B                     713 _40bit5:
   546B CB 08         [ 8]  714     rrc b
   546D B8            [ 4]  715     cp  b
   546E 20 06         [12]  716     jr nz, _40bit4
   5470 1E 85         [ 7]  717     ld  e, #133
   5472 21 00 20      [10]  718     ld  hl, #Key_F3
   5475 C9            [10]  719     ret
   5476                     720 _40bit4:
   5476 CB 08         [ 8]  721     rrc b
   5478 B8            [ 4]  722     cp  b
   5479 20 06         [12]  723     jr nz, _40bit3
   547B 1E 88         [ 7]  724     ld  e, #136
   547D 21 00 10      [10]  725     ld  hl, #Key_F6
   5480 C9            [10]  726     ret
   5481                     727 _40bit3:
   5481 CB 08         [ 8]  728     rrc b
   5483 B8            [ 4]  729     cp  b
   5484 20 06         [12]  730     jr nz, _40bit2
   5486 1E 8B         [ 7]  731     ld  e, #139
   5488 21 00 08      [10]  732     ld  hl, #Key_F9
   548B C9            [10]  733     ret
   548C                     734 _40bit2:
   548C CB 08         [ 8]  735     rrc b
   548E B8            [ 4]  736     cp  b
   548F 20 06         [12]  737     jr nz, _40bit1
   5491 1E F1         [ 7]  738     ld  e, #241
   5493 21 00 04      [10]  739     ld  hl, #Key_CursorDown
   5496 C9            [10]  740     ret
   5497                     741 _40bit1:
   5497 CB 08         [ 8]  742     rrc b
   5499 B8            [ 4]  743     cp  b
   549A 20 06         [12]  744     jr nz, _40bit0
   549C 1E F3         [ 7]  745     ld  e, #243
   549E 21 00 02      [10]  746     ld  hl, #Key_CursorRight
   54A1 C9            [10]  747     ret
   54A2                     748 _40bit0:
   54A2 CB 08         [ 8]  749     rrc b
   54A4 B8            [ 4]  750     cp  b
   54A5 C0            [11]  751     ret nz
   54A6 1E F0         [ 7]  752     ld  e, #240
   54A8 21 00 01      [10]  753     ld  hl, #Key_CursorUp
   54AB C9            [10]  754     ret
