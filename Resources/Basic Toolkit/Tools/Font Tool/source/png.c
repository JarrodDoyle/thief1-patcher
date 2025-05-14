/******************************************************************************
 *    png.c
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

static void png_file_reader(png_structp png_ptr, png_bytep data, png_size_t length)
{
	DWORD bytes;
	HANDLE h = png_get_io_ptr(png_ptr);
	if (!ReadFile(h, data, length, &bytes, NULL))
		png_error(png_ptr, "I/O error");
	if (bytes != length)
		png_error(png_ptr, "Premature end-of-file");
}

uint8** read_png(HANDLE hFile, int *image_width, int *image_height, int *pixel_size, RGBQUAD **image_pal, int sigbytes)
{
	uint8 **row_pointers = NULL;
	png_structp png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
	if (!png_ptr)
	{
		errno = ENOMEM;
		return NULL;
	}
	png_infop info_ptr = png_create_info_struct(png_ptr);
	if (!info_ptr)
	{
		png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
		errno = ENOMEM;
		return NULL;
	}
	if (setjmp(png_jmpbuf(png_ptr)))
	{
		if (row_pointers)
			free(row_pointers);
		png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
		return NULL;
	}
	png_set_read_fn(png_ptr, (png_voidp)hFile, png_file_reader);
	png_set_sig_bytes(png_ptr, sigbytes);
	png_read_info(png_ptr, info_ptr);

	png_uint_32 width, height;
	int bit_depth, color_type, bpp;
	png_get_IHDR(png_ptr, info_ptr, &width, &height, &bit_depth, &color_type, NULL, NULL, NULL);
	if ((color_type & (PNG_COLOR_MASK_COLOR|PNG_COLOR_MASK_PALETTE)) == PNG_COLOR_MASK_COLOR)
		bpp = 3;
	else
		bpp = 1;

	if (bit_depth > 8)
		png_set_strip_16(png_ptr);
	else if (bit_depth < 8)
	{
		if ((color_type & ~PNG_COLOR_MASK_ALPHA) == PNG_COLOR_TYPE_GRAY)
			png_set_expand_gray_1_2_4_to_8(png_ptr);
		else
			png_set_packing(png_ptr);
	}
	if (color_type & PNG_COLOR_MASK_ALPHA)
		png_set_strip_alpha(png_ptr);
	png_read_update_info(png_ptr, info_ptr);

	uint32 row_width = png_get_rowbytes(png_ptr, info_ptr);
	row_pointers = calloc(height, sizeof(png_bytep) + row_width);
	if (!row_pointers)
	{
		png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
		errno = ENOMEM;
		return NULL;
	}
	uint8 *ptr = (uint8*)&row_pointers[height];
	for (png_uint_32 row = 0; row < height; ptr += row_width, row++)
		row_pointers[row] = ptr;
	png_read_image(png_ptr, (png_bytepp)row_pointers);
	png_read_end(png_ptr, NULL);

	if (image_pal)
	{
		if (bpp == 1)
		{
			RGBQUAD *pal = calloc(256, sizeof(RGBQUAD));
			if (!pal)
			{
				free(row_pointers);
				png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
				errno = ENOMEM;
				return NULL;
			}
			if (png_get_valid(png_ptr, info_ptr, PNG_INFO_PLTE))
			{
				int num_pal;
				png_colorp png_pal;
				png_get_PLTE(png_ptr, info_ptr, &png_pal, &num_pal);
				while (num_pal--)
				{
					pal[num_pal].rgbRed = png_pal[num_pal].red;
					pal[num_pal].rgbGreen = png_pal[num_pal].green;
					pal[num_pal].rgbBlue = png_pal[num_pal].blue;
				}
			}
			*image_pal = pal;
		}
		else
		{
			*image_pal = NULL;
		}
	}

	png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
	*image_width = width;
	*image_height = height;
	*pixel_size = bpp;
	return row_pointers;
}

RGBQUAD* read_png_pal(HANDLE hFile, int sigbytes)
{
	volatile png_colorp grayscale = NULL;
	png_colorp png_pal = NULL;
	int num_pal;
	png_structp png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
	if (!png_ptr)
	{
		errno = ENOMEM;
		return NULL;
	}
	png_infop info_ptr = png_create_info_struct(png_ptr);
	if (!info_ptr)
	{
		png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
		errno = ENOMEM;
		return NULL;
	}
	if (setjmp(png_jmpbuf(png_ptr)))
	{
		if (grayscale)
			free(grayscale);
		png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
		return NULL;
	}
	png_set_read_fn(png_ptr, (png_voidp)hFile, png_file_reader);
	png_set_sig_bytes(png_ptr, sigbytes);
	png_read_info(png_ptr, info_ptr);

	png_uint_32 width, height;
	int bit_depth, color_type;
	png_get_IHDR(png_ptr, info_ptr, &width, &height, &bit_depth, &color_type, NULL, NULL, NULL);
	if ((color_type & ~PNG_COLOR_MASK_ALPHA) == PNG_COLOR_TYPE_GRAY)
	{
		grayscale = malloc(256*sizeof(png_color));
		png_build_grayscale_palette(8, grayscale);
		png_pal = grayscale;
		num_pal = 256;
	}
	else if ((color_type & PNG_COLOR_MASK_PALETTE) && bit_depth <= 8)
	{
		if (png_get_valid(png_ptr, info_ptr, PNG_INFO_PLTE))
			png_get_PLTE(png_ptr, info_ptr, &png_pal, &num_pal);
	}
	if (!png_pal)
	{
		png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
		return NULL;
	}
	RGBQUAD *pal = calloc(256, sizeof(RGBQUAD));
	if (!pal)
	{
		if (grayscale)
			free(grayscale);
		png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
		errno = ENOMEM;
		return NULL;
	}
	while (num_pal--)
	{
		pal[num_pal].rgbRed = png_pal[num_pal].red;
		pal[num_pal].rgbGreen = png_pal[num_pal].green;
		pal[num_pal].rgbBlue = png_pal[num_pal].blue;
	}
	if (grayscale)
		free(grayscale);
	png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
	return pal;
}
