/******************************************************************************
 *    parched.c
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
#include <commdlg.h>
#include <shlwapi.h>
#include <richedit.h>
#include "parched.h"
#include "fon.h"


void ErrorDialog(DWORD id, DWORD code, const char* file, unsigned int line);

static void FlushPage(void);


const TCHAR* gszAppClass = TEXT("ParchEd");
TCHAR gszAppName[256];
TCHAR gszTitleFormat[256];
TCHAR gszTitlePageFormat[256];
TCHAR gszOpenArtTitle[256];
TCHAR gszOpenTextTitle[256];
TCHAR gszSaveTextTitle[256];
TCHAR gszArtFilter[256];
TCHAR gszTextFilter[256];
TCHAR gszUntitled[256];

TCHAR gBookName[260];

HINSTANCE gInstance = NULL;
HMENU gMenu = NULL;
HACCEL gKeys = NULL;
HWND gMainWin = NULL;
HWND gTextWin = NULL;

char **gPages = NULL;
int gNumPages = 0;
int gCurrentPage = -1;

HDC gBackground = NULL;
HDC gOffscreen = NULL;
unsigned long gWidth=0, gHeight=0;

fon_image *gFont = NULL;

struct pinkrect_
{
	unsigned short left,top,right,bottom;
};
typedef struct pinkrect_ pinkrect;

pinkrect *gRectList = NULL;
int gNumRects = 0;


static pinkrect* LoadRects(LPCTSTR filename, int *num_rects)
{
	HANDLE filehandle;
	HANDLE filemap;
	VOID *filebits;
	pinkrect *rects;
	DWORD filesize;
	unsigned long count;
	DWORD err;

	if ((filehandle = CreateFile(filename, GENERIC_READ, FILE_SHARE_READ,
			NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL))
			== INVALID_HANDLE_VALUE)
	{
		err = GetLastError();
		if (err != ERROR_FILE_NOT_FOUND)
			ErrorDialog(IDS_ERROR_LOADFILE, err, __FILE__, __LINE__);
		return NULL;
	}

	filesize = GetFileSize(filehandle, NULL);
	if (filesize == 0xFFFFFFFF)
	{
		ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
		CloseHandle(filehandle);
		return NULL;
	}

	count = filesize / sizeof(pinkrect);
	rects = (pinkrect*)LocalAlloc(LPTR, sizeof(pinkrect)*count);
	if (!rects)
	{
		ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
		CloseHandle(filehandle);
		PostQuitMessage(1);
		return NULL;
	}

	if ((filemap = CreateFileMapping(filehandle, NULL, PAGE_READONLY, 0, 0, NULL)) == NULL) {
		ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
		CloseHandle(filehandle);
		LocalFree(rects);
		return NULL;
	}
    if ((filebits = MapViewOfFile(filemap, FILE_MAP_READ, 0, 0, sizeof(pinkrect) * count)) == NULL) {
		ErrorDialog(IDS_ERROR_LOADFILE, GetLastError(), __FILE__, __LINE__);
        CloseHandle(filemap);
        CloseHandle(filehandle);
		LocalFree(rects);
        return NULL;
    }
	CopyMemory(rects, filebits, sizeof(pinkrect) * count);

    UnmapViewOfFile(filebits);
    CloseHandle(filemap);
	CloseHandle(filehandle);
	*num_rects = count;
	return rects;
}

static void UpdateTitle(void)
{
	TCHAR title[1024];
	if (!gBookName[0])
		wnsprintf(title, 1024, TEXT("%s"), gszAppName);
	else if (gCurrentPage == -1)
		wnsprintf(title, 1024, gszTitleFormat, gBookName);
	else
		wnsprintf(title, 1024, gszTitlePageFormat, gBookName, gCurrentPage+1, gNumPages);
	SetWindowText(gMainWin, title);
}

static void DisplayBook(HWND hwnd)
{
	HDC hdc;
	PAINTSTRUCT ps;

	if (gOffscreen == NULL)
		return;
	hdc = BeginPaint(hwnd, &ps);
	BitBlt(hdc, 0, 0, gWidth, gHeight, gOffscreen, 0, 0, SRCCOPY);
	EndPaint(hwnd, &ps);
}

static void UpdateImage(void)
{
	RECT rc;
	/*HBRUSH br;*/
	char *textbuf;
	int textlen;
	int count, n;

	if (!gOffscreen)
		return;
	if (!gBackground)
	{
		rc.left = 0; rc.top = 0;
		rc.right = gWidth;
		rc.bottom = gHeight;
		FillRect(gOffscreen, &rc, (HBRUSH)GetStockObject(BLACK_BRUSH));
	}
	else
	{
		BitBlt(gOffscreen, 0, 0, gWidth, gHeight, gBackground, 0, 0, SRCCOPY);
	}
	if (gRectList && gNumRects > 0)
	{
		/*
		br = CreateSolidBrush(RGB(255,0,255));
		for (n=0; n<gNumRects; n++)
		{
			rc.left = gRectList[n].left;
			rc.top = gRectList[n].top;
			rc.right = gRectList[n].right+1;
			rc.bottom = gRectList[n].bottom+1;
			FrameRect(gOffscreen, &rc, br);
		}
		DeleteObject(br);
		*/
		if (gFont && gPages)
		{
			FlushPage();
			if (gCurrentPage != -1)
			{
				textbuf = gPages[gCurrentPage];
				textlen = strlen(textbuf);
				for (n=0; n<gNumRects; n++)
				{
					count = FonStr(gOffscreen, gFont, gRectList[n].left, gRectList[n].top,
							gRectList[n].right, gRectList[n].bottom, textbuf, NULL);
					textlen -= count;
					if (textlen <= 0)
						break;
					textbuf += count;
				}
			}
		}
	}
	else
	{
		if (gFont && gPages)
		{
			FlushPage();
			if (gCurrentPage != -1)
				FonStr(gOffscreen, gFont, 0, 0, gWidth, gHeight, gPages[gCurrentPage], NULL);
		}
	}

	InvalidateRect(gMainWin, NULL, FALSE);
}

