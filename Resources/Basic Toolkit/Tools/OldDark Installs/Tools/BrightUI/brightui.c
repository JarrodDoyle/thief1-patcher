/******************************************************************************
 *    brightui.c
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

#define WIN32_LEAN_AND_MEAN
#define WINVER		0x0400
#define _WIN32_WINNT WINVER
#define _WIN32_IE	0x0400

#include <windows.h>
#include <commctrl.h>
#include <commdlg.h>
/*
#undef _WIN32_WINNT
#define _WIN32_WINNT 0x0501
#include <uxtheme.h>
#undef _WIN32_WINNT
#define _WIN32_WINNT WINVER
*/
#include <dlgs.h>
#include <shlwapi.h>
#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include "resources.h"
#include "brightui.h"

HRESULT (WINAPI *EnableThemeDialogTexture)(HWND,DWORD);
HRESULT WINAPI StubEnableThemeDialogTexture(HWND w, DWORD f);
void LoadThemeLibrary(void);

LRESULT CALLBACK WindowFunc(HWND, UINT, WPARAM, LPARAM);
BOOL CALLBACK DialogFunc(HWND, UINT, WPARAM, LPARAM);
BOOL CALLBACK DialogPageFunc(HWND, UINT, WPARAM, LPARAM);
UINT APIENTRY SelectDirFunc(HWND, UINT, WPARAM, LPARAM);
BOOL CALLBACK CopyrightDialogFunc(HWND, UINT, WPARAM, LPARAM);

void OutputText(LPCTSTR txt);
BOOL ConfirmDialog(HWND parent, DWORD id, ...);

void ValidateInteger(HWND hctl, int min, int max);
void ValidateFloat(HWND hctl, float min, float max);

static BOOL CreateDialogPages(HWND hdlg);
static void InitDialogPages(HWND hdlg);
static HWND AddDialogPage(HWND hdlg, int x, int y, LPCTSTR rsrc);
static void ShowDialogPage(HWND htabs, int n);
static void SetDialogPages(HWND hdlg, unsigned int mask);

static void EnableBrightControls(HWND hdlg);
static void EnableMaskControls(HWND hdlg);
static void EnableTransControls(HWND hdlg);

static int CollectFileOptions(LPTSTR cmds, int len);
static int CollectColorOptions(LPTSTR cmds, int len);
static int CollectPaletteOptions(LPTSTR cmds, int len);
static int CollectMaskOptions(LPTSTR cmds, int len);
static int CollectTransOptions(LPTSTR cmds, int len);

static void CheckCanExecute(BOOL checkpal);
static BOOL CanExecute(BOOL checkpal);

static BOOL DoBright(HWND hdlg);
static BOOL DoMask(HWND hdlg);
static BOOL DoTrans(HWND hdlg);

static BOOL PickColor(HWND parent, COLORREF* color);
static BOOL PickInputFile(HWND parent, LPTSTR name, DWORD len, int type);
static BOOL PickOutputFile(HWND parent, LPTSTR name, DWORD len, int type);
static BOOL PickDirectory(HWND parent, LPTSTR name, DWORD len, int type);

static void AddFileToList(HWND hdlg);
static void RemoveFileFromList(HWND hdlg);
static void SelectOutputDir(HWND hdlg);
static void SelectWritePalette(HWND hdlg);
static void SelectImagePalette(HWND hdlg);

#define DWPDlgItem(p,h,i,v) \
	DeferWindowPos((p),GetDlgItem((h),(i)),NULL,0,0,0,0,SWP_NOMOVE|SWP_NOSIZE|SWP_NOZORDER|(v))


const TCHAR* gTabNames[] = { 
	TEXT("Files"),
	TEXT("Color Sampling"),
	TEXT("Palette"),
	TEXT("Mask"),
	TEXT("Snap-to-Black")
};

const TCHAR* gPaletteOptions[] = {
	TEXT("Automatic Combining"),
	TEXT("With Max. Error"),
	TEXT("From Existing File")
};

const TCHAR* gMaskOptions[] = {
	TEXT("No Masking"),
	TEXT("Default Masking"),
	TEXT("Mask Pink-ish Pixels"),
	TEXT("Mask Pink Pixels"),
	TEXT("Mask Gray Pixels"),
	TEXT("Mask Specific Color")
};

const TCHAR* gFilters[] = {
	TEXT("Image Files\0*.PCX;*.BMP;*.TGA\0All Files\0*.*\0\0"),
	TEXT("PCX Files\0*.PCX\0All Files\0*.*\0\0"),
	TEXT("BMP Files\0*.BMP\0All Files\0*.*\0\0"),
	TEXT("TGA Files\0*.TGA\0All Files\0*.*\0\0")
};


const TCHAR szWinName[] = TEXT("BrightUI");
HINSTANCE gInstance;
HWND gMain, gDialog, gText;
HWND gDialogPages[NUMPAGES];
HWND gCurrentPage;
int gMode;


HRESULT WINAPI StubEnableThemeDialogTexture(HWND w, DWORD f)
{
	return 0;
}

void LoadThemeLibrary(void)
{
	HMODULE mod;
	FARPROC proc;
	mod = LoadLibrary(TEXT("UXTHEME.DLL"));
	if (mod)
	{
		proc = GetProcAddress(mod, "EnableThemeDialogTexture");
		if (proc)
			EnableThemeDialogTexture = proc;
		else
			EnableThemeDialogTexture = StubEnableThemeDialogTexture;
	}
	else
		EnableThemeDialogTexture = StubEnableThemeDialogTexture;
}

HWND AddDialogPage(HWND hdlg, int x, int y, LPCTSTR rsrc)
{
	HWND page;
	page = CreateDialog(gInstance, rsrc, hdlg, DialogPageFunc);
	if (page)
	{
		EnableThemeDialogTexture(page, 6);
		SetWindowPos(page, HWND_TOP, x, y, 0, 0, SWP_NOSIZE);
	}
	return page;
}

BOOL CreateDialogPages(HWND hdlg)
{
	RECT rc;
	POINT pt;
	TC_ITEM ti;
	HWND page;
	HWND htabs = GetDlgItem(hdlg, IDB_TABS);

	ti.mask = TCIF_TEXT | TCIF_IMAGE;
	ti.iImage = -1;
	ti.pszText = TEXT("Foo");
	TabCtrl_InsertItem(htabs, 0, &ti);
	GetWindowRect(htabs, &rc);
	pt.x = rc.right; pt.y = rc.bottom;
	ScreenToClient(hdlg, &pt);
	rc.right = pt.x; rc.bottom = pt.y;
	pt.x = rc.left; pt.y = rc.top;
	ScreenToClient(hdlg, &pt);
	rc.left = pt.x; rc.top = pt.y;
	TabCtrl_AdjustRect(htabs, FALSE, &rc);
	TabCtrl_DeleteItem(htabs, 0);
	rc.top += min(rc.left, 4);

	page = AddDialogPage(hdlg, rc.left, rc.top, MAKEINTRESOURCE(IDD_FILEOPTIONS));
	if (!page)
		return FALSE;
	gDialogPages[FILEOPTIONS] = page;
	page = AddDialogPage(hdlg, rc.left, rc.top, MAKEINTRESOURCE(IDD_COLOROPTIONS));
	if (!page)
		return FALSE;
	gDialogPages[COLOROPTIONS] = page;
	page = AddDialogPage(hdlg, rc.left, rc.top, MAKEINTRESOURCE(IDD_PALETTEOPTIONS));
	if (!page)
		return FALSE;
	gDialogPages[PALETTEOPTIONS] = page;
	page = AddDialogPage(hdlg, rc.left, rc.top, MAKEINTRESOURCE(IDD_MASKOPTIONS));
	if (!page)
		return FALSE;
	gDialogPages[MASKOPTIONS] = page;
	page = AddDialogPage(hdlg, rc.left, rc.top, MAKEINTRESOURCE(IDD_TRANSOPTIONS));
	if (!page)
		return FALSE;
	gDialogPages[TRANSOPTIONS] = page;

	gCurrentPage = NULL;
	return TRUE;
}

