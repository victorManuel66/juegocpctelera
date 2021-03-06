#include "nave.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2017
// Palette uses hardware values.
const u8 palette[16] = { 0x54, 0x44, 0x55, 0x5c, 0x4c, 0x56, 0x57, 0x5e, 0x40, 0x4e, 0x47, 0x52, 0x53, 0x4a, 0x43, 0x4b };

// Tile spr: 10x6 pixels, 5x6 bytes.
const u8 spr[5 * 6] = {
	0xc0, 0xc0, 0x30, 0xc0, 0xc0,
	0xc0, 0xc0, 0xcc, 0xc0, 0xc0,
	0xc0, 0xc0, 0xcc, 0xc0, 0xc0,
	0x90, 0xc4, 0x0c, 0xc8, 0x60,
	0x90, 0xc4, 0x0c, 0xc8, 0x60,
	0xd9, 0x8c, 0x0c, 0x4c, 0xe6
};