static void ResizeImage(unsigned long width, unsigned long height)
{
	HDC hdc, offscreenDC = NULL;
	HBITMAP bitmap;
	RECT rc;

	hdc = GetDC(gMainWin);
	bitmap = CreateCompatibleBitmap(hdc, width, height);
	if (bitmap) {
		offscreenDC = CreateCompatibleDC(hdc);
		if (offscreenDC)
			DeleteObject(SelectObject(offscreenDC, bitmap));
		else
			ErrorDialog(IDS_ERROR_GRAPHICS, GetLastError(), __FILE__, __LINE__);
	}
	else
		ErrorDialog(IDS_ERROR_GRAPHICS, GetLastError(), __FILE__, __LINE__);

	ReleaseDC(gMainWin, hdc);

	if (!offscreenDC)
		return;

	if (gOffscreen)
		DeleteDC(gOffscreen);
	gOffscreen = offscreenDC;
	gWidth = width;
	gHeight = height;
	rc.left = 0; rc.top = 0;
	rc.right = width;
	rc.bottom = height;
	AdjustWindowRectEx(&rc, WS_CAPTION|WS_SYSMENU, TRUE, WS_EX_APPWINDOW);
	SetWindowPos(gMainWin, NULL, 0, 0, rc.right-rc.left, rc.bottom-rc.top, 
			SWP_NOACTIVATE | SWP_NOMOVE | SWP_NOZORDER);
	UpdateImage();
}

static HDC MakeOffscreenBitmap(HWND hwnd, HBITMAP src_bitmap)
{
	HDC hdc, offscreenDC = NULL;
	HBITMAP bitmap;
	char *bits;
	BITMAPINFO *info;
	BITMAPV4HEADER head;
	int numcolors, rowsize;

	hdc = GetDC(hwnd);

	head.bV4Size = sizeof(BITMAPV4HEADER);
	head.bV4BitCount = 0;
	GetDIBits(hdc, src_bitmap, 0, 0, NULL, (LPBITMAPINFO)&head, DIB_RGB_COLORS);
	numcolors = (head.bV4BitCount > 8) ? 0 : 1 << head.bV4BitCount;
	if (numcolors > 0) {
		info = (BITMAPINFO*)LocalAlloc(LPTR,sizeof(BITMAPINFOHEADER)+(sizeof(RGBQUAD)*numcolors));
		if (!info)
		{
			ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
			PostQuitMessage(1);
			return NULL;
		}
		CopyMemory(info, &head, sizeof(BITMAPINFOHEADER));
	} else {
		info = (BITMAPINFO*)LocalAlloc(LPTR,sizeof(BITMAPINFOHEADER) + ((head.bV4V4Compression == BI_BITFIELDS)?sizeof(DWORD)*3:0));
		if (!info)
		{
			ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
			PostQuitMessage(1);
			return NULL;
		}
		CopyMemory(info, &head, sizeof(BITMAPINFOHEADER));
		info->bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
	}
	rowsize = (((head.bV4Width * head.bV4BitCount)+31)>>3) & ~3;
	bits = LocalAlloc(LMEM_FIXED, rowsize * head.bV4Height);
	if (!bits)
	{
		ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
		LocalFree(info);
		PostQuitMessage(1);
		return NULL;
	}
	GetDIBits(hdc, src_bitmap, 0, head.bV4Height, bits, info, DIB_RGB_COLORS);

	bitmap = CreateCompatibleBitmap(hdc, head.bV4Width, head.bV4Height);
	if (bitmap) {
		offscreenDC = CreateCompatibleDC(hdc);
		if (offscreenDC)
		{
			DeleteObject(SelectObject(offscreenDC, bitmap));
			StretchDIBits(offscreenDC, 0, 0, head.bV4Width, head.bV4Height, 
				0, 0, head.bV4Width, head.bV4Height, bits, info, DIB_RGB_COLORS, SRCCOPY);
		}
		else
			ErrorDialog(IDS_ERROR_GRAPHICS, GetLastError(), __FILE__, __LINE__);
	}
	else
		ErrorDialog(IDS_ERROR_GRAPHICS, GetLastError(), __FILE__, __LINE__);
	LocalFree(bits);
	LocalFree(info);
	ReleaseDC(hwnd, hdc);
	return offscreenDC;
}