void InitDialogPages(HWND hdlg)
{
	int n;
	HWND ctl;

	SendDlgItemMessage(gDialogPages[FILEOPTIONS], IDT_DESTDIR, EM_LIMITTEXT, 259, 0);
	SendDlgItemMessage(gDialogPages[FILEOPTIONS], IDT_PREFIX, EM_LIMITTEXT, 259, 0);
	SendDlgItemMessage(gDialogPages[FILEOPTIONS], IDT_WRITEPAL, EM_LIMITTEXT, 259, 0);
	SendDlgItemMessage(gDialogPages[FILEOPTIONS], IDT_BUMP, EM_LIMITTEXT, 7, 0);
	SendDlgItemMessage(gDialogPages[COLOROPTIONS], IDT_DEPTHRED, EM_LIMITTEXT, 1, 0);
	SendDlgItemMessage(gDialogPages[COLOROPTIONS], IDT_DEPTHGREEN, EM_LIMITTEXT, 1, 0);
	SendDlgItemMessage(gDialogPages[COLOROPTIONS], IDT_DEPTHBLUE, EM_LIMITTEXT, 1, 0);
	SendDlgItemMessage(gDialogPages[COLOROPTIONS], IDT_BINS, EM_LIMITTEXT, 7, 0);
	SendDlgItemMessage(gDialogPages[PALETTEOPTIONS], IDT_PALFILE, EM_LIMITTEXT, 259, 0);
	SendDlgItemMessage(gDialogPages[PALETTEOPTIONS], IDT_NUMPALS, EM_LIMITTEXT, 7, 0);
	SendDlgItemMessage(gDialogPages[PALETTEOPTIONS], IDT_ERROR, EM_LIMITTEXT, 7, 0);
	SendDlgItemMessage(gDialogPages[PALETTEOPTIONS], IDT_COLORS, EM_LIMITTEXT, 7, 0);
	SendDlgItemMessage(gDialogPages[PALETTEOPTIONS], IDT_PREDEPTHRED, EM_LIMITTEXT, 1, 0);
	SendDlgItemMessage(gDialogPages[PALETTEOPTIONS], IDT_PREDEPTHGREEN, EM_LIMITTEXT, 1, 0);
	SendDlgItemMessage(gDialogPages[PALETTEOPTIONS], IDT_PREDEPTHBLUE, EM_LIMITTEXT, 1, 0);
	SendDlgItemMessage(gDialogPages[PALETTEOPTIONS], IDT_DITHER, EM_LIMITTEXT, 7, 0);
	SendDlgItemMessage(gDialogPages[MASKOPTIONS], IDT_MASK, EM_LIMITTEXT, 7, 0);
	SendDlgItemMessage(gDialogPages[MASKOPTIONS], IDT_FATMASK, EM_LIMITTEXT, 7, 0);
	SendDlgItemMessage(gDialogPages[MASKOPTIONS], IDT_MASKRED, EM_LIMITTEXT, 3, 0);
	SendDlgItemMessage(gDialogPages[MASKOPTIONS], IDT_MASKGREEN, EM_LIMITTEXT, 3, 0);
	SendDlgItemMessage(gDialogPages[MASKOPTIONS], IDT_MASKBLUE, EM_LIMITTEXT, 3, 0);
	SendDlgItemMessage(gDialogPages[TRANSOPTIONS], IDT_TRANS, EM_LIMITTEXT, 7, 0);

	CheckRadioButton(gDialogPages[FILEOPTIONS], IDB_PCX, IDB_TGA, IDB_PCX);

	CheckRadioButton(gDialogPages[COLOROPTIONS], IDB_YCC, IDB_RGB, IDB_YCC);
	
	SetDlgItemInt(gDialogPages[COLOROPTIONS], IDT_DEPTHRED, 8, FALSE);
	SetDlgItemInt(gDialogPages[COLOROPTIONS], IDT_DEPTHGREEN, 8, FALSE);
	SetDlgItemInt(gDialogPages[COLOROPTIONS], IDT_DEPTHBLUE, 8, FALSE);
	SetDlgItemInt(gDialogPages[COLOROPTIONS], IDT_BINS, 7168, FALSE);

	SetDlgItemInt(gDialogPages[PALETTEOPTIONS], IDT_NUMPALS, 1, FALSE);
	SetDlgItemInt(gDialogPages[PALETTEOPTIONS], IDT_ERROR, 200, FALSE);
	SetDlgItemInt(gDialogPages[PALETTEOPTIONS], IDT_COLORS, 256, FALSE);
	SetDlgItemInt(gDialogPages[PALETTEOPTIONS], IDT_PREDEPTHRED, 6, FALSE);
	SetDlgItemInt(gDialogPages[PALETTEOPTIONS], IDT_PREDEPTHGREEN, 5, FALSE);
	SetDlgItemInt(gDialogPages[PALETTEOPTIONS], IDT_PREDEPTHBLUE, 5, FALSE);
	SetDlgItemInt(gDialogPages[PALETTEOPTIONS], IDT_DITHER, 100, FALSE);

	SetDlgItemInt(gDialogPages[MASKOPTIONS], IDT_MASKRED, 255, FALSE);
	SetDlgItemInt(gDialogPages[MASKOPTIONS], IDT_MASKGREEN, 0, FALSE);
	SetDlgItemInt(gDialogPages[MASKOPTIONS], IDT_MASKBLUE, 255, FALSE);

	ctl = GetDlgItem(gDialogPages[PALETTEOPTIONS], IDM_PALETTE);
	if (ctl)
	{
		for (n=0;n<NUMPALOPTS;n++)
		{
			SendMessage(ctl, CB_INSERTSTRING, n, (LPARAM)gPaletteOptions[n]);
		}
		SendMessage(ctl, CB_SETCURSEL, 0, 0);
	}

	ctl = GetDlgItem(gDialogPages[MASKOPTIONS], IDM_MASK);
	if (ctl)
	{
		for (n=0;n<NUMMASKOPTS;n++)
		{
			SendMessage(ctl, CB_INSERTSTRING, n, (LPARAM)gMaskOptions[n]);
		}
		SendMessage(ctl, CB_SETCURSEL, 0, 0);
	}

	SetDlgItemText(gDialogPages[FILEOPTIONS], IDT_BUMP, TEXT("0.1"));
	SetDlgItemText(gDialogPages[MASKOPTIONS], IDT_MASK, TEXT("0.0"));
	SetDlgItemText(gDialogPages[MASKOPTIONS], IDT_FATMASK, TEXT("0.0"));
	SetDlgItemText(gDialogPages[TRANSOPTIONS], IDT_TRANS, TEXT("0.0"));
}

void ShowDialogPage(HWND htabs, int n)
{
	TC_ITEM info;
	info.mask = TCIF_PARAM;
	TabCtrl_GetItem(htabs, n, &info);
	if ((HWND)info.lParam != gCurrentPage)
	{
		if (gCurrentPage)
			ShowWindow(gCurrentPage, SW_HIDE);
		if ((HWND)info.lParam)
			SetWindowPos((HWND)info.lParam, HWND_TOP, 0, 0, 0, 0, SWP_NOSIZE | SWP_NOMOVE | SWP_SHOWWINDOW);
		gCurrentPage = (HWND)info.lParam;
		//SetFocus(GetWindow((HWND)info.lParam, GW_CHILD));
	}
}

void SetDialogPages(HWND hdlg, unsigned int mask)
{
	int page, n;
	HWND htabs;
	TC_ITEM info;

	if (gCurrentPage)
	{
		ShowWindow(gCurrentPage, SW_HIDE);
		gCurrentPage = NULL;
	}
	htabs = GetDlgItem(hdlg, IDB_TABS);
	TabCtrl_DeleteAllItems(htabs);
	info.mask = TCIF_TEXT | TCIF_IMAGE | TCIF_PARAM;
	info.iImage = -1;
	n = 0;
	for (page=0;page<NUMPAGES;page++)
	{
		if (mask & 1)
		{
			info.pszText = (LPTSTR)gTabNames[page];
			info.lParam = (LPARAM)gDialogPages[page];
			TabCtrl_InsertItem(htabs, n, &info);
			++n;
		}
		mask >>= 1;
	}
	TabCtrl_SetCurSel(htabs, 0);
	ShowDialogPage(htabs, 0);
}

void EnableBrightControls(HWND hdlg)
{
	int n;
	SetDialogPages(hdlg, FILEPAGE | COLORPAGE | MASKPAGE | PALETTEPAGE);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_PCX), TRUE);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_BMP), TRUE);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_TGA), TRUE);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_WRITEPAL), TRUE);
	if (IsDlgButtonChecked(gDialogPages[FILEOPTIONS], IDB_WRITEPAL) == BST_CHECKED)
	{
		EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDT_WRITEPAL), TRUE);
		EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_SELECTPAL), TRUE);
	}
	else
	{
		EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDT_WRITEPAL), FALSE);
		EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_SELECTPAL), FALSE);
	}
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_BUMP), TRUE);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDT_BUMP), 
				IsDlgButtonChecked(gDialogPages[FILEOPTIONS], IDB_BUMP) == BST_CHECKED);

	EnableWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDM_MASK), TRUE);
	n = SendDlgItemMessage(gDialogPages[MASKOPTIONS], IDM_MASK, CB_GETCURSEL, 0, 0);
	if (n == MASKCOLMASK)
	{
		ShowWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDS_MASKCOLOR), SW_SHOW);
		ShowWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDT_MASKRED), SW_SHOW);
		ShowWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDT_MASKGREEN), SW_SHOW);
		ShowWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDT_MASKBLUE), SW_SHOW);
		ShowWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDB_MASKCOLOR), SW_SHOW);
	}
	else
	{
		ShowWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDS_MASKCOLOR), SW_HIDE);
		ShowWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDT_MASKRED), SW_HIDE);
		ShowWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDT_MASKGREEN), SW_HIDE);
		ShowWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDT_MASKBLUE), SW_HIDE);
		ShowWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDB_MASKCOLOR), SW_HIDE);
	}
	if (n == MASKDEFAULT || n == MASKPINKSCREEN)
	{
		EnableWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDT_MASK), TRUE);
		EnableWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDB_FATMASK), TRUE);
		EnableWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDT_FATMASK), 
					 IsDlgButtonChecked(gDialogPages[MASKOPTIONS], IDB_FATMASK) == BST_CHECKED);
	}
	else
	{
		EnableWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDT_MASK), FALSE);
		EnableWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDB_FATMASK), FALSE);
		EnableWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDT_FATMASK), FALSE);
	}
	
	EnableWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDB_BLACK), TRUE);
}

