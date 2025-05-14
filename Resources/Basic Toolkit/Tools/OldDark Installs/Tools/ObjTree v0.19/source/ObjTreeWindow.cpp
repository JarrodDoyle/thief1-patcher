#include "objtree.h"
#include "ObjTreeWindow.h"
#include "ObjTreeDialogs.h"
#include "ObjWindow.h"
#include "DarkSources.h"

#include <stdexcept>
#include <fstream>
#include <algorithm>

#include <iostream>

#include "DarkLib/ncstr_functions.h"
#ifdef UNICODE
#define nctstr_equal	ncwstr_equal
#else
#define nctstr_equal	ncstr_equal
#endif

#include "DarkLib/DarkIterators.h"
#include "dbtools.h"
#include "resources.h"

#ifndef TreeView_GetLastVisible
#define TreeView_GetLastVisible(hwnd)	\
	TreeView_GetNextItem(hwnd, NULL, TVGN_LASTVISIBLE)
#endif

#define ID_DRAGOBJECTTIMER (ID_APPMAIN+1)


using namespace Dark;
using namespace std;
using __std::nctstr_equal;

static void InsertRecentFile(HMENU menu, _tstring* fname, int pos, int id);

const LPCTSTR ObjTreeMain::szClassName = TEXT("ObjTree");

_tstring ObjTreeMain::strWindowName;

BOOL ObjTreeMain::RegisterClass(HINSTANCE inst)
{
	WNDCLASS wcl;

	wcl.hInstance = inst;
	wcl.lpszClassName = szClassName;
	wcl.lpfnWndProc = WindowProc;
	wcl.style = 0;
	wcl.hIcon = LoadIcon(inst, MAKEINTRESOURCE(1));
	wcl.hCursor = LoadCursor(NULL, IDC_ARROW);
	wcl.lpszMenuName = NULL;
	wcl.cbClsExtra = 0;
	wcl.cbWndExtra = 0;
	wcl.hbrBackground = (HBRUSH)(COLOR_APPWORKSPACE+1);
	return ::RegisterClass(&wcl);
}

ObjTreeMain::~ObjTreeMain()
{
	if (m_chunkeditor)
	{
		delete m_chunkeditor->SetSource(NULL);
		delete m_chunkeditor;
	}

	map<sint32,ObjWindow*>::iterator i = m_windowlist.begin();
	for (; i != m_windowlist.end(); ++i)
		delete i->second;

	delete m_undoaction;
	
	if (m_database)
		m_database->dec_ref();
	
	_tstring** mru = m_recentfiles;
	while (*mru)
		delete *mru++;

	::DestroyMenu(m_menubar);
	SetWindowLong(m_window, GWL_USERDATA, 0);
}

ObjTreeMain::ObjTreeMain()
	: Window(), m_chunkeditor(NULL), m_database(NULL),
	  m_splitpos(200), m_mdimaximize(false),
	  m_currenteditcontext(editNone), m_undoaction(NULL)
{
	memset(m_recentfiles, 0, sizeof(m_recentfiles));
}

ObjTreeMain::ObjTreeMain(HINSTANCE inst)
	: Window(), m_chunkeditor(NULL), m_database(NULL),
	  m_splitpos(200), m_mdimaximize(false),
	  m_currenteditcontext(editNone), m_undoaction(NULL)
{
	memset(m_recentfiles, 0, sizeof(m_recentfiles));
	Create(inst);
}

