#define WIN32_LEAN_AND_MEAN
#define WINVER 0x0500
#define _WIN32_WINNT 0x0500
#define _WIN32_IE 0x0500
#include <windows.h>
#include <shellapi.h>
#include <imm.h>
#include <commctrl.h>
#include <commdlg.h>
#include <stdlib.h>
#include <string.h>
#include "Scintilla.h"

#define CMD_EXIT	1000
#define CMD_UNDO	1001
#define CMD_REDO	1002
#define CMD_CUT	1003
#define CMD_COPY	1004
#define CMD_PASTE	1005
#define CMD_DELETE	1006
#define CMD_SELECTALL	1007
#define CMD_SAVE	1008
#define CMD_OPEN	1009
#define CMD_LAUNCH	1010
#define CMD_TEXT	1011
#define CMD_TOPWIN	1012
#define CMD_TRANSWIN	1013

#define CTL_LABEL	1000
#define CTL_EDIT	1001
#define CTL_SLIDER	1002
#define CTL_FILE	1003
#define CTL_LABEL2	1004

#define TYPE_LAUNCH	0
#define TYPE_EXE	1
#define TYPE_INI	2
#define TYPE_LOG	3

#ifndef MIN
#define MIN(a,b) (((a)<(b))?(a):(b))
#endif

typedef BOOL (WINAPI *SETLAYEREDWINDOWATTRIBUTES)(HWND,COLORREF,BYTE,DWORD);
typedef BOOL (WINAPI *GETLAYEREDWINDOWATTRIBUTES)(HWND,COLORREF*,BYTE*,DWORD*);

SETLAYEREDWINDOWATTRIBUTES pfnSetLayeredWindowAttributes = NULL;
GETLAYEREDWINDOWATTRIBUTES pfnGetLayeredWindowAttributes = NULL;

struct DEBUG_PROC_INFO_
{
	LPCTSTR fn;
	LPTSTR args;
	HANDLE h;
	PROCESS_INFORMATION pi;
	STARTUPINFO si;
	char buf[1024];
	char wbuf[1024];
};
typedef struct DEBUG_PROC_INFO_ DEBUG_PROC_INFO;

struct OPTIONS_STRUCT_
{
	LPTSTR ini;
	TCHAR exe[520];
	TCHAR args[520];
	TCHAR log[520];
	TCHAR stamp[520];
	int left,top,width,height;
	int sticky;
	int transparent;
};
typedef struct OPTIONS_STRUCT_ OPTIONS;

struct DLGITEM_STRUCT_
{
	LPCWSTR cls;
	LPCWSTR caption;
	WORD id;
	DWORD style;
	short x,y,w,h;
};
typedef struct DLGITEM_STRUCT_ DLGITEM;

#define lpwAlign(n)	((LPWORD)((((ULONG)(n))+3)&~3))

static const DLGITEM selectfile_dialog[] = {
	{0, L"", 0, DS_MODALFRAME | WS_SYSMENU | WS_CAPTION, 0, 0, 228, 46},
	{(LPWSTR)MAKELONG(0xFFFF,0x0082), L"&File name", CTL_LABEL, SS_LEFT | WS_GROUP, 7, 8, 138, 8},
	{(LPWSTR)MAKELONG(0xFFFF,0x0081), L"", CTL_EDIT, ES_LEFT | ES_AUTOHSCROLL | WS_BORDER | WS_TABSTOP, 7, 21, 138, 12},
	{(LPWSTR)MAKELONG(0xFFFF,0x0080), L"...", CTL_FILE, BS_PUSHBUTTON | WS_TABSTOP, 148, 21, 14, 12},
	{(LPWSTR)MAKELONG(0xFFFF,0x0080), L"OK", IDOK, BS_PUSHBUTTON | WS_TABSTOP, 171, 7, 50, 14},
	{(LPWSTR)MAKELONG(0xFFFF,0x0080), L"Cancel", IDCANCEL, BS_PUSHBUTTON | WS_TABSTOP, 171, 24, 50, 14},
};
static const WCHAR header_dialog_caption[] = 
                   L"Insert text header:\r\n"
                   L"    %1: App filename  %2: App args\r\n"
                   L"    %3: Date (short)    %4: Date (long)  %5: Time\r\n"
                   L"    %6: User name     %n: Line break";
static const DLGITEM string_dialog[] = {
	{0, L"Edit text", 0, DS_MODALFRAME | WS_SYSMENU | WS_CAPTION, 0, 0, 228, 63},
	{(LPWSTR)MAKELONG(0xFFFF,0x0082), header_dialog_caption, CTL_LABEL, SS_LEFT | WS_GROUP, 7, 8, 156, 33},
	{(LPWSTR)MAKELONG(0xFFFF,0x0081), L"", CTL_EDIT, ES_LEFT | ES_AUTOHSCROLL | WS_BORDER | WS_TABSTOP, 7, 43, 214, 12},
	{(LPWSTR)MAKELONG(0xFFFF,0x0080), L"OK", IDOK, BS_PUSHBUTTON | WS_TABSTOP, 171, 7, 50, 14},
	{(LPWSTR)MAKELONG(0xFFFF,0x0080), L"Cancel", IDCANCEL, BS_PUSHBUTTON | WS_TABSTOP, 171, 24, 50, 14},
};
static const DLGITEM slider_dialog[] = {
	{0, L"Window Transparency", 0, DS_MODALFRAME | WS_SYSMENU | WS_CAPTION, 0, 0, 228, 46},
	{(LPWSTR)MAKELONG(0xFFFF,0x0082), L"&Transparent", CTL_LABEL, SS_RIGHT | WS_GROUP, 98, 8, 58, 8},
	{(LPWSTR)MAKELONG(0xFFFF,0x0082), L"Opaque", CTL_LABEL2, SS_LEFT, 7, 8, 58, 8},
	{TRACKBAR_CLASSW, L"", CTL_SLIDER, TBS_AUTOTICKS | TBS_BOTTOM | TBS_TOOLTIPS | WS_TABSTOP, 7, 19, 156, 18},
	{(LPWSTR)MAKELONG(0xFFFF,0x0080), L"OK", IDOK, BS_PUSHBUTTON | WS_TABSTOP, 171, 7, 50, 14},
	{(LPWSTR)MAKELONG(0xFFFF,0x0080), L"Cancel", IDCANCEL, BS_PUSHBUTTON | WS_TABSTOP, 171, 24, 50, 14},
};

LRESULT CALLBACK WindowFunc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
DWORD WINAPI DebugProc(DEBUG_PROC_INFO *procinfo);
void InsertText(char* text, DWORD nch);
BOOL SetWindowTopmost(HWND hwnd, BOOL topmost);
BOOL SetWindowTransparent(HWND hwnd, int transparent);
int TransparentDialog(HWND window);
BOOL StringDialog(HWND parent, LPTSTR text, LPCTSTR prompt);
BOOL FilenameDialog(HWND parent, LPTSTR filename, int type);
LPTSTR PromptFilename(HWND parent, int type, LPCTSTR name);
BOOL ReadIniFile(void);
void WriteIniFile(BOOL full);
OPTIONS* CreateIniStruct(HWND hwnd);

HINSTANCE ghInstance;
HMENU ghMenu = NULL;
HWND ghWnd = NULL;
HWND ghText = NULL;
OPTIONS* gOptions = NULL;
BOOL gIsDebugging = FALSE;