void EnableMaskControls(HWND hdlg)
{
	SetDialogPages(hdlg, FILEPAGE | MASKPAGE);
	CheckRadioButton(gDialogPages[FILEOPTIONS], IDB_PCX, IDB_TGA, IDB_BMP);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_PCX), FALSE);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_BMP), FALSE);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_TGA), FALSE);
	CheckDlgButton(gDialogPages[FILEOPTIONS], IDB_WRITEPAL, BST_UNCHECKED);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_WRITEPAL), FALSE);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDT_WRITEPAL), FALSE);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_SELECTPAL), FALSE);
	CheckDlgButton(gDialogPages[FILEOPTIONS], IDB_BUMP, BST_UNCHECKED);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_BUMP), FALSE);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDT_BUMP), FALSE);

	SendDlgItemMessage(gDialogPages[MASKOPTIONS], IDM_MASK, CB_SETCURSEL, MASKDEFAULT, 0);
	EnableWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDM_MASK), FALSE);
	EnableWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDT_MASK), TRUE);
	EnableWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDB_FATMASK), TRUE);
	EnableWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDT_FATMASK), 
				IsDlgButtonChecked(gDialogPages[MASKOPTIONS], IDB_FATMASK) == BST_CHECKED);
	EnableWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDB_BLACK), FALSE);
	ShowWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDS_MASKCOLOR), SW_HIDE);
	ShowWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDT_MASKRED), SW_HIDE);
	ShowWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDT_MASKGREEN), SW_HIDE);
	ShowWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDT_MASKBLUE), SW_HIDE);
	ShowWindow(GetDlgItem(gDialogPages[MASKOPTIONS], IDB_MASKCOLOR), SW_HIDE);
}

void EnableTransControls(HWND hdlg)
{
	SetDialogPages(hdlg, FILEPAGE | TRANSPAGE);
	CheckRadioButton(gDialogPages[FILEOPTIONS], IDB_PCX, IDB_TGA, IDB_BMP);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_PCX), FALSE);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_BMP), FALSE);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_TGA), FALSE);
	CheckDlgButton(gDialogPages[FILEOPTIONS], IDB_WRITEPAL, BST_UNCHECKED);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_WRITEPAL), FALSE);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDT_WRITEPAL), FALSE);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_SELECTPAL), FALSE);
	CheckDlgButton(gDialogPages[FILEOPTIONS], IDB_BUMP, BST_UNCHECKED);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDB_BUMP), FALSE);
	EnableWindow(GetDlgItem(gDialogPages[FILEOPTIONS], IDT_BUMP), FALSE);
}


int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd)
{
	HMENU hmenu;
	//HACCEL hkeys;
	MSG msg;
	WNDCLASS wcl;

	InitCommonControls();

	gInstance = hInstance;

	LoadThemeLibrary();

	wcl.hInstance = hInstance;
	wcl.lpszClassName = szWinName;
	wcl.lpfnWndProc = WindowFunc;
	wcl.style = 0;
	wcl.hIcon = LoadIcon(hInstance, MAKEINTRESOURCE(1));
	wcl.hCursor = LoadCursor(NULL, IDC_ARROW);
	wcl.lpszMenuName = NULL;
	wcl.cbClsExtra = 0;
	wcl.cbWndExtra = 0;
	wcl.hbrBackground = (HBRUSH)(COLOR_APPWORKSPACE+1);

	if (!RegisterClass(&wcl))
		return GetLastError();

	hmenu = LoadMenu(hInstance, MAKEINTRESOURCE(ID_BRIGHTUI));
	gMain = CreateWindowEx(WS_EX_APPWINDOW, szWinName, TEXT("BrightUI"),
		WS_OVERLAPPEDWINDOW,
		CW_USEDEFAULT, CW_USEDEFAULT, 600, 400,
		NULL, hmenu, hInstance, NULL);
	if (!gMain)
		return GetLastError();

	gDialog = CreateDialog(hInstance, MAKEINTRESOURCE(ID_BRIGHTUI), NULL, DialogFunc);
	if (!gDialog || !CreateDialogPages(gDialog))
		return GetLastError();
	InitDialogPages(gDialog);

	//hkeys = LoadAccelerators(hInstance, MAKEINTRESOURCE(ID_BRIGHTUI));

	gMode = 0;

	ShowWindow(gMain, SW_SHOWDEFAULT);
	UpdateWindow(gMain);

	while(GetMessage(&msg, NULL, 0, 0))
	{
		//if (!TranslateAccelerator(hdlg, hkeys, &msg) && !IsDialogMessage(hdlg, &msg))
		if (!IsDialogMessage(gDialog, &msg))
		{
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}
	}
	if (hmenu)
		DestroyMenu(hmenu);
	return msg.wParam;
}

BOOL CALLBACK CopyrightDialogFunc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
	HGLOBAL hGPL;
	HRSRC hRes;
	int id, len;
	LPTSTR res;
	LPTSTR buf;
	
	switch (msg) {
		case WM_INITDIALOG:
			hRes = FindResource(gInstance,TEXT("COPYRIGHT"), TEXT("TEXT"));
			if (hRes == NULL)
				return FALSE;
			hGPL = LoadResource(gInstance, hRes);
			if (hGPL == NULL)
				return FALSE;
			res = (LPTSTR)LockResource(hGPL);
			len = SizeofResource(gInstance, hRes);
			if ((buf = LocalAlloc(LPTR, len + 2)) != NULL) {
				lstrcpy(buf, res);
				SetDlgItemText(hwnd, 101, buf);
				LocalFree(buf);
			}
			return TRUE;
		case WM_COMMAND:
			id = LOWORD(wParam);
			if (id == IDOK) {
				EndDialog(hwnd, id);
				return TRUE;
			}
			break;
		case WM_CLOSE:
			EndDialog(hwnd, id);
			return TRUE;
	}
	return FALSE;
}

LRESULT CALLBACK WindowFunc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	switch(message)
	{
		case WM_CREATE:
			gText = CreateWindowEx(WS_EX_STATICEDGE, TEXT("EDIT"), NULL,
				WS_CHILD | WS_VISIBLE | WS_VSCROLL |
				ES_LEFT | ES_MULTILINE | ES_AUTOVSCROLL | ES_READONLY,
				0, 0, 0, 0, hwnd, (HMENU) IDT_MAINWINDOW, gInstance, NULL);
			SendMessage(gText, WM_SETFONT, (WPARAM)GetStockObject(ANSI_FIXED_FONT), MAKELPARAM(0, 0));
			break;
		case WM_DESTROY:
			PostQuitMessage(0);
			break;
		case WM_SETFOCUS:
			SetFocus(gText);
			break;
		case WM_SIZE:
			MoveWindow(gText, 0, 0, LOWORD(lParam), HIWORD(lParam), TRUE);
			break;
		case WM_COMMAND:
			switch (LOWORD(wParam))
			{
				case IDM_EXIT:
					DestroyWindow(gMain);
					break;
				case IDM_BRIGHTUI:
					EnableBrightControls(gDialog);
					SetWindowPos(gDialog, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_SHOWWINDOW);
					gMode = DOBRIGHT;
					break;
				case IDM_OUTMASK:
					EnableMaskControls(gDialog);
					SetWindowPos(gDialog, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_SHOWWINDOW);
					gMode = DOMASK;
					break;
				case IDM_TRANS:
					EnableTransControls(gDialog);
					SetWindowPos(gDialog, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_SHOWWINDOW);
					gMode = DOTRANS;
					break;
				case ID_GPL:
					DialogBox(gInstance, MAKEINTRESOURCE(ID_GPL), hwnd, CopyrightDialogFunc);
					break;
				case IDM_README:
					OpenManual(hwnd);
					break;
				default:
					return DefWindowProc(hwnd, message, wParam, lParam);
			}
			break;
		default:
			return DefWindowProc(hwnd, message, wParam, lParam);
	}
	return 0;
}

