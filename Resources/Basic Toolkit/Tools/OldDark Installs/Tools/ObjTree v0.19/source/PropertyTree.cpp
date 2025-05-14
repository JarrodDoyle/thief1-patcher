#include "PropertyTree.h"
#include "PropertySource.h"
#include "resources.h"

#include <stdexcept>
#include <vector>
#include <utility>
#include "DarkLib/parseutils.h"

#ifndef DFCS_HOT
#define DFCS_HOT 0x1000
#endif

#ifndef SPI_GETHOTTRACKING
#define SPI_GETHOTTRACKING 0x100E
#endif

using namespace std;
using namespace Dark;

const TCHAR* PropertyTree::szClassName = TEXT("PropTree");

ATOM PropertyTree::ClassID = 0;

BOOL PropertyTree::RegisterClass(HINSTANCE inst)
{
	WNDCLASS wcl;

	wcl.hInstance = inst;
	wcl.lpszClassName = szClassName;
	wcl.lpfnWndProc = WindowProc;
	wcl.style = 0;
	wcl.hIcon = LoadIcon(inst, MAKEINTRESOURCE(3));
	wcl.hCursor = LoadCursor(NULL, IDC_ARROW);
	wcl.lpszMenuName = NULL;
	wcl.cbClsExtra = 0;
	wcl.cbWndExtra = 0;
	wcl.hbrBackground = (HBRUSH)(COLOR_APPWORKSPACE+1);
	ClassID = ::RegisterClass(&wcl);
	return ClassID != 0;
}

LRESULT CALLBACK PropertyTree::EditWinHook(HWND hwnd, UINT message, WPARAM wparam, LPARAM lparam)
{
	WNDPROC proc = reinterpret_cast<WNDPROC>(GetWindowLong(hwnd, GWL_USERDATA));

	int code;

	if (message == WM_CHAR)
	{
		if (wparam == VK_RETURN)
		{
			code = IDOK;
		}
		else if (wparam == VK_ESCAPE)
		{
			code = IDCANCEL;
		}
		else
			goto l_editwindefault;
		HWND next = GetParent(hwnd);
		TCHAR cn[10];
		GetClassName(next, cn, 10);
		if (! lstrcmpi(cn,TEXT("ComboBox")))
		{
			COMBOBOXINFO cbinfo;
			cbinfo.cbSize = sizeof(COMBOBOXINFO);
			GetComboBoxInfo(next, &cbinfo);
			next = GetParent(next);
			if (IsWindowVisible(cbinfo.hwndList))
				goto l_editwindefault;
		}
		::SendMessage(next, WM_COMMAND, 
				MAKEWPARAM(code,1), (LPARAM)hwnd);
		return 0;
	}
	else if (message == WM_DESTROY)
	{
		SetWindowLong(hwnd, GWL_WNDPROC, reinterpret_cast<LONG>(proc));
	}

l_editwindefault:
	return CallWindowProc(proc, hwnd, message, wparam, lparam);
}

