#include "ObjTreeDialogs.h"
#include "resources.h"

#include "DarkLib/DarkIterators.h"

using namespace std;
using namespace Dark;

#define _FORMATFLAGS	FORMAT_MESSAGE_ALLOCATE_BUFFER | \
						FORMAT_MESSAGE_IGNORE_INSERTS | \
						FORMAT_MESSAGE_FROM_SYSTEM

dialog_error::dialog_error(DWORD err)
	: runtime_error(""), m_msg("OS error"), m_err(err)
{
	LPTSTR msg = NULL;
	DWORD len = FormatMessageA(_FORMATFLAGS, NULL, err, GetUserDefaultLangID(), 
			reinterpret_cast<LPTSTR>(&msg), 0, NULL);
	if (len > 0)
	{
		m_msg += ": ";
		m_msg.append(msg, len);
	}
	if (msg)
		LocalFree(msg);
}

const char* dialog_error::what() const throw()
{
	return m_msg.c_str();
}


BOOL CALLBACK BaseDialog::DlgProc(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
{
	if (msg == WM_INITDIALOG)
		return TRUE;
	
	if (msg == WM_COMMAND)
	{
		switch (LOWORD(wparam))
		{
		case IDOK:
		case IDCANCEL:
			EndDialog(hwnd, LOWORD(wparam));
			return TRUE;
		}
	}
	return FALSE;
}

BaseDialog::~BaseDialog()
{
	FreeResource(m_dlghandle);
}

BaseDialog::BaseDialog()
	: m_dlghandle(NULL)
{
}

BaseDialog::BaseDialog(LPCTSTR dlg)
{
	CreateDialog(dlg);
}

void BaseDialog::CreateDialog(LPCTSTR dlg)
{
	if (m_dlghandle)
		FreeResource(m_dlghandle);
	HRSRC res = FindResourceEx(NULL, RT_DIALOG, dlg, MAKELANGID(LANG_NEUTRAL,SUBLANG_NEUTRAL));
	if (! res)
		throw dialog_error(GetLastError());
	m_dlghandle = LoadResource(NULL, res);
	if (! m_dlghandle)
		throw dialog_error(GetLastError());
}

bool BaseDialog::operator()(HWND parent)
{
	LPCDLGTEMPLATE dlg = reinterpret_cast<LPCDLGTEMPLATE>(LockResource(m_dlghandle));
	if (!dlg)
		throw dialog_error(GetLastError());
	int ret = DialogBoxIndirectParam(NULL, dlg, parent, DlgProc, reinterpret_cast<LPARAM>(this));
	switch (ret)
	{
	case 0:
	case IDOK:
		return true;
	case IDCANCEL:
		return false;
	case -1:
		throw dialog_error(GetLastError());
	default:
		throw dialog_error(ret);
	}
	return false;
}


BOOL CALLBACK StringInputDialog::DlgProc(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
{
	StringInputDialog* dlg;
	if (msg == WM_INITDIALOG)
	{
		dlg = reinterpret_cast<StringInputDialog*>(lparam);
		if (!dlg)
		{
			EndDialog(hwnd, ERROR_INVALID_HANDLE);
			return FALSE;
		}
		SetWindowLong(hwnd, DWL_USER, reinterpret_cast<LONG>(dlg));
		if (! dlg->m_caption.empty())
			SetWindowText(hwnd, dlg->m_caption.c_str());
		if (! dlg->m_prompt.empty())
			SetDlgItemText(hwnd, IDD_STATICTEXT, dlg->m_prompt.c_str());
		SetDlgItemText(hwnd, IDD_EDITTEXT, dlg->m_text.c_str());
		return TRUE;
	}
	dlg = reinterpret_cast<StringInputDialog*>(GetWindowLong(hwnd, DWL_USER));
	if (msg == WM_COMMAND)
	{
		switch (LOWORD(wparam))
		{
		case IDOK:
			if (dlg)
			{
				int len = SendDlgItemMessage(hwnd, IDD_EDITTEXT, WM_GETTEXTLENGTH, 0, 0);
				if (len == 0)
				{
					dlg->m_text.clear();
				}
				else
				{
					TCHAR* buf = new TCHAR[len+1];
					len = SendDlgItemMessage(hwnd, IDD_EDITTEXT, WM_GETTEXT, len+1, reinterpret_cast<LPARAM>(buf));
					dlg->m_text.assign(buf, len);
					delete[] buf;
				}
			}
		case IDCANCEL:
			EndDialog(hwnd, LOWORD(wparam));
			return TRUE;
		}
	}
	return BaseDialog::DlgProc(hwnd, msg, wparam, lparam);
}

StringInputDialog::~StringInputDialog()
{
}

StringInputDialog::StringInputDialog()
	: BaseDialog(MAKEINTRESOURCE(ID_STRINGINPUT))
{
}

StringInputDialog::StringInputDialog(LPCTSTR dlg)
	: BaseDialog(dlg)
{
}

StringInputDialog::StringInputDialog(const _tstring& prompt, const _tstring& title)
	: BaseDialog(MAKEINTRESOURCE(ID_STRINGINPUT)), m_caption(title), m_prompt(prompt)
{
}

StringInputDialog::StringInputDialog(LPCTSTR dlg, const _tstring& prompt, const _tstring& title)
	: BaseDialog(dlg), m_caption(title), m_prompt(prompt)
{
}

StringInputDialog::StringInputDialog(UINT prompt, UINT title)
	: BaseDialog(MAKEINTRESOURCE(ID_STRINGINPUT))
{
	TCHAR strbuf[1024];
	int strlen = LoadString(NULL, title, strbuf, 1024);
	if (! strlen)
		throw dialog_error(GetLastError());
	m_caption.assign(strbuf, strlen);
	strlen = LoadString(NULL, prompt, strbuf, 1024);
	if (! strlen)
		throw dialog_error(GetLastError());
	m_prompt.assign(strbuf, strlen);
}

StringInputDialog::StringInputDialog(LPCTSTR dlg, UINT prompt, UINT title)
	: BaseDialog(dlg)
{
	TCHAR strbuf[1024];
	int strlen = LoadString(NULL, title, strbuf, 1024);
	if (! strlen)
		throw dialog_error(GetLastError());
	m_caption.assign(strbuf, strlen);
	strlen = LoadString(NULL, prompt, strbuf, 1024);
	if (! strlen)
		throw dialog_error(GetLastError());
	m_prompt.assign(strbuf, strlen);
}

bool StringInputDialog::operator()(HWND parent)
{
	LPCDLGTEMPLATE dlg = reinterpret_cast<LPCDLGTEMPLATE>(LockResource(m_dlghandle));
	if (!dlg)
		throw dialog_error(GetLastError());
	int ret = DialogBoxIndirectParam(NULL, dlg, parent, DlgProc, reinterpret_cast<LPARAM>(this));
	switch (ret)
	{
	case 0:
	case IDOK:
		return true;
	case IDCANCEL:
		return false;
	case -1:
		throw dialog_error(GetLastError());
	default:
		throw dialog_error(ret);
	}
	return false;
}

bool StringInputDialog::operator()(HWND parent, const _tstring& inittext)
{
	m_text = inittext;
	LPCDLGTEMPLATE dlg = reinterpret_cast<LPCDLGTEMPLATE>(LockResource(m_dlghandle));
	if (!dlg)
		throw dialog_error(GetLastError());
	int ret = DialogBoxIndirectParam(NULL, dlg, parent, DlgProc, reinterpret_cast<LPARAM>(this));
	switch (ret)
	{
	case 0:
	case IDOK:
		return true;
	case IDCANCEL:
		return false;
	case -1:
		throw dialog_error(GetLastError());
	default:
		throw dialog_error(ret);
	}
	return false;
}


BOOL CALLBACK StringListDialog::DlgProc(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
{
	StringListDialog* dlg;
	if (msg == WM_INITDIALOG)
	{
		dlg = reinterpret_cast<StringListDialog*>(lparam);
		if (!dlg)
		{
			EndDialog(hwnd, ERROR_INVALID_HANDLE);
			return FALSE;
		}
		SetWindowLong(hwnd, DWL_USER, reinterpret_cast<LONG>(dlg));
		if (! dlg->m_caption.empty())
			SetWindowText(hwnd, dlg->m_caption.c_str());
		if (! dlg->m_prompt.empty())
			SetDlgItemText(hwnd, IDD_STATICLIST, dlg->m_prompt.c_str());
		HWND listctrl = GetDlgItem(hwnd, IDD_EDITLIST);
		int index = 0;
		for (_listtype::const_iterator i = dlg->m_list.begin();
			 i != dlg->m_list.end(); ++i, ++index)
		{
			int id = SendMessage(listctrl, CB_ADDSTRING, 0, reinterpret_cast<LPARAM>(i->first.c_str()));
			SendMessage(listctrl, CB_SETITEMDATA, id, index);
		}
		index = SendMessage(listctrl, CB_FINDSTRINGEXACT, 0, reinterpret_cast<LPARAM>(dlg->m_text.c_str()));
		if (! dlg->m_text.empty() && index != CB_ERR)
		{
			dlg->m_selection = index;
			SendMessage(listctrl, CB_SETCURSEL, index, 0);
		}
		else
			SendMessage(listctrl, CB_SETCURSEL, dlg->m_selection, 0);
		return TRUE;
	}
	dlg = reinterpret_cast<StringListDialog*>(GetWindowLong(hwnd, DWL_USER));
	if (msg == WM_COMMAND && LOWORD(wparam) == IDOK)
	{
		if (dlg)
		{
			int id = SendDlgItemMessage(hwnd, IDD_EDITLIST, CB_GETCURSEL, 0, 0);
			if (id == CB_ERR)
			{
				dlg->m_selection = size_t(-1);
			}
			else
			{
				dlg->m_selection = 
						SendDlgItemMessage(hwnd, IDD_EDITLIST, CB_GETITEMDATA, id, 0);
			}
		}
	}
	return StringInputDialog::DlgProc(hwnd, msg, wparam, lparam);
}

StringListDialog::~StringListDialog()
{
}

StringListDialog::StringListDialog()
	: StringInputDialog(MAKEINTRESOURCE(ID_LISTINPUT)), m_selection(0)
{
}

StringListDialog::StringListDialog(const _tstring& prompt, const _tstring& title)
	: StringInputDialog(MAKEINTRESOURCE(ID_LISTINPUT), prompt, title), m_selection(0)
{
}

StringListDialog::StringListDialog(UINT prompt, UINT title)
	: StringInputDialog(MAKEINTRESOURCE(ID_LISTINPUT), prompt, title), m_selection(0)
{
}

bool StringListDialog::operator()(HWND parent)
{
	LPCDLGTEMPLATE dlg = reinterpret_cast<LPCDLGTEMPLATE>(LockResource(m_dlghandle));
	if (!dlg)
		throw dialog_error(GetLastError());
	int ret = DialogBoxIndirectParam(NULL, dlg, parent, DlgProc, reinterpret_cast<LPARAM>(this));
	switch (ret)
	{
	case 0:
	case IDOK:
		return true;
	case IDCANCEL:
		return false;
	case -1:
		throw dialog_error(GetLastError());
	default:
		throw dialog_error(ret);
	}
	return false;
}

bool StringListDialog::operator()(HWND parent, const _tstring& inittext)
{
	m_text = inittext;
	LPCDLGTEMPLATE dlg = reinterpret_cast<LPCDLGTEMPLATE>(LockResource(m_dlghandle));
	if (!dlg)
		throw dialog_error(GetLastError());
	int ret = DialogBoxIndirectParam(NULL, dlg, parent, DlgProc, reinterpret_cast<LPARAM>(this));
	switch (ret)
	{
	case 0:
	case IDOK:
		return true;
	case IDCANCEL:
		return false;
	case -1:
		throw dialog_error(GetLastError());
	default:
		throw dialog_error(ret);
	}
	return false;
}

bool StringListDialog::operator()(HWND parent, size_t initsel)
{
	m_selection = initsel;
	LPCDLGTEMPLATE dlg = reinterpret_cast<LPCDLGTEMPLATE>(LockResource(m_dlghandle));
	if (!dlg)
		throw dialog_error(GetLastError());
	int ret = DialogBoxIndirectParam(NULL, dlg, parent, DlgProc, reinterpret_cast<LPARAM>(this));
	switch (ret)
	{
	case 0:
	case IDOK:
		return true;
	case IDCANCEL:
		return false;
	case -1:
		throw dialog_error(GetLastError());
	default:
		throw dialog_error(ret);
	}
	return false;
}

void StringListDialog::Add(const _tstring& displaystring, const _tstring& returnstring)
{
	m_list.push_back(make_pair(displaystring,returnstring));
}

const _tstring& StringListDialog::ListText() const
{
	if (m_selection >= m_list.size())
		throw out_of_range("StringListDialog::ListText");
	return m_list.at(m_selection).second;
}

BOOL CALLBACK IntegerListDialog::DlgProc(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
{
	IntegerListDialog* dlg;
	if (msg == WM_INITDIALOG)
	{
		dlg = reinterpret_cast<IntegerListDialog*>(lparam);
		if (!dlg)
		{
			EndDialog(hwnd, ERROR_INVALID_HANDLE);
			return FALSE;
		}
		SetWindowLong(hwnd, DWL_USER, reinterpret_cast<LONG>(dlg));
		if (! dlg->m_caption.empty())
			SetWindowText(hwnd, dlg->m_caption.c_str());
		if (! dlg->m_prompt.empty())
			SetDlgItemText(hwnd, IDD_STATICLIST, dlg->m_prompt.c_str());
		HWND listctrl = GetDlgItem(hwnd, IDD_EDITLIST);
		int index = 0;
		for (_listtype::const_iterator i = dlg->m_list.begin();
			 i != dlg->m_list.end(); ++i, ++index)
		{
			int id = SendMessage(listctrl, CB_ADDSTRING, 0, reinterpret_cast<LPARAM>(i->first.c_str()));
			SendMessage(listctrl, CB_SETITEMDATA, id, i->second);
		}
		index = SendMessage(listctrl, CB_FINDSTRINGEXACT, 0, reinterpret_cast<LPARAM>(dlg->m_text.c_str()));
		if (! dlg->m_text.empty() && index != CB_ERR)
		{
			SendMessage(listctrl, CB_SETCURSEL, index, 0);
		}
		else
			SendMessage(listctrl, CB_SETCURSEL, 0, 0);
		return TRUE;
	}
	dlg = reinterpret_cast<IntegerListDialog*>(GetWindowLong(hwnd, DWL_USER));
	if (msg == WM_COMMAND && LOWORD(wparam) == IDOK)
	{
		if (dlg)
		{
			int id = SendDlgItemMessage(hwnd, IDD_EDITLIST, CB_GETCURSEL, 0, 0);
			if (id == CB_ERR)
			{
				dlg->m_listnum = 0;
			}
			else
			{
				dlg->m_listnum = 
						SendDlgItemMessage(hwnd, IDD_EDITLIST, CB_GETITEMDATA, id, 0);
			}
		}
	}
	return StringInputDialog::DlgProc(hwnd, msg, wparam, lparam);
}

IntegerListDialog::~IntegerListDialog()
{
}

IntegerListDialog::IntegerListDialog()
	: StringInputDialog(MAKEINTRESOURCE(ID_LISTINPUT)), m_listnum(0)
{
}

IntegerListDialog::IntegerListDialog(const _tstring& prompt, const _tstring& title)
	: StringInputDialog(MAKEINTRESOURCE(ID_LISTINPUT), prompt, title), m_listnum(0)
{
}

IntegerListDialog::IntegerListDialog(UINT prompt, UINT title)
	: StringInputDialog(MAKEINTRESOURCE(ID_LISTINPUT), prompt, title), m_listnum(0)
{
}

bool IntegerListDialog::operator()(HWND parent)
{
	LPCDLGTEMPLATE dlg = reinterpret_cast<LPCDLGTEMPLATE>(LockResource(m_dlghandle));
	if (!dlg)
		throw dialog_error(GetLastError());
	int ret = DialogBoxIndirectParam(NULL, dlg, parent, DlgProc, reinterpret_cast<LPARAM>(this));
	switch (ret)
	{
	case 0:
	case IDOK:
		return true;
	case IDCANCEL:
		return false;
	case -1:
		throw dialog_error(GetLastError());
	default:
		throw dialog_error(ret);
	}
	return false;
}

bool IntegerListDialog::operator()(HWND parent, const _tstring& inittext)
{
	m_text = inittext;
	LPCDLGTEMPLATE dlg = reinterpret_cast<LPCDLGTEMPLATE>(LockResource(m_dlghandle));
	if (!dlg)
		throw dialog_error(GetLastError());
	int ret = DialogBoxIndirectParam(NULL, dlg, parent, DlgProc, reinterpret_cast<LPARAM>(this));
	switch (ret)
	{
	case 0:
	case IDOK:
		return true;
	case IDCANCEL:
		return false;
	case -1:
		throw dialog_error(GetLastError());
	default:
		throw dialog_error(ret);
	}
	return false;
}

void IntegerListDialog::Add(const _tstring& str, long num)
{
	m_list.push_back(make_pair(str,num));
}

BOOL CALLBACK LinkInputDialog::DlgProc(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
{
	LinkInputDialog* dlg;
	if (msg == WM_INITDIALOG)
	{
		dlg = reinterpret_cast<LinkInputDialog*>(lparam);
		if (!dlg)
		{
			EndDialog(hwnd, ERROR_INVALID_HANDLE);
			return FALSE;
		}
		SetWindowLong(hwnd, DWL_USER, reinterpret_cast<LONG>(dlg));
		if (! dlg->m_caption.empty())
			SetWindowText(hwnd, dlg->m_caption.c_str());
		if (! dlg->m_prompt1.empty())
			SetDlgItemText(hwnd, IDD_STATICLIST, dlg->m_prompt1.c_str());
		if (! dlg->m_prompt2.empty())
			SetDlgItemText(hwnd, IDD_STATICTEXT, dlg->m_prompt2.c_str());
		SetDlgItemText(hwnd, IDD_EDITTEXT, dlg->m_name.c_str());
		dlg->InitRelations(GetDlgItem(hwnd, IDD_EDITLIST));
		return TRUE;
	}
	dlg = reinterpret_cast<LinkInputDialog*>(GetWindowLong(hwnd, DWL_USER));
	if (msg == WM_COMMAND)
	{
		switch (LOWORD(wparam))
		{
		case IDOK:
			if (dlg)
			{
				int len = SendDlgItemMessage(hwnd, IDD_EDITTEXT, WM_GETTEXTLENGTH, 0, 0);
				if (len == 0)
				{
					dlg->m_name.clear();
				}
				else
				{
					TCHAR* buf = new TCHAR[len+1];
					len = SendDlgItemMessage(hwnd, IDD_EDITTEXT, WM_GETTEXT, len+1, reinterpret_cast<LPARAM>(buf));
#ifdef UNICODE
					int wlen = WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK | WC_DISCARDNS | WC_DEFAULTCHAR,
							buf, len, NULL, 0, NULL, NULL);
					char wbuf[wlen+1];
					wlen = WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK | WC_DISCARDNS | WC_DEFAULTCHAR,
							buf, len, wbuf, wlen, NULL, NULL);
					dlg->m_name.assign(wbuf, wlen);
					delete[] wbuf;
#else
					dlg->m_name.assign(buf, len);
#endif
					delete[] buf;
				}
				int id = SendDlgItemMessage(hwnd, IDD_EDITLIST, CB_GETCURSEL, 0, 0);
				if (id == CB_ERR)
					dlg->m_flavor = 0;
				else
					dlg->m_flavor = 
							SendDlgItemMessage(hwnd, IDD_EDITLIST, CB_GETITEMDATA, id, 0);
			}
		case IDCANCEL:
			EndDialog(hwnd, LOWORD(wparam));
			return TRUE;
		}
	}
	return BaseDialog::DlgProc(hwnd, msg, wparam, lparam);
}

LinkInputDialog::~LinkInputDialog()
{
	m_relations->dec_ref();
}

LinkInputDialog::LinkInputDialog(const DarkDB* db)
	: BaseDialog(MAKEINTRESOURCE(ID_LINKINPUT))
{
	TCHAR strbuf[1024];
	int strlen = LoadString(NULL, IDS_ADDLINKTITLE, strbuf, 1024);
	if (! strlen)
		throw dialog_error(GetLastError());
	m_caption.assign(strbuf, strlen);
	strlen = LoadString(NULL, IDS_ADDLINKPROMPT, strbuf, 1024);
	if (! strlen)
		throw dialog_error(GetLastError());
	m_prompt1.assign(strbuf, strlen);
	strlen = LoadString(NULL, IDS_ADDLINKDESTPROMPT, strbuf, 1024);
	if (! strlen)
		throw dialog_error(GetLastError());
	m_prompt2.assign(strbuf, strlen);

	m_relations = dynamic_cast<DarkChunkRelations*>(db->GetChunk("Relations"));
	if (! m_relations)
		throw runtime_error("LinkInputDialog::LinkInputDialog");
	m_relations->inc_ref();
}

void LinkInputDialog::InitRelations(HWND listctrl)
{
	try
	{
		SetCursor(LoadCursor(NULL, IDC_WAIT));
		string_iterator rels = m_relations->GetRelations();
		unsigned int f = 1;
		while (! rels.empty())
		{
			const string& relname = *rels;
			rels++;
			if (! stricmp(relname.c_str(), "MetaProp")
			 || ! stricmp(relname.c_str(), "arSrcDesc")
			 || ! stricmp(relname.c_str(), "Receptron"))
			{
				++f;
				continue;
			}
			int id;
#ifdef UNICODE
			int wlen = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
					relname.data(), relname.size(), NULL, 0);
			WCHAR* wbuf = new WCHAR[wlen+1];
			wlen = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, 
					relname.data(), relname.size(), wbuf, wlen);
			wbuf[wlen] = TEXT('\0');
			id = SendMessage(listctrl, CB_ADDSTRING, 0, reinterpret_cast<LPARAM>(wbuf));
			delete[] wbuf;
#else
			id = SendMessage(listctrl, CB_ADDSTRING, 0, reinterpret_cast<LPARAM>(relname.c_str()));
#endif
			SendMessage(listctrl, CB_SETITEMDATA, id, f++);
		}
		SendMessage(listctrl, CB_SETCURSEL, 0, 0);
		SetCursor(LoadCursor(NULL, IDC_ARROW));
	}
	catch (...)
	{
		SetCursor(LoadCursor(NULL, IDC_ARROW));
	}
}

bool LinkInputDialog::operator()(HWND parent)
{
	LPCDLGTEMPLATE dlg = reinterpret_cast<LPCDLGTEMPLATE>(LockResource(m_dlghandle));
	if (!dlg)
		throw dialog_error(GetLastError());
	int ret = DialogBoxIndirectParam(NULL, dlg, parent, DlgProc, reinterpret_cast<LPARAM>(this));
	switch (ret)
	{
	case 0:
	case IDOK:
		return true;
	case IDCANCEL:
		return false;
	case -1:
		throw dialog_error(GetLastError());
	default:
		throw dialog_error(ret);
	}
	return false;
}