BOOL CALLBACK DialogFunc(HWND hdlg, UINT message, WPARAM wParam, LPARAM lParam)
{
	HWND htabs;
	switch (message)
	{
		case WM_INITDIALOG:
			return TRUE;
		case WM_CLOSE:
			SetWindowPos(hdlg, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_HIDEWINDOW);
			return TRUE;
		case WM_NOTIFY:
			if (wParam == IDB_TABS && ((LPNMHDR)lParam)->code == TCN_SELCHANGE)
			{
				htabs = GetDlgItem(hdlg, IDB_TABS);
				int iTab = TabCtrl_GetCurSel(htabs);
				ShowDialogPage(htabs, iTab);
				return TRUE;
			}
			break;
		case WM_COMMAND:
			switch (LOWORD(wParam))
			{
				case IDOK:
				{
					SetWindowPos(hdlg, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_HIDEWINDOW);
					switch (gMode)
					{
						case DOBRIGHT:
							if (!DoBright(hdlg))
								SetWindowPos(hdlg, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_SHOWWINDOW);
							break;
						case DOMASK:
							if (!DoMask(hdlg))
								SetWindowPos(hdlg, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_SHOWWINDOW);
							break;
						case DOTRANS:
							if (!DoTrans(hdlg))
								SetWindowPos(hdlg, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_SHOWWINDOW);
							break;
					}
					return TRUE;
				case IDCANCEL:
					SetWindowPos(hdlg, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_HIDEWINDOW);
					return TRUE;
				}
			}
			break;
	}
	return FALSE;
}

BOOL CALLBACK DialogPageFunc(HWND hdlg, UINT message, WPARAM wParam, LPARAM lParam)
{
	static BOOL validating = FALSE;
	HDWP hdwp;
	HBRUSH b;
	COLORREF c;
	int n;
	switch (message)
	{
		case WM_INITDIALOG:
			return TRUE;
		case WM_DESTROY:
			n = SendDlgItemMessage(gDialogPages[FILEOPTIONS], IDL_INPUTFILES, LB_GETCOUNT, 0, 0);
			while (n--)
			{
				LocalFree((LPVOID)SendDlgItemMessage(gDialogPages[FILEOPTIONS], IDL_INPUTFILES, LB_GETITEMDATA, n, 0));
			}
			break;
		case WM_CTLCOLORDLG:
			return FALSE;
		case WM_DRAWITEM:
			if (((LPDRAWITEMSTRUCT)lParam)->CtlID == IDS_MASKCOLOR)
			{
				c = RGB(GetDlgItemInt(hdlg, IDT_MASKRED, NULL, FALSE),
					GetDlgItemInt(hdlg, IDT_MASKGREEN, NULL, FALSE),
					GetDlgItemInt(hdlg, IDT_MASKBLUE, NULL, FALSE));
				b = CreateSolidBrush(c);
				FillRect(((LPDRAWITEMSTRUCT)lParam)->hDC, &((LPDRAWITEMSTRUCT)lParam)->rcItem, b);
				DeleteObject(b);
				return TRUE;
			}
			break;
		case WM_COMMAND:
			switch (LOWORD(wParam))
			{
				case IDM_PALETTE:
					if (HIWORD(wParam) == CBN_SELCHANGE)
					{
						n = SendDlgItemMessage(hdlg, IDM_PALETTE, CB_GETCURSEL, 0, 0);
						hdwp = BeginDeferWindowPos(6);
						DWPDlgItem(hdwp,hdlg,IDS_NUMPALS,(n == PALAUTO) ? SWP_SHOWWINDOW : SWP_HIDEWINDOW);
						DWPDlgItem(hdwp,hdlg,IDT_NUMPALS,(n == PALAUTO) ? SWP_SHOWWINDOW : SWP_HIDEWINDOW);
						DWPDlgItem(hdwp,hdlg,IDS_ERROR,(n == PALERROR) ? SWP_SHOWWINDOW : SWP_HIDEWINDOW);
						DWPDlgItem(hdwp,hdlg,IDT_ERROR,(n == PALERROR) ? SWP_SHOWWINDOW : SWP_HIDEWINDOW);
						DWPDlgItem(hdwp,hdlg,IDT_PALFILE,(n == PALFILE) ? SWP_SHOWWINDOW : SWP_HIDEWINDOW);
						DWPDlgItem(hdwp,hdlg,IDB_PALFILE,(n == PALFILE) ? SWP_SHOWWINDOW : SWP_HIDEWINDOW);
						EndDeferWindowPos(hdwp);
						if (n == PALFILE)
							CheckCanExecute(TRUE);
						return TRUE;
					}
					break;
				case IDM_MASK:
					if (HIWORD(wParam) == CBN_SELCHANGE)
					{
						n = SendDlgItemMessage(hdlg, IDM_MASK, CB_GETCURSEL, 0, 0);
						if (n == MASKCOLMASK)
						{
							ShowWindow(GetDlgItem(hdlg, IDS_MASKCOLOR), SW_SHOW);
							ShowWindow(GetDlgItem(hdlg, IDT_MASKRED), SW_SHOW);
							ShowWindow(GetDlgItem(hdlg, IDT_MASKGREEN), SW_SHOW);
							ShowWindow(GetDlgItem(hdlg, IDT_MASKBLUE), SW_SHOW);
							ShowWindow(GetDlgItem(hdlg, IDB_MASKCOLOR), SW_SHOW);
						}
						else
						{
							ShowWindow(GetDlgItem(hdlg, IDS_MASKCOLOR), SW_HIDE);
							ShowWindow(GetDlgItem(hdlg, IDT_MASKRED), SW_HIDE);
							ShowWindow(GetDlgItem(hdlg, IDT_MASKGREEN), SW_HIDE);
							ShowWindow(GetDlgItem(hdlg, IDT_MASKBLUE), SW_HIDE);
							ShowWindow(GetDlgItem(hdlg, IDB_MASKCOLOR), SW_HIDE);
						}
						if (n == MASKDEFAULT || n == MASKPINKSCREEN)
						{
							EnableWindow(GetDlgItem(hdlg, IDT_MASK), TRUE);
							EnableWindow(GetDlgItem(hdlg, IDB_FATMASK), TRUE);
							EnableWindow(GetDlgItem(hdlg, IDT_FATMASK), 
										 IsDlgButtonChecked(hdlg, IDB_FATMASK) == BST_CHECKED);
						}
						else
						{
							EnableWindow(GetDlgItem(hdlg, IDT_MASK), FALSE);
							EnableWindow(GetDlgItem(hdlg, IDB_FATMASK), FALSE);
							EnableWindow(GetDlgItem(hdlg, IDT_FATMASK), FALSE);
						}
						return TRUE;
					}
					break;
				case IDL_INPUTFILES:
					if (HIWORD(wParam) == LBN_SELCHANGE)
					{
						if (SendMessage((HWND)lParam, LB_GETCURSEL, 0, 0) != LB_ERR)
							EnableWindow(GetDlgItem(hdlg, IDB_REMFILE), TRUE);
						else
							EnableWindow(GetDlgItem(hdlg, IDB_REMFILE), FALSE);
					}
					break;
				case IDB_MASKCOLOR:
					c = RGB(GetDlgItemInt(hdlg, IDT_MASKRED, NULL, FALSE),
						GetDlgItemInt(hdlg, IDT_MASKGREEN, NULL, FALSE),
						GetDlgItemInt(hdlg, IDT_MASKBLUE, NULL, FALSE));
					if (PickColor(hdlg, &c))
					{
						SetDlgItemInt(hdlg, IDT_MASKRED, GetRValue(c), FALSE);
						SetDlgItemInt(hdlg, IDT_MASKGREEN, GetGValue(c), FALSE);
						SetDlgItemInt(hdlg, IDT_MASKBLUE, GetBValue(c), FALSE);
					}
					break;
				case IDT_MASKRED:
				case IDT_MASKGREEN:
				case IDT_MASKBLUE:
					if (HIWORD(wParam) == EN_CHANGE)
					{
						InvalidateRect(GetDlgItem(hdlg, IDS_MASKCOLOR), NULL, FALSE);
						return TRUE;
					}
					else if (HIWORD(wParam) == EN_UPDATE && !validating)
					{
						validating = TRUE;
						ValidateInteger(GetDlgItem(hdlg, LOWORD(wParam)), 0, 255);
						validating = FALSE;
						return TRUE;
					}
					break;
				case IDB_BUMP:
				case IDB_BINS:
				case IDB_DITHER:
				case IDB_FATMASK:
					EnableWindow(GetDlgItem(hdlg, LOWORD(wParam)+1), 
								 IsDlgButtonChecked(hdlg, LOWORD(wParam)) == BST_CHECKED);
					return TRUE;
				case IDB_PREFIX:
					EnableWindow(GetDlgItem(hdlg, IDT_PREFIX), 
								 IsDlgButtonChecked(hdlg, IDB_PREFIX) == BST_CHECKED);
					CheckCanExecute(FALSE);
					return TRUE;
				case IDB_WRITEPAL:
					if (IsDlgButtonChecked(hdlg, IDB_WRITEPAL) == BST_CHECKED)
					{
						EnableWindow(GetDlgItem(hdlg, IDT_WRITEPAL), TRUE);
						EnableWindow(GetDlgItem(hdlg, IDB_SELECTPAL), TRUE);
					}
					else
					{
						EnableWindow(GetDlgItem(hdlg, IDT_WRITEPAL), FALSE);
						EnableWindow(GetDlgItem(hdlg, IDB_SELECTPAL), FALSE);
					}
					CheckCanExecute(FALSE);
					return TRUE;
				case IDB_ADDFILE:
					AddFileToList(hdlg);
					CheckCanExecute(FALSE);
					return TRUE;
				case IDB_REMFILE:
					RemoveFileFromList(hdlg);
					CheckCanExecute(FALSE);
					return TRUE;
				case IDB_SELECTDIR:
					SelectOutputDir(hdlg);
					CheckCanExecute(FALSE);
					return TRUE;
				case IDB_SELECTPAL:
					SelectWritePalette(hdlg);
					CheckCanExecute(FALSE);
					return TRUE;
				case IDB_PALFILE:
					SelectImagePalette(hdlg);
					CheckCanExecute(FALSE);
					return TRUE;
				case IDT_DESTDIR:
				case IDT_PREFIX:
				case IDT_WRITEPAL:
					if (HIWORD(wParam) == EN_CHANGE)
					{
						CheckCanExecute(FALSE);
						return TRUE;
					}
					break;
				case IDT_PALFILE:
					if (HIWORD(wParam) == EN_CHANGE)
					{
						CheckCanExecute(TRUE);
						return TRUE;
					}
					break;
				case IDT_DEPTHRED:
				case IDT_DEPTHGREEN:
				case IDT_DEPTHBLUE:
				case IDT_PREDEPTHRED:
				case IDT_PREDEPTHGREEN:
				case IDT_PREDEPTHBLUE:
					if (HIWORD(wParam) == EN_UPDATE && !validating)
					{
						validating = TRUE;
						ValidateInteger(GetDlgItem(hdlg, LOWORD(wParam)), 5, 8);
						validating = FALSE;
						return TRUE;
					}
					break;
				case IDT_COLORS:
					if (HIWORD(wParam) == EN_UPDATE && !validating)
					{
						validating = TRUE;
						ValidateInteger(GetDlgItem(hdlg, LOWORD(wParam)), 1, 256);
						validating = FALSE;
						return TRUE;
					}
					break;
				case IDT_DITHER:
					if (HIWORD(wParam) == EN_UPDATE && !validating)
					{
						validating = TRUE;
						ValidateInteger(GetDlgItem(hdlg, LOWORD(wParam)), 0, 100);
						validating = FALSE;
						return TRUE;
					}
					break;
				case IDT_MASK:
				case IDT_FATMASK:
				case IDT_TRANS:
					if (HIWORD(wParam) == EN_UPDATE && !validating)
					{
						validating = TRUE;
						ValidateFloat(GetDlgItem(hdlg, LOWORD(wParam)), 0.0, 1.0);
						validating = FALSE;
						return TRUE;
					}
					break;
				case IDT_BUMP:
					if (HIWORD(wParam) == EN_UPDATE && !validating)
					{
						validating = TRUE;
						ValidateFloat(GetDlgItem(hdlg, LOWORD(wParam)), 0.0, 100.0);
						validating = FALSE;
						return TRUE;
					}
					break;
			}
			break;
	}
	return FALSE;
}

