#ifndef WINDOWBASE_H
#define WINDOWBASE_H

class Menu
{
protected:
	HMENU m_menu;

public:
	~Menu()
		{ }
	Menu() : m_menu(NULL)
		{ }
	Menu(const Menu& _m) : m_menu(_m.m_menu)
		{ }
	Menu(const HMENU _h) : m_menu(_h)
		{ }
	Menu(LPCTSTR _id, HINSTANCE _inst)
		{ Create(_id, _inst); }
	Menu& operator=(const Menu& _m)
		{ m_menu = _m.m_menu; return *this; }
	Menu& operator=(const HMENU _h)
		{ m_menu = _h; return *this; }
	operator HMENU() const
		{ return m_menu; }
	operator bool() const
		{ return m_menu != NULL; }
	bool operator==(const Menu& _m)
		{ return m_menu == _m.m_menu; }

	BOOL Create(LPCTSTR _id, HINSTANCE _inst)
		{ m_menu = ::LoadMenu(_inst, _id); return (m_menu != NULL); }

	BOOL EnableId(int _id) const
		{ return ::EnableMenuItem(m_menu, _id, MF_BYCOMMAND | MF_ENABLED); }
	BOOL EnablePos(int _pos) const
		{ return ::EnableMenuItem(m_menu, _pos, MF_BYPOSITION | MF_ENABLED); }
	BOOL DisableId(int _id) const
		{ return ::EnableMenuItem(m_menu, _id, MF_BYCOMMAND | MF_GRAYED); }
	BOOL DisablePos(int _pos) const
		{ return ::EnableMenuItem(m_menu, _pos, MF_BYPOSITION | MF_GRAYED); }
};

class Window
{
protected:
	HWND m_window;

public:
	~Window()
		{ }
	Window() : m_window(NULL)
		{ }
	Window(const Window& _w) : m_window(_w.m_window)
		{ }
	Window(const HWND _h) : m_window(_h)
		{ }
	
	Window& operator=(const Window& _w) 
		{ m_window = _w.m_window; return *this; }
	Window& operator=(const HWND _h) 
		{ m_window = _h; return *this; }
	operator HWND() const
		{ return m_window; }
	operator bool() const
		{ return m_window != NULL; }
	bool operator==(const Window& _w) const
		{ return m_window == _w.m_window; }

	static BOOL RegisterClass(HINSTANCE)
		{ return TRUE; }

	LRESULT SendMessage(UINT _m, WPARAM _w, LPARAM _l)
		{ return ::SendMessage(m_window, _m, _w, _l); }

	BOOL Show() const
		{ return ::ShowWindow(m_window, SW_SHOW); }
	BOOL Hide() const
		{ return ::ShowWindow(m_window, SW_HIDE); }
	HWND Focus() const
		{ return ::SetFocus(m_window); }

	BOOL Enable() const
		{ return ::EnableWindow(m_window, TRUE); }
	BOOL Disable() const
		{ return ::EnableWindow(m_window, FALSE); }

};

#endif
