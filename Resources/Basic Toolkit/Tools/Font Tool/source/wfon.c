/******************************************************************************
 *    wfon.c
 *
 *    This file is part of DarkUtils
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
#define UNICODE 1
#define WIN32_LEAN_AND_MEAN
#define WINVER 0x0400
#define _WIN32_IE 0x0400
#include <windows.h>
#include <commdlg.h>
#include <dlgs.h>

#include "wfon-dlg.h"

static const TCHAR szAppName[] = TEXT("WFont");

static const COLORREF	_ctable[] = {
	0x000000, 0xDDDDDD, 0xB6B6B6, 0x969696, 0x7C7C7C, 0x666666, 0x545454, 0x454545,
	0x393939, 0x2F2F2F, 0x272727, 0x202020, 0x1A1A1A, 0x161616, 0x121212, 0x0F0F0F,
	0x0C0C0C, 0x0A0A0A, 0x080808, 0x060606, 0x050505, 0x040404, 0x030303, 0x7A8449,
	0x707A43, 0x65703D, 0x5B6536, 0x0087FE, 0x007DF2, 0x0073E6, 0x0069DA, 0x005FCE,
	0xB18C82, 0xA38178, 0x96776E, 0x886C64, 0x7B615A, 0x6D5650, 0x604C46, 0x52413C,
	0x443632, 0x372B28, 0x29211E, 0x1C1614, 0x0E0B0A, 0xA30202, 0x980202, 0x8E0202,
	0x830202, 0x780101, 0x6D0101, 0x630101, 0x580101, 0x4D0101, 0x380101, 0x220000,
	0x0D0000, 0x083015, 0x072B13, 0x062510, 0x05200E, 0x041A0B, 0x031509, 0x020F06,
	0x8E6D43, 0x87683F, 0x81623C, 0x7A5D38, 0x735734, 0x6D5231, 0x664C2D, 0x60472A,
	0x573F25, 0x4D3820, 0x44301A, 0x3A2915, 0x312110, 0x3E1210, 0x3A110F, 0x36100E,
	0x320E0D, 0x2E0D0C, 0x2A0C0B, 0x260B0A, 0x220A09, 0x1D0807, 0x180606, 0x120504,
	0x0D0303, 0x321D46, 0x2D1A3F, 0x271736, 0x20132C, 0x1A1023, 0x140C1B, 0x0E0912,
	0xEE9A47, 0xDE9042, 0xCF863E, 0xBF7C39, 0xAF7134, 0xA0672F, 0x905D2B, 0x815326,
	0x714922, 0x613F1D, 0x513519, 0x412B14, 0x312110, 0x312110, 0x2E1F0F, 0x2B1D0E,
	0x271A0D, 0x24180C, 0x21160B, 0x1E140A, 0x1B1209, 0x170F07, 0x140D06, 0x110B05,
	0x0A0603, 0xFFFFBD, 0xFFB510, 0xFFAD52, 0xFFFF7B, 0xF1E657, 0xE4CE34, 0xD6B510,
	0x8C7B5A, 0x867555, 0x7F6E4F, 0x79684A, 0x726145, 0x6C5B40, 0x65543A, 0x5C4C33,
	0x54432C, 0x4B3B25, 0x42321E, 0x3A2A17, 0x312110, 0x505B30, 0x4B552D, 0x464F2A,
	0x404927, 0x3B4423, 0x363E20, 0x31381D, 0x2C321A, 0x262C17, 0x212614, 0x1C2011,
	0x171B0D, 0xAD10B5, 0x9C29AD, 0xB51894, 0x9400C6, 0x6300AD, 0x4A0080, 0x310052,
	0x6D7787, 0x666F7E, 0x5F6775, 0x575F6C, 0x505764, 0x494F5A, 0x424752, 0x3B4048,
	0x33373E, 0x2B2E34, 0x222529, 0x1A1C1F, 0x121315, 0x5A3139, 0x542E35, 0x4E2B31,
	0x48272E, 0x42242A, 0x3C2126, 0x361E22, 0x311B1F, 0x2B171B, 0x231316, 0x1B0E11,
	0x130A0C, 0xE71821, 0xCE2118, 0xFF8C18, 0xD97415, 0xB25C12, 0x8C440F, 0x652C0C,
	0x6D5370, 0x664E69, 0x5E4760, 0x564158, 0x4D3B4E, 0x463546, 0x3D2E3D, 0x352835,
	0x2D222D, 0x241B24, 0x1C151C, 0x130E13, 0x0B080B, 0x9C4A4A, 0xA86161, 0xB57777,
	0xC18E8E, 0xCEA5A5, 0xDABBBB, 0xE6D2D2, 0xF3E8E8, 0xFFFFFF, 0x0055C2, 0x004BB6,
	0x0041A2, 0xB5BDFF, 0x8C8CE7, 0x9CADEF, 0x7E9DE2, 0x5F8ED4, 0x417EC7, 0x226EB9,
	0xDED684, 0xCFC87B, 0xC1BA73, 0xB2AC6A, 0xA49E61, 0x959058, 0x878250, 0x746F44,
	0x605C39, 0x4D4A2D, 0x393721, 0x262416, 0x12110A, 0x74959D, 0x97B0B6, 0xBACACE,
	0xDCE5E7, 0xFFFFFF, 0x3A5B4B, 0x466E57, 0x538063, 0x5F936F, 0x6BA57B, 0x00378D,
	0x002D79, 0x002364, 0x001950, 0x000F3B, 0x0000FF, 0x0000FF, 0xFF00FF, 0x000000
};

#define FCTL_FG	ctlLast+2
#define FCTL_BG	ctlLast+4
#define FCTL_AA	ctlLast+5
#define FCTL_FILE ctlLast+6

typedef struct tagCHOOSEFONT_EX
{
	DWORD	lStructSize;
	HWND	hwndOwner;
	HDC 	hDC;
	LPLOGFONT	lpLogFont;
	INT 	iPointSize;
	DWORD	Flags;
	COLORREF	rgbForeground;
	COLORREF	rgbBackground;
	LPCFHOOKPROC	lpfnHook;
	LPCTSTR	lpTemplateName;
	HINSTANCE	hInstance;
	LPTSTR	lpszStyle;
	WORD	nFontType;
	WORD	___MISSING_ALIGNMENT__;
	INT 	nSizeMin;
	INT		nSizeMax;
} CHOOSEFONT_EX,*LPCHOOSEFONT_EX;
#define CFEX_READCHARSFROMFILE	0x10000000L

TCHAR _msg[1024];

HDC ghDC = NULL;
int gWidth, gHeight;

LONG WINAPI MainWndProc(HWND hwnd, UINT msg, WPARAM wp, LPARAM lp);

#define SWAPCHAR(x)	((WCHAR) ( (((WCHAR)(x)&(WCHAR)0x00FFU) << 8) | \
				    (((WCHAR)(x)&(WCHAR)0xFF00U) >> 8) ))

int readchars(LPCTSTR f, LPWSTR d)
{
	HANDLE h;
	/*WORD t[256];*/
	WCHAR c[256];
	DWORD n, i, count;
	int doswap;

	h = CreateFile(f, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
	if (h == INVALID_HANDLE_VALUE)
	{
		wsprintf(_msg, TEXT("No file: %d\n"), GetLastError());
		MessageBox(NULL, _msg, TEXT("Error"), MB_ICONERROR | MB_OK);
		return 0;
	}

	count = 256;
	if (! ReadFile(h, c, sizeof(WCHAR), &n, NULL))
	{
		wsprintf(_msg, TEXT("Can't read file: %d\n"), GetLastError());
		MessageBox(NULL, _msg, TEXT("Error"), MB_ICONERROR | MB_OK);
		CloseHandle(h);
		return 0;
	}
	switch (*c)
	{
	case 0xFFFE:
		doswap = 1;
		break;
	case 0xFEFF:
		doswap = 0;
		break;
	default:
		doswap = IS_TEXT_UNICODE_REVERSE_MASK;
		IsTextUnicode(c, sizeof(WCHAR), &doswap);
		if (doswap)
			*c = SWAPCHAR(*c);
		if (*c != 0x0A && *c != 0x0D && *c != 0x00)
		{
			*d++ = *c;
			count--;
		}
		break;
	}

	while (count > 0)
	{
		if (! ReadFile(h, c, sizeof(WCHAR) * count, &n, NULL))
		{
			wsprintf(_msg, TEXT("Can't read file: %d\n"), GetLastError());
			MessageBox(NULL, _msg, TEXT("Error"), MB_ICONERROR | MB_OK);
			CloseHandle(h);
			return 0;
		}
		if (n == 0)
			break;
		n /= sizeof(WCHAR);
		/*GetStringTypeW(CT_CTYPE3, c, n, t);*/
		for (i = 0; i < n && count > 0; i++)
		{
			if (doswap)
				c[i] = SWAPCHAR(c[i]);
			if (c[i] == 0x0A || c[i] == 0x0D || c[i] == 0x00)
				continue;
			*d++ = c[i];
			/*if (!(t[i] & (C3_NONSPACING|C3_DIACRITIC|C3_VOWELMARK)))*/
				count--;
		}
	}
	CloseHandle(h);

	return 256 - count;
}