static int LoadBookArt(LPCTSTR bookpath)
{
	TCHAR bookfile[1024];
	COLORREF colors[256];
	HBITMAP bookart;
	fon_image *fon;
	unsigned long width, height;
	pinkrect *rects;
	int num_rects;

	wnsprintf(bookfile, sizeof(bookfile), TEXT("%s%s"), bookpath, TEXT("BOOK.PCX"));
	bookart = LoadImageFile(bookfile, &width, &height, colors);
	if (!bookart)
		return 0;

	wnsprintf(bookfile, sizeof(bookfile), TEXT("%s%s"), bookpath, TEXT("TEXTFONT.FON"));
	fon = LoadFon(bookfile, colors);
	if (!fon)
	{
		DeleteObject(bookart);
		return 0;
	}

	wnsprintf(bookfile, sizeof(bookfile), TEXT("%s%s"), bookpath, TEXT("TEXTR.BIN"));
	rects = LoadRects(bookfile, &num_rects);
	if (!rects)
	{
		/* eh... I guess I can work without rects
		DeleteFon(fon);
		DeleteObject(bookart);
		return;
		*/
		if (gRectList)
			LocalFree(gRectList);
		gRectList = NULL;
		gNumRects = 0;
	}
	else
	{
		if (gRectList)
			LocalFree(gRectList);
		gRectList = rects;
		gNumRects = num_rects;
	}

	if (gFont)
		DeleteFon(gFont);
	gFont = fon;
	
	if (gBackground)
		DeleteDC(gBackground);
	gBackground = MakeOffscreenBitmap(gMainWin, bookart);
	ResizeImage(width, height);
	return 1;
}

static int OpenBookArt(HWND hwnd)
{
	OPENFILENAME ofn;
	TCHAR bookpath[1024];
	DWORD err;

	ZeroMemory(&ofn, sizeof(OPENFILENAME));
	ofn.lStructSize = sizeof(OPENFILENAME);
	ofn.hwndOwner = hwnd;
	ofn.lpstrTitle = gszOpenArtTitle;
	lstrcpy(bookpath, TEXT("BOOK.PCX"));
	ofn.lpstrFile = bookpath;
	ofn.nMaxFile = 1024;
	ofn.Flags = OFN_EXPLORER | OFN_FILEMUSTEXIST | OFN_HIDEREADONLY;
	ofn.nFilterIndex = 1;
	ofn.lpstrFilter = gszArtFilter;
	if (!GetOpenFileName(&ofn))
	{
		err = CommDlgExtendedError();
		if (err != NO_ERROR)
			ErrorDialog(IDS_ERROR_LOADFILE, err, __FILE__, __LINE__);
		return 0;
	}

	bookpath[ofn.nFileOffset] = TEXT('\0');
	return LoadBookArt(bookpath);
}

