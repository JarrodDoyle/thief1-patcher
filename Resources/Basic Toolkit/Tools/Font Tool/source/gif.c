/******************************************************************************
 *    gif.c
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
#include <gif_lib.h>

#pragma pack(push,1)
typedef struct GraphicControlExt_
{
    GifByteType     block_size;
    unsigned int    has_transparent : 1;
    unsigned int    user_input : 1;
    unsigned int    disposal_method : 3;
    unsigned int    reserved : 3;
    unsigned short  delay_time;
    GifByteType     transparent_index;
} GraphicControlExt;
#pragma pack(pop)
#define GRAPHIC_CONTROL_DISPOSE_NA    0
#define GRAPHIC_CONTROL_DISPOSE_NONE  1
#define GRAPHIC_CONTROL_DISPOSE_BG    2
#define GRAPHIC_CONTROL_DISPOSE_PREV  3

static int gif_file_reader(GifFileType *gif, GifByteType *buf, int count)
{
	DWORD bytes;
	if (!ReadFile((HANDLE)gif->UserData, buf, count, &bytes, NULL))
		return 0;
	return bytes;
}

static Boolean ReadGifImage(GifFileType *giffile, GifByteType **rowp, Boolean transparent_p, GifByteType transparent_index)
{
    static const int InterlacedOffset[] = { 0, 4, 2, 1 };
    static const int InterlacedJumps[] = { 8, 8, 4, 2 };
    GifByteType *temp = NULL;

    int row = giffile->Image.Top;
    int col = giffile->Image.Left;
    int width = giffile->Image.Width;
    int height = giffile->Image.Height;

    if (col + width > giffile->SWidth || row + height > giffile->SHeight)
        return TRUE;

    if (transparent_p)
    {
        temp = malloc(width);
        if (!temp)
		return FALSE;
        memset(temp, transparent_index, width);
    }

    if (giffile->Image.Interlace)
    {
        for (int pass = 0; pass < 4; pass++)
	{
            for (int l = row + InterlacedOffset[pass]; l < row+height; l += InterlacedJumps[pass])
	    {
                GifByteType *dst = rowp[l] + col;
                if (transparent_p) {
                    if (DGifGetLine(giffile, temp, width) == GIF_ERROR)
		    {
                        free(temp);
                        return FALSE;
                    }
                    for (int k = 0; k < width; k++, dst++)
                        if (temp[k] != transparent_index)
				*dst = temp[k];
                }
		else
		{
                    if (DGifGetLine(giffile, dst, width) == GIF_ERROR)
                        return FALSE;
                }
            }
        }
    }
    else
    {
        for (int l = row; l < row+height; l++)
	{
            GifByteType *dst = rowp[l] + col;
            if (transparent_p)
	    {
                if (DGifGetLine(giffile, temp, width) == GIF_ERROR)
		{
                    free(temp);
                    return FALSE;
                }
                for (int k = 0;k < width; k++, dst++)
                    if (temp[k] != transparent_index)
			*dst = temp[k];
            }
	    else
	    {
                if (DGifGetLine(giffile, dst, width) == GIF_ERROR)
                    return FALSE;
            }
        }
    }
    if (transparent_p)
	free(temp);
    return TRUE;
}

uint8** read_image_gif(HANDLE hFile, int *image_width, int *image_height, int *pixel_size, RGBQUAD **image_pal)
{
	GifFileType *gif = DGifOpen(hFile, gif_file_reader);
	if (!gif)
		return NULL;

	int row_width = (gif->SWidth + 3) & ~3;
	uint8 **row_pointers = calloc(gif->SHeight, sizeof(char*) + row_width);
	if (!row_pointers)
	{
		DGifCloseFile(gif);
		errno = ENOMEM;
		return NULL;
	}
	uint8 *ptr = (uint8*)&row_pointers[gif->SHeight];
	memset(ptr, gif->SBackGroundColor, gif->SHeight * row_width);
	for (int row = 0; row < gif->SHeight; ptr += row_width, row++)
		row_pointers[row] = ptr;

	GifRecordType recordtype;
	GifByteType transparentcolor = 0;
	Boolean is_transparent = FALSE;
	do
	{
		if (DGifGetRecordType(gif, &recordtype) == GIF_ERROR)
			goto gif_error;
		if (recordtype == IMAGE_DESC_RECORD_TYPE)
		{
			if (DGifGetImageDesc(gif) == GIF_ERROR)
				goto gif_error;
			if (!ReadGifImage(gif, row_pointers, is_transparent, transparentcolor))
				goto gif_error;
			break;
		}
		else if (recordtype == EXTENSION_RECORD_TYPE)
		{
			int extcode;
			GifByteType *ext;
			if (DGifGetExtension(gif, &extcode, &ext) == GIF_ERROR)
				goto gif_error;
			while (ext != NULL)
			{
				if (extcode == GRAPHICS_EXT_FUNC_CODE)
				{
					if (((GraphicControlExt*)ext)->has_transparent)
					{
						transparentcolor = ((GraphicControlExt*)ext)->transparent_index;
						is_transparent = TRUE;
					}
				}
				if (DGifGetExtensionNext(gif, &ext) == GIF_ERROR)
					goto gif_error;
			}
		}
	}
	while (recordtype != TERMINATE_RECORD_TYPE);

	if (image_pal)
	{
		RGBQUAD *pal = calloc(256, sizeof(RGBQUAD));
		if (!pal)
		{
			errno = ENOMEM;
			goto gif_error;
			return NULL;
		}
		const ColorMapObject *cmap = gif->Image.ColorMap ?: gif->SColorMap;
		for (int i = 1 << cmap->BitsPerPixel; i--; )
		{
			pal[i].rgbRed = cmap->Colors[i].Red;
			pal[i].rgbGreen = cmap->Colors[i].Green;
			pal[i].rgbBlue = cmap->Colors[i].Blue;
		}
		*image_pal = pal;
	}

	*image_width = gif->SWidth;
	*image_height = gif->SHeight;
	*pixel_size = 1;
	DGifCloseFile(gif);
	return row_pointers;
gif_error:
	free(row_pointers);
	DGifCloseFile(gif);
	return NULL;
}

RGBQUAD* read_gif_pal(HANDLE hFile)
{
	GifFileType *gif = DGifOpen(hFile, gif_file_reader);
	if (!gif)
		return NULL;
	RGBQUAD *pal = calloc(256, sizeof(RGBQUAD));
	if (!pal)
	{
		errno = ENOMEM;
		DGifCloseFile(gif);
		return NULL;
	}
	for (int i = 1 << gif->SColorMap->BitsPerPixel; i--; )
	{
		pal[i].rgbRed = gif->SColorMap->Colors[i].Red;
		pal[i].rgbGreen = gif->SColorMap->Colors[i].Green;
		pal[i].rgbBlue = gif->SColorMap->Colors[i].Blue;
	}
	DGifCloseFile(gif);
	return pal;
}