LRESULT CALLBACK ObjTreeMain::WindowProc(HWND hwnd, UINT message, WPARAM wparam, LPARAM lparam)
{
	static HWND currfocus = NULL;
	static bool dragsplitter = false;
	static bool dragtreeobj = false;

	if (message == WM_CREATE)
	{
		LPCREATESTRUCT info = reinterpret_cast<LPCREATESTRUCT>(lparam);
		ObjTreeMain* win = reinterpret_cast<ObjTreeMain*>(info->lpCreateParams);
		SetWindowLong(hwnd, GWL_USERDATA, reinterpret_cast<LONG>(win));
		return 0;
	}
	ObjTreeMain* win = reinterpret_cast<ObjTreeMain*>(GetWindowLong(hwnd, GWL_USERDATA));
	
	switch (message)
	{
	  case WM_DESTROY:
		if (win)
		{
			win->StowPersistence();
		}
		PostQuitMessage(0);
		return 0;
	  case WM_SIZE:
		if (win)
			win->AdjustLayout(dragsplitter);
		return 0;
	  case WM_PAINT:
		if (win)
		{
			PAINTSTRUCT ps;
			HDC dc = BeginPaint(hwnd, &ps);
			RECT rc;
			GetClientRect(hwnd, &rc);
			win->DrawSplitter(dc, rc.bottom, dragsplitter);
			EndPaint(hwnd, &ps);
			return 0;
		}
		break;
	  case WM_SETTINGCHANGE:
	  case WM_SYSCOLORCHANGE:
		if (win)
		{
			win->m_listwin.SendMessage(message, wparam, lparam);
			win->AdjustLayout(dragsplitter);
		}
		break;
	  case WM_LBUTTONDOWN:
		if (win)
		{
			int width = GetSystemMetrics(SM_CXSIZEFRAME) / 2;
			if ((MAKEPOINTS(lparam).x > win->m_splitpos-width)
			 && (MAKEPOINTS(lparam).x < win->m_splitpos+width))
			{
				win->m_oldpos = win->m_splitpos;
				win->m_dragpos = MAKEPOINTS(lparam).x;
				dragsplitter = true;
				currfocus = SetFocus(hwnd);
				RegisterHotKey(hwnd, 0, 0, VK_ESCAPE);
				SetCursor(LoadCursor(NULL, IDC_SIZEWE));
				SetCapture(hwnd);
				HDC dc = GetDC(hwnd);
				RECT rc;
				GetClientRect(hwnd, &rc);
				win->DrawSplitter(dc, rc.bottom, dragsplitter, true);
				ReleaseDC(hwnd, dc);
			}
		}
		break;
	  case WM_LBUTTONUP:
		if (win)
		{
			if (dragsplitter)
			{
				ReleaseCapture();
				SetCursor(LoadCursor(NULL, IDC_ARROW));
				UnregisterHotKey(hwnd, 0);
				if (currfocus)
					SetFocus(currfocus);
				dragsplitter = false;
				win->m_splitpos = win->m_dragpos;
				win->AdjustLayout(false);
				InvalidateRect(hwnd, NULL, FALSE);
			}
			else if (dragtreeobj)
			{
				dragtreeobj = false;
				UnregisterHotKey(hwnd, 0);
				win->EndDragTreeObject(MAKEPOINTS(lparam).x, MAKEPOINTS(lparam).y);
			}
		}
		break;
	  case WM_MOUSEMOVE:
		if (win)
		{
			RECT rc;
			GetClientRect(hwnd, &rc);
			if (dragsplitter)
			{
				SetCursor(LoadCursor(NULL, IDC_SIZEWE));
				int minwidth = GetSystemMetrics(SM_CXHSCROLL) * 2;
				if ((MAKEPOINTS(lparam).x - rc.left >= minwidth) 
				 && (rc.right - MAKEPOINTS(lparam).x >= minwidth))
				{
					win->m_oldpos = win->m_dragpos;
					win->m_dragpos = MAKEPOINTS(lparam).x;
					HDC dc = GetDC(hwnd);
					win->DrawSplitter(dc, rc.bottom, dragsplitter, true);
					ReleaseDC(hwnd, dc);
				}
			}
			else if (dragtreeobj)
			{
				win->DragTreeObject(MAKEPOINTS(lparam).x, MAKEPOINTS(lparam).y);
			}
			else
			{
				int width = GetSystemMetrics(SM_CXSIZEFRAME) / 2;
				if ((MAKEPOINTS(lparam).x > win->m_splitpos-width)
				 && (MAKEPOINTS(lparam).x < win->m_splitpos+width))
				{
					SetCursor(LoadCursor(NULL, IDC_SIZEWE));
				}
				else
					SetCursor(LoadCursor(NULL, IDC_ARROW));
			}
			return 0;
		}
		break;
	  case WM_HOTKEY:
		if (win && HIWORD(lparam) == VK_ESCAPE)
		{
			if (dragsplitter)
			{
				dragsplitter = false;
				ReleaseCapture();
				UnregisterHotKey(hwnd, 0);
				SetCursor(LoadCursor(NULL, IDC_ARROW));
				if (currfocus)
					SetFocus(currfocus);
				win->AdjustLayout(false);
				InvalidateRect(hwnd, NULL, FALSE);
			}
			else if (dragtreeobj)
			{
				dragtreeobj = false;
				UnregisterHotKey(hwnd, 0);
				TreeView_SelectDropTarget(win->m_listwin, NULL);
				win->EndDragTreeObject(MAKEPOINTS(lparam).x, MAKEPOINTS(lparam).y);
			}
		}
	  case WM_TIMER:
		if (wparam == ID_DRAGOBJECTTIMER)
		{
			if (win)
			{
				HTREEITEM item = TreeView_GetDropHilight(win->m_listwin);
				if (item)
					TreeView_Expand(win->m_listwin, item, TVE_EXPAND);
			}
			KillTimer(hwnd, ID_DRAGOBJECTTIMER);
			return 0;
		}
		break;
	  case WM_COMMAND:
		if (win)
		{
			if (LOWORD(wparam) >= IDM_RECENTFILE && LOWORD(wparam) < IDM_RECENTFILELAST)
			{
				MENUITEMINFO minfo;
				minfo.cbSize = sizeof(MENUITEMINFO);
				minfo.fMask = MIIM_DATA;
				GetMenuItemInfo(win->m_menubar, LOWORD(wparam), FALSE, &minfo);
				if (minfo.dwItemData)
					win->OpenDatabase(*reinterpret_cast<_tstring*>(minfo.dwItemData));
				return 0;
			}
			switch (LOWORD(wparam))
			{
			  case IDM_EXIT:
				DestroyWindow(hwnd);
				return 0;
			  case IDM_OPEN:
				win->OpenDatabase();
				if (GetFocus() != win->m_listwin)
					win->m_listwin.Focus();
				return 0;
			  case IDM_SAVE:
				win->SaveDatabase();
				return 0;
			  case IDM_STRUCTINFO:
				win->LoadStructInfo(GetKeyState(VK_SHIFT) & 0x8000);
			    return 0;
			  case IDM_UNDO:
				win->DoUndoRedo();
				return 0;
			  case IDM_SEARCHOBJ:
				win->SearchForObject();
				return 0;
			  case IDM_OBJADD:
				win->DoObjectAdd();
				return 0;
			  case IDM_OBJREMOVE:
				win->DoObjectRemove();
				return 0;
			  case IDM_EDITCHUNKS:
				win->OpenChunkEditor();
				return 0;
			  case IDM_IMPORTGMVL:
				win->GmvlImport();
			    return 0;
			  case IDM_CASCADE:
				win->m_clientwin.SendMessage(WM_MDICASCADE, MDITILE_SKIPDISABLED, 0);
				return 0;
			  case IDM_TILEH:
				win->m_clientwin.SendMessage(WM_MDITILE, MDITILE_HORIZONTAL | MDITILE_SKIPDISABLED, 0);
				return 0;
			  case IDM_TILEV:
				win->m_clientwin.SendMessage(WM_MDITILE, MDITILE_VERTICAL | MDITILE_SKIPDISABLED, 0);
				return 0;
			  case IDM_ARRANGE:
				win->m_clientwin.SendMessage(WM_MDIICONARRANGE, 0, 0);
				return 0;
			  case IDM_PANESWITCH:
				if (GetFocus() == win->m_listwin)
				{
					HWND w = reinterpret_cast<HWND>(
							win->m_clientwin.SendMessage(WM_MDIGETACTIVE, 0, 0));
					if (w)
						SetFocus(w);
				}
				else
					win->m_listwin.Focus();
				return 0;
			  case IDM_WINDOWSWITCH:
				if (GetFocus() != win->m_listwin)
				{
					HWND w = reinterpret_cast<HWND>(
							win->m_clientwin.SendMessage(WM_MDIGETACTIVE, 0, 0));
					if (w)
						return ::SendMessage(w, message, wparam, lparam);
				}
				break;
			}
		}
		break;
	  case WM_NOTIFY:
		if (win)
		{
			switch (reinterpret_cast<LPNMHDR>(lparam)->code)
			{
			  case TVN_GETDISPINFO:
			  {
				win->DisplayTreeObject(reinterpret_cast<LPNMTVDISPINFO>(lparam)->item);
				return 0;
			  }
			  case TVN_BEGINDRAG:
			  {
				LPNMTREEVIEW info = reinterpret_cast<LPNMTREEVIEW>(lparam);
				win->BeginDragTreeObject(info->itemNew.hItem, info->ptDrag.x, info->ptDrag.y);
				dragtreeobj = true;
				return 0;
			  }
			  case TVN_DELETEITEM:
			  {
				TVITEM& item = reinterpret_cast<LPNMTREEVIEW>(lparam)->itemOld;
				win->CloseObjectWindow(item.lParam);
				return 0;
			  }
			  case NM_DBLCLK:
			  case NM_RETURN:
			  {
				TVITEM info;
				info.hItem = TreeView_GetSelection(win->m_listwin);
				if (info.hItem)
				{
					info.mask = TVIF_PARAM;
					TreeView_GetItem(win->m_listwin, &info);
					win->OpenObjectWindow(info.lParam);
					return TRUE;
				}
			  }
			  case NM_KILLFOCUS:
			  {
				if (reinterpret_cast<LPNMHDR>(lparam)->hwndFrom == win->m_listwin)
					win->SetEditContext(editNone);
				return 0;
			  }
			  case NM_SETFOCUS:
			  {
				if (reinterpret_cast<LPNMHDR>(lparam)->hwndFrom == win->m_listwin)
				{
					if (TreeView_GetSelection(win->m_listwin) != NULL)
						win->SetEditContext(editHierarchy);
				}
				return 0;
			  }
			  case TVN_SELCHANGED:
			  {
				if (reinterpret_cast<LPNMHDR>(lparam)->hwndFrom == win->m_listwin)
				{
					win->SetEditContext(editHierarchy);
				}
				return 0;
			  }
			}
		}
		break;
	  case WM_PARENTNOTIFY:
		if (win && LOWORD(wparam) == WM_DESTROY)
		{
			if (win->m_chunkeditor && reinterpret_cast<HWND>(lparam) == *win->m_chunkeditor)
			{
				delete win->m_chunkeditor->SetSource(NULL);
				delete win->m_chunkeditor;
				win->m_chunkeditor = NULL;
				return 0;
			}
		}
		break;
	}
	return DefFrameProc(hwnd, (!win) ? (HWND)NULL : static_cast<HWND>(win->m_clientwin), message, wparam, lparam);
}

static POINT gDragObjectHoverPt;

void ObjTreeMain::BeginDragTreeObject(HTREEITEM item, int x, int y)
{
	/*
	RECT itemrc;
	TreeView_GetItemRect(m_listwin, item, &itemrc, TRUE);

	HIMAGELIST dragimage = TreeView_CreateDragImage(m_listwin, item);
	ImageList_BeginDrag(dragimage, 0, pt->x-itemrc.left, pt->y-itemrc.top);
	ImageList_DragEnter(m_listwin, pt->x, pt->y);
	*/
	m_currentdragobject = item;
	TreeView_SelectItem(m_listwin, item);
	SetCapture(m_window);
	SetFocus(m_window);
	RegisterHotKey(m_window, 0, 0, VK_ESCAPE);
	SetCursor(LoadCursor(NULL, IDC_CROSS));
	gDragObjectHoverPt.x = x;
	gDragObjectHoverPt.y = y;
}

