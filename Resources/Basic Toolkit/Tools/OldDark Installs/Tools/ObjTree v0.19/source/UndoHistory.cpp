#include "UndoHistory.h"
#include "ObjTreeWindow.h"
#include "ObjWindow.h"
#include "PropertyTree.h"

using namespace std;
using namespace Dark;

UndoCreateObject::~UndoCreateObject()
{
	obj->dec_ref();
}

UndoCreateObject::UndoCreateObject(DarkObject* _o, sint32 _p)
	: obj(_o), parent(_p)
{
	obj->inc_ref();
}

bool UndoCreateObject::Undo(ObjTreeMain& win) const
{
	win.RemoveObject(obj);
	return true;
}

bool UndoCreateObject::Redo(ObjTreeMain& win) const
{
	win.AddObject(obj, parent);
	return true;
}

bool UndoMoveObject::Undo(ObjTreeMain& win) const
{
	return win.MoveObject(oid, oldparent);
}

bool UndoMoveObject::Redo(ObjTreeMain& win) const
{
	return win.MoveObject(oid, newparent);
}

bool UndoChangeProperty::Undo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	PropertyTree* editor = objwin->GetPropertyEditor();
	if (! editor)
		return false;
	return editor->SetPropertyData(name, olddata);
}

bool UndoChangeProperty::Redo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	PropertyTree* editor = objwin->GetPropertyEditor();
	if (! editor)
		return false;
	return editor->SetPropertyData(name, newdata);
}

bool UndoChangeMetaproperty::Undo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	PropertyTree* editor = objwin->GetMetapropertyEditor(linkid);
	if (! editor)
		return false;
	return editor->SetPropertyData(name, olddata);
}

bool UndoChangeMetaproperty::Redo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	PropertyTree* editor = objwin->GetMetapropertyEditor(linkid);
	if (! editor)
		return false;
	return editor->SetPropertyData(name, newdata);
}

bool UndoChangeLink::Undo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	PropertyTree* editor = objwin->GetLinkEditor(linkid);
	if (! editor)
		return false;
	return editor->SetPropertyData(name, olddata);
}

bool UndoChangeLink::Redo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	PropertyTree* editor = objwin->GetLinkEditor(linkid);
	if (! editor)
		return false;
	return editor->SetPropertyData(name, newdata);
}

bool UndoChangeStimulus::Undo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	PropertyTree* editor = objwin->GetStimulusEditor(linkid);
	if (! editor)
		return false;
	return editor->SetPropertyData(name, olddata);
}

bool UndoChangeStimulus::Redo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	PropertyTree* editor = objwin->GetStimulusEditor(linkid);
	if (! editor)
		return false;
	return editor->SetPropertyData(name, newdata);
}

bool UndoChangeReceptron::Undo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	PropertyTree* editor = objwin->GetReceptronEditor(linkid);
	if (! editor)
		return false;
	return editor->SetPropertyData(name, olddata);
}

bool UndoChangeReceptron::Redo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	PropertyTree* editor = objwin->GetReceptronEditor(linkid);
	if (! editor)
		return false;
	return editor->SetPropertyData(name, newdata);
}

UndoAddObjectProperty::~UndoAddObjectProperty()
{
	prop->dec_ref();
}

UndoAddObjectProperty::UndoAddObjectProperty(sint32 _o, DarkProp* _p)
	: oid(_o), prop(_p)
{
	prop->inc_ref();
}

bool UndoAddObjectProperty::Undo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	DarkProp* _p = objwin->RemoveProperty(prop->GetName());
	_p->dec_ref();
	return true;
}

bool UndoAddObjectProperty::Redo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	objwin->AddProperty(prop->GetName(), prop);
	return true;
}

UndoRemoveObjectProperty::~UndoRemoveObjectProperty()
{
	prop->dec_ref();
}

UndoRemoveObjectProperty::UndoRemoveObjectProperty(sint32 _o, DarkProp* _p)
	: oid(_o), prop(_p)
{
	prop->inc_ref();
}

bool UndoRemoveObjectProperty::Undo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	objwin->AddProperty(prop->GetName(), prop);
	return true;
}

bool UndoRemoveObjectProperty::Redo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	DarkProp* _p = objwin->RemoveProperty(prop->GetName());
	_p->dec_ref();
	return true;
}

UndoAddObjectLink::~UndoAddObjectLink()
{
	link->dec_ref();
}

UndoAddObjectLink::UndoAddObjectLink(sint32 _o, DarkLink* _l)
	: oid(_o), link(_l)
{
	link->inc_ref();
}

bool UndoAddObjectLink::Undo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	return objwin->RemoveLink(link);
}

bool UndoAddObjectLink::Redo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	return objwin->AddLink(link);
}

UndoRemoveObjectLink::~UndoRemoveObjectLink()
{
	link->dec_ref();
}

UndoRemoveObjectLink::UndoRemoveObjectLink(sint32 _o, DarkLink* _l)
	: oid(_o), link(_l)
{
	link->inc_ref();
}

bool UndoRemoveObjectLink::Undo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	return objwin->AddLink(link);
}

bool UndoRemoveObjectLink::Redo(ObjTreeMain& win) const
{
	ObjWindow* objwin = win.OpenObjectWindow(oid);
	if (! objwin)
		return false;
	return objwin->RemoveLink(link);
}

