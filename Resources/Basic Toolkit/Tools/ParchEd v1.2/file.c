/******************************************************************************
 *    file.c
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
#include "parched.h"

/*
extern HBITMAP LoadJPEG(HANDLE filehandle, unsigned long *width, unsigned long *height);
extern HBITMAP LoadGIF(HANDLE filehandle, unsigned long *width, unsigned long *height);
extern HBITMAP LoadPNG(HANDLE filehandle, unsigned long *width, unsigned long *height);
*/
extern HBITMAP LoadPCX(HANDLE filehandle, unsigned long *width, unsigned long *height, COLORREF *colors);


extern HINSTANCE gInstance;


BOOL ResetFile(HANDLE filehandle)
{
    LONG hiword = 0;
    SetFilePointer(filehandle, 0, &hiword, FILE_BEGIN);
    return (hiword != 0);
}

/*
HBITMAP LoadBMPFile(LPTSTR filename, unsigned long *width, unsigned long *height)
{
    HBITMAP image;
    BITMAPINFOHEADER head;
    HDC screen;

    image = LoadImage(gInstance, filename, IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE | LR_CREATEDIBSECTION | LR_LOADREALSIZE);
    if (image) {
        head.biSize = sizeof(BITMAPINFOHEADER);
        head.biBitCount = 0;
        screen = GetDC(NULL);
        GetDIBits(screen, image, 0, 0, NULL, (LPBITMAPINFO)&head, DIB_RGB_COLORS);
        ReleaseDC(NULL, screen);
        *width = head.biWidth;
        *height = head.biHeight;
    }
    return image;
}
*/
HBITMAP LoadBMP(HANDLE filehandle, unsigned long *width, unsigned long *height, COLORREF *colors)
{
    DWORD count;
    HANDLE filemap;
    HBITMAP bitmap;
    HDC screen;
    VOID* filebits;
    BITMAPINFOHEADER* info;
    BITMAPFILEHEADER head;
    if (!ReadFile(filehandle, &head, sizeof(BITMAPFILEHEADER), &count, NULL) || count != sizeof(BITMAPFILEHEADER)) {
		ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
        ResetFile(filehandle);
        return NULL;
    }
    if (head.bfType != 0x4D42 || head.bfSize == 0 || head.bfOffBits == 0) {
        ResetFile(filehandle);
        return NULL;
    }
    if ((filemap = CreateFileMapping(filehandle, NULL, PAGE_READONLY, 0, 0, NULL)) == NULL) {
		ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
        ResetFile(filehandle);
        return NULL;
    }
    /* I wanted to only map head.bfSize, but NOOOO.... I had to come across a 
       fucked-up file that had an incorrect bfSize field. And since nothing else 
       even warned about this, I have no choice but to ignore bfSize and just map
       the whole damned thing. Sure, I could pre-read the BMIHeader, but I really 
       *hate* pointless sequential reads when I spent all this money on a CPU with 
       a virtual address space. */
    if ((filebits = MapViewOfFile(filemap, FILE_MAP_READ, 0, 0, 0)) == NULL) {
		ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
        CloseHandle(filemap);
        ResetFile(filehandle);
        return NULL;
    }
    info = (BITMAPINFOHEADER*)(filebits+sizeof(BITMAPFILEHEADER));
    screen = GetDC(NULL);
    bitmap = CreateDIBitmap(screen, info, CBM_INIT, filebits + head.bfOffBits, (LPBITMAPINFO)info, DIB_RGB_COLORS);
    if (bitmap) {
        if (info->biSize == sizeof(BITMAPCOREHEADER)) {
            *width = ((LPBITMAPCOREHEADER)info)->bcWidth;
            *height = ((LPBITMAPCOREHEADER)info)->bcHeight;
        } else {
            *width = info->biWidth;
            *height = info->biHeight;
        }
		if (colors && info->biBitCount <= 8)
		{
			CopyMemory(colors, filebits+sizeof(BITMAPFILEHEADER)+info->biSize, sizeof(RGBQUAD)*info->biClrUsed);
		}
    }
	else
		ErrorDialog(IDS_ERROR_GRAPHICS, GetLastError(), __FILE__, __LINE__);
    ReleaseDC(NULL, screen);
    UnmapViewOfFile(filebits);
    CloseHandle(filemap);
    return bitmap;
}

HBITMAP LoadImageFile(LPCTSTR filename, unsigned long *width, unsigned long *height, COLORREF *colors)
{
    HBITMAP bitmap = NULL;
    HANDLE filehandle;
    if ((filehandle = CreateFile(filename, GENERIC_READ, FILE_SHARE_READ,
                                 NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL))
                   == INVALID_HANDLE_VALUE) {
		ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
        return NULL;
    }
    bitmap = LoadBMP(filehandle, width, height, colors);
	/*
    if (!bitmap) bitmap = LoadPNG(filehandle, width, height);
    if (!bitmap) bitmap = LoadGIF(filehandle, width, height);
    if (!bitmap) bitmap = LoadJPEG(filehandle, width, height);
	*/
	if (!bitmap) bitmap = LoadPCX(filehandle, width, height, colors);

	CloseHandle(filehandle);
    return bitmap;
}


