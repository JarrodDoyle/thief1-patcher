/******************************************************************************
 *    thieffon.c
 *
 *    This file is part of DarkUtils
 *    Copyright (C) 2013 Tom N Harris <telliamed@whoopdedo.org>
 *
 *    This program is free software; you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation; either version 2 of the License, or
 *    (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program; if not, write to the Free Software
 *    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *****************************************************************************/
#define _BSD_SOURCE
#undef __STRICT_ANSI__
#include "defs.h"
#include "Dark/fon.h"

#include <math.h>
#include <getopt.h>
#include <libgen.h>

const uint32	_ctable[] = {
	0x000000, 0xDDDDDD, 0xB6B6B6, 0x969696, 0x7C7C7C, 0x666666, 0x545454, 0x454545,
	0x393939, 0x2F2F2F, 0x272727, 0x202020, 0x1A1A1A, 0x161616, 0x121212, 0x0F0F0F,
	0x0C0C0C, 0x0A0A0A, 0x080808, 0x060606, 0x050505, 0x040404, 0x030303, 0x7A8449,
	0x707A43, 0x65703D, 0x5B6536, 0x0087FE, 0x007DF2, 0x0073E6, 0x0069DA, 0x005FCE,
	0xB18C82, 0xA38178, 0x96776E, 0x886C64, 0x7B615A, 0x6D5650, 0x604C46, 0x52413C,
	0x443632, 0x372B28, 0x29211E, 0x1C1614, 0x0E0B0A, 0xA30202, 0x980202, 0x8E0202,
	0x830202, 0x780101, 0x6D0101, 0x630101, 0x580101, 0x4D0101, 0x380101, 0x220000,
	0x0D0000, 0x083015, 0x072B13, 0x062510, 0x05200E, 0x041A0B, 0x031509, 0x020F06,
	0x8E6D43, 0x87683F, 0x81623C, 0x7A5D38, 0x735734, 0x6D5231, 0x664C2D, 0x60472A,
	0x573F25, 0x4D3820, 0x44301A, 0x3A2915, 0x312110, 0x3E1210, 0x3A110F, 0x36100E,
	0x320E0D, 0x2E0D0C, 0x2A0C0B, 0x260B0A, 0x220A09, 0x1D0807, 0x180606, 0x120504,
	0x0D0303, 0x321D46, 0x2D1A3F, 0x271736, 0x20132C, 0x1A1023, 0x140C1B, 0x0E0912,
	0xEE9A47, 0xDE9042, 0xCF863E, 0xBF7C39, 0xAF7134, 0xA0672F, 0x905D2B, 0x815326,
	0x714922, 0x613F1D, 0x513519, 0x412B14, 0x312110, 0x312110, 0x2E1F0F, 0x2B1D0E,
	0x271A0D, 0x24180C, 0x21160B, 0x1E140A, 0x1B1209, 0x170F07, 0x140D06, 0x110B05,
	0x0A0603, 0xFFFFBD, 0xFFB510, 0xFFAD52, 0xFFFF7B, 0xF1E657, 0xE4CE34, 0xD6B510,
	0x8C7B5A, 0x867555, 0x7F6E4F, 0x79684A, 0x726145, 0x6C5B40, 0x65543A, 0x5C4C33,
	0x54432C, 0x4B3B25, 0x42321E, 0x3A2A17, 0x312110, 0x505B30, 0x4B552D, 0x464F2A,
	0x404927, 0x3B4423, 0x363E20, 0x31381D, 0x2C321A, 0x262C17, 0x212614, 0x1C2011,
	0x171B0D, 0xAD10B5, 0x9C29AD, 0xB51894, 0x9400C6, 0x6300AD, 0x4A0080, 0x310052,
	0x6D7787, 0x666F7E, 0x5F6775, 0x575F6C, 0x505764, 0x494F5A, 0x424752, 0x3B4048,
	0x33373E, 0x2B2E34, 0x222529, 0x1A1C1F, 0x121315, 0x5A3139, 0x542E35, 0x4E2B31,
	0x48272E, 0x42242A, 0x3C2126, 0x361E22, 0x311B1F, 0x2B171B, 0x231316, 0x1B0E11,
	0x130A0C, 0xE71821, 0xCE2118, 0xFF8C18, 0xD97415, 0xB25C12, 0x8C440F, 0x652C0C,
	0x6D5370, 0x664E69, 0x5E4760, 0x564158, 0x4D3B4E, 0x463546, 0x3D2E3D, 0x352835,
	0x2D222D, 0x241B24, 0x1C151C, 0x130E13, 0x0B080B, 0x9C4A4A, 0xA86161, 0xB57777,
	0xC18E8E, 0xCEA5A5, 0xDABBBB, 0xE6D2D2, 0xF3E8E8, 0xFFFFFF, 0x0055C2, 0x004BB6,
	0x0041A2, 0xB5BDFF, 0x8C8CE7, 0x9CADEF, 0x7E9DE2, 0x5F8ED4, 0x417EC7, 0x226EB9,
	0xDED684, 0xCFC87B, 0xC1BA73, 0xB2AC6A, 0xA49E61, 0x959058, 0x878250, 0x746F44,
	0x605C39, 0x4D4A2D, 0x393721, 0x262416, 0x12110A, 0x74959D, 0x97B0B6, 0xBACACE,
	0xDCE5E7, 0xFFFFFF, 0x3A5B4B, 0x466E57, 0x538063, 0x5F936F, 0x6BA57B, 0x00378D,
	0x002D79, 0x002364, 0x001950, 0x000F3B, 0x0000FF, 0x0000FF, 0xFF00FF, 0x000000
};