void ErrorDialog(DWORD err)
{
	TCHAR txt[24];
	wsprintf(txt, TEXT("%u"), err);
	MessageBox(NULL, txt, TEXT("Error"), MB_ICONERROR | MB_OK);
}

LPDLGTEMPLATE CreateDialogTemplate(const DLGITEM* items, int numitems, LPCWSTR caption)
{
	HGLOBAL hgbl;
	LPDLGTEMPLATE lpdt;
	LPDLGITEMTEMPLATE lpdit;
	LPWORD lpw;
	int n;

	hgbl = GlobalAlloc(GMEM_ZEROINIT, 1024);
	if (!hgbl)
		return NULL;
	lpdt = (LPDLGTEMPLATE)GlobalLock(hgbl);
	lpdt->style = WS_POPUP | WS_BORDER | DS_SETFONT | items[0].style;
	lpdt->cdit = numitems-1;
	lpdt->x = items[0].x;
	lpdt->y = items[0].y;
	lpdt->cx = items[0].w;
	lpdt->cy = items[0].h;
	lpw = (LPWORD)(lpdt+1);
	*lpw++ = 0;
	*lpw++ = 0;
	if (caption) {
		lstrcpyW((LPWSTR)lpw, caption);
		lpw += lstrlenW(caption) + 1;
	} else {
		lstrcpyW((LPWSTR)lpw, items[0].caption);
		lpw += lstrlenW(items[0].caption) + 1;
	}
	*lpw++ = 8;
	lstrcpyW((LPWSTR)lpw, L"MS Shell Dlg");
	lpw += 13;
	for (n = 1; n < numitems; n++) {
		lpw = lpwAlign(lpw);
		lpdit = (LPDLGITEMTEMPLATE)lpw;
		lpdit->x = items[n].x;
		lpdit->y = items[n].y;
		lpdit->cx = items[n].w;
		lpdit->cy = items[n].h;
		lpdit->id = items[n].id;
		lpdit->style = WS_CHILD | WS_VISIBLE | items[n].style;
		lpw = (LPWORD)(lpdit+1);
		if (LOWORD((DWORD)items[n].cls)==0xFFFF) {
			*lpw++ = LOWORD((DWORD)items[n].cls);
			*lpw++ = HIWORD((DWORD)items[n].cls);
		} else {
			lstrcpyW((LPWSTR)lpw, items[n].cls);
			lpw += lstrlenW(items[n].cls) + 1;
		}
		lstrcpyW((LPWSTR)lpw, items[n].caption);
		lpw += lstrlenW(items[n].caption) + 1;
		*lpw++ = 0;
	}
	GlobalUnlock(hgbl);
	return (LPDLGTEMPLATE)hgbl;
}

void DebugEvents(DEBUG_PROC_INFO *procinfo)
{
	DEBUG_EVENT event;
	DWORD status;
	char* ptr;
	WCHAR* wptr;
	SIZE_T len, nbytes;
	SIZE_T wlen, wbytes;

	gIsDebugging = TRUE;
	while(1) {
		if (!WaitForDebugEvent(&event, INFINITE)) {
			gIsDebugging = FALSE;
			return;
		}

		status = DBG_CONTINUE;
		switch (event.dwDebugEventCode) {
		case OUTPUT_DEBUG_STRING_EVENT:
			if (!procinfo->h)
				break;
			len = event.u.DebugString.nDebugStringLength * sizeof(TCHAR);
			ptr = (char*)event.u.DebugString.lpDebugStringData;
			while (len > 0) {
				nbytes = MIN(len,1022);
				if (!ReadProcessMemory(procinfo->h, ptr, procinfo->buf, nbytes, &nbytes))
					break;
				if (event.u.DebugString.fUnicode) {
					wptr = (WCHAR*)procinfo->buf;
					wlen = WideCharToMultiByte(CP_UTF8, 0, wptr, -1, NULL, 0, NULL, NULL);
					while (wlen > 0) {
						wbytes = MIN(wlen,1023);
						wbytes = WideCharToMultiByte(CP_ACP, 0, wptr, -1, procinfo->wbuf, wbytes, NULL, NULL);
						InsertText(procinfo->wbuf, wbytes);
						wlen -= wbytes;
						wptr += MultiByteToWideChar(CP_ACP, 0, procinfo->wbuf, wbytes, NULL, 0);
					}
				} else {
					InsertText(procinfo->buf, nbytes);
				}
				len -= nbytes;
				ptr += nbytes;
			}
			break;
		case EXIT_PROCESS_DEBUG_EVENT:
			gIsDebugging = FALSE;
			return;
		case CREATE_PROCESS_DEBUG_EVENT:
			if (!procinfo->h && event.u.CreateProcessInfo.hProcess)
				procinfo->h = event.u.CreateProcessInfo.hProcess;
			if (event.u.CreateProcessInfo.hFile)
				CloseHandle(event.u.CreateProcessInfo.hFile);
			break;
		case LOAD_DLL_DEBUG_EVENT:
			if (event.u.LoadDll.hFile)
				CloseHandle(event.u.LoadDll.hFile);
			break;
		case CREATE_THREAD_DEBUG_EVENT:
		case EXIT_THREAD_DEBUG_EVENT:
		case UNLOAD_DLL_DEBUG_EVENT:
			break;
		case EXCEPTION_DEBUG_EVENT:
			switch(event.u.Exception.ExceptionRecord.ExceptionCode) {
			case EXCEPTION_BREAKPOINT:
				status = DBG_CONTINUE;
				break;
			case EXCEPTION_ACCESS_VIOLATION:
			case EXCEPTION_DATATYPE_MISALIGNMENT:
			case EXCEPTION_SINGLE_STEP:
			case DBG_CONTROL_C:
			default:
				status = DBG_EXCEPTION_NOT_HANDLED;
				break;
			}
			break;
		}

		ContinueDebugEvent(event.dwProcessId, event.dwThreadId, status);
	}
	gIsDebugging = FALSE;
}

typedef BOOL (WINAPI *DEBUGSETPROCESSKILLONEXITPROC)(BOOL);
DWORD WINAPI DebugProc(DEBUG_PROC_INFO *procinfo)
{
	DEBUGSETPROCESSKILLONEXITPROC pfnDebugSetProcessKillOnExit;
	LPTSTR directory = NULL;
	LPTSTR p;
	DWORD err;
	int n;

	pfnDebugSetProcessKillOnExit = (DEBUGSETPROCESSKILLONEXITPROC)GetProcAddress(GetModuleHandle(TEXT("KERNEL32.DLL")), "DebugSetProcessKillOnExit");

	p = (LPTSTR)procinfo->fn + lstrlen(procinfo->fn) - 1;
	while (p > procinfo->fn && *p != TEXT('\\')) p--;
	if (p > procinfo->fn) {
		n = p - procinfo->fn + 1;
		directory = LocalAlloc(LPTR, (n+1) * sizeof(TCHAR));
		lstrcpyn(directory, procinfo->fn, n);
		directory[n] = TEXT('\0');
	}

	ZeroMemory(&procinfo->pi, sizeof(PROCESS_INFORMATION));
	ZeroMemory(&procinfo->si, sizeof(STARTUPINFO));
	procinfo->si.cb = sizeof(STARTUPINFO);
	procinfo->si.wShowWindow = SW_SHOWDEFAULT;
	if (!CreateProcess(procinfo->fn, procinfo->args, NULL, NULL, TRUE, 
				DEBUG_ONLY_THIS_PROCESS | NORMAL_PRIORITY_CLASS | CREATE_DEFAULT_ERROR_MODE | CREATE_NEW_CONSOLE, NULL,
				directory, &procinfo->si, &procinfo->pi))
	{
		err = GetLastError();
		LocalFree(directory);
		ExitThread(err);
	}
	if (pfnDebugSetProcessKillOnExit)
		pfnDebugSetProcessKillOnExit(FALSE);
	LocalFree(directory);
	CloseHandle(procinfo->pi.hThread);

	procinfo->h = NULL;
	DebugEvents(procinfo);

	CloseHandle(procinfo->pi.hProcess);
	ExitThread(0);
	return 0;
}

