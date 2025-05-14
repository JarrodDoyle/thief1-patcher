#include "objtree.h"
#include "ObjWindow.h"
#include "ObjTreeWindow.h"
#include "ObjTreeDialogs.h"
#include "DarkSources.h"
#include "UndoHistory.h"

#include <stdexcept>
#include <algorithm>
#include <functional>
#include <iterator>
#include <string>
#include <cctype>

#ifndef _tstring
# ifdef UNICODE
#  define _tstring	wstring
# else
#  define _tstring	string
# endif
#endif

#include "DarkLib/DarkIterators.h"
#include "DarkLib/StructInfo.h"
#include "DarkLib/parseutils.h"
#include "dbtools.h"
#include "resources.h"

// _WIN32_IE >= 0x500
#ifndef LVS_EX_LABELTIP
#define LVS_EX_LABELTIP 0x4000
#endif


using namespace Dark;
using namespace std;


const TCHAR* ObjWindow::szClassName = TEXT("ObjView");

BOOL ObjWindow::RegisterClass(HINSTANCE inst)
{
	WNDCLASS wcl;

	wcl.hInstance = inst;
	wcl.lpszClassName = szClassName;
	wcl.lpfnWndProc = WindowProc;
	wcl.style = 0;
	wcl.hIcon = LoadIcon(inst, MAKEINTRESOURCE(2));
	wcl.lpszMenuName = NULL;
	wcl.cbClsExtra = 0;
	wcl.cbWndExtra = 0;
	wcl.hbrBackground = (HBRUSH)(COLOR_WINDOW+1);
	return ::RegisterClass(&wcl);
}

ObjWindow::~ObjWindow()
{
	map<sint32,LinkEditor*>::iterator i = m_editors.begin();
	for (; i != m_editors.end(); ++i)
		delete i->second;
	m_editors.clear();
	m_object->dec_ref();
	SetWindowLong(m_window, GWL_USERDATA, 0);
}

ObjWindow::ObjWindow(DarkObject* obj, ObjTreeMain& parent, HINSTANCE inst)
	: Window(), m_parent(parent), m_object(obj)
{
	m_pages[kPropPage] = &m_props;
	m_pages[kMetapropPage] = &m_metaprops;
	m_pages[kLinkPage] = &m_links;
	m_pages[kStimPage] = &m_stims;
	m_pages[kReceptronPage] = &m_receptrons;
	m_object->inc_ref();
	Create(inst);
}

ObjWindow::ObjWindow(const ObjWindow& cpy)
	: Window(cpy), m_parent(cpy.m_parent), m_object(cpy.m_object)
{
	m_pages[kPropPage] = &m_props;
	m_pages[kMetapropPage] = &m_metaprops;
	m_pages[kLinkPage] = &m_links;
	m_pages[kStimPage] = &m_stims;
	m_pages[kReceptronPage] = &m_receptrons;
	m_object->inc_ref();
}

ObjWindow& ObjWindow::operator=(const ObjWindow& cpy)
{
	Window::operator=(cpy);
	m_object = cpy.m_object;
	m_object->inc_ref();
	return *this;
}

LRESULT CALLBACK ObjWindow::WindowProc(HWND hwnd, UINT message, WPARAM wparam, LPARAM lparam)
{
	if (message == WM_CREATE)
	{
		LPCREATESTRUCT info = reinterpret_cast<LPCREATESTRUCT>(lparam);
		ObjWindow* win = reinterpret_cast<ObjWindow*>(
				reinterpret_cast<LPMDICREATESTRUCT>(info->lpCreateParams)->lParam);
		SetWindowLong(hwnd, GWL_USERDATA, reinterpret_cast<LONG>(win));
		return 0;
	}

	ObjWindow* win = reinterpret_cast<ObjWindow*>(GetWindowLong(hwnd, GWL_USERDATA));
	if (win)
	{
		switch (message)
		{
		  case WM_DESTROY:
			return 0;
		  case WM_CLOSE:
			win->m_parent.CloseObjectWindow(win->m_object->GetId());
			return 0;
		  case WM_SIZE:
			if (wparam == SIZE_MINIMIZED)
				win->ToggleEditors(SW_HIDE);
			else //if (wparam == SIZE_MAXIMIZED || SIZE_RESTORED)
			{
				if (wparam == SIZE_MAXIMIZED)
					win->m_parent.SetMDIMaximized(true);
				else if (wparam == SIZE_RESTORED)
					win->m_parent.SetMDIMaximized(false);
				win->AdjustLayout();
				win->ToggleEditors(SW_SHOW);
			}
			break;
		/*
		  case WM_SHOWWINDOW:
			if (lparam == SW_OTHERZOOM || lparam == SW_OTHERUNZOOM)
			{
				win->ToggleEditors((wparam)?SW_SHOW:SW_HIDE);
			}
			break;
		*/
		  case WM_MDIACTIVATE:
		  {
			if (hwnd == (HWND)lparam && !IsIconic(hwnd))
				win->ToggleEditors(SW_SHOW);
			else
				win->ToggleEditors(SW_HIDE);
			return 0;
		  }
		  case WM_SETFOCUS:
			win->m_pages[TabCtrl_GetCurSel(win->m_tabs)]->Focus();
			return 0;
		  case WM_SETTINGCHANGE:
		  case WM_SYSCOLORCHANGE:
			win->m_tabs.SendMessage(message, wparam, lparam);
			win->m_props.SendMessage(message, wparam, lparam);
			win->m_metaprops.SendMessage(message, wparam, lparam);
			win->m_links.SendMessage(message, wparam, lparam);
			win->m_stims.SendMessage(message, wparam, lparam);
			win->m_receptrons.SendMessage(message, wparam, lparam);
			win->AdjustLayout();
			break;
		  case WM_PARENTNOTIFY:
			if (LOWORD(wparam) == WM_DESTROY)
			{
				if (GetClassLong(reinterpret_cast<HWND>(lparam), GCW_ATOM)
				 == PropertyTree::ClassID)
				{
					PropertyTree* w = reinterpret_cast<PropertyTree*>(
							GetWindowLong(reinterpret_cast<HWND>(lparam),GWL_USERDATA));
					if (w)
					{
						if (w->HasSource())
							delete w->SetSource(NULL);
						if (w->UserData())
						{
							LinkEditor* info = reinterpret_cast<LinkEditor*>(w->UserData());
							if (info)
								win->EraseEditor(info->linkid);
						}
					}
					return 0;
				}
			}
			break;
		  case WM_NOTIFY:
		  {
			switch (reinterpret_cast<LPNMHDR>(lparam)->code)
			{
			  case NM_KILLFOCUS:
			  {
				win->m_parent.SetEditContext(ObjTreeMain::editNone);
				return 0;
			  }
			  case NM_SETFOCUS:
			  {
				HWND focuswin = reinterpret_cast<LPNMHDR>(lparam)->hwndFrom;
				ObjTreeMain::EditContext ctx = ObjTreeMain::editNone;
				if (focuswin == win->m_props)
				{
					try
					{
						win->m_props.GetSelection();
						ctx = ObjTreeMain::editObjectProperty;
					}
					catch (...)
					{ }
				}
				else
				{
					if (focuswin == win->m_metaprops)
						ctx = ObjTreeMain::editObjectMetaproperty;
					else if (focuswin == win->m_links)
						ctx = ObjTreeMain::editObjectLink;
					else if (focuswin == win->m_stims)
						ctx = ObjTreeMain::editObjectStimulus;
					else if (focuswin == win->m_receptrons)
						ctx = ObjTreeMain::editObjectReceptron;
					else
						goto l_ignorefocus;
					//if (ListView_GetNextItem(focuswin, (WPARAM)-1, LVNI_SELECTED) == -1)
					//	ctx = ObjTreeMain::editNone;
				}
			l_ignorefocus:
				win->m_parent.SetEditContext(ctx, win->m_object->GetId());
				return 0;
			  }
			  case TCN_SELCHANGE:
			  {
				Window* w = win->m_pages[TabCtrl_GetCurSel(win->m_tabs)];
				w->Show();
				if (GetFocus() != win->m_tabs)
					w->Focus();
				return 0;
			  }
			  case TCN_SELCHANGING:
			  {
				Window* w = win->m_pages[TabCtrl_GetCurSel(win->m_tabs)];
				w->Hide();
				return 0;
			  }
			  case PTN_PROPERTYCHANGING:
			  {
				win->HandlePropertyChanging(reinterpret_cast<const PTNINFO*>(lparam));
				return 0;
			  }
			  case PTN_PROPERTYCHANGED:
			  {
				win->HandlePropertyChanged(reinterpret_cast<const PTNINFO*>(lparam));
				return 0;
			  }
			  case PTN_PROPERTYCHANGECANCELED:
			  {
				win->HandlePropertyChangeCanceled(reinterpret_cast<const PTNINFO*>(lparam));
				return 0;
			  }
			  case LVN_GETDISPINFO:
			  {
				NMLVDISPINFO* info = reinterpret_cast<NMLVDISPINFO*>(lparam);
				win->DisplayListItem(info->hdr.hwndFrom, info->item);
				return 0;
			  }
			  case NM_DBLCLK:
			  case NM_RETURN:
			  {
				HWND listwin = reinterpret_cast<LPNMHDR>(lparam)->hwndFrom;
				int rownum = ListView_GetNextItem(listwin, (WPARAM)-1, LVNI_SELECTED);
				if (rownum >= 0)
				{
					win->EditListItem(listwin, rownum);
					return 0;
				}
			  }
			}
			break;
		  }
		  case WM_COMMAND:
		  {
			switch (LOWORD(wparam))
			{
			  case IDM_WINDOWSWITCH:
			  {
				Window* w = win->m_pages[TabCtrl_GetCurSel(win->m_tabs)];
				if (GetFocus() != win->m_tabs)
					win->m_tabs.Focus();
				else
					w->Focus();
				return 0;
			  }
			}
			break;
		  }
		}
	}
	return DefMDIChildProc(hwnd, message, wparam, lparam);
}