BOOL PickColor(HWND parent, COLORREF* color)
{
	static COLORREF cust[16] = {
		RGB(255,255,255), RGB(255,255,255), RGB(255,255,255), RGB(255,255,255), 
		RGB(255,255,255), RGB(255,255,255), RGB(255,255,255), RGB(255,255,255), 
		RGB(255,255,255), RGB(255,255,255), RGB(255,255,255), RGB(255,255,255), 
		RGB(255,255,255), RGB(255,255,255), RGB(255,255,255), RGB(255,255,255)
	};
	CHOOSECOLOR cc;

	memset(&cc, 0, sizeof(CHOOSECOLOR));
	cc.lStructSize = sizeof(CHOOSECOLOR);
	cc.hwndOwner = parent;
	cc.lpCustColors = (LPDWORD)cust;
	cc.rgbResult = *color;
	cc.Flags = CC_ANYCOLOR | CC_FULLOPEN | CC_RGBINIT;
	if (!ChooseColor(&cc))
		return FALSE;
	*color = cc.rgbResult;
	return TRUE;
}

BOOL PickInputFile(HWND parent, LPTSTR name, DWORD len, int type)
{
	OPENFILENAME ofn;
	TCHAR title[260];

	title[0] = TEXT('\0');
	LoadString(gInstance, IDS_OPENFILECAPTION, title, 260);
	ZeroMemory(&ofn, sizeof(ofn));
	ofn.lStructSize = sizeof(ofn);
	ofn.hwndOwner = parent;
	ofn.lpstrFile = name;
	ofn.nMaxFile = len;
	ofn.lpstrTitle = title;
	ofn.Flags = OFN_EXPLORER | OFN_FILEMUSTEXIST | OFN_HIDEREADONLY;
	ofn.nFilterIndex = 1;
	ofn.lpstrFilter = gFilters[type];
	return GetOpenFileName(&ofn);
}

BOOL PickOutputFile(HWND parent, LPTSTR name, DWORD len, int type)
{
	OPENFILENAME ofn;
	TCHAR fnbuf[520];
	TCHAR title[260];

	fnbuf[0] = TEXT('\0');
	GetDlgItemText(gDialogPages[FILEOPTIONS], IDT_DESTDIR, fnbuf, 260);
	PathAddBackslash(fnbuf);
	if (name && *name && !StrPBrk(name, TEXT("/\\:*?\"<>|"))
		&& (lstrlen(name) < 520 - lstrlen(fnbuf)))
	{
		lstrcat(fnbuf, name);
	}
	else
	{
		lstrcat(fnbuf, gFilters[type] + lstrlen(gFilters[type]) + 1);
	}

	title[0] = TEXT('\0');
	LoadString(gInstance, IDS_SAVEFILECAPTION, title, 260);
	ZeroMemory(&ofn, sizeof(ofn));
	ofn.lStructSize = sizeof(ofn);
	ofn.hwndOwner = parent;
	ofn.lpstrFile = fnbuf;
	ofn.nMaxFile = 520;
	ofn.lpstrTitle = title;
	ofn.Flags = OFN_EXPLORER | OFN_HIDEREADONLY | OFN_NOTESTFILECREATE;
	ofn.nFilterIndex = 1;
	ofn.lpstrFilter = gFilters[type];
	if (GetSaveFileName(&ofn))
	{
		if (lstrlen(fnbuf) - ofn.nFileOffset < len)
		{
			lstrcpy(name, fnbuf + ofn.nFileOffset);
			return TRUE;
		}
	}
	return FALSE;
}

BOOL PickDirectory(HWND parent, LPTSTR name, DWORD len, int type)
{
	OPENFILENAME ofn;
	TCHAR title[260];

	title[0] = TEXT('\0');
	LoadString(gInstance, IDS_OPENDIRCAPTION, title, 260);
	ZeroMemory(&ofn, sizeof(ofn));
	ofn.lStructSize = sizeof(ofn);
	ofn.hwndOwner = parent;
	ofn.lpstrFile = name;
	ofn.nMaxFile = len;
	ofn.lpstrTitle = title;
	ofn.Flags = OFN_EXPLORER | OFN_ENABLESIZING | OFN_HIDEREADONLY | OFN_ENABLEHOOK | OFN_NOTESTFILECREATE | OFN_NOVALIDATE;
	ofn.lpfnHook = SelectDirFunc;
	ofn.nFilterIndex = 1;
	ofn.lpstrFilter = gFilters[type];
	return GetSaveFileName(&ofn);
}

UINT APIENTRY SelectDirFunc(HWND hdlg, UINT message, WPARAM wParam, LPARAM lParam)
{
	LPOFNOTIFY info;
	switch (message)
	{
		case WM_INITDIALOG:
			return TRUE;
		case WM_NOTIFY:
			info = (LPOFNOTIFY)lParam;
			switch (info->hdr.code)
			{
				case CDN_INITDONE:
					CommDlg_OpenSave_HideControl(info->hdr.hwndFrom, stc3);
					CommDlg_OpenSave_HideControl(info->hdr.hwndFrom, edt1);
					break;
				case CDN_FILEOK:
					//ret = CommDlg_OpenSave_GetFolderPath(info->hdr.hwndFrom, info->lpOFN->lpstrFile, info->lpOFN->nMaxFile);
					if (info->lpOFN->nFileOffset > 0 && info->lpOFN->nFileOffset < info->lpOFN->nMaxFile)
					{
						info->lpOFN->lpstrFile[info->lpOFN->nFileOffset] = TEXT('\0');
						info->lpOFN->nFileExtension = 0;
					}
					SetWindowLong(hdlg, DWL_MSGRESULT, 0);
					return TRUE;
				case CDN_SELCHANGE:
					CommDlg_OpenSave_SetControlText(info->hdr.hwndFrom, edt1, TEXT("Output Here"));
					return TRUE;
			}
			break;
	}
	return FALSE;
}