static void FlushPage(void)
{
	LPWSTR edittext;
	char *buftext;
	int editlen, buflen;
#ifndef UNICODE
	LPWSTR wtext;
	int wlen;
#endif

	if (gTextWin && gCurrentPage >= 0)
	{
		editlen = SendMessage(gTextWin, WM_GETTEXTLENGTH, 0, 0);
		if (editlen == 0)
		{
			if (!gPages[gCurrentPage])
			{
				gPages[gCurrentPage] = LocalAlloc(LPTR, 8);
				if (!gPages[gCurrentPage])
				{
					ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
					PostQuitMessage(1);
					return;
				}
			}
			gPages[gCurrentPage][0] = '\0';
			return;
		}
		if (gPages[gCurrentPage])
		{
			LocalFree(gPages[gCurrentPage]);
			gPages[gCurrentPage] = NULL;
		}
		edittext = (LPWSTR)LocalAlloc(LMEM_FIXED, sizeof(TCHAR)*(editlen+1));
		if (!edittext)
		{
			ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
			PostQuitMessage(1);
			return;
		}
		SendMessage(gTextWin, WM_GETTEXT, editlen+1, (LPARAM)edittext);
#ifndef UNICODE
		wlen = MultiByteToWideChar(CP_ACP, 0, (LPCSTR)edittext, editlen, NULL, 0);
		wtext = (LPWSTR)LocalAlloc(LMEM_FIXED, sizeof(WCHAR)*(wlen+1));
		if (!wtext)
		{
			ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
			LocalFree(edittext);
			PostQuitMessage(1);
			return;
		}
		MultiByteToWideChar(CP_ACP, 0, (LPCSTR)edittext, editlen, wtext, wlen+1);
		wtext[wlen] = L'\0';
		LocalFree(edittext);
		edittext = wtext;
		editlen = wlen;
#endif
		buflen = WideCharToMultiByte(850, 0, edittext, editlen, NULL, 0, NULL, NULL);
		buftext = (char*)LocalAlloc(LMEM_FIXED, buflen+1);
		if (!buftext)
		{
			ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
			LocalFree(edittext);
			PostQuitMessage(1);
			return;
		}
		WideCharToMultiByte(850, 0, edittext, editlen, buftext, buflen+1, NULL, NULL);
		buftext[buflen] = '\0';
		LocalFree(edittext);
		gPages[gCurrentPage] = buftext;
	}
}

static void SetPage(int page)
{
	const char *buftext;
	LPWSTR edittext;
	int editlen;
#ifndef UNICODE
	LPSTR ansitext;
	int ansilen;
#endif

	if (page < 0 || page >= gNumPages)
		return;
	if (gCurrentPage >= 0)
		FlushPage();

	if (gTextWin)
	{
		buftext = gPages[page];
		if (buftext == NULL || *buftext == '\0')
		{
			SendMessage(gTextWin, WM_SETTEXT, 0, (LPARAM)TEXT(""));
		}
		else
		{
			editlen = MultiByteToWideChar(850, 0, buftext, -1, NULL, 0);
			edittext = (LPWSTR)LocalAlloc(LMEM_FIXED, sizeof(WCHAR)*(editlen+1));
			if (!edittext)
			{
				ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
				PostQuitMessage(1);
				return;
			}
			MultiByteToWideChar(850, 0, buftext, -1, edittext, editlen+1);
			edittext[editlen] = L'\0';
#ifndef UNICODE
			ansilen = WideCharToMultiByte(CP_ACP, 0, edittext, editlen, NULL, 0, NULL, NULL);
			ansitext = (LPSTR)LocalAlloc(LMEM_FIXED, ansilen+1);
			if (!ansitext)
			{
				ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
				LocalFree(edittext);
				PostQuitMessage(1);
				return;
			}
			WideCharToMultiByte(CP_ACP, 0, edittext, editlen, ansitext, ansilen+1, NULL, NULL);
			ansitext[ansilen] = '\0';
			LocalFree(edittext);
			edittext = (LPWSTR)ansitext;
#endif
			SendMessage(gTextWin, WM_SETTEXT, 0, (LPARAM)edittext);
			LocalFree(edittext);
		}
	}
	gCurrentPage = page;
	UpdateTitle();
	UpdateImage();
}

