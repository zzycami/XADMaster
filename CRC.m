/*
 * CRC.m
 *
 * Copyright (c) 2017-present, MacPaw Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301  USA
 */
#import "Checksums.h"

uint32_t XADCRC(uint32_t prevcrc,uint8_t byte,const uint32_t *table)
{
	return table[(prevcrc^byte)&0xff]^(prevcrc>>8);
}

uint32_t XADCalculateCRC(uint32_t prevcrc,const uint8_t *buffer,int length,const uint32_t *table)
{
	uint32_t crc=prevcrc;
	for(int i=0;i<length;i++) crc=XADCRC(crc,buffer[i],table);
	return crc;
}

uint64_t XADCRC64(uint64_t prevcrc,uint8_t byte,const uint64_t *table)
{
	return table[(prevcrc^byte)&0xff]^(prevcrc>>8);
}

uint64_t XADCalculateCRC64(uint64_t prevcrc,const uint8_t *buffer,int length,const uint64_t *table)
{
	uint64_t crc=prevcrc;
	for(int i=0;i<length;i++) crc=XADCRC64(crc,buffer[i],table);
	return crc;
}

int XADUnReverseCRC16(int val)
{
	val=((val>>8)&0x00FF)|((val&0x00FF)<<8);
	return val;
}

const uint32_t XADCRCTable_a001[256]=
{
	0x00000000,0x0000c0c1,0x0000c181,0x00000140,0x0000c301,0x000003c0,0x00000280,0x0000c241,
	0x0000c601,0x000006c0,0x00000780,0x0000c741,0x00000500,0x0000c5c1,0x0000c481,0x00000440,
	0x0000cc01,0x00000cc0,0x00000d80,0x0000cd41,0x00000f00,0x0000cfc1,0x0000ce81,0x00000e40,
	0x00000a00,0x0000cac1,0x0000cb81,0x00000b40,0x0000c901,0x000009c0,0x00000880,0x0000c841,
	0x0000d801,0x000018c0,0x00001980,0x0000d941,0x00001b00,0x0000dbc1,0x0000da81,0x00001a40,
	0x00001e00,0x0000dec1,0x0000df81,0x00001f40,0x0000dd01,0x00001dc0,0x00001c80,0x0000dc41,
	0x00001400,0x0000d4c1,0x0000d581,0x00001540,0x0000d701,0x000017c0,0x00001680,0x0000d641,
	0x0000d201,0x000012c0,0x00001380,0x0000d341,0x00001100,0x0000d1c1,0x0000d081,0x00001040,
	0x0000f001,0x000030c0,0x00003180,0x0000f141,0x00003300,0x0000f3c1,0x0000f281,0x00003240,
	0x00003600,0x0000f6c1,0x0000f781,0x00003740,0x0000f501,0x000035c0,0x00003480,0x0000f441,
	0x00003c00,0x0000fcc1,0x0000fd81,0x00003d40,0x0000ff01,0x00003fc0,0x00003e80,0x0000fe41,
	0x0000fa01,0x00003ac0,0x00003b80,0x0000fb41,0x00003900,0x0000f9c1,0x0000f881,0x00003840,
	0x00002800,0x0000e8c1,0x0000e981,0x00002940,0x0000eb01,0x00002bc0,0x00002a80,0x0000ea41,
	0x0000ee01,0x00002ec0,0x00002f80,0x0000ef41,0x00002d00,0x0000edc1,0x0000ec81,0x00002c40,
	0x0000e401,0x000024c0,0x00002580,0x0000e541,0x00002700,0x0000e7c1,0x0000e681,0x00002640,
	0x00002200,0x0000e2c1,0x0000e381,0x00002340,0x0000e101,0x000021c0,0x00002080,0x0000e041,
	0x0000a001,0x000060c0,0x00006180,0x0000a141,0x00006300,0x0000a3c1,0x0000a281,0x00006240,
	0x00006600,0x0000a6c1,0x0000a781,0x00006740,0x0000a501,0x000065c0,0x00006480,0x0000a441,
	0x00006c00,0x0000acc1,0x0000ad81,0x00006d40,0x0000af01,0x00006fc0,0x00006e80,0x0000ae41,
	0x0000aa01,0x00006ac0,0x00006b80,0x0000ab41,0x00006900,0x0000a9c1,0x0000a881,0x00006840,
	0x00007800,0x0000b8c1,0x0000b981,0x00007940,0x0000bb01,0x00007bc0,0x00007a80,0x0000ba41,
	0x0000be01,0x00007ec0,0x00007f80,0x0000bf41,0x00007d00,0x0000bdc1,0x0000bc81,0x00007c40,
	0x0000b401,0x000074c0,0x00007580,0x0000b541,0x00007700,0x0000b7c1,0x0000b681,0x00007640,
	0x00007200,0x0000b2c1,0x0000b381,0x00007340,0x0000b101,0x000071c0,0x00007080,0x0000b041,
	0x00005000,0x000090c1,0x00009181,0x00005140,0x00009301,0x000053c0,0x00005280,0x00009241,
	0x00009601,0x000056c0,0x00005780,0x00009741,0x00005500,0x000095c1,0x00009481,0x00005440,
	0x00009c01,0x00005cc0,0x00005d80,0x00009d41,0x00005f00,0x00009fc1,0x00009e81,0x00005e40,
	0x00005a00,0x00009ac1,0x00009b81,0x00005b40,0x00009901,0x000059c0,0x00005880,0x00009841,
	0x00008801,0x000048c0,0x00004980,0x00008941,0x00004b00,0x00008bc1,0x00008a81,0x00004a40,
	0x00004e00,0x00008ec1,0x00008f81,0x00004f40,0x00008d01,0x00004dc0,0x00004c80,0x00008c41,
	0x00004400,0x000084c1,0x00008581,0x00004540,0x00008701,0x000047c0,0x00004680,0x00008641,
	0x00008201,0x000042c0,0x00004380,0x00008341,0x00004100,0x000081c1,0x00008081,0x00004040,
};