BOOL SetSecurity(void)
{
	HANDLE hToken;
	TOKEN_PRIVILEGES *ptp;
	DWORD len;

	OSVERSIONINFO vi;
	vi.dwOSVersionInfoSize = sizeof (OSVERSIONINFO);
	if (!GetVersionEx(&vi) || vi.dwPlatformId != VER_PLATFORM_WIN32_NT)
		return TRUE;

	len = sizeof(DWORD) + sizeof(LUID_AND_ATTRIBUTES);
	ptp = (PTOKEN_PRIVILEGES)LocalAlloc(LPTR, len);
	ptp->PrivilegeCount = 1;
	if (!LookupPrivilegeValue(NULL, SE_DEBUG_NAME, &ptp->Privileges[0].Luid))
	{
		LocalFree(ptp);
		return FALSE;
	}
	ptp->Privileges[0].Attributes |= SE_PRIVILEGE_ENABLED;
	if (!OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES|TOKEN_QUERY, &hToken))
	{
		LocalFree(ptp);
		return FALSE;
	}
	if (!AdjustTokenPrivileges(hToken, FALSE, ptp, 0, NULL, NULL))
	{
		CloseHandle(hToken);
		LocalFree(ptp);
		return FALSE;
	}
	CloseHandle(hToken);
	LocalFree(ptp);
	return TRUE;
}

void StartDebug(LPCTSTR filename, LPCTSTR cmdline)
{
	DEBUG_PROC_INFO *procinfo;
	HANDLE thread;
	DWORD threadid;

	if (!SetSecurity())
		return;

	procinfo = (DEBUG_PROC_INFO*)GlobalAlloc(GPTR, sizeof(DEBUG_PROC_INFO));
	procinfo->fn = filename;
	procinfo->args = (LPTSTR)cmdline;
	thread = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)DebugProc, procinfo, 0, &threadid);
	if (!thread)
	{
		GlobalFree(procinfo);
	}
	else
	{
		CloseHandle(thread);
	}
}

void TimeStamp()
{
	TCHAR buf[1024];
	TCHAR date[260];
	TCHAR ldate[260];
	TCHAR time[260];
	TCHAR name[260];
	SYSTEMTIME current;
	LPCTSTR args[6];
	DWORD len;
	int nch;

	GetLocalTime(&current);
	GetDateFormat(LOCALE_USER_DEFAULT, DATE_SHORTDATE, &current, NULL, date, 260);
	GetDateFormat(LOCALE_USER_DEFAULT, DATE_LONGDATE, &current, NULL, ldate, 260);
	GetTimeFormat(LOCALE_USER_DEFAULT, 0, &current, NULL, time, 260);
	len = 260;
	GetUserName(name, &len);

	args[0] = gOptions->exe;
	args[1] = gOptions->args;
	args[2] = date;
	args[3] = ldate;
	args[4] = time;
	args[5] = name;
	nch = FormatMessage(FORMAT_MESSAGE_FROM_STRING | FORMAT_MESSAGE_ARGUMENT_ARRAY,
				gOptions->stamp, 0, 0, buf, 1023, (va_list*)args);
	InsertText(buf, nch);
	if (buf[nch-1] != TEXT('\n'))
		InsertText("\r\n", 2);
}

void InsertText(char* text, DWORD nch)
{
	static int insert_pos = 0;
	int sel_a, sel_b;
	int len;
	int cont = 0;
	char* ch;

	while (text[nch-1] == '\0') nch--;
	if (text[nch] != '\0') text[nch] = '\0';
	if (text[nch-1] == '\r')
	{
		text[--nch] = '\0';
		ch = strrchr(text, '\n');
		cont = (ch) ? nch - (ch-text) - 1 : nch;
	}
	sel_a = SendMessage(ghText, SCI_GETSELECTIONSTART, 0, 0);
	sel_b = SendMessage(ghText, SCI_GETSELECTIONEND, 0, 0);
	len = SendMessage(ghText, SCI_GETLENGTH, 0, 0);
	SendMessage(ghText, SCI_SETREADONLY, 0, 0);
	if (insert_pos == len)
	{
		SendMessage(ghText, SCI_APPENDTEXT, nch, (LPARAM)text);
	}
	else
	{
		SendMessage(ghText, SCI_SETANCHOR, insert_pos, 0);
		SendMessage(ghText, SCI_SETCURRENTPOS, len, 0);
		SendMessage(ghText, SCI_REPLACESEL, 0, (LPARAM)text);
	}
	SendMessage(ghText, SCI_SETREADONLY, 1, 0);
	insert_pos = SendMessage(ghText, SCI_GETLENGTH, 0, 0) - cont;
	if (sel_a != sel_b)
	{
		SendMessage(ghText, SCI_SETSEL, sel_a, sel_b);
	}
	else
		SendMessage(ghText, SCI_GOTOPOS, insert_pos, 0);
}

OPTIONS* CreateIniStruct(HWND hwnd)
{
	OPTIONS* opts;
	RECT rc;
	BYTE alpha;
	opts = LocalAlloc(LPTR, sizeof(OPTIONS));
	GetWindowRect(hwnd, &rc);
	opts->left = rc.left;
	opts->top = rc.top;
	opts->width = rc.right-rc.left;
	opts->height = rc.bottom-rc.top;
	opts->sticky = 0 != (WS_EX_TOPMOST & GetWindowLong(hwnd, GWL_EXSTYLE));
	if (WS_EX_LAYERED & GetWindowLong(hwnd, GWL_EXSTYLE)) {
		alpha = 255;
		if (pfnGetLayeredWindowAttributes)
			pfnGetLayeredWindowAttributes(hwnd, NULL, &alpha, NULL);
		opts->transparent = 100 - ((alpha * 100) / 255);
	}

	return opts;
}

