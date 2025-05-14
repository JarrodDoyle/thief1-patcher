/******************************************************************************
 *    exec.c
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
#define _WIN32_IE	0x0400

#include <windows.h>
#include <shellapi.h>
#include <shlwapi.h>
#include "brightui.h"

#define BUFSIZE 32

BOOL IsWinNT(void);
LPTSTR CreateTemporaryDirectories(void);
void DestroyTemporaryDirectories(LPTSTR temp);
DWORD ReallyRun(LPCTSTR exe, LPTSTR cmds, LPCTSTR cwd);
DWORD ExecuteBright(HWND parent, LPCTSTR cmds, LPCTSTR destdir, LPCTSTR prefix, HWND lb, BOOL individual);
void OpenManual(HWND parent);


BOOL IsWinNT(void)
{
	OSVERSIONINFO vi;
	vi.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
	if (! GetVersionEx(&vi))
		return FALSE;
	return vi.dwPlatformId == VER_PLATFORM_WIN32_NT;
}

LPTSTR CreateTemporaryDirectories(void)
{
	LPTSTR temp, mytemp;
	DWORD len, dlen;
	TCHAR uid[MAX_PATH];
	TCHAR domain[MAX_PATH];
	SECURITY_ATTRIBUTES sa;
	SECURITY_DESCRIPTOR sd;
	LPSECURITY_ATTRIBUTES psa;
	PACL dacl;
	PSID psid;
	SID_NAME_USE usage;

	len = GetTempPath(0, NULL);
	temp = LocalAlloc(LPTR, len * sizeof(TCHAR));
	if (!temp)
		return NULL;
	if (!GetTempPath(len, temp))
	{
		len = GetLastError();
		LocalFree(temp);
		SetLastError(len);
		return NULL;
	}
	len = lstrlen(temp) + 20;
	mytemp = LocalAlloc(LPTR, len * sizeof(TCHAR));
	if (!mytemp)
	{
		len = GetLastError();
		LocalFree(temp);
		SetLastError(len);
		return NULL;
	}
	if (!GetTempFileName(temp, TEXT("BRIGHT"), 0, mytemp))
	{
		len = GetLastError();
		LocalFree(mytemp);
		LocalFree(temp);
		SetLastError(len);
		return NULL;
	}
	LocalFree(temp);

	if (IsWinNT())
	{
		len = MAX_PATH;
		GetUserName(uid, &len);
		len = 0;
		dlen = MAX_PATH;
		LookupAccountName(NULL, uid, NULL, &len, domain, &dlen, &usage);
		psid = LocalAlloc(LPTR, len);
		dlen = MAX_PATH;
		LookupAccountName(NULL, uid, psid, &len, domain, &dlen, &usage);
		if (usage != SidTypeUser)
		{
			len = GetLastError();
			LocalFree(psid);
			LocalFree(mytemp);
			SetLastError(len);
			return NULL;
		}
		len = sizeof(ACL) + sizeof(ACCESS_ALLOWED_ACE) + GetLengthSid(psid) - sizeof(DWORD);
		dacl = LocalAlloc(LPTR, len);
		InitializeAcl(dacl, len, ACL_REVISION);
		AddAccessAllowedAce(dacl, ACL_REVISION, GENERIC_ALL | STANDARD_RIGHTS_ALL, psid);
		InitializeSecurityDescriptor(&sd, SECURITY_DESCRIPTOR_REVISION);
		SetSecurityDescriptorOwner(&sd, psid, FALSE);
		SetSecurityDescriptorDacl(&sd, TRUE, dacl, FALSE);
		sa.nLength = sizeof(sa);
		sa.lpSecurityDescriptor = &sd;
		sa.bInheritHandle = TRUE;
		psa = &sa;
	}
	else
	{
		psa = NULL;
		dacl = NULL;
		psid = NULL;
	}
	if (!DeleteFile(mytemp))
	{
		len = GetLastError();
		if (dacl)
			LocalFree(dacl);
		if (psid)
			LocalFree(psid);
		LocalFree(mytemp);
		SetLastError(len);
		return NULL;
	}
	if (!CreateDirectory(mytemp, &sa))
	{
		len = GetLastError();
		if (dacl)
			LocalFree(dacl);
		if (psid)
			LocalFree(psid);
		LocalFree(mytemp);
		SetLastError(len);
		return NULL;
	}
	temp = LocalAlloc(LPTR, (lstrlen(mytemp) + 5) * sizeof(TCHAR));
	PathCombine(temp, mytemp, TEXT("out"));
	if (!CreateDirectory(temp, &sa))
	{
		len = GetLastError();
		if (dacl)
			LocalFree(dacl);
		if (psid)
			LocalFree(psid);
		LocalFree(temp);
		LocalFree(mytemp);
		SetLastError(len);
		return NULL;
	}

	LocalFree(temp);
	if (dacl)
		LocalFree(dacl);
	if (psid)
		LocalFree(psid);
	return mytemp;
}

void DestroyTemporaryDirectories(LPTSTR temp)
{
	SHFILEOPSTRUCT fop;
	fop.hwnd = NULL;
	fop.wFunc = FO_DELETE;
	fop.fFlags = FOF_SILENT | FOF_NOCONFIRMATION | FOF_NOERRORUI;
	fop.pFrom = temp;
	fop.pTo = NULL;
	SHFileOperation(&fop);
	LocalFree(temp);
}

static DWORD CopyToTemp(HWND parent, LPCTSTR temp, LPCTSTR files)
{
	SHFILEOPSTRUCT fop;
	DWORD err = 0;
	fop.hwnd = parent;
	fop.wFunc = FO_COPY;
	fop.fFlags = FOF_FILESONLY;
	fop.pTo = temp;
	fop.pFrom = files;
	err = SHFileOperation(&fop);
	return err;
}

static DWORD MoveFromTemp(HWND parent, LPCTSTR temp, LPCTSTR dest)
{
	SHFILEOPSTRUCT fop;
	LPTSTR outdir, destdir;
	DWORD err;
	outdir = LocalAlloc(LPTR, (lstrlen(temp) + 12) * sizeof(TCHAR));
	if (!outdir)
	{
		return GetLastError();
	}
	destdir = LocalAlloc(LPTR, (lstrlen(dest) + 2) * sizeof(TCHAR));
	if (!destdir)
	{
		err = GetLastError();
		LocalFree(outdir);
		return err;
	}
	PathCombine(outdir, temp, TEXT("out\\*.*"));
	lstrcpy(destdir, dest);
	fop.hwnd = parent;
	fop.wFunc = FO_MOVE;
	fop.fFlags = FOF_FILESONLY;
	fop.pFrom = outdir;
	fop.pTo = destdir;
	err = SHFileOperation(&fop);
	LocalFree(destdir);
	LocalFree(outdir);
	return err;
}

DWORD ExecuteBright(HWND parent, LPCTSTR cmds, LPCTSTR destdir, LPCTSTR prefix, HWND lb, BOOL individual)
{
	TCHAR bright[260];
	LPTSTR file, allfiles, c;
	LPTSTR tempdir;
	LPTSTR args;
	DWORD err;
	int n, len, space;
	
	/* Find executable file */
	err = (DWORD)FindExecutable(TEXT("bright.exe"), NULL, bright);
	if (err <= 32)
		return err;

	/* Create temporary directories */
	tempdir = CreateTemporaryDirectories();
	if (!tempdir)
		return GetLastError();

	/* Copy files listed in lb to tempdir */
	len = 4096;
	space = 4095;
	allfiles = LocalAlloc(LPTR, len);
	if (!allfiles)
	{
		err = GetLastError();
		DestroyTemporaryDirectories(tempdir);
		return err;
	}
	c = allfiles;
	n = SendMessage(lb, LB_GETCOUNT, 0, 0);
	while (n--)
	{
		file = (LPTSTR)SendMessage(lb, LB_GETITEMDATA, n, 0);
		if (file)
		{
			if (space < lstrlen(file) + 1)
			{
				err = c - allfiles;
				len = (len + lstrlen(file) + 0x100) & 0xFF;
				allfiles = LocalReAlloc(allfiles, len, LMEM_MOVEABLE);
				if (!allfiles)
				{
					err = GetLastError();
					DestroyTemporaryDirectories(tempdir);
					return err;
				}
				c = allfiles + err;
			}
			lstrcpy(c, file);
			c += lstrlen(file) + 1; *c = TEXT('\0');
			space -= lstrlen(file) + 1;
		}
	}
	err = CopyToTemp(parent, tempdir, allfiles);
	LocalFree(allfiles);
	if (err)
	{
		DestroyTemporaryDirectories(tempdir);
		return err;
	}

	/* Working directory is handled by CreateProcess */

	/* Execute bright */
	if (individual)
	{
		n = SendMessage(lb, LB_GETCOUNT, 0, 0);
		while (n--)
		{
			file = (LPTSTR)SendMessage(lb, LB_GETITEMDATA, n, 0);
			if (file && (file = PathFindFileName(file)))
			{
				/* bright cmds file out\prefix */
				args = LocalAlloc(LPTR, (lstrlen(cmds) + (lstrlen(file) * 2) + lstrlen(prefix) + 8) * sizeof(TCHAR));
				if (args)
				{
					lstrcpy(args, cmds);
					lstrcat(args, TEXT(" \""));
					lstrcat(args, file);
					lstrcat(args, TEXT("\" out\\"));
					lstrcat(args, prefix);
					lstrcat(args, file);
					err = ReallyRun(bright, args, tempdir);
					LocalFree(args);
					if (err)
						break;
				}
			}
		}
	}
	else
	{
		/* bright cmds * out\prefix */
		args = LocalAlloc(LPTR, (lstrlen(cmds) + lstrlen(prefix) + 8) * sizeof(TCHAR));
		if (args)
		{
			lstrcpy(args, cmds);
			lstrcat(args, TEXT(" * out\\"));
			lstrcat(args, prefix);
			err = ReallyRun(bright, args, tempdir);
			LocalFree(args);
		}
	}

	/* Move files from tempdir/out to destdir */
	if (err)
		MoveFromTemp(parent, tempdir, destdir);
	else
		err = MoveFromTemp(parent, tempdir, destdir);

	/* Delete files in tempdir */
	DestroyTemporaryDirectories(tempdir);

	return err;
}

