/******************************************************************************
 *    fon.h
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

#include "Dark/fon.h"

struct fon_image_
{
	HDC dc;
	HBITMAP mask;
	DWORD rop;
	struct char_info chars[256];
};
typedef struct fon_image_ fon_image;

fon_image* LoadFon(LPCTSTR fon_name, COLORREF *colors);
void DeleteFon(fon_image *fon);

int FonChar(HDC destDC, const fon_image *fon, int left, int top, int right, int bottom, unsigned char c);
int FonStr(HDC destDC, const fon_image *fon, int left, int top, int right, int bottom, const char *str, LPPOINT endpos);

