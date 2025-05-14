#ifndef OBJTREEWINDOW_H
#define OBJTREEWINDOW_H

#include <windows.h>
#include <commctrl.h>
#undef GetObject

#include <map>
#include <string>

#ifndef _tstring
# ifdef UNICODE
#  define _tstring	wstring
# else
#  define _tstring	string
# endif
#endif

#include "Dark/utils.h"
#include "DarkLib/DarkDB.h"

#include "WindowBase.h"
#include "PropertyTree.h"
#include "UndoHistory.h"
#include "GmvlImport.h"

class ObjTreeList : public Window
{
public:
	~ObjTreeList() { }
	ObjTreeList() : Window() { }
	ObjTreeList(HWND parent, HINSTANCE inst);

	BOOL Create(HWND parent, HINSTANCE inst);

	void Clear();
	void LoadHierarchy(Dark::DarkDB* db, const std::string& root);
	void LoadHierarchy(Dark::DarkDB* db, HTREEITEM root, Dark::DarkObject* obj);

	HTREEITEM ReParent(Dark::DarkDB* db, HTREEITEM item, HTREEITEM parent);
	bool ReParent(Dark::DarkDB* db, sint32 item, sint32 parent);

	bool MakeVisible(sint32 oid, bool expand = false);
	void UpdateObject(sint32 oid);
	void AddObject(sint32 oid, sint32 parent);
	void RemoveObject(sint32 oid);

private:
	std::map<sint32,HTREEITEM> m_objlist;
};

class ObjWindow;

class ObjTreeMain : public Window
{
public:
	enum EditContext
	{
		editNone = 0,
		editHierarchy,
		editObjectProperty,
		editObjectMetaproperty,
		editObjectLink,
		editObjectStimulus,
		editObjectReceptron
	};

private:
	Window m_clientwin;
	ObjTreeList m_listwin;

	Menu m_menubar;

	std::map<sint32,ObjWindow*> m_windowlist;

	PropertyTree* m_chunkeditor;

	Dark::DarkDB* m_database;
	//std::_tstring m_dbname;

	std::_tstring* m_recentfiles[11];

	int m_splitpos, m_dragpos, m_oldpos;
	bool m_mdimaximize;

	HTREEITEM m_currentdragobject;

	sint32 m_currenteditobject;
	EditContext m_currenteditcontext;

	UndoRecord const * m_undoaction;

	struct ImportNotify : public GmvlImportNotifier
	{
		virtual GmvlImportResult ObjectNameConflict(const char* name, int line, int col);
		virtual GmvlImportResult ObjectNameUnknown(const char* name, int line, int col);
		virtual GmvlImportResult MetapropertyNameUnknown(const char* name, int line, int col);
		virtual GmvlImportResult LinkFlavorUnknown(const char* flavor, int line, int col);
		virtual GmvlImportResult PropertyNameUnknown(const char* name, int line, int col);
		virtual GmvlImportResult ParamNameUnknown(const char* name, int line, int col);
		virtual GmvlImportResult ParamValueError(const char* name, const char* value, int line, int col);

		ImportNotify(ObjTreeMain& w) : window(w) { }
		ObjTreeMain& window;
	};

public:
	~ObjTreeMain();
	ObjTreeMain();
	ObjTreeMain(HINSTANCE inst);

	static BOOL RegisterClass(HINSTANCE inst);
	BOOL Create(HINSTANCE inst);

	Window& Client()
		{ return m_clientwin; }

	bool IsMDIMaximized() const
		{ return m_mdimaximize; }
	void SetMDIMaximized(bool _m)
		{ m_mdimaximize = _m; }

	int RetrievePersistence();
	void StowPersistence();

	void UpdateRecentFiles(const std::_tstring& fname);

	void AdjustLayout(bool dragging = false);
	void DrawSplitter(HDC dc, int height, bool dragging = false, bool track = false);

	void ErrorMessage(const std::_tstring& msg);
	bool PromptMessage(const std::_tstring& msg);
	int PromptMessage2(const std::_tstring& msg);
#ifdef UNICODE
	void ErrorMessage(const std::string& msg);
	bool PromptMessage(const std::string& msg);
	int PromptMessage2(const std::string& msg);
#endif

	void OpenDatabase();
	void OpenDatabase(const std::_tstring& fname);
	void SaveDatabase();

	Dark::DarkDB* Database()
		{ return m_database; }

	void SearchForObject();

	ObjWindow* FindObjectWindow(sint32 oid);
	ObjWindow* OpenObjectWindow(sint32 oid);
	void CloseObjectWindow(sint32 oid);
	void CloseAllObjectWindows();

	void UpdateObject(Dark::DarkObject* obj);

	bool MoveObject(sint32 oid, sint32 parent);
	void CreateObject(sint32 parent);
	Dark::DarkObject* CreateObject(sint32 parent, const std::_tstring& name);
	void DeleteObject(sint32 oid);
	void AddObject(Dark::DarkObject* obj, sint32 parent);
	void RemoveObject(Dark::DarkObject* obj);

	void DoObjectAdd();
	void DoObjectRemove();

	PropertyTree* OpenChunkEditor();

	void GmvlImport();
	void GmvlImport(const std::_tstring& fname);
	void GmvlImport(LPCTSTR fname)
		{ GmvlImport(std::_tstring(fname)); }

	void LoadStructInfo(bool shift=false);
	void LoadStructInfo(const std::_tstring& fname, bool shift=false);
	void LoadStructInfo(LPCTSTR fname, bool shift=false)
		{ LoadStructInfo(std::_tstring(fname), shift); }

	void SetUndoAction(const UndoRecord* action);

	void SetEditContext(EditContext ctx = editNone, sint32 oid = 0);

private:
	static LRESULT CALLBACK WindowProc(HWND, UINT, WPARAM, LPARAM);

	static const LPCTSTR szClassName;
	static std::_tstring strWindowName;

	void BeginDragTreeObject(HTREEITEM item, int x, int y);
	void DragTreeObject(int x, int y);
	void EndDragTreeObject(int x, int y);

	void DisplayTreeObject(TVITEM& item);

	void DoUndoRedo();
};

#endif // OBJTREEWINDOW_H