BOOL ObjWindow::Create(HINSTANCE inst)
{
	{
		string name = print_object_name(m_parent.Database(), m_object);
#ifdef UNICODE
		int len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
				name.data(), name.size(),
				NULL, 0);
		LPTSTR windowname = new TCHAR[len+1];
		len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
				name.data(), name.size(),
				windowname, len);
		windowname[len] = TEXT('\0');
#else
		LPCTSTR windowname = name.c_str();
#endif
		int flags = (m_parent.IsMDIMaximized()) ? WS_MAXIMIZE : 0;
		m_window = CreateMDIWindow(szClassName, windowname, flags,
				CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, 
				m_parent.Client(), inst, reinterpret_cast<LPARAM>(this));
#ifdef UNICODE
		delete[] windowname;
#endif
		if (!m_window)
			return FALSE;
	}

	{
		RECT rc;
		GetClientRect(m_window, &rc);
		m_tabs = CreateWindowEx(0, WC_TABCONTROL, NULL,
				WS_CHILD | TCS_BUTTONS | TCS_FLATBUTTONS | TCS_HOTTRACK,
				0, 0, rc.right, rc.bottom, 
				m_window, NULL, inst, NULL);
		if (!m_tabs)
			return FALSE;
		m_tabs.SendMessage(WM_SETFONT, (WPARAM)(HFONT)GetStockObject(DEFAULT_GUI_FONT), 0);
		//m_tabs.SendMessage(TCM_SETEXTENDEDSTYLE, 0, TCS_EX_FLATSEPARATORS);
	}

	{
		TCITEM item;
		TCHAR szName[32];

		item.mask = TCIF_TEXT | TCIF_IMAGE;
		item.iImage = -1;
		item.pszText = szName;
		int id = ID_TABLABELS;
		for (int n=0; n < kLastPage; ++n)
		{
			LoadString(inst, id+n, szName, sizeof(szName));
			TabCtrl_InsertItem(m_tabs, n, &item);
		}
	}

	if (!(CreatePropertyPage(inst)
	   && CreateMetapropertyPage(inst) 
	   && CreateLinkPage(inst)
	   && CreateStimPage(inst)
	   && CreateReceptronPage(inst)
	  ))
		return FALSE;

	AdjustLayout();
	m_tabs.Show();
	m_props.Show();
	m_props.Focus();

	return TRUE;
}

BOOL ObjWindow::CreatePropertyPage(HINSTANCE inst)
{
	if (!m_props.Create(m_window, inst))
		return FALSE;
	m_props.SetSource(new DarkObjectPropertySource(m_object));
	return InitPropertyPage();
}

BOOL ObjWindow::InitPropertyPage()
{
	m_props.SendMessage(WM_SETREDRAW, FALSE, 0);
	m_props.Clear();
	DarkPropIterator props = m_object->GetProperties();
	while (! props.empty())
	{
		DarkProp* p = *props++;
		m_props.AddProperty(p->GetName());
		try
		{
			const StructInfo* pinfo = DarkDataSource::GetStructReader().GetStruct(p->GetName());
			// The only variable-length property (hopefully) is a string
			// which is handled specially.
			if (pinfo->Size() == -1)
				continue;
			StructIterator piter = pinfo->Begin();
			StructIterator pend = pinfo->End();
			int childfields = 0;
			bool isbitfield = false;
			string pname;
			for (; piter != pend; ++piter)
			{
				pname = p->GetName() + '\\' + *piter;
				isbitfield = piter->Type() == typeBITFIELD::name;
				m_props.AddProperty(pname, pname.substr(0,pname.rfind('\\')));
				if (isbitfield)
					m_props.SetState(pname, PropertyTree::stateBitfield);
				++childfields;
			}
			if (childfields == 1)
			{
				// relies on the string value of the iterator remaining constant
				// at end-of-sequence
				m_props.RemoveProperty(pname);
				if (isbitfield)
					m_props.SetState(p->GetName(), PropertyTree::stateBitfield);
			}
		}
		catch (out_of_range &e)
		{ }
	}
	m_props.SendMessage(WM_SETREDRAW, TRUE, 0);
	InvalidateRect(m_props, NULL, TRUE);

	return TRUE;
}

BOOL ObjWindow::CreateMetapropertyPage(HINSTANCE inst)
{
	m_metaprops = CreateWindowEx(WS_EX_CLIENTEDGE, WC_LISTVIEW, NULL,
			WS_CHILD | LVS_REPORT | LVS_NOSORTHEADER | LVS_SHOWSELALWAYS | LVS_SINGLESEL,
			0, 0, CW_USEDEFAULT, CW_USEDEFAULT,
			m_window, NULL, inst, NULL);
	if (!m_metaprops)
		return FALSE;
	m_metaprops.SendMessage(WM_SETFONT, (WPARAM)(HFONT)GetStockObject(DEFAULT_GUI_FONT), 0);
#ifdef UNICODE
	ListView_SetUnicodeFormat(m_metaprops, TRUE);
#endif
	m_metaprops.SendMessage(LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_FULLROWSELECT | LVS_EX_LABELTIP);
	{
		TCHAR colname[260];
		LVCOLUMN column;
		column.mask = LVCF_FMT | LVCF_WIDTH | LVCF_TEXT | LVCF_SUBITEM;
		column.fmt = LVCFMT_LEFT;
		column.pszText = colname;
		column.cx = 200;
		LoadString(inst, IDS_COLNAME, colname, sizeof(colname));
		column.iSubItem = 0;
		ListView_InsertColumn(m_metaprops, 0, &column);
		column.cx = 60;
		LoadString(inst, IDS_COLPRIORITY, colname, sizeof(colname));
		column.iSubItem = 1;
		ListView_InsertColumn(m_metaprops, 1, &column);
	}
	return InitMetapropertyPage();
}

BOOL ObjWindow::InitMetapropertyPage()
{
	m_metaprops.SendMessage(WM_SETREDRAW, FALSE, 0);
	ListView_DeleteAllItems(m_metaprops);

	LVITEM rowitem;
	rowitem.mask = LVIF_TEXT | LVIF_PARAM;
	rowitem.iItem = 0;
	rowitem.iSubItem = 0;
	rowitem.pszText = LPSTR_TEXTCALLBACK;

	DarkLinkIterator mplinks = m_object->GetLinksByFlavor(m_parent.Database()->Flavor("MetaProp"));
	ListView_SetItemCount(m_metaprops, mplinks.size());
	while (! mplinks.empty())
	{
		DarkLinkMetaProp* mp = dynamic_cast<DarkLinkMetaProp*>(*mplinks++);
		if (mp->IsMP())
		{
			rowitem.iSubItem = 0;
			rowitem.lParam = mp->GetId();
			int rownum = ListView_InsertItem(m_metaprops, &rowitem);
			rowitem.iSubItem = 1;
			m_metaprops.SendMessage(LVM_SETITEMTEXT, rownum, (LPARAM)&rowitem);
			++rowitem.iItem;
		}
	}
	m_metaprops.SendMessage(WM_SETREDRAW, TRUE, 0);
	InvalidateRect(m_metaprops, NULL, TRUE);

	return TRUE;
}

