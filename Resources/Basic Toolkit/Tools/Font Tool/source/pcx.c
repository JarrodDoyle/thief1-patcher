/******************************************************************************
 *    pcx.c
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

#pragma pack(push,1)
typedef struct
{
	uint8 r,g,b;
} rgb_t;

typedef struct
{
	uint8	signature;	/* 0x0A */
	uint8	version;	/* 0,2,5 */
	uint8	compressed;
	uint8	bpp;
	sint16	left;
	sint16	top;
	sint16	right;
	sint16	bottom;
	uint16	hres;
	uint16	vres;
	rgb_t		colors[16];
	uint8	reserved;
	uint8	planes;
	uint16	row_width;
	uint16	format;	/* 0 = rgb, 1 = index, 2 = gray */
	uint16	screen_width;
	uint16	screen_height;
	uint8	zero[54];
} pcx_header;
#pragma pack(pop)

#define RLEBUFSIZE	256
typedef struct {
	HANDLE filehandle;
	uint8 buffer[RLEBUFSIZE];
	uint8 *next;
	unsigned int buf_read;
	unsigned int buf_avail;
} rle_reader;

static void InitRLE(rle_reader *rle, HANDLE infile)
{
	rle->filehandle = infile;
	rle->next = rle->buffer;
	rle->buf_read = 0;
	rle->buf_avail = 0;
}

static int EndRLE(rle_reader *rle, uint8 *outp)
{
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
	{
		uint8 tmpbuf[16];
		DWORD count;
		while (ReadFile(rle->filehandle, tmpbuf, 16, &count, NULL) && count != 0)
		{
			uint8 *p = tmpbuf;
			while (count--)
			{
				if (*p++ == 0x0C)
				{
					memcpy(outp, p, count);
					return count;
				}
			}
		}
	}
	return 0;
}

static int NextRLE(rle_reader *rle)
{
	if (! rle->buf_avail)
	{
		if (!ReadFile(rle->filehandle, rle->buffer, RLEBUFSIZE, (DWORD*)&rle->buf_read, NULL))
		{
			errno = GetLastError();
			return -1;
		}
		rle->buf_avail = rle->buf_read;
		rle->next = rle->buffer;
	}
	if (rle->buf_avail == 0)
		return -1;
	--rle->buf_avail;
	return *rle->next++;
}

static int ReadRLE(rle_reader *rle, int *count)
{
	int code = NextRLE(rle);
	if (code == -1)
		return -1;
	if ((code & 0xC0) == 0xC0)
	{
		*count = code & 0x3F;
		code = NextRLE(rle);
	}
	else
		*count = 1;
	return code;
}

