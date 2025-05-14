/******************************************************************************
 *    fon.c
 *
 *    This file is part of DarkUtils/ParchEd
 *    Copyright (C) 2004 Tom N Harris <telliamed@whoopdedo.cjb.net>
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

#include "fon.h"
#include "parched.h"

static const COLORREF	_ctable[] = {
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

/* Anti-aliased fonts have a pixel width of 8 bits, but only the low 4 bits are used. */
static const COLORREF	_aatable1[] = {
	0xFFFFFF, 0xEEEEEE, 0xDDDDDD, 0xCCCCCC, 0xBBBBBB, 0xAAAAAA, 0x999999, 0x888888,
	0x777777, 0x666666, 0x555555, 0x444444, 0x333333, 0x222222, 0x111111, 0x000000,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF,
	0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFF00FF, 0xFFFFFF
};
static const COLORREF	_aatable2[] = {
	0x000000, 0x111111, 0x222222, 0x333333, 0x444444, 0x555555, 0x666666, 0x777777,
	0x888888, 0x999999, 0xAAAAAA, 0xBBBBBB, 0xCCCCCC, 0xDDDDDD, 0xEEEEEE, 0xFFFFFF,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,
	0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
};

/*
static char BLACK_INDEX =	0;
static char WHITE_INDEX =	1;
static char PINK_INDEX =	254;
*/

#ifndef DSTCOPY
#define DSTCOPY		0x00AA0029
#endif
#define MASKROP		MAKEROP4(SRCCOPY,DSTCOPY)

extern HWND gMainWin;

static char* loadfile(HANDLE hFile)
{
	HANDLE hFileMap;
	char *pRet;

	hFileMap = CreateFileMapping(hFile, NULL, PAGE_READONLY, 0, 0, NULL);
	if (!hFileMap)
	{
		ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
		return NULL;
	}
	pRet = MapViewOfFile(hFileMap, FILE_MAP_READ, 0, 0, 0);
	if (!pRet)
		ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
	CloseHandle(hFileMap);
	return pRet;
}

static char* read_fon(const char *fondata, struct char_info *chars, int *width_ret, int *height_ret, int *color_ret)
{
	const struct fon_head *head;
	const unsigned short *widths;
	const char *bmdata;
	unsigned int num_chars;
	char *image_data;
	int image_width, image_height;
	int row_width;
	unsigned int n;
	const char *iptr;
	char *optr;
	
	head = (struct fon_head*)fondata;
	widths = (unsigned short*)(fondata + head->width_offset);
	bmdata = fondata + head->bm_offset;
	if (head->bm_offset < head->width_offset)
		return NULL;
	num_chars = head->last_char - head->first_char + 1;
	if (num_chars > 256)
	{
		return NULL;
	}
	image_height = head->num_rows;
	row_width = (head->row_width + 3) & ~3;
	image_data = (char*)LocalAlloc(LPTR, row_width*image_height);
	if (!image_data)
	{
		ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
		return NULL;
	}
	for (n=0; n<256; n++)
	{
		chars[n].code = n;
		chars[n].column = 0;
		chars[n].width = 0;
		chars[n].height = image_height;
		chars[n].x = 0;
		chars[n].y = 0;
	}
	for (n = 0; n < num_chars; n++)
	{
		chars[head->first_char+n].column = widths[n];
		chars[head->first_char+n].width = widths[n+1] - widths[n];
	}
	image_width = widths[n];
	iptr = bmdata;
	optr = image_data;
	for (n = 0; (int)n < image_height; n++)
	{
		CopyMemory(optr, iptr, head->row_width);
		optr += row_width;
		iptr += head->row_width;
	}
	*width_ret = image_width;
	*height_ret = image_height;
	switch (head->format)
	{
	case 0:
		*color_ret = 1; break;
	case 1:
		*color_ret = 2; break;
	case 0xCCCC:
		*color_ret = (head->palette == 1) ? -1 : 0;
		break;
	default:
		*color_ret = 0;
		break;
	}
	return image_data;
}

