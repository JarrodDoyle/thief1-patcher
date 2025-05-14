/******************************************************************************
 *    pal.c
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

RGBQUAD* read_bmp_pal(HANDLE hFile);
RGBQUAD* read_pcx_pal(HANDLE hFile);
RGBQUAD* read_gif_pal(HANDLE hFile);
RGBQUAD* read_png_pal(HANDLE hFile, int sigbytes);

extern const uint32	_ctable[];
extern uint32	_aatable[256];

static char* next_line(char* line, unsigned long *n)
{
	char *c = memchr(line, '\n', *n);
	if (c)
	{
		*n -= ++c - line;
		return c;
	}
	return NULL;
}

static void read_pal_text(RGBQUAD *pal, int count, char *data, unsigned long length)
{
	char buf[32];
	for (int i = 0; data && length && i < count; i++)
	{
		unsigned long l = length >= sizeof(buf) ? sizeof(buf)-1 : length;
		char *n = next_line(data, &length);
		if (n)
		{
			l = n - data;
			if (l >= sizeof(buf)) l = sizeof(buf)-1;
		}
		memcpy(buf, data, l);
		buf[l] = 0;
		char *c = buf;
		pal[i].rgbRed = strtoul(c, &c, 10);
		pal[i].rgbGreen = strtoul(c, &c, 10);
		pal[i].rgbBlue = strtoul(c, &c, 10);
		data = n;
	}
}

static Boolean read_jasc_pal(HANDLE hPalFile, RGBQUAD *pal)
{
	int err;
	DWORD bytes;
	unsigned long pal_size;
	SetFilePointer(hPalFile, 0, 0, FILE_BEGIN);
	pal_size = GetFileSize(hPalFile, &bytes);
	if (pal_size == INVALID_FILE_SIZE && (err = GetLastError()) != NO_ERROR)
	{
		errprintf("Cannot read file\n");
		errno = err;
		return FALSE;
	}
	if (bytes)
		pal_size = 0xFFFFFFFFUL;
	char *pal_data = loadfile(hPalFile);
	if (!pal_data)
	{
		errprintf("Out of memory\n");
		errno = ENOMEM;
		return FALSE;
	}
	if (memcmp(pal_data, "JASC-PAL", 8))
	{
		errprintf("Unsupported palette type\n");
		unloadfile(hPalFile, pal_data);
		errno = EILSEQ;
		return FALSE;
	}
	char *ptr = next_line(pal_data, &pal_size);
	ptr = ptr ? next_line(ptr, &pal_size) : NULL;
	if (!ptr)
	{
		errprintf("Unsupported palette type\n");
		unloadfile(hPalFile, pal_data);
		errno = EILSEQ;
		return FALSE;
	}
	char *n = next_line(ptr, &pal_size);
	if (!n)
	{
		errprintf("Unsupported palette type\n");
		unloadfile(hPalFile, pal_data);
		errno = EILSEQ;
		return FALSE;
	}
	int count = strtoul(ptr, NULL, 10);
	ptr = n;
	if (count > 256)
		count = 256;
	read_pal_text(pal, count, ptr, pal_size);
	unloadfile(hPalFile, pal_data);
	return TRUE;
}

static Boolean read_gimp_pal(HANDLE hPalFile, RGBQUAD *pal)
{
	int err;
	DWORD bytes;
	unsigned long pal_size;
	SetFilePointer(hPalFile, 0, 0, FILE_BEGIN);
	pal_size = GetFileSize(hPalFile, &bytes);
	if (pal_size == INVALID_FILE_SIZE && (err = GetLastError()) != NO_ERROR)
	{
		errprintf("Cannot read file\n");
		errno = err;
		return FALSE;
	}
	if (bytes)
		pal_size = 0xFFFFFFFFUL;
	char *pal_data = loadfile(hPalFile);
	if (!pal_data)
	{
		errprintf("Out of memory\n");
		errno = ENOMEM;
		return FALSE;
	}
	if (memcmp(pal_data, "GIMP Palette", 12))
	{
		errprintf("Unsupported palette type\n");
		unloadfile(hPalFile, pal_data);
		errno = EILSEQ;
		return FALSE;
	}
	char *ptr = next_line(pal_data, &pal_size);
	while (ptr && *ptr != '#')
		ptr = next_line(ptr, &pal_size);
	if (!ptr)
	{
		errprintf("Unsupported palette type\n");
		unloadfile(hPalFile, pal_data);
		errno = EILSEQ;
		return FALSE;
	}
	ptr = next_line(ptr, &pal_size);
	read_pal_text(pal, 256, ptr, pal_size);
	unloadfile(hPalFile, pal_data);
	return TRUE;
}

static Boolean read_riff_pal(HANDLE hPalFile, RGBQUAD *pal)
{
	struct 
	{
		uint32 rifflength;
		uint32 psig1;
		uint32 psig2;
		uint32 length;
	} h;
	DWORD bytes = 0;
	if (!ReadFile(hPalFile, &h, 16, &bytes, NULL))
	{
		errprintf("Cannot read file\n");
		errno = GetLastError();
		return FALSE;
	}
	if (bytes != 16)
	{
		errprintf("Cannot read file\n");
		errno = ERANGE;
		return FALSE;
	}
	if (h.psig1 != 0x204C4150)
	{
		errprintf("Unsupported palette type\n");
		errno = EILSEQ;
		return FALSE;
	}
	uint16 count;
	SetFilePointer(hPalFile, 2, NULL, FILE_CURRENT);
	if (!ReadFile(hPalFile, &count, 2, &bytes, NULL))
	{
		errprintf("Cannot read file\n");
		errno = GetLastError();
		return FALSE;
	}
	if (count > 256)
		count = 256;
	if (!ReadFile(hPalFile, pal, sizeof(RGBQUAD)*count, &bytes, NULL))
	{
		errprintf("Cannot read file\n");
		errno = GetLastError();
		return FALSE;
	}
	count = bytes / sizeof(RGBQUAD);
	for (int i = 0; i < count; i++)
	{
		uint8 s = pal[i].rgbRed;
		pal[i].rgbRed = pal[i].rgbBlue;
		pal[i].rgbBlue = s;
	}
	return TRUE;
}

RGBQUAD* read_pal(HANDLE hPalFile)
{
	union {
		uint32 l;
		uint8 b[4];
	} sig;
	DWORD bytes = 0;
	RGBQUAD *pal = (RGBQUAD*)calloc(256, sizeof(RGBQUAD));
	if (!pal)
	{
		errprintf("Out of memory\n");
		errno = ENOMEM;
		return NULL;
	}
	ReadFile(hPalFile, sig.b, sizeof(sig), &bytes, NULL);
	if (bytes != 4)
	{
		errprintf("Cannot read file\n");
		free(pal);
		errno = ERANGE;
		return NULL;
	}
	if (sig.l == 0x46464952)
	{
		if (!read_riff_pal(hPalFile, pal))
		{
			free(pal);
			return NULL;
		}
		return pal;
	}
	else if (sig.l == 0x4353414A)
	{
		if (!read_jasc_pal(hPalFile, pal))
		{
			free(pal);
			return NULL;
		}
		return pal;
	}
	else if (sig.l == 0x504D4947)
	{
		if (!read_gimp_pal(hPalFile, pal))
		{
			free(pal);
			return NULL;
		}
		return pal;
	}
	else if (sig.l == 0x38464947)
	{
		free(pal);
		SetFilePointer(hPalFile, 0, 0, FILE_BEGIN);
		pal = read_gif_pal(hPalFile);
	}
	else if (sig.b[0] == 0x42 && sig.b[1] == 0x4D)
	{
		free(pal);
		SetFilePointer(hPalFile, 0, 0, FILE_BEGIN);
		pal = read_bmp_pal(hPalFile);
	}
	else if (sig.b[0] == 0xA && sig.b[1] <= 5)
	{
		free(pal);
		SetFilePointer(hPalFile, 0, 0, FILE_BEGIN);
		pal = read_pcx_pal(hPalFile);
	}
	else if (png_sig_cmp(sig.b, 0, sizeof(sig)) == 0)
	{
		free(pal);
		pal = read_png_pal(hPalFile, sizeof(sig));
	}
	else
	{
		SetFilePointer(hPalFile, 0, 0, FILE_BEGIN);
		RGBTRIPLE *p = calloc(256,sizeof(RGBTRIPLE));
		if (!p)
		{
			errprintf("Out of memory\n");
			free(pal);
			errno = ENOMEM;
			return NULL;
		}
		ReadFile(hPalFile, p, sizeof(RGBTRIPLE)*256, &bytes, NULL);
		int count = bytes / sizeof(RGBTRIPLE);
		for (int i = 0; i < count; i++)
		{
			pal[i].rgbRed = p[i].rgbtBlue;
			pal[i].rgbGreen = p[i].rgbtGreen;
			pal[i].rgbBlue = p[i].rgbtRed;
		}
		free(p);
		return pal;
	}
	if (!pal)
	{
		if (errno == ENOMEM)
			errprintf("Out of memory\n");
		else
			errprintf("Cannot read file\n");
		return NULL;
	}
	return pal;
}

RGBQUAD* load_pal(const cchar_t *pal_name)
{
	RGBQUAD *pal_data;
	if (pal_name)
	{
		HANDLE hFile = OpenFile(pal_name);
		if (hFile == INVALID_HANDLE_VALUE)
		{
			errno = GetLastError();
			return NULL;
		}
		pal_data = read_pal(hFile);
		CloseHandle(hFile);
		if (!pal_data)
		{
			return NULL;
		}
	}
	else
		pal_data = (RGBQUAD*)_ctable;
	return pal_data;
}

void free_pal(RGBQUAD* pal_data)
{
	if (pal_data != (RGBQUAD*)_ctable && pal_data != (RGBQUAD*)_aatable)
		free(pal_data);
}

