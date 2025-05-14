/******************************************************************************
 *    boxer.c
 *
 *    Copyright (C) 2005 Tom N Harris <telliamed@whoopdedo.org>
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
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

char g_basename[1012];
RGBQUAD g_colortable[256];
COLORREF g_maskcolor = RGB(255,0,255);
int g_mask = -1;
int g_verbosity = 0;
char g_buffer[1024];


#define PX2RGB(p,y,x)	RGB( ((p)[y]+((x)*3))[2],((p)[y]+((x)*3))[1],((p)[y]+((x)*3))[0])

#pragma pack(push,1)
struct rgb_
{
	unsigned char r,g,b;
};
#pragma pack(pop)
typedef struct rgb_ rgb;

#pragma pack(push,1)
struct pcx_header_
{
	unsigned char	signature;	/* 0x0A */
	unsigned char	version;	/* 0,2,5 */
	unsigned char	compressed;
	unsigned char	bpp;
	unsigned short	left;
	unsigned short	top;
	unsigned short	right;
	unsigned short	bottom;
	unsigned short	hres;
	unsigned short	vres;
	rgb		colors[16];
	char	unknown;
	unsigned char	planes;
	unsigned short	row_width;
	unsigned char	format;	/* 0 = rgb, 1 = index, 2 = gray */
	char	zero[59];
};
#pragma pack(pop)
typedef struct pcx_header_ pcx_header;


char* ReadRLE(BYTE *outp, BYTE *inp, int row_width)
{
	register BYTE *p = inp, *q = outp;
	register int repeat = 0;
	BYTE code;

	while (row_width > 0)
	{
		code = *p++;
		if (repeat != 0)
		{
			row_width -= repeat;
			do *q++ = code;
			while (--repeat);
		}
		else
		{
			if ((code & 0xC0) == 0xC0)
			{
				repeat = code & 0x3F;
				if (repeat > row_width)
					repeat = row_width;
			}
			else
			{
				*q++ = code;
				--row_width;
			}
		}
	}
	return p;
}

int WriteRLE(BYTE *outp, BYTE *inp, int row_width)
{
	register BYTE *p = inp, *q = outp;
	register unsigned int repeat = 0;
	BYTE code;

	while (row_width--)
	{
		code = *p++;
		repeat = 0;
		while (row_width && code == *p)
		{
			++p;
			--row_width;
			if (++repeat >= 0x3E)
				break;
		}
		if (repeat != 0 || (code & 0xC0) == 0xC0)
		{
			*q++ = 0xC0 | (repeat+1);
			*q++ = code;
		}
		else
			*q++ = code;
	}
	return q-outp;
}

char* loadfile(HANDLE hFile)
{
	HANDLE hFileMap;
	char *pRet;

	hFileMap = CreateFileMapping(hFile, NULL, PAGE_READONLY, 0, 0, NULL);
	if (!hFileMap)
		return NULL;
	pRet = MapViewOfFile(hFileMap, FILE_MAP_READ, 0, 0, 0);
	CloseHandle(hFileMap);
	return pRet;
}

int format_pcx(char *image_data)
{
	pcx_header *head;
	head = (pcx_header*)image_data;
	return (head->signature == 0x0A
		&& (head->version == 5 || head->version == 2 || head->version == 0)
		&& (head->format == 1 || head->format == 0)
		&& (head->planes == 1 && head->bpp == 8));
}

BYTE** read_pcx(char *image_data, int *image_width, int *image_height, RGBQUAD *colors)
{
	pcx_header *head;
	rgb *ctable;
	BYTE **row_pointers;
	unsigned int width, height, row_width;
	BYTE *image_bits, *ptr;
	unsigned int row, n;

	head = (pcx_header*)image_data;

	width = head->right - head->left + 1;
	height = head->bottom - head->top + 1;
	/*
	row_width = (((width * head->bpp * head->planes) >> 3) + 3) & ~3;
	if (row_width < head->row_width)
		row_width = (head->row_width + 3) & ~3;
	*/
	row_width = head->row_width;
	image_bits = (BYTE*)calloc(height, row_width);
	if (!image_bits)
		return NULL;
	row_pointers = (BYTE**)calloc(height, sizeof(BYTE*));
	if (!row_pointers)
	{
		free(image_bits);
		return NULL;
	}
	ptr = image_bits;
	for (row = 0; row < height; row++)
	{
		row_pointers[row] = ptr;
		ptr += row_width;
	}

	ptr = (BYTE*)(image_data + sizeof(pcx_header));
	if (head->compressed)
	{
		for (row = 0; row < height; row++)
		{
			ptr = ReadRLE(row_pointers[row], ptr, row_width);
		}
	}
	else
	{
		for (row = 0; row < height; row++)
		{
			memcpy(row_pointers[row], ptr, row_width);
			ptr += row_width;
		}
	}
	while (*ptr++ != 0x0C);

	ctable = (rgb*)ptr;
	for (n = 0; n < 256; n++)
	{
		colors[n].rgbRed = ctable[n].r;
		colors[n].rgbGreen = ctable[n].g;
		colors[n].rgbBlue = ctable[n].b;
	}

	*image_width = width;
	*image_height = height;
	return row_pointers;
}