LRESULT CALLBACK PropertyTree::WindowProc(HWND hwnd, UINT message, WPARAM wparam, LPARAM lparam)
{
	static HWND buttonfocus = NULL;

	if (message == WM_CREATE)
	{
		LPCREATESTRUCT info = reinterpret_cast<LPCREATESTRUCT>(lparam);
		PropertyTree* win = reinterpret_cast<PropertyTree*>(info->lpCreateParams);
		SetWindowLong(hwnd, GWL_USERDATA, reinterpret_cast<LONG>(win));
		return 0;
	}
	PropertyTree* win = reinterpret_cast<PropertyTree*>(GetWindowLong(hwnd, GWL_USERDATA));
	
	switch (message)
	{
	  case WM_DESTROY:
		if (win)
		{
			if (win->m_realparent)
			{
				::SendMessage(win->m_realparent, WM_PARENTNOTIFY, 
						MAKEWPARAM(WM_DESTROY,GetWindowLong(hwnd,GWL_ID)), (LPARAM)hwnd);
			}
			if (win->m_bitmenu)
				DestroyMenu(win->m_bitmenu);
		}
		return 0;
	  case WM_SIZE:
		if (win)
			win->AdjustLayout();
		return 0;
	  case WM_SETFOCUS:
		if (win)
			::SetFocus((win->m_currentedit)?win->m_editwin:win->m_listwin);
		return 0;
	  case WM_SETCURSOR:
		if (win)
		{
			POINT pt;
			GetCursorPos(&pt);
			/*
			if (reinterpret_cast<HWND>(wparam) == win->m_listwin)
			{
				ScreenToClient(win->m_listwin, &pt);
				TVHITTESTINFO hitinfo;
				hitinfo.pt = pt;
				if (TreeView_HitTest(win->m_listwin, &hitinfo) && hitinfo.hItem)
				{
					if (win->IsTreeItemLocked(hitinfo.hItem))
					{
						SetCursor(LoadCursor(NULL, IDC_ARROW));
						return TRUE;
					}
				}
			}
			else */
			if (reinterpret_cast<HWND>(wparam) == win->m_buttons[0]
				  || reinterpret_cast<HWND>(wparam) == win->m_buttons[1]
				  || reinterpret_cast<HWND>(wparam) == win->m_bitbutton)
			{
				if (buttonfocus != reinterpret_cast<HWND>(wparam))
				{
					if (buttonfocus)
						InvalidateRect(buttonfocus, NULL, FALSE);
					buttonfocus = reinterpret_cast<HWND>(wparam);
					InvalidateRect(buttonfocus, NULL, FALSE);
				}
			}
			if (buttonfocus && buttonfocus != reinterpret_cast<HWND>(wparam))
			{
				InvalidateRect(buttonfocus, NULL, FALSE);
				buttonfocus = NULL;
			}
		}
		break;
	  case WM_SETTINGCHANGE:
	  case WM_SYSCOLORCHANGE:
		if (win)
		{
			win->m_listwin.SendMessage(message, wparam, lparam);
			win->m_textwin.SendMessage(message, wparam, lparam);
			win->m_combowin.SendMessage(message, wparam, lparam);
			win->m_bitbutton.SendMessage(message, wparam, lparam);
			win->m_buttons[0].SendMessage(message, wparam, lparam);
			win->m_buttons[1].SendMessage(message, wparam, lparam);
			win->AdjustLayout();
		}
		break;
	  case WM_COMMAND:
		if (win)
		{
			if (LOWORD(wparam) >= IDM_BITFIELD && LOWORD(wparam) < IDM_BITFIELDLAST)
			{
				win->ToggleMenuBit(LOWORD(wparam));
				return 0;
			}
			switch (LOWORD(wparam))
			{
			  case IDOK:
				if (!win->EndEditProperty())
				{
					MessageBeep(MB_ICONEXCLAMATION);
					win->m_editwin.SendMessage((win->m_editstate==stateNormal)?EM_SETSEL:CB_SETEDITSEL,
								0, (LPARAM)-1);
				}
				return 0;
			  case IDCANCEL:
				win->EndEditProperty(true);
				return 0;
			case IDM_BITBUTTON:
				if (win->m_bitmenu)
				{
					POINT pt;
					GetCursorPos(&pt);
					TPMPARAMS parms;
					parms.cbSize = sizeof(TPMPARAMS);
					GetWindowRect(win->m_bitbutton, &parms.rcExclude);
					TrackPopupMenuEx(win->m_bitmenu, TPM_LEFTBUTTON | TPM_RIGHTALIGN | TPM_VERTICAL,
							pt.x, pt.y, hwnd, &parms);
				}
				return 0;
			}
		}
		break;
	  case WM_NOTIFY:
		if (win)
		{
			switch (reinterpret_cast<LPNMHDR>(lparam)->code)
			{
			  case NM_CUSTOMDRAW:
			  {
				LPNMTVCUSTOMDRAW cdinfo = reinterpret_cast<LPNMTVCUSTOMDRAW>(lparam);
				if (cdinfo->nmcd.dwDrawStage == CDDS_PREPAINT)
					return CDRF_NOTIFYITEMDRAW;
				if (cdinfo->nmcd.dwDrawStage == CDDS_ITEMPREPAINT)
				{
					if (win->IsTreeItemLocked(reinterpret_cast<HTREEITEM>(cdinfo->nmcd.dwItemSpec)))
					{
						cdinfo->clrText = GetSysColor(COLOR_GRAYTEXT);
						cdinfo->clrTextBk = (cdinfo->nmcd.uItemState & CDIS_SELECTED) ?
								GetSysColor(COLOR_ACTIVECAPTION) : GetSysColor(COLOR_3DFACE);
						TVITEM iteminfo;
						iteminfo.hItem = reinterpret_cast<HTREEITEM>(cdinfo->nmcd.dwItemSpec);
						iteminfo.mask = TVIF_CHILDREN;
						TreeView_GetItem(win->m_listwin, &iteminfo);
						if ((cdinfo->nmcd.uItemState & CDIS_HOT) && (iteminfo.cChildren == 0))
						{
							LOGFONT finfo;
							TEXTMETRIC metrics;
							GetTextMetrics(cdinfo->nmcd.hdc, &metrics);
							GetTextFace(cdinfo->nmcd.hdc, LF_FACESIZE, finfo.lfFaceName);
							finfo.lfHeight = metrics.tmHeight;
							finfo.lfWidth = metrics.tmAveCharWidth;
							finfo.lfEscapement = 0;
							finfo.lfOrientation = 0;
							finfo.lfWeight = metrics.tmWeight;
							finfo.lfItalic = metrics.tmItalic;
							finfo.lfUnderline = FALSE;
							finfo.lfStrikeOut = metrics.tmStruckOut;
							finfo.lfCharSet = metrics.tmCharSet;
							finfo.lfPitchAndFamily = metrics.tmPitchAndFamily;
							finfo.lfOutPrecision = OUT_DEFAULT_PRECIS;
							finfo.lfClipPrecision = CLIP_DEFAULT_PRECIS;
							finfo.lfQuality = DEFAULT_QUALITY;
							HFONT f = CreateFontIndirect(&finfo);
							if (f)
							{
								SelectObject(cdinfo->nmcd.hdc, f);
								return CDRF_NEWFONT;
							}
						}
					}
				}
				return CDRF_DODEFAULT;
			  }
			  case TVN_GETDISPINFO:
			  {
				TVITEM& item = reinterpret_cast<LPNMTVDISPINFO>(lparam)->item;
				string itemname = win->Display(*reinterpret_cast<string*>(item.lParam));
#ifdef UNICODE
				int n = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
						itemname.data(), itemname.size(),
						item.pszText, item.cchTextMax);
				item.pszText[n] = TEXT('\0');
#else
				itemname.copy(item.pszText, item.cchTextMax);
				item.pszText[min(item.cchTextMax,int(itemname.size()))] = '\0';
#endif
				return 0;
			  }
			  case TVN_ITEMEXPANDED:
			  {
				LPNMTREEVIEW info = reinterpret_cast<LPNMTREEVIEW>(lparam);
				if (GetKeyState(VK_MENU) & 0x8000)
				{
					HTREEITEM curr = TreeView_GetChild(info->hdr.hwndFrom, info->itemNew.hItem);
					while (curr)
					{
						TreeView_Expand(info->hdr.hwndFrom, curr, info->action);
						curr = TreeView_GetNextSibling(info->hdr.hwndFrom, curr);
					}
				}
				return FALSE;
			  }
			  case TVN_SELCHANGING:
			  {
				LPNMTREEVIEW info = reinterpret_cast<LPNMTREEVIEW>(lparam);
				if (win->IsTreeItemLocked(info->itemNew.hItem))
				{
					/*
					if (info->action == TVC_BYKEYBOARD)
					{
						HTREEITEM next = win->GetNextUnlocked(info->itemNew.hItem, TVGN_NEXTVISIBLE);
						if (next && next != info->itemOld.hItem)
						{
							TreeView_SelectItem(win->m_listwin, next);
						}
						else
						{
							next = win->GetNextUnlocked(info->itemNew.hItem, TVGN_PREVIOUSVISIBLE);
							if (next && next != info->itemOld.hItem)
							{
								TreeView_SelectItem(win->m_listwin, next);
							}
						}
					}
					*/
					if (info->action == TVC_BYMOUSE)
						return TRUE;
				}
				return FALSE;
			  }
			  case TVN_DELETEITEM:
			  {
				LPNMTREEVIEW info = reinterpret_cast<LPNMTREEVIEW>(lparam);
				if (reinterpret_cast<string*>(info->itemOld.lParam) == win->m_currentedit)
					win->EndEditProperty(true);
				win->m_properties.erase(*reinterpret_cast<string*>(info->itemOld.lParam));
				return FALSE;
			  }
			  case NM_RETURN:
			  {
				if (reinterpret_cast<LPNMHDR>(lparam)->hwndFrom == win->m_listwin)
				{
					TVITEM info;
					info.hItem = TreeView_GetSelection(win->m_listwin);
					if (info.hItem)
					{
						info.mask = TVIF_CHILDREN | TVIF_PARAM;
						TreeView_GetItem(win->m_listwin, &info);
						if (info.cChildren == 0)
						{
							if (!win->IsTreeItemLocked(info.hItem))
							{
								string* itemname = reinterpret_cast<string*>(info.lParam);
								if (! win->m_currentedit)
									win->BeginEditProperty(itemname);
								else if (win->m_currentedit == itemname)
									win->m_editwin.Focus();
								else
									MessageBeep(0);
							}
						}
						else
						{
							TreeView_Expand(win->m_listwin, info.hItem, TVE_TOGGLE);
						}
						return TRUE;
					}
				}
				else if (reinterpret_cast<LPNMHDR>(lparam)->hwndFrom == win->m_editwin)
				{
					return win->EndEditProperty();
				}
				break;
			  }
			  case NM_DBLCLK:
			  {
				TVHITTESTINFO hitinfo;
				GetCursorPos(&hitinfo.pt);
				ScreenToClient(win->m_listwin, &hitinfo.pt);
				HTREEITEM hititem = TreeView_HitTest(win->m_listwin, &hitinfo);
				if (hititem)
				{
					TVITEM info;
					info.hItem = hititem;
					info.mask = TVIF_CHILDREN | TVIF_PARAM;
					TreeView_GetItem(win->m_listwin, &info);
					if (info.cChildren == 0)
					{
						if (!win->IsTreeItemLocked(info.hItem))
						{
							string* itemname = reinterpret_cast<string*>(info.lParam);
							if (! win->m_currentedit)
								win->BeginEditProperty(itemname);
							else if (win->m_currentedit == itemname)
								win->m_editwin.Focus();
							else
								MessageBeep(0);
						}
						return TRUE;
					}
				}
				break;
			  }
			case NM_KILLFOCUS:
			case NM_SETFOCUS:
				if (reinterpret_cast<LPNMHDR>(lparam)->hwndFrom == win->m_listwin)
				{
					NMHDR info;
					info.hwndFrom = win->m_window;
					info.idFrom = GetWindowLong(win->m_window, GWL_ID);
					info.code = reinterpret_cast<LPNMHDR>(lparam)->code;
					::SendMessage(GetParent(hwnd), WM_NOTIFY, info.idFrom, 
							reinterpret_cast<LPARAM>(&info));
					return 0;
				}
				break;
			}
		}
		break;
	  case WM_MEASUREITEM:
	  {
		LPMEASUREITEMSTRUCT info = reinterpret_cast<LPMEASUREITEMSTRUCT>(lparam);
		info->itemWidth = GetSystemMetrics(SM_CYMENU);
		info->itemHeight = GetSystemMetrics(SM_CYBORDER) * 2 + info->itemWidth;
		return 0;
	  }
	  case WM_DRAWITEM:
	  {
		LPDRAWITEMSTRUCT info = reinterpret_cast<LPDRAWITEMSTRUCT>(lparam);
		RECT itemrc;
		CopyRect(&itemrc, &info->rcItem);
		if (info->hwndItem == win->m_bitbutton)
		{
			UINT flags = DFCS_SCROLLCOMBOBOX;
			if (info->itemState & ODS_DISABLED)
				flags |= DFCS_INACTIVE;
			else
			{
				if (info->itemState & ODS_SELECTED)
					flags |= DFCS_PUSHED;
				if (buttonfocus == info->hwndItem)
					flags |= DFCS_HOT;
			}
			DrawFrameControl(info->hDC, &itemrc, DFC_SCROLL, flags);
		}
		else
		{
			UINT flags = DFCS_BUTTONPUSH | DFCS_ADJUSTRECT;
			if (info->itemState & ODS_DISABLED)
				flags |= DFCS_INACTIVE | DFCS_FLAT;
			else
			{
				if (info->itemState & ODS_SELECTED)
					flags |= DFCS_PUSHED;
				if (buttonfocus != info->hwndItem)
					flags |= DFCS_FLAT;
				else
					flags |= DFCS_HOT;
			}
			DrawFrameControl(info->hDC, &itemrc, DFC_BUTTON, flags);
			HICON hicon = reinterpret_cast<HICON>(GetWindowLong(info->hwndItem, GWL_USERDATA));
			if (hicon)
			{
				HANDLE sicon = CopyImage((HANDLE)hicon, IMAGE_ICON, 
						itemrc.right-itemrc.left, itemrc.bottom-itemrc.top,
						LR_COPYFROMRESOURCE);
				DrawState(info->hDC, NULL, NULL, reinterpret_cast<LPARAM>(sicon), 0, 
						itemrc.left, itemrc.top, itemrc.right-itemrc.left, itemrc.bottom-itemrc.top,
						DST_ICON | ((info->itemState&ODS_DISABLED)?DSS_DISABLED:DSS_NORMAL));
			}
			else
			{
				HRGN clip = CreateRectRgnIndirect(&itemrc);
				SelectClipRgn(info->hDC, clip);
				TCHAR label[8];
				int len = GetWindowText(info->hwndItem, label, 7);
				DrawState(info->hDC, NULL, NULL, reinterpret_cast<LPARAM>(label), len, 
						itemrc.left, itemrc.top, itemrc.right-itemrc.left, itemrc.bottom-itemrc.top,
						DST_TEXT | ((info->itemState&ODS_DISABLED)?DSS_DISABLED:DSS_NORMAL));
			}
		}
		//if (info->itemState & ODS_FOCUS)
		//	DrawFocusRect(info->hDC, &info->rcItem);
		return TRUE;
	  }
	}
	return DefWindowProc(hwnd, message, wparam, lparam);
}

