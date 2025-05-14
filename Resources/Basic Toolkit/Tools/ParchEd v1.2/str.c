/******************************************************************************
 *    str.c
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
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <stdio.h>
#include "parched.h"

static char* next_line(char *ptr, char *end)
{
	while (*ptr != '\r' && *ptr != '\n')
	{
		if (++ptr == end)
			return NULL;
	}
	return ptr;
}

static char* next_str(char *ptr, char *end)
{
	char *mark;
l_nextstr:
	while (isspace(*ptr))
	{
		if (++ptr == end)
			return NULL;
	}
	if (!isalpha(*ptr))
	{
l_nextline:
		while (*ptr != '\r' && *ptr != '\n')
		{
			if (++ptr == end)
				return NULL;
		}
		goto l_nextstr;
	}

	mark = ptr;
	while (isalnum(*ptr) || *ptr == '_')
	{
		if (++ptr == end)
			return NULL;
	}
	while (isspace(*ptr))
	{
		if (*ptr == '\r' || *ptr == '\n')
			goto l_nextstr;
		if (++ptr == end)
			return NULL;
	}
	if (*ptr != ':')
		goto l_nextline;
	++ptr;
	while (isspace(*ptr))
	{
		if (*ptr == '\r' || *ptr == '\n')
			goto l_nextstr;
		if (++ptr == end)
			return NULL;
	}
	if (*ptr != '"')
		goto l_nextline;

	return mark;
}

static char* end_quote(char *ptr, char *end)
{
	int e = 0;
	while (ptr < end)
	{
		if (!e)
		{
			if (*ptr == '\\')
				e = 1;
			else if (*ptr == '"')
				return ptr;
		}
		else
			e = 0;
		++ptr;
	}
	return NULL;
}

/* if I were to support all escapes...
static const char _esctable[] = {
0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,
0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x1A,0x1B,0x1C,0x1D,0x1E,0x1F,
0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,
0x00,0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,
0x40,0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,
0x50,0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,
0x60,0x07,0x08,0x63,0x64,0x65,0x0C,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x0A,0x6F,
0x70,0x71,0x0D,0x73,0x09,0x75,0x0B,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x7F,
0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,
0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F,
0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,
0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF,
0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,
0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF,
0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,
0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF
};
static const char _hexdigits[] = {0,1,2,3,4,5,6,7,8,9,0,0,0,0,0,0,0,10,11,12,13,14,15};

static int unescape_str(char *dest, const char *src, const char *end)
{
	char *ptr = dest;
	int e = 0;
	while (src < end)
	{
		if (e)
		{
			if (*src >= '0' && *src <='3')
			{
				*ptr = *src++ - '0';
				if (*src >= '0' && *src <= '7')
				{
					*ptr = (*ptr << 3) | (*src++ - '0');
					if (*src >= '0' && *src <= '7')
					{
						*ptr = (*ptr << 3) | (*src++ - '0');
					}
				}
				++ptr;
			}
			else if (*src == 'x' && isxdigit(src[1]) && isxdigit(src[2]))
			{
				*ptr++ = (_hexdigits[(src[1]-'0')&0x1F]<<4) | _hexdigits[(src[2]-'0')&0x1F];
				src += 3;
			}
			else if (*src == '\r')
			{
				++src;
				if (*src == '\n')
					++src;
			}
			else if (*src == '\n')
			{
				++src;
			}
			else
				*ptr++ = _esctable[*(unsigned char*)src++];
			e = 0;
		}
		else
		{
			if (*src == '\\')
				e = 1;
			else
				*ptr++ = *src;
			++src;
		}
	}
	*ptr = '\0';
	return ptr-dest;
}
*/
/* instead, only support \t, line-continue, and general escapes (\" \\) */
static int unescape_str(char *dest, const char *src, const char *end)
{
	char *ptr = dest;
	int e = 0;
	while (src < end)
	{
		if (e)
		{
			switch (*src)
			{
			case '\r':
				if (src[1] == '\n')
					++src;
			case '\n':
				break;
			case 't':
				*ptr++ = '\t';
				break;
			default:
				*ptr++ = *src;
				break;
			}
			++src;
			e = 0;
		}
		else
		{
			if (*src == '\\')
				e = 1;
			else
				*ptr++ = *src;
			++src;
		}
	}
	*ptr = '\0';
	return ptr-dest;
}

static int escape_str(char *dest, const char *src)
{
	char *ptr = dest;
	char *brk;
	while ((brk = strpbrk(src, "\"\\")))
	{
		strncpy(ptr, src, brk-src);
		ptr += brk-src;
		*ptr++ = '\\';
		*ptr++ = *brk++;
		src = brk;
	}
	strcpy(ptr, src);
	return ptr-dest + strlen(src);
}