void ObjTreeMain::DragTreeObject(int x, int y)
{
	//ImageList_DragMove(pt->x, pt->y);
	TVHITTESTINFO hit;
	hit.pt.x = x;
	hit.pt.y = y;
	HTREEITEM hititem = TreeView_HitTest(m_listwin, &hit);
	HTREEITEM curr = hititem;
	curr = hititem;
	while (curr)
	{
		if (curr == m_currentdragobject)
		{
			hititem = NULL;
			break;
		}
		curr = TreeView_GetParent(m_listwin, curr);
	}
	
	if (! hit.hItem)
	{
		if (hit.flags & TVHT_ABOVE)
			m_listwin.SendMessage(WM_VSCROLL, MAKEWPARAM(SB_LINEUP,0), 0);
		else if (hit.flags & TVHT_BELOW)
			m_listwin.SendMessage(WM_VSCROLL, MAKEWPARAM(SB_LINEDOWN,0), 0);
		if (hit.flags & TVHT_TOLEFT)
			m_listwin.SendMessage(WM_HSCROLL, MAKEWPARAM(SB_LINELEFT,0), 0);
		else if (hit.flags & TVHT_TORIGHT)
			m_listwin.SendMessage(WM_HSCROLL, MAKEWPARAM(SB_LINERIGHT,0), 0);
	}

	if (hititem)
	{
		POINT dist;
		POINT fuzz;
		fuzz.x = GetSystemMetrics(SM_CXDOUBLECLK);
		fuzz.y = GetSystemMetrics(SM_CYDOUBLECLK);
		dist.x = x - gDragObjectHoverPt.x;
		if (dist.x < 0) dist.x = -dist.x;
		dist.y = y - gDragObjectHoverPt.y;
		if (dist.y < 0) dist.y = -dist.y;
		if ((dist.x > fuzz.x) || (dist.y > fuzz.y))
		{
			KillTimer(m_window, ID_DRAGOBJECTTIMER);
			SetTimer(m_window, ID_DRAGOBJECTTIMER, GetDoubleClickTime(), NULL);
			gDragObjectHoverPt.x = x;
			gDragObjectHoverPt.y = y;
		}
	}
	else
	{
			KillTimer(m_window, ID_DRAGOBJECTTIMER);
			gDragObjectHoverPt.x = MAXLONG;
			gDragObjectHoverPt.y = MAXLONG;
	}

	//ImageList_DragLeave(m_listwin);
	TreeView_SelectDropTarget(m_listwin, hititem);
	//ImageList_DragEnter(m_listwin, pt->x, pt->y);
}

void ObjTreeMain::EndDragTreeObject(int x, int y)
{
	//ImageList_EndDrag();
	ReleaseCapture();
	UnregisterHotKey(m_window, 0);
	SetCursor(LoadCursor(NULL, IDC_ARROW));

	HTREEITEM droptarget = TreeView_GetDropHilight(m_listwin);
	if (droptarget)
	{
		HTREEITEM curr = droptarget;
		while (curr)
		{
			if (curr == m_currentdragobject)
				goto l_nomove;
			curr = TreeView_GetParent(m_listwin, curr);
		}
		sint32 oid, oldparent, newparent;
		{
			TVITEM iteminfo;
			iteminfo.mask = TVIF_PARAM;
			iteminfo.hItem = m_currentdragobject;
			TreeView_GetItem(m_listwin, &iteminfo);
			oid = iteminfo.lParam;
			iteminfo.hItem = droptarget;
			TreeView_GetItem(m_listwin, &iteminfo);
			newparent = iteminfo.lParam;
			iteminfo.hItem = TreeView_GetParent(m_listwin, m_currentdragobject);
			TreeView_GetItem(m_listwin, &iteminfo);
			oldparent = iteminfo.lParam;
		}
		HTREEITEM newitem = m_listwin.ReParent(m_database, m_currentdragobject, droptarget);
		if (newitem != NULL)
		{
			SetUndoAction(new UndoMoveObject(oid, oldparent, newparent));
		}
		TreeView_SelectItem(m_listwin, newitem);
	}
l_nomove:

	TreeView_SelectDropTarget(m_listwin, NULL);
	m_listwin.Focus();
}

int ObjTreeMain::RetrievePersistence()
{
	int viewstate = 0;
	HKEY appkey;
	DWORD datatype;
	DWORD datalen;
	if (ERROR_SUCCESS == RegOpenKeyEx(HKEY_CURRENT_USER, 
			TEXT("Software\\WhoopDeDo.org\\ObjTree"), 0, KEY_READ, &appkey))
	{
		struct { RECT rc; int state; int split; } regsize;
		if (ERROR_SUCCESS == RegQueryValueEx(appkey, TEXT("WindowPos"), NULL,
				&datatype, NULL, &datalen)
		 && datatype == REG_BINARY && datalen == (sizeof(regsize)))
		{
			RegQueryValueEx(appkey, TEXT("WindowPos"), NULL,
					&datatype, reinterpret_cast<LPBYTE>(&regsize), &datalen);
			viewstate = regsize.state;
			m_splitpos = regsize.split;
			if (m_window)
			{
				SetWindowPos(m_window, NULL, regsize.rc.left, regsize.rc.top,
						regsize.rc.right, regsize.rc.bottom, 
						SWP_NOACTIVATE | SWP_NOZORDER | SWP_NOCOPYBITS);
			}
		}

		if (ERROR_SUCCESS == RegQueryValueEx(appkey, TEXT("MDIMaximize"), NULL, 
				&datatype, NULL, &datalen) && datalen <= 4)
		{
			union { int i; char d[4]; };
			datalen = 4;
			RegQueryValueEx(appkey, TEXT("MDIMaximize"), NULL,
					&datatype, reinterpret_cast<LPBYTE>(d), &datalen);
			if (datatype == REG_SZ)
				m_mdimaximize = d[0] == '1';
			else
				m_mdimaximize = i;
		}

		HMENU filemenu = GetSubMenu(m_menubar, ID_FILEMENU);
		TCHAR mruname[16];
		lstrcpy(mruname, TEXT("RecentFile0"));
		int mrunum = 0;
		while (ERROR_SUCCESS == RegQueryValueEx(appkey, mruname, NULL,
				&datatype, NULL, &datalen) && datatype == REG_SZ)
		{
			LPTSTR mrufile = new TCHAR[datalen];
			RegQueryValueEx(appkey, mruname, NULL, &datatype,
					reinterpret_cast<LPBYTE>(mrufile), &datalen);
			m_recentfiles[mrunum] = new _tstring(mrufile);
			InsertRecentFile(filemenu, m_recentfiles[mrunum], mrunum, mrunum);
			if (++mrunum > 9)
				break;
			++mruname[10];
		}
		if (mrunum > 0)
			InsertMenu(filemenu, ID_RECENTFILEPOS+mrunum, MF_BYPOSITION | MF_SEPARATOR, 0, NULL);

		RegCloseKey(appkey);
	}
	return viewstate;
}

void ObjTreeMain::StowPersistence()
{
	HKEY appkey;
	DWORD data;
	if (ERROR_SUCCESS == RegCreateKeyEx(HKEY_CURRENT_USER,
			TEXT("Software\\WhoopDeDo.org\\ObjTree"), 0, NULL, 0, KEY_WRITE, NULL, &appkey, &data))
	{
		struct { RECT rc; int state; int split; } regsize;
		WINDOWPLACEMENT windowpos;
		windowpos.length = sizeof(WINDOWPLACEMENT);
		GetWindowPlacement(m_window, &windowpos);
		regsize.rc.left = windowpos.rcNormalPosition.left;
		regsize.rc.top = windowpos.rcNormalPosition.top;
		regsize.rc.right = windowpos.rcNormalPosition.right - windowpos.rcNormalPosition.left;
		regsize.rc.bottom = windowpos.rcNormalPosition.bottom - windowpos.rcNormalPosition.top;
		regsize.state = windowpos.showCmd;
		regsize.split = m_splitpos;
		RegSetValueEx(appkey, TEXT("WindowPos"), 0, REG_BINARY, 
				reinterpret_cast<LPBYTE>(&regsize), sizeof(regsize));

		data = m_mdimaximize;
		RegSetValueEx(appkey, TEXT("MDIMaximize"), 0, REG_DWORD,
				reinterpret_cast<LPBYTE>(&data), sizeof(data));

		TCHAR mruname[16];
		lstrcpy(mruname, TEXT("RecentFile0"));
		_tstring** mrufile = m_recentfiles;
		while (*mrufile)
		{
			RegSetValueEx(appkey, mruname, 0, REG_SZ, 
					reinterpret_cast<const BYTE*>((*mrufile)->data()), (*mrufile)->size());
			++mruname[10];
			++mrufile;
		}

		RegCloseKey(appkey);
	}
}

