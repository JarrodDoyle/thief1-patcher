#include "GmvlImport.h"
#include "DarkLib/parseutils.h"
#include "DarkLib/DarkIterators.h"
#include "dbtools.h"

#include <cstring>
#include <cstdio>
#include <cctype>

using namespace std;
using namespace Dark;

GmvlImporter::~GmvlImporter()
{
	if (parser_state)
	{
		XML_ParserFree(parser_state->parser);
		delete parser_state;
	}
	if (obj_cache)
		delete obj_cache;
	if (database)
		database->dec_ref();
}

DarkObject* GmvlImporter::CreateObject(const char* _b, const char* _n)
{
	sint32 parent = obj_cache->find(_b);
	DarkObject* baseobj = database->GetObject(parent);
	if (! baseobj)
		throw parameter_error("base");
	sint32 oid = obj_cache->find(_n, false);
	DarkObject* obj = database->GetObject(oid);
	if (obj)
	{
		obj->inc_ref();
		obj->SetBase(parent);
		return obj;
	}

	oid = database->NextAbstractObjectId();
	if (! oid)
		return NULL;
		//throw runtime_error("No more abstract object IDs");
	obj = new DarkObject(database, oid);
	database->AddObject(oid, obj);
	obj->SetBase(parent);
	obj_cache->add(_n, oid);

	sint32 donortype = 0;
	DarkPropInteger* donorprop = dynamic_cast<DarkPropInteger*>(baseobj->GetProperty("DonorType"));
	if (donorprop)
		donortype = donorprop->GetValue();
	donorprop = new DarkPropInteger("DonorType", database->DefaultPropertyVersion("DonorType"),
			oid, &donortype, sizeof(donortype));
	obj->AddProperty("DonorType", donorprop);
	donorprop->dec_ref();
	DarkPropString* nameprop = new DarkPropString("SymName", database->DefaultPropertyVersion("SymName"),
			oid, NULL, 0);
	nameprop->SetString(_n);
	obj->AddProperty("SymName", nameprop);
	nameprop->dec_ref();
	return obj;
}

DarkProp* GmvlImporter::CreateProperty(const char* _n)
{
	return DarkDataSource::CreateStandardProperty(database, _n, parser_state->obj->GetId());
}

DarkLinkMetaProp* GmvlImporter::CreateMetaproperty(const char* _n, sint32 _p)
{
	sint32 mpid = obj_cache->find(_n);
	if (! database->GetObject(mpid))
		throw parameter_error("name");

	uint32 f = database->Flavor("MetaProp");
	if (_p == 0)
	{
		_p= 1016;
		DarkLinkIterator allmps = parser_state->obj->GetLinksByFlavor(f);
		while (! allmps.empty())
		{
			DarkLinkMetaProp* mp = dynamic_cast<DarkLinkMetaProp*>(*allmps++);
			if (mp->GetPriority() > _p)
				_p = mp->GetPriority();
		}
		_p += 8;
	}
	DarkLinkMetaProp* mplink = new DarkLinkMetaProp(0, f, database->DefaultLinkVersion(f),
			parser_state->obj->GetId(), mpid, NULL, 0);
	mplink->SetPriority(_p);
	parser_state->obj->AddLink(mplink);
	return mplink;
}

DarkLink* GmvlImporter::CreateLink(const char* _f, const char* _s, const char* _d)
{
	sint32 srcid, destid;
	srcid = obj_cache->find(_s);
	destid = obj_cache->find(_d);
	if (! database->GetObject(destid))
		throw parameter_error("dest");
	DarkObject* srcobj = database->GetObject(srcid);
	if (! srcobj)
		throw parameter_error("src");
	uint32 flavor = database->Flavor(_f);
	if (! flavor)
		throw parameter_error("flavor");

	DarkLink* link = new DarkLinkGeneric(0, flavor, database->DefaultLinkVersion(flavor),
			srcid, destid, NULL, 0);
	srcobj->AddLink(link);
	return link;
}

bool GmvlImporter::AddPropertyField(const char* _n, const char* _v)
{
	string name = join_name_path(parser_state->propname, _n);
	return parser_state->prop->Set(name, _v);
}

