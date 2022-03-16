;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module naveexplo3
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _playerexplo3
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
_playerexplo3:
	.db #0xc0	; 192
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xb2	; 178
	.db #0x30	; 48	'0'
	.db #0x71	; 113	'q'
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xb2	; 178
	.db #0xf3	; 243
	.db #0x71	; 113	'q'
	.db #0xc0	; 192
	.db #0x90	; 144
	.db #0xb2	; 178
	.db #0xf3	; 243
	.db #0x71	; 113	'q'
	.db #0x60	; 96
	.db #0x90	; 144
	.db #0xb2	; 178
	.db #0x30	; 48	'0'
	.db #0x71	; 113	'q'
	.db #0x60	; 96
	.db #0xd9	; 217
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xe6	; 230
	.area _INITIALIZER
	.area _CABS (ABS)