static void InsertRecentFile(HMENU menu, _tstring* fname, int pos, int id)
{
	int tail = fname->rfind(TEXT('\\')) + 1;
	MENUITEMINFO info;
	info.cbSize = sizeof(MENUITEMINFO);
	info.fMask = MIIM_TYPE | MIIM_ID | MIIM_DATA;
	info.fType = MFT_STRING;
	info.wID = IDM_RECENTFILE+id;
	info.dwTypeData = const_cast<LPTSTR>(fname->c_str() + tail);
	info.cch = fname->size() - tail;
	info.dwItemData = reinterpret_cast<DWORD>(fname);
	InsertMenuItem(menu, ID_RECENTFILEPOS+pos, TRUE, &info);
}

void ObjTreeMain::UpdateRecentFiles(const _tstring& fname)
{
	int id;
	HMENU menu = GetSubMenu(m_menubar, ID_FILEMENU);
	_tstring** mru = m_recentfiles;
	for (;*mru; ++mru)
	{
		if (nctstr_equal()(**mru, fname))
		{
			if (mru == m_recentfiles)
				return;
			id = GetMenuItemID(menu, ID_RECENTFILEPOS + (mru - m_recentfiles)) - IDM_RECENTFILE;
			RemoveMenu(menu, ID_RECENTFILEPOS + (mru - m_recentfiles), MF_BYPOSITION);
			_tstring* mrufile = *mru;
			copy(m_recentfiles, mru, m_recentfiles+1);
			m_recentfiles[0] = mrufile;
			InsertRecentFile(menu, mrufile, 0, id);
			return;
		}
	}
	if (mru == m_recentfiles)
	{
		InsertMenu(menu, ID_RECENTFILEPOS, MF_BYPOSITION | MF_SEPARATOR, 0, NULL);
		id = 0;
	}
	else if (mru - m_recentfiles > 9)
	{
		--mru;
		id = GetMenuItemID(menu, ID_RECENTFILEPOS + (mru - m_recentfiles)) - IDM_RECENTFILE;
		RemoveMenu(menu, ID_RECENTFILEPOS + (mru - m_recentfiles), MF_BYPOSITION);
		delete *mru;
	}
	else
		id = mru - m_recentfiles;
	copy(m_recentfiles, mru, m_recentfiles+1);
	m_recentfiles[0] = new _tstring(fname);
	InsertRecentFile(menu, m_recentfiles[0], 0, id);
}

BOOL ObjTreeMain::Create(HINSTANCE inst)
{
	if (!m_menubar.Create(MAKEINTRESOURCE(ID_APPMAIN), inst))
		return FALSE;

	if (strWindowName.empty())
	{
		TCHAR windowname[260];
		LoadString(inst, ID_APPMAIN, windowname, sizeof(windowname));
		strWindowName = windowname;
	}

	m_window = CreateWindowEx(WS_EX_APPWINDOW | WS_EX_OVERLAPPEDWINDOW,
		szClassName, strWindowName.c_str(),
		WS_OVERLAPPEDWINDOW,
		CW_USEDEFAULT, CW_USEDEFAULT, 600, 400,
		NULL, m_menubar, inst, reinterpret_cast<void*>(this));
	if (!m_window)
		return FALSE;

	CLIENTCREATESTRUCT clientinfo;
	clientinfo.hWindowMenu = GetSubMenu(m_menubar, ID_WINDOWMENU);
	clientinfo.idFirstChild = ID_CHILDWIN;
	m_clientwin = CreateWindowEx(WS_EX_CLIENTEDGE, TEXT("MDICLIENT"), NULL,
		WS_CHILD | WS_VISIBLE | WS_VSCROLL | WS_HSCROLL,
		m_splitpos, 0, 400, 400,
		m_window, NULL, inst, (LPSTR)&clientinfo);
	if (!m_clientwin)
		return FALSE;

	if (!m_listwin.Create(m_window, inst))
		return FALSE;

	m_menubar.DisableId(IDM_SAVE);
	m_menubar.DisablePos(ID_EDITMENU);
	m_menubar.DisableId(IDM_UNDO);
	m_menubar.DisableId(IDM_CUT);
	m_menubar.DisableId(IDM_COPY);
	m_menubar.DisableId(IDM_PASTE);
	m_menubar.DisablePos(ID_OBJECTMENU);
	m_menubar.DisableId(IDM_OBJADD);
	m_menubar.DisableId(IDM_OBJREMOVE);
	m_menubar.DisablePos(ID_WINDOWMENU);
	DrawMenuBar(m_window);

	return TRUE;
}

void ObjTreeMain::AdjustLayout(bool dragging)
{
	RECT rc;
	int width, height;
	width = GetSystemMetrics(SM_CXSIZEFRAME) / 2;
	GetClientRect(m_window, &rc);
	height = rc.bottom-rc.top;
	int split = dragging ? m_dragpos : m_splitpos;
	HDWP pos = BeginDeferWindowPos(2);
	DeferWindowPos(pos, m_listwin, NULL, 0, 0, split-width, height, SWP_NOZORDER);
	DeferWindowPos(pos, m_clientwin, NULL, split+width, 0, rc.right-split, height, SWP_NOZORDER);
	EndDeferWindowPos(pos);
}

void ObjTreeMain::DrawSplitter(HDC dc, int height, bool dragging, bool track)
{
	BOOL liveupdate = FALSE;
	SystemParametersInfo(SPI_GETDRAGFULLWINDOWS, 0, &liveupdate, 0);
	int width = GetSystemMetrics(SM_CXSIZEFRAME) / 2;
	int pos = (dragging && liveupdate) ? m_dragpos : m_splitpos;
	RECT rc;
	
	if (track)
	{
		if (!liveupdate)
		{
			SetRect(&rc, m_oldpos-width, 0, m_oldpos+width, height);
			RedrawWindow(m_window, &rc, NULL, RDW_INVALIDATE | RDW_FRAME | RDW_UPDATENOW);
			SetRect(&rc, m_dragpos-width, 0, m_dragpos+width, height);
			HBRUSH br = CreateSolidBrush(GetSysColor(COLOR_ACTIVEBORDER));
			HBRUSH ob = (HBRUSH)::SelectObject(dc, br);
			HPEN op = (HPEN)::SelectObject(dc, GetStockObject(NULL_PEN));
			int rop = GetROP2(dc);
			SetROP2(dc, R2_XORPEN);
			Rectangle(dc, m_dragpos-width, 0, m_dragpos+width, height);
			SetROP2(dc, rop);
			::SelectObject(dc, op);
			::SelectObject(dc, ob);
			::DeleteObject(br);
		}
		else
		{
			AdjustLayout(dragging);
			SetRect(&rc, m_dragpos-width, 0, m_dragpos+width, height);
			RedrawWindow(m_window, &rc, NULL, RDW_INVALIDATE | RDW_FRAME | RDW_UPDATENOW);
		}
	}
	else
	{
		SetRect(&rc, pos-width, 0, pos+width, height);
		DrawEdge(dc, &rc, EDGE_RAISED, BF_LEFT | BF_RIGHT | BF_MIDDLE | BF_SOFT);
	}
}

void ObjTreeMain::ErrorMessage(const _tstring& msg)
{
	MessageBox(m_window, msg.c_str(), TEXT("error"), MB_APPLMODAL | MB_ICONERROR | MB_OK);
}

#ifdef UNICODE
void ObjTreeMain::ErrorMessage(const string& msg)
{
	int len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
			msg.data(), msg.size(),
			NULL, 0);
	LPWSTR buf = new WCHAR[len+1];
	len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
			msg.data(), msg.size(),
			buf, len);
	buf[len] = TEXT('\0');
	MessageBox(m_window, buf, TEXT("error"), MB_APPLMODAL | MB_ICONERROR | MB_OK);
	delete[] buf;
}
#endif