bool GmvlImporter::AddLinkField(const char* _n, const char* _v)
{
	return parser_state->link->Set(_n, _v);
}

int GmvlImporter::Parse(std::istream& inp)
{
	if (!database)
		return XML_STATUS_ERROR;

	if (obj_cache)
		delete obj_cache;
	obj_cache = new ObjCache(database);

	parser_state = new parser_state_t;
	parser_state->parser = XML_ParserCreate(NULL);
	XML_SetUserData(parser_state->parser, reinterpret_cast<void*>(this));
	XML_SetStartElementHandler(parser_state->parser,
			reinterpret_cast<XML_StartElementHandler>(InitialStartHandler));
	parser_state->err = false;
	parser_state->obj = NULL;
	parser_state->prop = NULL;
	parser_state->link = NULL;

	XML_Status err = XML_STATUS_OK;
	try
	{
		char line[1024];
		while (inp)
		{
			inp.read(line, 1024);
			err = XML_Parse(parser_state->parser, line, inp.gcount(), XML_FALSE);
			if (err == XML_STATUS_ERROR)
			{
				throw parse_error(XML_GetCurrentLineNumber(parser_state->parser),
						XML_GetCurrentColumnNumber(parser_state->parser));
			}
			if (parser_state->err)
			{
				throw parse_error(parser_state->err_line, parser_state->err_col);
			}
		}
		err = XML_Parse(parser_state->parser, line, 0, XML_TRUE);
		if (err == XML_STATUS_ERROR)
		{
			throw parse_error(XML_GetCurrentLineNumber(parser_state->parser),
					XML_GetCurrentColumnNumber(parser_state->parser));
		}
	}
	catch (...)
	{
		XML_ParserFree(parser_state->parser);
		delete parser_state;
		parser_state = NULL;
		delete obj_cache;
		obj_cache = NULL;
		throw;
	}
	XML_ParserFree(parser_state->parser);
	delete parser_state;
	parser_state = NULL;
	delete obj_cache;
	obj_cache = NULL;
	return err;
}

void GmvlImporter::raise_parse_error(const char* attr)
{
	parser_state->err = true;
	parser_state->err_line = XML_GetCurrentLineNumber(parser_state->parser);
	parser_state->err_col = XML_GetCurrentColumnNumber(parser_state->parser) + 1;
	if (attr)
	{
		int start, len;
		const char* ctx = XML_GetInputContext(parser_state->parser, &start, &len);
		int p = start + 1;
		while (isspace(ctx[p]))
		{
			if (ctx[p] == '\n')
			{
				++parser_state->err_line;
				parser_state->err_col = 1;
				start = p + 1;
			}
			++p;
		}
		while (!isspace(ctx[p]) && ctx[p] != '>') ++p;
		if (*attr)
		{
			char const* ptr = ctx + p;
			char const* attr_ptr = strstr(ptr, attr);
			while (ptr < attr_ptr)
			{
				if (*ptr++ == '\n')
				{
					++parser_state->err_line;
					parser_state->err_col = 1;
					start = ptr - ctx;
				}
			}
			p = attr_ptr - ctx;
		}
		parser_state->err_col += p - start;
	}
}

void GmvlImporter::InitialStartHandler(GmvlImporter* ptr, const XML_Char* name, const XML_Char** atts)
{
	if (ptr->parser_state->err)
		return;
	try
	{
		if (! strcmp(name, "gmvl"))
			XML_SetElementHandler(ptr->parser_state->parser,
					reinterpret_cast<XML_StartElementHandler>(RootStartHandler),
					reinterpret_cast<XML_EndElementHandler>(RootEndHandler));
		else
			XML_DefaultCurrent(ptr->parser_state->parser);
	}
	catch (parameter_error& x)
	{
		ptr->raise_parse_error(x.param());
	}
	catch (...)
	{
		ptr->raise_parse_error();
	}
}