BOOL PropertyTree::IsTreeItemLocked(HTREEITEM item)
{
	TVITEM iteminfo;
	iteminfo.mask = TVIF_STATE;
	iteminfo.stateMask = TVIS_OVERLAYMASK;
	while (item)
	{
		iteminfo.hItem = item;
		TreeView_GetItem(m_listwin, &iteminfo);
		if ((iteminfo.state & TVIS_OVERLAYMASK) == INDEXTOOVERLAYMASK(stateLocked))
			return TRUE;
		item = TreeView_GetParent(m_listwin, item);
	}
	return FALSE;
}

HTREEITEM PropertyTree::GetNextUnlocked(HTREEITEM curr, int dir)
{
	TVITEM info;
	info.mask = TVIF_STATE;
	info.stateMask = TVIS_OVERLAYMASK;
	curr = TreeView_GetNextItem(m_listwin, curr, dir);
	while (curr)
	{
		info.hItem = curr;
		TreeView_GetItem(m_listwin, &info);
		if ((info.state & TVIS_OVERLAYMASK) != INDEXTOOVERLAYMASK(stateLocked))
			break;
		curr = TreeView_GetNextItem(m_listwin, curr, dir);
	}
	return curr;
}

PropertyTree::~PropertyTree()
{
	SetWindowLong(m_window, GWL_USERDATA, 0);
}