bool ObjTreeMain::PromptMessage(const _tstring& msg)
{
	int _ret = 
	MessageBox(m_window, msg.c_str(), TEXT("prompt"), MB_APPLMODAL | MB_ICONQUESTION | MB_YESNO);
	return _ret == IDYES;
}

#ifdef UNICODE
bool ObjTreeMain::PromptMessage(const string& msg)
{
	int len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
			msg.data(), msg.size(),
			NULL, 0);
	LPWSTR buf = new WCHAR[len+1];
	len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
			msg.data(), msg.size(),
			buf, len);
	buf[len] = TEXT('\0');
	int _ret = 
	MessageBox(m_window, buf, TEXT("prompt"), MB_APPLMODAL | MB_ICONQUESTION | MB_YESNO);
	delete[] buf;
	return _ret == IDYES;
}
#endif

int ObjTreeMain::PromptMessage2(const _tstring& msg)
{
	int _ret = 
	MessageBox(m_window, msg.c_str(), TEXT("prompt"), MB_APPLMODAL | MB_ICONQUESTION | MB_YESNOCANCEL);
	return _ret == IDCANCEL ? -1 : _ret == IDYES;
}

#ifdef UNICODE
int ObjTreeMain::PromptMessage2(const string& msg)
{
	int len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
			msg.data(), msg.size(),
			NULL, 0);
	LPWSTR buf = new WCHAR[len+1];
	len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
			msg.data(), msg.size(),
			buf, len);
	buf[len] = TEXT('\0');
	int _ret = 
	MessageBox(m_window, buf, TEXT("prompt"), MB_APPLMODAL | MB_ICONQUESTION | MB_YESNOCANCEL);
	delete[] buf;
	return _ret == IDCANCEL ? -1 : _ret == IDYES;
}
#endif

ObjWindow* ObjTreeMain::FindObjectWindow(sint32 oid)
{
	map<sint32,ObjWindow*>::const_iterator i = m_windowlist.find(oid);
	return (i == m_windowlist.end()) ? NULL : i->second;
}

ObjWindow* ObjTreeMain::OpenObjectWindow(sint32 oid)
{
	ObjWindow* win = NULL;
	map<sint32,ObjWindow*>::iterator i = m_windowlist.find(oid);
	if (i != m_windowlist.end())
	{
		win = i->second;
		m_clientwin.SendMessage(WM_MDIACTIVATE, (WPARAM)static_cast<HWND>(*win), 0);
	}
	else
	{
		DarkObject* obj = m_database->GetObject(oid);
		if (!obj)
			return NULL;
		win = new ObjWindow(obj, *this, gInstance);
		m_windowlist.insert(make_pair(oid, win));
		m_menubar.EnablePos(ID_WINDOWMENU);
		DrawMenuBar(m_window);
	}
	return win;
}

void ObjTreeMain::CloseObjectWindow(sint32 oid)
{
	map<sint32,ObjWindow*>::iterator i = m_windowlist.find(oid);
	if (i != m_windowlist.end())
	{
		m_clientwin.SendMessage(WM_MDIDESTROY, (WPARAM)static_cast<HWND>(*(i->second)), 0);
		delete i->second;
		m_windowlist.erase(i);
		if (m_windowlist.empty())
		{
			m_menubar.DisablePos(ID_WINDOWMENU);
			DrawMenuBar(m_window);
			m_listwin.Focus();
		}
	}
}

void ObjTreeMain::CloseAllObjectWindows()
{
	map<sint32,ObjWindow*>::iterator i = m_windowlist.begin();
	for (; i != m_windowlist.end(); ++i)
	{
		m_clientwin.SendMessage(WM_MDIDESTROY, (WPARAM)static_cast<HWND>(*(i->second)), 0);
		delete i->second;
	}
	m_windowlist.clear();
	m_menubar.DisablePos(ID_WINDOWMENU);
	DrawMenuBar(m_window);
	m_listwin.Focus();
}

void ObjTreeMain::DisplayTreeObject(TVITEM& item)
{
	DarkObject* obj = m_database->GetObject(item.lParam);
	if (!obj)
	{
		wsprintf(item.pszText, TEXT("<error> (%d)"), item.lParam);
		return;
	}
	string itemname = print_object_name(m_database, obj);
#ifdef UNICODE
	int n = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
			itemname.data(), itemname.size(),
			item.pszText, item.cchTextMax);
	item.pszText[n] = TEXT('\0');
#else
	itemname.copy(item.pszText, item.cchTextMax);
	item.pszText[min(item.cchTextMax,int(itemname.size()))] = '\0';
#endif
}

void ObjTreeMain::UpdateObject(DarkObject* obj)
{
	m_listwin.UpdateObject(obj->GetId());

	map<sint32,ObjWindow*>::iterator i = m_windowlist.find(obj->GetId());
	if (i != m_windowlist.end())
	{
		string name = print_object_name(m_database, obj);
#ifdef UNICODE
		int len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
				name.data(), name.size(),
				NULL, 0);
		LPTSTR windowname = new TCHAR[len+1];
		len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
				name.data(), name.size(),
				windowname, len);
		windowname[len] = TEXT('\0');
		SetWindowText(*(i->second), windowname);
		delete[] windowname;
#else
		SetWindowText(*(i->second), name.c_str());
#endif
	}
}

void ObjTreeMain::OpenDatabase()
{
	_tstring fname;

	if (PickInputFile(m_window, fname))
	{
		OpenDatabase(fname);
	}
}

void ObjTreeMain::OpenDatabase(const _tstring& fname)
{
	try
	{
		SetCursor(LoadCursor(NULL, IDC_WAIT));

		ifstream fin;
		fin.open(fname.c_str(), ios::in | ios::binary);
		if (fin.is_open())
		{
			if (m_chunkeditor)
			{
				delete m_chunkeditor->SetSource(NULL);
				delete m_chunkeditor;
				m_chunkeditor = NULL;
			}
			CloseAllObjectWindows();
			m_listwin.Clear();
			delete m_undoaction;
			m_undoaction = NULL;
			if (m_database)
			{
				m_database->dec_ref();
				m_database = NULL;
				SetUndoAction(NULL);
				m_menubar.DisableId(IDM_SAVE);
				m_menubar.DisablePos(ID_OBJECTMENU);
				DrawMenuBar(m_window);
			}
			m_database = new DarkDB(fin);

			m_listwin.LoadHierarchy(m_database, "Object");
			m_listwin.LoadHierarchy(m_database, "MetaProperty");
			m_listwin.LoadHierarchy(m_database, "Stimulus");
			m_listwin.LoadHierarchy(m_database, "Base Room");
			m_listwin.LoadHierarchy(m_database, "Texture");
			m_listwin.LoadHierarchy(m_database, "Flow Group");

			DarkDataSource::SetSelfTargetObject(find_object_id(m_database, "This Sensor"));
			DarkDataSource::SetSelfSourceObject(find_object_id(m_database, "This Source"));

			UpdateRecentFiles(fname);
			m_menubar.EnableId(IDM_SAVE);
			m_menubar.EnablePos(ID_EDITMENU);
			m_menubar.EnablePos(ID_OBJECTMENU);
			DrawMenuBar(m_window);

			_tstring windowname = strWindowName + TEXT(" - [") + fname + TEXT("]");
			SetWindowText(m_window, windowname.c_str());
		}
		SetCursor(LoadCursor(NULL, IDC_ARROW));
	}
	catch (exception &e)
	{
		SetCursor(LoadCursor(NULL, IDC_ARROW));
		ErrorMessage(e.what());
	}
}

void ObjTreeMain::SaveDatabase()
{
	if (!m_database)
		return;

	_tstring fname;
	if (m_recentfiles[0])
		fname = *m_recentfiles[0];
	if (PickOutputFile(m_window, fname))
	{
		try
		{
			SetCursor(LoadCursor(NULL, IDC_WAIT));

			delete m_undoaction;
			m_undoaction = NULL;

			ofstream fout;
			fout.open(fname.c_str(), ios::out | ios::trunc | ios::binary);
			if (fout.is_open())
			{
				m_database->Save(fout);
				UpdateRecentFiles(fname);
			}
			SetCursor(LoadCursor(NULL, IDC_ARROW));
		}
		catch (exception &e)
		{
			SetCursor(LoadCursor(NULL, IDC_ARROW));
			ErrorMessage(e.what());
		}
	}
	return;
}

