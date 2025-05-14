/******************************************************************************
 *    fon.h
 *
 *    This file is part of DarkUtils
 *    Copyright (C) 2004 Tom N Harris <telliamed@whoopdedo.org>
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
#ifndef DARK_FON_H
#define DARK_FON_H

#include "utils.h"

#ifdef __cplusplus
namespace Dark
{
#endif

#define FON_FRACTSPACING	2
#define FON_HASKERNTAB		4
#define FON_VERTSPACEADJUST	8

#pragma pack(push,2)
struct fon_head
{
	uint16	format;		/* 1 - aa16, 2 - aa256, 0xCCCC - 8bpp, else - 1bpp */
	uint8	flags;
	uint8	palette;	/* 0 - use current, 1 - standard */
	sint16	fractional_spacing;
	sint32	kerntab_offset;
	sint16	vert_space_adjust;
	uint8	zero1[24];
	sint16	first_char;
	sint16	last_char;
	uint8	zero2[32];
	uint32	width_offset;
	uint32	bm_offset;
	uint16	row_width;	/* in bytes */
	uint16	num_rows;
};

struct char_info
{
	sint16	code;
	uint16	column;
	uint16	width;
	uint16	height;
	sint32	x,y;
};

#ifdef __cplusplus
} // namespace Dark
#endif

#endif
