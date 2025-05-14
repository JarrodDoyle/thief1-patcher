/******************************************************************************
 *    pcx.c
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
#define STRICT
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdlib.h>
#include "parched.h"

extern BOOL ResetFile(HANDLE filehandle);

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

struct rle_reader_
{
	HANDLE filehandle;
	unsigned int row_width;
	char *buffer, *next;
	unsigned int buf_read;
	unsigned int buf_avail;
};
typedef struct rle_reader_ rle_reader;


static rle_reader* InitRLE(HANDLE, unsigned int);
static void EndRLE(rle_reader*);
static unsigned int FlushRLE(rle_reader*, char*);
static unsigned int ReadRLE(rle_reader*, char*);
static HBITMAP BuildDIBitmap(pcx_header*, char*, rgb*, unsigned int, unsigned int, unsigned int, COLORREF*);


HBITMAP LoadPCX(HANDLE infile, unsigned long *image_width, unsigned long *image_height, COLORREF *colors)
{
	HBITMAP bmp = NULL;
	rle_reader *rle;
	pcx_header head;
	rgb *ctable;
	unsigned int width, height, rowsize;
	char *bits;
	char *row;
	DWORD count;
	unsigned int n, p;

	if (!ReadFile(infile, &head, sizeof(pcx_header), &count, NULL) || count != sizeof(pcx_header))
	{
		ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
		ResetFile(infile);
		return NULL;
	}
	if (head.signature != 0x0A
	 || !(head.version == 5 || head.version == 2 || head.version == 0)
	 || !(head.format == 1 || head.format == 0 || head.format == 2)
	 || (head.planes != 1)
	 )
	{
		ResetFile(infile);
		return NULL;
	}

	width = head.right - head.left + 1;
	height = head.bottom - head.top + 1;
	rowsize = (((width * head.bpp * head.planes) >> 3) + 3) & ~3;
	if (rowsize < head.row_width)
		rowsize = (head.row_width + 3) & ~3;
	bits = (char*)malloc(height * rowsize);
	row = (char*)malloc(rowsize);
	if (head.bpp == 8)
	{
		ctable = (rgb*)malloc(sizeof(rgb)*256);
	}
	else
		ctable = head.colors;
	if (!bits || !row || !ctable)
	{
		ErrorDialog(IDS_ERROR_MEMORY, 8, __FILE__, __LINE__);
		ResetFile(infile);
		return NULL;
	}


	if (head.compressed)
	{
		rle = InitRLE(infile, head.row_width);
		if (!rle)
		{
			ErrorDialog(IDS_ERROR_MEMORY, 8, __FILE__, __LINE__);
			return NULL;
		}
		/*
		if (head.planes > 1)
		{
			for (n=0; n<height; n++)
			{
				for (p=0; p<head.planes; p++)
				{
					count = ReadRLE(rle, row);
					ExpandPlane(bits+(n*rowsize), row, p, width);
				}
			}
		}
		else
		*/
		{
			for (n=0; n<height; n++)
			{
				count = ReadRLE(rle, bits+(n*rowsize));
			}
		}
		if (head.bpp == 8)
		{
			count = FlushRLE(rle, (char*)ctable);
			if (!ReadFile(infile, ((char*)ctable)+count, (sizeof(rgb)*256)-count,
					&count, NULL))
				ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
		}
		EndRLE(rle);
	}
	else
	{
		/*
		if (head.planes > 1)
		{
			for (p=0; p<head.planes; p++)
			{
				for (n=0; n<height; n++)
				{
					ReadFile(infile, row, head.row_width, &count, NULL);
					ExpandPlane(bits+(n*rowsize), row, p, width);
				}
			}
		}
		else
		*/
		{
			for (n=0; n<height; n++)
			{
				if (!ReadFile(infile, bits+(n*rowsize), head.row_width, &count, NULL))
				{
					ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
					break;
				}
			}
		}
		if (head.bpp == 8)
		{
			if (!ReadFile(infile, ctable, sizeof(rgb)*256, &count, NULL))
				ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
		}
	}

	bmp = BuildDIBitmap(&head, bits, ctable, width, height, rowsize, colors);
	if (bmp)
	{
		*image_width = width;
		*image_height = height;
	}

	if (head.bpp == 8)
		free(ctable);
	free(row);
	free(bits);

	return bmp;
}