const uint32_t XADCRCReverseTable_1021[256]=
{
	0x00000000,0x00002110,0x00004220,0x00006330,0x00008440,0x0000a550,0x0000c660,0x0000e770,
	0x00000881,0x00002991,0x00004aa1,0x00006bb1,0x00008cc1,0x0000add1,0x0000cee1,0x0000eff1,
	0x00003112,0x00001002,0x00007332,0x00005222,0x0000b552,0x00009442,0x0000f772,0x0000d662,
	0x00003993,0x00001883,0x00007bb3,0x00005aa3,0x0000bdd3,0x00009cc3,0x0000fff3,0x0000dee3,
	0x00006224,0x00004334,0x00002004,0x00000114,0x0000e664,0x0000c774,0x0000a444,0x00008554,
	0x00006aa5,0x00004bb5,0x00002885,0x00000995,0x0000eee5,0x0000cff5,0x0000acc5,0x00008dd5,
	0x00005336,0x00007226,0x00001116,0x00003006,0x0000d776,0x0000f666,0x00009556,0x0000b446,
	0x00005bb7,0x00007aa7,0x00001997,0x00003887,0x0000dff7,0x0000fee7,0x00009dd7,0x0000bcc7,
	0x0000c448,0x0000e558,0x00008668,0x0000a778,0x00004008,0x00006118,0x00000228,0x00002338,
	0x0000ccc9,0x0000edd9,0x00008ee9,0x0000aff9,0x00004889,0x00006999,0x00000aa9,0x00002bb9,
	0x0000f55a,0x0000d44a,0x0000b77a,0x0000966a,0x0000711a,0x0000500a,0x0000333a,0x0000122a,
	0x0000fddb,0x0000dccb,0x0000bffb,0x00009eeb,0x0000799b,0x0000588b,0x00003bbb,0x00001aab,
	0x0000a66c,0x0000877c,0x0000e44c,0x0000c55c,0x0000222c,0x0000033c,0x0000600c,0x0000411c,
	0x0000aeed,0x00008ffd,0x0000eccd,0x0000cddd,0x00002aad,0x00000bbd,0x0000688d,0x0000499d,
	0x0000977e,0x0000b66e,0x0000d55e,0x0000f44e,0x0000133e,0x0000322e,0x0000511e,0x0000700e,
	0x00009fff,0x0000beef,0x0000dddf,0x0000fccf,0x00001bbf,0x00003aaf,0x0000599f,0x0000788f,
	0x00008891,0x0000a981,0x0000cab1,0x0000eba1,0x00000cd1,0x00002dc1,0x00004ef1,0x00006fe1,
	0x00008010,0x0000a100,0x0000c230,0x0000e320,0x00000450,0x00002540,0x00004670,0x00006760,
	0x0000b983,0x00009893,0x0000fba3,0x0000dab3,0x00003dc3,0x00001cd3,0x00007fe3,0x00005ef3,
	0x0000b102,0x00009012,0x0000f322,0x0000d232,0x00003542,0x00001452,0x00007762,0x00005672,
	0x0000eab5,0x0000cba5,0x0000a895,0x00008985,0x00006ef5,0x00004fe5,0x00002cd5,0x00000dc5,
	0x0000e234,0x0000c324,0x0000a014,0x00008104,0x00006674,0x00004764,0x00002454,0x00000544,
	0x0000dba7,0x0000fab7,0x00009987,0x0000b897,0x00005fe7,0x00007ef7,0x00001dc7,0x00003cd7,
	0x0000d326,0x0000f236,0x00009106,0x0000b016,0x00005766,0x00007676,0x00001546,0x00003456,
	0x00004cd9,0x00006dc9,0x00000ef9,0x00002fe9,0x0000c899,0x0000e989,0x00008ab9,0x0000aba9,
	0x00004458,0x00006548,0x00000678,0x00002768,0x0000c018,0x0000e108,0x00008238,0x0000a328,
	0x00007dcb,0x00005cdb,0x00003feb,0x00001efb,0x0000f98b,0x0000d89b,0x0000bbab,0x00009abb,
	0x0000754a,0x0000545a,0x0000376a,0x0000167a,0x0000f10a,0x0000d01a,0x0000b32a,0x0000923a,
	0x00002efd,0x00000fed,0x00006cdd,0x00004dcd,0x0000aabd,0x00008bad,0x0000e89d,0x0000c98d,
	0x0000267c,0x0000076c,0x0000645c,0x0000454c,0x0000a23c,0x0000832c,0x0000e01c,0x0000c10c,
	0x00001fef,0x00003eff,0x00005dcf,0x00007cdf,0x00009baf,0x0000babf,0x0000d98f,0x0000f89f,
	0x0000176e,0x0000367e,0x0000554e,0x0000745e,0x0000932e,0x0000b23e,0x0000d10e,0x0000f01e,
};