BOOL ReadIniFile(void)
{
	LPTSTR p;
	int n;
	if (!(gOptions && gOptions->ini))
		return FALSE;
	if (!GetPrivateProfileString(TEXT("mono"), TEXT("exe"), TEXT(""), gOptions->exe, 520, gOptions->ini))
		return FALSE;
	if (!((gOptions->exe[1]==TEXT(':') && gOptions->exe[2]==TEXT('\\')) ||
	      (gOptions->exe[0]==TEXT('\\') && gOptions->exe[1]==TEXT('\\')) ))
	{
		lstrcpy(gOptions->args, gOptions->exe);
		p = (LPTSTR)gOptions->ini + lstrlen(gOptions->ini) - 1;
		while (p > gOptions->ini && *p != TEXT('\\')) p--;
		n = p - gOptions->ini + 1;
		lstrcpyn(gOptions->exe, gOptions->ini, n+1);
		lstrcpy(gOptions->exe+n, gOptions->args);
		gOptions->args[0] = TEXT('\0');
	}
	GetPrivateProfileString(TEXT("mono"), TEXT("args"), TEXT(""), gOptions->args, 520, gOptions->ini);
	GetPrivateProfileString(TEXT("mono"), TEXT("log"), TEXT(""), gOptions->log, 520, gOptions->ini);
	if (!((gOptions->log[1]==TEXT(':') && gOptions->log[2]==TEXT('\\')) ||
	      (gOptions->log[0]==TEXT('\\') && gOptions->log[1]==TEXT('\\')) ))
	{
		lstrcpy(gOptions->stamp, gOptions->log);
		p = (LPTSTR)gOptions->ini + lstrlen(gOptions->ini) - 1;
		while (p > gOptions->ini && *p != TEXT('\\')) p--;
		n = p - gOptions->ini + 1;
		lstrcpyn(gOptions->log, gOptions->ini, n+1);
		lstrcpy(gOptions->log+n, gOptions->stamp);
		gOptions->stamp[0] = TEXT('\0');
	}
	GetPrivateProfileString(TEXT("mono"), TEXT("stamp"), TEXT(""), gOptions->stamp, 520, gOptions->ini);
	gOptions->left = GetPrivateProfileInt(TEXT("window"), TEXT("left"), gOptions->left, gOptions->ini);
	gOptions->top = GetPrivateProfileInt(TEXT("window"), TEXT("top"), gOptions->top, gOptions->ini);
	gOptions->width = GetPrivateProfileInt(TEXT("window"), TEXT("width"), gOptions->width, gOptions->ini);
	gOptions->height = GetPrivateProfileInt(TEXT("window"), TEXT("height"), gOptions->height, gOptions->ini);
	gOptions->sticky = GetPrivateProfileInt(TEXT("window"), TEXT("sticky"), gOptions->sticky, gOptions->ini);
	gOptions->transparent = GetPrivateProfileInt(TEXT("window"), TEXT("transparent"), gOptions->transparent, gOptions->ini);
	return TRUE;
}