void GmvlImporter::RootStartHandler(GmvlImporter* ptr, const XML_Char* name, const XML_Char** atts)
{
	if (ptr->parser_state->err)
		return;
	
	try
	{
		if (! strcmp(name, "object"))
		{
			const XML_Char* obase = get_attr(atts, "base");
			const XML_Char* oname = get_attr(atts, "name");
			const XML_Char* otype = get_attr(atts, "type");
			if (!obase || !oname)
				throw parameter_error("");
			if (otype && strcmp(otype, "abstract") != 0)
				throw parameter_error("type");
			string arcname = unmangle_string(obase);
			string objname = unmangle_string(oname);
			DarkObject* obj = ptr->CreateObject(arcname.c_str(), objname.c_str());
			ptr->parser_state->obj = obj;
			if (obj)
				ptr->parser_state->prop = new DarkObjectPropertySource(obj);
			XML_SetElementHandler(ptr->parser_state->parser,
					reinterpret_cast<XML_StartElementHandler>(ObjectStartHandler),
					reinterpret_cast<XML_EndElementHandler>(ObjectEndHandler));
		}
		else if (!strcmp(name, "link"))
		{
			const XML_Char* lflavor = get_attr(atts, "flavor");
			const XML_Char* lsrc = get_attr(atts, "src");
			const XML_Char* ldest = get_attr(atts, "dest");
			if (!lflavor || !lsrc || !ldest)
				throw parameter_error("");
			string rel = unmangle_name(lflavor);
			string src = unmangle_string(lsrc);
			string dest = unmangle_string(ldest);
			DarkLink* link = ptr->CreateLink(rel.c_str(), src.c_str(), dest.c_str());
			if (link)
			{
				ptr->parser_state->link = new DarkLinkSource(ptr->database, link);
				link->dec_ref();
			}
			XML_SetElementHandler(ptr->parser_state->parser,
					reinterpret_cast<XML_StartElementHandler>(LinkStartHandler),
					reinterpret_cast<XML_EndElementHandler>(LinkEndHandler));
		}
		else
			XML_DefaultCurrent(ptr->parser_state->parser);
	}
	catch (parameter_error& x)
	{
		ptr->raise_parse_error(x.param());
	}
	catch (...)
	{
		ptr->raise_parse_error();
	}
}

void GmvlImporter::RootEndHandler(GmvlImporter* ptr, const XML_Char* name)
{
	if (ptr->parser_state->err)
		return;

	if (! strcmp(name, "gmvl"))
		XML_SetElementHandler(ptr->parser_state->parser, NULL, NULL);
	else
		XML_DefaultCurrent(ptr->parser_state->parser);
}

void GmvlImporter::ObjectStartHandler(GmvlImporter* ptr, const XML_Char* name, const XML_Char** atts)
{
	if (ptr->parser_state->err)
		return;
	if (! ptr->parser_state->obj)
		return;

	try
	{
		if (! strcmp(name, "property"))
		{
			const XML_Char* pname = get_attr(atts, "name");
			if (!pname)
				throw parameter_error("");
			string nm = unmangle_name(pname);
			DarkProp* prop = ptr->CreateProperty(nm.c_str());
			if (prop)
			{
				ptr->parser_state->propname = nm;
				ptr->parser_state->obj->AddProperty(nm, prop);
				prop->dec_ref();
			}
			XML_SetElementHandler(ptr->parser_state->parser,
					reinterpret_cast<XML_StartElementHandler>(PropertyStartHandler),
					reinterpret_cast<XML_EndElementHandler>(PropertyEndHandler));
		}
		else if (! strcmp(name, "metaprop"))
		{
			const XML_Char* mpname = get_attr(atts, "name");
			const XML_Char* mppriority = get_attr(atts, "priority");
			if (!mpname)
				throw parameter_error("");
			sint32 priority = 0;
			if (mppriority)
				try
				{
					priority = chartounsigned(mppriority);
				}
				catch (value_error& x)
				{
					throw parameter_error("priority");
				}
			string nm = unmangle_string(mpname);
			DarkLinkMetaProp* mp = ptr->CreateMetaproperty(nm.c_str(), priority);
			if (mp)
			{
				mp->dec_ref();
			}
		}
		else
			XML_DefaultCurrent(ptr->parser_state->parser);
	}
	catch (parameter_error& x)
	{
		ptr->raise_parse_error(x.param());
	}
	catch (...)
	{
		ptr->raise_parse_error();
	}
}