static int make_image(fon_image *fon, const char *fon_bits, int image_width, int image_height, RGBQUAD *ctable, BOOL is_mono)
{
	COLORREF _mono[2];
	BITMAPINFO *bmi;
	HDC hdc;
	HBITMAP bmp;
	int ctablesize;
	int rowsize, mrowsize;
	char *mask_bits;
	const char *iptr;
	char *optr;
	int x, y, i, c;

	if (! is_mono)
	{
		ctablesize = 256;
		rowsize = (image_width + 3) & ~3;
	}
	else
	{
		ctablesize = 2;
		_mono[0] = 0;
		_mono[1] = ((COLORREF*)ctable)[255];
		ctable = (RGBQUAD*)_mono;
		rowsize = ((image_width + 31) >> 3) & ~3;
	}
	bmi = (BITMAPINFO*)LocalAlloc(LPTR, sizeof(BITMAPINFOHEADER) + (sizeof(RGBQUAD)*ctablesize));
	if (!bmi)
	{
		ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
		return 1;
	}
	bmi->bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
	bmi->bmiHeader.biWidth = image_width;
	bmi->bmiHeader.biHeight = 0 - image_height;
	bmi->bmiHeader.biPlanes = 1;
	bmi->bmiHeader.biBitCount = (ctablesize==2) ? 1 : 8;
	bmi->bmiHeader.biSizeImage = image_height * rowsize;
	bmi->bmiHeader.biXPelsPerMeter = 2835;
	bmi->bmiHeader.biYPelsPerMeter = 2835;
	bmi->bmiHeader.biClrUsed = ctablesize;
	bmi->bmiHeader.biClrImportant = ctablesize;
	CopyMemory(bmi->bmiColors, ctable, sizeof(RGBQUAD)*ctablesize);
	hdc = GetDC(gMainWin);
	bmp = CreateDIBitmap(hdc, (BITMAPINFOHEADER*)bmi, CBM_INIT, fon_bits, bmi, DIB_RGB_COLORS);
	if (!bmp)
	{
		ErrorDialog(IDS_ERROR_GRAPHICS, GetLastError(), __FILE__, __LINE__);
		ReleaseDC(gMainWin, hdc);
		LocalFree(bmi);
		return 2;
	}
	fon->dc = CreateCompatibleDC(hdc);
	if (!fon->dc)
	{
		ErrorDialog(IDS_ERROR_GRAPHICS, GetLastError(), __FILE__, __LINE__);
		DeleteObject(bmp);
		ReleaseDC(gMainWin, hdc);
		LocalFree(bmi);
		return 2;
	}
	DeleteObject(SelectObject(fon->dc, bmp));
	ReleaseDC(gMainWin, hdc);
	LocalFree(bmi);

	mrowsize = ((image_width + 15) >> 3) & ~1;
	mask_bits = (char*)LocalAlloc(LPTR, image_height * mrowsize);
	if (!mask_bits)
	{
		ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
		return 1;
	}
	if (ctablesize == 2)
	{
		for (y=0; y<image_height; y++)
		{
			iptr = fon_bits + (rowsize * y);
			optr = mask_bits + (mrowsize * y);
			CopyMemory(optr, iptr, mrowsize);
		}
	}
	else
	{
		for (y=0; y<image_height; y++)
		{
			i = 0;
			c = 0;
			iptr = fon_bits + (rowsize * y);
			optr = mask_bits + (mrowsize * y);
			for (x=0; x<image_width; x++)
			{
				c <<= 1;
				c |= (*iptr++ != 0);
				if (++i == 8)
				{
					*optr++ = c;
					i = 0;
					c = 0;
				}
			}
			if (i)
				*optr = c << (8 - i);
		}
	}
	fon->mask = CreateBitmap(image_width, image_height, 1, 1, mask_bits);
	if (!fon->mask)
	{
		ErrorDialog(IDS_ERROR_GRAPHICS, GetLastError(), __FILE__, __LINE__);
		LocalFree(mask_bits);
		return 2;
	}
	fon->rop = SRCCOPY;
	LocalFree(mask_bits);
	return 0;
}

