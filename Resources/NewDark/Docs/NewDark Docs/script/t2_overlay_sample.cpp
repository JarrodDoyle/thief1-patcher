struct sRect
{
	int left, top, right, bottom;

	BOOL IsPtInside(int x, int y) { return x >= left && y >= top && x < right && y < bottom; }
};


///////////////////////////////////////////////////////////////////////////////

// base class for our HUD elements
class cHudElement
{
public:
	BOOL m_bActive;
	sRect m_rect;

public:
	cHudElement() { m_bActive=FALSE; m_rect.left=m_rect.top=m_rect.right=m_rect.bottom=0; }
	virtual ~cHudElement() {}

	void Toggle() { m_bActive = !m_bActive; }
	void Show() { m_bActive = TRUE; }
	void Hide() { m_bActive = FALSE; }

	virtual void CalcPlacement() {}

	virtual void Draw() = 0;
};

// a custom HUD element
class cHudElement_Something : public cHudElement
{
	int m_bgImage;

public:
	cHudElement_Something()
	{
		m_bgImage = DarkOverlay.GetBitmap("sima_1", "intrface\\");

		CalcPlacement();
	}

	virtual ~cHudElement_Something() {}

	virtual void CalcPlacement()
	{
		m_rect.left = 0;
		m_rect.top =  0;
		DarkOverlay.GetBitmapSize(m_bgImage, m_rect.right, m_rect.bottom);
		m_rect.right += m_rect.left;
		m_rect.bottom += m_rect.top;
	}

	virtual void Draw()
	{
		DarkOverlay.DrawBitmap(m_bgImage, m_rect.left, m_rect.top);
	}
};

// another custom HUD element
class cHudElement_SomethingElse : public cHudElement
{
	int m_bgImage;

public:
	cHudElement_SomethingElse()
	{
		m_bgImage = DarkOverlay.GetBitmap("demof009", "intrface\\");

		CalcPlacement();
	}

	virtual ~cHudElement_SomethingElse() {}

	virtual void CalcPlacement()
	{
		int w, h, bm_w, bm_h;
		Engine.GetCanvasSize(w, h);
		DarkOverlay.GetBitmapSize(m_bgImage, bm_w, bm_h);
		m_rect.left = w-bm_w;
		m_rect.top =  0;
		m_rect.right = m_rect.left + bm_w;
		m_rect.bottom = m_rect.top + bm_h;
	}

	virtual void Draw()
	{
		DarkOverlay.DrawBitmap(m_bgImage, m_rect.left, m_rect.top);
		int w, h;
		DarkOverlay.GetStringSize("H", w, h);
		DarkOverlay.DrawString("Hello", m_rect.left+2, m_rect.top+4);
		DarkOverlay.DrawString("World", m_rect.left+2, m_rect.top+4+h+2);
	}
};


///////////////////////////////////////////////////////////////////////////////

// base class for our transparent (non-interactive) overlay elements
class cOverlayElement
{
public:
	BOOL m_bActive;
	int m_handle;

public:
	cOverlayElement() { m_bActive=FALSE; m_handle=-1; }
	virtual ~cOverlayElement() {}

	void Toggle() { m_bActive = !m_bActive; }
	void Show() { m_bActive = TRUE; }
	void Hide() { m_bActive = FALSE; }

	virtual void CalcPlacement() {}

	virtual void Draw() = 0;
};

// a custom overlay element
class cOverlayElement_Something : public cOverlayElement
{
protected:
	void CalcPos(int &x, int &y)
	{
		x = 10;
		y = 10;
	}

public:
	cOverlayElement_Something()
	{
		// create a simple static overlay of a bitmap

		int x, y;
		CalcPos(x, y);

		// you cannot use images that are potentially also used as textures on 3D objects/terrain
		// this is only used here for demo purposes
		int bm = DarkOverlay.GetBitmap("clocger3", "obj\\txt16\\");

		m_handle = DarkOverlay.CreateTOverlayItemFromBitmap(x, y, 127, bm, TRUE);
	}

	virtual ~cOverlayElement_Something() {}

	virtual void CalcPlacement()
	{
		int x, y;
		CalcPos(x, y);

		DarkOverlay.UpdateTOverlayPosition(m_handle, x, y);
	}

