#ifndef UNDOHISTORY_H
#define UNDOHISTORY_H

#include "Dark/utils.h"
#include "DarkLib/DarkObject.h"
#include "DarkLib/DarkProp.h"
#include "DarkLib/DarkLink.h"

#include <string>


class ObjTreeMain;

class UndoRecord
{
public:
	virtual ~UndoRecord() { }
	UndoRecord() { }

	virtual const char* Name() const = 0;
	virtual bool Undo(ObjTreeMain& win) const = 0;
	virtual bool Redo(ObjTreeMain& win) const = 0;
};

class UndoCreateObject : public UndoRecord
{
	Dark::DarkObject* obj;
	sint32 parent;

public:
	virtual ~UndoCreateObject();
	UndoCreateObject(Dark::DarkObject* _o, sint32 _p);

	virtual const char* Name() const
		{ return "Add Object"; }
	virtual bool Undo(ObjTreeMain& win) const;
	virtual bool Redo(ObjTreeMain& win) const;
};

class UndoMoveObject : public UndoRecord
{
	sint32 oid;
	sint32 oldparent, newparent;

public:
	virtual ~UndoMoveObject() { }
	UndoMoveObject(sint32 _o, sint32 _p1, sint32 _p2)
		: oid(_o), oldparent(_p1), newparent(_p2)
	{ }

	virtual const char* Name() const
		{ return "Move Object"; }
	virtual bool Undo(ObjTreeMain& win) const;
	virtual bool Redo(ObjTreeMain& win) const;
};

class UndoChangeProperty : public UndoRecord
{
	sint32 oid;
	std::string name;
	std::string olddata, newdata;

public:
	virtual ~UndoChangeProperty() { }
	UndoChangeProperty(sint32 _o, std::string _n, std::string _d1, std::string _d2)
		: oid(_o), name(_n), olddata(_d1), newdata(_d2)
	{ }

	virtual const char* Name() const
		{ return "Change Property"; }
	virtual bool Undo(ObjTreeMain& win) const;
	virtual bool Redo(ObjTreeMain& win) const;
};

class UndoChangeMetaproperty : public UndoRecord
{
	sint32 oid;
	sint32 linkid;
	std::string name;
	std::string olddata, newdata;

public:
	virtual ~UndoChangeMetaproperty() { }
	UndoChangeMetaproperty(sint32 _o, sint32 _l, std::string _n, std::string _d1, std::string _d2)
		: oid(_o), linkid(_l), name(_n), olddata(_d1), newdata(_d2)
	{ }

	virtual const char* Name() const
		{ return "Change Metaproperty"; }
	virtual bool Undo(ObjTreeMain& win) const;
	virtual bool Redo(ObjTreeMain& win) const;
};

class UndoChangeLink : public UndoRecord
{
	sint32 oid;
	sint32 linkid;
	std::string name;
	std::string olddata, newdata;

public:
	virtual ~UndoChangeLink() { }
	UndoChangeLink(sint32 _o, sint32 _l, std::string _n, std::string _d1, std::string _d2)
		: oid(_o), linkid(_l), name(_n), olddata(_d1), newdata(_d2)
	{ }

	virtual const char* Name() const
		{ return "Change Link"; }
	virtual bool Undo(ObjTreeMain& win) const;
	virtual bool Redo(ObjTreeMain& win) const;
};

class UndoChangeStimulus : public UndoRecord
{
	sint32 oid;
	sint32 linkid;
	std::string name;
	std::string olddata, newdata;

public:
	virtual ~UndoChangeStimulus() { }
	UndoChangeStimulus(sint32 _o, sint32 _l, std::string _n, std::string _d1, std::string _d2)
		: oid(_o), linkid(_l), name(_n), olddata(_d1), newdata(_d2)
	{ }

	virtual const char* Name() const
		{ return "Change Stimulus"; }
	virtual bool Undo(ObjTreeMain& win) const;
	virtual bool Redo(ObjTreeMain& win) const;
};

class UndoChangeReceptron : public UndoRecord
{
	sint32 oid;
	sint32 linkid;
	std::string name;
	std::string olddata, newdata;

public:
	virtual ~UndoChangeReceptron() { }
	UndoChangeReceptron(sint32 _o, sint32 _l, std::string _n, std::string _d1, std::string _d2)
		: oid(_o), linkid(_l), name(_n), olddata(_d1), newdata(_d2)
	{ }

	virtual const char* Name() const
		{ return "Change Stimulus"; }
	virtual bool Undo(ObjTreeMain& win) const;
	virtual bool Redo(ObjTreeMain& win) const;
};