BOOL ObjWindow::CreateLinkPage(HINSTANCE inst)
{
	m_links = CreateWindowEx(WS_EX_CLIENTEDGE, WC_LISTVIEW, NULL,
			WS_CHILD | LVS_REPORT | LVS_NOSORTHEADER | LVS_SHOWSELALWAYS | LVS_SINGLESEL,
			0, 0, CW_USEDEFAULT, CW_USEDEFAULT,
			m_window, NULL, inst, NULL);
	if (!m_links)
		return FALSE;
	m_links.SendMessage(WM_SETFONT, (WPARAM)(HFONT)GetStockObject(DEFAULT_GUI_FONT), 0);
#ifdef UNICODE
	ListView_SetUnicodeFormat(m_links, TRUE);
#endif
	m_links.SendMessage(LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_FULLROWSELECT | LVS_EX_LABELTIP);
	{
		TCHAR colname[260];
		LVCOLUMN column;
		column.mask = LVCF_FMT | LVCF_WIDTH | LVCF_TEXT | LVCF_SUBITEM;
		column.fmt = LVCFMT_LEFT;
		column.pszText = colname;
		column.cx = 80;
		LoadString(inst, IDS_COLLINKID, colname, sizeof(colname));
		column.iSubItem = 0;
		ListView_InsertColumn(m_links, 0, &column);
		column.cx = 100;
		LoadString(inst, IDS_COLKIND, colname, sizeof(colname));
		column.iSubItem = 1;
		ListView_InsertColumn(m_links, 1, &column);
		column.cx = 120;
		LoadString(inst, IDS_COLSOURCE, colname, sizeof(colname));
		column.iSubItem = 2;
		ListView_InsertColumn(m_links, 2, &column);
		LoadString(inst, IDS_COLDEST, colname, sizeof(colname));
		column.iSubItem = 3;
		ListView_InsertColumn(m_links, 3, &column);
	}
	return InitLinkPage();
}

BOOL ObjWindow::InitLinkPage()
{
	m_links.SendMessage(WM_SETREDRAW, FALSE, 0);
	ListView_DeleteAllItems(m_links);

	LVITEM rowitem;
	rowitem.mask = LVIF_TEXT | LVIF_PARAM;
	rowitem.iItem = 0;
	rowitem.iSubItem = 0;
	rowitem.pszText = LPSTR_TEXTCALLBACK;

	uint32 mpflavor = m_parent.Database()->Flavor("MetaProp");
	uint32 srcflavor = m_parent.Database()->Flavor("arSrcDesc");
	uint32 rcptnflavor = m_parent.Database()->Flavor("Receptron");
	DarkLinkIterator links = m_object->GetLinks();
	while (! links.empty())
	{
		DarkLink* l = *links++;
		if (!(l->GetFlavor() == mpflavor 
		   || l->GetFlavor() == srcflavor 
		   || l->GetFlavor() == rcptnflavor))
		{
			rowitem.iSubItem = 0;
			rowitem.lParam = l->GetId();
			int rownum = ListView_InsertItem(m_links, &rowitem);
			rowitem.iSubItem = 1;
			m_links.SendMessage(LVM_SETITEMTEXT, rownum, (LPARAM)&rowitem);
			rowitem.iSubItem = 2;
			m_links.SendMessage(LVM_SETITEMTEXT, rownum, (LPARAM)&rowitem);
			rowitem.iSubItem = 3;
			m_links.SendMessage(LVM_SETITEMTEXT, rownum, (LPARAM)&rowitem);
			++rowitem.iItem;
		}
	}
	links = m_object->GetReverseLinks();
	while (! links.empty())
	{
		DarkLink* l = *links++;
		if (!(l->GetFlavor() == mpflavor 
		   || l->GetFlavor() == srcflavor 
		   || l->GetFlavor() == rcptnflavor))
		{
			rowitem.iSubItem = 0;
			rowitem.lParam = - l->GetId();
			int rownum = ListView_InsertItem(m_links, &rowitem);
			rowitem.iSubItem = 1;
			m_links.SendMessage(LVM_SETITEMTEXT, rownum, (LPARAM)&rowitem);
			rowitem.iSubItem = 2;
			m_links.SendMessage(LVM_SETITEMTEXT, rownum, (LPARAM)&rowitem);
			rowitem.iSubItem = 3;
			m_links.SendMessage(LVM_SETITEMTEXT, rownum, (LPARAM)&rowitem);
			++rowitem.iItem;
		}
	}
	m_links.SendMessage(WM_SETREDRAW, TRUE, 0);
	InvalidateRect(m_links, NULL, TRUE);

	return TRUE;
}

BOOL ObjWindow::CreateStimPage(HINSTANCE inst)
{
	m_stims = CreateWindowEx(WS_EX_CLIENTEDGE, WC_LISTVIEW, NULL,
			WS_CHILD | LVS_REPORT | LVS_NOSORTHEADER | LVS_SHOWSELALWAYS | LVS_SINGLESEL,
			0, 0, CW_USEDEFAULT, CW_USEDEFAULT,
			m_window, NULL, inst, NULL);
	if (!m_stims)
		return FALSE;
	m_stims.SendMessage(WM_SETFONT, (WPARAM)(HFONT)GetStockObject(DEFAULT_GUI_FONT), 0);
#ifdef UNICODE
	ListView_SetUnicodeFormat(m_stims, TRUE);
#endif
	m_stims.SendMessage(LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_FULLROWSELECT | LVS_EX_LABELTIP);
	{
		TCHAR colname[260];
		LVCOLUMN column;
		column.mask = LVCF_FMT | LVCF_WIDTH | LVCF_TEXT | LVCF_SUBITEM;
		column.fmt = LVCFMT_LEFT;
		column.pszText = colname;
		column.cx = 80;
		LoadString(inst, IDS_COLLINKID, colname, sizeof(colname));
		column.iSubItem = 0;
		ListView_InsertColumn(m_stims, 0, &column);
		column.cx = 120;
		LoadString(inst, IDS_COLSTIMULUS, colname, sizeof(colname));
		column.iSubItem = 1;
		ListView_InsertColumn(m_stims, 1, &column);
		column.cx = 100;
		LoadString(inst, IDS_COLPROPAGATION, colname, sizeof(colname));
		column.iSubItem = 2;
		ListView_InsertColumn(m_stims, 2, &column);
		column.cx = 60;
		LoadString(inst, IDS_COLINTENSITY, colname, sizeof(colname));
		column.iSubItem = 3;
		ListView_InsertColumn(m_stims, 3, &column);
	}
	return InitStimPage();
}

BOOL ObjWindow::InitStimPage()
{
	m_stims.SendMessage(WM_SETREDRAW, FALSE, 0);
	ListView_DeleteAllItems(m_stims);

	LVITEM rowitem;
	rowitem.mask = LVIF_TEXT | LVIF_PARAM;
	rowitem.iItem = 0;
	rowitem.iSubItem = 0;
	rowitem.pszText = LPSTR_TEXTCALLBACK;

	DarkLinkIterator stimlinks = m_object->GetLinksByFlavor(m_parent.Database()->Flavor("arSrcDesc"));
	ListView_SetItemCount(m_stims, stimlinks.size());
	while (! stimlinks.empty())
	{
		DarkLink* stim = *stimlinks++;
		rowitem.iSubItem = 0;
		rowitem.lParam = stim->GetId();
		int rownum = ListView_InsertItem(m_stims, &rowitem);
		rowitem.iSubItem = 1;
		m_stims.SendMessage(LVM_SETITEMTEXT, rownum, (LPARAM)&rowitem);
		rowitem.iSubItem = 2;
		m_stims.SendMessage(LVM_SETITEMTEXT, rownum, (LPARAM)&rowitem);
		rowitem.iSubItem = 3;
		m_stims.SendMessage(LVM_SETITEMTEXT, rownum, (LPARAM)&rowitem);
		++rowitem.iItem;
	}
	m_stims.SendMessage(WM_SETREDRAW, TRUE, 0);
	InvalidateRect(m_stims, NULL, TRUE);

	return TRUE;
}

BOOL ObjWindow::CreateReceptronPage(HINSTANCE inst)
{
	m_receptrons = CreateWindowEx(WS_EX_CLIENTEDGE, WC_LISTVIEW, NULL,
			WS_CHILD | LVS_REPORT | LVS_NOSORTHEADER | LVS_SHOWSELALWAYS | LVS_SINGLESEL,
			0, 0, CW_USEDEFAULT, CW_USEDEFAULT,
			m_window, NULL, inst, NULL);
	if (!m_receptrons)
		return FALSE;
	m_receptrons.SendMessage(WM_SETFONT, (WPARAM)(HFONT)GetStockObject(DEFAULT_GUI_FONT), 0);
#ifdef UNICODE
	ListView_SetUnicodeFormat(m_receptrons, TRUE);
#endif
	m_receptrons.SendMessage(LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_FULLROWSELECT | LVS_EX_LABELTIP);
	{
		TCHAR colname[260];
		LVCOLUMN column;
		column.mask = LVCF_FMT | LVCF_WIDTH | LVCF_TEXT | LVCF_SUBITEM;
		column.fmt = LVCFMT_LEFT;
		column.pszText = colname;
		column.cx = 80;
		LoadString(inst, IDS_COLLINKID, colname, sizeof(colname));
		column.iSubItem = 0;
		ListView_InsertColumn(m_receptrons, 0, &column);
		column.cx = 120;
		LoadString(inst, IDS_COLSTIMULUS, colname, sizeof(colname));
		column.iSubItem = 1;
		ListView_InsertColumn(m_receptrons, 1, &column);
		column.cx = 100;
		LoadString(inst, IDS_COLREACTION, colname, sizeof(colname));
		column.iSubItem = 2;
		ListView_InsertColumn(m_receptrons, 2, &column);
		column.cx = 60;
		LoadString(inst, IDS_COLINTENSITYMIN, colname, sizeof(colname));
		column.iSubItem = 3;
		ListView_InsertColumn(m_receptrons, 3, &column);
		LoadString(inst, IDS_COLINTENSITYMAX, colname, sizeof(colname));
		column.iSubItem = 4;
		ListView_InsertColumn(m_receptrons, 4, &column);
	}
	return InitReceptronPage();
}