void SelectOutputDir(HWND hdlg)
{
	TCHAR name[260];
	name[0] = TEXT('\0');
	GetDlgItemText(hdlg, IDT_DESTDIR, name, 260);
	StrTrim(name, TEXT(" "));
	if (PickDirectory(hdlg, name, 260, ALLFORMATS))
	{
		SetDlgItemText(hdlg, IDT_DESTDIR, name);
	}
}

void SelectWritePalette(HWND hdlg)
{
	TCHAR name[260];
	int type = ALLFORMATS;
	name[0] = TEXT('\0');
	if (IsDlgButtonChecked(hdlg, IDB_PCX) == BST_CHECKED)
		type = PCXFORMAT;
	else if (IsDlgButtonChecked(hdlg, IDB_BMP) == BST_CHECKED)
		type = BMPFORMAT;
	else if (IsDlgButtonChecked(hdlg, IDB_TGA) == BST_CHECKED)
		type = TGAFORMAT;
	GetDlgItemText(hdlg, IDT_WRITEPAL, name, 260);
	StrTrim(name, TEXT(" "));
	if (PickOutputFile(hdlg, name, 260, type))
	{
		SetDlgItemText(hdlg, IDT_WRITEPAL, name);
	}
}

void SelectImagePalette(HWND hdlg)
{
	TCHAR name[260];
	name[0] = TEXT('\0');
	GetDlgItemText(hdlg, IDT_PALFILE, name, 260);
	StrTrim(name, TEXT(" "));
	if (PickInputFile(hdlg, name, 260, PCXFORMAT))
	{
		SetDlgItemText(hdlg, IDT_PALFILE, name);
	}
}

void AddFileToList(HWND hdlg)
{
	TCHAR path[260];
	TCHAR name[260];
	LPTSTR data;
	HWND lb = GetDlgItem(hdlg, IDL_INPUTFILES);
	int n;
	path[0] = TEXT('\0');
	if (PickInputFile(hdlg, path, 260, ALLFORMATS))
	{
		lstrcpy(name, PathFindFileName(path));
		n = SendMessage(lb, LB_FINDSTRINGEXACT, -1, (LPARAM)name);
		if (n != LB_ERR)
		{
			if (ConfirmDialog(hdlg, IDS_REPLACEINPUTFILE, name))
			{
				data = StrDup(path);
				if (data)
				{
					if (SendMessage(lb, LB_SETITEMDATA, n, (LPARAM)data) == LB_ERR)
					{
						LocalFree(data);
						SendMessage(lb, LB_DELETESTRING, n, 0);
					}
				}
			}
		}
		else
		{
			n = SendMessage(lb, LB_ADDSTRING, 0, (LPARAM)name);
			if (n >= 0)
			{
				data = StrDup(path);
				if (data)
				{
					if (SendMessage(lb, LB_SETITEMDATA, n, (LPARAM)data) == LB_ERR)
					{
						LocalFree(data);
						SendMessage(lb, LB_DELETESTRING, n, 0);
					}
				}
			}
		}
	}
}

void RemoveFileFromList(HWND hdlg)
{
	HWND lb = GetDlgItem(hdlg, IDL_INPUTFILES);
	int n = SendMessage(lb, LB_GETCURSEL, 0, 0);
	LPTSTR data;
	if (n >= 0)
	{
		data = (LPTSTR)SendMessage(lb, LB_GETITEMDATA, n, 0);
		LocalFree(data);
		SendMessage(lb, LB_DELETESTRING, n, 0);
		EnableWindow(GetDlgItem(hdlg, IDB_REMFILE), FALSE);
	}
}

void ValidateInteger(HWND hctl, int min, int max)
{
	TCHAR str[8];
	int num;
	GetWindowText(hctl, str, 8);
	StrTrim(str, TEXT(" "));
	num = StrToInt(str);
	if (num < min)
		num = min;
	else if (num > max)
		num = max;
	wsprintf(str, TEXT("%d"), num);
	SetWindowText(hctl, str);
	SendMessage(hctl, EM_SETSEL, (WPARAM)0, (LPARAM)-1);
	SendMessage(hctl, EM_SETSEL, (WPARAM)-1, (LPARAM)0);
}

void ValidateFloat(HWND hctl, float min, float max)
{
	CHAR str[8];
	CHAR *c;
	float num;
	BOOL gotdecimal;
	GetWindowTextA(hctl, str, 8);
	StrTrimA(str, " ");
	c = str;
	gotdecimal = FALSE;
	while (*c)
	{
		if (*c < '0' || *c > '9')
		{
			if (*c != '.' || gotdecimal)
			{
				*c = '\0';
				break;
			}
			gotdecimal = TRUE;
		}
		++c;
	}
	if (str[0])
	{
		num = strtod(str, NULL);
		if (num < min)
		{
			num = min;
			sprintf(str, "%#0.4f", num);
		}
		else if (num > max)
		{
			num = max;
			sprintf(str, "%#0.4f", num);
		}
	}
	else
	{
		lstrcpyA(str, "0.0");
	}
	SetWindowTextA(hctl, str);
	SendMessage(hctl, EM_SETSEL, (WPARAM)0, (LPARAM)-1);
	SendMessage(hctl, EM_SETSEL, (WPARAM)-1, (LPARAM)0);
}

BOOL CanExecute(BOOL checkpal)
{
	TCHAR path[260];
	if (0 == SendDlgItemMessage(gDialogPages[FILEOPTIONS], IDL_INPUTFILES, LB_GETCOUNT, 0, 0))
		return FALSE;
	path[0] = TEXT('\0');
	GetDlgItemText(gDialogPages[FILEOPTIONS], IDT_DESTDIR, path, 260);
	StrTrim(path, TEXT(" "));
	if (!PathIsDirectory(path))
		return FALSE;
	if (checkpal && SendDlgItemMessage(gDialogPages[PALETTEOPTIONS], IDM_PALETTE, CB_GETCURSEL, 0, 0) == PALFILE)
	{
		path[0] = TEXT('\0');
		GetDlgItemText(gDialogPages[PALETTEOPTIONS], IDT_PALFILE, path, 260);
		StrTrim(path, TEXT(" "));
		if (!PathFileExists(path) || PathIsDirectory(path))
			return FALSE;
	}
	if (IsDlgButtonChecked(gDialogPages[FILEOPTIONS], IDB_WRITEPAL) == BST_CHECKED)
	{
		path[0] = TEXT('\0');
		GetDlgItemText(gDialogPages[FILEOPTIONS], IDT_WRITEPAL, path, 260);
		StrTrim(path, TEXT(" "));
		if (path[0] == TEXT('\0'))
			return FALSE;
		if (StrPBrk(path, TEXT("/\\:*?\"<>|")))
			return FALSE;
	}
	if (IsDlgButtonChecked(gDialogPages[FILEOPTIONS], IDB_PREFIX) == BST_CHECKED)
	{
		path[0] = TEXT('\0');
		GetDlgItemText(gDialogPages[FILEOPTIONS], IDT_PREFIX, path, 260);
		StrTrim(path, TEXT(" "));
		if (StrPBrk(path, TEXT("/\\:*?\"<>|")))
			return FALSE;
	}
	return TRUE;
}

void CheckCanExecute(BOOL checkpal)
{
	EnableWindow(GetDlgItem(gDialog, IDOK), CanExecute(checkpal));
}

void OutputText(LPCTSTR txt)
{
	/* This makes me sick. What kind of wanker designs a text control 
	   without an append text function. Or at least gimme a way to 
	   position the cursor at the end of the text. Yeesh. */
	SendMessage(gText, EM_SETSEL, (WPARAM)0, (LPARAM)-1);
	SendMessage(gText, EM_SETSEL, (WPARAM)-1, (LPARAM)0);
	SendMessage(gText, EM_REPLACESEL, FALSE, (LPARAM)txt);
}

BOOL ConfirmDialog(HWND parent, DWORD id, ...)
{
	va_list va;
	TCHAR title[260];
	TCHAR msg[520];
	int ret = IDNO;
	LPTSTR out = NULL;
	msg[0] = TEXT('\0');
	LoadString(gInstance, id, msg, 520);
	va_start(va, id);
	FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_STRING, msg,
			0, GetUserDefaultLangID(), (LPTSTR)&out, 0, &va);
	va_end(va);
	if (out)
	{
		title[0] = TEXT('\0');
		LoadString(gInstance, IDS_CONFIRMCAPTION, title, 260);
		ret = MessageBox(parent, out, title, MB_APPLMODAL | MB_ICONQUESTION | MB_YESNO);
		LocalFree(out);
	}
	return ret == IDYES;
}