class UndoAddObjectProperty : public UndoRecord
{
	sint32 oid;
	Dark::DarkProp* prop;

public:
	virtual ~UndoAddObjectProperty();
	UndoAddObjectProperty(sint32 _o, Dark::DarkProp* _p);

	virtual const char* Name() const
		{ return "Add Property"; }
	virtual bool Undo(ObjTreeMain& win) const;
	virtual bool Redo(ObjTreeMain& win) const;
};

class UndoRemoveObjectProperty : public UndoRecord
{
	sint32 oid;
	Dark::DarkProp* prop;

public:
	virtual ~UndoRemoveObjectProperty();
	UndoRemoveObjectProperty(sint32 _o, Dark::DarkProp* _p);

	virtual const char* Name() const
		{ return "Remove Property"; }
	virtual bool Undo(ObjTreeMain& win) const;
	virtual bool Redo(ObjTreeMain& win) const;
};

class UndoAddObjectLink : public UndoRecord
{
	sint32 oid;
	Dark::DarkLink* link;

public:
	virtual ~UndoAddObjectLink();
	UndoAddObjectLink(sint32 _o, Dark::DarkLink* _l);

	virtual const char* Name() const
		{ return "Add Link"; }
	virtual bool Undo(ObjTreeMain& win) const;
	virtual bool Redo(ObjTreeMain& win) const;
};

class UndoRemoveObjectLink : public UndoRecord
{
	sint32 oid;
	Dark::DarkLink* link;

public:
	virtual ~UndoRemoveObjectLink();
	UndoRemoveObjectLink(sint32 _o, Dark::DarkLink* _l);

	virtual const char* Name() const
		{ return "Remove Link"; }
	virtual bool Undo(ObjTreeMain& win) const;
	virtual bool Redo(ObjTreeMain& win) const;
};

class UndoAddObjectMetaproperty : public UndoAddObjectLink
{
public:
	virtual ~UndoAddObjectMetaproperty() { }
	UndoAddObjectMetaproperty(sint32 _o, Dark::DarkLinkMetaProp* _mp)
		: UndoAddObjectLink(_o, _mp) { }

	virtual const char* Name() const
		{ return "Add Metaproperty"; }
};

class UndoRemoveObjectMetaproperty : public UndoRemoveObjectLink
{
public:
	virtual ~UndoRemoveObjectMetaproperty() { }
	UndoRemoveObjectMetaproperty(sint32 _o, Dark::DarkLinkMetaProp* _mp)
		: UndoRemoveObjectLink(_o, _mp) { }

	virtual const char* Name() const
		{ return "Remove Metaproperty"; }
};

class UndoAddObjectStimulus : public UndoAddObjectLink
{
public:
	virtual ~UndoAddObjectStimulus() { }
	UndoAddObjectStimulus(sint32 _o, Dark::DarkLinkStimulus* _stim)
		: UndoAddObjectLink(_o, _stim) { }

	virtual const char* Name() const
		{ return "Add Stimulus"; }
};

class UndoRemoveObjectStimulus : public UndoRemoveObjectLink
{
public:
	virtual ~UndoRemoveObjectStimulus() { }
	UndoRemoveObjectStimulus(sint32 _o, Dark::DarkLinkStimulus* _stim)
		: UndoRemoveObjectLink(_o, _stim) { }

	virtual const char* Name() const
		{ return "Remove Stimulus"; }
};

class UndoAddObjectReceptron : public UndoAddObjectLink
{
public:
	virtual ~UndoAddObjectReceptron() { }
	UndoAddObjectReceptron(sint32 _o, Dark::DarkLinkReceptron* _rcptn)
		: UndoAddObjectLink(_o, _rcptn) { }

	virtual const char* Name() const
		{ return "Add Receptron"; }
};

class UndoRemoveObjectReceptron : public UndoRemoveObjectLink
{
public:
	virtual ~UndoRemoveObjectReceptron() { }
	UndoRemoveObjectReceptron(sint32 _o, Dark::DarkLinkReceptron* _rcptn)
		: UndoRemoveObjectLink(_o, _rcptn) { }

	virtual const char* Name() const
		{ return "Remove Receptron"; }
};


/* If I ever go to multi-level undo... 
class UndoHistory
{
	typedef const UndoRecord*		node_t;
	typedef std::stack<node_t, std::list<node_t> >	stack_t;

	stack_t m_history;

public:
	~UndoHistory();
	UndoHistory();

};
*/

#endif