/* Anti-aliased fonts have a pixel width of 8 bits. */
uint32	_aatable[256] = {0,};

uint8 BLACK_INDEX =	0;
uint8 WHITE_INDEX =	1;
uint8 PINK_INDEX =	254;

#pragma pack(push,1)
typedef union
{
	struct
	{
		uint16 bg;
		uint8 r;
	} w;
	uint8 bgr[3];
} fastcolor_t;
#pragma pack(pop)
static inline Boolean iscolor(const uint8 *pixel, uint8 r, uint8 g, uint8 b)
{
	fastcolor_t *ref = (fastcolor_t*)pixel;
	return ((size_t)pixel & 0x1) ? (ref->bgr[1] == g && ref->bgr[0] == b && ref->bgr[2] == r)
	                     : (ref->w.bg == ((((uint16)g)<<8)|b) && ref->w.r == r);
}
#define IS_PINK(P,X,Y,BPP)	((BPP==1)?(P)[(Y)][(X)]==PINK_INDEX:iscolor(&(P)[(Y)][(X)*(BPP)],255,0,255))
#define IS_BLACK(P,X,Y,BPP)	((BPP==1)?(P)[(Y)][(X)]==BLACK_INDEX:iscolor(&(P)[(Y)][(X)*(BPP)],0,0,0))

static inline uint8 rgb2gray(const uint8 *pixel)
{
	RGBTRIPLE *p = (RGBTRIPLE*)pixel;
	//return (p->rgbtRed>>2) + (p->rgbtGreen>>1) + (p->rgbtBlue>>2);
	//return p->rgbtRed*0.212f + p->rgbtGreen*0.715f + p->rgbtBlue*0.072f;
	return ((uint32)p->rgbtRed*6969 + (uint32)p->rgbtGreen*23434 + (uint32)p->rgbtBlue*2365) / 32768;
}
#define GRAY256(P,X,Y,BPP)	((BPP==1)?(P)[(Y)][(X)]:rgb2gray(&(P)[(Y)][(X)*(BPP)]))
#define GRAY16(P,X,Y,BPP)	((BPP==1)?(P)[(Y)][(X)]:15*rgb2gray(&(P)[(Y)][(X)*(BPP)])/255)

static inline void color2rgb(uint8 **pixels, int x, int y, const RGBQUAD c)
{
	RGBTRIPLE *p = (RGBTRIPLE*)&pixels[y][x*3];
	p->rgbtRed = c.rgbRed;
	p->rgbtGreen = c.rgbGreen;
	p->rgbtBlue = c.rgbBlue;
}

static uint8 lookup_colortable(uint8 **pixels, int x, int y, const RGBQUAD *colors)
{
	RGBTRIPLE *p = (RGBTRIPLE*)&pixels[y][x*3];
	uint32 c = *(uint32*)p & RGB(255,255,255);
	uint8 r = p->rgbtRed, g = p->rgbtGreen, b = p->rgbtBlue;
	int mincolor = 0;
	double mindist = HUGE_VAL;
	for (int i = 0; i < 256; i++)
	{
		if (c == *(const uint32*)(&colors[i]))
			return i;
		double dr = (colors[i].rgbRed - r),
		       dg = (colors[i].rgbGreen - g),
		       db = (colors[i].rgbBlue - b);
		dr = dr*dr + db*db + dg*dg;
		if (dr < mindist)
		{
			mindist = dr;
			mincolor = i;
		}
	}
	return mincolor;
}