BOOL ObjWindow::InitReceptronPage()
{
	m_receptrons.SendMessage(WM_SETREDRAW, FALSE, 0);
	ListView_DeleteAllItems(m_receptrons);

	LVITEM rowitem;
	rowitem.mask = LVIF_TEXT | LVIF_PARAM;
	rowitem.iItem = 0;
	rowitem.iSubItem = 0;
	rowitem.pszText = LPSTR_TEXTCALLBACK;

	DarkLinkIterator rcptnlinks = m_object->GetLinksByFlavor(m_parent.Database()->Flavor("Receptron"));
	ListView_SetItemCount(m_receptrons, rcptnlinks.size());
	while (! rcptnlinks.empty())
	{
		DarkLink* rcptn = *rcptnlinks++;
		rowitem.iSubItem = 0;
		rowitem.lParam = rcptn->GetId();
		int rownum = ListView_InsertItem(m_receptrons, &rowitem);
		rowitem.iSubItem = 1;
		m_receptrons.SendMessage(LVM_SETITEMTEXT, rownum, (LPARAM)&rowitem);
		rowitem.iSubItem = 2;
		m_receptrons.SendMessage(LVM_SETITEMTEXT, rownum, (LPARAM)&rowitem);
		rowitem.iSubItem = 3;
		m_receptrons.SendMessage(LVM_SETITEMTEXT, rownum, (LPARAM)&rowitem);
		rowitem.iSubItem = 4;
		m_receptrons.SendMessage(LVM_SETITEMTEXT, rownum, (LPARAM)&rowitem);
		++rowitem.iItem;
	}
	m_receptrons.SendMessage(WM_SETREDRAW, TRUE, 0);
	InvalidateRect(m_receptrons, NULL, TRUE);

	return TRUE;
}

void ObjWindow::AdjustLayout()
{
	RECT rc;
	DWORD width, height;
	GetClientRect(m_window, &rc);
	width = rc.right;
	height = rc.bottom;
	TabCtrl_AdjustRect(m_tabs, FALSE, &rc);
	HDWP pos = BeginDeferWindowPos(kLastPage+1);
	DeferWindowPos(pos, m_tabs, NULL, 0, 0, width, height, SWP_NOMOVE | SWP_NOZORDER);
	for (int n=0; n < kLastPage; ++n)
	{
		DeferWindowPos(pos, *m_pages[n], HWND_TOP, 0, rc.top, width, height-rc.top, 0);
	}
	EndDeferWindowPos(pos);
}

void ObjWindow::UpdateObject()
{
	InitPropertyPage();
	InitMetapropertyPage();
	InitLinkPage();
	InitStimPage();
	InitReceptronPage();
}

DarkProp* ObjWindow::AddProperty(const string& propname)
{
	DarkProp* prop = m_object->GetProperty(propname);
	if (prop != NULL)
	{
		m_props.MakeVisible(propname);
		return prop;
	}
	prop = DarkDataSource::CreateStandardProperty(m_parent.Database(), propname, m_object->GetId());
	AddProperty(propname, prop);
	return prop;
}

bool ObjWindow::AddProperty(const string& name, DarkProp* prop)
{
	m_object->AddProperty(name, prop);
	InitPropertyPage();
	return true;
}

DarkProp* ObjWindow::RemoveProperty(const std::string& propname)
{
	DarkProp* prop = m_object->GetProperty(propname);
	if (! prop)
		return NULL;
	prop->inc_ref();
	m_object->RemoveProperty(propname);
	InitPropertyPage();
	return prop;
}

bool ObjWindow::AddLink(DarkLink* link)
{
	if (m_object->AddLink(link))
	{
		if (link->GetFlavor() == m_parent.Database()->Flavor("Metaprop"))
			InitMetapropertyPage();
		else if (link->GetFlavor() == m_parent.Database()->Flavor("arSrcDesc"))
			InitStimPage();
		else if (link->GetFlavor() == m_parent.Database()->Flavor("Receptron"))
			InitReceptronPage();
		else
			InitLinkPage();
		return true;
	}
	return false;
}

bool ObjWindow::RemoveLink(DarkLink* link)
{
	CloseEditor(link->GetId());
	m_object->RemoveLink(link->GetId());
	if (link->GetFlavor() == m_parent.Database()->Flavor("MetaProp"))
		InitMetapropertyPage();
	else if (link->GetFlavor() == m_parent.Database()->Flavor("arSrcDesc"))
		InitStimPage();
	else if (link->GetFlavor() == m_parent.Database()->Flavor("Receptron"))
		InitReceptronPage();
	else
		InitLinkPage();
	return true;
}

DarkLink* ObjWindow::CreateLink(sint32 id, uint32 flavor)
{
	// DarkLinkSource can massage links with zero-length data.
	// This also fits with the ability to create links in Dromed
	// without any data.
	DarkLink* link = new DarkLinkGeneric(0, flavor, m_parent.Database()->DefaultLinkVersion(flavor),
			m_object->GetId(), id, NULL, 0);
	if (! AddLink(link))
	{
		link->dec_ref();
		return NULL;
	}
	return link;
}

DarkLinkMetaProp* ObjWindow::CreateMetaproperty(sint32 id, sint32 priority)
{
	uint32 f = m_parent.Database()->Flavor("MetaProp");
	if (priority == 0)
	{
		priority = 1016;
		DarkLinkIterator allmps = m_object->GetLinksByFlavor(f);
		while (! allmps.empty())
		{
			DarkLinkMetaProp* mp = dynamic_cast<DarkLinkMetaProp*>(*allmps++);
			if (mp->GetPriority() > priority)
				priority = mp->GetPriority();
		}
		priority += 8;
	}
	DarkLinkMetaProp* mplink = new DarkLinkMetaProp(0, f, m_parent.Database()->DefaultLinkVersion(f),
			m_object->GetId(), id, NULL, 0);
	mplink->SetPriority(priority);
	if (! AddLink(mplink))
	{
		mplink->dec_ref();
		return NULL;
	}
	return mplink;
}

DarkLinkStimulus* ObjWindow::CreateStimulus(sint32 id, sint32 stimtype)
{
	DarkDBLinkARSrcDesc data;
	memset(&data, 0, sizeof(DarkDBLinkARSrcDesc));
	uint32 f = m_parent.Database()->Flavor("arSrcDesc");
	DarkLinkStimulus* stimlink = new DarkLinkStimulus(0, f, m_parent.Database()->DefaultLinkVersion(f),
			m_object->GetId(), id, &data, sizeof(DarkDBLinkARSrcDesc));
	stimlink->SetPropagationType(stimtype);
	if (! AddLink(stimlink))
	{
		stimlink->dec_ref();
		return NULL;
	}
	return stimlink;
}

DarkLinkReceptron* ObjWindow::CreateReceptron(sint32 id)
{
	DarkDBLinkReceptron data;
	memset(&data, 0, sizeof(DarkDBLinkReceptron));
	strcpy(data.effect, "None");
	uint32 f = m_parent.Database()->Flavor("Receptron");
	DarkLinkReceptron* rcptnlink = new DarkLinkReceptron(0, f, m_parent.Database()->DefaultLinkVersion(f),
			m_object->GetId(), id, &data, sizeof(DarkDBLinkReceptron));
	if (! AddLink(rcptnlink))
	{
		rcptnlink->dec_ref();
		return NULL;
	}
	return rcptnlink;
}

void ObjWindow::DoAddProperty()
{
	try
	{
		StringListDialog dlg(IDS_ADDPROPERTYPROMPT, IDS_ADDPROPERTYTITLE);
		{
			SetCursor(LoadCursor(NULL, IDC_WAIT));
			const StructClass* propstructs = DarkDataSource::GetStructReader().GetClass("properties");
			StructClass::iterator p = propstructs->Begin();
			while (p != propstructs->End())
			{
				const StructInfo* sinfo = *p++;
				dlg.Add(sinfo->Label(), sinfo->Name());
			}
			SetCursor(LoadCursor(NULL, IDC_ARROW));
		}
		if (!dlg(m_parent))
			return;

		string propstr;
#ifdef UNICODE
		{
			const wstring& wpropstr = dlg.ListText();
			int len = WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK | WC_DISCARDNS | WC_DEFAULTCHAR,
					wpropstr.data(), wpropstr.size(), NULL, 0, NULL, NULL);
			char buf[len+1];
			len = WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK | WC_DISCARDNS | WC_DEFAULTCHAR,
					wpropstr.data(), wpropstr.size(), buf, len, NULL, NULL);
			propstr.assign(buf, len);
			delete[] buf;
		}
