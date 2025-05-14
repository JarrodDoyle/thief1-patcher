/******************************************************************************
 *    revpal.c
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
#include <windows.h>

void swaptriples(RGBTRIPLE *pColors, int iCount)
{
	RGBTRIPLE tmp;
	int i,j;
	for (i=0,j=iCount-1; i<j; i++,j--)
	{
		tmp = pColors[i];
		pColors[i] = pColors[j];
		pColors[j] = tmp;
	}
}

void swapquads(RGBQUAD *pColors, int iCount)
{
	RGBQUAD tmp;
	int i,j;
	for (i=0,j=iCount-1; i<j; i++,j--)
	{
		tmp = pColors[i];
		pColors[i] = pColors[j];
		pColors[j] = tmp;
	}
}

typedef struct 
{
	DWORD riffsig;
	DWORD rifflength;
	DWORD psig1;
	DWORD psig2;
	DWORD length;
} riffheader;

void swapriffpal(char* pData)
{
	int colors;
	riffheader *h = (riffheader*)pData;
	if (!(h->psig1 == 0x204C4150 && h->psig2 == 0x61746164))
	{
		fprintf(stderr, "Unsupported RIFF type.");
		return;
	}
	colors = *(short*)(pData + sizeof(riffheader) + 2);
	swapquads((RGBQUAD*)(pData + sizeof(riffheader) + 4), colors);
}

void swapbmppal(char *pData)
{
	BITMAPFILEHEADER *file_head;
	BITMAPINFOHEADER *bm_head;
	char* bits;
	int n;

	file_head = (BITMAPFILEHEADER*)pData;
	bm_head = (BITMAPINFOHEADER*)(pData + sizeof(BITMAPFILEHEADER));
	if (!(bm_head->biBitCount == 8 /*|| bm_head->biBitCount == 4 || bm_head->biBitCount == 1*/)
	 || bm_head->biCompression != BI_RGB)
	{
		fprintf(stderr, "Unsupported BMP type.");
		return;
	}
	swapquads((RGBQUAD*)(pData + sizeof(BITMAPFILEHEADER) + bm_head->biSize), bm_head->biClrUsed);
	bits = pData + file_head->bfOffBits;
	n = (bm_head->biSizeImage == 0) ? bm_head->biHeight * bm_head->biWidth : bm_head->biSizeImage;
	while (n--)
	{
		*bits++ = ~*bits;
	}
}

char* loadfile(HANDLE hFile)
{
	HANDLE hFileMap;
	char *pRet;

	hFileMap = CreateFileMapping(hFile, NULL, PAGE_READWRITE, 0, 0, NULL);
	if (!hFileMap)
		return NULL;
	pRet = MapViewOfFile(hFileMap, FILE_MAP_WRITE, 0, 0, 0);
	CloseHandle(hFileMap);
	return pRet;
}

int process(LPCTSTR pszFileName)
{
	HANDLE hFile;
	char *pData;
	unsigned long tag;
	int colors;

	hFile = CreateFile(pszFileName, GENERIC_READ|GENERIC_WRITE, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
	if (hFile == INVALID_HANDLE_VALUE)
	{
		return 1;
	}
	pData = loadfile(hFile);
	if (pData == NULL)
	{
		CloseHandle(hFile);
		return 2;
	}

	tag = *(unsigned long*)pData;
	if (tag == 0x4353414A)
	{
		fprintf(stderr, "JASC Palettes are unsupported at this time.\n");
	}
	else if (tag == 0x46464952)
	{
		swapriffpal(pData);
	}
	else if ((tag & 0xFFFF) == 0x4D42)
	{
		swapbmppal(pData);
	}
	else
	{
		colors = GetFileSize(hFile, NULL) / 3;
		if (colors <= 256)
			swaptriples((RGBTRIPLE*)pData, colors);
	}
	UnmapViewOfFile(pData);
	CloseHandle(hFile);
	return 0;
}

int main(int argc, char* argv[])
{
	int n;
	int err = 0;
	for (n=1; n<argc; n++)
		if (0 != (err = process(argv[n])))
			break;
	return err;
}