	virtual void Draw()
	{
		DarkOverlay.DrawTOverlayItem(m_handle);
	}
};

// another custom overlay element
class cOverlayElement_SomethingElse : public cOverlayElement
{
	BOOL m_bUpdateContents;

	int m_bgImage;

protected:
	void CalcPos(int &x, int &y)
	{
		x = 10;
		y = 300;
	}

public:
	cOverlayElement_SomethingElse()
	{
		// create a dynamic/comlpex overlay with 64x64 size

		int x, y;
		CalcPos(x, y);

		m_handle = DarkOverlay.CreateTOverlayItem(x, y, 128, 128, 127, TRUE);
		m_bUpdateContents = TRUE;

		// get our bg bitmap
		m_bgImage = DarkOverlay.GetBitmap("p003r001", "intrface\\miss1\\english\\");
	}

	virtual ~cOverlayElement_SomethingElse() {}

	virtual void CalcPlacement()
	{
		int x, y;
		CalcPos(x, y);

		DarkOverlay.UpdateTOverlayPosition(m_handle, x, y);
	}

	virtual void Draw()
	{
		// draw overlay contents if something changed
		if (m_bUpdateContents)
		{
			m_bUpdateContents = FALSE;

			if ( DarkOverlay.BeginTOverlayUpdate(m_handle) )
			{
				char s[16];
				sprintf(s, "miss%d", DarkGame.GetCurrentMission());

				int w, h;
				DarkOverlay.GetStringSize(s, w, h);

				DarkOverlay.DrawBitmap(m_bgImage, 0, 0);
				DarkOverlay.DrawString(s, 128-w-4, 4);

				DarkOverlay.EndTOverlayUpdate();
			}
		}

		DarkOverlay.DrawTOverlayItem(m_handle);
	}
};


///////////////////////////////////////////////////////////////////////////////
// custom overlay handler

class cMyThiefOverlay : public IDarkOverlayHandler
{
	enum
	{
		NUM_ELEMS = 2,
		NUM_OVERLAYS = 2
	};

	cHudElement *m_elems[NUM_ELEMS];
	cOverlayElement *m_overlays[NUM_OVERLAYS];

public:
	void Init()
	{
		m_elems[0] = new cHudElement_Something;
		m_elems[1] = new cHudElement_SomethingElse;

		m_overlays[0] = new cOverlayElement_Something;
		m_overlays[1] = new cOverlayElement_SomethingElse;

		// show em all
		m_elems[0]->Show();
		m_elems[1]->Show();
		m_overlays[0]->Show();
		m_overlays[1]->Show();
	}

	void Term()
	{
		for (int i=0; i<NUM_ELEMS; i++)
		{
			if (m_elems[i])
			{
				delete m_elems[i];
				m_elems[i] = NULL;
			}
		}
	}

public:
	//
	// IDarkOverlayHandler interface
	//

	STDMETHOD_(void,DrawHUD)()
	{
		for (int i=0; i<NUM_ELEMS; i++)
			if (m_elems[i]->m_bActive)
				m_elems[i]->Draw();
	}

	STDMETHOD_(void,DrawTOverlay)()
	{
		for (int i=0; i<NUM_OVERLAYS; i++)
			if (m_overlays[i]->m_bActive)
				m_overlays[i]->Draw();
	}

	STDMETHOD_(void,OnUIEnterMode)()
	{
		int i;

		for (i=0; i<NUM_ELEMS; i++)
			m_elems[i]->CalcPlacement();

		for (i=0; i<NUM_OVERLAYS; i++)
			m_overlays[i]->CalcPlacement();
	}
};


cMyThiefOverlay myOverlay;


///////////////////////////////////////////////////////////////////////////////
// base script that installs the custom overlay/HUD handler

BEGIN_SCRIPT(MyHudScript, RootScript)
METHODS:
MESSAGES:
	OnBeginScript()
	{
		DarkOverlay.SetHandler(&myOverlay);
		myOverlay.Init();

		DefaultOnBeginScript();
	}

	OnEndScript()
	{
		DarkOverlay.SetHandler(NULL);
		myOverlay.Term();

		DefaultOnEndScript();
	}
END_SCRIPT(MyHudScript)