int CollectFileOptions(LPTSTR cmds, int len)
{
	TCHAR pal[260];
	TCHAR bump[8];
	int need = 0;
	BOOL eightbit;

	if (IsDlgButtonChecked(gDialogPages[FILEOPTIONS], IDB_PCX) != BST_CHECKED)
		need = 5;
	if ((eightbit = (IsDlgButtonChecked(gDialogPages[FILEOPTIONS], IDB_ALLOW8BIT) == BST_CHECKED)))
		need += 3;
	pal[0] = TEXT('\0');
	if (IsDlgButtonChecked(gDialogPages[FILEOPTIONS], IDB_WRITEPAL) == BST_CHECKED)
	{
		need += 17;
		GetDlgItemText(gDialogPages[FILEOPTIONS], IDT_WRITEPAL, pal, 260);
		need += lstrlen(pal);
	}
	bump[0] = TEXT('\0');
	if (IsDlgButtonChecked(gDialogPages[FILEOPTIONS], IDB_BUMP) == BST_CHECKED)
	{
		need += 7;
		GetDlgItemText(gDialogPages[FILEOPTIONS], IDT_BUMP, bump, 8);
		need += lstrlen(bump);
	}
	if (len < need)
		return need;
	
	if (IsDlgButtonChecked(gDialogPages[FILEOPTIONS], IDB_BMP) == BST_CHECKED)
		lstrcat(cmds, TEXT("-bmp "));
	else if (IsDlgButtonChecked(gDialogPages[FILEOPTIONS], IDB_TGA) == BST_CHECKED)
		lstrcat(cmds, TEXT("-tga "));
	if (eightbit)
		lstrcat(cmds, TEXT("-8 "));
	if (pal[0])
	{
		lstrcat(cmds, TEXT("-writepal \"out\\"));
		lstrcat(cmds, pal);
		lstrcat(cmds, TEXT("\" "));
	}
	if (bump[0])
	{
		lstrcat(cmds, TEXT("-bump "));
		lstrcat(cmds, bump);
		lstrcat(cmds, TEXT(" "));
	}
	return need;
}

int CollectColorOptions(LPTSTR cmds, int len)
{
	TCHAR bins[8];
	TCHAR *c;
	int need = 16; /* -ycc -depth rgb  */
	BOOL mips = IsDlgButtonChecked(gDialogPages[COLOROPTIONS], IDB_MIPS) == BST_CHECKED;
	bins[0] = TEXT('\0');
	if (IsDlgButtonChecked(gDialogPages[COLOROPTIONS], IDB_BINS) == BST_CHECKED)
	{
		need += 7;
		GetDlgItemText(gDialogPages[COLOROPTIONS], IDT_BINS, bins, 8);
		need += lstrlen(bins);
	}
	if (mips)
		need += 6;
	if (len >= need)
	{
		if (IsDlgButtonChecked(gDialogPages[COLOROPTIONS], IDB_RGB) == BST_CHECKED)
			lstrcat(cmds, TEXT("-rgb "));
		else
			lstrcat(cmds, TEXT("-ycc "));
		lstrcat(cmds, TEXT("-depth "));
		c = cmds + lstrlen(cmds);
		GetDlgItemText(gDialogPages[COLOROPTIONS], IDT_DEPTHRED, c++, 2);
		GetDlgItemText(gDialogPages[COLOROPTIONS], IDT_DEPTHGREEN, c++, 2);
		GetDlgItemText(gDialogPages[COLOROPTIONS], IDT_DEPTHBLUE, c++, 2);
		*c++ = TEXT(' '); *c = TEXT('\0');
		if (bins[0])
		{
			lstrcat(cmds, TEXT("-bins "));
			lstrcat(cmds, bins);
			lstrcat(cmds, TEXT(" "));
		}
		if (mips)
			lstrcat(cmds, TEXT("-mips "));
	}
	return need;
}

int CollectPaletteOptions(LPTSTR cmds, int len)
{
	TCHAR pal[260], colors[8];
	TCHAR dither[8];
	TCHAR *c;
	BOOL sizebias;
	int need = 23; /* -colors c -predepth rgb  */
	int mode = SendDlgItemMessage(gDialogPages[PALETTEOPTIONS], IDM_PALETTE, CB_GETCURSEL, 0, 0);
	switch (mode)
	{
		case PALAUTO:
			need += 7;
			GetDlgItemText(gDialogPages[PALETTEOPTIONS], IDT_NUMPALS, pal, 8);
			need += lstrlen(pal);
			break;
		case PALERROR:
			need += 8;
			GetDlgItemText(gDialogPages[PALETTEOPTIONS], IDT_ERROR, pal, 8);
			need += lstrlen(pal);
			break;
		case PALFILE:
			need += 12;
			GetDlgItemText(gDialogPages[PALETTEOPTIONS], IDT_PALFILE, pal, 260);
			need += lstrlen(pal);
			break;
	}
	GetDlgItemText(gDialogPages[PALETTEOPTIONS], IDT_COLORS, colors, 8);
	need += lstrlen(colors);
	dither[0] = TEXT('\0');
	if (IsDlgButtonChecked(gDialogPages[PALETTEOPTIONS], IDB_DITHER) == BST_CHECKED)
	{
		need += 9;
		GetDlgItemText(gDialogPages[PALETTEOPTIONS], IDT_DITHER, dither, 8);
		need += lstrlen(dither);
	}
	if ((sizebias = (IsDlgButtonChecked(gDialogPages[PALETTEOPTIONS], IDB_SIZEBIAS) == BST_CHECKED)))
		need += 10;
	if (len < need)
		return need;

	switch (mode)
	{
		case PALAUTO:
			lstrcat(cmds, TEXT("-auto "));
			lstrcat(cmds, pal);
			lstrcat(cmds, TEXT(" "));
			break;
		case PALERROR:
			lstrcat(cmds, TEXT("-error "));
			lstrcat(cmds, pal);
			lstrcat(cmds, TEXT(" "));
			break;
		case PALFILE:
			lstrcat(cmds, TEXT("-palette \""));
			lstrcat(cmds, pal);
			lstrcat(cmds, TEXT("\" "));
			break;
	}
	lstrcat(cmds, TEXT("-colors "));
	lstrcat(cmds, colors);
	lstrcat(cmds, TEXT(" "));
	lstrcat(cmds, TEXT("-predepth "));
	c = cmds + lstrlen(cmds);
	GetDlgItemText(gDialogPages[PALETTEOPTIONS], IDT_PREDEPTHRED, c++, 2);
	GetDlgItemText(gDialogPages[PALETTEOPTIONS], IDT_PREDEPTHGREEN, c++, 2);
	GetDlgItemText(gDialogPages[PALETTEOPTIONS], IDT_PREDEPTHBLUE, c++, 2);
	*c++ = TEXT(' '); *c = TEXT('\0');
	if (dither[0])
	{
		lstrcat(cmds, TEXT("-dither "));
		lstrcat(cmds, dither);
		lstrcat(cmds, TEXT(" "));
	}
	if (sizebias)
		lstrcat(cmds, TEXT("-sizebias "));
	return need;
}

int CollectMaskOptions(LPTSTR cmds, int len)
{
	TCHAR mask[8], fatmask[8];
	TCHAR rgb[12]; /* bbb ggg rrr -- yes, backwards */
	BOOL black;
	int need = 0;
	int mode = SendDlgItemMessage(gDialogPages[MASKOPTIONS], IDM_MASK, CB_GETCURSEL, 0, 0);
	switch (mode)
	{
		case MASKPINKSCREEN:
			need += 12;
		case MASKDEFAULT:
			need += 7;
			GetDlgItemText(gDialogPages[MASKOPTIONS], IDT_MASK, mask, 8);
			need += lstrlen(mask);
			fatmask[0] = TEXT('\0');
			if (IsDlgButtonChecked(gDialogPages[MASKOPTIONS], IDB_FATMASK) == BST_CHECKED)
			{
				need += 10;
				GetDlgItemText(gDialogPages[MASKOPTIONS], IDT_FATMASK, fatmask, 8);
				need += lstrlen(fatmask);
			}
			break;
		case MASKPINKMASK:
		case MASKGRAYMASK:
			need += 10;
			break;
		case MASKCOLMASK:
		{
			TCHAR* c = rgb;
			GetDlgItemText(gDialogPages[MASKOPTIONS], IDT_MASKBLUE, c, 4);
			c += lstrlen(c);
			*c++ = TEXT(' '); *c = TEXT('\0');
			GetDlgItemText(gDialogPages[MASKOPTIONS], IDT_MASKGREEN, c, 4);
			c += lstrlen(c);
			*c++ = TEXT(' '); *c = TEXT('\0');
			GetDlgItemText(gDialogPages[MASKOPTIONS], IDT_MASKRED, c, 4);
			need += 10 + lstrlen(rgb);
			break;
		}
	}
	if ((black = IsDlgButtonChecked(gDialogPages[MASKOPTIONS], IDB_BLACK) == BST_CHECKED))
		need += 7;

	if (len < need)
		return need;
	switch (mode)
	{
		case MASKPINKSCREEN:
			lstrcat(cmds, TEXT("-pinkscreen "));
		case MASKDEFAULT:
			lstrcat(cmds, TEXT("-mask "));
			lstrcat(cmds, mask);
			lstrcat(cmds, TEXT(" "));
			if (fatmask[0])
			{
				lstrcat(cmds, TEXT("-fatmask "));
				lstrcat(cmds, fatmask);
				lstrcat(cmds, TEXT(" "));
			}
			break;
		case MASKPINKMASK:
			lstrcat(cmds, TEXT("-pinkmask "));
			break;
		case MASKGRAYMASK:
			lstrcat(cmds, TEXT("-graymask "));
			break;
		case MASKCOLMASK:
			lstrcat(cmds, TEXT("-colmask "));
			lstrcat(cmds, rgb);
			lstrcat(cmds, TEXT(" "));
			break;
	}
	if (black)
		lstrcat(cmds, TEXT("-black "));
	return need;
}