static RGBQUAD* make_aatable(int num_colors, int pink_index)
{
	memset(_aatable, 0, sizeof(uint32)*256);
	for (int i = --num_colors; i >= 0; i--)
	{
		int c = (255 * i) / num_colors;
		_aatable[i] = RGB(c,c,c);
	}
	if (pink_index > 0)
		_aatable[pink_index] = RGB(255,0,255);
	return (RGBQUAD*)_aatable;
}

static struct char_info* parse_chars(uint8 **image_rows, int image_width, int image_height, int pixel_size,
                              int first_char, int *num_ret)
{
	int num_chars = 0;
	short current_code = first_char;
	struct char_info *chars = calloc(256,sizeof(struct char_info));
	if (!chars)
	{
		errprintf("Out of memory\n");
		errno = ENOMEM;
		return NULL;
	}
	for (int scany = 0; scany < image_height-1; scany++)
	{
		for (int scanx = 0; scanx < image_width-1; scanx++)
		{
			if (IS_PINK(image_rows,scanx,scany,pixel_size)
			 && (scany == 0 || !IS_PINK(image_rows,scanx,scany-1,pixel_size))
			 && (scanx == 0 || !IS_PINK(image_rows,scanx-1,scany,pixel_size)))
			{
				int boxx = scanx+1;
				while (boxx < image_width
				 && IS_PINK(image_rows,boxx,scany,pixel_size)
				 && !IS_PINK(image_rows,boxx,scany+1,pixel_size))
					boxx++;
				int boxy = scany+1;
				while (boxy < image_height 
				 && IS_PINK(image_rows,scanx,boxy,pixel_size)
				 && !IS_PINK(image_rows,scanx+1,boxy,pixel_size))
					boxy++;
				if (boxx >= image_width || boxy >= image_height
				 || boxx-scanx < 2 || boxy-scany < 2)
				{
					scanx = boxx;
					continue;
				}
				chars[num_chars].code = current_code++;
				chars[num_chars].x = scanx + 1;
				chars[num_chars].y = scany + 1;
				chars[num_chars].width = boxx - scanx - 1;
				chars[num_chars].height = boxy - scany - 1;
				num_chars++;
				if (current_code == 256)
					goto lMAX_CHARS;
				scanx = boxx;
			}
		}
	}
lMAX_CHARS:
	*num_ret = num_chars;
	return chars;
}