void ObjTreeMain::LoadStructInfo(bool shift)
{
	_tstring fname;

	if (PickInputFile(m_window, fname, 1))
	{
		LoadStructInfo(fname, shift);
	}
}

void ObjTreeMain::LoadStructInfo(const _tstring& fname, bool shift)
{
	try
	{
		SetCursor(LoadCursor(NULL, IDC_WAIT));

		ifstream fin;
		fin.open(fname.c_str(), ios::in);
		if (fin.is_open())
		{
			if (shift)
				DarkDataSource::LoadStructInfo(fin);
			else
				DarkDataSource::ReloadStructInfo(fin);
		}
		SetCursor(LoadCursor(NULL, IDC_ARROW));
	}
	catch (exception &e)
	{
		SetCursor(LoadCursor(NULL, IDC_ARROW));
		ErrorMessage(e.what());
	}
}

void ObjTreeMain::SearchForObject()
{
	try
	{
		StringInputDialog dlg(IDS_SEARCHOBJPROMPT, IDS_SEARCHOBJTITLE);
		if (!dlg(m_window))
			return;
		SetCursor(LoadCursor(NULL, IDC_WAIT));
		const _tstring& objstr = dlg.Text();
		sint32 oid = find_object_id(m_database, objstr.c_str());
		SetCursor(LoadCursor(NULL, IDC_ARROW));
		if (m_database->GetObject(oid) && m_listwin.MakeVisible(oid))
		{
			OpenObjectWindow(oid);
		}
		else
		{
			_tstring msg =  TEXT("The object \"%\" was not found in the database.");
			msg.replace(msg.find('%'), 1, objstr);
			MessageBox(m_window, msg.c_str(), TEXT("Not Found"), 
					MB_APPLMODAL | MB_ICONINFORMATION | MB_OK);
		}
	}
	catch (exception &e)
	{
		SetCursor(LoadCursor(NULL, IDC_ARROW));
		ErrorMessage(e.what());
	}
}

bool ObjTreeMain::MoveObject(sint32 oid, sint32 parent)
{
	return m_listwin.ReParent(m_database, oid, parent);
}

void ObjTreeMain::CreateObject(sint32 parent)
{
	try
	{
		StringInputDialog dlg(IDS_ADDOBJPROMPT, IDS_ADDOBJTITLE);
	l_createobjectprompt:
		if (!dlg(m_window))
			return;
		const _tstring& objstr = dlg.Text();
		SetCursor(LoadCursor(NULL, IDC_WAIT));
		if (find_object_id(m_database, objstr.c_str()) != 0)
		{
			SetCursor(LoadCursor(NULL, IDC_ARROW));
			_tstring msg =  TEXT("An object named \"%\" already exists.");
			msg.replace(msg.find('%'), 1, objstr);
			MessageBox(m_window, msg.c_str(), TEXT("Invalid Object Name"), 
					MB_APPLMODAL | MB_ICONEXCLAMATION | MB_OK);
			goto l_createobjectprompt;
		}

		DarkObject* obj = CreateObject(parent, objstr);
		SetUndoAction(new UndoCreateObject(obj, parent));
		obj->dec_ref();

		SetCursor(LoadCursor(NULL, IDC_ARROW));
	}
	catch (exception &e)
	{
		SetCursor(LoadCursor(NULL, IDC_ARROW));
		ErrorMessage(e.what());
	}
}

DarkObject* ObjTreeMain::CreateObject(sint32 parent, const _tstring& name)
{
	sint32 oid = m_database->NextAbstractObjectId();
	if (! oid)
		throw runtime_error("No more abstract object IDs");
	DarkObject* obj = new DarkObject(m_database, oid);
	AddObject(obj, parent);

	sint32 donortype = 0;
	DarkObject* baseobj = m_database->GetObject(parent);
	if (baseobj)
	{
		DarkPropInteger* parentdonor = dynamic_cast<DarkPropInteger*>(baseobj->GetProperty("DonorType"));
		if (parentdonor)
			donortype = parentdonor->GetValue();
	}
	DarkPropInteger* donorprop = new DarkPropInteger("DonorType", m_database->DefaultPropertyVersion("DonorType"),
			oid, &donortype, sizeof(donortype));
	obj->AddProperty("DonorType", donorprop);
	donorprop->dec_ref();
	DarkPropString* nameprop = new DarkPropString("SymName", m_database->DefaultPropertyVersion("SymName"),
			oid, NULL, 0);
	nameprop->SetString(name);
	obj->AddProperty("SymName", nameprop);
	nameprop->dec_ref();
	return obj;
}

void ObjTreeMain::DeleteObject(sint32 oid)
{
	DarkObject* obj = m_database->GetObject(oid);
	if (obj)
	{
		if (PromptMessage(TEXT("Removing an object (and all its descendants) cannot be undone.\n"
					"Proceed anyway?")))
		{
			RemoveObject(obj);
		}
	}
}

void ObjTreeMain::AddObject(DarkObject* obj, sint32 parent)
{
	m_database->AddObject(obj->GetId(), obj);
	obj->SetBase(parent);
	m_listwin.AddObject(obj->GetId(), parent);
}

void ObjTreeMain::RemoveObject(DarkObject* obj)
{
		CloseObjectWindow(obj->GetId());
		m_listwin.RemoveObject(obj->GetId());
		m_database->RemoveObject(obj->GetId());
}

void ObjTreeMain::DoObjectAdd()
{
	switch (m_currenteditcontext)
	{
	case editHierarchy:
	{
		TVITEM iteminfo;
		iteminfo.hItem = TreeView_GetSelection(m_listwin);
		if (iteminfo.hItem)
		{
			iteminfo.mask = TVIF_PARAM;
			TreeView_GetItem(m_listwin, &iteminfo);
			CreateObject(iteminfo.lParam);
		}
		break;
	}
	case editObjectProperty:
	{
		ObjWindow* objwin = OpenObjectWindow(m_currenteditobject);
		if (objwin)
			objwin->DoAddProperty();
		break;
	}
	case editObjectMetaproperty:
	{
		ObjWindow* objwin = OpenObjectWindow(m_currenteditobject);
		if (objwin)
			objwin->DoAddMetaproperty();
		break;
	}
	case editObjectLink:
	{
		ObjWindow* objwin = OpenObjectWindow(m_currenteditobject);
		if (objwin)
			objwin->DoAddLink();
		break;
	}
	case editObjectStimulus:
	{
		ObjWindow* objwin = OpenObjectWindow(m_currenteditobject);
		if (objwin)
			objwin->DoAddStimulus();
		break;
	}
	case editObjectReceptron:
	{
		ObjWindow* objwin = OpenObjectWindow(m_currenteditobject);
		if (objwin)
			objwin->DoAddReceptron();
		break;
	}
	case editNone:
		break;
	}
}

void ObjTreeMain::DoObjectRemove()
{
	switch (m_currenteditcontext)
	{
	case editHierarchy:
	{
		TVITEM iteminfo;
		iteminfo.hItem = TreeView_GetSelection(m_listwin);
		if (iteminfo.hItem)
		{
			iteminfo.mask = TVIF_PARAM;
			TreeView_GetItem(m_listwin, &iteminfo);
			DeleteObject(iteminfo.lParam);
		}
		break;
	}
	case editObjectProperty:
	{
		ObjWindow* objwin = OpenObjectWindow(m_currenteditobject);
		if (objwin)
			objwin->DoRemoveProperty();
		break;
	}
	case editObjectMetaproperty:
	{
		ObjWindow* objwin = OpenObjectWindow(m_currenteditobject);
		if (objwin)
			objwin->DoRemoveMetaproperty();
		break;
	}
	case editObjectLink:
	{
		ObjWindow* objwin = OpenObjectWindow(m_currenteditobject);
		if (objwin)
			objwin->DoRemoveLink();
		break;
	}
	case editObjectStimulus:
	{
		ObjWindow* objwin = OpenObjectWindow(m_currenteditobject);
		if (objwin)
			objwin->DoRemoveStimulus();
		break;
	}
	case editObjectReceptron:
	{
		ObjWindow* objwin = OpenObjectWindow(m_currenteditobject);
		if (objwin)
			objwin->DoRemoveReceptron();
		break;
	}
	case editNone:
		break;
	}
}

