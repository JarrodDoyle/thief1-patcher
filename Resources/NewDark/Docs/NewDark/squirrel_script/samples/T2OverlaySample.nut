// A squirrel.osm port of the C++ T2 overlay sample ("t2_overlay_sample.cpp").
// This can be used in place of "t2sample.osm" with the "Demo_OverlaySampleOsm.mis" mission.

//
// Local helper classes for individual HUD elements etc.
//
//

class sRect
{
	left = 0;
	top = 0;
	right = 0;
	bottom = 0;

	function IsPtInside(x, y) { return x >= left && y >= top && x < right && y < bottom; }
}

// ---------------------------------------------------------------

// base class for our HUD elements
class cHudElement
{
	m_bActive = false;
	m_rect = null;

	constructor()
	{
		m_rect = sRect();
	}

	function Toggle() { m_bActive = !m_bActive; }
	function Show() { m_bActive = true; }
	function Hide() { m_bActive = false; }

	// required functions in derived classes
	//function CalcPlacement()
	//function Draw()
}


// a custom HUD element
class cHudElement_Something extends cHudElement
{
	m_bgImage = 0;

	// keep two temp int_ref objects around which are useful when calling service functions that have integer reference parameters
	// (avoids constant object creation and deletion if these were created as temp local vars)
	iref1 = int_ref();
	iref2 = int_ref();

	constructor()
	{
		base.constructor();

		m_bgImage = DarkOverlay.GetBitmap("sima_1");

		CalcPlacement();
	}

	function CalcPlacement()
	{
		m_rect.left = 0;
		m_rect.top = 0;

		DarkOverlay.GetBitmapSize(m_bgImage, iref1, iref2);
		m_rect.right = iref1.tointeger();
		m_rect.bottom = iref2.tointeger();

		m_rect.right += m_rect.left;
		m_rect.bottom += m_rect.top;
	}

	function Draw()
	{
		DarkOverlay.DrawBitmap(m_bgImage, m_rect.left, m_rect.top);
	}
}

// another custom HUD element
class cHudElement_SomethingElse extends cHudElement
{
	m_bgImage = 0;

	// keep two temp int_ref objects around which are useful when calling service functions that have integer reference parameters
	// (avoids constant object creation and deletion if these were created as temp local vars)
	iref1 = int_ref();
	iref2 = int_ref();

	constructor()
	{
		base.constructor();

		m_bgImage = DarkOverlay.GetBitmap("demof009");

		CalcPlacement();
	}

	function CalcPlacement()
	{
		Engine.GetCanvasSize(iref1, iref2);
		local w = iref1.tointeger();
		local h = iref2.tointeger();

		DarkOverlay.GetBitmapSize(m_bgImage, iref1, iref2);
		local bm_w = iref1.tointeger();
		local bm_h = iref2.tointeger();

		m_rect.left = w-bm_w;
		m_rect.top =  0;
		m_rect.right = m_rect.left + bm_w;
		m_rect.bottom = m_rect.top + bm_h;
	}

	function Draw()
	{
		DarkOverlay.DrawBitmap(m_bgImage, m_rect.left, m_rect.top);

		DarkOverlay.GetStringSize("H", iref1, iref2);
		local w = iref1.tointeger();
		local h = iref2.tointeger();

		DarkOverlay.DrawString("Hello", m_rect.left+2, m_rect.top+4);
		DarkOverlay.DrawString("World", m_rect.left+2, m_rect.top+4+h+2);
	}
}

// ---------------------------------------------------------------

// base class for our transparent (non-interactive) overlay elements
class cOverlayElement
{
	m_bActive = false;
	m_handle = -1;

	constructor()
	{
	}

	function Toggle() { m_bActive = !m_bActive; }
	function Show() { m_bActive = true; }
	function Hide() { m_bActive = false; }

	// required functions in derived classes
	//function CalcPlacement()
	//function Draw()
}


// a custom overlay element
class cOverlayElement_Something extends cOverlayElement
{
	x = 0;
	y = 0;

	constructor()
	{
		base.constructor();

		// create a simple static overlay of a bitmap

		CalcPos();

		// you cannot use images that are potentially also used as textures on 3D objects/terrain
		// this is only used here for demo purposes
		local bm = DarkOverlay.GetBitmap("clocger3", "obj\\txt16\\");

		m_handle = DarkOverlay.CreateTOverlayItemFromBitmap(x, y, 127, bm, TRUE);
	}

