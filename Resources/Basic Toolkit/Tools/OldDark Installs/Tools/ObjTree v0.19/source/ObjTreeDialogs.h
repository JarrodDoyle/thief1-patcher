#ifndef OBJTREEDIALOGS_H
#define OBJTREEDIALOGS_H

#include <windows.h>
#undef CreateDialog

#include <stdexcept>
#include <string>
#include <vector>
#include <utility>

#include "DarkLib/DarkDB.h"
#include "DarkLib/DarkChunk.h"

#ifndef _tstring
# ifdef _UNICODE
#  define _tstring	wstring
# else
#  define _tstring	string
# endif
#endif

class dialog_error : public std::runtime_error
{
	std::string m_msg;
	DWORD m_err;
public:
	virtual ~dialog_error() throw() { }
	dialog_error(DWORD err);
	virtual const char* what() const throw();
	virtual DWORD err() const throw() { return m_err; }
};

class BaseDialog
{
protected:
	HGLOBAL m_dlghandle;

	void CreateDialog(LPCTSTR dlg);

	static BOOL CALLBACK DlgProc(HWND,UINT,WPARAM,LPARAM);

public:
	~BaseDialog();
	BaseDialog();
	BaseDialog(LPCTSTR dlg);

	bool operator()(HWND parent);
};

class StringInputDialog : public BaseDialog
{
protected:
	std::_tstring m_caption;
	std::_tstring m_prompt;
	std::_tstring m_text;

	static BOOL CALLBACK DlgProc(HWND,UINT,WPARAM,LPARAM);

public:
	~StringInputDialog();
	StringInputDialog(LPCTSTR dlg, const std::_tstring& prompt, const std::_tstring& title);
	StringInputDialog(const std::_tstring& prompt, const std::_tstring& title);
	StringInputDialog(LPCTSTR dlg, UINT prompt, UINT title);
	StringInputDialog(UINT prompt, UINT title);
	StringInputDialog(LPCTSTR dlg);
	StringInputDialog();

	bool operator()(HWND parent);
	bool operator()(HWND parent, const std::_tstring& inittext);

	const std::_tstring& Text() const
		{ return m_text; }
};

class StringListDialog : public StringInputDialog
{
protected:
	typedef std::vector<std::pair<std::_tstring,std::_tstring> > _listtype;
	_listtype m_list;
	size_t m_selection;

	static BOOL CALLBACK DlgProc(HWND,UINT,WPARAM,LPARAM);

public:
	~StringListDialog();
	StringListDialog(const std::_tstring& prompt, const std::_tstring& title);
	StringListDialog(UINT prompt, UINT title);
	StringListDialog();

	bool operator()(HWND parent);
	bool operator()(HWND parent, const std::_tstring& inittext);
	bool operator()(HWND parent, size_t initsel);

	void Add(const std::_tstring& str1, const std::_tstring& str2);
	const std::_tstring& ListText() const;
};

class IntegerListDialog : public StringInputDialog
{
protected:
	typedef std::vector<std::pair<std::_tstring,long> > _listtype;
	_listtype m_list;
	long m_listnum;

	static BOOL CALLBACK DlgProc(HWND,UINT,WPARAM,LPARAM);

public:
	~IntegerListDialog();
	IntegerListDialog(const std::_tstring& prompt, const std::_tstring& title);
	IntegerListDialog(UINT prompt, UINT title);
	IntegerListDialog();

	bool operator()(HWND parent);
	bool operator()(HWND parent, const std::_tstring& inittext);

	void Add(const std::_tstring& str, long num);
	long ListInt() const
		{ return m_listnum; }
};

class LinkInputDialog : public BaseDialog
{
	std::_tstring m_caption;
	std::_tstring m_prompt1, m_prompt2;

	uint32 m_flavor;
	std::string m_name;

	Dark::DarkChunkRelations* m_relations;

	static BOOL CALLBACK DlgProc(HWND,UINT,WPARAM,LPARAM);
	void InitRelations(HWND listctrl);

public:
	~LinkInputDialog();
	LinkInputDialog(const Dark::DarkDB* db);

	bool operator()(HWND parent);

	uint32 Flavor() const
		{ return m_flavor; }
	const std::string& Name() const
		{ return m_name; }
};

#endif