PropertyTree::PropertyTree(void* data)
	: Window(), m_source(NULL), m_currentedit(NULL), m_editstate(stateNormal),
	  m_realparent(NULL), m_userdata(data)
{
}

PropertyTree::PropertyTree(HWND parent, HINSTANCE inst, void* data)
	: Window(), m_source(NULL), m_currentedit(NULL), m_editstate(stateNormal),
	  m_realparent(NULL), m_userdata(data)
{
	Create(parent, inst);
}

PropertyTree::PropertyTree(PropertySource* src, void* data)
	: Window(), m_source(src), m_currentedit(NULL), m_editstate(stateNormal),
	  m_realparent(NULL), m_userdata(data)
{
}

PropertyTree::PropertyTree(PropertySource* src, HWND parent, HINSTANCE inst, void* data)
	: Window(), m_source(src), m_currentedit(NULL), m_editstate(stateNormal),
	  m_realparent(NULL), m_userdata(data)
{
	Create(parent, inst);
}

/* Cheap hacks & candy
 * Windows insists that the "owner" of an overlapped window be a top-level window
 * which excludes the MDI child windows that I'm using to create this.
 * So... let's just tell Windows to fuck-off and do things ourselves.
 */
HWND PropertyTree::SetRealParent(HWND parent)
{
	HWND tmp = m_realparent;
	m_realparent = parent;
	return tmp;
}

BOOL PropertyTree::Create(HWND parent, HINSTANCE inst)
{
	m_window = CreateWindowEx(0, szClassName, NULL,
			WS_CHILD ,
			0, 0, CW_USEDEFAULT, CW_USEDEFAULT, 
			parent, NULL, inst, reinterpret_cast<void*>(this));
	if (!m_window)
		return FALSE;

	if (!CreateChildren(inst))
	{
		DestroyWindow(m_window);
		return FALSE;
	}

	DisableEdit();
	return TRUE;
}

BOOL PropertyTree::Create(HWND parent, HINSTANCE inst, LPCTSTR name)
{
	m_window = CreateWindowEx(WS_EX_WINDOWEDGE, szClassName, name,
			WS_OVERLAPPED | WS_BORDER | WS_CAPTION | WS_SYSMENU | WS_SIZEBOX,
			CW_USEDEFAULT, CW_USEDEFAULT, 200, 300, 
			parent, NULL, inst, reinterpret_cast<void*>(this));
	if (!m_window)
		return FALSE;

	if (!CreateChildren(inst))
	{
		DestroyWindow(m_window);
		return FALSE;
	}

	DisableEdit();
	return TRUE;
}

BOOL PropertyTree::CreateChildren(HINSTANCE inst)
{
	HFONT guifont = (HFONT)GetStockObject(DEFAULT_GUI_FONT);
	int height = GetSystemMetrics(SM_CYMENU);
	RECT rc;
	GetClientRect(m_window, &rc);

	{
		m_listwin = CreateWindowEx(0, WC_TREEVIEW, NULL,
				WS_CHILD | WS_VISIBLE | WS_BORDER 
				| TVS_SHOWSELALWAYS | TVS_FULLROWSELECT | TVS_DISABLEDRAGDROP | TVS_TRACKSELECT,
				0, height*2, rc.right, rc.bottom-(height*2),
				m_window, NULL, inst, NULL);
		if (!m_listwin)
			return FALSE;
		m_listwin.SendMessage(WM_SETFONT, (WPARAM)guifont, 0);
#ifdef UNICODE
		TreeView_SetUnicodeFormat(m_listwin, TRUE);
#endif
		HIMAGELIST images = ImageList_LoadImage(inst, MAKEINTRESOURCE(ID_LISTICONS), 10, 1,
				RGB(255,255,255), IMAGE_BITMAP, LR_SHARED);
		TreeView_SetImageList(m_listwin, images, TVSIL_NORMAL);
	}

	{
		m_textwin = CreateWindowEx(WS_EX_CLIENTEDGE, TEXT("Edit"), TEXT(""),
				WS_CHILD | WS_VISIBLE | WS_BORDER | ES_AUTOHSCROLL,
				0, 0, rc.right-(height*2), height,
				m_window, NULL, inst, NULL);
		if (!m_textwin)
			return FALSE;
		m_textwin.SendMessage(WM_SETFONT, (WPARAM)(HFONT)guifont, 0);
		LONG oldeditproc = SetWindowLong(m_textwin, GWL_WNDPROC, reinterpret_cast<LONG>(EditWinHook));
		SetWindowLong(m_textwin, GWL_USERDATA, oldeditproc);
	}
	{
		m_combowin = CreateWindowEx(WS_EX_CLIENTEDGE, TEXT("ComboBox"), TEXT(""),
				WS_CHILD | WS_BORDER | CBS_DROPDOWN | CBS_AUTOHSCROLL | WS_VSCROLL,
				0, 0, rc.right-(height*2), height,
				m_window, NULL, inst, NULL);
		if (!m_combowin)
			return FALSE;
		m_combowin.SendMessage(WM_SETFONT, (WPARAM)guifont, 0);
		m_combowin.SendMessage(CB_SETLOCALE, (WPARAM)GetUserDefaultLCID(), 0);
		COMBOBOXINFO cbinfo;
		cbinfo.cbSize = sizeof(COMBOBOXINFO);
		GetComboBoxInfo(m_combowin, &cbinfo);
		LONG oldeditproc = SetWindowLong(cbinfo.hwndItem, GWL_WNDPROC, reinterpret_cast<LONG>(EditWinHook));
		SetWindowLong(cbinfo.hwndItem, GWL_USERDATA, oldeditproc);
	}

	m_bitbutton = CreateWindowEx(0, TEXT("Button"), TEXT(""),
			WS_CHILD | BS_PUSHBUTTON | BS_OWNERDRAW,
			rc.right-(height*3), 0, height, height,
			m_window, (HMENU)IDM_BITBUTTON, inst, NULL);
	m_bitbutton.SendMessage(WM_SETFONT, (WPARAM)guifont, 0);

	m_buttons[0] = CreateWindowEx(0, TEXT("Button"), TEXT("OK"),
			WS_CHILD | WS_VISIBLE | BS_OWNERDRAW ,
			rc.right-(height*2), 0, height, height,
			m_window, (HMENU)IDOK, inst, NULL);
	m_buttons[0].SendMessage(WM_SETFONT, (WPARAM)guifont, 0);
	m_buttons[1] = CreateWindowEx(0, TEXT("Button"), TEXT("Esc"),
			WS_CHILD | WS_VISIBLE | BS_OWNERDRAW ,
			rc.right-height, 0, height, height,
			m_window, (HMENU)IDCANCEL, inst, NULL);
	m_buttons[1].SendMessage(WM_SETFONT, (WPARAM)guifont, 0);

	HANDLE hicon = LoadImage(inst, MAKEINTRESOURCE(ID_OKBUTTON), IMAGE_ICON, 0, 0, LR_SHARED);
	SetWindowLong(m_buttons[0], GWL_USERDATA, reinterpret_cast<LONG>(hicon));
	hicon = LoadImage(inst, MAKEINTRESOURCE(ID_CANCELBUTTON), IMAGE_ICON, 0, 0, LR_SHARED);
	SetWindowLong(m_buttons[1], GWL_USERDATA, reinterpret_cast<LONG>(hicon));

	return TRUE;
}