const uint32_t XADCRCTable_edb88320[256]=
{
	0x00000000,0x77073096,0xee0e612c,0x990951ba,0x076dc419,0x706af48f,0xe963a535,0x9e6495a3,
	0x0edb8832,0x79dcb8a4,0xe0d5e91e,0x97d2d988,0x09b64c2b,0x7eb17cbd,0xe7b82d07,0x90bf1d91,
	0x1db71064,0x6ab020f2,0xf3b97148,0x84be41de,0x1adad47d,0x6ddde4eb,0xf4d4b551,0x83d385c7,
	0x136c9856,0x646ba8c0,0xfd62f97a,0x8a65c9ec,0x14015c4f,0x63066cd9,0xfa0f3d63,0x8d080df5,
	0x3b6e20c8,0x4c69105e,0xd56041e4,0xa2677172,0x3c03e4d1,0x4b04d447,0xd20d85fd,0xa50ab56b,
	0x35b5a8fa,0x42b2986c,0xdbbbc9d6,0xacbcf940,0x32d86ce3,0x45df5c75,0xdcd60dcf,0xabd13d59,
	0x26d930ac,0x51de003a,0xc8d75180,0xbfd06116,0x21b4f4b5,0x56b3c423,0xcfba9599,0xb8bda50f,
	0x2802b89e,0x5f058808,0xc60cd9b2,0xb10be924,0x2f6f7c87,0x58684c11,0xc1611dab,0xb6662d3d,
	0x76dc4190,0x01db7106,0x98d220bc,0xefd5102a,0x71b18589,0x06b6b51f,0x9fbfe4a5,0xe8b8d433,
	0x7807c9a2,0x0f00f934,0x9609a88e,0xe10e9818,0x7f6a0dbb,0x086d3d2d,0x91646c97,0xe6635c01,
	0x6b6b51f4,0x1c6c6162,0x856530d8,0xf262004e,0x6c0695ed,0x1b01a57b,0x8208f4c1,0xf50fc457,
	0x65b0d9c6,0x12b7e950,0x8bbeb8ea,0xfcb9887c,0x62dd1ddf,0x15da2d49,0x8cd37cf3,0xfbd44c65,
	0x4db26158,0x3ab551ce,0xa3bc0074,0xd4bb30e2,0x4adfa541,0x3dd895d7,0xa4d1c46d,0xd3d6f4fb,
	0x4369e96a,0x346ed9fc,0xad678846,0xda60b8d0,0x44042d73,0x33031de5,0xaa0a4c5f,0xdd0d7cc9,
	0x5005713c,0x270241aa,0xbe0b1010,0xc90c2086,0x5768b525,0x206f85b3,0xb966d409,0xce61e49f,
	0x5edef90e,0x29d9c998,0xb0d09822,0xc7d7a8b4,0x59b33d17,0x2eb40d81,0xb7bd5c3b,0xc0ba6cad,
	0xedb88320,0x9abfb3b6,0x03b6e20c,0x74b1d29a,0xead54739,0x9dd277af,0x04db2615,0x73dc1683,
	0xe3630b12,0x94643b84,0x0d6d6a3e,0x7a6a5aa8,0xe40ecf0b,0x9309ff9d,0x0a00ae27,0x7d079eb1,
	0xf00f9344,0x8708a3d2,0x1e01f268,0x6906c2fe,0xf762575d,0x806567cb,0x196c3671,0x6e6b06e7,
	0xfed41b76,0x89d32be0,0x10da7a5a,0x67dd4acc,0xf9b9df6f,0x8ebeeff9,0x17b7be43,0x60b08ed5,
	0xd6d6a3e8,0xa1d1937e,0x38d8c2c4,0x4fdff252,0xd1bb67f1,0xa6bc5767,0x3fb506dd,0x48b2364b,
	0xd80d2bda,0xaf0a1b4c,0x36034af6,0x41047a60,0xdf60efc3,0xa867df55,0x316e8eef,0x4669be79,
	0xcb61b38c,0xbc66831a,0x256fd2a0,0x5268e236,0xcc0c7795,0xbb0b4703,0x220216b9,0x5505262f,
	0xc5ba3bbe,0xb2bd0b28,0x2bb45a92,0x5cb36a04,0xc2d7ffa7,0xb5d0cf31,0x2cd99e8b,0x5bdeae1d,
	0x9b64c2b0,0xec63f226,0x756aa39c,0x026d930a,0x9c0906a9,0xeb0e363f,0x72076785,0x05005713,
	0x95bf4a82,0xe2b87a14,0x7bb12bae,0x0cb61b38,0x92d28e9b,0xe5d5be0d,0x7cdcefb7,0x0bdbdf21,
	0x86d3d2d4,0xf1d4e242,0x68ddb3f8,0x1fda836e,0x81be16cd,0xf6b9265b,0x6fb077e1,0x18b74777,
	0x88085ae6,0xff0f6a70,0x66063bca,0x11010b5c,0x8f659eff,0xf862ae69,0x616bffd3,0x166ccf45,
	0xa00ae278,0xd70dd2ee,0x4e048354,0x3903b3c2,0xa7672661,0xd06016f7,0x4969474d,0x3e6e77db,
	0xaed16a4a,0xd9d65adc,0x40df0b66,0x37d83bf0,0xa9bcae53,0xdebb9ec5,0x47b2cf7f,0x30b5ffe9,
	0xbdbdf21c,0xcabac28a,0x53b39330,0x24b4a3a6,0xbad03605,0xcdd70693,0x54de5729,0x23d967bf,
	0xb3667a2e,0xc4614ab8,0x5d681b02,0x2a6f2b94,0xb40bbe37,0xc30c8ea1,0x5a05df1b,0x2d02ef8d,
};

