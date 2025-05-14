/******************************************************************************
 *    file.c
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
#include <png.h>
#ifndef _WIN32
#include <sys/mman.h>

uint32 GetFileSize(int fd, uint32* hiword)
{
	struct stat sb;
	if (fstat(fd, &sb) == -1)
		return INVALID_FILE_SIZE;
	*hiword = 0;
	return sb.st_size;
}
#endif

uint8* loadfile(HANDLE hFile)
{
#ifdef _WIN32
	HANDLE hFileMap = CreateFileMapping(hFile, NULL, PAGE_READONLY, 0, 0, NULL);
	if (!hFileMap)
	{
		errno = ENOMEM;
		return NULL;
	}
	uint8 *pRet = MapViewOfFile(hFileMap, FILE_MAP_READ, 0, 0, 0);
	CloseHandle(hFileMap);
	return pRet;
#else
	struct stat sb;
	if (fstat(hFile, &sb) == -1)
		return NULL;
	return mmap(NULL, sb.st_size ?: 1, PROT_READ, MAP_SHARED, hFile, 0);
#endif
}

Boolean unloadfile(HANDLE hFile, uint8* ptr)
{
#ifdef _WIN32
	hFile = hFile;
	return UnmapViewOfFile(ptr);
#else
	struct stat sb;
	if (fstat(hFile, &sb) == -1)
		return FALSE;
	return munmap(ptr, sb.st_size) == 0;
#endif
}

uint8** read_bmp(HANDLE hFile, int *image_width, int *image_height, int *pixel_size, RGBQUAD **image_pal);
uint8** read_image_pcx(HANDLE hFile, int *image_width, int *image_height, int *pixel_size, RGBQUAD **image_pal);
uint8** read_image_gif(HANDLE hFile, int *image_width, int *image_height, int *pixel_size, RGBQUAD **image_pal);
uint8** read_png(HANDLE hFile, int *image_width, int *image_height, int *pixel_size, RGBQUAD **image_pal, int sigbytes);

uint8** read_image(HANDLE hImageFile, int *image_width, int *image_height, int *pixel_size, RGBQUAD **image_pal)
{
	uint8** image_rows;
	union {
		uint32 l;
		uint8 b[4];
	} sig;
	DWORD bytes;
	if (!ReadFile(hImageFile, sig.b, sizeof(sig), &bytes, NULL) || bytes != 4)
	{
		errprintf("Could not read image\n");
		return NULL;
	}
	if (sig.b[0] == 0x42 && sig.b[1] == 0x4D)
	{
		SetFilePointer(hImageFile, 0, 0, FILE_BEGIN);
		image_rows = read_bmp(hImageFile, image_width, image_height, pixel_size, image_pal);
	}
	else if (sig.b[0] == 0xA && sig.b[1] <= 5)
	{
		SetFilePointer(hImageFile, 0, 0, FILE_BEGIN);
		image_rows = read_image_pcx(hImageFile, image_width, image_height, pixel_size, image_pal);
	}
	else if (sig.l == 0x38464947)
	{
		SetFilePointer(hImageFile, 0, 0, FILE_BEGIN);
		image_rows = read_image_gif(hImageFile, image_width, image_height, pixel_size, image_pal);
	}
	else if (png_sig_cmp(sig.b, 0, sizeof(sig)) == 0)
	{
		image_rows = read_png(hImageFile, image_width, image_height, pixel_size, image_pal, sizeof(sig));
	}
	else
	{
		errprintf("Unsupported image type\n");
		return NULL;
	}
	if (image_rows)
		return image_rows;
	if (errno == ENOMEM)
		errprintf("Out of memory\n");
	else
		errprintf("Unsupported image type\n");
	return NULL;
}