static uint8** read_fon(uint8 *fondata, const RGBQUAD *color_table, int *width_ret, int *height_ret, int *color_ret)
{
	struct fon_head *head;
	unsigned short *widths;
	uint8 *bmdata;
	unsigned int num_chars;
	struct char_info *chars;
	uint8 **row_pointers;
	int image_width, image_height;

	int read_fon_p()
	{
		uint8* image_data = malloc(image_height * image_width);
		if (!image_data)
		{
			errprintf("Out of memory\n");
			return ENOMEM;
		}
		memset(image_data, BLACK_INDEX, image_height * image_width);
		uint8 *ptr = image_data;
		for (int n = 0; n < image_height; n++)
		{
			row_pointers[n] = ptr;
			ptr += image_width;
		}
		for (unsigned int n = 0; n < num_chars ; n++)
		{
			int x = chars[n].x;
			int y = chars[n].y++;
			for (int i = 0; i <= chars[n].width+1; i++, x++)
			{
				row_pointers[y][x] = PINK_INDEX;
				row_pointers[y+head->num_rows+1][x] = PINK_INDEX;
			}
			x = chars[n].x++;
			for (int i = 0; i <= head->num_rows; i++, y++)
			{
				row_pointers[y][x] = PINK_INDEX;
				row_pointers[y][x+chars[n].width+1] = PINK_INDEX;
			}
		}
		if (head->format == 0)
		{
			ptr = bmdata;
			for (unsigned int i = 0; i < head->num_rows; i++)
			{
				for (unsigned int n = 0; n < num_chars; n++)
				{
					int y = chars[n].column;
					for (int x = 0; x < chars[n].width; y++, x++)
						row_pointers[chars[n].y+i][chars[n].x+x] = ((ptr[y/8]>>(7-(y%8)))&1) ? WHITE_INDEX : BLACK_INDEX;
				}
				ptr += head->row_width;
			}
		}
		else
		{
			ptr = bmdata;
			for (unsigned int i = 0; i < head->num_rows; i++)
			{
				for (unsigned int n = 0; n < num_chars; n++)
				{
					memcpy(row_pointers[chars[n].y+i]+chars[n].x, ptr, chars[n].width);
					ptr += chars[n].width;
				}
			}
		}
		return 0;
	}

	int read_fon_bgr(const RGBQUAD *pal)
	{
		const RGBQUAD cPink = {255,0,255,0};
		uint8* image_data = malloc(image_height * image_width * 3);
		if (!image_data)
		{
			errprintf("Out of memory\n");
			return ENOMEM;
		}
		memset(image_data, 0, image_height * image_width * 3);
		uint8 *ptr = image_data;
		for (int n = 0; n < image_height; n++)
		{
			row_pointers[n] = ptr;
			ptr += image_width * 3;
		}
		for (unsigned int n = 0; n < num_chars ; n++)
		{
			int x = chars[n].x;
			int y = chars[n].y++;
			for (int i = 0; i <= chars[n].width+1; i++, x++)
			{
				color2rgb(row_pointers, x, y, cPink);
				color2rgb(row_pointers, x, y+head->num_rows+1, cPink);
			}
			x = chars[n].x++;
			for (int i = 0; i <= head->num_rows; i++, y++)
			{
				color2rgb(row_pointers, x, y, cPink);
				color2rgb(row_pointers, x+chars[n].width+1, y, cPink);
			}
		}
		ptr = bmdata;
		for (unsigned int i = 0; i < head->num_rows; i++)
		{
			for (unsigned int n = 0; n < num_chars; n++)
			{
				for (unsigned int j = 0; j < chars[n].width; j++)
					color2rgb(row_pointers, chars[n].x+j, chars[n].y+i, pal[ptr[j]]);
				ptr += chars[n].width;
			}
		}
		return 0;
	}

	head = (struct fon_head*)fondata;
	switch (head->format)
	{
	case 0:
		stdprintf("Monochrome format\n");
		*color_ret = 1; break;
	case 1:
		stdprintf("4-bit grayscale format\n");
		*color_ret = 2; break;
	case 2:
		stdprintf("8-bit grayscale format\n");
		*color_ret = 3; break;
	case 0xCCCC:
		stdprintf("8-bit color format (%s palette)\n", head->palette == 1 ? _T("standard") : _T("custom"));
		*color_ret = head->palette == 1 ? -1 : 0;
		break;
	default:
		stdprintf("Unknown pixel format! (0x%04X) Assuming 8-bit color\n", head->format);
		*color_ret = 0;
		break;
	}
	widths = (unsigned short*)(fondata + head->width_offset);
	bmdata = fondata + head->bm_offset;
	if (head->bm_offset < head->width_offset)
	{
		errno = EILSEQ;
		return NULL;
	}
	num_chars = head->last_char - head->first_char + 1;
	chars = (struct char_info*)calloc(num_chars, sizeof(struct char_info));
	if (!chars)
	{
		errprintf("Out of memory\n");
		errno = ENOMEM;
		return NULL;
	}
	image_height = ((num_chars / 16) + 2) * (head->num_rows + 4);
	row_pointers = calloc(image_height, sizeof(char*));
	if (!row_pointers)
	{
		errprintf("Out of memory\n");
		free(chars);
		errno = ENOMEM;
		return NULL;
	}
	{
		int y = (head->num_rows / 2) + 2;
		int x = 2;
		image_width = 2;
		for (unsigned int n = 0; n < num_chars; n++)
		{
			chars[n].code = head->first_char + n;
			chars[n].column = widths[n];
			chars[n].width = widths[n+1] - widths[n];
			chars[n].x = x;
			chars[n].y = y;
			x += chars[n].width + 6;
			if ((n&0xF) == 0xF)
			{
				y += head->num_rows + 4;
				if (x > image_width)
					image_width = x;
				x = 2;
			}
		}
		if (x > image_width)
			image_width = x;
	}
	int err;
	if (head->format != 0
	 && memchr(bmdata, PINK_INDEX, head->row_width * head->num_rows))
	{
		RGBQUAD *pal = (RGBQUAD*)color_table;
		*color_ret = 24;
		switch (head->format)
		{
		case 1:
			pal = make_aatable(16, -1); break;
		case 2:
			pal = make_aatable(256, -1); break;
		default:
			if (head->palette == 1)
				pal = (RGBQUAD*)_ctable;
			break;
		}
		err = read_fon_bgr(pal);
	}
	else
		err = read_fon_p();
	if (err != 0)
	{
		free(row_pointers);
		free(chars);
		errno = ENOMEM;
		return NULL;
	}
	free(chars);
	stdprintf("Read %d glyphs (first char = 0x%02x)\n", num_chars, head->first_char);
	*width_ret = image_width;
	*height_ret = image_height;
	return row_pointers;
}