static void InitPages(char **pages, int num_pages, LPCTSTR name)
{
	POINT pos;
	int n;

	if (!gTextWin)
	{
		pos.x = gWidth - 300;
		pos.y = gHeight - 200;
		ClientToScreen(gMainWin, &pos);
		gTextWin = CreateWindowEx(WS_EX_PALETTEWINDOW, TEXT("EDIT"), NULL,
			WS_OVERLAPPED | WS_BORDER | WS_CAPTION | WS_THICKFRAME 
			| WS_VISIBLE | WS_VSCROLL
			| ES_LEFT | ES_MULTILINE | ES_WANTRETURN | ES_AUTOVSCROLL | ES_NOHIDESEL,
			pos.x, pos.y, 300, 200, 
			gMainWin, NULL, gInstance, NULL);
		if (!gTextWin)
		{
			ErrorDialog(IDS_ERROR_WINDOW, GetLastError(), __FILE__, __LINE__);
			return;
		}
		SendMessage(gTextWin, WM_SETFONT, (WPARAM)GetStockObject(ANSI_VAR_FONT), 0);
	}

	lstrcpyn(gBookName, (name)?name:gszUntitled, 260);

	if (gPages)
	{
		for (n=0; n<gNumPages; n++)
			LocalFree(gPages[n]);
		LocalFree(gPages);
	}
	if (pages)
	{
		gPages = pages;
		gNumPages = num_pages;
	}
	else
	{
		gPages = LocalAlloc(LPTR, sizeof(char*));
		if (!gPages)
		{
			ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
			PostQuitMessage(1);
			return;
		}
		gPages[0] = LocalAlloc(LPTR, 8);
		if (!gPages[0])
		{
			ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
			PostQuitMessage(1);
			return;
		}
		gNumPages = 1;
	}
	gCurrentPage = -1;
	SetPage(0);
}

static int IsPageEmpty()
{
	FlushPage();
	return !(gPages[gCurrentPage] != NULL && *gPages[gCurrentPage] != '\0');
}

static void AddNewPage(void)
{
	char **pages;
	int num;

	if (!gPages)
	{
		InitPages(NULL, 0, NULL);
		return;
	}

	num = gNumPages + 1;
	pages = (char**)LocalReAlloc(gPages, sizeof(char*)*num, LMEM_MOVEABLE);
	if (!pages)
	{
		ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
		PostQuitMessage(1);
		return;
	}
	pages[num-1] = LocalAlloc(LPTR, 8);
	if (!pages[num-1])
	{
		ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
		PostQuitMessage(1);
		return;
	}
	gPages = pages;
	gNumPages = num;
	SetPage(num-1);
}

static void DeletePage(void)
{
	int num = gCurrentPage;
	if (gPages && num >= 0)
	{
		gCurrentPage = -1;
		gNumPages -= 1;
		LocalFree(gPages[num]);
		if (gNumPages == 0)
		{
			gNumPages = 1;
			gPages[0] = LocalAlloc(LPTR, 8);
			if (!gPages[0])
			{
				ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
				PostQuitMessage(1);
				return;
			}
		}
		else
		{
			if (gNumPages > num)
				MoveMemory(gPages+num, gPages+num+1, sizeof(char*)*(gNumPages-num));
			gPages = (char**)LocalReAlloc(gPages, sizeof(char*)*gNumPages, LMEM_MOVEABLE);
			if (!gPages)
			{
				ErrorDialog(IDS_ERROR_MEMORY, GetLastError(), __FILE__, __LINE__);
				PostQuitMessage(1);
				return;
			}
		}
		SetPage((num >= gNumPages)?(gNumPages-1):num);
	}
}

BOOL CALLBACK GetPageProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	int ret = -1;
	switch (msg)
	{
	case WM_INITDIALOG:
		SetDlgItemInt(hwnd, IDT_EDITTEXT, lParam+1, TRUE);
		return TRUE;
	case WM_COMMAND:
		switch (LOWORD(wParam))
		{
		case IDOK:
			ret = GetDlgItemInt(hwnd, IDT_EDITTEXT, NULL, TRUE) - 1;
		case IDCANCEL:
			EndDialog(hwnd,ret);
		}
	}
	return FALSE;
}

static void GetPageDialog(HWND hwnd)
{
	int num;

	if (gNumPages > 0)
	{
		num = DialogBoxParam(gInstance, MAKEINTRESOURCE(ID_GETPAGE), hwnd, GetPageProc, gCurrentPage);
		SetPage(num);
	}
}