void WriteIniFile(BOOL full)
{
	TCHAR num[12];
	struct TextRange range;
	int len;
	DWORD nbytes;
	HANDLE log;
	DWORD pos;
	OSVERSIONINFO vi;
	vi.dwOSVersionInfoSize = sizeof (OSVERSIONINFO);
	if (!GetVersionEx(&vi)) {
		vi.dwMajorVersion = 4;
		vi.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS;
	}

	if (full) {
		WritePrivateProfileString(TEXT("mono"), TEXT("exe"), gOptions->exe, gOptions->ini);
		if (gOptions->args[0]) {
			WritePrivateProfileString(TEXT("mono"), TEXT("args"), gOptions->args, gOptions->ini);
		} else {
			WritePrivateProfileString(TEXT("mono"), TEXT("args"), NULL, gOptions->ini);
		}
		if (gOptions->log[0]) {
			WritePrivateProfileString(TEXT("mono"), TEXT("log"), gOptions->log, gOptions->ini);
		} else {
			WritePrivateProfileString(TEXT("mono"), TEXT("log"), NULL, gOptions->ini);
		}
		if (gOptions->stamp[0]) {
			WritePrivateProfileString(TEXT("mono"), TEXT("stamp"), gOptions->stamp, gOptions->ini);
		} else {
			WritePrivateProfileString(TEXT("mono"), TEXT("stamp"), NULL, gOptions->ini);
		}
	}

	wsprintf(num, TEXT("%d"), gOptions->left);
	WritePrivateProfileString(TEXT("window"), TEXT("left"), num, gOptions->ini);
	wsprintf(num, TEXT("%d"), gOptions->top);
	WritePrivateProfileString(TEXT("window"), TEXT("top"), num, gOptions->ini);
	wsprintf(num, TEXT("%d"), gOptions->width);
	WritePrivateProfileString(TEXT("window"), TEXT("width"), num, gOptions->ini);
	wsprintf(num, TEXT("%d"), gOptions->height);
	WritePrivateProfileString(TEXT("window"), TEXT("height"), num, gOptions->ini);
	wsprintf(num, TEXT("%d"), gOptions->sticky);
	WritePrivateProfileString(TEXT("window"), TEXT("sticky"), num, gOptions->ini);

	if (vi.dwMajorVersion >= 5) {
		wsprintf(num, TEXT("%d"), gOptions->transparent);
		WritePrivateProfileString(TEXT("window"), TEXT("transparent"), num, gOptions->ini);
	}

	if (gOptions->log[0] && ghText)
	{
		len = SendMessage(ghText, SCI_GETLENGTH, 0, 0);
		if (len > 0)
		{
			range.lpstrText = LocalAlloc(LPTR, MIN(len+1,16384));
			if (!range.lpstrText)
				return;
			log = CreateFile(gOptions->log, (vi.dwPlatformId == VER_PLATFORM_WIN32_NT) ? FILE_APPEND_DATA : GENERIC_WRITE,
							FILE_SHARE_READ, NULL,OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
			if (log != INVALID_HANDLE_VALUE)
			{
				range.chrg.cpMin = 0;
				while (len > 0)
				{
					nbytes = MIN(len, 16383);
					range.chrg.cpMax = range.chrg.cpMin + nbytes;
					SendMessage(ghText, SCI_GETTEXTRANGE, 0, (LPARAM)&range);
					pos = SetFilePointer(log, 0, NULL, FILE_END);
					LockFile(log, pos, 0, nbytes, 0);
					WriteFile(log, range.lpstrText, nbytes, &nbytes, NULL);
					UnlockFile(log, pos, 0, nbytes, 0);
					len -= nbytes;
					range.chrg.cpMin += nbytes;
				}
				CloseHandle(log);
			} else {
				ErrorDialog(GetLastError());
			}
			LocalFree(range.lpstrText);
		}
	}
}

BOOL PromptCloseWindow(HWND window)
{
	static const TCHAR _message[] = TEXT(
		"Closing the monolog window will force the connected application to exit as well.\r\n"
		"Do you really want to close the window?");
	OSVERSIONINFO vi;
	vi.dwOSVersionInfoSize = sizeof (OSVERSIONINFO);
	if (GetVersionEx(&vi)
	&& (vi.dwMajorVersion > 5
	 || (vi.dwMajorVersion == 5 && vi.dwMinorVersion >= 1))) {
		return TRUE;
	}

	return IDYES == MessageBox(window, _message, TEXT("Close Window?"), MB_ICONWARNING | MB_YESNO | MB_DEFBUTTON2);
}

struct SLIDER_DIALOG_STRUCT
{
	int transparent;
};

INT_PTR CALLBACK SliderDialogProc(HWND hdlg, UINT msg, WPARAM wParam, LPARAM lParam)
{
	struct SLIDER_DIALOG_STRUCT* init;
	HWND slider;
	if (msg == WM_INITDIALOG) {
		init = (struct SLIDER_DIALOG_STRUCT*)(lParam);
		SetWindowLongPtr(hdlg, DWLP_USER, (LONG_PTR)init);
		slider = GetDlgItem(hdlg, CTL_SLIDER);
		SendMessage(slider, TBM_SETTICFREQ, 10, 0);
		SendMessage(slider, TBM_SETRANGE, FALSE, MAKELPARAM(0, 100));
		SendMessage(slider, TBM_SETPOS, TRUE, init->transparent);
		return TRUE;
	}
	init = (struct SLIDER_DIALOG_STRUCT*)GetWindowLongPtr(hdlg, DWLP_USER);
	switch (msg) {
	case WM_COMMAND:
		switch (LOWORD(wParam)) {
		case IDOK:
			slider = GetDlgItem(hdlg, CTL_SLIDER);
			init->transparent = SendMessage(slider, TBM_GETPOS, 0, 0);
		case IDCANCEL:
			EndDialog(hdlg, wParam);
			return TRUE;
		}
	}
	return FALSE;
}

int TransparentDialog(HWND window)
{
	LPDLGTEMPLATE dlg;
	INT_PTR result;
	struct SLIDER_DIALOG_STRUCT init;
	BYTE alpha;

	if (WS_EX_LAYERED & GetWindowLong(window, GWL_EXSTYLE)) {
		alpha = 255;
		if (pfnGetLayeredWindowAttributes)
			pfnGetLayeredWindowAttributes(window, NULL, &alpha, NULL);
		init.transparent = 100 - ((alpha * 100) / 255);
	} else {
		init.transparent = 0;
	}

	dlg = CreateDialogTemplate(slider_dialog, sizeof(slider_dialog)/sizeof(slider_dialog[0]), NULL);
	if (!dlg) {
		ErrorDialog(GetLastError());
		return FALSE;
	}
	result = DialogBoxIndirectParam(ghInstance, dlg, window, SliderDialogProc, (LPARAM)(&init));
	if (result == -1) {
		ErrorDialog(GetLastError());
	}
	GlobalFree(dlg);
	return (result == IDOK) ? init.transparent : -1;
}

struct STRING_DIALOG_STRUCT
{
	LPTSTR text;
	LPCTSTR caption;
};

INT_PTR CALLBACK StringDialogProc(HWND hdlg, UINT msg, WPARAM wParam, LPARAM lParam)
{
	struct STRING_DIALOG_STRUCT* init;
	if (msg == WM_INITDIALOG) {
		init = (struct STRING_DIALOG_STRUCT*)(lParam);
		SetWindowLongPtr(hdlg, DWLP_USER, (LONG_PTR)init);
		if (init->caption)
			SetDlgItemText(hdlg, CTL_LABEL, init->caption);
		SetDlgItemText(hdlg, CTL_EDIT, init->text);
		return TRUE;
	}
	init = (struct STRING_DIALOG_STRUCT*)GetWindowLongPtr(hdlg, DWLP_USER);
	switch (msg) {
	case WM_COMMAND:
		switch (LOWORD(wParam)) {
		case IDOK:
			GetDlgItemText(hdlg, CTL_EDIT, init->text, 520);
		case IDCANCEL:
			EndDialog(hdlg, wParam);
			return TRUE;
		}
	}
	return FALSE;
}

BOOL StringDialog(HWND parent, LPTSTR text, LPCTSTR caption)
{
	LPDLGTEMPLATE dlg;
	INT_PTR result;
	struct STRING_DIALOG_STRUCT init;
	init.text = text;
	init.caption = caption;
	dlg = CreateDialogTemplate(string_dialog, sizeof(string_dialog)/sizeof(string_dialog[0]), NULL);
	if (!dlg) {
		ErrorDialog(GetLastError());
		return FALSE;
	}
	result = DialogBoxIndirectParam(ghInstance, dlg, parent, StringDialogProc, (LPARAM)(&init));
	if (result == -1) {
		ErrorDialog(GetLastError());
	}
	GlobalFree(dlg);
	return result == IDOK;
}

struct FILENAME_DIALOG_STRUCT
{
	LPTSTR filename;
	int type;
};

INT_PTR CALLBACK FilenameDialogProc(HWND hdlg, UINT msg, WPARAM wParam, LPARAM lParam)
{
	TCHAR text[260];
	LPTSTR name;
	struct FILENAME_DIALOG_STRUCT* init;
	if (msg == WM_INITDIALOG) {
		init = (struct FILENAME_DIALOG_STRUCT*)(lParam);
		SetWindowLongPtr(hdlg, DWLP_USER, (LONG_PTR)init);
		SetDlgItemText(hdlg, CTL_EDIT, init->filename);
		return TRUE;
	}
	init = (struct FILENAME_DIALOG_STRUCT*)GetWindowLongPtr(hdlg, DWLP_USER);
	switch (msg) {
	case WM_COMMAND:
		switch (LOWORD(wParam)) {
		case IDOK:
			GetDlgItemText(hdlg, CTL_EDIT, init->filename, 520);
		case IDCANCEL:
			EndDialog(hdlg, wParam);
			return TRUE;
		case CTL_FILE:
			GetDlgItemText(hdlg, CTL_EDIT, text, 260);
			name = PromptFilename(hdlg, init->type, text);
			if (name) {
				SetDlgItemText(hdlg, CTL_EDIT, name);
				LocalFree(name);
			}
			return TRUE;
		}
	}
	return FALSE;
}

BOOL FilenameDialog(HWND parent, LPTSTR filename, int type)
{
	static LPCWSTR const _types[] = {
		L"", L"Application", L"", L"Log File",
	};
	LPDLGTEMPLATE dlg;
	INT_PTR result;
	struct FILENAME_DIALOG_STRUCT init;
	init.filename = filename;
	init.type = type;
	dlg = CreateDialogTemplate(selectfile_dialog, sizeof(selectfile_dialog)/sizeof(selectfile_dialog[0]), _types[type]);
	if (!dlg) {
		ErrorDialog(GetLastError());
		return FALSE;
	}
	result = DialogBoxIndirectParam(ghInstance, dlg, parent, FilenameDialogProc, (LPARAM)(&init));
	if (result == -1) {
		ErrorDialog(GetLastError());
	}
	GlobalFree(dlg);
	return result == IDOK;
}

LPTSTR PromptFilename(HWND parent, int type, LPCTSTR name)
{
	static LPCTSTR const _types[] = {
		TEXT("Executable Files\0*.EXE\0Configuration Files\0*.INI\0"), TEXT("Select an Application..."),
		TEXT("Executable Files\0*.EXE\0"), TEXT("Select an Application..."),
		TEXT("Configuration Files\0*.INI\0"), TEXT("Save to File..."),
		TEXT("Text Files\0*.TXT;*.LOG\0"), TEXT("Select a File..."),
	};
    OPENFILENAME ofn;
    TCHAR fn[262];
    LPTSTR filename = NULL;
	BOOL result;
	if (name) {
		lstrcpyn(fn, name, 260);
	} else {
	    fn[0] = TEXT('\0');
	}
	type *= 2;
	ZeroMemory(&ofn, sizeof(OPENFILENAME));
    ofn.lStructSize = OPENFILENAME_SIZE_VERSION_400;
    ofn.hwndOwner = parent;
    ofn.lpstrFile = fn;
    ofn.nMaxFile = 260;
    ofn.lpstrFilter = _types[type];
    ofn.nFilterIndex = 1;
    ofn.lpstrTitle = _types[type+1];
	if (type < 4) {
		ofn.Flags = OFN_EXPLORER | OFN_FILEMUSTEXIST | OFN_HIDEREADONLY;
		result = GetOpenFileName(&ofn);
	} else {
		ofn.Flags = OFN_EXPLORER | OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT;
		result = GetSaveFileName(&ofn);
	}
    if (result) {
        filename = LocalAlloc(LPTR, (lstrlen(fn) + 1) * sizeof(TCHAR));
        if (filename)
            lstrcpy(filename, fn);
    }
    return filename;
}

LPTSTR GetFilename(LPCTSTR cmdline)
{
	LPTSTR cmd, end;
	TCHAR key;
	LPTSTR filename = NULL;
	DWORD len;
	if ((cmd = (LPTSTR)cmdline)) {
		if (*cmd == TEXT('\"')) {
			while (*++cmd && *cmd != TEXT('\"')) ;
			if (*cmd) cmd++;
		}
		else
			while (*cmd && *cmd != TEXT(' ')) cmd++;
		if (*cmd) {
			while (*cmd && *cmd == TEXT(' ')) cmd++;
			if (*cmd == TEXT('\"')) {
				key = TEXT('\"');
				cmd++;
			}
			else
				key = TEXT(' ');
			end = cmd;
			while (*end && *end != key) end++;
			if (end > cmd) {
				if (!((cmd[1]==TEXT(':') && cmd[2]==TEXT('\\')) ||
					 (cmd[0]==TEXT('\\') && cmd[1]==TEXT('\\'))))
				{
					len = GetCurrentDirectory(0, NULL);
					filename = LocalAlloc(LPTR, (len + (end-cmd+1)) * sizeof(TCHAR));
					if (filename) {
						len = GetCurrentDirectory(len, filename);
						filename[len++] = TEXT('\\');
						lstrcpyn(filename+len, cmd, end - cmd + 1);
						filename[len+(end-cmd)] = TEXT('\0');
					}
				} else {
					filename = LocalAlloc(LPTR, (end - cmd + 1) * sizeof(TCHAR));
					if (filename) {
						lstrcpyn(filename, cmd, end - cmd + 1);
						filename[end-cmd] = TEXT('\0');
					}
				}
			}
		}
	}
	return filename;
}

BOOL Command(HWND window, HWND text, int id)
{
	LPTSTR filename;
	int transparent;
	switch (id) {
	case CMD_UNDO:
		SendMessage(text, SCI_UNDO, 0, 0);
		return TRUE;
	case CMD_REDO:
		SendMessage(text, SCI_REDO, 0, 0);
		return TRUE;
	case CMD_CUT:
		SendMessage(text, SCI_CUT, 0, 0);
		return TRUE;
	case CMD_COPY:
		SendMessage(text, SCI_COPY, 0, 0);
		return TRUE;
	case CMD_PASTE:
		SendMessage(text, SCI_PASTE, 0, 0);
		return TRUE;
	case CMD_DELETE:
		SendMessage(text, SCI_CLEAR, 0, 0);
		return TRUE;
	case CMD_SELECTALL:
		SendMessage(text, SCI_SELECTALL, 0, 0);
		return TRUE;
	case CMD_EXIT:
		SendMessage(window, WM_CLOSE, 0, 0);
		return TRUE;
	case CMD_SAVE:
		filename = PromptFilename(window, 2, gOptions ? gOptions->ini : NULL);
		if (filename) {
			if (gOptions) {
				LocalFree(gOptions->ini);
			} else {
				gOptions = CreateIniStruct(window);
			}
			gOptions->ini = filename;
			WriteIniFile(TRUE);
		}
		return TRUE;
	case CMD_OPEN:
		if (!gOptions) gOptions = CreateIniStruct(window);
		FilenameDialog(window, gOptions->log, TYPE_LOG);
		return TRUE;
	case CMD_LAUNCH:
		if (!gOptions) gOptions = CreateIniStruct(window);
		FilenameDialog(window, gOptions->exe, TYPE_EXE);
		return TRUE;
	case CMD_TEXT:
		if (!gOptions) gOptions = CreateIniStruct(window);
		StringDialog(window, gOptions->stamp, NULL);
		return TRUE;
	case CMD_TOPWIN:
		SetWindowTopmost(window, 0==(WS_EX_TOPMOST & GetWindowLong(window, GWL_EXSTYLE)));
		//SetWindowTopmost(window, 0==(MF_CHECKED & GetMenuState(ghMenu, CMD_TOPWIN, MF_BYCOMMAND)));
		return TRUE;
	case CMD_TRANSWIN:
		transparent = TransparentDialog(window);
		if (transparent >= 0)
			SetWindowTransparent(window, transparent);
		break;
	}
	return FALSE;
}

void SetDefaults(HWND text, LPRECT rc)
{
	static const char* _line = "_";
	char codepage[10];
	if (GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_IDEFAULTANSICODEPAGE, codepage, sizeof(codepage)))
		SendMessage(text, SCI_SETCODEPAGE, atoi(codepage), 0);
	else
		SendMessage(text, SCI_SETCODEPAGE, 0, 0);
	SendMessage(text, SCI_SETSELFORE, 1, (LPARAM)(GetSysColor(COLOR_HIGHLIGHTTEXT)));
	SendMessage(text, SCI_SETSELBACK, 1, (LPARAM)(GetSysColor(COLOR_HIGHLIGHT)));
	SendMessage(text, SCI_STYLESETFONT, STYLE_DEFAULT, (LPARAM)("Courier New"));
	SendMessage(text, SCI_STYLESETSIZE, STYLE_DEFAULT, 10);
	SendMessage(text, SCI_SETWRAPMODE, SC_WRAP_WORD, 0);
	SendMessage(text, SCI_SETMARGINWIDTHN, 0, 0);
	SendMessage(text, SCI_SETMARGINWIDTHN, 1, 0);
	SendMessage(text, SCI_SETMARGINWIDTHN, 2, 0);
	SendMessage(text, SCI_SETYCARETPOLICY, CARET_EVEN, 0);
	SendMessage(text, SCI_SETVSCROLLBAR, SC_SCROLL_ALWAYS, 0);
	SendMessage(text, SCI_SETREADONLY, 1, 0);

	rc->left = rc->top = 0;
	rc->right = 80 * SendMessage(text, SCI_TEXTWIDTH, 0, (LPARAM)_line);
	rc->right += SendMessage(text, SCI_GETMARGINLEFT, 0, 0) + SendMessage(text, SCI_GETMARGINRIGHT, 0, 0);
	rc->bottom = 25 * SendMessage(text, SCI_TEXTHEIGHT, 0, 0);
}