#else
		propstr = dlg.ListText();
#endif
		if (propstr.size() > 9)
			propstr.erase(9);
		
		DarkProp* prop = AddProperty(propstr);
		m_parent.SetUndoAction(new UndoAddObjectProperty(m_object->GetId(), prop));
		prop->dec_ref();
	}
	catch (exception &e)
	{
		SetCursor(LoadCursor(NULL, IDC_ARROW));
		m_parent.ErrorMessage(e.what());
	}
}

void ObjWindow::DoRemoveProperty()
{
	try
	{
		const string& selname = m_props.GetSelection();
		string propname(selname, 0, selname.find('\\'));
		DarkProp* prop = RemoveProperty(propname);
		if (prop)
		{
			m_parent.SetUndoAction(new UndoRemoveObjectProperty(m_object->GetId(), prop));
			prop->dec_ref();
		}
	}
	catch (...)
	{ }
}

void ObjWindow::DoAddMetaproperty()
{
	try
	{
		IntegerListDialog dlg(IDS_ADDMETAPROPPROMPT, IDS_ADDMETAPROPTITLE);
		{
			SetCursor(LoadCursor(NULL, IDC_WAIT));
			vector<sint32> allmps;
			find_object_descendants(m_parent.Database(), 
					find_object_id(m_parent.Database(), "MetaProperty"), allmps);
			vector<sint32>::const_iterator mp = allmps.begin();
			while (mp != allmps.end())
			{
				DarkObject* mpobj = m_parent.Database()->GetObject(*mp++);
				DarkPropInteger* donorprop = dynamic_cast<DarkPropInteger*>(mpobj->GetProperty("DonorType"));
				if (donorprop->GetValue() != 0)
					dlg.Add(print_object_name(m_parent.Database(),mpobj), mpobj->GetId());
			}
			SetCursor(LoadCursor(NULL, IDC_ARROW));
		}
		if (!dlg(m_parent))
			return;

		SetCursor(LoadCursor(NULL, IDC_WAIT));
		sint32 mpid = dlg.ListInt();
		if (mpid != 0)
		{
			DarkLinkMetaProp* mplink = CreateMetaproperty(mpid, 0);
			if (mplink)
			{
				m_parent.SetUndoAction(new UndoAddObjectMetaproperty(m_object->GetId(), mplink));
				mplink->dec_ref();
			}
		}
		SetCursor(LoadCursor(NULL, IDC_ARROW));
	}
	catch (exception &e)
	{
		SetCursor(LoadCursor(NULL, IDC_ARROW));
		m_parent.ErrorMessage(e.what());
	}
}

void ObjWindow::DoRemoveMetaproperty()
{
	LVITEM info;
	info.mask = LVIF_PARAM;
	info.iSubItem = 0;
	info.iItem = ListView_GetNextItem(m_metaprops, (WPARAM)-1, LVNI_SELECTED);
	if (info.iItem >= 0)
	{
		ListView_GetItem(m_metaprops, &info);
		DarkLinkMetaProp* mplink = dynamic_cast<DarkLinkMetaProp*>(m_object->GetLink(info.lParam));
		if (mplink)
		{
			mplink->inc_ref();
			RemoveLink(mplink);
			m_parent.SetUndoAction(new UndoRemoveObjectMetaproperty(m_object->GetId(), mplink));
			mplink->dec_ref();
		}
	}
}

void ObjWindow::DoAddLink()
{
	try
	{
		LinkInputDialog dlg(m_parent.Database());
		if (!dlg(m_parent))
			return;

		SetCursor(LoadCursor(NULL, IDC_WAIT));
		sint32 destid = find_object_id(m_parent.Database(), dlg.Name());
		if (destid == 0)
		{
			SetCursor(LoadCursor(NULL, IDC_ARROW));
			_tstring msg =  TEXT("The object \"%\" was not found in the database.");
			msg.replace(msg.find('%'), 1, dlg.Name());
			MessageBox(m_window, msg.c_str(), TEXT("Not Found"), 
					MB_APPLMODAL | MB_ICONINFORMATION | MB_OK);
			return;
		}
		else if (dlg.Flavor() != 0)
		{
			DarkLink* link = CreateLink(destid, dlg.Flavor());
			if (link)
			{
				m_parent.SetUndoAction(new UndoAddObjectLink(m_object->GetId(), link));
				link->dec_ref();
			}
		}
		SetCursor(LoadCursor(NULL, IDC_ARROW));
	}
	catch (exception &e)
	{
		SetCursor(LoadCursor(NULL, IDC_ARROW));
		m_parent.ErrorMessage(e.what());
	}
}

void ObjWindow::DoRemoveLink()
{
	LVITEM info;
	info.mask = LVIF_PARAM;
	info.iSubItem = 0;
	info.iItem = ListView_GetNextItem(m_links, (WPARAM)-1, LVNI_SELECTED);
	if (info.iItem >= 0)
	{
		ListView_GetItem(m_links, &info);
		DarkLink* link = m_object->GetLink(info.lParam);
		if (link)
		{
			link->inc_ref();
			RemoveLink(link);
			m_parent.SetUndoAction(new UndoRemoveObjectLink(m_object->GetId(), link));
			link->dec_ref();
		}
	}
}

void ObjWindow::DoAddStimulus()
{
	try
	{
		IntegerListDialog dlg(IDS_ADDSTIMULUSPROMPT, IDS_ADDSTIMULUSTITLE);
		{
			SetCursor(LoadCursor(NULL, IDC_WAIT));
			vector<sint32> allstims;
			find_object_descendants(m_parent.Database(), 
					find_object_id(m_parent.Database(), "Stimulus"), allstims);
			vector<sint32>::const_iterator stim = allstims.begin();
			while (stim != allstims.end())
			{
				DarkObject* stimobj = m_parent.Database()->GetObject(*stim++);
				dlg.Add(print_object_name(m_parent.Database(),stimobj), stimobj->GetId());
			}
			SetCursor(LoadCursor(NULL, IDC_ARROW));
		}
		if (!dlg(m_parent))
			return;

		SetCursor(LoadCursor(NULL, IDC_WAIT));
		sint32 stimid = dlg.ListInt();
		if (stimid != 0)
		{
			DarkLinkStimulus* stimlink = CreateStimulus(stimid, 0);
			if (stimlink)
			{
				m_parent.SetUndoAction(new UndoAddObjectStimulus(m_object->GetId(), stimlink));
				EditStimItem(stimlink->GetId());
				stimlink->dec_ref();
			}
		}
		SetCursor(LoadCursor(NULL, IDC_ARROW));
	}
	catch (exception &e)
	{
		SetCursor(LoadCursor(NULL, IDC_ARROW));
		m_parent.ErrorMessage(e.what());
	}
}

void ObjWindow::DoRemoveStimulus()
{
	LVITEM info;
	info.mask = LVIF_PARAM;
	info.iSubItem = 0;
	info.iItem = ListView_GetNextItem(m_stims, (WPARAM)-1, LVNI_SELECTED);
	if (info.iItem >= 0)
	{
		ListView_GetItem(m_stims, &info);
		DarkLinkStimulus* stimlink = dynamic_cast<DarkLinkStimulus*>(m_object->GetLink(info.lParam));
		if (stimlink)
		{
			stimlink->inc_ref();
			RemoveLink(stimlink);
			m_parent.SetUndoAction(new UndoRemoveObjectStimulus(m_object->GetId(), stimlink));
			stimlink->dec_ref();
		}
	}
}

void ObjWindow::DoAddReceptron()
{
	try
	{
		IntegerListDialog dlg(IDS_ADDRECEPTRONPROMPT, IDS_ADDRECEPTRONTITLE);
		{
			SetCursor(LoadCursor(NULL, IDC_WAIT));
			vector<sint32> allstims;
			find_object_descendants(m_parent.Database(), 
					find_object_id(m_parent.Database(), "Stimulus"), allstims);
			vector<sint32>::const_iterator stim = allstims.begin();
			while (stim != allstims.end())
			{
				DarkObject* stimobj = m_parent.Database()->GetObject(*stim++);
				dlg.Add(print_object_name(m_parent.Database(),stimobj), stimobj->GetId());
			}
			SetCursor(LoadCursor(NULL, IDC_ARROW));
		}
		if (!dlg(m_parent))
			return;

		SetCursor(LoadCursor(NULL, IDC_WAIT));
		sint32 stimid = dlg.ListInt();
		if (stimid != 0)
		{
			DarkLinkReceptron* rcptnlink = CreateReceptron(stimid);
			if (rcptnlink)
			{
				m_parent.SetUndoAction(new UndoAddObjectReceptron(m_object->GetId(), rcptnlink));
				EditReceptronItem(rcptnlink->GetId());
				rcptnlink->dec_ref();
			}
		}
		SetCursor(LoadCursor(NULL, IDC_ARROW));
	}
	catch (exception &e)
	{
		SetCursor(LoadCursor(NULL, IDC_ARROW));
		m_parent.ErrorMessage(e.what());
	}
}