static int write_fon(HANDLE hFonFile, uint8 **image_rows, int pixel_size, const RGBQUAD *color_table,
              struct char_info *chars, int num_chars, int color)
{
	struct fon_head head;
	DWORD bytes;

	memset(&head, 0, sizeof(struct fon_head));
	switch (color)
	{
	case 1:
		head.format = 0; break;
	case 2:
	case 3:
		head.format = color - 1;
		head.flags = FON_FRACTSPACING|FON_VERTSPACEADJUST;
		break;
	default:
		head.format = 0xCCCC;
		if (color < 0)
			head.palette = 1;
		break;
	}
	head.first_char = chars[0].code;
	head.last_char = chars[0].code + num_chars - 1;
	head.width_offset = sizeof(struct fon_head);

	unsigned short column = 0;
	SetFilePointer(hFonFile, sizeof(struct fon_head), NULL, FILE_BEGIN);
	for (int n = 0; n < num_chars; n++)
	{
		chars[n].column = column;
		WriteFile(hFonFile, &column, 2, &bytes, NULL);
		column += chars[n].width;
		if (chars[n].height > head.num_rows)
			head.num_rows = chars[n].height;
	}
	WriteFile(hFonFile, &column, 2, &bytes, NULL);
	head.bm_offset = SetFilePointer(hFonFile, 0, NULL, FILE_CURRENT);
	head.row_width = (color == 1) ? (column+7)>>3 : column;
	SetFilePointer(hFonFile, 0, NULL, FILE_BEGIN);
	WriteFile(hFonFile, &head, sizeof(struct fon_head), &bytes, NULL);
	SetFilePointer(hFonFile, head.bm_offset, NULL, FILE_BEGIN);
	uint8 *row_data = malloc(head.row_width);
	if (!row_data)
	{
		errprintf("Out of memory\n");
		return ENOMEM;
	}
	if (color == 1)
	{
		for (int row = 0; row < head.num_rows; row++)
		{
			memset(row_data, BLACK_INDEX, head.row_width);
			column = 7;
			bytes = 0;
			int c = 0;
			for (int n = 0; n < num_chars; n++)
			{
				if (row < chars[n].height)
				{
					for (int b = 0; b < chars[n].width; b++)
					{
						c |= (IS_BLACK(image_rows,chars[n].x+b,chars[n].y+row,pixel_size)?0:1) << column;
						if (column == 0)
						{
							row_data[bytes++] = c;
							column = 7;
							c = 0;
						}
						else
							column--;
					}
				}
				else
				{
					if (chars[n].width > 8 || chars[n].width > column)
						row_data[bytes] = c;
					c = 0;
					bytes += chars[n].width >> 3;
					if (column < (chars[n].width & 0x7))
					{
						bytes++;
						column += 8 - (chars[n].width & 0x7);
					}
					else
						column -= chars[n].width & 0x7;
				}
			}
			if (column < 7)
			{
				row_data[bytes] = c;
			}
			WriteFile(hFonFile, row_data, head.row_width, &bytes, NULL);
		}
	}
	else if (color == 2)
	{
		for (int row = 0; row < head.num_rows; row++)
		{
			memset(row_data, BLACK_INDEX, head.row_width);
			for (int n = 0; n < num_chars; n++)
			{
				if (row < chars[n].height)
				{
					for (int b = 0; b < chars[n].width; b++)
					{
						row_data[chars[n].column+b] = GRAY16(image_rows,chars[n].x+b,chars[n].y+row,pixel_size);
					}
				}
			}
			WriteFile(hFonFile, row_data, head.row_width, &bytes, NULL);
		}
	}
	else if (color == 3)
	{
		for (int row = 0; row < head.num_rows; row++)
		{
			memset(row_data, BLACK_INDEX, head.row_width);
			for (int n = 0; n < num_chars; n++)
			{
				if (row < chars[n].height)
				{
					for (int b = 0; b < chars[n].width; b++)
					{
						row_data[chars[n].column+b] = GRAY256(image_rows,chars[n].x+b,chars[n].y+row,pixel_size);
					}
				}
			}
			WriteFile(hFonFile, row_data, head.row_width, &bytes, NULL);
		}
	}
	else if (pixel_size == 1)
	{
		for (int row = 0; row < head.num_rows; row++)
		{
			memset(row_data, BLACK_INDEX, head.row_width);
			for (int n = 0; n < num_chars; n++)
			{
				if (row < chars[n].height)
				{
					memcpy(row_data+chars[n].column, image_rows[chars[n].y+row]+chars[n].x, chars[n].width);
				}
			}
			WriteFile(hFonFile, row_data, head.row_width, &bytes, NULL);
		}
	}
	else
	{
		for (int row = 0; row < head.num_rows; row++)
		{
			memset(row_data, BLACK_INDEX, head.row_width);
			for (int n = 0; n < num_chars; n++)
			{
				if (row < chars[n].height)
				{
					for (int b = 0; b < chars[n].width; b++)
					{
						row_data[chars[n].column+b] = lookup_colortable(image_rows,chars[n].x+b,chars[n].y+row,color_table);
					}
				}
			}
			WriteFile(hFonFile, row_data, head.row_width, &bytes, NULL);
		}
	}
	free(row_data);