const uint64_t XADCRCTable_c96c5795d7870f42[256]=
{
	0x0000000000000000,0xb32e4cbe03a75f6f,0xf4843657a840a05b,0x47aa7ae9abe7ff34,
	0x7bd0c384ff8f5e33,0xc8fe8f3afc28015c,0x8f54f5d357cffe68,0x3c7ab96d5468a107,
	0xf7a18709ff1ebc66,0x448fcbb7fcb9e309,0x0325b15e575e1c3d,0xb00bfde054f94352,
	0x8c71448d0091e255,0x3f5f08330336bd3a,0x78f572daa8d1420e,0xcbdb3e64ab761d61,
	0x7d9ba13851336649,0xceb5ed8652943926,0x891f976ff973c612,0x3a31dbd1fad4997d,
	0x064b62bcaebc387a,0xb5652e02ad1b6715,0xf2cf54eb06fc9821,0x41e11855055bc74e,
	0x8a3a2631ae2dda2f,0x39146a8fad8a8540,0x7ebe1066066d7a74,0xcd905cd805ca251b,
	0xf1eae5b551a2841c,0x42c4a90b5205db73,0x056ed3e2f9e22447,0xb6409f5cfa457b28,
	0xfb374270a266cc92,0x48190ecea1c193fd,0x0fb374270a266cc9,0xbc9d3899098133a6,
	0x80e781f45de992a1,0x33c9cd4a5e4ecdce,0x7463b7a3f5a932fa,0xc74dfb1df60e6d95,
	0x0c96c5795d7870f4,0xbfb889c75edf2f9b,0xf812f32ef538d0af,0x4b3cbf90f69f8fc0,
	0x774606fda2f72ec7,0xc4684a43a15071a8,0x83c230aa0ab78e9c,0x30ec7c140910d1f3,
	0x86ace348f355aadb,0x3582aff6f0f2f5b4,0x7228d51f5b150a80,0xc10699a158b255ef,
	0xfd7c20cc0cdaf4e8,0x4e526c720f7dab87,0x09f8169ba49a54b3,0xbad65a25a73d0bdc,
	0x710d64410c4b16bd,0xc22328ff0fec49d2,0x85895216a40bb6e6,0x36a71ea8a7ace989,
	0x0adda7c5f3c4488e,0xb9f3eb7bf06317e1,0xfe5991925b84e8d5,0x4d77dd2c5823b7ba,
	0x64b62bcaebc387a1,0xd7986774e864d8ce,0x90321d9d438327fa,0x231c512340247895,
	0x1f66e84e144cd992,0xac48a4f017eb86fd,0xebe2de19bc0c79c9,0x58cc92a7bfab26a6,
	0x9317acc314dd3bc7,0x2039e07d177a64a8,0x67939a94bc9d9b9c,0xd4bdd62abf3ac4f3,
	0xe8c76f47eb5265f4,0x5be923f9e8f53a9b,0x1c4359104312c5af,0xaf6d15ae40b59ac0,
	0x192d8af2baf0e1e8,0xaa03c64cb957be87,0xeda9bca512b041b3,0x5e87f01b11171edc,
	0x62fd4976457fbfdb,0xd1d305c846d8e0b4,0x96797f21ed3f1f80,0x2557339fee9840ef,
	0xee8c0dfb45ee5d8e,0x5da24145464902e1,0x1a083bacedaefdd5,0xa9267712ee09a2ba,
	0x955cce7fba6103bd,0x267282c1b9c65cd2,0x61d8f8281221a3e6,0xd2f6b4961186fc89,
	0x9f8169ba49a54b33,0x2caf25044a02145c,0x6b055fede1e5eb68,0xd82b1353e242b407,
	0xe451aa3eb62a1500,0x577fe680b58d4a6f,0x10d59c691e6ab55b,0xa3fbd0d71dcdea34,
	0x6820eeb3b6bbf755,0xdb0ea20db51ca83a,0x9ca4d8e41efb570e,0x2f8a945a1d5c0861,
	0x13f02d374934a966,0xa0de61894a93f609,0xe7741b60e174093d,0x545a57dee2d35652,
	0xe21ac88218962d7a,0x5134843c1b317215,0x169efed5b0d68d21,0xa5b0b26bb371d24e,
	0x99ca0b06e7197349,0x2ae447b8e4be2c26,0x6d4e3d514f59d312,0xde6071ef4cfe8c7d,
	0x15bb4f8be788911c,0xa6950335e42fce73,0xe13f79dc4fc83147,0x521135624c6f6e28,
	0x6e6b8c0f1807cf2f,0xdd45c0b11ba09040,0x9aefba58b0476f74,0x29c1f6e6b3e0301b,
	0xc96c5795d7870f42,0x7a421b2bd420502d,0x3de861c27fc7af19,0x8ec62d7c7c60f076,
	0xb2bc941128085171,0x0192d8af2baf0e1e,0x4638a2468048f12a,0xf516eef883efae45,
	0x3ecdd09c2899b324,0x8de39c222b3eec4b,0xca49e6cb80d9137f,0x7967aa75837e4c10,
	0x451d1318d716ed17,0xf6335fa6d4b1b278,0xb199254f7f564d4c,0x02b769f17cf11223,
	0xb4f7f6ad86b4690b,0x07d9ba1385133664,0x4073c0fa2ef4c950,0xf35d8c442d53963f,
	0xcf273529793b3738,0x7c0979977a9c6857,0x3ba3037ed17b9763,0x888d4fc0d2dcc80c,
	0x435671a479aad56d,0xf0783d1a7a0d8a02,0xb7d247f3d1ea7536,0x04fc0b4dd24d2a59,
	0x3886b22086258b5e,0x8ba8fe9e8582d431,0xcc0284772e652b05,0x7f2cc8c92dc2746a,
	0x325b15e575e1c3d0,0x8175595b76469cbf,0xc6df23b2dda1638b,0x75f16f0cde063ce4,
	0x498bd6618a6e9de3,0xfaa59adf89c9c28c,0xbd0fe036222e3db8,0x0e21ac88218962d7,
	0xc5fa92ec8aff7fb6,0x76d4de52895820d9,0x317ea4bb22bfdfed,0x8250e80521188082,
	0xbe2a516875702185,0x0d041dd676d77eea,0x4aae673fdd3081de,0xf9802b81de97deb1,
	0x4fc0b4dd24d2a599,0xfceef8632775faf6,0xbb44828a8c9205c2,0x086ace348f355aad,
	0x34107759db5dfbaa,0x873e3be7d8faa4c5,0xc094410e731d5bf1,0x73ba0db070ba049e,
	0xb86133d4dbcc19ff,0x0b4f7f6ad86b4690,0x4ce50583738cb9a4,0xffcb493d702be6cb,
	0xc3b1f050244347cc,0x709fbcee27e418a3,0x3735c6078c03e797,0x841b8ab98fa4b8f8,
	0xadda7c5f3c4488e3,0x1ef430e13fe3d78c,0x595e4a08940428b8,0xea7006b697a377d7,
	0xd60abfdbc3cbd6d0,0x6524f365c06c89bf,0x228e898c6b8b768b,0x91a0c532682c29e4,
	0x5a7bfb56c35a3485,0xe955b7e8c0fd6bea,0xaeffcd016b1a94de,0x1dd181bf68bdcbb1,
	0x21ab38d23cd56ab6,0x9285746c3f7235d9,0xd52f0e859495caed,0x6601423b97329582,
	0xd041dd676d77eeaa,0x636f91d96ed0b1c5,0x24c5eb30c5374ef1,0x97eba78ec690119e,
	0xab911ee392f8b099,0x18bf525d915feff6,0x5f1528b43ab810c2,0xec3b640a391f4fad,
	0x27e05a6e926952cc,0x94ce16d091ce0da3,0xd3646c393a29f297,0x604a2087398eadf8,
	0x5c3099ea6de60cff,0xef1ed5546e415390,0xa8b4afbdc5a6aca4,0x1b9ae303c601f3cb,
	0x56ed3e2f9e224471,0xe5c372919d851b1e,0xa26908783662e42a,0x114744c635c5bb45,
	0x2d3dfdab61ad1a42,0x9e13b115620a452d,0xd9b9cbfcc9edba19,0x6a978742ca4ae576,
	0xa14cb926613cf817,0x1262f598629ba778,0x55c88f71c97c584c,0xe6e6c3cfcadb0723,
	0xda9c7aa29eb3a624,0x69b2361c9d14f94b,0x2e184cf536f3067f,0x9d36004b35545910,
	0x2b769f17cf112238,0x9858d3a9ccb67d57,0xdff2a94067518263,0x6cdce5fe64f6dd0c,
	0x50a65c93309e7c0b,0xe388102d33392364,0xa4226ac498dedc50,0x170c267a9b79833f,
	0xdcd7181e300f9e5e,0x6ff954a033a8c131,0x28532e49984f3e05,0x9b7d62f79be8616a,
	0xa707db9acf80c06d,0x14299724cc279f02,0x5383edcd67c06036,0xe0ada17364673f59,
};