	function CalcPos()
	{
		// if desired do some fancy position calcs based on canvas size for different alignments
		x = 10;
		y = 10;
	}

	function CalcPlacement()
	{
		CalcPos();

		DarkOverlay.UpdateTOverlayPosition(m_handle, x, y);
	}

	function Draw()
	{
		DarkOverlay.DrawTOverlayItem(m_handle);
	}
}

// another custom overlay element
class cOverlayElement_SomethingElse extends cOverlayElement
{
	m_bUpdateContents = false;
	m_bgImage = 0;
	x = 0;
	y = 0;

	// keep two temp int_ref objects around which are useful when calling service functions that have integer reference parameters
	// (avoids constant object creation and deletion if these were created as temp local vars)
	iref1 = int_ref();
	iref2 = int_ref();

	constructor()
	{
		base.constructor();

		// create a dynamic/comlpex overlay with 64x64 size

		CalcPos();

		m_handle = DarkOverlay.CreateTOverlayItem(x, y, 128, 128, 127, TRUE);
		m_bUpdateContents = true;

		// get our bg bitmap
		m_bgImage = DarkOverlay.GetBitmap("p003r001", "intrface\\miss1\\english\\");
	}

	function CalcPos()
	{
		// if desired do some fancy position calcs based on canvas size for different alignments
		x = 10;
		y = 300;
	}

	function CalcPlacement()
	{
		CalcPos();

		DarkOverlay.UpdateTOverlayPosition(m_handle, x, y);
	}

	function Draw()
	{
		// draw overlay contents to update it if something changed
		if (m_bUpdateContents)
		{
			m_bUpdateContents = false;

			if ( DarkOverlay.BeginTOverlayUpdate(m_handle) )
			{
				local s = "miss" + DarkGame.GetCurrentMission();

				DarkOverlay.GetStringSize(s, iref1, iref2);
				local w = iref1.tointeger();
				local h = iref2.tointeger();

				DarkOverlay.DrawBitmap(m_bgImage, 0, 0);
				DarkOverlay.DrawString(s, 128-w-4, 4);

				DarkOverlay.EndTOverlayUpdate();
			}
		}

		DarkOverlay.DrawTOverlayItem(m_handle);
	}
}


/****************************************************************************/


//
// The overlay handler interface
// Receives calls from the engine. Only one handler (per OSM) can be active at a time.
//

class cMyThiefOverlay extends IDarkOverlayHandler
{
	m_elems = null;
	m_overlays = null;

	/*constructor()
	{
		base.constructor();
	}*/

	function Init()
	{
		m_elems = [];
		m_elems.append( cHudElement_Something() );
		m_elems.append( cHudElement_SomethingElse() );

		m_overlays = [];
		m_overlays.append( cOverlayElement_Something() );
		m_overlays.append( cOverlayElement_SomethingElse() );

		// show em all

		foreach (o in m_elems)
			o.Show();

		foreach (o in m_overlays)
			o.Show();
	}

	function Term()
	{
		foreach (i, o in m_elems)
			m_elems[i] = null;

		foreach (i, o in m_overlays)
			m_overlays[i] = null;
	}

	//
	// IDarkOverlayHandler interface
	//

	function DrawHUD()
	{
		foreach (o in m_elems)
			if (o.m_bActive)
				o.Draw();
	}

	function DrawTOverlay()
	{
		foreach (o in m_overlays)
			if (o.m_bActive)
				o.Draw();
	}

	function OnUIEnterMode()
	{
		foreach (o in m_elems)
			o.CalcPlacement();

		foreach (o in m_overlays)
			o.CalcPlacement();
	}
}


myOverlay <- cMyThiefOverlay();


//
// Script that installs and uninstalls the overlay handler
// Add this script to one (dummy) object in the mission
//

class MyHudScript extends SqRootScript
{
	function destructor()
	{
		// to be on the safe side make really sure the handler is removed when this script is destroyed
		// (calling RemoveHandler if it's already been removed is no problem)
		DarkOverlay.RemoveHandler(myOverlay);
	}

	function OnBeginScript()
	{
		DarkOverlay.AddHandler(myOverlay);
		myOverlay.Init();
	}

	function OnEndScript()
	{
		DarkOverlay.RemoveHandler(myOverlay);
		myOverlay.Term();
	}
}