static void LoadBookText(HWND hwnd)
{
	OPENFILENAME ofn;
	TCHAR bookpath[1024];
	char **booktext;
	int num_pages;
	DWORD err;

	ZeroMemory(&ofn, sizeof(OPENFILENAME));
	ofn.lStructSize = sizeof(OPENFILENAME);
	ofn.hwndOwner = hwnd;
	ofn.lpstrTitle = gszOpenTextTitle;
	bookpath[0] = TEXT('\0');
	ofn.lpstrFile = bookpath;
	ofn.nMaxFile = 1024;
	ofn.Flags = OFN_EXPLORER | OFN_FILEMUSTEXIST | OFN_HIDEREADONLY;
	ofn.nFilterIndex = 1;
	ofn.lpstrFilter = gszTextFilter;
	if (!GetOpenFileName(&ofn))
	{
		err = CommDlgExtendedError();
		if (err != NO_ERROR)
			ErrorDialog(IDS_ERROR_LOADFILE, err, __FILE__, __LINE__);
		return;
	}

	booktext = LoadStrFile(bookpath, &num_pages);
	if (!booktext)
		return;
	
	bookpath[ofn.nFileExtension-1] = TEXT('\0');
	InitPages(booktext, num_pages, bookpath+ofn.nFileOffset);
}

static void SaveBookText(HWND hwnd)
{
	TCHAR bookpath[1024];
	OPENFILENAME ofn;
	DWORD err;

	FlushPage();
	if (gPages)
	{
		ZeroMemory(&ofn, sizeof(OPENFILENAME));
		ofn.lStructSize = sizeof(OPENFILENAME);
		ofn.hwndOwner = hwnd;
		ofn.lpstrTitle = gszSaveTextTitle;
		if (gBookName[0] == TEXT('<'))
			bookpath[0] = TEXT('\0');
		else
			lstrcpy(bookpath, gBookName);
		ofn.lpstrFile = bookpath;
		ofn.nMaxFile = 1024;
		ofn.Flags = OFN_EXPLORER | OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT;
		ofn.nFilterIndex = 1;
		ofn.lpstrFilter = gszTextFilter;
		ofn.lpstrDefExt = TEXT("STR");
		if (!GetSaveFileName(&ofn))
		{
			err = CommDlgExtendedError();
			if (err != NO_ERROR)
				ErrorDialog(IDS_ERROR_LOADFILE, err, __FILE__, __LINE__);
			return;
		}
		if ((err = SaveStrFile(bookpath, gPages, gNumPages)) == 0)
		{
			bookpath[ofn.nFileExtension-1] = TEXT('\0');
			lstrcpyn(gBookName, bookpath+ofn.nFileOffset, 260);
			UpdateTitle();
		}
	}
	return;
}

static void ShowAboutBox(HWND hwnd)
{
	TCHAR str[1024];
	LoadString(gInstance, IDS_INFOTEXT, str, sizeof(str));
	MessageBox(hwnd, str, TEXT(""), MB_APPLMODAL | MB_ICONINFORMATION | MB_OK);
}

void ErrorDialog(DWORD id, DWORD code, const char* file, unsigned int line)
{
	TCHAR outbuf[1024];
	TCHAR dlgmsg[512];
	TCHAR dlgtitle[256];
	TCHAR errmsg[256];
	errmsg[0] = TEXT('\0');
	LoadString(gInstance, id, dlgmsg, 512);
	LoadString(gInstance, IDS_ERRORTITLE, dlgtitle, 256);
	FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS, NULL,
				code, GetUserDefaultLangID(), errmsg, 256, NULL);
	if (errmsg[0] != TEXT('\0'))
		wnsprintf(outbuf, sizeof(outbuf), TEXT("%s\r\n(%s)\r\n[%hs,%d]"), 
				dlgmsg, errmsg, file, line);
	else
		wnsprintf(outbuf, sizeof(outbuf), TEXT("%s\r\n(%d)\r\n[%hs,%d]"), 
				dlgmsg, code, file, line);
	MessageBox(gMainWin, outbuf, dlgtitle, MB_APPLMODAL | MB_ICONERROR | MB_OK);
}


