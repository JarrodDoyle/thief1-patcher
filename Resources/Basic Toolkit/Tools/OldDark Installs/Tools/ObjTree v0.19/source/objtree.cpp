#include "objtree.h"
#include "ObjTreeWindow.h"
#include "ObjWindow.h"
#include "PropertyTree.h"

#include <commdlg.h>

#include <locale>
#include <algorithm>
//#include <cstring>

#include "resources.h"

using namespace Dark;
using namespace std;

HINSTANCE gInstance;
locale gLocale;

TCHAR gszFileFilters[2][260];
LPCTSTR gszUndo;
LPCTSTR gszRedo;

static TCHAR szFileTitle[260];
static TCHAR szFileName[520];

static TCHAR szUndoRedo[64];


BOOL PickInputFile(HWND parent, _tstring& name, int filter)
{
	OPENFILENAME ofn;

	memset(&ofn, 0, sizeof(OPENFILENAME));
	ofn.lStructSize = sizeof(OPENFILENAME);
	ofn.hwndOwner = parent;

	szFileTitle[0] = TEXT('\0');
	LoadString(gInstance, IDS_OPENFILECAPTION, szFileTitle, 260);
	ofn.lpstrTitle = szFileTitle;

	name.copy(szFileName, 520);
	szFileName[min(name.size(),size_t(520))] = TEXT('\0');
	ofn.lpstrFile = szFileName;
	ofn.nMaxFile = 520;

	ofn.Flags = OFN_EXPLORER | OFN_FILEMUSTEXIST | OFN_HIDEREADONLY;
	ofn.nFilterIndex = 1;
	ofn.lpstrFilter = gszFileFilters[filter];
	if (GetOpenFileName(&ofn))
	{
		name.assign(szFileName);
		return TRUE;
	}
	return FALSE;
}

BOOL PickOutputFile(HWND parent, _tstring& name, int filter)
{
	OPENFILENAME ofn;

	memset(&ofn, 0, sizeof(OPENFILENAME));
	ofn.lStructSize = sizeof(OPENFILENAME);
	ofn.hwndOwner = parent;
	
	szFileTitle[0] = TEXT('\0');
	LoadString(gInstance, IDS_SAVEFILECAPTION, szFileTitle, 260);
	ofn.lpstrTitle = szFileTitle;

	name.copy(szFileName, 520);
	szFileName[min(name.size(),size_t(520))] = TEXT('\0');
	ofn.lpstrFile = szFileName;
	ofn.nMaxFile = 520;

	ofn.Flags = OFN_EXPLORER | OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT;
	ofn.nFilterIndex = 1;
	ofn.lpstrFilter = gszFileFilters[filter];
	if (GetSaveFileName(&ofn))
	{
		name.assign(szFileName);
		return TRUE;
	}
	return FALSE;
}


int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd)
{
	ObjTreeMain mainwin;
	HACCEL hkeys;
	MSG msg;

	InitCommonControls();

	gInstance = hInstance;

	LoadString(hInstance, IDS_GAMSYSFILTER, gszFileFilters[0], sizeof(gszFileFilters[0]));
	for (TCHAR* p=gszFileFilters[0]; *p; ++p)
		if (*p == TEXT('\\')) *p = TEXT('\0');
	LoadString(hInstance, IDS_XMLFILTER, gszFileFilters[1], sizeof(gszFileFilters[1]));
	for (TCHAR* p=gszFileFilters[1]; *p; ++p)
		if (*p == TEXT('\\')) *p = TEXT('\0');
	LoadString(hInstance, IDS_UNDOREDO, szUndoRedo, sizeof(szUndoRedo));
	gszUndo = szUndoRedo;
	for (TCHAR* p=szUndoRedo; *p; ++p)
	{
		if (*p == TEXT('\\'))
		{
			*p = TEXT('\0');
			gszRedo = p + 1;
		}
	}

	if (!(ObjTreeMain::RegisterClass(hInstance) 
	   && ObjWindow::RegisterClass(hInstance) 
	   && PropertyTree::RegisterClass(hInstance) 
	   ))
		return GetLastError();

	hkeys = LoadAccelerators(hInstance, MAKEINTRESOURCE(ID_APPMAIN));

	if (!mainwin.Create(hInstance))
		return GetLastError();
	int viewstate = mainwin.RetrievePersistence();
	mainwin.AdjustLayout();
	ShowWindow(mainwin, (viewstate == SW_SHOWMAXIMIZED) ? SW_SHOWMAXIMIZED : SW_SHOWDEFAULT);
	UpdateWindow(mainwin);

	mainwin.LoadStructInfo(TEXT("structinfo.xml"));

	while (GetMessage(&msg, NULL, 0, 0))
	{
		if (!TranslateMDISysAccel(mainwin.Client(), &msg) 
		 && !TranslateAccelerator(mainwin, hkeys, &msg))
		{
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}
	}

	return msg.wParam;
}