void GmvlImporter::ObjectEndHandler(GmvlImporter* ptr, const XML_Char* name)
{
	if (ptr->parser_state->err)
		return;

	if (! strcmp(name, "object"))
	{
		if (ptr->parser_state->prop)
		{
			delete ptr->parser_state->prop;
			ptr->parser_state->prop = NULL;
		}
		if (ptr->parser_state->obj)
		{
			ptr->parser_state->obj->dec_ref();
			ptr->parser_state->obj = NULL;
		}
		XML_SetElementHandler(ptr->parser_state->parser,
				reinterpret_cast<XML_StartElementHandler>(RootStartHandler),
				reinterpret_cast<XML_EndElementHandler>(RootEndHandler));
	}
	else if (! strcmp(name, "metaprop"))
		;
	else
		XML_DefaultCurrent(ptr->parser_state->parser);
}

void GmvlImporter::LinkStartHandler(GmvlImporter* ptr, const XML_Char* name, const XML_Char** atts)
{
	if (ptr->parser_state->err)
		return;
	if (! ptr->parser_state->link)
		return;

	try
	{
		if (! strcmp(name, "field"))
		{
			const XML_Char* pname = get_attr(atts, "name");
			const XML_Char* pval = get_attr(atts, "value");
			if (!pname || !pval)
				throw parameter_error("");
			string nm = unmangle_name(pname);
			string val = unmangle_string(pval);
			ptr->AddLinkField(nm.c_str(), val.c_str());
		}
		else
			XML_DefaultCurrent(ptr->parser_state->parser);
	}
	catch (parameter_error& x)
	{
		ptr->raise_parse_error(x.param());
	}
	catch (...)
	{
		ptr->raise_parse_error();
	}
}

void GmvlImporter::LinkEndHandler(GmvlImporter* ptr, const XML_Char* name)
{
	if (ptr->parser_state->err)
		return;

	if (! strcmp(name, "link"))
	{
		if (ptr->parser_state->link)
		{
			delete ptr->parser_state->link;
			ptr->parser_state->link = NULL;
		}
		XML_SetElementHandler(ptr->parser_state->parser,
				reinterpret_cast<XML_StartElementHandler>(RootStartHandler),
				reinterpret_cast<XML_EndElementHandler>(RootEndHandler));
	}
	else if (! strcmp(name, "field"))
		;
	else
		XML_DefaultCurrent(ptr->parser_state->parser);
}

void GmvlImporter::PropertyStartHandler(GmvlImporter* ptr, const XML_Char* name, const XML_Char** atts)
{
	if (ptr->parser_state->err)
		return;
	if (ptr->parser_state->propname.empty())
		return;

	try
	{
		if (! strcmp(name, "field"))
		{
			const XML_Char* pname = get_attr(atts, "name");
			const XML_Char* pval = get_attr(atts, "value");
			if (!pname || !pval)
				throw parameter_error("");
			string nm = unmangle_name(pname);
			string val = unmangle_string(pval);
			ptr->AddPropertyField(nm.c_str(), val.c_str());
		}
		else
			XML_DefaultCurrent(ptr->parser_state->parser);
	}
	catch (parameter_error& x)
	{
		ptr->raise_parse_error(x.param());
	}
	catch (...)
	{
		ptr->raise_parse_error();
	}
}

void GmvlImporter::PropertyEndHandler(GmvlImporter* ptr, const XML_Char* name)
{
	if (ptr->parser_state->err)
		return;

	if (! strcmp(name, "property"))
	{
		ptr->parser_state->propname = "";
		XML_SetElementHandler(ptr->parser_state->parser,
				reinterpret_cast<XML_StartElementHandler>(ObjectStartHandler),
				reinterpret_cast<XML_EndElementHandler>(ObjectEndHandler));
	}
	else if (! strcmp(name, "field"))
		;
	else
		XML_DefaultCurrent(ptr->parser_state->parser);
}