void PropertyTree::AdjustLayout()
{
	RECT rc;
	int height = GetSystemMetrics(SM_CYMENU);
	int border = GetSystemMetrics(SM_CYBORDER);
	int listtop = height + border*2;
	GetClientRect(m_window, &rc);
	HDWP pos = BeginDeferWindowPos(6);
	DeferWindowPos(pos, m_listwin, NULL, 0, listtop, rc.right, rc.bottom-listtop, SWP_NOZORDER | SWP_NOACTIVATE);
	int dropdownheight = listtop;
	if (m_editstate == stateDropdown)
	{
		dropdownheight = (m_combowin.SendMessage(CB_GETCOUNT, 0, 0) + 1) * m_combowin.SendMessage(CB_GETITEMHEIGHT, 0, 0);
		if (dropdownheight > rc.bottom)
			dropdownheight = rc.bottom;
		m_combowin.SendMessage(CB_SETITEMHEIGHT, (WPARAM)-1, listtop);
	}
	DeferWindowPos(pos, m_combowin, NULL, 0, 0, rc.right-(height*2), dropdownheight, SWP_NOZORDER | SWP_NOACTIVATE);
	if (m_editstate == stateBitfield)
		DeferWindowPos(pos, m_textwin, NULL, 0, 0, rc.right-(height*3), listtop, SWP_NOZORDER | SWP_NOACTIVATE);
	else
		DeferWindowPos(pos, m_textwin, m_bitbutton, 0, 0, rc.right-(height*2), listtop, SWP_NOZORDER | SWP_NOACTIVATE);
	DeferWindowPos(pos, m_bitbutton, NULL, rc.right-(height*3), 0, height, listtop, SWP_NOZORDER | SWP_NOACTIVATE);
	DeferWindowPos(pos, m_buttons[0], NULL, rc.right-(height*2), 0, height, listtop, SWP_NOZORDER | SWP_NOACTIVATE);
	DeferWindowPos(pos, m_buttons[1], NULL, rc.right-height, 0, height, listtop, SWP_NOZORDER | SWP_NOACTIVATE);
	EndDeferWindowPos(pos);
}

void PropertyTree::DisableEdit()
{
	m_editstate = stateNormal;
	m_editwin = m_textwin;

	m_textwin.Disable();
	m_combowin.Disable();
	m_bitbutton.Disable();
	m_buttons[0].Disable();
	m_buttons[1].Disable();

	m_textwin.Show();
	m_combowin.Hide();
	m_bitbutton.Hide();

	AdjustLayout();
}

void PropertyTree::EnableEdit(PropertyState state)
{
	m_editstate = state;
	switch (state)
	{
	case stateNormal:
		m_textwin.Enable();
		m_textwin.Show();
		m_combowin.Hide();
		m_editwin = m_textwin;
		break;
	case stateBoolean:
		m_editstate = stateDropdown;
	case stateDropdown:
		m_combowin.Enable();
		m_combowin.Show();
		m_textwin.Hide();
		m_editwin = m_combowin;
		break;
	case stateBitfield:
		m_textwin.Enable();
		m_bitbutton.Enable();
		m_textwin.Show();
		m_bitbutton.Show();
		m_combowin.Hide();
		m_editwin = m_textwin;
		break;
	case stateLocked:
		return;
	}
	m_buttons[0].Enable();
	m_buttons[1].Enable();

	AdjustLayout();
}

void PropertyTree::ToggleMenuBit(DWORD id)
{
	MENUITEMINFO info;
	info.cbSize = sizeof(MENUITEMINFO);
	info.fMask = MIIM_STATE | MIIM_TYPE | MIIM_DATA;
	info.dwTypeData = NULL;
	if (GetMenuItemInfo(m_bitmenu, id, FALSE, &info))
	{
		info.dwTypeData = new TCHAR[++info.cch];
		GetMenuItemInfo(m_bitmenu, id, FALSE, &info);
#ifdef UNICODE
		int buflen = WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK | WC_DISCARDNS | WC_DEFAULTCHAR,
				info.dwTypeData, info.cch, NULL, 0, NULL, NULL);
		char buf[buflen+1];
		buflen = WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK | WC_DISCARDNS | WC_DEFAULTCHAR,
				info.dwTypeData, info.cch, buf, buflen, NULL, NULL);
		string name(buf, buflen);
#else
		string name(info.dwTypeData, info.cch);
#endif
		string data = GetEditText();
		if (info.fState & MFS_CHECKED)
		{
			data = clear_symbol_in_bitstring(data, name, info.dwItemData);
			info.fState = MFS_UNCHECKED;
		}
		else
		{
			data = set_symbol_in_bitstring(data, name, info.dwItemData);
			info.fState = MFS_CHECKED;
		}
		SetEditText(data);
		info.fMask = MIIM_STATE;
		SetMenuItemInfo(m_bitmenu, id, FALSE, &info);
		delete[] info.dwTypeData;
	}
}

