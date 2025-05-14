#include <windows.h>
#include <commctrl.h>
#undef GetObject

#include <locale>
#include <string>

#undef _tstring
#ifdef _UNICODE
#define _tstring	wstring
#else
#define _tstring	string
#endif

BOOL PickInputFile(HWND parent, std::_tstring& name, int filter = 0);
BOOL PickOutputFile(HWND parent, std::_tstring& name, int filter = 0);

extern HINSTANCE gInstance;
extern std::locale gLocale;
extern LPCTSTR gszUndo;
extern LPCTSTR gszRedo;