HWND CreateText(HWND parent)
{
	HWND text;
	RECT winrc;
	GetClientRect(ghWnd, &winrc);
	text = CreateWindowEx(WS_EX_NOPARENTNOTIFY, TEXT("Scintilla"), TEXT(""),
				WS_CHILD|WS_BORDER|WS_VISIBLE, 0, 0, 
				winrc.right, winrc.bottom, 
				parent, NULL, ghInstance, NULL);
	return text;
}

BOOL SetWindowTopmost(HWND hwnd, BOOL topmost)
{
	if (!SetWindowPos(hwnd, topmost ? HWND_TOPMOST : HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE|SWP_NOSIZE|SWP_NOACTIVATE))
		return FALSE;
	CheckMenuItem(ghMenu, CMD_TOPWIN, MF_BYCOMMAND | (topmost ? MF_CHECKED : MF_UNCHECKED));
	if (gOptions) gOptions->sticky = topmost;
	return TRUE;
}

BOOL SetWindowTransparent(HWND hwnd, int transparent)
{
	double alpha = (double)(100 - transparent) / 100.0;
	OSVERSIONINFO vi;
	vi.dwOSVersionInfoSize = sizeof (OSVERSIONINFO);
	if (!GetVersionEx(&vi) || vi.dwMajorVersion < 5) {
		return FALSE;
	}

	if (transparent == 0) {
		SetWindowLong(hwnd, GWL_EXSTYLE, GetWindowLong(hwnd, GWL_EXSTYLE) & ~WS_EX_LAYERED);
		RedrawWindow(hwnd, NULL, NULL, RDW_ERASE | RDW_INVALIDATE | RDW_FRAME | RDW_ALLCHILDREN);
		CheckMenuItem(ghMenu, CMD_TRANSWIN, MF_BYCOMMAND | MF_UNCHECKED);
		if (gOptions) gOptions->transparent = 0;
		return TRUE;
	}

	if (pfnSetLayeredWindowAttributes) {
		SetWindowLong(hwnd, GWL_EXSTYLE, GetWindowLong(hwnd, GWL_EXSTYLE) | WS_EX_LAYERED);
		pfnSetLayeredWindowAttributes(hwnd, 0, (int)(alpha * 255), LWA_ALPHA);
	}
	CheckMenuItem(ghMenu, CMD_TRANSWIN, MF_BYCOMMAND | MF_CHECKED);
	if (gOptions) gOptions->transparent = transparent;
	return TRUE;
}