uint8** read_image_pcx(HANDLE hFile, int *image_width, int *image_height, int *pixel_size, RGBQUAD **image_pal)
{
	pcx_header head;
	rgb_t ctable[256];
	rle_reader rle;
	DWORD bytes;
	if (!ReadFile(hFile, &head, sizeof(pcx_header), &bytes, NULL))
	{
		errno = GetLastError();
		return NULL;
	}
	if (head.signature != 0x0A || head.version > 5
	 || head.bpp != 8 || !(head.planes == 1 || head.planes == 3 || head.planes == 4))
	{
		errno = EILSEQ;
		return NULL;
	}

	int width = head.right - head.left + 1;
	int height = head.bottom - head.top + 1;
	int bpp = head.planes == 1 ? 1 : 3;

	int rowsize = (width * bpp + 3) & ~3;
	if (rowsize < head.row_width)
		rowsize = head.row_width;
	uint8 *row_data = calloc(height, sizeof(char*) + rowsize);
	if (!row_data)
	{
		errno = ENOMEM;
		return NULL;
	}
	uint8 **row_pointers = (uint8**)row_data;
	row_data += height * sizeof(char*);
	uint8* ptr = row_data;
	for (int row = 0; row < height; row++)
	{
		row_pointers[row] = ptr;
		ptr += rowsize;
	}
	if (head.planes != 1)
	{
		if (head.compressed)
		{
			InitRLE(&rle, hFile);
			for (int row = 0; row < height; row++)
			{
				for (int plane = 2; plane >= 0; plane--)
				{
					int x = 0;
					ptr = row_pointers[row] + plane;
					while (x < head.row_width)
					{
						int count, code;
						code = ReadRLE(&rle, &count);
						if (code == -1)
						{
							free(row_pointers);
							errno = EILSEQ;
							return NULL;
						}
						x += count;
						while (count--)
						{
							*ptr = code;
							ptr += 3;
						}
					}
				}
				for (unsigned int plane = 3; plane < head.planes; plane++)
				{
					int x = 0;
					while (x < head.row_width)
					{
						int count, code;
						code = ReadRLE(&rle, &count);
						if (code == -1)
						{
							free(row_pointers);
							errno = EILSEQ;
							return NULL;
						}
						x += count;
					}
				}
			}
		}
		else
		{
			bytes = height * head.planes * head.row_width;
			uint8 *bits = malloc(bytes);
			for (int row = 0; row < height; row++)
			{
				uint8 *ptr = bits;
				if (!ReadFile(hFile, bits, head.planes * head.row_width, &bytes, NULL))
				{
					errno = GetLastError();
					free(row_pointers);
					return NULL;
				}
				if (bytes != head.planes * head.row_width)
				{
					errno = EILSEQ;
					free(row_pointers);
					return NULL;
				}
				for (int plane = 2; plane >= 0; plane--)
				{
					for (int x = 0; x < width; x++)
						row_pointers[row][x * 3 + plane] = ptr[x];
					ptr += head.row_width;
				}
				/*
				if (head.planes > 3)
				{
					bits += head.row_width * (head.planes - 3);
				}
				*/
			}
			free(bits);
		}		
	}
	else /* head.planes == 1 */
	{
		if (head.compressed)
		{
			InitRLE(&rle, hFile);
			for (int row = 0; row < height; row++)
			{
				int x = 0;
				ptr = row_pointers[row];
				while (x < head.row_width)
				{
					int count, code;
					code = ReadRLE(&rle, &count);
					if (code == -1)
					{
						free(row_pointers);
						errno = EILSEQ;
						return NULL;
					}
					x += count;
					while (count--)
					{
						*ptr++ = code;
					}
				}
			}
		}
		else
		{
			for (int row = height-1; row >= 0; row--)
			{
				if (!ReadFile(hFile, row_pointers[row], head.row_width, &bytes, NULL))
				{
					errno = GetLastError();
					free(row_pointers);
					return NULL;
				}
				if (bytes != head.row_width)
				{
					errno = EILSEQ;
					free(row_pointers);
					return NULL;
				}
			}
		}
	}

	if (image_pal)
	{
		if (head.bpp == 8 && head.planes == 1)
		{
			memset(ctable, 0, 256*sizeof(rgb_t));
			if (head.compressed)
			{
				uint8 *ptr = (uint8*)ctable;
				int count = EndRLE(&rle, ptr);
				if (!ReadFile(hFile, ptr+count, (256*sizeof(rgb_t)) - count, &bytes, NULL))
				{
					errno = GetLastError();
					free(row_pointers);
					return NULL;
				}
			}
			else
			{
				if (!ReadFile(hFile, ctable, 256*sizeof(rgb_t), &bytes, NULL))
				{
					errno = GetLastError();
					free(row_pointers);
					return NULL;
				}
			}
			RGBQUAD *pal = calloc(256, sizeof(RGBQUAD));
			if (!pal)
			{
				errno = ENOMEM;
				free(row_pointers);
				return NULL;
			}
			for (int i = 0; i < 256; i++)
			{
				pal[i].rgbRed = ctable[i].r;
				pal[i].rgbGreen = ctable[i].g;
				pal[i].rgbBlue = ctable[i].b;
			}
			*image_pal = pal;
		}
		else
			*image_pal = NULL;
	}

	*image_width = width;
	*image_height = height;
	*pixel_size = bpp;
	return row_pointers;

}

RGBQUAD* read_pcx_pal(HANDLE hFile)
{
	pcx_header head;
	DWORD bytes;
	if (!ReadFile(hFile, &head, sizeof(pcx_header), &bytes, NULL))
	{
		errno = GetLastError();
		return NULL;
	}
	if (head.signature != 0x0A || head.version > 5)
	{
		errno = EILSEQ;
		return NULL;
	}
	if (head.bpp == 1 && (head.planes == 4 || head.planes == 1))
	{
		RGBQUAD *pal = calloc(256, sizeof(RGBQUAD));
		if (!pal)
		{
			errno = ENOMEM;
			return NULL;
		}
		int ncolors = 1 << (head.planes - 1);
		for (int i = 0; i < ncolors; i++)
		{
			pal[i].rgbRed = head.colors[i].r;
			pal[i].rgbGreen = head.colors[i].g;
			pal[i].rgbBlue = head.colors[i].b;
		}
		return pal;
	}

	if (!(head.bpp == 8 && head.planes == 1))
		return NULL;

	rgb_t ctable[256];
	rle_reader rle;
	int height = head.bottom - head.top + 1;

	if (head.compressed)
	{
		InitRLE(&rle, hFile);
		for (int row = 0; row < height; row++)
		{
			int x = 0;
			while (x < head.row_width)
			{
				int count, code;
				code = ReadRLE(&rle, &count);
				if (code == -1)
					return NULL;
				x += count;
			}
		}
		uint8 *ptr = (uint8*)ctable;
		int count = EndRLE(&rle, ptr);
		if (!ReadFile(hFile, ptr+count, (256*sizeof(rgb_t)) - count, &bytes, NULL))
		{
			errno = GetLastError();
			return NULL;
		}
	}
	else
	{
		SetFilePointer(hFile, height * head.row_width, NULL, FILE_CURRENT);
		if (!ReadFile(hFile, ctable, 256*sizeof(rgb_t), &bytes, NULL))
		{
			errno = GetLastError();
			return NULL;
		}
	}

	RGBQUAD *pal = calloc(256, sizeof(RGBQUAD));
	if (!pal)
	{
		errno = ENOMEM;
		return NULL;
	}
	for (int i = 0; i < 256; i++)
	{
		pal[i].rgbRed = ctable[i].r;
		pal[i].rgbGreen = ctable[i].g;
		pal[i].rgbBlue = ctable[i].b;
	}
	return pal;
}