string PropertyTree::GetEditText()
{
	int buflen = m_editwin.SendMessage(WM_GETTEXTLENGTH, 0, 0);
	TCHAR buf[buflen+1];
	buflen = m_editwin.SendMessage(WM_GETTEXT, buflen+1, (LPARAM)buf);
#ifdef UNICODE
	int wbuflen = WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK | WC_DISCARDNS | WC_DEFAULTCHAR,
			buf, buflen, NULL, 0, NULL, NULL);
	char wbuf[wbuflen+1];
	wbuflen = WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK | WC_DISCARDNS | WC_DEFAULTCHAR,
			buf, buflen, wbuf, wbuflen, NULL, NULL);
	return string(wbuf, wbuflen);
#else
	return string(buf, buflen);
#endif
}

void PropertyTree::SetEditText(const string& data)
{
	if (data.size() == 0)
	{
		m_editwin.SendMessage(WM_SETTEXT, 0, (LPARAM)TEXT(""));
	}
	else
	{
#ifdef UNICODE
		int buflen = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED,
				data.data(), data.size(), NULL, 0);
		TCHAR buf[buflen+1];
		buflen = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED,
				data.data(), data.size(), buf, buflen);
		buf[buflen] = TEXT('\0');
		m_editwin.SendMessage(WM_SETTEXT, 0, (LPARAM)buf);
		//delete[] buf;
#else
		m_editwin.SendMessage(WM_SETTEXT, 0, (LPARAM)data.c_str());
#endif
	}
}

PropertySource* PropertyTree::SetSource(PropertySource* src)
{
	PropertySource* tmp = m_source;
	m_source = src;
	return tmp;
}

string PropertyTree::Display(const string& name)
{
	if (!m_source)
		return name;

	string label;
	string data;
	if (!m_source->Get(name, label, data))
		return string("<error>");

	if (data.size() != 0)
	{
		label += " = ";
		label += data;
	}
	return label;
}

void PropertyTree::SetState(const string& name, PropertyState state)
{
	map<string,HTREEITEM>::iterator item = m_properties.find(name);
	if (item != m_properties.end())
	{
		//if (m_currentedit == &i->first)
		//	EndEditProperty(true);
		TVITEM iteminfo;
		iteminfo.hItem = item->second;
		iteminfo.mask = TVIF_STATE;
		iteminfo.stateMask = TVIS_OVERLAYMASK;
		iteminfo.state = INDEXTOOVERLAYMASK(state);
		TreeView_SetItem(m_listwin, &iteminfo);

		RECT itemrc;
		TreeView_GetItemRect(m_listwin, item->second, &itemrc, FALSE);
		InvalidateRect(m_listwin, &itemrc, TRUE);
	}
}

const string& PropertyTree::GetSelection()
{
	TVITEM item;
	item.hItem = TreeView_GetSelection(m_listwin);
	if (! item.hItem)
		throw out_of_range("PropertyTree::GetSelection");
	item.mask = TVIF_PARAM;
	TreeView_GetItem(m_listwin, &item);
	return *reinterpret_cast<string*>(item.lParam);
}

void PropertyTree::MakeVisible(const string& name, bool expand)
{
	map<string,HTREEITEM>::iterator item = m_properties.find(name);
	if (item != m_properties.end())
	{
		TreeView_EnsureVisible(m_listwin, item->second);
		if (expand)
			TreeView_Expand(m_listwin, item->second, TVE_EXPAND);
	}
}

void PropertyTree::UpdateProperty(const string& name)
{
	map<string,HTREEITEM>::iterator item = m_properties.find(name);
	if (item != m_properties.end())
	{
		RECT itemrc;
		if (TreeView_GetItemRect(m_listwin, item->second, &itemrc, FALSE))
			InvalidateRect(m_listwin, &itemrc, TRUE);
	}
}

void PropertyTree::Clear()
{
	if (m_currentedit)
		EndEditProperty(true);
	m_properties.clear();
	TreeView_DeleteAllItems(m_listwin);
}

bool PropertyTree::AddProperty(const string& name)
{
	map<string,HTREEITEM>::iterator i = m_properties.find(name);
	if (i != m_properties.end())
		return false;
	i = m_properties.insert(i, make_pair(name,HTREEITEM(NULL)));
	HTREEITEM item;
	TVINSERTSTRUCT info;
	info.hParent = TVI_ROOT;
	info.hInsertAfter = TVI_LAST;
	info.item.mask = TVIF_TEXT | TVIF_IMAGE | TVIF_PARAM;
	info.item.pszText = LPSTR_TEXTCALLBACK;
	info.item.iImage = 0;
	info.item.lParam = reinterpret_cast<LPARAM>(&i->first);
	item = TreeView_InsertItem(m_listwin, &info);
	if (!item)
	{
		m_properties.erase(i);
		return false;
	}
	i->second = item;
	return true;
}

bool PropertyTree::AddProperty(const string& name, const string& parent)
{
	HTREEITEM item;
	map<string,HTREEITEM>::iterator i = m_properties.find(parent);
	if (i == m_properties.end())
		return false;
	item = i->second;

	i = m_properties.find(name);
	if (i != m_properties.end())
		return false;
	i = m_properties.insert(i, make_pair(name,HTREEITEM(NULL)));

	TVINSERTSTRUCT info;
	info.hParent = item;
	info.hInsertAfter = TVI_LAST;
	info.item.mask = TVIF_TEXT | TVIF_IMAGE | TVIF_PARAM;
	info.item.pszText = LPSTR_TEXTCALLBACK;
	info.item.iImage = 0;
	info.item.lParam = reinterpret_cast<LPARAM>(&i->first);
	item = TreeView_InsertItem(m_listwin, &info);
	if (!item)
	{
		m_properties.erase(i);
		return false;
	}
	i->second = item;
	return true;
}

bool PropertyTree::AddProperty(const string& name, const string& parent, const string& after)
{
	HTREEITEM item, root;
	map<string,HTREEITEM>::iterator i;

	if (parent.size() == 0)
	{
		root = TVI_ROOT;
	}
	else
	{
		i = m_properties.find(parent);
		if (i == m_properties.end())
			return false;
		root = i->second;
	}
	
	i = m_properties.find(after);
	if (i == m_properties.end())
		return false;
	item = i->second;

	i = m_properties.find(name);
	if (i != m_properties.end())
		return false;
	i = m_properties.insert(i, make_pair(name,HTREEITEM(NULL)));

	TVINSERTSTRUCT info;
	info.hParent = root;
	info.hInsertAfter = item;
	info.item.mask = TVIF_TEXT | TVIF_IMAGE | TVIF_PARAM;
	info.item.pszText = LPSTR_TEXTCALLBACK;
	info.item.iImage = 0;
	info.item.lParam = reinterpret_cast<LPARAM>(&i->first);
	item = TreeView_InsertItem(m_listwin, &info);
	if (!item)
	{
		m_properties.erase(i);
		return false;
	}
	i->second = item;
	return true;
}

