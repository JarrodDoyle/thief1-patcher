/******************************************************************************
 *    brightui.h
 *
 *    This file is part of BrightUI
 *    Copyright (C) 2003 Tom N Harris <telliamed@whoopdedo.cjb.net>
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

#define FILEPAGE	0x01
#define COLORPAGE	0x02
#define PALETTEPAGE	0x04
#define MASKPAGE	0x08
#define TRANSPAGE	0x10

#define FILEOPTIONS		0
#define COLOROPTIONS	1
#define PALETTEOPTIONS	2
#define MASKOPTIONS		3
#define TRANSOPTIONS	4
#define NUMPAGES		5

const TCHAR* gTabNames[NUMPAGES];

#define PALAUTO		0
#define PALERROR	1
#define PALFILE		2
#define NUMPALOPTS	3

const TCHAR* gPaletteOptions[NUMPALOPTS];

#define MASKNONE		0
#define MASKDEFAULT		1
#define MASKPINKSCREEN	2
#define MASKPINKMASK	3
#define MASKGRAYMASK	4
#define MASKCOLMASK		5
#define NUMMASKOPTS		6

const TCHAR* gMaskOptions[NUMMASKOPTS];


#define ALLFORMATS		0
#define PCXFORMAT		1
#define BMPFORMAT		2
#define TGAFORMAT		3
#define NUMFILTERS		4

const TCHAR* gFilters[NUMFILTERS];


#define DOBRIGHT	1
#define DOMASK		2
#define DOTRANS		3


extern void OutputText(LPCTSTR txt);
extern BOOL ConfirmDialog(HWND parent, DWORD id, ...);

extern DWORD ExecuteBright(HWND parent, LPCTSTR cmds, LPCTSTR destdir, LPCTSTR prefix, HWND lb, BOOL individual);
extern void OpenManual(HWND parent);