	return 0;
}

static int write_image_p(HANDLE hImageFile, const RGBQUAD *color_table, uint8 **row_pointers, int image_width, int image_height)
{
	BITMAPFILEHEADER	file_head;
	BITMAPINFOHEADER	bm_head;
	int 	row_width, row;
	DWORD	dwBytes;
	char	zero[4] = {0,0,0,0};

	file_head.bfType = 0x4D42;
	file_head.bfReserved1 = 0;
	file_head.bfReserved2 = 0;
	file_head.bfOffBits = sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER) + (sizeof(RGBQUAD)*256);
	bm_head.biSize = sizeof(BITMAPINFOHEADER);
	bm_head.biWidth = image_width;
	bm_head.biHeight = image_height;
	bm_head.biPlanes = 1;
	bm_head.biBitCount = 8;
	bm_head.biCompression = 0;
	bm_head.biXPelsPerMeter = 0xB13;
	bm_head.biYPelsPerMeter = 0xB13;
	bm_head.biClrUsed = 256;
	bm_head.biClrImportant = 256;
	row_width = (image_width + 3) & ~3;
	bm_head.biSizeImage = row_width * image_height;
	file_head.bfSize = file_head.bfOffBits + bm_head.biSizeImage;

	if (!WriteFile(hImageFile, &file_head, sizeof(BITMAPFILEHEADER), &dwBytes, NULL))
		return GetLastError();
	if (!WriteFile(hImageFile, &bm_head, sizeof(BITMAPINFOHEADER), &dwBytes, NULL))
		return GetLastError();
	if (!WriteFile(hImageFile, color_table, sizeof(RGBQUAD)*256, &dwBytes, NULL))
		return GetLastError();
	row_width -= image_width;
	for (row = image_height-1; row >= 0; row--)
	{
		if (!WriteFile(hImageFile, row_pointers[row], image_width, &dwBytes, NULL))
			return GetLastError();
		if (row_width != 0)
		{
			if (!WriteFile(hImageFile, zero, row_width, &dwBytes, NULL))
				return GetLastError();
		}
	}
	return 0;
}

static int write_image_bgr(HANDLE hImageFile, uint8 **row_pointers, int image_width, int image_height)
{
	BITMAPFILEHEADER	file_head;
	BITMAPINFOHEADER	bm_head;
	int 	row_width, row;
	DWORD	dwBytes;
	char	zero[4] = {0,0,0,0};

	file_head.bfType = 0x4D42;
	file_head.bfReserved1 = 0;
	file_head.bfReserved2 = 0;
	file_head.bfOffBits = sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER);
	bm_head.biSize = sizeof(BITMAPINFOHEADER);
	bm_head.biWidth = image_width;
	bm_head.biHeight = image_height;
	bm_head.biPlanes = 1;
	bm_head.biBitCount = 24;
	bm_head.biCompression = 0;
	bm_head.biXPelsPerMeter = 0xB13;
	bm_head.biYPelsPerMeter = 0xB13;
	bm_head.biClrUsed = 0;
	bm_head.biClrImportant = 0;
	image_width *= 3;
	row_width = (image_width + 3) & ~3;
	bm_head.biSizeImage = row_width * image_height;
	file_head.bfSize = file_head.bfOffBits + bm_head.biSizeImage;

	if (!WriteFile(hImageFile, &file_head, sizeof(BITMAPFILEHEADER), &dwBytes, NULL))
		return GetLastError();
	if (!WriteFile(hImageFile, &bm_head, sizeof(BITMAPINFOHEADER), &dwBytes, NULL))
		return GetLastError();
	row_width -= image_width;
	for (row = image_height-1; row >= 0; row--)
	{
		if (!WriteFile(hImageFile, row_pointers[row], image_width, &dwBytes, NULL))
			return GetLastError();
		if (row_width != 0)
		{
			if (!WriteFile(hImageFile, zero, row_width, &dwBytes, NULL))
				return GetLastError();
		}
	}
	return 0;
}

