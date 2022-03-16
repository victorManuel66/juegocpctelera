;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module escenario16x8
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _esce_7
	.globl _esce_6
	.globl _esce_5
	.globl _esce_4
	.globl _esce_3
	.globl _esce_2
	.globl _esce_1
	.globl _esce_0
	.globl _tileset
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
_tileset:
	.dw _esce_0
	.dw _esce_1
	.dw _esce_2
	.dw _esce_3
	.dw _esce_4
	.dw _esce_5
	.dw _esce_6
	.dw _esce_7
_esce_0:
	.db #0xc0	; 192
	.db #0xf0	; 240
	.db #0xd0	; 208
	.db #0xbb	; 187
	.db #0xf5	; 245
	.db #0xbb	; 187
	.db #0xf5	; 245
	.db #0xbb	; 187
_esce_1:
	.db #0xf0	; 240
	.db #0xc0	; 192
	.db #0x77	; 119	'w'
	.db #0xe0	; 224
	.db #0x77	; 119	'w'
	.db #0xfa	; 250
	.db #0x77	; 119	'w'
	.db #0xfa	; 250
_esce_2:
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
_esce_3:
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
_esce_4:
	.db #0xf5	; 245
	.db #0xbb	; 187
	.db #0xf5	; 245
	.db #0xfa	; 250
	.db #0xf5	; 245
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xc0	; 192
_esce_5:
	.db #0x77	; 119	'w'
	.db #0xfa	; 250
	.db #0xf5	; 245
	.db #0xfa	; 250
	.db #0xd0	; 208
	.db #0xfa	; 250
	.db #0xc0	; 192
	.db #0xf0	; 240
_esce_6:
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
_esce_7:
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.area _INITIALIZER
	.area _CABS (ABS)