DWORD ReallyRun(LPCTSTR exe, LPTSTR cmds, LPCTSTR cwd)
{
	LPTSTR argv;
	HANDLE savedout, savederr, childread, childwrite;
	SECURITY_ATTRIBUTES sa;
	STARTUPINFO si;
	PROCESS_INFORMATION pi;
	CHAR buf[BUFSIZE];
#if UNICODE
	WCHAR wbuf[BUFSIZE*2];
#endif
	DWORD bytes;
	int err = 0;

	sa.nLength = sizeof(sa);
	sa.bInheritHandle = TRUE;
	sa.lpSecurityDescriptor = NULL;

	ZeroMemory(&si, sizeof(si));
	ZeroMemory(&pi, sizeof(pi));
	si.cb = sizeof(si);
	si.dwFlags = STARTF_USESTDHANDLES | STARTF_USESHOWWINDOW;
	si.wShowWindow = SW_HIDE;

	/*
	savedout = GetStdHandle(STD_OUTPUT_HANDLE);
	savederr = GetStdHandle(STD_ERROR_HANDLE);
	*/
	if (!CreatePipe(&childread, &childwrite, &sa, 0))
		return GetLastError();
	/*
	if (!SetStdHandle(STD_OUTPUT_HANDLE, childwrite))
	{
		err = GetLastError();
		CloseHandle(childread);
		CloseHandle(childwrite);
	}
	if (!SetStdHandle(STD_ERROR_HANDLE, childwrite))
	{
		err = GetLastError();
		SetStdHandle(STD_OUTPUT_HANDLE, savedout);
		CloseHandle(childread);
		CloseHandle(childwrite);
	}
	*/

	si.hStdOutput = childwrite;
	si.hStdError = childwrite;

	argv = LocalAlloc(LPTR, (lstrlen(exe) + lstrlen(cmds) + 2) * sizeof(TCHAR));
	if (!argv)
	{
		err = GetLastError();
		CloseHandle(childread);
		CloseHandle(childwrite);
		return err;
	}
	lstrcpy(argv, exe);
	lstrcat(argv, TEXT(" "));
	lstrcat(argv, cmds);
	if (!CreateProcess(exe, argv, NULL, NULL, TRUE, 0, NULL, cwd, &si, &pi))
	{
		err = GetLastError();
		/*
		SetStdHandle(STD_OUTPUT_HANDLE, savedout);
		SetStdHandle(STD_ERROR_HANDLE, savederr);
		*/
		CloseHandle(childread);
		CloseHandle(childwrite);
		LocalFree(argv);
		return err;
	}
	CloseHandle(pi.hThread);
	LocalFree(argv);

	/*
	SetStdHandle(STD_OUTPUT_HANDLE, savedout);
	SetStdHandle(STD_ERROR_HANDLE, savederr);
	*/
	CloseHandle(childwrite);

	while (TRUE)
	{
		if (!ReadFile(childread, buf, BUFSIZE, &bytes, NULL) || bytes == 0)
			break;
		buf[bytes] = '\0';
#if UNICODE
		if ((err = MultiByteToWideChar(CP_OEMCP, MB_PRECOMPOSED, buf, bytes, wbuf, BUFSIZE*2)))
		{
			wbuf[err] = 0;
			OutputText(wbuf);
		}
#else
		OutputText(buf);
#endif
	}

	CloseHandle(childread);

	/* bright doesn't give meaningful error codes anyway
	if ((err = WaitForSingleObject(pi.hProcess, 15000)) == WAIT_OBJECT_0)
		GetExitCodeProcess(pi.hProcess, &err);
	*/
	err = 0;
	CloseHandle(pi.hProcess);

	return err;
}


void OpenManual(HWND parent)
{
	WIN32_FIND_DATA fd;
	HANDLE fh;
	LPCTSTR file = TEXT("BrightUI.txt");
	if (!PathFileExists(file))
	{
		file = TEXT("Bright.txt");
		if (!PathFileExists(file))
		{
			file = TEXT("Bright183Public.txt");
			if (!PathFileExists(file))
			{
				fh = FindFirstFile(TEXT("*.txt"), &fd);
				if (fh == INVALID_HANDLE_VALUE)
					return;
				FindClose(fh);
				file = fd.cFileName;
			}
		}
	}
	ShellExecute(parent, NULL, file, NULL, NULL, SW_SHOWNORMAL);
}