void PropertyTree::RemoveProperty(const string& name)
{
	map<string,HTREEITEM>::iterator i = m_properties.find(name);
	if (i != m_properties.end())
	{
		if (m_currentedit == &i->first)
			EndEditProperty(true);
		TreeView_DeleteItem(m_listwin, i->second);
	}
}

/*
 * The PTN_ notifications are sent as if the property were
 * being editted manually, except that the PTN_PROPERTYCHANGED 
 * message will have the olddata and newdata fields set to NULL.
 * So the parent window has a chance to do any pre/post-processing,
 * but we don't want to trigger anything like an undo history.
 * (The undo action is likely what called SetPropertyData in the first place.)
 * Also, Validate isn't called because I'm too lazy to create a temporary
 * string, and wouldn't know what to do with it if it were modified.
 */
bool PropertyTree::SetPropertyData(const string& name, const string& data)
{
	if (!m_source)
		return false;

	map<string,HTREEITEM>::const_iterator item = m_properties.find(name);
	if (item == m_properties.end())
		return false;
	
	PropertyState state = stateNormal;
	{
		TVITEM iteminfo;
		iteminfo.mask = TVIF_STATE;
		iteminfo.stateMask = TVIS_OVERLAYMASK;
		iteminfo.hItem = item->second;
		TreeView_GetItem(m_listwin, &iteminfo);
		state = PropertyState((iteminfo.state & TVIS_OVERLAYMASK) >> 8);
	}
	if (state == stateLocked)
		return false;

	Window parent = (m_realparent) ? m_realparent : GetParent(m_window);
	if (parent)
	{
		PTNINFO msginfo;
		msginfo.hdr.hwndFrom = m_window;
		msginfo.hdr.idFrom = GetWindowLong(m_window, GWL_ID);
		msginfo.hdr.code = PTN_PROPERTYCHANGING;
		msginfo.name = &name;
		msginfo.userdata = m_userdata;
		msginfo.olddata = msginfo.newdata = NULL;
		if (parent.SendMessage(WM_NOTIFY, msginfo.hdr.idFrom, reinterpret_cast<LPARAM>(&msginfo)))
			return false;
	}

	if (! m_source->Set(name, data))
	{
		if (parent)
		{
			PTNINFO msginfo;
			msginfo.hdr.hwndFrom = m_window;
			msginfo.hdr.idFrom = GetWindowLong(m_window, GWL_ID);
			msginfo.hdr.code = PTN_PROPERTYCHANGECANCELED;
			msginfo.name = &name;
			msginfo.userdata = m_userdata;
			msginfo.olddata = msginfo.newdata = NULL;
			::SendMessage(parent, WM_NOTIFY, msginfo.hdr.idFrom, reinterpret_cast<LPARAM>(&msginfo));
		}
		return false;
	}

	if (parent)
	{
		PTNINFO msginfo;
		msginfo.hdr.hwndFrom = m_window;
		msginfo.hdr.idFrom = GetWindowLong(m_window, GWL_ID);
		msginfo.hdr.code = PTN_PROPERTYCHANGED;
		msginfo.name = &name;
		msginfo.userdata = m_userdata;
		msginfo.olddata = msginfo.newdata = NULL;
		::SendMessage(parent, WM_NOTIFY, msginfo.hdr.idFrom, reinterpret_cast<LPARAM>(&msginfo));
	}

	{
		RECT itemrc;
		if (TreeView_GetItemRect(m_listwin, item->second, &itemrc, FALSE))
			InvalidateRect(m_listwin, &itemrc, TRUE);
		TreeView_EnsureVisible(m_listwin, item->second);
	}

	return true;
}

bool PropertyTree::BeginEditProperty(const string* name)
{
	if (!m_source)
		return false;

	map<string,HTREEITEM>::const_iterator item = m_properties.find(*name);
	if (item == m_properties.end())
		return false;
	
	PropertyState state = stateNormal;
	{
		TVITEM iteminfo;
		iteminfo.mask = TVIF_STATE;
		iteminfo.stateMask = TVIS_OVERLAYMASK;
		iteminfo.hItem = item->second;
		TreeView_GetItem(m_listwin, &iteminfo);
		state = PropertyState((iteminfo.state & TVIS_OVERLAYMASK) >> 8);
	}
	if (state == stateLocked)
		return false;

	Window parent = (m_realparent) ? m_realparent : GetParent(m_window);
	if (parent)
	{
		PTNINFO msginfo;
		msginfo.hdr.hwndFrom = m_window;
		msginfo.hdr.idFrom = GetWindowLong(m_window, GWL_ID);
		msginfo.hdr.code = PTN_PROPERTYCHANGING;
		msginfo.name = name;
		msginfo.userdata = m_userdata;
		msginfo.olddata = msginfo.newdata = NULL;
		if (parent.SendMessage(WM_NOTIFY, msginfo.hdr.idFrom, reinterpret_cast<LPARAM>(&msginfo)))
			return false;
	}

	string label, data;
	vector<pair<string,uint32> > symbols;
	if (!m_source->Get(*name, label, data, symbols))
		return false;

	switch (state)
	{
	case stateNormal:
		if (! symbols.empty())
		{
			state = stateDropdown;
			m_editwin = m_combowin;
			for (vector<pair<string,uint32> >::const_iterator i = symbols.begin();
				 i != symbols.end(); ++i)
			{
				const string& sym = i->first;
#ifdef UNICODE
				int buflen = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED,
						sym.data(), sym.size(), NULL, 0);
				LPTSTR buf = new TCHAR[buflen+1];
				buflen = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED,
						sym.data(), sym.size(), buf, buflen);
				buf[buflen] = TEXT('\0');
				m_combowin.SendMessage(CB_ADDSTRING, 0, (LPARAM)buf);
				delete[] buf;
#else
				m_combowin.SendMessage(CB_ADDSTRING, 0, (LPARAM)sym.c_str());
#endif
			}
		}
		else
			m_editwin = m_textwin;
		break;
	case stateBoolean:
		state = stateDropdown;
		m_editwin = m_combowin;
		m_combowin.SendMessage(CB_ADDSTRING, 0, (LPARAM)TEXT("false"));
		m_combowin.SendMessage(CB_ADDSTRING, 0, (LPARAM)TEXT("true"));
		break;
	case stateBitfield:
	  {
		if (m_bitmenu)
			DestroyMenu(m_bitmenu);
		m_bitmenu = CreatePopupMenu();
		MENUITEMINFO mitem;
		mitem.cbSize = sizeof(MENUITEMINFO);
		mitem.fMask = MIIM_TYPE | MIIM_ID | MIIM_STATE | MIIM_DATA;
		mitem.fType = MFT_STRING;
		mitem.wID = IDM_BITFIELD;
		for (vector<pair<string,uint32> >::const_iterator i = symbols.begin();
			 i != symbols.end(); ++i)
		{
			const string& sym = i->first;
#ifdef UNICODE
			mitem.cch = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED,
					sym.data(), sym.size(), NULL, 0);
			mitem.dwTypeData = new TCHAR[mitem.cch+1];
			mitem.cch = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED,
					sym.data(), sym.size(), mitem.dwTypeData, mitem.cch);
			mitem.dwTypeData[mitem.cch] = TEXT('\0');