int write_pcx(int suffix_num, BYTE **image_rows, int x, int y, int w, int h, RGBQUAD *colors)
{
	char fname[1024];
	rgb ctable[256];
	pcx_header head;
	BYTE *row_bytes;
	int row;
	HANDLE hFile;
	DWORD dwBytes;
	int err;
	int n;

	memset(&head, 0, sizeof(pcx_header));
	head.signature = 0x0A;
	head.version = 5;
	head.compressed = 1;
	head.format = 1;
	head.planes = 1;
	head.bpp = 8;
	head.row_width = w;
	head.right = w - 1;
	head.bottom = h - 1;
	head.hres = w;
	head.vres = h;

	row_bytes = (BYTE*)malloc(w * 2);
	if (!row_bytes)
	{
		return 8;
	}

	for (n = 0; n < 256; n++)
	{
		ctable[n].r = colors[n].rgbRed;
		ctable[n].g = colors[n].rgbGreen;
		ctable[n].b = colors[n].rgbBlue;
	}
	memcpy(head.colors, ctable, sizeof(rgb)*16);

	sprintf(fname, TEXT("%s%03d.pcx"), g_basename, suffix_num);
	hFile = CreateFile(fname, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
	if (hFile == INVALID_HANDLE_VALUE)
	{
		free(row_bytes);
		return GetLastError();
	}
	if (!WriteFile(hFile, &head, sizeof(pcx_header), &dwBytes, NULL))
	{
		err = GetLastError();
		goto lEndWrite_pcx;
	}
	for (row = 0; row < h; row++)
	{
		dwBytes = WriteRLE(row_bytes, image_rows[row+y]+x, w);
		if (!WriteFile(hFile, row_bytes, dwBytes, &dwBytes, NULL))
		{
			err = GetLastError();
			goto lEndWrite_pcx;
		}
	}
	row_bytes[0] = 0x0C;
	WriteFile(hFile, row_bytes, 1, &dwBytes, NULL);

	if (!WriteFile(hFile, ctable, sizeof(rgb)*256, &dwBytes, NULL))
	{
		err = GetLastError();
	}
lEndWrite_pcx:
	CloseHandle(hFile);
	free(row_bytes);

	return 0;
}

int format_bmp8(char *image_data)
{
	BITMAPFILEHEADER *file_head;
	BITMAPINFOHEADER *bm_head;
	file_head = (BITMAPFILEHEADER*)image_data;
	bm_head = (BITMAPINFOHEADER*)(image_data + sizeof(BITMAPFILEHEADER));
	return (file_head->bfType == 0x4D42 && bm_head->biBitCount == 8);
}

int format_bmp24(char *image_data)
{
	BITMAPFILEHEADER *file_head;
	BITMAPINFOHEADER *bm_head;
	file_head = (BITMAPFILEHEADER*)image_data;
	bm_head = (BITMAPINFOHEADER*)(image_data + sizeof(BITMAPFILEHEADER));
	return (file_head->bfType == 0x4D42 && bm_head->biBitCount == 24);
}

BYTE** read_bmp8(char *image_data, int *image_width, int *image_height, RGBQUAD *colors)
{
	BITMAPFILEHEADER *file_head;
	BITMAPINFOHEADER *bm_head;
	RGBQUAD *ctable;
	BYTE **row_pointers;
	BYTE *image_bits;
	BYTE *ptr;
	int row_width, row;

	file_head = (BITMAPFILEHEADER*)image_data;
	bm_head = (BITMAPINFOHEADER*)(image_data + sizeof(BITMAPFILEHEADER));
	ptr = (BYTE*)(image_data + file_head->bfOffBits);
	ctable = (RGBQUAD*)(image_data + sizeof(BITMAPFILEHEADER) + bm_head->biSize);
	memcpy(colors, ctable, sizeof(RGBQUAD)*bm_head->biClrUsed);
	row_width = (bm_head->biWidth + 3) & ~3;
	row_pointers = (BYTE**)calloc(bm_head->biHeight, sizeof(BYTE*));
	if (!row_pointers)
		return NULL;
	image_bits = (BYTE*)calloc(bm_head->biHeight, row_width);
	if (!image_bits)
	{
		free(row_pointers);
		return NULL;
	}
	memcpy(image_bits, ptr, row_width * bm_head->biHeight);
	ptr = image_bits;
	for (row = bm_head->biHeight-1; row >= 0; row--)
	{
		row_pointers[row] = ptr;
		ptr += row_width;
	}
	*image_width = bm_head->biWidth;
	*image_height = bm_head->biHeight;
	return row_pointers;
}

int write_bmp8(int suffix_num, BYTE **image_rows, int x, int y, int w, int h, RGBQUAD *colors)
{
	char fname[1024];
	BITMAPFILEHEADER file_head;
	BITMAPINFOHEADER bm_head;
	int row_width, row;
	HANDLE hFile;
	DWORD dwBytes;
	int err = 0;
	const char zero[4] = {0,0,0,0};

	file_head.bfType = 0x4D42;
	file_head.bfReserved1 = 0;
	file_head.bfReserved2 = 0;
	file_head.bfOffBits = sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER) + (sizeof(RGBQUAD)*256);
	bm_head.biSize = sizeof(BITMAPINFOHEADER);
	bm_head.biWidth = w;
	bm_head.biHeight = h;
	bm_head.biPlanes = 1;
	bm_head.biBitCount = 8;
	bm_head.biCompression = 0;
	bm_head.biXPelsPerMeter = 0xB13;
	bm_head.biYPelsPerMeter = 0xB13;
	bm_head.biClrUsed = 256;
	bm_head.biClrImportant = 256;
	row_width = (w + 3) & ~3;
	bm_head.biSizeImage = row_width * h;
	file_head.bfSize = file_head.bfOffBits + bm_head.biSizeImage;

	sprintf(fname, TEXT("%s%03d.bmp"), g_basename, suffix_num);
	hFile = CreateFile(fname, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
	if (hFile == INVALID_HANDLE_VALUE)
	{
		return GetLastError();
	}
	if (!WriteFile(hFile, &file_head, sizeof(BITMAPFILEHEADER), &dwBytes, NULL))
	{
		err = GetLastError();
		goto lEndWrite_bmp8;
	}
	if (!WriteFile(hFile, &bm_head, sizeof(BITMAPINFOHEADER), &dwBytes, NULL))
	{
		err = GetLastError();
		goto lEndWrite_bmp8;
	}
	if (!WriteFile(hFile, colors, sizeof(RGBQUAD)*256, &dwBytes, NULL))
	{
		err = GetLastError();
		goto lEndWrite_bmp8;
	}
	row_width -= w;
	for (row = y+h-1; row >= y; row--)
	{
		if (!WriteFile(hFile, image_rows[row]+x, w, &dwBytes, NULL))
		{
			err = GetLastError();
			goto lEndWrite_bmp8;
		}
		if (row_width != 0)
		{
			if (!WriteFile(hFile, zero, row_width, &dwBytes, NULL))
			{
				err = GetLastError();
				goto lEndWrite_bmp8;
			}
		}
	}
lEndWrite_bmp8:
	CloseHandle(hFile);
	return err;
}

BYTE** read_bmp24(char *image_data, int *image_width, int *image_height)
{
	BITMAPFILEHEADER *file_head;
	BITMAPINFOHEADER *bm_head;
	BYTE **row_pointers;
	BYTE *image_bits;
	BYTE *ptr;
	int row_width, row;

	file_head = (BITMAPFILEHEADER*)image_data;
	bm_head = (BITMAPINFOHEADER*)(image_data + sizeof(BITMAPFILEHEADER));
	ptr = (BYTE*)(image_data + file_head->bfOffBits);
	row_width = ((bm_head->biWidth * 3) + 3) & ~3;
	row_pointers = (BYTE**)calloc(bm_head->biHeight, sizeof(BYTE*));
	if (!row_pointers)
		return NULL;
	image_bits = (BYTE*)calloc(bm_head->biHeight, row_width);
	if (!image_bits)
	{
		free(row_pointers);
		return NULL;
	}
	memcpy(image_bits, ptr, row_width * bm_head->biHeight);
	ptr = image_bits;
	for (row = bm_head->biHeight-1; row >= 0; row--)
	{
		row_pointers[row] = ptr;
		ptr += row_width;
	}
	*image_width = bm_head->biWidth;
	*image_height = bm_head->biHeight;
	return row_pointers;
}

int write_bmp24(int suffix_num, BYTE **image_rows, int x, int y, int w, int h, RGBQUAD* colors)
{
	char fname[1024];
	BITMAPFILEHEADER file_head;
	BITMAPINFOHEADER bm_head;
	int row_width, row;
	HANDLE hFile;
	DWORD dwBytes;
	int err = 0;
	const char zero[4] = {0,0,0,0};

	file_head.bfType = 0x4D42;
	file_head.bfReserved1 = 0;
	file_head.bfReserved2 = 0;
	file_head.bfOffBits = sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER);
	bm_head.biSize = sizeof(BITMAPINFOHEADER);
	bm_head.biWidth = w;
	bm_head.biHeight = h;
	bm_head.biPlanes = 1;
	bm_head.biBitCount = 24;
	bm_head.biCompression = 0;
	bm_head.biXPelsPerMeter = 0xB13;
	bm_head.biYPelsPerMeter = 0xB13;
	bm_head.biClrUsed = 0;
	bm_head.biClrImportant = 0;
	row_width = ((w * 3) + 3) & ~3;
	bm_head.biSizeImage = row_width * h;
	file_head.bfSize = file_head.bfOffBits + bm_head.biSizeImage;

	sprintf(fname, TEXT("%s%03d.bmp"), g_basename, suffix_num);
	hFile = CreateFile(fname, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
	if (hFile == INVALID_HANDLE_VALUE)
	{
		return GetLastError();
	}
	if (!WriteFile(hFile, &file_head, sizeof(BITMAPFILEHEADER), &dwBytes, NULL))
	{
		err = GetLastError();
		goto lEndWrite_bmp8;
	}
	if (!WriteFile(hFile, &bm_head, sizeof(BITMAPINFOHEADER), &dwBytes, NULL))
	{
		err = GetLastError();
		goto lEndWrite_bmp8;
	}
	row_width -= w * 3;
	for (row = y+h-1; row >= y; row--)
	{
		if (!WriteFile(hFile, image_rows[row]+(x*3), w*3, &dwBytes, NULL))
		{
			err = GetLastError();
			goto lEndWrite_bmp8;
		}
		if (row_width != 0)
		{
			if (!WriteFile(hFile, zero, row_width, &dwBytes, NULL))
			{
				err = GetLastError();
				goto lEndWrite_bmp8;
			}
		}
	}
lEndWrite_bmp8:
	CloseHandle(hFile);
	return err;
}

int parse_boxes8(BYTE **image_rows, int image_width, int image_height, RGBQUAD *colors, int (*write_image)(int,BYTE**,int,int,int,int,RGBQUAD*))
{
	int num_box;
	int scanx, scany;
	int boxx, boxy;
	int n;

	if (g_mask == -1)
	{
		g_mask = image_rows[0][0];
		if (g_verbosity > 0)
			fprintf(stdout, "Background color is #%d (%d,%d,%d)\n",
				g_mask, colors[g_mask].rgbBlue, colors[g_mask].rgbGreen, colors[g_mask].rgbBlue);
	}
	else if (g_mask == -2)
	{
		for (n=0; n<256; n++)
		{
			if (g_maskcolor == ((COLORREF*)colors)[n])
			{
				g_mask = n;
				break;
			}
		}
		if (g_mask < 0)
		{
			fprintf(stderr, "Bitmap color table does not include mask color.\n");
			return -22;
		}
		if (g_verbosity > 0)
			fprintf(stdout, "Pink color is #%d\n", g_mask);
	}
	else
	{
		if (g_verbosity > 0)
			fprintf(stdout, "Mask color is #%d (%d,%d,%d)\n",
				g_mask, colors[g_mask].rgbBlue, colors[g_mask].rgbGreen, colors[g_mask].rgbBlue);
	}

	num_box = 0;
	for (scany = 0; scany < image_height-1; scany++)
	{
		for (scanx = 0; scanx < image_width-1; scanx++)
		{
			if (image_rows[scany][scanx] != g_mask
			 && (scany == 0 || (image_rows[scany-1][scanx] == g_mask))
			 && (scanx == 0 || (image_rows[scany][scanx-1] == g_mask)))
			{
				boxx = scanx;
				while (boxx < image_width
				 && image_rows[scany][boxx] != g_mask
				 && image_rows[scany+1][boxx] != g_mask)
					boxx++;
				boxy = scany+1;
				while (boxy < image_height
				 && image_rows[boxy][scanx] != g_mask
				 && image_rows[boxy][scanx+1] != g_mask)
					boxy++;
				if (boxx-scanx > 0 && boxy-scany > 0)
				{
					if (g_verbosity > 2)
						fprintf(stdout, "@%d,%d %dx%d\n", scanx, scany, boxx-scanx, boxy-scany);
					write_image(num_box, image_rows, scanx, scany, boxx-scanx, boxy-scany, colors);
					num_box++;
				}
				scanx = boxx;
			}
		}
	}
	return num_box;
}

int parse_rects8(BYTE **image_rows, int image_width, int image_height, RGBQUAD *colors, int (*write_image)(int,BYTE**,int,int,int,int,RGBQUAD*))
{
	int num_box;
	int scanx, scany;
	int boxx, boxy;
	int n;

	if (g_mask == -1)
	{
		g_mask = image_rows[0][0];
		if (g_verbosity > 0)
			fprintf(stdout, "Background color is #%d (%d,%d,%d)\n",
				g_mask, colors[g_mask].rgbRed, colors[g_mask].rgbGreen, colors[g_mask].rgbBlue);
	}
	else if (g_mask == -2)
	{
		for (n=0; n<256; n++)
		{
			if (g_maskcolor == ((COLORREF*)colors)[n])
			{
				g_mask = n;
				break;
			}
		}
		if (g_mask < 0)
		{
			fprintf(stderr, "Bitmap color table does not include mask color.\n");
			return -22;
		}
		if (g_verbosity > 0)
			fprintf(stdout, "Pink color is #%d\n", g_mask);
	}
	else
	{
		if (g_verbosity > 0)
			fprintf(stdout, "Mask color is #%d (%d,%d,%d)\n", 
				g_mask, colors[g_mask].rgbRed, colors[g_mask].rgbGreen, colors[g_mask].rgbBlue);
	}

	num_box = 0;
	for (scany = 0; scany < image_height-1; scany++)
	{
		for (scanx = 0; scanx < image_width-1; scanx++)
		{
			if (image_rows[scany][scanx] == g_mask
			 && (scany == 0 || (image_rows[scany-1][scanx] != g_mask))
			 && (scanx == 0 || (image_rows[scany][scanx-1] != g_mask)))
			{
				boxx = scanx+1;
				while (boxx < image_width
				 && image_rows[scany][boxx] == g_mask
				 && image_rows[scany+1][boxx] != g_mask)
					boxx++;
				boxy = scany+1;
				while (boxy < image_height
				 && image_rows[boxy][scanx] == g_mask
				 && image_rows[boxy][scanx+1] != g_mask)
					boxy++;
				if (boxx-scanx > 1 && boxy-scany > 1)
				{
					if (g_verbosity > 2)
						fprintf(stdout, "@%d,%d %dx%d\n", scanx, scany, boxx-scanx, boxy-scany);
					write_image(num_box, image_rows, scanx+1, scany+1, boxx-scanx-1, boxy-scany-1, colors);
					num_box++;
				}
				scanx = boxx;
			}
		}
	}
	return num_box;
}

int parse_boxes24(BYTE **image_rows, int image_width, int image_height, int (*write_image)(int,BYTE**,int,int,int,int,RGBQUAD*))
{
	int num_box;
	int scanx, scany;
	int boxx, boxy;

	if (g_mask == -1)
	{
		g_maskcolor = PX2RGB(image_rows,0,0);
		if (g_verbosity > 0)
			fprintf(stdout, "Background color is (%d,%d,%d)\n",
				GetRValue(g_maskcolor), GetGValue(g_maskcolor), GetBValue(g_maskcolor));
	}
	else
	{
		if (g_verbosity > 0)
			fprintf(stdout, "Mask color is (%d,%d,%d)\n",
				GetRValue(g_maskcolor), GetGValue(g_maskcolor), GetBValue(g_maskcolor));
	}

	num_box = 0;
	for (scany = 0; scany < image_height-1; scany++)
	{
		for (scanx = 0; scanx < image_width-1; scanx++)
		{
			if (PX2RGB(image_rows,scany,scanx) != g_maskcolor
			 && (scany == 0 || (PX2RGB(image_rows,scany-1,scanx) == g_maskcolor))
			 && (scanx == 0 || (PX2RGB(image_rows,scany,scanx-1) == g_maskcolor)))
			{
				boxx = scanx;
				while (boxx < image_width
				 && PX2RGB(image_rows,scany,boxx) != g_maskcolor
				 && PX2RGB(image_rows,scany+1,boxx) != g_maskcolor)
					boxx++;
				boxy = scany+1;
				while (boxy < image_height
				 && PX2RGB(image_rows,boxy,scanx) != g_maskcolor
				 && PX2RGB(image_rows,boxy,scanx+1) != g_maskcolor)
					boxy++;
				if (boxx-scanx > 0 && boxy-scany > 0)
				{
					if (g_verbosity > 2)
						fprintf(stdout, "@%d,%d %dx%d\n", scanx, scany, boxx-scanx, boxy-scany);
					write_image(num_box, image_rows, scanx, scany, boxx-scanx, boxy-scany, NULL);
					num_box++;
				}
				scanx = boxx;
			}
		}
	}
	return num_box;
}

int parse_rects24(BYTE **image_rows, int image_width, int image_height, int (*write_image)(int,BYTE**,int,int,int,int,RGBQUAD*))
{
	int num_box;
	int scanx, scany;
	int boxx, boxy;

	if (g_mask == -1)
	{
		g_maskcolor = PX2RGB(image_rows,0,0);
		if (g_verbosity > 0)
			fprintf(stdout, "Background color is (%d,%d,%d)\n",
				GetRValue(g_maskcolor), GetGValue(g_maskcolor), GetBValue(g_maskcolor));
	}
	else
	{
		if (g_verbosity > 0)
			fprintf(stdout, "Mask color is (%d,%d,%d)\n",
				GetRValue(g_maskcolor), GetGValue(g_maskcolor), GetBValue(g_maskcolor));
	}
	
	num_box = 0;
	for (scany = 0; scany < image_height-1; scany++)
	{
		for (scanx = 0; scanx < image_width-1; scanx++)
		{
			if (PX2RGB(image_rows,scany,scanx) == g_maskcolor
			 && (scany == 0 || (PX2RGB(image_rows,scany-1,scanx) != g_maskcolor))
			 && (scanx == 0 || (PX2RGB(image_rows,scany,scanx-1) != g_maskcolor)))
			{
				boxx = scanx+1;
				while (boxx < image_width
				 && PX2RGB(image_rows,scany,boxx) == g_maskcolor
				 && PX2RGB(image_rows,scany+1,boxx) != g_maskcolor)
					boxx++;
				boxy = scany+1;
				while (boxy < image_height
				 && PX2RGB(image_rows,boxy,scanx) == g_maskcolor
				 && PX2RGB(image_rows,boxy,scanx+1) != g_maskcolor)
					boxy++;
				if (boxx-scanx > 1 && boxy-scany > 1)
				{
					if (g_verbosity > 2)
						fprintf(stdout, "@%d,%d %dx%d\n", scanx, scany, boxx-scanx, boxy-scany);
					write_image(num_box, image_rows, scanx+1, scany+1, boxx-scanx-1, boxy-scany-1, NULL);
					num_box++;
				}
				scanx = boxx;
			}
		}
	}
	return num_box;
}

int process_file(char *fname, int rects)
{
	HANDLE hFile;
	char *image_data;
	BYTE **image_rows = NULL;
	RGBQUAD *colors = NULL;
	int image_width, image_height;
	int (*write_fn)(int,BYTE**,int,int,int,int,RGBQUAD*) = NULL;
	int num_boxes;
	int err = 0;

	if (g_verbosity > 0) fprintf(stdout, "Processing file %s\n", fname);

	hFile = CreateFile(fname, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
	if (hFile == INVALID_HANDLE_VALUE)
	{
		return GetLastError();
	}
	image_data = loadfile(hFile);
	err = GetLastError();
	if (!image_data)
	{
		CloseHandle(hFile);
		return err;
	}
	if (format_bmp8(image_data))
	{
		if (g_verbosity > 1) fprintf(stdout, "Image is 8-bit BMP\n");
		colors = g_colortable;
		image_rows = read_bmp8(image_data, &image_width, &image_height, colors);
		write_fn = write_bmp8;
		if (g_verbosity > 1) fprintf(stdout, "width is %d, height is %d\n", image_width, image_height);
	}
	else if (format_bmp24(image_data))
	{
		if (g_verbosity > 1) fprintf(stdout, "Image is 24-bit BMP\n");
		colors = NULL;
		image_rows = read_bmp24(image_data, &image_width, &image_height);
		write_fn = write_bmp24;
		if (g_verbosity > 1) fprintf(stdout, "width is %d, height is %d\n", image_width, image_height);
	}
	else if (format_pcx(image_data))
	{
		if (g_verbosity > 1) fprintf(stdout, "Image is 8-bit PCX\n");
		colors = g_colortable;
		image_rows = read_pcx(image_data, &image_width, &image_height, colors);
		write_fn = write_pcx;
		if (g_verbosity > 1) fprintf(stdout, "width is %d, height is %d\n", image_width, image_height);
	}
	else
	{
		fprintf(stderr, "Unknown file format.\n");
		CloseHandle(hFile);
		UnmapViewOfFile(image_data);
		return -11;
	}
	CloseHandle(hFile);
	if (!image_rows)
	{
		UnmapViewOfFile(image_data);
		return 8;
	}
	if (colors)
	{
		if (rects)
			num_boxes = parse_rects8(image_rows, image_width, image_height, colors, write_fn);
		else
			num_boxes = parse_boxes8(image_rows, image_width, image_height, colors, write_fn);
	}
	else
	{
		if (rects)
			num_boxes = parse_rects24(image_rows, image_width, image_height, write_fn);
		else
			num_boxes = parse_boxes24(image_rows, image_width, image_height, write_fn);
	}
	free(image_rows);
	UnmapViewOfFile(image_data);
	if (num_boxes < 0)
		return num_boxes;
	fprintf(stdout, "Found %d boxes.\n", num_boxes);
	return 0;
}

int main(int argc, char **argv)
{
	char *ext;
	int r,g,b,i;
	int n,o;
	int err;

	memset(g_colortable, 0, sizeof(RGBQUAD)*256);
	i = 0;

	for (n=1; n<argc; n++)
	{
		if (*argv[n] == '-')
		{
			for (o=1; argv[n][o]; o++)
				switch (argv[n][o])
				{
				case 'v':
					g_verbosity++;
					break;
				case 'i':
					i = 1;
					break;
				case 'p':
					g_maskcolor = RGB(255,0,255);
					g_mask = -2;
					break;
				case 'm':
					g_mask = 0;
					break;
				case 'c':
					n++;
					if (n<argc)
					{
						if (3 == sscanf(argv[n], "%u,%u,%u", &r, &g, &b))
						{
							g_maskcolor = RGB(r,g,b);
							g_mask = -2;
							goto lColorOption;
						}
					}
				default:
					fprintf(stderr, "Usage: boxer [-p|-m|-c r,g,b] [-i] file.(bmp|pcx) ...\n");
					return 0;
				}
lColorOption:
			continue;
		}
		else
		{
			ext = strrchr(argv[n], '.');
			if (ext)
			{
				strncpy(g_basename, argv[n], ext-argv[n]);
				g_basename[ext-argv[n]] = '\0';
			}
			else
				strcpy(g_basename, argv[n]);
			if ((err = process_file(argv[n], i)) != 0)
			{
				if (err > 0)
				{
					FormatMessage(FORMAT_MESSAGE_IGNORE_INSERTS | FORMAT_MESSAGE_FROM_SYSTEM,
							NULL, err, 0, g_buffer, sizeof(g_buffer), NULL);
					CharToOem(g_buffer, g_buffer);
					fprintf(stderr, "%s", g_buffer);
				}
				return 0;
			}
		}
	}

	return 0;
}