char** LoadStrFile(LPCTSTR filename, int *num_pages)
{
	HANDLE filehandle;
	HANDLE filemap;
	char *filebits;
	char **pages;
	int pagecount, usecount;
	DWORD filesize;
	char *ptr, *end, *qtr;
	int n;

	if ((filehandle = CreateFile(filename, GENERIC_READ, FILE_SHARE_READ,
			NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL))
			== INVALID_HANDLE_VALUE)
	{
		ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
		return NULL;
	}
	filesize = GetFileSize(filehandle, NULL);
	if (filesize == 0xFFFFFFFF)
	{
		ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
		CloseHandle(filehandle);
		return NULL;
	}
	if ((filemap = CreateFileMapping(filehandle, NULL, PAGE_READONLY, 0, 0, NULL)) == NULL)
	{
		ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
		CloseHandle(filehandle);
		return NULL;
	}
	if ((filebits = MapViewOfFile(filemap, FILE_MAP_READ, 0, 0, 0)) == NULL) {
		ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
		CloseHandle(filemap);
		CloseHandle(filehandle);
		return NULL;
	}

	pages = (char**)LocalAlloc(LPTR, sizeof(char*)*64);
	if (!pages)
	{
		ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
		UnmapViewOfFile(filebits);
		CloseHandle(filemap);
		CloseHandle(filehandle);
		return NULL;
	}
	pagecount = 64;
	usecount = 0;

	ptr = filebits;
	end = ptr + filesize;

	while (ptr && (ptr = next_str(ptr, end)))
	{
		if (strnicmp(ptr, "page_", 5) != 0)
		{
			ptr = next_line(ptr, end);
			continue;
		}
		n = atoi(ptr+5);
		ptr = strchr(ptr, '"') + 1;
		qtr = end_quote(ptr, end);
		if (!qtr)
			break;
		if (n >= pagecount)
		{
			pagecount = (n + 31) & ~31;
			pages = LocalReAlloc(pages, sizeof(char*)*pagecount, LMEM_MOVEABLE|LMEM_ZEROINIT);
			if (!pages)
			{
				ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
				break;
			}
		}
		if (n == usecount)
		{
			++usecount;
			while (pages[usecount] != NULL)
				++usecount;
		}
		if (pages[n] != NULL)
			LocalFree(pages[n]);
		pages[n] = LocalAlloc(LMEM_FIXED, qtr - ptr + 1);
		if (!pages[n])
		{
			ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
			break;
		}
		unescape_str(pages[n], ptr, qtr);
		ptr = next_line(qtr, end);
	}

    UnmapViewOfFile(filebits);
    CloseHandle(filemap);
	CloseHandle(filehandle);

	for (n=usecount; n<pagecount; n++)
	{
		if (pages[n] != NULL)
			LocalFree(pages[n]);
	}
	pages = LocalReAlloc(pages, sizeof(char*)*usecount, LMEM_MOVEABLE);
	if (!pages)
	{
		ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
		return NULL;
	}
	*num_pages = usecount;
	return pages;
}

int SaveStrFile(LPCTSTR filename, char **pages, int num_pages)
{
	HANDLE filehandle;
	char *buftext;
	int buflen;
	unsigned long count;
	int n;

	if ((filehandle = CreateFile(filename, GENERIC_WRITE, 0,
			NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL))
			== INVALID_HANDLE_VALUE)
	{
		ErrorDialog(IDS_ERROR_SAVEFILE, GetLastError(), __FILE__, __LINE__);
		return GetLastError();
	}
	for (n=0; n<num_pages; n++)
	{
		buflen = strlen(pages[n])+1;
		buftext = LocalAlloc(LMEM_FIXED, (buflen * 2) + 32);
		if (!buftext)
		{
			n = GetLastError();
			ErrorDialog(IDS_ERROR_MEMORY, n, __FILE__, __LINE__);
			CloseHandle(filehandle);
			return n;
		}
		if (buflen == 0)
		{
			count = snprintf(buftext, 32, "page_%d: \"\"\r\n", n);
			if (!WriteFile(filehandle, buftext, count, &count, NULL))
			{
				ErrorDialog(IDS_ERROR_SAVEFILE, GetLastError(), __FILE__, __LINE__);
				LocalFree(buftext);
				break;
			}
		}
		else
		{
			count = snprintf(buftext, 28, "page_%d: \"", n);
			count += escape_str(buftext+count, pages[n]);
			count += snprintf(buftext+count, 4, "\"\r\n");
			if (!WriteFile(filehandle, buftext, count, &count, NULL))
			{
				ErrorDialog(IDS_ERROR_SAVEFILE, GetLastError(), __FILE__, __LINE__);
				LocalFree(buftext);
				break;
			}
		}
		LocalFree(buftext);
	}

	CloseHandle(filehandle);
	return 0;
}