#else
			mitem.dwTypeData = const_cast<char*>(sym.c_str());
			mitem.cch = sym.size();
#endif
			mitem.dwItemData = i->second;
			if (is_symbol_in_bitstring(data, sym, i->second))
				mitem.fState = MFS_CHECKED;
			else
				mitem.fState = MFS_UNCHECKED;
			InsertMenuItem(m_bitmenu, (UINT)-1, TRUE, &mitem);
			++mitem.wID;
#ifdef UNICODE
			delete[] buf;
#endif
		}
	  }
	default:
		m_editwin = m_textwin;
		break;
	}

	SetEditText(data);

	{
		TVITEM iteminfo;
		iteminfo.hItem = item->second;
		iteminfo.mask = TVIF_IMAGE | TVIF_SELECTEDIMAGE | TVIF_STATE;
		iteminfo.stateMask = TVIS_BOLD;
		iteminfo.state = TVIS_BOLD;
		iteminfo.iImage = iteminfo.iSelectedImage = 1;
		TreeView_SetItem(m_listwin, &iteminfo);

		iteminfo.mask = TVIF_IMAGE | TVIF_SELECTEDIMAGE;
		iteminfo.iImage = iteminfo.iSelectedImage = 2;
		while (1)
		{
			iteminfo.hItem = TreeView_GetParent(m_listwin, iteminfo.hItem);
			if (! iteminfo.hItem)
				break;
			TreeView_SetItem(m_listwin, &iteminfo);
		}
	}

	m_currentedit = name;
	EnableEdit(state);
	m_editwin.Focus();
	return true;
}

bool PropertyTree::EndEditProperty(bool abort)
{
	if (!abort)
	{
		if (!m_source)
			return false;

		string data = GetEditText();

		if (!m_source->Validate(*m_currentedit, data))
		{
			SetEditText(data);
			m_editwin.Focus();
			return false;
		}

		{
			string olddata, unused;
			m_source->Get(*m_currentedit, unused, olddata);
			m_source->Set(*m_currentedit, data);
			HWND parent = (m_realparent) ? m_realparent : GetParent(m_window);
			if (parent)
			{
				PTNINFO msginfo;
				msginfo.hdr.hwndFrom = m_window;
				msginfo.hdr.idFrom = GetWindowLong(m_window, GWL_ID);
				msginfo.hdr.code = PTN_PROPERTYCHANGED;
				msginfo.name = m_currentedit;
				msginfo.userdata = m_userdata;
				msginfo.olddata = &olddata;
				msginfo.newdata = &data;
				::SendMessage(parent, WM_NOTIFY, msginfo.hdr.idFrom, reinterpret_cast<LPARAM>(&msginfo));
			}
		}

		map<string,HTREEITEM>::const_iterator item = m_properties.find(*m_currentedit);
		if (item != m_properties.end())
		{
			RECT itemrc;
			if (TreeView_GetItemRect(m_listwin, item->second, &itemrc, FALSE))
				InvalidateRect(m_listwin, &itemrc, TRUE);
			TreeView_EnsureVisible(m_listwin, item->second);
		}
	}
	else
	{
		HWND parent = (m_realparent) ? m_realparent : GetParent(m_window);
		if (parent)
		{
			PTNINFO msginfo;
			msginfo.hdr.hwndFrom = m_window;
			msginfo.hdr.idFrom = GetWindowLong(m_window, GWL_ID);
			msginfo.hdr.code = PTN_PROPERTYCHANGECANCELED;
			msginfo.name = m_currentedit;
			msginfo.userdata = m_userdata;
			msginfo.olddata = msginfo.newdata = NULL;
			::SendMessage(parent, WM_NOTIFY, msginfo.hdr.idFrom, reinterpret_cast<LPARAM>(&msginfo));
		}
	}

	map<string,HTREEITEM>::const_iterator item = m_properties.find(*m_currentedit);
	if (item != m_properties.end())
	{
		TVITEM iteminfo;
		iteminfo.hItem = item->second;
		iteminfo.mask = TVIF_IMAGE | TVIF_SELECTEDIMAGE | TVIF_STATE;
		iteminfo.stateMask = TVIS_BOLD;
		iteminfo.state = 0;
		iteminfo.iImage = iteminfo.iSelectedImage = 0;
		TreeView_SetItem(m_listwin, &iteminfo);

		iteminfo.mask = TVIF_IMAGE | TVIF_SELECTEDIMAGE;
		while (1)
		{
			iteminfo.hItem = TreeView_GetParent(m_listwin, iteminfo.hItem);
			if (! iteminfo.hItem)
				break;
			TreeView_SetItem(m_listwin, &iteminfo);
		}
	}

	switch (m_editstate)
	{
	case stateBoolean:
	case stateDropdown:
		m_combowin.SendMessage(CB_RESETCONTENT, 0, 0);
		break;
	case stateBitfield:
		DestroyMenu(m_bitmenu);
		m_bitmenu = NULL;
		break;
	default:
		break;
	}

	m_currentedit = NULL;
	m_editwin.SendMessage(WM_SETTEXT, 0, (LPARAM)TEXT(""));
	DisableEdit();
	m_listwin.Focus();
	return true;
}

