#ifndef GMVLIMPORT_H
#define GMVLIMPORT_H

#include "expat.h"

#include "Dark/utils.h"
#include "DarkLib/DarkDB.h"
#include "DarkSources.h"
#include "ObjCache.h"

#include <string>
#include <iostream>
#include <stdexcept>

enum GmvlImportResult
{
	GmvlImportAbort,
	GmvlImportIgnore,
	GmvlImportMerge
};

struct GmvlImportNotifier
{
	virtual GmvlImportResult ObjectNameConflict(const char* name, int line, int col) = 0;
	virtual GmvlImportResult ObjectNameUnknown(const char* name, int line, int col) = 0;
	virtual GmvlImportResult MetapropertyNameUnknown(const char* name, int line, int col) = 0;
	virtual GmvlImportResult LinkFlavorUnknown(const char* flavor, int line, int col) = 0;
	virtual GmvlImportResult PropertyNameUnknown(const char* name, int line, int col) = 0;
	virtual GmvlImportResult FieldNameUnknown(const char* name, int line, int col) = 0;
	virtual GmvlImportResult FieldValueError(const char* name, const char* value, int line, int col) = 0;
};

class GmvlImporter
{
	typedef void (*_starthandler)(GmvlImporter*,const XML_Char*,const XML_Char**);
	typedef void (*_endhandler)(GmvlImporter*,const XML_Char*);

	struct parser_state_t
	{
		XML_Parser	parser;
		Dark::DarkObject*	obj;
		std::string propname;
		DarkObjectPropertySource*	prop;
		DarkLinkSource*	link;
		bool	err;
		int	err_line, err_col;
	};

	// no public copying... too troublesome
	GmvlImporter(const GmvlImporter&) { }
	GmvlImporter& operator=(const GmvlImporter&) { return *this; }

public:
	~GmvlImporter();
	GmvlImporter(Dark::DarkDB* db)
		: parser_state(NULL), callback(NULL), obj_cache(NULL), database(db)
	{
		if (database) database->inc_ref();
	}

	void Notify(GmvlImportNotifier* cb) { callback = cb; }
	int Parse(std::istream&);

protected:
	Dark::DarkObject* CreateObject(const char* _b, const char* _n);
	Dark::DarkProp* CreateProperty(const char* _n);
	Dark::DarkLinkMetaProp* CreateMetaproperty(const char* _n, sint32 _p);
	Dark::DarkLink* CreateLink(const char* _f, const char* _s, const char* _d);
	bool AddPropertyField(const char* _n, const char* _v);
	bool AddLinkField(const char* _n, const char* _v);

private:
	void raise_parse_error(const char* attr = NULL);

	static void InitialStartHandler(GmvlImporter* ptr, const XML_Char* name, const XML_Char** atts);

	static void RootStartHandler(GmvlImporter* ptr, const XML_Char* name, const XML_Char** atts);
	static void RootEndHandler(GmvlImporter* ptr, const XML_Char* name);

	static void ObjectStartHandler(GmvlImporter* ptr, const XML_Char* name, const XML_Char** atts);
	static void ObjectEndHandler(GmvlImporter* ptr, const XML_Char* name);

	static void LinkStartHandler(GmvlImporter* ptr, const XML_Char* name, const XML_Char** atts);
	static void LinkEndHandler(GmvlImporter* ptr, const XML_Char* name);

	static void PropertyStartHandler(GmvlImporter* ptr, const XML_Char* name, const XML_Char** atts);
	static void PropertyEndHandler(GmvlImporter* ptr, const XML_Char* name);

	parser_state_t* parser_state;
	GmvlImportNotifier* callback;
	ObjCache* obj_cache;
	Dark::DarkDB* database;
};

#endif // GMVLIMPORT_H