LONG WINAPI MainWndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	static int in_dialog = 0;

	switch (msg)
	{
	case WM_CREATE:
		return 0;
	case WM_PAINT:
		DisplayBook(hwnd);
		return 0;
	case WM_ERASEBKGND:
		break;
	case WM_CLOSE:
		DestroyWindow(hwnd);
		return 0;
	case WM_DESTROY:
		if (gTextWin)
		{
			DestroyWindow(gTextWin);
		}
		PostQuitMessage(0);
		return 0;
	case WM_ACTIVATEAPP:
		if (gTextWin && !in_dialog)
			ShowWindow(gTextWin, (wParam) ? SW_SHOW : SW_HIDE);
		break;
	case WM_SIZE:
		if (wParam == SIZE_MINIMIZED)
		{
			if (gTextWin && !in_dialog)
				ShowWindow(gTextWin, SW_HIDE);
		}
		else if (wParam == SIZE_RESTORED)
		{
			if (gTextWin && !in_dialog)
				ShowWindow(gTextWin, SW_SHOW);
		}
		break;
	case WM_COMMAND:
		if (HIWORD(wParam) == EN_CHANGE)
		{
			UpdateImage();
			return 0;
		}
		else
			switch (LOWORD(wParam))
			{
			case IDM_EXIT:
				DestroyWindow(hwnd);
				return 0;
			case IDM_ABOUT:
				if (gTextWin)
					ShowWindow(gTextWin, SW_HIDE);
				in_dialog = 1;
				ShowAboutBox(hwnd);
				in_dialog = 0;
				if (gTextWin)
					ShowWindow(gTextWin, SW_SHOW);
				return 0;
			case IDM_OPENART:
				if (gTextWin)
					ShowWindow(gTextWin, SW_HIDE);
				in_dialog = 1;
				if (OpenBookArt(hwnd))
				{
					if (!gPages)
						InitPages(NULL, 0, NULL);
				}
				in_dialog = 0;
				if (gTextWin)
					ShowWindow(gTextWin, SW_SHOW);
				return 0;
			case IDM_OPENTEXT:
				if (gTextWin)
					ShowWindow(gTextWin, SW_HIDE);
				in_dialog = 1;
				if (gBackground || OpenBookArt(hwnd))
					LoadBookText(hwnd);
				in_dialog = 0;
				if (gTextWin)
					ShowWindow(gTextWin, SW_SHOW);
				return 0;
			case IDM_SAVETEXT:
				if (gTextWin)
					ShowWindow(gTextWin, SW_HIDE);
				in_dialog = 1;
				SaveBookText(hwnd);
				in_dialog = 0;
				if (gTextWin)
					ShowWindow(gTextWin, SW_SHOW);
				return 0;
			case IDM_NEWTEXT:
				if (gTextWin)
					ShowWindow(gTextWin, SW_HIDE);
				in_dialog = 1;
				if (gBackground || OpenBookArt(hwnd))
					InitPages(NULL, 0, NULL);
				in_dialog = 0;
				if (gTextWin)
					ShowWindow(gTextWin, SW_SHOW);
				return 0;
			case IDM_GOTOPAGE:
				if (gTextWin)
					ShowWindow(gTextWin, SW_HIDE);
				in_dialog = 1;
				GetPageDialog(hwnd);
				in_dialog = 0;
				if (gTextWin)
					ShowWindow(gTextWin, SW_SHOW);
				return 0;
			case IDM_NEXTPAGE:
				if (gNumPages <= gCurrentPage+1)
					AddNewPage();
				else
					SetPage(gCurrentPage+1);
				return 0;
			case IDM_PREVPAGE:
				if (gNumPages <= gCurrentPage+1 && IsPageEmpty())
					DeletePage();
				else
					SetPage(gCurrentPage-1);
				return 0;
			case IDM_NEWPAGE:
				AddNewPage();
				return 0;
			case IDM_REMOVEPAGE:
				DeletePage();
				return 0;
			case IDM_CUT:
				if (gTextWin)
					SendMessage(gTextWin, WM_CUT, 0, 0);
				return 0;
			case IDM_COPY:
				if (gTextWin)
					SendMessage(gTextWin, WM_COPY, 0, 0);
				return 0;
			case IDM_PASTE:
				if (gTextWin)
					SendMessage(gTextWin, WM_PASTE, 0, 0);
				return 0;
			case IDM_UNDO:
				if (gTextWin)
				{
					if (SendMessage(gTextWin, EM_CANUNDO, 0, 0))
						SendMessage(gTextWin, WM_UNDO, 0, 0);
				}
				return 0;
			}
		break;
	}
	return DefWindowProc(hwnd, msg, wParam, lParam);
}

static void AppDefaults(void)
{
	TCHAR apppath[1024];
	LPTSTR filename;

	if (!GetCurrentDirectory(sizeof(apppath), apppath))
		return;
	filename = apppath + lstrlen(apppath);
	if (filename[-1] != TEXT('\\'))
		*filename++ = TEXT('\\');
	*filename = TEXT('\0');
	if (1011 < (filename - apppath))
		return;

	lstrcpy(filename, TEXT("BOOK.PCX"));
	if (!PathFileExists(apppath))
		return;
	lstrcpy(filename, TEXT("TEXTFONT.FON"));
	if (!PathFileExists(apppath))
		return;

	*filename = TEXT('\0');
	if (LoadBookArt(apppath))
		InitPages(NULL, 0, NULL);
}