int CollectTransOptions(LPTSTR cmds, int len)
{
	int need;
	TCHAR trans[8];
	GetDlgItemText(gDialogPages[TRANSOPTIONS], IDT_TRANS, trans, 8);
	need = lstrlen(trans) + 8;
	if (len < need)
		return need;
	lstrcat(cmds, TEXT("-trans "));
	lstrcat(cmds, trans);
	lstrcat(cmds, TEXT(" "));
	return need;
}

BOOL DoBright(HWND hdlg)
{
	TCHAR destdir[260], prefix[260];
	LPTSTR cmds;
	int len = 1024;
	int total, ret;

	cmds = LocalAlloc(LPTR, len * sizeof(TCHAR));
	if (!cmds)
		return TRUE;

	total = 1;
	ret = CollectColorOptions(cmds, len - total);
	if (ret > len - total)
	{
		len = (total + ret + 0xFF) & (~0xFF);
		cmds = LocalReAlloc(cmds, len, LMEM_MOVEABLE);
		ret = CollectTransOptions(cmds, len - total);
	}
	total += ret;
	ret = CollectPaletteOptions(cmds, len - total);
	if (ret > len - total)
	{
		len = (total + ret + 0xFF) & (~0xFF);
		cmds = LocalReAlloc(cmds, len, LMEM_MOVEABLE);
		ret = CollectTransOptions(cmds, len - total);
	}
	total += ret;
	ret = CollectMaskOptions(cmds, len - total);
	if (ret > len - total)
	{
		len = (total + ret + 0xFF) & (~0xFF);
		cmds = LocalReAlloc(cmds, len, LMEM_MOVEABLE);
		ret = CollectTransOptions(cmds, len - total);
	}
	total += ret;
	ret = CollectFileOptions(cmds, len - total);
	if (ret > len - total)
	{
		len = (total + ret + 0xFF) & (~0xFF);
		cmds = LocalReAlloc(cmds, len, LMEM_MOVEABLE);
		ret = CollectFileOptions(cmds, len - total);
	}
	total += ret;

	OutputText(TEXT("\r\n---------- \r\n"));
	OutputText(TEXT("bright "));
	OutputText(cmds);
	OutputText(TEXT("\r\n"));

	GetDlgItemText(gDialogPages[FILEOPTIONS], IDT_DESTDIR, destdir, 260);
	GetDlgItemText(gDialogPages[FILEOPTIONS], IDT_PREFIX, prefix, 260);
	ret = ExecuteBright(gMain, cmds, destdir, prefix, GetDlgItem(gDialogPages[FILEOPTIONS], IDL_INPUTFILES), FALSE);
	LocalFree(cmds);

	OutputText(TEXT("\r\nOperation Complete -- "));
	if (ret)
	{
		wsprintf(prefix, TEXT("Returned with Error Code %d"), ret);
		OutputText(prefix);
		prefix[0] = TEXT('\0');
		FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS, NULL,
				ret, GetUserDefaultLangID(), prefix, 260, NULL);
		if (prefix[0])
		{
			OutputText(TEXT(": "));
			OutputText(prefix);
		}
		else
		{
			OutputText(TEXT("\r\n"));
		}
	}
	else
	{
		OutputText(TEXT("Normal Termination\r\n"));
	}

	return TRUE;
}

BOOL DoMask(HWND hdlg)
{
	TCHAR destdir[260], prefix[260];
	LPTSTR cmds;
	int len = 1024;
	int total, ret;

	cmds = LocalAlloc(LPTR, len * sizeof(TCHAR));
	if (!cmds)
		return TRUE;

	total = 1;
	ret = CollectMaskOptions(cmds, len - total);
	if (ret > len - total)
	{
		len = (total + ret + 0xFF) & (~0xFF);
		cmds = LocalReAlloc(cmds, len, LMEM_MOVEABLE);
		ret = CollectTransOptions(cmds, len - total);
	}
	total += ret;
	ret = CollectFileOptions(cmds, len - total);
	if (ret > len - total)
	{
		len = (total + ret + 0xFF) & (~0xFF);
		cmds = LocalReAlloc(cmds, len, LMEM_MOVEABLE);
		ret = CollectFileOptions(cmds, len - total);
	}
	total += ret;

	OutputText(TEXT("\r\n---------- \r\n"));
	OutputText(TEXT("bright "));
	OutputText(cmds);
	OutputText(TEXT("\r\n"));

	GetDlgItemText(gDialogPages[FILEOPTIONS], IDT_DESTDIR, destdir, 260);
	GetDlgItemText(gDialogPages[FILEOPTIONS], IDT_PREFIX, prefix, 260);
	ret = ExecuteBright(gMain, cmds, destdir, prefix, GetDlgItem(gDialogPages[FILEOPTIONS], IDL_INPUTFILES), TRUE);
	LocalFree(cmds);

	OutputText(TEXT("\r\nOperation Complete -- "));
	if (ret)
	{
		wsprintf(prefix, TEXT("Returned with Error Code %d"), ret);
		OutputText(prefix);
		prefix[0] = TEXT('\0');
		FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS, NULL,
				ret, GetUserDefaultLangID(), prefix, 260, NULL);
		if (prefix[0])
		{
			OutputText(TEXT(": "));
			OutputText(prefix);
		}
		else
		{
			OutputText(TEXT("\r\n"));
		}
	}
	else
	{
		OutputText(TEXT("Normal Termination\r\n"));
	}

	return TRUE;
}

BOOL DoTrans(HWND hdlg)
{
	TCHAR destdir[260], prefix[260];
	LPTSTR cmds;
	int len = 1024;
	int total, ret;

	cmds = LocalAlloc(LPTR, len * sizeof(TCHAR));
	if (!cmds)
		return TRUE;

	total = 1;
	ret = CollectTransOptions(cmds, len - total);
	if (ret > len - total)
	{
		len = (total + ret + 0xFF) & (~0xFF);
		cmds = LocalReAlloc(cmds, len, LMEM_MOVEABLE);
		ret = CollectTransOptions(cmds, len - total);
	}
	total += ret;
	ret = CollectFileOptions(cmds, len - total);
	if (ret > len - total)
	{
		len = (total + ret + 0xFF) & (~0xFF);
		cmds = LocalReAlloc(cmds, len, LMEM_MOVEABLE);
		ret = CollectFileOptions(cmds, len - total);
	}
	total += ret;

	OutputText(TEXT("\r\n---------- \r\n"));
	OutputText(TEXT("bright "));
	OutputText(cmds);
	OutputText(TEXT("\r\n"));

	GetDlgItemText(gDialogPages[FILEOPTIONS], IDT_DESTDIR, destdir, 260);
	GetDlgItemText(gDialogPages[FILEOPTIONS], IDT_PREFIX, prefix, 260);
	ret = ExecuteBright(gMain, cmds, destdir, prefix, GetDlgItem(gDialogPages[FILEOPTIONS], IDL_INPUTFILES), TRUE);
	LocalFree(cmds);

	OutputText(TEXT("\r\nOperation Complete -- "));
	if (ret)
	{
		wsprintf(prefix, TEXT("Returned with Error Code %d"), ret);
		OutputText(prefix);
		prefix[0] = TEXT('\0');
		FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS, NULL,
				ret, GetUserDefaultLangID(), prefix, 260, NULL);
		if (prefix[0])
		{
			OutputText(TEXT(": "));
			OutputText(prefix);
		}
		else
		{
			OutputText(TEXT("\r\n"));
		}
	}
	else
	{
		OutputText(TEXT("Normal Termination\r\n"));
	}

	return TRUE;
}