static int fon2image(const cchar_t *fon_name, const cchar_t *image_name, const cchar_t *pal_name)
{
	int err;

	stdprintf("Converting font %s to %s...\n", fon_name, image_name);
	HANDLE hFile = OpenFile(fon_name);
	if (hFile == INVALID_HANDLE_VALUE)
	{
		err = GetLastError();
		errprintf("Cannot read file %s\n", fon_name);
		return err;
	}
	uint8 *fon_data = loadfile(hFile);
	err = GetLastError();
	if (!fon_data)
	{
		errprintf("Cannot read file %s\n", fon_name);
		CloseHandle(hFile);
		return err;
	}
	RGBQUAD *pal_data = load_pal(pal_name);
	if (!pal_data)
	{
		err = errno;
		errprintf("Cannot read file %s\n", pal_name);
		unloadfile(hFile, fon_data);
		CloseHandle(hFile);
		return err;
	}
	int image_width, image_height, color;
	uint8 **image_rows = read_fon(fon_data, (RGBQUAD*)pal_data, &image_width, &image_height, &color);
	unloadfile(hFile, fon_data);
	CloseHandle(hFile);
	if (!image_rows)
	{
		errno = err;
		free_pal(pal_data);
		return err;
	}
	hFile = CreateFile(image_name);
	if (hFile == INVALID_HANDLE_VALUE)
	{
		err = GetLastError();
		errprintf("Cannot write file %s\n", image_name);
		free(*image_rows);
		free(image_rows);
		free_pal(pal_data);
		return err;
	}
	if (color == 24)
	{
		err = write_image_bgr(hFile, image_rows, image_width, image_height);
	}
	else
	{
		if (pal_data == (RGBQUAD*)_ctable)
		{
			if (color == 2)
				pal_data = make_aatable(16, PINK_INDEX);
			else if (color == 3)
				pal_data = make_aatable(256, PINK_INDEX);
		}
		err = write_image_p(hFile, (RGBQUAD*)pal_data, image_rows, image_width, image_height);
	}
	CloseHandle(hFile);
	free(*image_rows);
	free(image_rows);
	free_pal(pal_data);
	return err;
}

static int image2fon(const cchar_t *image_name, const cchar_t *fon_name, const cchar_t *pal_name, int first_char, int color)
{
	int err = 0;

	stdprintf("Converting image %s to %s...\n", image_name, fon_name);
	HANDLE hFile = OpenFile(image_name);
	if (hFile == INVALID_HANDLE_VALUE)
	{
		err = GetLastError();
		errprintf("Cannot read file %s\n", image_name);
		return err;
	}
	int image_width, image_height, pixel_size;
	uint8 **image_rows = read_image(hFile, &image_width, &image_height, &pixel_size, NULL);
	CloseHandle(hFile);
	if (!image_rows)
	{
		err = errno;
		return err;
	}
	RGBQUAD *pal_data = load_pal(pal_name);
	if (!pal_data)
	{
		err = errno;
		errprintf("Cannot read file %s\n", pal_name);
		free(image_rows);
		return err;
	}
	int num_chars;
	struct char_info *chars = parse_chars(image_rows, image_width, image_height, pixel_size, first_char, &num_chars);
	if (!chars)
	{
		err = errno;
		free(image_rows);
		free_pal(pal_data);
		return err;
	}
	stdprintf("Found %d glyphs.\n", num_chars);
	if (num_chars > 0)
	{
		HANDLE hFonFile = CreateFile(fon_name);
		if (hFonFile == INVALID_HANDLE_VALUE)
		{
			errprintf("Cannot write file %s\n", fon_name);
			free(chars);
			free(image_rows);
			free_pal(pal_data);
			return ENOENT;
		}
		err = write_fon(hFonFile, image_rows, pixel_size, pal_data, chars, num_chars, color);
		CloseHandle(hFonFile);
	}
	free(chars);
	free(image_rows);
	free_pal(pal_data);
	return 0;
}

#if UNICODE
static inline wchar_t* rightmost(const wchar_t *str, wchar_t ch)
{
	return wcsrchr(str, ch) ?: ((wchar_t*)str + wcslen(str));
}
static Boolean is_ext(const wchar_t *str, const wchar_t *ext)
{
	const wchar_t *x = wcsrchr(str, L'.') ?: (str + wcslen(str));
	return _wcsicmp(x, ext) == 0;
}

static wchar_t* change_or_add_ext(wchar_t *dst, const wchar_t *src, const wchar_t *ext)
{
	wcscpy(dst, src);
	wchar_t *x = wcsrchr(dst, L'.');
	if (x && _wcsicmp(x, ext) != 0)
		wcscpy(x, ext);
	else
		wcscat(dst, ext);
	return dst;
}
#else
static Boolean is_ext(const char *str, const char *ext)
{
	const char *x = strrchr(str, '.') ?: (str + strlen(str));
	return strcasecmp(x, ext) == 0;
}

