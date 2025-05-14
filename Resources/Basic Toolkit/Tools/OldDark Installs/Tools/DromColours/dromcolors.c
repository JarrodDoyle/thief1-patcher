// bcc32 -q -O1 -v- -D_WINVER=0x400 -D_WIN32_WINNT=0X400 -c dromcolors.c
// ilink32 -v- -Tpe -aa -c c0w32.obj dromcolors.obj,dromcolors.exe,,import32.lib cw32.lib,,dromcolors.res
/******************************************************************************
 *    dromcolors.cpp
 *
 *    This file is part of Dromed Colors
 *    Copyright (C) 2002 Tom N Harris <telliamed@whoopdedo.cjb.net>
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
#define WINVER 0x400
#define WIN32_WINNT WINVER

#include <windows.h>
#include <commdlg.h>
#include <stdlib.h>
//#include <stdio.h>

#define DROMED1_COLOR_OFFSET	0x36C548
#define DROMED1_FILE_SIZE 0x745FD4
#define DROMED2_COLOR_OFFSET	0x3CA220
#define DROMED2_FILE_SIZE 0x7E2094
#define SHOCKED_COLOR_OFFSET	0x4022C0
#define SHOCKED_FILE_SIZE 0x88A678

LRESULT CALLBACK WindowFunc(HWND, UINT, WPARAM, LPARAM);
BOOL CALLBACK DialogFunc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
void pickColor(HWND hwnd, DWORD item);
BOOL drawColor(HWND hwnd, LPDRAWITEMSTRUCT item);
void openDromed(HWND hwnd);
void saveDromed(HWND hwnd);

const char szWinName[] = "Dromed Colors";
HWND gMain;
char dromed_path[260];
COLORREF dromed_colors[24];
char message_table[10][255];
int dromed_version;
//FILE *f;

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd)
{
#pragma argsused(hInstance, nShowCmd)
	HWND hwnd, hdlg;
	MSG msg;
	HACCEL accel;
	WNDCLASS wcl;
	int i;

//f = fopen("msgdump", "w");
	memset(dromed_path, 0, sizeof(dromed_path));
	for (i=0;i<10;i++)
	{
		LoadString(hInstance, 1000+i, message_table[i], 255);
	}

	//define a window class
	wcl.hInstance = hInstance; //hand to this instance
	wcl.lpszClassName = szWinName; // window class name
	wcl.lpfnWndProc = WindowFunc; //window function
	wcl.style = 0;  // default style

	wcl.hIcon = LoadIcon(NULL, IDI_APPLICATION);

	wcl.hCursor = LoadCursor(NULL, IDC_ARROW);
	wcl.lpszMenuName = NULL;  // no menu

	wcl.cbClsExtra = 0;  // no extra
	wcl.cbWndExtra = 0;
	//background
	wcl.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH);

	// register the window class
	if(!RegisterClass(&wcl)) return 0;

	// lets create a window
	gMain = CreateWindow(
		szWinName,		//name of window class
		"Dromed Colors", 		//title
		WS_POPUP, 		//window style -normal
		CW_USEDEFAULT, 		// X Coordiate, default
		CW_USEDEFAULT, 		// Y Coordiate, default
		CW_USEDEFAULT, 		//width, default
		CW_USEDEFAULT, 		//height, default
		NULL, 		//no parent window
		NULL, 		//use menu registered with this class
		hInstance, 		//handle of this instance of the program
		NULL 		//no additional arguments
		);

	hdlg = CreateDialog(hInstance, MAKEINTRESOURCE(1024), NULL, DialogFunc);

	//Display window
	ShowWindow(hdlg, nShowCmd);
	UpdateWindow(hdlg);

	accel = LoadAccelerators(hInstance, MAKEINTRESOURCE(1024));

	//create the message loop
	while(GetMessage(&msg, NULL, 0, 0))
	{
		if (!TranslateAccelerator(hdlg, accel, &msg))
		{
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}
	}
//fclose(f);
	return msg.wParam;
}

LRESULT CALLBACK WindowFunc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	switch(message){
	case WM_DESTROY: //terminate the program
		PostQuitMessage(0);
		break;
	default:
	//let windows do the job! you paid too much for it!!!
	return DefWindowProc(hwnd, message, wParam, lParam);
	}
	return 0;
}

BOOL CALLBACK DialogFunc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
//fprintf(f, "m: %x c:%d w:%x l:%x\n", message, LOWORD(wParam), HIWORD(wParam), lParam);
	switch (message)
	{
	case WM_COMMAND:
		switch (LOWORD(wParam))
		{
		case 1040:
			openDromed(hwnd);
			return TRUE;
		case 1041:
			if (dromed_path[0])
			{
				saveDromed(hwnd);
				return TRUE;
			}
			break;
		case 1042:
			DestroyWindow(gMain);
			return TRUE;
		case 1000:case 1001:case 1002:case 1003:
		case 1004:case 1005:case 1006:case 1007:
		case 1008:case 1009:case 1010:case 1011:
		case 1012:case 1013:case 1014:case 1015:
		case 1016:case 1017:case 1018:case 1019:
		case 1020:case 1021:case 1022:case 1023:
			if (dromed_path[0])
			{
				pickColor(hwnd, LOWORD(wParam));
				return TRUE;
			}
			break;
		}
		break;
	case WM_DRAWITEM:
			return drawColor(hwnd, (LPDRAWITEMSTRUCT)lParam);
	case WM_CLOSE:
		DestroyWindow(gMain);
		return TRUE;
	}
	return FALSE;
}

void pickColor(HWND hwnd, DWORD item)
{
	static COLORREF cust[16];
	CHOOSECOLOR cc;
	int index = item-1000;

	memset(&cc, 0, sizeof(CHOOSECOLOR));
	cc.lStructSize = sizeof(CHOOSECOLOR);
	cc.hwndOwner = hwnd;
	cc.lpCustColors = (LPDWORD)cust;
	cc.rgbResult = dromed_colors[index] & 0x00FFFFFF;
	cc.Flags = CC_ANYCOLOR | CC_FULLOPEN | CC_RGBINIT;
	if (!ChooseColor(&cc))
		return;
	dromed_colors[index] = cc.rgbResult + 0x01000000;
	InvalidateRect(GetDlgItem(hwnd, item), NULL, FALSE);
}

BOOL drawColor(HWND hwnd, LPDRAWITEMSTRUCT item)
{
#pragma argsused(item)
	RECT* r;
	HBRUSH b, ob;
	COLORREF c;

	if (item->CtlID < 1000 || item->CtlID > 1023)
		return FALSE;

	if (dromed_path[0])
	{
		c = dromed_colors[item->CtlID-1000] & 0x00FFFFFF;
		b = CreateSolidBrush(c);
	} else
	{
		c = 0xFFFFFFFF;
		b = GetStockObject(GRAY_BRUSH);
	}
	r = &item->rcItem;
	SelectObject(item->hDC, GetStockObject(BLACK_PEN));
	ob = (HBRUSH)SelectObject(item->hDC, b);
	Rectangle(item->hDC, r->top, r->left, r->right, r->bottom);
	SelectObject(item->hDC, ob);
	if (c == 0xFFFFFFFF)
		DeleteObject(b);
	return TRUE;
}

void openDromed(HWND hwnd)
{
	OPENFILENAME ofn;
	HANDLE file;
	DWORD count, counthigh, offset;

	memset(&ofn, 0, sizeof(OPENFILENAME));
	ofn.lStructSize = sizeof(OPENFILENAME);
	ofn.hwndOwner = hwnd;
	ofn.lpstrFile = dromed_path;
	ofn.nMaxFile = sizeof(dromed_path);
	ofn.lpstrFilter = "Dromed\0DROMED.EXE\0All Files\0*.*\0";
	ofn.nFilterIndex = 1;
	ofn.lpstrFileTitle = NULL;
	ofn.nMaxFileTitle = 0;
	ofn.lpstrInitialDir = NULL;
	ofn.Flags = OFN_PATHMUSTEXIST | OFN_FILEMUSTEXIST;
	if (!GetOpenFileName(&ofn))
		return;
	
	if ((file = CreateFile(dromed_path, GENERIC_READ, FILE_SHARE_READ, NULL,
			OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)) == INVALID_HANDLE_VALUE)
	{
		MessageBox(hwnd, message_table[1], message_table[0], MB_OK | MB_ICONERROR);
		dromed_path[0] = 0;
		return;
	}
	count = GetFileSize(file, &counthigh);
	if (counthigh != 0)
	{
		MessageBox(hwnd, message_table[7], message_table[6], MB_OK | MB_ICONERROR);
		CloseHandle(file);
		dromed_path[0] = 0;
		return;
	}
	switch (count)
	{
	case DROMED1_FILE_SIZE:
		dromed_version = 1;
		offset = DROMED1_COLOR_OFFSET;
		break;
	case DROMED2_FILE_SIZE:
		dromed_version = 2;
		offset = DROMED2_COLOR_OFFSET;
		break;
	case SHOCKED_FILE_SIZE:
		dromed_version = 3;
		offset = SHOCKED_COLOR_OFFSET;
		break;
	default:
		MessageBox(hwnd, message_table[7], message_table[6], MB_OK | MB_ICONERROR);
		CloseHandle(file);
		dromed_path[0] = 0;
		return;
	}
	if (SetFilePointer(file, offset, 0, FILE_BEGIN) == 0xFFFFFFFF)
	{
		MessageBox(hwnd, message_table[5], message_table[4], MB_OK | MB_ICONERROR);
		CloseHandle(file);
		dromed_path[0] = 0;
		return;
	}
	ReadFile(file, dromed_colors, sizeof(dromed_colors), &count, NULL);
	CloseHandle(file);
	if (count < sizeof(dromed_colors))
	{
		MessageBox(hwnd, message_table[5], message_table[4], MB_OK | MB_ICONERROR);
		dromed_path[0] = 0;
		return;
	}
	//for (count=0;count<24;count++)
	//	dromed_colors[count] &= 0x00FFFFFF;
	InvalidateRect(hwnd, NULL, FALSE);
}

void saveDromed(HWND hwnd)
{
	char backup[260];
	HANDLE file;
	DWORD count, offset;
	char *c;

	strncpy(backup, dromed_path, 260);
	c = strrchr(backup, '.');
	strcpy(c, ".bak");

	switch (dromed_version)
	{
	case 1:
		offset = DROMED1_COLOR_OFFSET;
		break;
	case 2:
		offset = DROMED2_COLOR_OFFSET;
		break;
	case 3:
		offset = SHOCKED_COLOR_OFFSET;
		break;
	default:
		return;
	}
	if (!MoveFile(dromed_path, backup))
	{
		MessageBox(hwnd, message_table[8], message_table[2], MB_OK | MB_ICONERROR);
		return;
	}
	if (!CopyFile(backup, dromed_path, FALSE))
	{
		MessageBox(hwnd, message_table[8], message_table[2], MB_OK | MB_ICONERROR);
		MoveFile(backup, dromed_path);
		return;
	}

	if ((file = CreateFile(dromed_path, GENERIC_WRITE, FILE_SHARE_WRITE, NULL,
			OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)) == INVALID_HANDLE_VALUE)
	{
		MessageBox(hwnd, message_table[3], message_table[2], MB_OK | MB_ICONERROR);
		return;
	}
	if (SetFilePointer(file, offset, 0, FILE_BEGIN) == 0xFFFFFFFF)
	{
		MessageBox(hwnd, message_table[9], message_table[2], MB_OK | MB_ICONERROR);
		CloseHandle(file);
		return;
	}
	WriteFile(file, dromed_colors, sizeof(dromed_colors), &count, NULL);
	CloseHandle(file);
}