void ObjWindow::DoRemoveReceptron()
{
	LVITEM info;
	info.mask = LVIF_PARAM;
	info.iSubItem = 0;
	info.iItem = ListView_GetNextItem(m_receptrons, (WPARAM)-1, LVNI_SELECTED);
	if (info.iItem >= 0)
	{
		ListView_GetItem(m_receptrons, &info);
		DarkLinkReceptron* rcptnlink = dynamic_cast<DarkLinkReceptron*>(m_object->GetLink(info.lParam));
		if (rcptnlink)
		{
			rcptnlink->inc_ref();
			RemoveLink(rcptnlink);
			m_parent.SetUndoAction(new UndoRemoveObjectReceptron(m_object->GetId(), rcptnlink));
			rcptnlink->dec_ref();
		}
	}
}

void ObjWindow::DisplayListItem(HWND listwin, LVITEM& item)
{
	if (!(item.mask & LVIF_TEXT))
		return;

	if (listwin == m_metaprops)
		DisplayMetaproperty(item);
	else if (listwin == m_links)
		DisplayLink(item);
	else if (listwin == m_stims)
		DisplayStimulus(item);
	else if (listwin == m_receptrons)
		DisplayReceptron(item);
}

void ObjWindow::DisplayMetaproperty(LVITEM& item)
{
	DarkLinkMetaProp* mp = dynamic_cast<DarkLinkMetaProp*>(m_object->GetLink(item.lParam));
	if (!mp)
	{
		lstrcpyn(item.pszText, (item.iSubItem==0)?TEXT("<error>"):TEXT(""), item.cchTextMax);
		return;
	}
	if (item.iSubItem == 0)
	{
		string mpname = print_object_name(m_parent.Database(), 
				m_parent.Database()->GetObject(mp->GetDest()));
#ifdef UNICODE
		int len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
				mpname.data(), mpname.size(),
				item.pszText, item.cchTextMax);
		item.pszText[len] = TEXT('\0');
#else
		mpname.copy(item.pszText, item.cchTextMax);
		item.pszText[min(item.cchTextMax,int(mpname.size()))] = '\0';
#endif
	}
	else if (item.iSubItem == 1)
	{
		TCHAR datastr[12];
		wsprintf(datastr, TEXT("%ld"), mp->GetPriority());
		lstrcpyn(item.pszText, datastr, item.cchTextMax);
	}
}

void ObjWindow::DisplayLink(LVITEM& item)
{
	bool reverse = false;
	sint32 linkid = item.lParam;
	if (linkid < 0)
	{
		reverse = true;
		linkid = -linkid;
	}
	DarkLink* link = m_object->GetLink(linkid);
	if (!link)
	{
		lstrcpyn(item.pszText, (item.iSubItem==0)?TEXT("<error>"):TEXT(""), item.cchTextMax);
		return;
	}
	string data("");
	switch (item.iSubItem)
	{
	  case 0:
	  {
		TCHAR datastr[12];
		wsprintf(datastr, TEXT("%08lX"), item.lParam);
		lstrcpyn(item.pszText, datastr, item.cchTextMax);
		return;
	  }
	  case 1:
		if (reverse)
		  data = "~";
		data += m_parent.Database()->FlavorName(link->GetFlavor());
		break;
	  case 2:
		data = print_object_name(m_parent.Database(),
				m_parent.Database()->GetObject((reverse)?link->GetDest():link->GetSource()));
		break;
	  case 3:
		data = print_object_name(m_parent.Database(),
				m_parent.Database()->GetObject((reverse)?link->GetSource():link->GetDest()));
		break;
	}
#ifdef UNICODE
	int len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
			data.data(), data.size(),
			item.pszText, item.cchTextMax);
	item.pszText[len] = TEXT('\0');
#else
	data.copy(item.pszText, item.cchTextMax);
	item.pszText[min(item.cchTextMax,int(data.size()))] = '\0';
#endif
}

void ObjWindow::DisplayStimulus(LVITEM& item)
{
	DarkLinkStimulus* stim = dynamic_cast<DarkLinkStimulus*>(m_object->GetLink(item.lParam));
	if (!stim)
	{
		lstrcpyn(item.pszText, (item.iSubItem==0)?TEXT("<error>"):TEXT(""), item.cchTextMax);
		return;
	}
	string data;
	switch (item.iSubItem)
	{
	case 0:
	{
		TCHAR datastr[12];
		wsprintf(datastr, TEXT("%08lX"), stim->GetId());
		lstrcpyn(item.pszText, datastr, item.cchTextMax);
		return;
	}
	case 1: // Stimulus
		data = print_object_name(m_parent.Database(),
				m_parent.Database()->GetObject(stim->GetDest()));
		break;
	case 2: // Propagation
		data = stim->GetPropagationName();
		break;
	case 3: // Intensity
		data = formatfloat(stim->GetSourceDesc().intensity);
		break;
	}
#ifdef UNICODE
	int len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
			data.data(), data.size(),
			item.pszText, item.cchTextMax);
	item.pszText[len] = TEXT('\0');
#else
	data.copy(item.pszText, item.cchTextMax);
	item.pszText[min(item.cchTextMax,int(data.size()))] = '\0';
#endif
}

void ObjWindow::DisplayReceptron(LVITEM& item)
{
	DarkLinkReceptron* rcptn = dynamic_cast<DarkLinkReceptron*>(m_object->GetLink(item.lParam));
	if (!rcptn)
	{
		lstrcpyn(item.pszText, (item.iSubItem==0)?TEXT("<error>"):TEXT(""), item.cchTextMax);
		return;
	}
	string data;
	switch (item.iSubItem)
	{
	case 0:
	{
		TCHAR datastr[12];
		wsprintf(datastr, TEXT("%08lX"), rcptn->GetId());
		lstrcpyn(item.pszText, datastr, item.cchTextMax);
		return;
	}
	case 1: // Stimulus
		data = print_object_name(m_parent.Database(),
				m_parent.Database()->GetObject(rcptn->GetDest()));
		break;
	case 2: // Reaction
		data = rcptn->GetReactionName();
		break;
	case 3: // Min. Intensity
		if (rcptn->GetReactionDesc().flags & RECEPTRON_NOMIN)
			data = "None";
		else
			data = formatfloat(rcptn->GetReactionDesc().minintensity);
		break;
	case 4: // Max. Intensity
		if (rcptn->GetReactionDesc().flags & RECEPTRON_NOMAX)
			data = "None";
		else
			data = formatfloat(rcptn->GetReactionDesc().maxintensity);
		break;
	}
#ifdef UNICODE
	int len = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
			data.data(), data.size(),
			item.pszText, item.cchTextMax);
	item.pszText[len] = TEXT('\0');
#else
	data.copy(item.pszText, item.cchTextMax);
	item.pszText[min(item.cchTextMax,int(data.size()))] = '\0';
#endif
}

bool ObjWindow::EditListItem(HWND listwin, int rownum)
{
	LVITEM info;
	info.mask = LVIF_PARAM;
	info.iItem = rownum;
	info.iSubItem = 0;
	ListView_GetItem(listwin, &info);
	if (listwin == m_metaprops)
	{
		return EditMetapropertyItem(info.lParam);
	}
	else if (listwin == m_links)
	{
		return EditLinkItem(info.lParam);
	}
	else if (listwin == m_stims)
	{
		return EditStimItem(info.lParam);
	}
	else if (listwin == m_receptrons)
	{
		return EditReceptronItem(info.lParam);
	}
	return false;
}

bool ObjWindow::EditMetapropertyItem(sint32 id)
{
	DarkLinkMetaProp* mp = dynamic_cast<DarkLinkMetaProp*>(m_object->GetLink(id));
	if (!mp)
		return false;
	TCHAR winname[32];
	wsprintf(winname, TEXT("MetaProperty #%08lX"), mp->GetId());
	PropertyTree* editor = OpenEditor(mp->GetId(), m_metaprops, winname);
	if (!editor)
		return false;
	if (! editor->HasSource())
		editor->SetSource(new DarkMetapropertySource(m_parent.Database(), mp));
	editor->Show();
	
	editor->SendMessage(WM_SETREDRAW, FALSE, 0);
	editor->AddProperty("Metaprop");
	editor->AddProperty("Priority");
	editor->SendMessage(WM_SETREDRAW, TRUE, 0);
	InvalidateRect(*editor, NULL, TRUE);

	return true;
}

