/******************************************************************************
 *    resources.h
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
#define ID_APP	1024

#define IDM_EXIT	(ID_APP-1)

#define IDM_FILE	(ID_APP)
#define IDM_NEWTEXT	(IDM_FILE+1)
#define IDM_OPENTEXT	(IDM_FILE+2)
#define IDM_SAVETEXT	(IDM_FILE+3)
#define IDM_OPENART	(IDM_FILE+4)

#define IDM_EDIT	(ID_APP+16)
#define IDM_UNDO	(IDM_EDIT+1)
#define IDM_CUT		(IDM_EDIT+2)
#define IDM_COPY	(IDM_EDIT+3)
#define IDM_PASTE	(IDM_EDIT+4)

#define IDM_PAGE	(ID_APP+32)
#define IDM_GOTOPAGE	(IDM_PAGE+1)
#define IDM_NEXTPAGE	(IDM_PAGE+2)
#define IDM_PREVPAGE	(IDM_PAGE+3)
#define IDM_NEWPAGE	(IDM_PAGE+4)
#define IDM_REMOVEPAGE	(IDM_PAGE+5)

#define IDM_HELP	(ID_APP+48)
#define IDM_ABOUT	(IDM_HELP+1)

#define IDT_EDITTEXT	(ID_APP+1)

#define ID_GETPAGE	(ID_APP+1)

#define IDS_INFOTEXT (ID_APP+1)
#define IDS_OPENART	(ID_APP+2)
#define IDS_OPENTEXT	(ID_APP+3)
#define IDS_SAVETEXT	(ID_APP+4)
#define IDS_ARTFILTER	(ID_APP+5)
#define IDS_STRFILTER	(ID_APP+6)
#define IDS_UNTITLED	(ID_APP+7)
#define IDS_TITLEFORMAT		(ID_APP+8)
#define IDS_TITLEPAGEFORMAT	(ID_APP+9)

#define IDS_ERRORTITLE	(ID_APP+16)
#define IDS_ERROR_WINDOW	(ID_APP+17)
#define IDS_ERROR_MEMORY	(ID_APP+18)
#define IDS_ERROR_LOADFILE	(ID_APP+19)
#define IDS_ERROR_SAVEFILE	(ID_APP+20)
#define IDS_ERROR_GRAPHICS	(ID_APP+21)