fon_image* LoadFon(LPCTSTR fon_name, COLORREF *pal_data)
{
	HANDLE hFile;
	fon_image *fon;
	char *fon_bits;
	int image_width, image_height;
	char *fon_data;
	int color;
	int err;

	hFile = CreateFile(fon_name, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
	if (hFile == INVALID_HANDLE_VALUE)
	{
		ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
		return NULL;
	}
	fon_data = loadfile(hFile);
	if (!fon_data)
	{
		CloseHandle(hFile);
		return NULL;
	}
	fon = (fon_image*)LocalAlloc(LPTR, sizeof(fon_image));
	if (!fon)
	{
		ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
		UnmapViewOfFile(fon_data);
		CloseHandle(hFile);
		return NULL;
	}
	fon_bits = read_fon(fon_data, fon->chars, &image_width, &image_height, &color);
	UnmapViewOfFile(fon_data);
	CloseHandle(hFile);
	if (!fon_bits)
	{
		LocalFree(fon);
		return NULL;
	}
	fon->rop = SRCCOPY;
	switch (color)
	{
	case 0:
		err = make_image(fon, fon_bits, image_width, image_height, (RGBQUAD*)pal_data, FALSE);
		break;
	case 1:
		err = make_image(fon, fon_bits, image_width, image_height, (RGBQUAD*)pal_data, TRUE);
		break;
	case 2:
		err = make_image(fon, fon_bits, image_width, image_height, (RGBQUAD*)_aatable2, FALSE);
		fon->rop = NOTSRCERASE;
		break;
	case -1:
		err = make_image(fon, fon_bits, image_width, image_height, (RGBQUAD*)_ctable, FALSE);
		break;
	default:
		err = -1;
		break;
	}
	LocalFree(fon_bits);
	if (err)
	{
		LocalFree(fon);
		return NULL;
	}
	return fon;
}

void DeleteFon(fon_image *fon)
{
	DeleteObject(fon->mask);
	DeleteDC(fon->dc);
	LocalFree(fon);
}

/* This hand-rolled function works in Win9x, which MaskBlt doesn't.
   It also has the convenient side-effect of displaying anti-aliased fonts
   very easily. So I'll just use this everywhere.

   I ripped it off from wxWindows, incidentally.
 */

static BOOL BlitMasked(HDC hdcDest, int nXDest, int nYDest, int nWidth, int nHeight, HDC hdcSrc, int nXSrc, int nYSrc, HBITMAP hbmMask, DWORD dwRop)
{
	BOOL success;
	HDC hdcMask;
	HDC hdcTemp;
	HBITMAP hbmBuffer;
	HBITMAP hbmTemp, hbmOld;
	COLORREF oldColor, oldBackColor;
	RECT rc;

	if (NULL == (hdcMask = CreateCompatibleDC(hdcSrc)))
	{
		return FALSE;
	}
	if (NULL == (hdcTemp = CreateCompatibleDC(hdcDest)))
	{
		DeleteDC(hdcMask);
		return FALSE;
	}
	if (NULL == (hbmBuffer = CreateCompatibleBitmap(hdcDest, nWidth, nHeight)))
	{
		DeleteDC(hdcTemp);
		DeleteDC(hdcMask);
		return FALSE;
	}
	hbmTemp = (HBITMAP)SelectObject(hdcTemp, hbmBuffer);
	hbmOld = (HBITMAP)SelectObject(hdcMask, hbmMask);
	/* A normal masked blit would just copy here. */
	/* But using the same op twice causes a greyscale source 
	   to blend well with the dest. */
	SetRect(&rc, 0, 0, nWidth, nHeight);
	FillRect(hdcTemp, &rc, (HBRUSH)GetStockObject(BLACK_BRUSH));
	BitBlt(hdcTemp, 0, 0, nWidth, nHeight, hdcDest, nXDest, nYDest, dwRop);
	BitBlt(hdcTemp, 0, 0, nWidth, nHeight, hdcSrc, nXSrc, nYSrc, dwRop);
	
	oldBackColor = SetBkColor(hdcDest, RGB(255,255,255));
	oldColor = SetTextColor(hdcDest, RGB(0,0,0));
	BitBlt(hdcTemp, 0, 0, nWidth, nHeight, hdcMask, nXSrc, nYSrc, SRCAND);
	
	SetBkColor(hdcDest, RGB(0,0,0));
	SetTextColor(hdcDest, RGB(255,255,255));
	BitBlt(hdcDest, nXDest, nYDest, nWidth, nHeight, hdcMask, nXSrc, nYSrc, SRCAND);
	
	SetBkColor(hdcDest, oldBackColor);
	SetTextColor(hdcDest, oldColor);
	success = BitBlt(hdcDest, nXDest, nYDest, nWidth, nHeight, hdcTemp, 0, 0, SRCPAINT);

	SelectObject(hdcMask, hbmOld);
	SelectObject(hdcTemp, hbmTemp);
	DeleteDC(hdcMask);
	DeleteDC(hdcTemp);
	DeleteObject(hbmBuffer);

	return success;
}

int FonChar(HDC destDC, const fon_image *fon, int left, int top, int right, int bottom, unsigned char c)
{
	int real_right = left + fon->chars[c].width;
	int real_bottom = top + fon->chars[c].height;
	if (fon->chars[c].width == 0)
		return left;
	if (real_right > right)
		real_right = right;
	if (real_bottom > bottom)
		real_bottom = bottom;
	//MaskBlt(destDC, left, top, real_right - left, real_bottom - top, 
	//		fon->dc, fon->chars[c].column, 0, fon->mask, fon->chars[c].column, 0, fon->rop);
	BlitMasked(destDC, left, top, real_right - left, real_bottom - top,
			fon->dc, fon->chars[c].column, 0, fon->mask, fon->rop);
	return real_right;
}

int wrap_string(const fon_image *fon, int w, const char* s)
{
	char *p = (char*)s;
	char *m = NULL;
	unsigned char c;
	while (*p)
	{
		c = *(unsigned char*)p++;
		switch (c)
		{
		case '\r':
			if (*p == '\n')
				++p;
		case '\n':
			return p - s;
		case ' ':
		case '\t':
			m = p;
		default:
			w -= fon->chars[c].width;
			if (w < 0)
			{
				if (m)
					p = m;
				else
					--p;
				return p - s;
			}
			break;
		}
	}

	return p - s;
}

int FonStr(HDC destDC, const fon_image *fon, int left, int top, int right, int bottom, const char *str, LPPOINT endpos)
{
	char *ptr;
	int line_len;
	int x, y;
	unsigned char c;

	ptr = (char*)str;
	x = left;
	y = top;
	while ((line_len = wrap_string(fon, right - left, ptr)) != -1)
	{
		while (line_len--)
		{
			c = *(unsigned char*)ptr++;
			x = FonChar(destDC, fon, x, y, right, bottom, c);
		}
		y += fon->chars[0].height;
		x = left;
		if (y + fon->chars[0].height > bottom)
			break;
	}

	if (endpos)
	{
		endpos->x = x;
		endpos->y = y;
	}
	return ptr - str;
}