bool ObjWindow::EditLinkItem(sint32 id)
{
	if (id < 0)
		id = -id;
	DarkLink* l = m_object->GetLink(id);
	if (!l)
		return false;
	_tstring winname = m_parent.Database()->FlavorName(l->GetFlavor());
	TCHAR buf[16];
	wsprintf(buf, TEXT(" Link #%08lX"), l->GetId());
	winname += buf;
	PropertyTree* editor = OpenEditor(l->GetId(), m_links, winname.c_str());
	if (! editor)
		return false;
	if (! editor->HasSource())
		editor->SetSource(new DarkLinkSource(m_parent.Database(), l));
	editor->Show();

	editor->SendMessage(WM_SETREDRAW, FALSE, 0);
	editor->AddProperty("__source");
	editor->SetState("__source", PropertyTree::stateLocked);
	editor->AddProperty("__dest");
	try
	{
		const StructInfo* linfo = 
				DarkDataSource::GetStructReader().GetStruct(m_parent.Database()->FlavorName(l->GetFlavor()));
		if (linfo->NumFields() > 0)
		{
			string basename("__data");
			editor->AddProperty(basename);
			StructIterator liter = linfo->Begin();
			StructIterator lend = linfo->End();
			string lname;
			for (; liter != lend; ++liter)
			{
				if ((*liter).find('\\') != size_t(-1))
					editor->AddProperty(*liter, (*liter).substr(0,(*liter).rfind('\\')));
				else
					editor->AddProperty(*liter, basename);
				if (liter->Type() == typeBITFIELD::name)
					editor->SetState(*liter, PropertyTree::stateBitfield);
			}
			editor->MakeVisible(basename, true);
		}
	}
	catch (out_of_range &e)
	{ }
	editor->SendMessage(WM_SETREDRAW, TRUE, 0);
	InvalidateRect(*editor, NULL, TRUE);

	return true;
}

bool ObjWindow::EditStimItem(sint32 id)
{
	DarkLinkStimulus* stim = dynamic_cast<DarkLinkStimulus*>(m_object->GetLink(id));
	if (!stim)
		return false;
	TCHAR winname[32];
	wsprintf(winname, TEXT("Stim Source #%08lX"), stim->GetId());
	PropertyTree* editor = OpenEditor(stim->GetId(), m_stims, winname);
	if (!editor)
		return false;
	if (! editor->HasSource())
		editor->SetSource(new DarkStimulusSource(m_parent.Database(), stim));
	editor->Show();

	editor->SendMessage(WM_SETREDRAW, FALSE, 0);
	editor->AddProperty("__stim");
	editor->AddProperty("sourcetype");
	editor->AddProperty("intensity");
	InitStimulusEditorProps(editor, stim);
	editor->SendMessage(WM_SETREDRAW, TRUE, 0);
	InvalidateRect(*editor, NULL, TRUE);

	return true;
}

void ObjWindow::InitStimulusEditorProps(PropertyTree* editor, DarkLinkStimulus* stim)
{
	try
	{
		const StructFieldStruct* datafield = NULL;
		string basename;
		if (stim->GetSourceDesc().sourcetype == STIMSOURCE_CONTACT)
		{
			datafield = dynamic_cast<const StructFieldStruct*>(
					DarkDataSource::GetStructReader().GetStruct("arSrcDesc")->Field("shapecontact"));
			basename = "shapecontact";
			editor->AddProperty(basename);
			StructIterator siter = datafield->Value()->Begin();
			StructIterator send = datafield->Value()->End();
			string sname;
			for (; siter != send; ++siter)
			{
				sname = basename + "\\" + *siter;
				editor->AddProperty(sname, sname.substr(0,sname.rfind('\\')));
				if (siter->Type() == typeBITFIELD::name)
					editor->SetState(sname, PropertyTree::stateBitfield);
			}
			editor->MakeVisible(basename, true);
		}
		else if (stim->GetSourceDesc().sourcetype == STIMSOURCE_RADIUS)
		{
			datafield = dynamic_cast<const StructFieldStruct*>(
					DarkDataSource::GetStructReader().GetStruct("arSrcDesc")->Field("shaperadius"));
			basename = "shaperadius";
			editor->AddProperty(basename);
			StructIterator siter = datafield->Value()->Begin();
			StructIterator send = datafield->Value()->End();
			string sname;
			for (; siter != send; ++siter)
			{
				sname = basename + "\\" + *siter;
				editor->AddProperty(sname, sname.substr(0,sname.rfind('\\')));
				if (siter->Type() == typeBITFIELD::name)
					editor->SetState(sname, PropertyTree::stateBitfield);
			}
			editor->MakeVisible(basename, true);
		}
		if (stim->GetSourceDesc().validfields & STIMFIELDS_LIFECYCLE)
		{
			datafield = dynamic_cast<const StructFieldStruct*>(
					DarkDataSource::GetStructReader().GetStruct("arSrcDesc")->Field("lifecycle"));
			basename = "lifecycle";
			editor->AddProperty(basename);
			StructIterator siter = datafield->Value()->Begin();
			StructIterator send = datafield->Value()->End();
			string sname;
			for (; siter != send; ++siter)
			{
				sname = basename + "\\" + *siter;
				editor->AddProperty(sname, sname.substr(0,sname.rfind('\\')));
				if (siter->Type() == typeBITFIELD::name)
					editor->SetState(sname, PropertyTree::stateBitfield);
			}
			editor->MakeVisible(basename, true);
		}
	}
	catch (out_of_range &e)
	{ }
}

void ObjWindow::BeginStimSourceEdit(LinkEditor* info)
{
	if (info->data)
	{
		delete info->data;
		info->data = NULL;
	}
	DarkLinkStimulus* stim = dynamic_cast<DarkLinkStimulus*>(m_object->GetLink(info->linkid));
	if (stim)
	{
		info->data = new string(stim->GetPropagationName());
	}
}

void ObjWindow::EndStimSourceEdit(LinkEditor* info)
{
	DarkLinkStimulus* stim = dynamic_cast<DarkLinkStimulus*>(m_object->GetLink(info->linkid));
	stim->SetPropagationType(stim->GetSourceDesc().sourcetype);
	if (! info->data || stim->GetPropagationName() != *info->data)
	{
		info->editor->RemoveProperty("shapecontact");
		info->editor->RemoveProperty("shaperadius");
		info->editor->RemoveProperty("lifecycle");
		InitStimulusEditorProps(info->editor, stim);
	}
	delete info->data;
	info->data = NULL;
}

bool ObjWindow::EditReceptronItem(sint32 id)
{
	DarkLinkReceptron* rcptn = dynamic_cast<DarkLinkReceptron*>(m_object->GetLink(id));
	if (!rcptn)
		return false;
	TCHAR winname[32];
	wsprintf(winname, TEXT("Receptron #%08lX"), rcptn->GetId());
	PropertyTree* editor = OpenEditor(rcptn->GetId(), m_receptrons, winname);
	if (!editor)
		return false;
	if (! editor->HasSource())
		editor->SetSource(new DarkReceptronSource(m_parent.Database(), rcptn));
	editor->Show();

	editor->SendMessage(WM_SETREDRAW, FALSE, 0);
	editor->AddProperty("__stim");
	editor->AddProperty("__minintensity");
	editor->AddProperty("__maxintensity");
	editor->AddProperty("flags");
	editor->SetState("flags", PropertyTree::stateBitfield);
	editor->AddProperty("ordinal");
	editor->AddProperty("effect");
	InitReceptronEditorProps(editor, rcptn);
	editor->SendMessage(WM_SETREDRAW, TRUE, 0);
	InvalidateRect(*editor, NULL, TRUE);
	
	return true;
}

void ObjWindow::InitReceptronEditorProps(PropertyTree* editor, DarkLinkReceptron* rcptn)
{
	try
	{
		string reactionname;
		transform(rcptn->GetReactionName().begin(), rcptn->GetReactionName().end(), 
				back_inserter(reactionname), pointer_to_unary_function<int,int>(::tolower));
		if (reactionname == "add_metaprop"
		 || reactionname == "rem_metaprop" 
		 || reactionname == "stimulate"
		 || reactionname == "add_prop"
		 || reactionname == "clone_props"
		 || reactionname == "create_obj"
		 || reactionname == "move_obj"
		 || reactionname == "damage"
		 || reactionname == "spoofdamage"
		 || reactionname == "slay"
		 || reactionname == "awarefilter"
		 || reactionname == "knockout"
		 || reactionname == "weapon_hit"
		 || reactionname == "weapon_block")
		{
			 editor->AddProperty("__target");
			 editor->AddProperty("__agent");
		}
		else if (reactionname == "destroy_obj"
			  || reactionname == "frob_obj"
			  || reactionname == "set_model"
			  || reactionname == "rem_prop"
			  || reactionname == "permeate"
			  || reactionname == "tweq_control")
		{
			 editor->AddProperty("__target");
		}
		string basename = "Reaction:";
		basename += reactionname;
		const StructInfo* reactstruct = 
				DarkDataSource::GetStructReader().GetStruct(basename);
		if (reactstruct->NumFields() > 0)
		{
			editor->AddProperty(basename);
			StructIterator siter = reactstruct->Begin();
			StructIterator send = reactstruct->End();
			string sname;
			for (; siter != send; ++siter)
			{
				sname = basename + "\\" + *siter;
				editor->AddProperty(sname, sname.substr(0,sname.rfind('\\')));
				if (siter->Type() == typeBITFIELD::name)
					editor->SetState(sname, PropertyTree::stateBitfield);
			}
			editor->MakeVisible(basename, true);
		}
	}
	catch (out_of_range &e)
	{ }
}