/*
Mono
 Save Configuration...
 --
 Application...
 Log File...
 Header...
 --
 Exit
Edit
 Copy
 Select All
Window
 Always on Top
 Transparency...
 */
HMENU CreateMenus(void)
{
	OSVERSIONINFO vi;
	HMENU menubar, submenu;
	MENUITEMINFO info;
	int count, subcount;

	ZeroMemory(&info, sizeof(MENUITEMINFO));
	info.cbSize = sizeof(MENUITEMINFO);

	count = 0;
	menubar = CreateMenu();
	if (!menubar)
		return NULL;

	subcount = 0;
	submenu = CreatePopupMenu();
	if (!submenu) {
		DestroyMenu(menubar);
		return NULL;
	}
	info.fMask = MIIM_ID | MIIM_STATE | MIIM_TYPE | MIIM_DATA;
	info.fType = MFT_STRING;
	info.fState = MFS_ENABLED;
	info.wID = CMD_SAVE;
	info.dwTypeData = TEXT("&Save Configuration...");
		InsertMenuItem(submenu, subcount++, TRUE, &info);
	info.fMask = MIIM_STATE | MIIM_TYPE;
	info.fType = MFT_SEPARATOR;
	info.fState = MFS_DISABLED;
		InsertMenuItem(submenu, subcount++, TRUE, &info);
	info.fMask = MIIM_ID | MIIM_STATE | MIIM_TYPE | MIIM_DATA;
	info.fType = MFT_STRING;
	info.fState = MFS_ENABLED;
	info.wID = CMD_LAUNCH;
	info.dwTypeData = TEXT("&Application...");
		InsertMenuItem(submenu, subcount++, TRUE, &info);
	info.fMask = MIIM_ID | MIIM_STATE | MIIM_TYPE | MIIM_DATA;
	info.fType = MFT_STRING;
	info.fState = MFS_ENABLED;
	info.wID = CMD_OPEN;
	info.dwTypeData = TEXT("&Log File...");
		InsertMenuItem(submenu, subcount++, TRUE, &info);
	info.fMask = MIIM_ID | MIIM_STATE | MIIM_TYPE | MIIM_DATA;
	info.fType = MFT_STRING;
	info.fState = MFS_ENABLED;
	info.wID = CMD_TEXT;
	info.dwTypeData = TEXT("&Header...");
		InsertMenuItem(submenu, subcount++, TRUE, &info);
	info.fMask = MIIM_STATE | MIIM_TYPE;
	info.fType = MFT_SEPARATOR;
	info.fState = MFS_DISABLED;
		InsertMenuItem(submenu, subcount++, TRUE, &info);
	info.fMask = MIIM_ID | MIIM_STATE | MIIM_TYPE | MIIM_DATA;
	info.fType = MFT_STRING;
	info.fState = MFS_ENABLED;
	info.wID = CMD_EXIT;
	info.dwTypeData = TEXT("E&xit");
		InsertMenuItem(submenu, subcount++, TRUE, &info);
	info.fMask = MIIM_STATE | MIIM_TYPE | MIIM_DATA | MIIM_SUBMENU;
	info.fType = MFT_STRING;
	info.fState = MFS_ENABLED;
	info.hSubMenu = submenu;
	info.dwTypeData = TEXT("&Mono");
		InsertMenuItem(menubar, count++, TRUE, &info);

	subcount = 0;
	submenu = CreatePopupMenu();
	if (!submenu) {
		DestroyMenu(menubar);
		return NULL;
	}
	info.fMask = MIIM_ID | MIIM_STATE | MIIM_TYPE | MIIM_DATA;
	info.fType = MFT_STRING;
	info.fState = MFS_ENABLED;
	info.wID = CMD_COPY;
	info.dwTypeData = TEXT("&Copy");
		InsertMenuItem(submenu, subcount++, TRUE, &info);
	info.fMask = MIIM_ID | MIIM_STATE | MIIM_TYPE | MIIM_DATA;
	info.fType = MFT_STRING;
	info.fState = MFS_ENABLED;
	info.wID = CMD_SELECTALL;
	info.dwTypeData = TEXT("Select &All");
		InsertMenuItem(submenu, subcount++, TRUE, &info);
	info.fMask = MIIM_STATE | MIIM_TYPE | MIIM_DATA | MIIM_SUBMENU;
	info.fType = MFT_STRING;
	info.fState = MFS_ENABLED;
	info.hSubMenu = submenu;
	info.dwTypeData = TEXT("&Edit");
		InsertMenuItem(menubar, count++, TRUE, &info);

	subcount = 0;
	submenu = CreatePopupMenu();
	if (!submenu) {
		DestroyMenu(menubar);
		return NULL;
	}
	info.fMask = MIIM_ID | MIIM_STATE | MIIM_TYPE | MIIM_DATA;
	info.fType = MFT_STRING;
	info.fState = MFS_ENABLED | MFS_UNCHECKED;
	info.wID = CMD_TOPWIN;
	info.dwTypeData = TEXT("&Always on Top");
		InsertMenuItem(submenu, subcount++, TRUE, &info);
	info.fMask = MIIM_ID | MIIM_STATE | MIIM_TYPE | MIIM_DATA;
	info.fType = MFT_STRING;
	info.fState = MFS_ENABLED | MFS_UNCHECKED;
	info.wID = CMD_TRANSWIN;
	info.dwTypeData = TEXT("&Transparency...");
	vi.dwOSVersionInfoSize = sizeof (OSVERSIONINFO);
	if (!GetVersionEx(&vi) || vi.dwMajorVersion < 5) {
		info.fState = MFS_DISABLED;
	}
		InsertMenuItem(submenu, subcount++, TRUE, &info);
	info.fMask = MIIM_STATE | MIIM_TYPE | MIIM_DATA | MIIM_SUBMENU;
	info.fType = MFT_STRING;
	info.fState = MFS_ENABLED;
	info.hSubMenu = submenu;
	info.dwTypeData = TEXT("&Window");
		InsertMenuItem(menubar, count++, TRUE, &info);

	return menubar;
}

