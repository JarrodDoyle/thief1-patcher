#ifndef PROPERTYTREE_H
#define PROPERTYTREE_H

#include <windows.h>
#include <commctrl.h>

#include <map>
#include <string>

#include "WindowBase.h"

class PropertySource;

class PropertyTree : public Window
{
public:
	enum PropertyState
	{
		stateNormal = 0,
		stateBoolean,
		stateBitfield,
		stateLocked,
		// only for edit state, not properties
		stateDropdown
	};

private:
	Window m_listwin;
	Window m_editwin;
	Window m_textwin;
	Window m_combowin;
	Window m_bitbutton;
	Menu m_bitmenu;
	Window m_buttons[2];

	PropertySource* m_source;

	std::map<std::string,HTREEITEM> m_properties;
	const std::string* m_currentedit;
	PropertyState m_editstate;

	HWND m_realparent;
	void* m_userdata;

public:
	~PropertyTree();
	PropertyTree(void* data = NULL);
	PropertyTree(HWND parent, HINSTANCE inst, void* data = NULL);
	PropertyTree(PropertySource* src, void* data = NULL);
	PropertyTree(PropertySource* src, HWND parent, HINSTANCE inst, void* data = NULL);

	static ATOM ClassID;

	static BOOL RegisterClass(HINSTANCE inst);
	BOOL Create(HWND parent, HINSTANCE inst);
	// Creates a popup (actually, overlapped) window
	BOOL Create(HWND parent, HINSTANCE inst, LPCTSTR name);
private:
	BOOL CreateChildren(HINSTANCE inst);

public:
	void AdjustLayout();

	bool HasSource() const
		{ return m_source != NULL; }
	PropertySource* GetSource()
		{ return m_source; }
	PropertySource* SetSource(PropertySource* src);

	std::string Display(const std::string& name);

	HWND SetRealParent(HWND);

	void* UserData() const
		{ return m_userdata; }

	void Clear();
	bool AddProperty(const std::string& name);
	bool AddProperty(const std::string& name, const std::string& parent);
	bool AddProperty(const std::string& name, const std::string& parent, const std::string& after);

	void RemoveProperty(const std::string& name);

	void SetState(const std::string& name, PropertyState state = stateNormal);

	bool SetPropertyData(const std::string& name, const std::string& data);

	void MakeVisible(const std::string& name, bool expand = false);
	void UpdateProperty(const std::string& name);

	bool BeginEditProperty(const std::string* name);
	bool EndEditProperty(bool abort = false);

	const std::string& GetSelection();

private:
	BOOL IsTreeItemLocked(HTREEITEM item);
	HTREEITEM GetNextUnlocked(HTREEITEM item, int direction);

	void DisableEdit();
	void EnableEdit(PropertyState state);

	void ToggleMenuBit(DWORD id);
	std::string GetEditText();
	void SetEditText(const std::string& _s);

	static LRESULT CALLBACK WindowProc(HWND, UINT, WPARAM, LPARAM);
	static LRESULT CALLBACK EditWinHook(HWND, UINT, WPARAM, LPARAM);

	static const TCHAR* szClassName;
};

#define PTN_PROPERTYCHANGED		(NM_LAST+1)
#define PTN_PROPERTYCHANGING		(NM_LAST+2)
#define PTN_PROPERTYCHANGECANCELED		(NM_LAST+3)

struct _PTNINFO
{
	NMHDR	hdr;
	const std::string* name;
	const std::string* olddata;
	const std::string* newdata;
	void*	userdata;
};
typedef struct _PTNINFO PTNINFO;

#endif