void ObjTreeMain::SetEditContext(EditContext ctx, sint32 oid)
{
	m_currenteditobject = oid;
	m_currenteditcontext = ctx;

	TCHAR name[260];
	int stringid;
	MENUITEMINFO minfo;
	minfo.cbSize = sizeof(MENUITEMINFO);
	minfo.fMask = MIIM_TYPE | MIIM_STATE;
	minfo.fState = MFS_ENABLED;
	minfo.fType = MFT_STRING;
	minfo.dwTypeData = name;

	switch (ctx)
	{
	case editHierarchy:
		stringid = IDS_ADDOBJECT;
		break;
	case editObjectProperty:
		stringid = IDS_ADDPROPERTY;
		break;
	case editObjectMetaproperty:
		stringid = IDS_ADDMETAPROP;
		break;
	case editObjectLink:
		stringid = IDS_ADDLINK;
		break;
	case editObjectStimulus:
		stringid = IDS_ADDSTIMULUS;
		break;
	case editObjectReceptron:
		stringid = IDS_ADDRECEPTRON;
		break;
	case editNone:
		stringid = IDS_ADDOBJECT;
		minfo.fState = MFS_GRAYED;
		break;
	}
	LoadString(NULL, stringid, name, sizeof(name));
	SetMenuItemInfo(m_menubar, IDM_OBJADD, FALSE, &minfo);
	LoadString(NULL, stringid+1, name, sizeof(name));
	SetMenuItemInfo(m_menubar, IDM_OBJREMOVE, FALSE, &minfo);
}

void ObjTreeMain::SetUndoAction(const UndoRecord* action)
{
	if (m_undoaction)
		delete m_undoaction;
	m_undoaction = action;
	_tstring name(gszUndo);
	if (! action)
	{
		name.erase(name.find('%'), 1);
	}
	else
	{
#ifdef UNICODE
		int len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
				action->Name(), -1, NULL, 0);
		LPTSTR wname = new TCHAR[len+1];
		len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
				action->Name(), -1, wname, len);
		name.replace(name.find('%'), 1, wname, len);
		delete[] wname;
#else
		name.replace(name.find('%'), 1, action->Name());
#endif
	}
	MENUITEMINFO minfo;
	minfo.cbSize = sizeof(MENUITEMINFO);
	minfo.fMask = MIIM_TYPE | MIIM_STATE | MIIM_DATA;
	minfo.fState = (action) ? MFS_ENABLED : MFS_GRAYED;
	minfo.fType = MFT_STRING;
	minfo.dwTypeData = const_cast<LPTSTR>(name.c_str());
	minfo.dwItemData = 0;
	SetMenuItemInfo(m_menubar, IDM_UNDO, FALSE, &minfo);
}

void ObjTreeMain::DoUndoRedo()
{
	if (! m_undoaction)
		return;

	_tstring name;
	MENUITEMINFO minfo;
	minfo.cbSize = sizeof(MENUITEMINFO);
	minfo.fMask = MIIM_DATA;
	GetMenuItemInfo(m_menubar, IDM_UNDO, FALSE, &minfo);
	if (minfo.dwItemData)
	{
		if (m_undoaction->Redo(*this))
		{
			name = gszUndo;
#ifdef UNICODE
			int len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
					m_undoaction->Name(), -1, NULL, 0);
			LPTSTR wname = new TCHAR[len+1];
			len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
					m_undoaction->Name(), -1, wname, len);
			name.replace(name.find('%'), 1, wname, len);
			delete[] wname;
#else
			name.replace(name.find('%'), 1, m_undoaction->Name());
#endif
			minfo.fMask = MIIM_TYPE | MIIM_DATA;
			minfo.fType = MFT_STRING;
			minfo.dwTypeData = const_cast<LPTSTR>(name.c_str());
			minfo.dwItemData = 0;
			SetMenuItemInfo(m_menubar, IDM_UNDO, FALSE, &minfo);
		}
		else
			MessageBeep(MB_ICONERROR);
	}
	else
	{
		if (m_undoaction->Undo(*this))
		{
			name = gszRedo;
#ifdef UNICODE
			int len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
					m_undoaction->Name(), -1, NULL, 0);
			LPTSTR wname = new TCHAR[len+1];
			len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
					m_undoaction->Name(), -1, wname, len);
			name.replace(name.find('%'), 1, wname, len);
			delete[] wname;
#else
			name.replace(name.find('%'), 1, m_undoaction->Name());
#endif
			minfo.fMask = MIIM_TYPE | MIIM_DATA;
			minfo.fType = MFT_STRING;
			minfo.dwTypeData = const_cast<LPTSTR>(name.c_str());
			minfo.dwItemData = 1;
			SetMenuItemInfo(m_menubar, IDM_UNDO, FALSE, &minfo);
		}
		else
			MessageBeep(MB_ICONERROR);
	}
}

PropertyTree* ObjTreeMain::OpenChunkEditor()
{
	if (m_chunkeditor)
	{
		m_chunkeditor->Focus();
		return m_chunkeditor;
	}
	m_chunkeditor = new PropertyTree(new DarkChunkSource(m_database));
	m_chunkeditor->Create(m_window, gInstance, TEXT("Chunks"));

	try
	{
		const StructClass* knownchunks = DarkDataSource::GetStructReader().GetClass("chunks");
		StructClass::iterator c = knownchunks->Begin();
		while (c != knownchunks->End())
		{
			const StructInfo* chunkinfo = *c++;
			if (m_database->GetChunk(chunkinfo->Name()) != NULL)
			{
				m_chunkeditor->AddProperty(chunkinfo->Name());
				StructIterator citer = chunkinfo->Begin();
				StructIterator cend = chunkinfo->End();
				string cname;
				for (; citer != cend; ++citer)
				{
					cname = chunkinfo->Name() + '\\' + *citer;
					m_chunkeditor->AddProperty(cname, cname.substr(0,cname.rfind('\\')));
					if (citer->Type() == typeBITFIELD::name)
						m_chunkeditor->SetState(cname, PropertyTree::stateBitfield);
				}
			}
		}
	}
	catch (out_of_range &e)
	{ }
	catch (exception &e)
	{
		ErrorMessage(e.what());
	}

	m_chunkeditor->Show();
	return m_chunkeditor;
}

void ObjTreeMain::GmvlImport()
{
	_tstring fname;

	if (PickInputFile(m_window, fname, 1))
	{
		GmvlImport(fname);
	}
}

void ObjTreeMain::GmvlImport(const std::_tstring& fname)
{
	try
	{
		SetCursor(LoadCursor(NULL, IDC_WAIT));

		ifstream fin;
		fin.open(fname.c_str(), ios::in);
		if (fin.is_open())
		{
			GmvlImporter import(m_database);
			//ImportNotify notify(*this);
			//import.Notify(&notify);
			import.Parse(fin);

			m_listwin.Clear();
			m_listwin.LoadHierarchy(m_database, "Object");
			m_listwin.LoadHierarchy(m_database, "MetaProperty");
			m_listwin.LoadHierarchy(m_database, "Stimulus");
			m_listwin.LoadHierarchy(m_database, "Base Room");
			m_listwin.LoadHierarchy(m_database, "Texture");
			m_listwin.LoadHierarchy(m_database, "Flow Group");
			SetUndoAction(NULL);

		}
		SetCursor(LoadCursor(NULL, IDC_ARROW));
	}
	catch (exception &e)
	{
		SetCursor(LoadCursor(NULL, IDC_ARROW));
		ErrorMessage(e.what());
	}
}

GmvlImportResult ObjTreeMain::ImportNotify::ObjectNameConflict(const char* name, int line, int col)
{
	return GmvlImportAbort;
}

