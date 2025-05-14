/******************************************************************************
 *    defs.h
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
#ifndef DEFS_H
#define DEFS_H

#include "Dark/utils.h"

#ifdef _WIN32
#define UNICODE 1
#define WIN32_LEAN_AND_MEAN 
#include <windows.h>
#include <shellapi.h>
#include <errno.h>
#include <malloc.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef wchar_t	cchar_t;
#define _T(text)	TEXT(text)
#define cstrlen(s)	wcslen(s)
#define errprintf(fmt, ...)	fwprintf(stderr, TEXT("%s: " fmt), program, ##__VA_ARGS__)
#define stdprintf(fmt, ...)	fwprintf(stdout, TEXT(fmt), ##__VA_ARGS__)

#undef OpenFile
#undef CreateFile
#define OpenFile(n)	CreateFileW(n,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,0,NULL);
#define CreateFile(n)	CreateFileW(n,GENERIC_WRITE,0,NULL,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL)

#else /* _WIN32 */

#pragma pack(push,1)
typedef struct
{
	uint8 rgbtBlue;
	uint8 rgbtGreen;
	uint8 rgbtRed;
} RGBTRIPLE;

typedef struct
{
	uint8 rgbBlue;
	uint8 rgbGreen;
	uint8 rgbRed;
	uint8 rgbReserved;
} RGBQUAD;

#define RGB(r,g,b)	((uint32)(uint8)(r)|(((uint32)(uint8)(g))<<8)|(((uint32)(uint8)(b))<<16))

typedef struct
{
	uint16 bfType;
	uint32 bfSize;
	uint16 bfReserved1;
	uint16 bfReserved2;
	uint32 bfOffBits;
} BITMAPFILEHEADER;

typedef struct
{
	uint32 biSize;
	sint32 biWidth;
	sint32 biHeight;
	uint16 biPlanes;
	uint16 biBitCount;
	uint32 biCompression;
	uint32 biSizeImage;
	sint32 biXPelsPerMeter;
	sint32 biYPelsPerMeter;
	uint32 biClrUsed;
	uint32 biClrImportant;
} BITMAPINFOHEADER;
#pragma pack(pop)

#define GetLastError()	(errno)
#define SetLastError(e)	errno=(e)
#define NO_ERROR	0

#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <limits.h>
#include <errno.h>
#include <alloca.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define FALSE 0
#define TRUE 1
typedef unsigned int DWORD;
typedef int HANDLE;
#define FILE_BEGIN	SEEK_SET
#define FILE_CURRENT	SEEK_CUR
#define FILE_END	SEEK_END
#define INVALID_HANDLE_VALUE	-1
#define INVALID_FILE_SIZE	UINT_MAX

#define OpenFile(n)     	open(n,O_RDONLY)
#define CreateFile(n)   	open(n,O_WRONLY|O_CREAT,0666)
#define CloseHandle(h)  	close(h)
#define SetFilePointer(h,o,x,w)	lseek(h,o,w)
#define WriteFile(h,p,n,w,x)	((*(w)=write(h,p,n))!=(size_t)-1)
#define ReadFile(h,p,n,w,x)	((*(w)=read(h,p,n))!=(size_t)-1)
uint32 GetFileSize(int fd, uint32* hiword);

typedef char	cchar_t;
#define _T(text)	(text)
#define cstrlen(s)	strlen(s)
#define errprintf(fmt, ...)	fprintf(stderr, "%s: " fmt, program, ##__VA_ARGS__)
#define stdprintf(fmt, ...)	fprintf(stdout, fmt, ##__VA_ARGS__)

#endif

extern cchar_t *program;
uint8* loadfile(HANDLE hFile);
Boolean unloadfile(HANDLE hFile, uint8* ptr);
uint8** read_image(HANDLE hImageFile, int *image_width, int *image_height, int *pixel_size, RGBQUAD **image_pal);
RGBQUAD* load_pal(const cchar_t *pal_name);
RGBQUAD* read_pal(HANDLE hPalFile);
void free_pal(RGBQUAD* pal_data);

#endif /* DEFS_H */