TCHAR szWinName[] = TEXT("MonoWin");

int RegisterClasses(HINSTANCE hInstance)
{
	WNDCLASS wcl;

	INITCOMMONCONTROLSEX icc;
	icc.dwSize = sizeof(INITCOMMONCONTROLSEX);
	icc.dwICC = ICC_BAR_CLASSES;
	InitCommonControlsEx(&icc);

	wcl.hInstance = hInstance;
	wcl.lpszClassName = szWinName;
	wcl.lpfnWndProc = WindowFunc;
	wcl.style = 0;
	wcl.hIcon = LoadIcon(NULL, IDI_APPLICATION);
	wcl.hCursor = LoadCursor(NULL, IDC_ARROW);
	wcl.lpszMenuName = NULL;
	wcl.cbClsExtra = 0;
	wcl.cbWndExtra = 0;
	wcl.hbrBackground = (HBRUSH)(COLOR_APPWORKSPACE+1);

	if (!RegisterClass(&wcl)) return -1;
	return 0;
}

LRESULT CALLBACK WindowFunc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	RECT rc;
	switch(msg) {
	case WM_CREATE:
		break;
	case WM_CLOSE:
		if (!gIsDebugging || PromptCloseWindow(hwnd)) {
			if (gOptions) {
				GetWindowRect(hwnd, &rc);
				gOptions->left = rc.left;
				gOptions->top = rc.top;
				gOptions->width = rc.right-rc.left;
				gOptions->height = rc.bottom-rc.top;
				WriteIniFile(FALSE);
			}
			DestroyWindow(hwnd);
		}
		break;
	case WM_DESTROY:
		PostQuitMessage(0);
		break;
	case WM_SIZE:
		MoveWindow(ghText, 0, 0, LOWORD(lParam), HIWORD(lParam), FALSE);
		/*SendMessage(ghText, WM_SIZE, wParam, lParam);*/
		break;
	case WM_KILLFOCUS:
		SendMessage(ghText, SCI_SETFOCUS, 0, 0);
		break;
	case WM_SETFOCUS:
		SendMessage(ghText, SCI_SETFOCUS, 1, 0);
		break;
	case WM_COMMAND:
		if (!Command(ghWnd, ghText, LOWORD(wParam)))
			return DefWindowProc(hwnd, msg, wParam, lParam);
		break;
	case WM_KEYDOWN:
	case WM_SYSKEYDOWN:
	case WM_CHAR:
	case WM_IME_CHAR:
	case WM_IME_KEYDOWN:
	case WM_MOUSEWHEEL:
		return SendMessage(ghText, msg, wParam, lParam);
	default:
		return DefWindowProc(hwnd, msg, wParam, lParam);
	}
	return 0;
}

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd)
{
	int ret;
	MSG msg;
	RECT rc;
	HMODULE hmod = NULL;
	HACCEL acceltable = NULL;
	HINSTANCE hSciLib = NULL;
	LPTSTR filename = NULL;
	LPTSTR cmdline = NULL;
	int n;

	ghInstance = hInstance;

	hmod = GetModuleHandle(TEXT("USER32.DLL"));
	pfnSetLayeredWindowAttributes = (SETLAYEREDWINDOWATTRIBUTES)GetProcAddress(hmod, "SetLayeredWindowAttributes");
	pfnGetLayeredWindowAttributes = (GETLAYEREDWINDOWATTRIBUTES)GetProcAddress(hmod, "GetLayeredWindowAttributes");

	if (RegisterClasses(hInstance))
		return 0;

	ghMenu = CreateMenus();
	ghWnd = CreateWindowEx(WS_EX_APPWINDOW, szWinName, TEXT("Monolog"), WS_OVERLAPPEDWINDOW, 
						 CW_USEDEFAULT,CW_USEDEFAULT,CW_USEDEFAULT,CW_USEDEFAULT,
						 NULL, ghMenu, hInstance, NULL);
	if (!ghWnd) {
		DestroyMenu(ghMenu);
		return -1;
	}

	hSciLib = LoadLibrary(TEXT("Scintilla.DLL"));
	if (!hSciLib) {
		MessageBox(ghWnd, TEXT("The Scintilla Library could not be loaded."),
				   TEXT("Library Error"), MB_OK | MB_ICONERROR);
		DestroyWindow(ghWnd);
		return -1;
	}

	ghText = CreateText(ghWnd);
	if (!ghText) {
		DestroyWindow(ghWnd);
		FreeLibrary(hSciLib);
		return -1;
	}
	SetDefaults(ghText, &rc);
	AdjustWindowRectEx(&rc, WS_OVERLAPPEDWINDOW, FALSE, WS_EX_APPWINDOW);
	SetWindowPos(ghWnd, NULL, 0, 0, rc.right-rc.left, rc.bottom-rc.top, SWP_NOACTIVATE | SWP_NOMOVE | SWP_NOZORDER);

	filename = GetFilename(GetCommandLine());
	if (!filename) {
		filename = PromptFilename(ghWnd, 0, NULL);
	}
	if (filename) {
		gOptions = CreateIniStruct(ghWnd);
		if (0 == lstrcmpi(filename+lstrlen(filename)-4, ".ini")) {
			gOptions->ini = filename;
			filename = NULL;
			if (ReadIniFile()) {
				SetWindowPos(ghWnd, NULL, gOptions->left, gOptions->top, gOptions->width, gOptions->height, SWP_NOACTIVATE | SWP_NOZORDER);
				if (gOptions->stamp[0])
					TimeStamp();
				if (gOptions->args[0]) {
					n = lstrlen(gOptions->exe);
					cmdline = LocalAlloc(LPTR, n+lstrlen(gOptions->args)+4);
					if (strchr(gOptions->exe, ' ') != NULL) {
						cmdline[0] = TEXT('\"');
						lstrcpy(cmdline+1, gOptions->exe);
						cmdline[n+1] = TEXT('\"');
						n += 2;
					} else {
						lstrcpy(cmdline, gOptions->exe);
					}
					cmdline[n] = TEXT(' ');
					lstrcpy(cmdline+n+1, gOptions->args);
				}
				StartDebug(gOptions->exe, cmdline);
			} else {
				PostQuitMessage(1);
			}
		} else {
			lstrcpyn(gOptions->exe, filename, 520);
			StartDebug(filename, NULL);
		}
	} else {
		PostQuitMessage(1);
	}

	if (gOptions) {
		if (gOptions->transparent)
			SetWindowTransparent(ghWnd, gOptions->transparent);
		if (gOptions->sticky)
			SetWindowTopmost(ghWnd, TRUE);
	}
	
	ShowWindow(ghWnd, nShowCmd);
	UpdateWindow(ghWnd);
	while (1) {
		ret = GetMessage(&msg, NULL, 0, 0);
		if (ret == 0 || ret == -1)
			break;
		if (acceltable != NULL) {
			if (TranslateAccelerator(ghWnd, acceltable, &msg) || 
				TranslateAccelerator(ghText, acceltable, &msg))
				continue;
		}
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}

	if (cmdline)
		LocalFree(cmdline);
	if (gOptions) {
		if (gOptions->ini)
			LocalFree(gOptions->ini);
		LocalFree(gOptions);
	}
	if (filename)
		LocalFree(filename);
	FreeLibrary(hSciLib);
	if (acceltable)
		DestroyAcceleratorTable(acceltable);

	return msg.wParam;
}