static BOOL InitApp(HINSTANCE hInstance)
{
	WNDCLASS wc;
	TCHAR str[256];
	RECT rc;
	TCHAR *ptr;

	wc.style = 0;
	wc.lpfnWndProc = (WNDPROC)MainWndProc;
	wc.cbClsExtra = 0;
	wc.cbWndExtra = 0;
	wc.hInstance = hInstance;
	wc.hIcon = LoadIcon(NULL, MAKEINTRESOURCE(1));
	wc.hCursor = LoadCursor(NULL, IDC_ARROW);
	wc.hbrBackground = (HBRUSH)GetStockObject(BLACK_BRUSH);
	wc.lpszMenuName = NULL;
	wc.lpszClassName = gszAppClass;
	if (!RegisterClass(&wc))
	{
		ErrorDialog(IDS_ERROR_WINDOW, GetLastError(), __FILE__, __LINE__);
		return FALSE;
	}

	LoadString(hInstance, ID_APP, gszAppName, sizeof(gszAppName));
	LoadString(hInstance, IDS_OPENART, gszOpenArtTitle, sizeof(gszOpenArtTitle));
	LoadString(hInstance, IDS_OPENTEXT, gszOpenTextTitle, sizeof(gszOpenTextTitle));
	LoadString(hInstance, IDS_SAVETEXT, gszSaveTextTitle, sizeof(gszSaveTextTitle));
	LoadString(hInstance, IDS_UNTITLED, gszUntitled, sizeof(gszUntitled));
	LoadString(hInstance, IDS_TITLEFORMAT, gszTitleFormat, sizeof(gszTitleFormat));
	LoadString(hInstance, IDS_TITLEPAGEFORMAT, gszTitlePageFormat, sizeof(gszTitlePageFormat));
	LoadString(hInstance, IDS_ARTFILTER, str, sizeof(str));
	wnsprintf(gszArtFilter, sizeof(gszArtFilter), TEXT("%s\tBOOK.PCX\t"), str);
	for (ptr=gszArtFilter; *ptr; ++ptr)
		if (*ptr == TEXT('\t')) *ptr = TEXT('\0');
	LoadString(hInstance, IDS_STRFILTER, str, sizeof(str));
	wnsprintf(gszTextFilter, sizeof(gszTextFilter), TEXT("%s\t*.STR\t"), str);
	for (ptr=gszTextFilter; *ptr; ++ptr)
		if (*ptr == TEXT('\t')) *ptr = TEXT('\0');

	gMenu = LoadMenu(hInstance, MAKEINTRESOURCE(ID_APP));
	gKeys = LoadAccelerators(hInstance, MAKEINTRESOURCE(ID_APP));

	gWidth = 640;
	gHeight = 480;
	rc.left = 0; rc.top = 0;
	rc.right = gWidth;
	rc.bottom = gHeight;
	AdjustWindowRectEx(&rc, WS_CAPTION|WS_SYSMENU, TRUE, WS_EX_APPWINDOW);
	gMainWin = CreateWindowEx(WS_EX_APPWINDOW, gszAppClass, gszAppName,
			WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX, 
			CW_USEDEFAULT, CW_USEDEFAULT, rc.right - rc.left, rc.bottom - rc.top,
			NULL, gMenu, hInstance, NULL);
	if (!gMainWin)
	{
		ErrorDialog(IDS_ERROR_WINDOW, GetLastError(), __FILE__, __LINE__);
		return FALSE;
	}

	gBookName[0] = TEXT('\0');
	UpdateTitle();

	AppDefaults();

	return TRUE;
}

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
{
	int ret;
	MSG msg;
	int n;

	gInstance = hInstance;

	if (!InitApp(hInstance))
		return 1;

	ShowWindow(gMainWin, SW_SHOWDEFAULT);
	UpdateWindow(gMainWin);

	while (1)
	{
		ret = GetMessage(&msg, NULL, 0, 0);
		if (ret == 0 || ret < 0)
			break;
		if (!TranslateAccelerator(gMainWin, gKeys, &msg))
		{
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}
	}

	if (gPages)
	{
		for (n=0; n<gNumPages; n++)
			LocalFree(gPages[n]);
		LocalFree(gPages);
	}
	if (gFont)
		DeleteFon(gFont);
	if (gRectList)
		LocalFree(gRectList);
	if (gBackground)
		DeleteDC(gBackground);
	if (gOffscreen)
		DeleteDC(gOffscreen);

	return ret;
}

