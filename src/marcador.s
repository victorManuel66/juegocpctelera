.area _CODE

.include "cpctelera.h.s"

decenas:  .db 0x00
centenas: .db 0x00
millares: .db 0x00
diezmil:  .db 0x00

suma::
    ld hl, #decenas
    inc (hl)
    ld a, #0x0A
    cp (hl)
    jr nz, guarda
    ld  a, #0x00
    ld (decenas), a
    ld hl, #centenas
    inc (hl)
    ld  a, #0x0A
    cp (hl)
    jr nz, guarda
    ld  a, #0x00
    ld (centenas), a
    ld hl, #millares
    inc (hl)
    ld  a, #0x0A
    cp (hl)
    jr nz, guarda
    ld a, #0x00
    ld (millares), a
    ld hl, #diezmil
    inc (hl)
guarda:
    ld  a, (decenas)
    call printdecena
    ld  a, (centenas)
    call printcentena
    ld  a, (millares)
    call printmillares
    ld  a, (diezmil)
    call printdiezmil

    ret

printdecena:
    add #0x30                            ;; El codigo ASCII de '0'
    push af
    ld hl, #0x0002
    call cpct_setDrawCharM0_asm
    ld de, #0xC000
    ld bc, #0x5C43
    call cpct_getScreenPtr_asm
    pop af
    ld  e, a
    call cpct_drawCharM0_asm
    ret

printcentena:
    add #0x30                            ;; El codigo ASCII de '0'
    push af
    ld hl, #0x0002
    call cpct_setDrawCharM0_asm
    ld de, #0xC000
    ld bc, #0x5C3F
    call cpct_getScreenPtr_asm
    pop af
    ld  e, a
    call cpct_drawCharM0_asm
    ret

printmillares:
    add #0x30                            ;; El codigo ASCII de '0'
    push af
    ld hl, #0x0002
    call cpct_setDrawCharM0_asm
    ld de, #0xC000
    ld bc, #0x5C3B
    call cpct_getScreenPtr_asm
    pop af
    ld  e, a
    call cpct_drawCharM0_asm
    ret

printdiezmil:
    add #0x30                            ;; El codigo ASCII de '0'
    push af
    ld hl, #0x0002
    call cpct_setDrawCharM0_asm
    ld de, #0xC000
    ld bc, #0x5C37
    call cpct_getScreenPtr_asm
    pop af
    ld  e, a
    call cpct_drawCharM0_asm
    ret