static char* change_or_add_ext(char *dst, const char *src, const char *ext)
{
	strcpy(dst, src);
	char *x = strrchr(dst, '.');
	if (x && strcasecmp(x, ext) != 0)
		strcpy(x, ext);
	else
		strcat(dst, ext);
	return dst;
}
#endif

cchar_t * program = NULL;

static void print_help(void)
{
	stdprintf("Copyright (C) 2004-2013 Tom N Harris <telliamed@whoopdedo.org>\n"
	        "This is free software; see the source for copying conditions.\n"
	        "There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A \n"
	        "PARTICULAR PURPOSE.\n"
	        "usage: %s -c [-m|-a|-A] [-s] [-f num] [-b num] [-p num] [-w num] bmp [fon]\n"
	        "       %s -d [-b num] [-p num] [-w num] fon_file [image_file [pal_file]]\n",
		program, program);
}

int main(int argc, char **argv)
{
	int first = 32;
	int color = 0;
	int table = 0;
	int err = 0;
	int conv = 0;

	stdprintf("Thief Font Converter 1.2\n");
#if UNICODE
	int wargc;
	wchar_t **wargv = CommandLineToArgvW(GetCommandLineW(), &wargc);
	if (!wargv || wargc != argc)
		return EINVAL;

	{
		wchar_t *x = wcsrchr(wargv[0], L'\\');
		wchar_t *y = wcsrchr(wargv[0], L'/');
		if (y > x)
			x = y;
		program = wcsdup(x ? (x+1) : wargv[0]);
		x = wcsrchr(program, L'.');
		if (x && _wcsicmp(x, L".exe")==0)
			*x = 0;
	}
#else
#define wargv argv
#define wargc argc
	{
		program = strdup(argv[0]);
		program = basename(program);
		char *x = strrchr(program, '.');
		if (x && strcasecmp(x, ".exe")==0)
			*x = 0;
	}
#endif

	{
		char c;
		while ((c = getopt(argc, argv, "cdb:p:w:maAsf:ht:")) != EOF)
		{
			switch (c)
			{
			case 'b':
				BLACK_INDEX = strtoul(optarg, NULL, 0);
				break;
			case 'p':
				PINK_INDEX = strtoul(optarg, NULL, 0);
				break;
			case 'w':
				WHITE_INDEX = strtoul(optarg, NULL, 0);
				break;
			case 'f':
				first = strtoul(optarg, NULL, 0);
				break;
			case 'm':
				color = 1;
				break;
			case 'a':
				color = 2;
				break;
			case 'A':
				color = 3;
				break;
			case 's':
				table = 1;
				break;
			case 'c':
				conv = 1;
				break;
			case 'd':
				conv = 2;
				break;
			default:
				print_help();
				goto EXIT;
			}
		}
	}

	if (optind >= argc)
	{
		print_help();
		goto EXIT;
	}

	if (conv == 0)
	{
		if (is_ext(wargv[optind], _T(".fon")))
			conv = 2;
		else if (is_ext(wargv[optind], _T(".bmp"))
		      || is_ext(wargv[optind], _T(".gif"))
		      || is_ext(wargv[optind], _T(".pcx")))
			conv = 1;
		else
		{
			print_help();
			goto EXIT;
		}
	}

	if (conv == 1)
	{
		cchar_t *fon;
		cchar_t *image = wargv[optind++];
		if (optind >= argc)
		{
			fon = alloca((cstrlen(image) + 5) * sizeof(cchar_t));
			change_or_add_ext(fon, image, _T(".fon"));
		}
		else
			fon = wargv[optind++];
		cchar_t *pal = (optind < argc) ? wargv[optind] : NULL;
		if (color == 0 && table == 1)
			color = -1;
		err = image2fon(image, fon, pal, first, color);
	}
	else if (conv == 2)
	{
		cchar_t *image;
		cchar_t *fon = wargv[optind++];
		if (optind >= argc)
		{
			image = alloca((cstrlen(fon) + 5) * sizeof(cchar_t));
			change_or_add_ext(image, fon, _T(".bmp"));
		}
		else
			image = wargv[optind++];
		cchar_t *pal = (optind < argc) ? wargv[optind] : NULL;
		err = fon2image(fon, image, pal);
	}

EXIT:
#if UNICODE
	LocalFree(wargv);
#endif
	return err;
}