static rle_reader* InitRLE(HANDLE infile, unsigned int rowsize)
{
	rle_reader *rle = (rle_reader*)malloc(sizeof(rle_reader));
	if (rle)
	{
		rle->filehandle = infile;
		rle->row_width = rowsize;
		rle->buffer = malloc(rowsize);
		rle->next = rle->buffer;
		rle->buf_read = 0;
		rle->buf_avail = 0;
	}
	return rle;
}

static void EndRLE(rle_reader *rle)
{
	free(rle->buffer);
	free(rle);
}

static unsigned int FlushRLE(rle_reader *rle, char *outp)
{
	char tmpbuf[16];
	DWORD count;
	char *p;
	if (rle->buf_avail > 0)
	{
		while (*rle->next++ != 0x0C)
		{
			if (--rle->buf_avail == 0)
				goto rle_buffer_empty;
		}
		memcpy(outp, rle->next, --rle->buf_avail);
		return rle->buf_avail;
	}
rle_buffer_empty:
	while (ReadFile(rle->filehandle, tmpbuf, 16, (DWORD*)&count, NULL))
	{
		p = tmpbuf;
		while (count-- && *p++ != 0x0C);
		if (count)
		{
			memcpy(outp, p, count);
			return count;
		}
	}
	return 0;
}

static unsigned int ReadRLE(rle_reader *rle, char *outp)
{
	char *p = outp;
	unsigned int count = 0;
	char code;
	unsigned int repeat = 0;

	while (count < rle->row_width)
	{
		if (! rle->buf_avail)
		{
			if (!ReadFile(rle->filehandle, rle->buffer, rle->row_width, (DWORD*)&rle->buf_read, NULL)
			 || rle->buf_read == 0)
			{
				return count;
			}
			rle->buf_avail = rle->buf_read;
			rle->next = rle->buffer;
		}
		code = *rle->next++;
		--rle->buf_avail;
		if (repeat != 0)
		{
			count += repeat;
			do *p++ = code;
			while (--repeat);
		}
		else
		{
			if ((code & 0xC0) == 0xC0)
			{
				repeat = code & 0x3F;
			}
			else
			{
				*p++ = code;
				++count;
			}
		}
	}
	return count;
}

static HBITMAP BuildDIBitmap(pcx_header *head, char *bits, rgb *ctable,
		unsigned int width, unsigned int height, unsigned int rowsize,
		COLORREF *colors)
{
	BITMAPINFO *bmi;
	HBITMAP bmp;
	HDC screendc;
	int ctablesize;

	if (head->format == 1 || head->bpp == 8)
	{
		ctablesize = (head->bpp == 8) ? 256 : 16;
	}
	else
		ctablesize = 0;

	bmi = (BITMAPINFO*)malloc(sizeof(BITMAPINFOHEADER) + (sizeof(RGBQUAD)*ctablesize));
	if (!bmi)
	{
		ErrorDialog(IDS_ERROR_MEMORY, 8, __FILE__, __LINE__);
		return NULL;
	}
	memset(bmi, 0, sizeof(BITMAPINFOHEADER) + (sizeof(RGBQUAD)*ctablesize));
	bmi->bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
	bmi->bmiHeader.biWidth = width;
	bmi->bmiHeader.biHeight = 0 - height;
	bmi->bmiHeader.biPlanes = 1;
	bmi->bmiHeader.biBitCount = head->bpp * head->planes;
	bmi->bmiHeader.biSizeImage = height * rowsize;
	bmi->bmiHeader.biXPelsPerMeter = 2835;
	bmi->bmiHeader.biYPelsPerMeter = 2835;
	bmi->bmiHeader.biClrUsed = ctablesize;
	bmi->bmiHeader.biClrImportant = ctablesize;

	while (ctablesize--)
	{
		bmi->bmiColors[ctablesize].rgbRed = ctable[ctablesize].r;
		bmi->bmiColors[ctablesize].rgbGreen = ctable[ctablesize].g;
		bmi->bmiColors[ctablesize].rgbBlue = ctable[ctablesize].b;
	}

	screendc = GetDC(NULL);
	bmp = CreateDIBitmap(screendc, (BITMAPINFOHEADER*)bmi, CBM_INIT, bits, bmi, DIB_RGB_COLORS);
	if (!bmp)
		ErrorDialog(IDS_ERROR_GRAPHICS, GetLastError(), __FILE__, __LINE__);
	ReleaseDC(NULL, screendc);

	if (bmp && colors)
	{
		CopyMemory(colors, bmi->bmiColors, sizeof(RGBQUAD)*bmi->bmiHeader.biClrUsed);
	}

	free(bmi);
	return bmp;
}