void ObjWindow::BeginReactionEffectEdit(LinkEditor* info)
{
	if (info->data)
	{
		delete info->data;
		info->data = NULL;
	}
	DarkLinkReceptron* rcptn = dynamic_cast<DarkLinkReceptron*>(m_object->GetLink(info->linkid));
	if (rcptn)
	{
		info->data = new string(rcptn->GetReactionName());
	}
}

void ObjWindow::EndReactionEffectEdit(LinkEditor* info)
{
	DarkLinkReceptron* rcptn = dynamic_cast<DarkLinkReceptron*>(m_object->GetLink(info->linkid));
	if (! info->data || rcptn->GetReactionName() != *info->data)
	{
		info->editor->RemoveProperty("__target");
		info->editor->RemoveProperty("__agent");
		string reactionprop("Reaction:");
		transform(info->data->begin(), info->data->end(), back_inserter(reactionprop),
				pointer_to_unary_function<int,int>(::tolower));
		info->editor->RemoveProperty(reactionprop);
		InitReceptronEditorProps(info->editor, rcptn);
	}
	delete info->data;
	info->data = NULL;
}

PropertyTree* ObjWindow::FindEditor(sint32 id)
{
	PropertyTree* editor = NULL;
	map<sint32,LinkEditor*>::iterator i = m_editors.find(id);
	if (i != m_editors.end())
	{
		i->second->editor->Focus();
		editor = i->second->editor;
	}
	return editor;
}

PropertyTree* ObjWindow::CreateEditor(sint32 id, const Window& listwin, LPCTSTR title)
{
	PropertyTree* editor = NULL;
	LinkEditor* info = new LinkEditor(id,listwin);
	pair<map<sint32,LinkEditor*>::iterator,bool> result = 
			m_editors.insert(make_pair(id,info));
	if (!result.second)
	{
		delete info;
		return NULL;
	}
	editor = info->editor;
	if (!editor->Create(m_window, gInstance, title))
	{
		delete info;
		m_editors.erase(result.first);
		return NULL;
	}
	SetWindowLong(*editor, GWL_EXSTYLE, WS_EX_WINDOWEDGE | WS_EX_TOOLWINDOW);
	editor->SetRealParent(m_window);
	return editor;
}

PropertyTree* ObjWindow::OpenEditor(sint32 id, const Window& listwin, LPCTSTR title)
{
	PropertyTree* editor = FindEditor(id);
	if (! editor)
		editor = CreateEditor(id, listwin, title);
	return editor;
}

void ObjWindow::EraseEditor(sint32 id)
{
	map<sint32,LinkEditor*>::iterator i = m_editors.find(id);
	if (i != m_editors.end())
	{
		delete i->second;
		m_editors.erase(i);
	}
}

void ObjWindow::CloseEditor(sint32 id)
{
	map<sint32,LinkEditor*>::iterator i = m_editors.find(id);
	if (i != m_editors.end())
	{
		::DestroyWindow(*i->second->editor);
	}
}

void ObjWindow::ToggleEditors(int param)
{
	map<sint32,LinkEditor*>::const_iterator i = m_editors.begin();
	for (; i != m_editors.end(); ++i)
		::ShowWindow(*(i->second->editor), param);
};

PropertyTree* ObjWindow::GetPropertyEditor()
{
	return &m_props;
}

PropertyTree* ObjWindow::GetMetapropertyEditor(sint32 id)
{
	PropertyTree* editor = FindEditor(id);
	if (! editor)
	{
		if (EditMetapropertyItem(id))
			editor = FindEditor(id);
	}
	return editor;
}

PropertyTree* ObjWindow::GetLinkEditor(sint32 id)
{
	PropertyTree* editor = FindEditor(id);
	if (! editor)
	{
		if (EditLinkItem(id))
			editor = FindEditor(id);
	}
	return editor;
}

PropertyTree* ObjWindow::GetStimulusEditor(sint32 id)
{
	PropertyTree* editor = FindEditor(id);
	if (! editor)
	{
		if (EditStimItem(id))
			editor = FindEditor(id);
	}
	return editor;
}

PropertyTree* ObjWindow::GetReceptronEditor(sint32 id)
{
	PropertyTree* editor = FindEditor(id);
	if (! editor)
	{
		if (EditReceptronItem(id))
			editor = FindEditor(id);
	}
	return editor;
}

void ObjWindow::HandlePropertyChanging(const PTNINFO* propinfo)
{
	if (propinfo->hdr.hwndFrom != m_props)
	{
		LinkEditor* linfo = reinterpret_cast<LinkEditor*>(propinfo->userdata);
		if (linfo->listwin == m_stims
		 && *propinfo->name == "sourcetype")
		{
			BeginStimSourceEdit(linfo);
		}
		else if (linfo->listwin == m_receptrons
		 && *propinfo->name == "effect")
		{
			BeginReactionEffectEdit(linfo);
		}
	}
}

void ObjWindow::HandlePropertyChanged(const PTNINFO* propinfo)
{
	if (propinfo->newdata)
	{
		UndoRecord* undo = NULL;
		if (propinfo->hdr.hwndFrom == m_props)
			undo = new UndoChangeProperty(m_object->GetId(), 
					*propinfo->name, *propinfo->olddata, *propinfo->newdata);
		else
		{
			LinkEditor* linfo = reinterpret_cast<LinkEditor*>(propinfo->userdata);
			if (linfo->listwin == m_metaprops)
				undo = new UndoChangeMetaproperty(m_object->GetId(), linfo->linkid,
						*propinfo->name, *propinfo->olddata, *propinfo->newdata);
			else if (linfo->listwin == m_links)
				undo = new UndoChangeLink(m_object->GetId(), linfo->linkid,
						*propinfo->name, *propinfo->olddata, *propinfo->newdata);
			else if (linfo->listwin == m_stims)
				undo = new UndoChangeStimulus(m_object->GetId(), linfo->linkid,
						*propinfo->name, *propinfo->olddata, *propinfo->newdata);
			else if (linfo->listwin == m_receptrons)
				undo = new UndoChangeReceptron(m_object->GetId(), linfo->linkid,
						*propinfo->name, *propinfo->olddata, *propinfo->newdata);
		}
		if (undo)
			m_parent.SetUndoAction(undo);
	}

	if (propinfo->hdr.hwndFrom == m_props)
	{
		if (! propinfo->name->compare(0, 7, "SymName"))
		{
			m_parent.UpdateObject(m_object);
		}
	}
	else
	{
		LinkEditor* linfo = reinterpret_cast<LinkEditor*>(propinfo->userdata);
		if (linfo->listwin == m_stims
		 && *propinfo->name == "sourcetype")
			EndStimSourceEdit(linfo);
		else if (linfo->listwin == m_receptrons
		 && *propinfo->name == "effect")
			EndReactionEffectEdit(linfo);
		else if (linfo->listwin == m_receptrons
		 && (*propinfo->name == "__minintensity"
			|| *propinfo->name == "__maxintensity"
			|| *propinfo->name == "flags"))
		{
			linfo->editor->UpdateProperty("__minintensity");
			linfo->editor->UpdateProperty("__maxintensity");
			linfo->editor->UpdateProperty("flags");
		}
		linfo->Update();
	}
}

void ObjWindow::HandlePropertyChangeCanceled(const PTNINFO* propinfo)
{
	if (propinfo->hdr.hwndFrom != m_props)
	{
		LinkEditor* linfo = reinterpret_cast<LinkEditor*>(propinfo->userdata);
		if (linfo->data)
		{
			delete linfo->data;
			linfo->data = NULL;
		}
	}
}


/*
ObjWindow::LinkEditor::LinkEditor(sint32 l, const Window& w, const Window& p)
	: listwin(w), linkid(l)
{
	editor = new PropertyTree(p, gInstance, reinterpret_cast<void*>(this));
}
*/

ObjWindow::LinkEditor::LinkEditor(sint32 l, const Window& w)
	: listwin(w), linkid(l), data(NULL)
{
	editor = new PropertyTree(reinterpret_cast<void*>(this));
}

ObjWindow::LinkEditor::~LinkEditor()
{
	delete data;
	delete editor;
}

void ObjWindow::LinkEditor::Update()
{
	LVFINDINFO info;
	info.flags = LVFI_PARAM;
	info.lParam = linkid;
	int rownum = ListView_FindItem(listwin, (WPARAM)-1, &info);
	if (rownum >= 0)
		ListView_Update(listwin, rownum);
}

