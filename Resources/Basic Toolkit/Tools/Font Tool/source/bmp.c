/******************************************************************************
 *    bmp.c
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
#include "defs.h"

uint8** read_bmp(HANDLE hFile, int *image_width, int *image_height, int *pixel_size, RGBQUAD **image_pal)
{
	BITMAPFILEHEADER file_head;
	BITMAPINFOHEADER bm_head;
	DWORD bytes, offsetBytes = 0;

	if (!ReadFile(hFile, &file_head, sizeof(BITMAPFILEHEADER), &bytes, NULL))
	{
		errno = GetLastError();
		return NULL;
	}
	offsetBytes += bytes;
	if (!ReadFile(hFile, &bm_head, sizeof(BITMAPINFOHEADER), &bytes, NULL))
	{
		errno = GetLastError();
		return NULL;
	}
	offsetBytes += bytes;
	if (bytes != sizeof(BITMAPINFOHEADER)
	|| file_head.bfType != 0x4D42 || bm_head.biCompression != 0
	|| (bm_head.biBitCount != 8
	 && bm_head.biBitCount != 24))
	{
		errno = EILSEQ;
		return NULL;
	}
	int bpp = bm_head.biBitCount >> 3;
	int row_width = (bm_head.biWidth * bpp + 3) & ~3;
	uint8 **row_pointers = calloc(bm_head.biHeight, sizeof(char*) + row_width);
	if (!row_pointers)
	{
		errno = ENOMEM;
		return NULL;
	}
	if (bm_head.biBitCount == 8)
	{
		if (image_pal)
		{
			RGBQUAD *pal = calloc(256, sizeof(RGBQUAD));
			if (!pal)
			{
				free(row_pointers);
				errno = ENOMEM;
				return NULL;
			}
			if (!ReadFile(hFile, pal, 256*sizeof(RGBQUAD), &bytes, NULL))
			{
				free(pal);
				free(row_pointers);
				errno = GetLastError();
				return NULL;
			}
			offsetBytes += bytes;
			*image_pal = pal;
		}
		else
		{
			SetFilePointer(hFile, 256*sizeof(RGBQUAD), NULL, FILE_CURRENT);
			offsetBytes += 256*sizeof(RGBQUAD);
		}
	}
	else if (image_pal)
		*image_pal = NULL;

	uint8 *ptr = (uint8*)&row_pointers[bm_head.biHeight];
	SetFilePointer(hFile, file_head.bfOffBits - offsetBytes, NULL, FILE_CURRENT);
	if (!ReadFile(hFile, ptr, bm_head.biHeight * row_width, &bytes, NULL))
	{
		free(row_pointers);
		errno = GetLastError();
		return NULL;
	}
	for (int row = bm_head.biHeight-1; row >= 0; row--)
	{
		row_pointers[row] = ptr;
		ptr += row_width;
	}
	*image_width = bm_head.biWidth;
	*image_height = bm_head.biHeight;
	*pixel_size = bpp;
	return row_pointers;
}

RGBQUAD* read_bmp_pal(HANDLE hFile)
{
	BITMAPFILEHEADER file_head;
	BITMAPINFOHEADER bm_head;
	DWORD bytes;

	if (!ReadFile(hFile, &file_head, sizeof(BITMAPFILEHEADER), &bytes, NULL))
	{
		errno = GetLastError();
		return NULL;
	}
	if (!ReadFile(hFile, &bm_head, sizeof(BITMAPINFOHEADER), &bytes, NULL))
	{
		errno = GetLastError();
		return NULL;
	}
	if (bytes != sizeof(BITMAPINFOHEADER)
	|| file_head.bfType != 0x4D42)
	{
		errno = EILSEQ;
		return NULL;
	}
	if (bm_head.biBitCount != 8)
	{
		errno = NO_ERROR;
		return NULL;
	}
	RGBQUAD *pal = calloc(256, sizeof(RGBQUAD));
	if (!pal)
	{
		errno = ENOMEM;
		return NULL;
	}
	if (!ReadFile(hFile, pal, 256*sizeof(RGBQUAD), &bytes, NULL))
	{
		free(pal);
		errno = GetLastError();
		return NULL;
	}
	if (bytes != 256*sizeof(RGBQUAD))
	{
		free(pal);
		errno = EILSEQ;
		return NULL;
	}
	return pal;
}