HANDLE selectbmp(HWND w, HDC d)
{
	HANDLE h;
	TCHAR f[1024];
	OPENFILENAME of;
	DWORD err;

	if (!GetTextFace(d, 1024, f))
	{
		lstrcpy(f,TEXT("fon.bmp"));
	}
	ZeroMemory(&of, sizeof(OPENFILENAME));
	of.lStructSize = sizeof(OPENFILENAME);
	of.hwndOwner = w;
	of.lpstrFilter = TEXT("All Files\0*.*\0Bitmap Images\0*.BMP\0");
	of.nFilterIndex = 2;
	of.lpstrFile = f;
	of.nMaxFile = 1024;
	of.lpstrTitle = TEXT("Save Font Bitmap");
	of.Flags = OFN_OVERWRITEPROMPT | OFN_EXPLORER;
	of.lpstrDefExt = TEXT("BMP");
	if (!GetSaveFileName(&of))
	{
		if ((err = CommDlgExtendedError()) != 0)
		{
			wsprintf(_msg, TEXT("No file: %d\n"), err);
			MessageBox(NULL, _msg, TEXT("Error"), MB_ICONERROR | MB_OK);
		}
		return INVALID_HANDLE_VALUE;
	}
	h = CreateFile(f, GENERIC_READ|GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
	if (h == INVALID_HANDLE_VALUE)
	{
		wsprintf(_msg, TEXT("No file: %d\n"), GetLastError());
		MessageBox(NULL, _msg, TEXT("Error"), MB_ICONERROR | MB_OK);
	}
	return h;
}

void drawcolor(LPDRAWITEMSTRUCT item, COLORREF c)
{
	RECT rc;
	HBRUSH br;

	CopyRect(&rc, &item->rcItem);
	if (item->itemAction == ODA_FOCUS)
	{
		InflateRect(&rc, -2, -2);
		DrawFocusRect(item->hDC, &rc);
		return;
	}
	br = CreateSolidBrush(c);
	if (!(item->itemState & ODS_DISABLED))
	{
		DrawFrameControl(item->hDC, &rc, DFC_BUTTON, 
			DFCS_BUTTONPUSH | DFCS_ADJUSTRECT | 
			((item->itemState & ODS_SELECTED) ? DFCS_PUSHED : 0));
		FillRect(item->hDC, &rc, br);
		if (item->itemState & ODS_FOCUS)
		{
			DrawFocusRect(item->hDC, &rc);
		}
	}
	else
	{
		DrawFrameControl(item->hDC, &rc, DFC_BUTTON, 
			DFCS_BUTTONPUSH | DFCS_INACTIVE | DFCS_ADJUSTRECT);
		FillRect(item->hDC, &rc, br);
	}
	DeleteObject(br);
}

void drawsample(HWND w, HDC d, LPRECT r, COLORREF c, COLORREF k)
{
	LOGFONT l;
	HFONT f, t;
	COLORREF o;
	HBRUSH b;
	RECT e;
	int m;
	ZeroMemory(&l, sizeof(LOGFONT));
	CopyRect(&e,r);
	b = CreateSolidBrush(k);
	DrawEdge(d, &e, EDGE_SUNKEN, BF_RECT | BF_ADJUST);
	FillRect(d, &e, b);
	DeleteObject(b);
	SendMessage(w, WM_CHOOSEFONT_GETLOGFONT, 0, (LPARAM)&l);
	if (!l.lfFaceName[0])
		return;
	l.lfHeight = GetDlgItemInt(w, cmb3, NULL, FALSE);
	if (l.lfHeight == 0)
		return;
	l.lfQuality = (IsDlgButtonChecked(w,FCTL_AA) == BST_UNCHECKED) ? 
			NONANTIALIASED_QUALITY : ANTIALIASED_QUALITY;
	f = CreateFontIndirect(&l);
	if (!f)
		return;
	t = SelectObject(d, f);
	o = SetTextColor(d, c);
	m = SetBkMode(d, TRANSPARENT);
	/* These damn dialogs are a real pain, but at least this
	   seems to "magically" work for getting the sample string. */
	GetDlgItemText(w, stc5, _msg, 1023);
	DrawText(d, _msg ,8, r, DT_CENTER | DT_VCENTER | DT_SINGLELINE);
	SetTextColor(d, o);
	SetBkMode(d, m);
	SelectObject(d, t);
	DeleteObject(f);
}

int selectcolor(HWND parent, COLORREF *color)
{
	static COLORREF cust[16] = {
		RGB(255,255,255), RGB(255,255,255), RGB(255,255,255), RGB(255,255,255), 
		RGB(255,255,255), RGB(255,255,255), RGB(255,255,255), RGB(255,255,255), 
		RGB(255,255,255), RGB(255,255,255), RGB(255,255,255), RGB(255,255,255), 
		RGB(255,255,255), RGB(255,255,255), RGB(255,255,255), RGB(255,255,255)
	};
	CHOOSECOLOR cc;

	ZeroMemory(&cc, sizeof(CHOOSECOLOR));
	cc.lStructSize = sizeof(CHOOSECOLOR);
	cc.hwndOwner = parent;
	cc.lpCustColors = (LPDWORD)cust;
	cc.rgbResult = *color;
	cc.Flags = CC_ANYCOLOR | CC_FULLOPEN | CC_RGBINIT;
	if (!ChooseColor(&cc))
		return -1;
	*color = cc.rgbResult;
	return 0;
}

UINT WINAPI fontproc(HWND dlg, UINT msg, WPARAM wp, LPARAM lp)
{
	static LPCHOOSEFONT_EX cf = NULL;
	static COLORREF tc = 0, bc = 0;
	static LONG ok = 0;
	COLORREF c;
	HDC dc;
	RECT rc;

/*
	GetWindowRect(GetDlgItem(dlg, FCTL_FG), &rc);
	MapWindowPoints(NULL, dlg, (POINT*)&rc, 2);
*/
	switch (msg)
	{
	case WM_INITDIALOG:
		cf = (LPCHOOSEFONT_EX)lp;
		CheckDlgButton(dlg, FCTL_AA, 
				(cf->lpLogFont->lfQuality == NONANTIALIASED_QUALITY) ? BST_UNCHECKED : BST_CHECKED);
		tc = cf->rgbForeground;
		bc = cf->rgbBackground;
		SendDlgItemMessage(dlg, cmb4, CB_SETITEMDATA,
				SendDlgItemMessage(dlg, cmb4, CB_GETCURSEL, 0,0), tc);
		//SetDlgItemInt(dlg, cmb3, 24, FALSE);
		SendDlgItemMessage(dlg, cmb3, CB_SELECTSTRING, -1, (LPARAM)(TEXT("24")));
		ok = 0;
		return TRUE;
	case WM_DESTROY:
		/* This fucking sucks. */
		if (ok)
		{
			if (ok < 0)
			{
				cf->lpLogFont->lfQuality = NONANTIALIASED_QUALITY;
				cf->lpLogFont->lfHeight = -ok;
			}
			else
			{
				cf->lpLogFont->lfHeight = ok;
			}
			dc = GetDC(dlg);
			cf->iPointSize = MulDiv(cf->lpLogFont->lfHeight, 720, GetDeviceCaps(dc, LOGPIXELSY));
			ReleaseDC(dlg,dc);
		}
		break;
	case WM_COMMAND:
		switch (wp)
		{
		case IDOK:
			cf->rgbForeground = tc;
			cf->rgbBackground = bc;
			ok = GetDlgItemInt(dlg, cmb3, NULL, FALSE);
			if (IsDlgButtonChecked(dlg,FCTL_AA) == BST_UNCHECKED)
				ok = -ok;
			if (IsDlgButtonChecked(dlg,FCTL_FILE) == BST_CHECKED)
				cf->Flags |= CFEX_READCHARSFROMFILE;
			return FALSE;
		case FCTL_FG:
			c = tc;
			if (selectcolor(dlg, &c) == 0)
			{
				tc = c;
				InvalidateRect(GetDlgItem(dlg, FCTL_FG), NULL, TRUE);
				SendDlgItemMessage(dlg, cmb4, CB_SETITEMDATA,
						SendDlgItemMessage(dlg, cmb4, CB_GETCURSEL, 0,0), c);
				GetWindowRect(GetDlgItem(dlg, stc5), &rc);
				MapWindowPoints(NULL, dlg, (POINT*)&rc, 2);
				InvalidateRect(dlg, &rc, TRUE);
			}
			return TRUE;
		case FCTL_BG:
			c = bc;
			if (selectcolor(dlg, &c) == 0)
			{
				bc = c;
				InvalidateRect(GetDlgItem(dlg, FCTL_BG), NULL, TRUE);
				GetWindowRect(GetDlgItem(dlg, stc5), &rc);
				MapWindowPoints(NULL, dlg, (POINT*)&rc, 2);
				InvalidateRect(dlg, &rc, TRUE);
			}
			return TRUE;
		case FCTL_AA:
				GetWindowRect(GetDlgItem(dlg, stc5), &rc);
				MapWindowPoints(NULL, dlg, (POINT*)&rc, 2);
				InvalidateRect(dlg, &rc, TRUE);
			break;
		}
		break;
	case WM_PAINT:
		if (GetUpdateRect(dlg, &rc, FALSE))
		{
			GetWindowRect(GetDlgItem(dlg, stc5), &rc);
			MapWindowPoints(NULL, dlg, (POINT*)&rc, 2);
			dc = GetDC(dlg);
			drawsample(dlg, dc, &rc, tc, bc);
			ReleaseDC(dlg, dc);
			ValidateRect(dlg, &rc);
		}
		break;
	case WM_DRAWITEM:
		if (((LPDRAWITEMSTRUCT)lp)->CtlID == FCTL_FG)
		{
			drawcolor((LPDRAWITEMSTRUCT)lp, tc);
			return TRUE;
		}
		else if (((LPDRAWITEMSTRUCT)lp)->CtlID == FCTL_BG)
		{
			drawcolor((LPDRAWITEMSTRUCT)lp, bc);
			return TRUE;
		}
		break;
	}
	return FALSE;
}

HANDLE fonttemplate()
{
	HGLOBAL hg;
	char *dt;
	
	hg = GlobalAlloc(GMEM_ZEROINIT, 2048);
	if (!hg)
		return NULL;
	dt = (char*)GlobalLock(hg);
	CopyMemory(dt, _fontdialog, sizeof(_fontdialog));
	GlobalUnlock(hg);
	return hg;
}

HFONT selectfont(HWND w, COLORREF *tc, COLORREF *bc, LPTSTR fn)
{
	OPENFILENAME of;
	CHOOSEFONT_EX cf;
	LOGFONT lf;
	DWORD err;
	
	ZeroMemory(&lf, sizeof(LOGFONT));
	ZeroMemory(&cf, sizeof(CHOOSEFONT_EX));
	cf.lStructSize = sizeof(CHOOSEFONT_EX);
	cf.hwndOwner = w;
	cf.lpLogFont = &lf;
	cf.Flags = CF_SCREENFONTS | CF_EFFECTS | CF_NOVERTFONTS
			| CF_ENABLEHOOK | CF_ENABLETEMPLATEHANDLE;
	cf.lpfnHook = fontproc;
	cf.hInstance = (HINSTANCE)fonttemplate();
	lf.lfQuality = ANTIALIASED_QUALITY;
	cf.rgbForeground = RGB(255,255,255);
	cf.rgbBackground = RGB(0,0,0);
	
	err = ChooseFont((LPCHOOSEFONT)&cf);
	GlobalFree(cf.hInstance);
	if (!err)
	{
		if ((err = CommDlgExtendedError()) != 0)
		{
			wsprintf(_msg, TEXT("No font: %d\n"), err);
			MessageBox(NULL, _msg, TEXT("Error"), MB_ICONERROR | MB_OK);
		}
		return NULL;
	}
	*tc = cf.rgbForeground;
	*bc = cf.rgbBackground;
	if (cf.Flags & CFEX_READCHARSFROMFILE)
	{
		ZeroMemory(&of, sizeof(OPENFILENAME));
		of.lStructSize = sizeof(OPENFILENAME);
		of.hwndOwner = w;
		of.lpstrFilter = TEXT("All Files\0*.*\0Text Files\0*.TXT;*.TEXT\0");
		of.nFilterIndex = 2;
		of.lpstrFile = fn;
		of.nMaxFile = 1024;
		of.lpstrTitle = TEXT("Read Characters from File");
		of.Flags = OFN_FILEMUSTEXIST | OFN_HIDEREADONLY | OFN_EXPLORER;
		if (!GetOpenFileName(&of))
		{
			if ((err = CommDlgExtendedError()) != 0)
			{
				wsprintf(_msg, TEXT("No file: %d\n"), err);
				MessageBox(NULL, _msg, TEXT("Error"), MB_ICONERROR | MB_OK);
			}
			fn[0] = TEXT('\0');
		}
	}
	return CreateFontIndirect(&lf);
}

void writebmp(HWND parent, HDC dc)
{
	HANDLE fh;
	HBITMAP bm;
	BITMAPINFO *bi;
	BITMAPINFOHEADER *bmi;
	BITMAPFILEHEADER bmf;
	unsigned char *bits;
	DWORD n;
	
	bm = GetCurrentObject(dc, OBJ_BITMAP);
	bi = (BITMAPINFO*)LocalAlloc(LMEM_FIXED, sizeof(BITMAPINFOHEADER)+1024);
	if (!bi)
	{
		wsprintf(_msg, TEXT("No memory: %d\n"), GetLastError());
		MessageBox(NULL, _msg, TEXT("Error"), MB_ICONERROR | MB_OK);
		return;
	}
	bmi = (BITMAPINFOHEADER*)bi;
	bmi->biSize = sizeof(BITMAPINFOHEADER);
	bmi->biBitCount = 0;
	if (!GetDIBits(dc, bm, 0, 0, NULL, bi, DIB_RGB_COLORS))
	{
		wsprintf(_msg, TEXT("No bitmap: %d\n"), GetLastError());
		MessageBox(NULL, _msg, TEXT("Error"), MB_ICONERROR | MB_OK);
		LocalFree(bi);
		return;
	}
	bits = LocalAlloc(LPTR, bmi->biHeight * (((bmi->biWidth * 3)+3)&~3));
	if (bits)
	{
		bmi->biPlanes = 1;
		bmi->biBitCount = 24;
		bmi->biCompression = BI_RGB;
		bmi->biSizeImage = 0;
		bmi->biXPelsPerMeter = 0xB13;
		bmi->biYPelsPerMeter = 0xB13;
		bmi->biClrUsed = 0;
		bmi->biClrImportant = 0;
		GetDIBits(dc, bm, 0, bmi->biHeight, bits, bi, DIB_RGB_COLORS);
		bmf.bfType = 0x4D42;
		bmf.bfReserved1 = bmf.bfReserved2 = 0;
		bmf.bfOffBits = sizeof(BITMAPINFOHEADER) + sizeof(BITMAPFILEHEADER);
		bmf.bfSize = bmi->biSizeImage + bmf.bfOffBits;
		fh = selectbmp(parent, dc);
		if (fh != INVALID_HANDLE_VALUE)
		{
			WriteFile(fh, &bmf, sizeof(BITMAPFILEHEADER), &n, NULL);
			WriteFile(fh, bi, sizeof(BITMAPINFOHEADER), &n, NULL);
			WriteFile(fh, bits, bmi->biSizeImage, &n, NULL);
			CloseHandle(fh);
		}
		LocalFree(bits);
	}
	else
	{
		wsprintf(_msg, TEXT("No memory: %d\n"), GetLastError());
		MessageBox(NULL, _msg, TEXT("Error"), MB_ICONERROR | MB_OK);
	}
	
	LocalFree(bi);
}

int dofont(HWND parent)
{
	HDC screen, dc;
	HBITMAP bm;
	HBRUSH br;
	COLORREF tc, bc;
	HFONT tf;
	TEXTMETRIC mx;
	RECT rc;
	int x,y;
	int width,height;
	DWORD n,c;
	char cp850[4];
	WCHAR uni[256];
	TCHAR charfile[1024];
	WCHAR *p;
	int numchars;

	ZeroMemory(uni, 256 * sizeof(WCHAR));
	
	screen = GetDC(parent);
	if (!screen)
	{
		wsprintf(_msg, TEXT("No screen: %d\n"), GetLastError());
		MessageBox(NULL, _msg, TEXT("Error"), MB_ICONERROR | MB_OK);
		return 1;
	}
	dc = CreateCompatibleDC(screen);
	if (!dc)
	{
		wsprintf(_msg, TEXT("No graphics: %d\n"), GetLastError());
		MessageBox(NULL, _msg, TEXT("Error"), MB_ICONERROR | MB_OK);
		ReleaseDC(parent,screen);
		return 1;
	}
	
	charfile[0] = TEXT('\0');
	tf = selectfont(parent, &tc, &bc, charfile);
	if (!tf)
	{
		DeleteDC(dc);
		ReleaseDC(parent,screen);
		return 1;
	}
	DeleteObject(SelectObject(dc, tf));

	if (charfile[0])
	{
		numchars = readchars(charfile, uni);
	}
	else
		numchars = 0;
	
	if (!GetTextMetrics(dc, &mx))
	{
		wsprintf(_msg, TEXT("No metrics: %d\n"), GetLastError());
		MessageBox(NULL, _msg, TEXT("Error"), MB_ICONERROR | MB_OK);
		DeleteDC(dc);
		ReleaseDC(parent,screen);
		return 1;
	}
	
	width = (mx.tmMaxCharWidth + 8) * 18;
	height = (mx.tmHeight + 8) * 16;
	bm = CreateCompatibleBitmap(screen, width, height);
	ReleaseDC(parent,screen);
	if (!bm)
	{
		wsprintf(_msg, TEXT("No bitmap: %d\n"), GetLastError());
		MessageBox(NULL, _msg, TEXT("Error"), MB_ICONERROR | MB_OK);
		DeleteDC(dc);
		return 1;
	}
	DeleteObject(SelectObject(dc, bm));
	
	rc.left = 0; rc.top = 0;
	rc.right = width; rc.bottom = height;
	br = CreateSolidBrush(bc);
	FillRect(dc, &rc, br);
	DeleteObject(br);
	
	br = CreateSolidBrush(RGB(255,0,255));
	SetTextColor(dc, tc);
	SetBkColor(dc, bc);

	x = 2;
	y = mx.tmHeight/2;
	p = uni;
	for (n = (numchars) ? 0 : 0x20; n <= 0xFF; n++)
	{
		rc.left = x;
		rc.top = y;
		rc.bottom = y + mx.tmHeight + 2;
		if (numchars)
		{
			rc.right = rc.left;
			rc.bottom = rc.top;
			DrawTextW(dc, p, 1, &rc, DT_CALCRECT | DT_NOCLIP | DT_EXTERNALLEADING | DT_SINGLELINE | DT_NOPREFIX);
			rc.right += GetTextCharacterExtra(dc) + 2;
			rc.bottom += 2;
			FrameRect(dc, &rc, br);
			rc.left += 1;
			rc.top += 1;
			DrawTextW(dc, p, 1, &rc, DT_NOCLIP | DT_SINGLELINE | DT_NOPREFIX);
			x = rc.right + 4;
			p++;
			if (--numchars == 0)
				break;
		}
		else
		{
			wsprintfA(cp850, "%c", (char)n);
			c = MultiByteToWideChar(850, MB_PRECOMPOSED | MB_ERR_INVALID_CHARS | MB_USEGLYPHCHARS,
					cp850, 1, uni, 3);
			if (c == 0)
			{
				uni[0] = 0;
				rc.right = x + 3;
				FrameRect(dc, &rc, br);
				x += 7;
			}
			else
			{
				rc.right = rc.left;
				rc.bottom = rc.top;
				DrawTextW(dc, uni, c, &rc, DT_CALCRECT | DT_NOCLIP | DT_EXTERNALLEADING | DT_SINGLELINE | DT_NOPREFIX);
				rc.right += GetTextCharacterExtra(dc) + 2;
				rc.bottom += 2;
				FrameRect(dc, &rc, br);
				rc.left += 1;
				rc.top += 1;
				DrawTextW(dc, uni, c, &rc, DT_NOCLIP | DT_SINGLELINE | DT_NOPREFIX);
				x = rc.right + 4;
			}
		}
		if ((n&0xF) == 0xF)
		{
			x = 2;
			y = rc.bottom + 5;
		}
	}
	DeleteObject(br);

	if (ghDC)
		DeleteDC(ghDC);
	ghDC = dc;
	gWidth = width;
	gHeight = height;

	return 0;
}

int WINAPI WinMain(HINSTANCE inst, HINSTANCE prev, LPSTR cmd, int sw)
{
	HWND wnd;
	MSG msg;
	WNDCLASS wc;

	wc.style = 0;
	wc.lpfnWndProc = (WNDPROC)MainWndProc;
	wc.cbClsExtra = 0;
	wc.cbWndExtra = 0;
	wc.hInstance = inst;
	wc.hIcon = LoadIcon(inst, szAppName);
	wc.hCursor = LoadCursor(NULL, IDC_ARROW);
	wc.hbrBackground = (HBRUSH)(GetStockObject(BLACK_BRUSH));
	wc.lpszMenuName = szAppName;
	wc.lpszClassName = szAppName;
	
	if (!RegisterClass(&wc))
		return FALSE;
	wnd = CreateWindow(szAppName, szAppName, 
			(WS_OVERLAPPEDWINDOW & ~WS_THICKFRAME) | WS_CLIPSIBLINGS | WS_CLIPCHILDREN, 
			CW_USEDEFAULT, CW_USEDEFAULT, 640, 480, NULL, NULL, inst, NULL); 
	if (!wnd)
		return FALSE;
	ShowWindow(wnd, SW_SHOWDEFAULT);
	UpdateWindow(wnd);
	while (1)
	{
		if (!GetMessage(&msg, NULL, 0, 0))
			break;
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}
	return 0;
}

LONG WINAPI MainWndProc(HWND wnd, UINT msg, WPARAM wp, LPARAM lp)
{
	static BOOL first = FALSE;
	HDC dc;
	PAINTSTRUCT ps;

	switch (msg)
	{
	case WM_CREATE:
		if (dofont(wnd) == 0)
		{
			SetWindowPos(wnd, HWND_TOP, 0,0, gWidth, gHeight, SWP_NOMOVE | SWP_NOZORDER);
		}
		else
		{
			DestroyWindow(wnd);
		}
		return TRUE;
	case WM_WINDOWPOSCHANGED:
		if (!first && ((LPWINDOWPOS)lp)->flags & SWP_SHOWWINDOW)
		{
			first = TRUE;
			writebmp(wnd, ghDC);
		}
		break;
	case WM_SIZE:
		InvalidateRect(wnd, NULL, FALSE);
		break;
	case WM_PAINT:
		dc = BeginPaint(wnd, &ps);
		if (ghDC)
		{
			BitBlt(dc, 0, 0, gWidth, gHeight, ghDC, 0, 0, SRCCOPY);
		}
		EndPaint(wnd, &ps);
		break;
	case WM_CLOSE:
		if (ghDC)
			DeleteDC(ghDC);
		DestroyWindow(wnd);
		return TRUE;
	case WM_DESTROY:
		PostQuitMessage(0);
		return TRUE;
	default:
		return DefWindowProc(wnd, msg, wp, lp);
	}

	return FALSE;
}