GmvlImportResult ObjTreeMain::ImportNotify::ObjectNameUnknown(const char* name, int line, int col)
{
	return GmvlImportAbort;
}

GmvlImportResult ObjTreeMain::ImportNotify::MetapropertyNameUnknown(const char* name, int line, int col)
{
	return GmvlImportAbort;
}

GmvlImportResult ObjTreeMain::ImportNotify::LinkFlavorUnknown(const char* flavor, int line, int col)
{
	return GmvlImportAbort;
}

GmvlImportResult ObjTreeMain::ImportNotify::PropertyNameUnknown(const char* name, int line, int col)
{
	return GmvlImportAbort;
}

GmvlImportResult ObjTreeMain::ImportNotify::ParamNameUnknown(const char* name, int line, int col)
{
	return GmvlImportAbort;
}

GmvlImportResult ObjTreeMain::ImportNotify::ParamValueError(const char* name, const char* value, int line, int col)
{
	return GmvlImportAbort;
}


//////////////////////
// ObjTreeList
//
ObjTreeList::ObjTreeList(HWND parent, HINSTANCE inst)
	: Window(NULL)
{
	Create(parent, inst);
}

BOOL ObjTreeList::Create(HWND parent, HINSTANCE inst)
{
	m_window = CreateWindowEx(WS_EX_CLIENTEDGE, WC_TREEVIEW, NULL,
		WS_CHILD | WS_VISIBLE | 
		TVS_HASLINES | TVS_LINESATROOT | TVS_HASBUTTONS | TVS_SHOWSELALWAYS | TVS_TRACKSELECT, 
		0, 0, CW_USEDEFAULT, CW_USEDEFAULT, 
		parent, NULL, inst, NULL);
	if (!m_window)
		return FALSE;
	SetWindowLong(m_window, GWL_USERDATA, reinterpret_cast<LONG>(this));

	::SendMessage(m_window, WM_SETFONT, (WPARAM)(HFONT)GetStockObject(DEFAULT_GUI_FONT), 0);
#ifdef UNICODE
	TreeView_SetUnicodeFormat(m_window, TRUE);
#endif

	return TRUE;
}

bool ObjTreeList::MakeVisible(sint32 oid, bool expand)
{
	map<sint32,HTREEITEM>::const_iterator item = m_objlist.find(oid);
	if (item != m_objlist.end())
	{
		TreeView_EnsureVisible(m_window, item->second);
		if (expand)
			TreeView_Expand(m_window, item->second, TVE_EXPAND);
		return true;
	}
	return false;
}

void ObjTreeList::UpdateObject(sint32 oid)
{
	map<sint32,HTREEITEM>::const_iterator item = m_objlist.find(oid);
	if (item != m_objlist.end())
	{
		RECT itemrc;
		TreeView_GetItemRect(m_window, item->second, &itemrc, FALSE);
		InvalidateRect(m_window, &itemrc, TRUE);
	}
}

void ObjTreeList::AddObject(sint32 oid, sint32 parent)
{
	TVINSERTSTRUCT iteminfo;
	map<sint32,HTREEITEM>::const_iterator i = m_objlist.find(oid);
	if (i != m_objlist.end())
		return;
	i = m_objlist.find(parent);
	if (i != m_objlist.end())
		iteminfo.hParent = i->second;
	else
		iteminfo.hParent = TVI_ROOT;
	iteminfo.item.mask = TVIF_TEXT | TVIF_PARAM;
	iteminfo.item.pszText = LPSTR_TEXTCALLBACK;
	iteminfo.item.lParam = oid;
	iteminfo.hInsertAfter = TVI_LAST;
	HTREEITEM newitem = TreeView_InsertItem(m_window, &iteminfo);
	m_objlist.insert(make_pair(oid, newitem));
}

void ObjTreeList::RemoveObject(sint32 oid)
{
	map<sint32,HTREEITEM>::iterator i = m_objlist.find(oid);
	if (i != m_objlist.end())
	{
		TreeView_DeleteItem(m_window, i->second);
		m_objlist.erase(i);
	}
}

void ObjTreeList::Clear()
{
	TreeView_DeleteAllItems(m_window);
	m_objlist.clear();
}

void ObjTreeList::LoadHierarchy(DarkDB* db, const string& root)
{
	DarkObject* parent = db->GetObject(find_object_id(db, root));
	if (!parent)
	{
		string err("can't find root object: ");
		throw runtime_error(err + root);
	}
	TVINSERTSTRUCT iteminfo;
	iteminfo.item.mask = TVIF_TEXT | TVIF_PARAM;
	iteminfo.item.pszText = LPSTR_TEXTCALLBACK;
	iteminfo.item.lParam = parent->GetId();
	iteminfo.hParent = TVI_ROOT;
	iteminfo.hInsertAfter = TVI_LAST;
	HTREEITEM curr = TreeView_InsertItem(m_window, &iteminfo);
	m_objlist.insert(make_pair(parent->GetId(),curr));
	LoadHierarchy(db, curr, parent);
}

void ObjTreeList::LoadHierarchy(DarkDB* db, HTREEITEM root, DarkObject* obj)
{
	HTREEITEM curr;
	TVINSERTSTRUCT iteminfo;
	iteminfo.item.mask = TVIF_TEXT | TVIF_PARAM;
	iteminfo.item.pszText = LPSTR_TEXTCALLBACK;
	iteminfo.hParent = root;
	iteminfo.hInsertAfter = TVI_FIRST;
	DarkLinkIterator mplinks = obj->GetReverseLinksByFlavor(db->Flavor("MetaProp"));
	while (! mplinks.empty())
	{
		DarkLinkMetaProp* mp = dynamic_cast<DarkLinkMetaProp*>(*mplinks++);
		if (! mp->IsMP())
		{
			DarkObject* child = db->GetObject(mp->GetSource());
			if (child)
			{
				iteminfo.item.lParam = child->GetId();
				curr = TreeView_InsertItem(m_window, &iteminfo);
				m_objlist.insert(make_pair(child->GetId(),curr));
				LoadHierarchy(db, curr, child);
				iteminfo.hInsertAfter = curr;
			}
		}
	}
}

HTREEITEM ObjTreeList::ReParent(DarkDB* db, HTREEITEM olditem, HTREEITEM parent)
{
	TVINSERTSTRUCT iteminfo;
	DarkObject *obj, *base;

	iteminfo.item.mask = TVIF_PARAM;
	iteminfo.item.hItem = olditem;
	TreeView_GetItem(m_window, &iteminfo.item);
	obj = db->GetObject(iteminfo.item.lParam);
	iteminfo.item.hItem = parent;
	TreeView_GetItem(m_window, &iteminfo.item);
	base = db->GetObject(iteminfo.item.lParam);
	if (!obj || !base)
		return NULL;


	obj->SetBase(base->GetId());

	iteminfo.hParent = parent;
	iteminfo.hInsertAfter = TVI_LAST;
	iteminfo.item.mask = TVIF_TEXT | TVIF_PARAM;
	iteminfo.item.pszText = LPSTR_TEXTCALLBACK;
	iteminfo.item.lParam = obj->GetId();
	HTREEITEM newitem = TreeView_InsertItem(m_window, &iteminfo);
	m_objlist[obj->GetId()] = newitem;

	HTREEITEM curr = TreeView_GetChild(m_window, olditem);
	while (curr)
	{
		HTREEITEM next = TreeView_GetNextSibling(m_window, curr);
		ReParent(db, curr, newitem);
		curr = next;
	}

	TreeView_DeleteItem(m_window, olditem);
	return newitem;
}

bool ObjTreeList::ReParent(DarkDB* db, sint32 oid, sint32 parentid)
{
	map<sint32,HTREEITEM>::const_iterator item = m_objlist.find(oid);
	map<sint32,HTREEITEM>::const_iterator parent = m_objlist.find(parentid);
	if (item != m_objlist.end() && parent != m_objlist.end())
	{
		HTREEITEM newitem = ReParent(db, item->second, parent->second);
		if (newitem != NULL)
		{
			TreeView_SelectItem(m_window, newitem);
			return true;
		}
	}
	return false;
}

