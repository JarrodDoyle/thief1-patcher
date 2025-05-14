#include "DarkSources.h"
#include "DarkLib/DarkChunk.h"
#include "DarkLib/parseutils.h"
#include "dbtools.h"

#include <algorithm>
#include <functional>

using namespace Dark;
using namespace std;

#define PATHSEP	'\\'

StructReader DarkDataSource::m_structs;
sint32 DarkDataSource::m_selftarget = 0;
sint32 DarkDataSource::m_selfsource = 0;

struct _symbol_pair_less : public binary_function<uint32,pair<string,uint32>,bool>
{
	result_type operator() (const first_argument_type& __a, const second_argument_type& __b)
		{ return __a < __b.second; }
};

static void fill_enum_symbols(const StructField* field, vector<pair<string,uint32> >& syms)
{
	if (field->Type() == typeINTEGER::name)
	{
		const EnumInfoInteger* ienum = dynamic_cast<const StructFieldInteger*>(field)->Enum();
		if (ienum)
		{
			EnumInfoInteger::iterator ii = ienum->Begin();
			EnumInfoInteger::iterator iend = ienum->End();
			for (; ii != iend; ++ii)
			{
				vector<pair<string,uint32> >::iterator in = 
						upper_bound(syms.begin(), syms.end(), uint32(ii->second), 
						_symbol_pair_less());
				syms.insert(in, make_pair(ii->first,ii->second));
			}
		}
	}
	else if (field->Type() == typeUNSIGNED::name)
	{
		const EnumInfoUnsigned* uenum = dynamic_cast<const StructFieldUnsigned*>(field)->Enum();
		if (uenum)
		{
			EnumInfoUnsigned::iterator ui = uenum->Begin();
			EnumInfoUnsigned::iterator uend = uenum->End();
			for (; ui != uend; ++ui)
			{
				vector<pair<string,uint32> >::iterator in = 
						upper_bound(syms.begin(), syms.end(), ui->second, 
						_symbol_pair_less());
				syms.insert(in, make_pair(ui->first,ui->second));
			}
		}
	}
	else if (field->Type() == typeBITFIELD::name)
	{
		const EnumInfoBitfield* benum = dynamic_cast<const StructFieldBitfield*>(field)->Enum();
		if (benum)
		{
			EnumInfoBitfield::iterator bi = benum->Begin();
			EnumInfoBitfield::iterator bend = benum->End();
			for (; bi != bend; ++bi)
			{
				vector<pair<string,uint32> >::iterator in = 
						upper_bound(syms.begin(), syms.end(), bi->second, 
						_symbol_pair_less());
				syms.insert(in, make_pair(bi->first,bi->second));
			}
		}
	}
	else if (field->Type() == typeFLOAT::name)
	{
		const EnumInfoFloat* fenum = dynamic_cast<const StructFieldFloat*>(field)->Enum();
		if (fenum)
		{
			EnumInfoFloat::iterator fi = fenum->Begin();
			EnumInfoFloat::iterator fend = fenum->End();
			for (; fi != fend; ++fi)
				syms.push_back(make_pair(fi->first,0));
		}
	}
	else if (field->Type() == typeSTRING::name)
	{
		const EnumInfoString* senum = dynamic_cast<const StructFieldString*>(field)->Enum();
		if (senum)
		{
			EnumInfoString::iterator si = senum->Begin();
			EnumInfoString::iterator send = senum->End();
			for (; si != send; ++si)
				syms.push_back(make_pair(si->first,0));
		}
	}
	else if (field->Type() == typeBOOLEAN::name)
	{
		syms.push_back(make_pair("false",0));
		syms.push_back(make_pair("true",1));
	}
}


DarkProp* DarkDataSource::CreateStandardProperty(DarkDB* db, const string& name, sint32 oid)
{
	DarkProp* prop = NULL;
	const StructInfo* sinfo = m_structs.GetStruct(name);
	if (sinfo->Size() == -1)
	{
		DarkString data;
		data.length = 1;
		data.name[0] = '\0';
		prop = new DarkPropString(name.c_str(), db->DefaultPropertyVersion(name),
				oid, &data, sizeof(DarkString));
	}
	else
	{
		char* data = new char[sinfo->Size()];
		memset(data, 0, sinfo->Size());
		if (sinfo->NumFields() == 1)
		{
			const StructField* sfield = sinfo->Field(0);
			if ((sfield->Type() == typeINTEGER::name
			 || sfield->Type() == typeUNSIGNED::name
			 || sfield->Type() == typeBITFIELD::name)
			 && sfield->Size() == 4)
			{
				prop = new DarkPropInteger(name.c_str(), db->DefaultPropertyVersion(name),
						oid, data, sinfo->Size());
			}
			else if (sfield->Type() == typeBOOLEAN::name
				 && sfield->Size() == 4)
			{
				prop = new DarkPropBoolean(name.c_str(), db->DefaultPropertyVersion(name),
						oid, data, sinfo->Size());
			}
			else if (sfield->Type() == typeFLOAT::name
				 && sfield->Size() == 4)
			{
				prop = new DarkPropFloat(name.c_str(), db->DefaultPropertyVersion(name),
						oid, data, sinfo->Size());
			}
			else if (sfield->Type() == typeSTRING::name
				 && sfield->Size() == 16)
			{
				prop = new DarkPropLabel(name.c_str(), db->DefaultPropertyVersion(name),
						oid, data, sinfo->Size());
			}
		}
		if (! prop)
			prop = new DarkPropGeneric(name.c_str(), db->DefaultPropertyVersion(name), 
					oid, data, sinfo->Size());
	}
	return prop;
}


DarkObjectPropertySource::~DarkObjectPropertySource()
{
	m_obj->dec_ref();
}

DarkObjectPropertySource::DarkObjectPropertySource(DarkObject* obj)
	: m_obj(obj)
{
	m_obj->inc_ref();
}

DarkObjectPropertySource::DarkObjectPropertySource(const DarkObjectPropertySource& cpy)
	: DarkDataSource(cpy), m_obj(cpy.m_obj)
{
	m_obj->inc_ref();
}

DarkObjectPropertySource& DarkObjectPropertySource::operator=(const DarkObjectPropertySource& cpy)
{
	DarkObject* old = m_obj;
	m_obj = cpy.m_obj;
	m_obj->inc_ref();
	old->dec_ref();
	return *this;
}

bool DarkObjectPropertySource::Get(const string& name, string& label, string& data) const
{
	int sep = name.find(PATHSEP);
	string propname(name, 0, sep);
	string fieldname;
	if (sep >= 0)
		fieldname.assign(name, sep+1, name.size());
	label.assign(name, name.rfind(PATHSEP)+1, name.size());
	data = "<unknown>";
	DarkProp* prop = m_obj->GetProperty(propname);
	if (prop)
	{
		try
		{
			const StructInfo* propstruct = m_structs.GetStruct(propname);
			if (typeid(*prop) == typeid(DarkPropString))
			{
				/* StructInfo really isn't suited to variable-length data */
				/* We still want to steal the label from it, though */
				if (! propstruct->Label().empty())
					label = propstruct->Label();
				data = dynamic_cast<DarkPropString*>(prop)->GetString();
				if (data.empty())
					data.assign("\0", 1);
				return true;
			}
			const StructField* propfield;
			struct_off_t fieldoff;
			if (fieldname.empty())
			{
				if (! propstruct->Label().empty())
					label = propstruct->Label();
				if (propstruct->NumFields() != 1)
				{
					data = "";
					return true;
				}
				propfield = propstruct->Field(0);
				fieldoff = 0;
			}
			else
				propfield = find_field(propstruct, fieldname, &fieldoff);
			if (! propfield)
			{
				data = "<error>";
				return true;
			}
			const char* propdata = reinterpret_cast<const char*>(prop->GetData());
			if (! fieldname.empty() && ! propfield->Label().empty())
				label = propfield->Label();
			if (propfield->Type() == StructFieldStruct::type
			 || propfield->Type() == StructFieldArray::type)
			{
				data = "";
			}
			else
			{
				data = format_single_field(propstruct, propfield, fieldoff, 
							propdata, prop->GetDataSize());
				if (data.empty())
					data.assign("\0", 1);
			}
			delete[] propdata;
			return true;
		}
		catch (exception &e)
		{
			data = "<";
			data += e.what();
			data += ">";
			//return true;
		}
		if (typeid(*prop) == typeid(DarkPropString) || typeid(*prop) == typeid(DarkPropLabel))
		{
			data = dynamic_cast<DarkPropString*>(prop)->GetString();
			if (data.empty())
				data.assign("\0", 1);
		}
		else if (typeid(*prop) == typeid(DarkPropInteger))
			data = formatsigned(dynamic_cast<DarkPropInteger*>(prop)->GetValue());
		else if (typeid(*prop) == typeid(DarkPropFloat))
			data = formatfloat(dynamic_cast<DarkPropFloat*>(prop)->GetValue());
		else if (typeid(*prop) == typeid(DarkPropBoolean))
			data = formatboolean(dynamic_cast<DarkPropBoolean*>(prop)->GetValue());
		//else
		//	data = "<unknown>";
	}
	else
		data = "<error>";

	return true;
}

bool DarkObjectPropertySource::Get(const string& name, string& label, string& data, vector<pair<string,uint32> >& symbols) const
{
	int sep = name.find(PATHSEP);
	string propname(name, 0, sep);
	string fieldname;
	if (sep >= 0)
		fieldname.assign(name, sep+1, name.size());
	label.assign(name, name.rfind(PATHSEP)+1, name.size());
	data = "<unknown>";
	DarkProp* prop = m_obj->GetProperty(propname);
	if (prop)
	{
		try
		{
			const StructInfo* propstruct = m_structs.GetStruct(propname);
			if (typeid(*prop) == typeid(DarkPropString))
			{
				if (! propstruct->Label().empty())
					label = propstruct->Label();
				data = dynamic_cast<DarkPropString*>(prop)->GetString();
				if (data.empty())
					data.assign("\0", 1);
				if (propstruct->NumFields() > 0)
				{
					const StructField* propfield = propstruct->Field(propstruct->NumFields()-1);
					if (propfield->Type() == typeSTRING::name)
						fill_enum_symbols(propfield, symbols);
				}
				return true;
			}
			const StructField* propfield;
			struct_off_t fieldoff;
			if (fieldname.empty())
			{
				if (! propstruct->Label().empty())
					label = propstruct->Label();
				if (propstruct->NumFields() != 1)
				{
					data = "";
					return true;
				}
				propfield = propstruct->Field(0);
				fieldoff = propfield->Offset();
			}
			else
				propfield = find_field(propstruct, fieldname, &fieldoff);
			if (! propfield)
			{
				data = "<error>";
				return true;
			}
			const char* propdata = reinterpret_cast<const char*>(prop->GetData());
			if (! fieldname.empty() && ! propfield->Label().empty())
				label = propfield->Label();
			if (propfield->Type() == StructFieldStruct::type
			 || propfield->Type() == StructFieldArray::type)
			{
				data = "";
			}
			else
			{
				data = format_single_field(propstruct, propfield, fieldoff, 
							propdata, prop->GetDataSize());
				if (data.empty())
					data.assign("\0", 1);
				fill_enum_symbols(propfield, symbols);
			}
			delete[] propdata;
			return true;
		}
		catch (exception &e)
		{
			data = "<";
			data += e.what();
			data += ">";
			//return true;
		}
		if (typeid(*prop) == typeid(DarkPropString) || typeid(*prop) == typeid(DarkPropLabel))
		{
			data = dynamic_cast<DarkPropString*>(prop)->GetString();
			if (data.empty())
				data.assign("\0", 1);
		}
		else if (typeid(*prop) == typeid(DarkPropInteger))
			data = formatsigned(dynamic_cast<DarkPropInteger*>(prop)->GetValue());
		else if (typeid(*prop) == typeid(DarkPropFloat))
			data = formatfloat(dynamic_cast<DarkPropFloat*>(prop)->GetValue());
		else if (typeid(*prop) == typeid(DarkPropBoolean))
			data = formatboolean(dynamic_cast<DarkPropBoolean*>(prop)->GetValue());
		//else
		//	data = "<unknown>";
	}
	else
		data = "<error>";

	return true;
}

bool DarkObjectPropertySource::Set(const string& name, const string& data)
{
	int sep = name.find(PATHSEP);
	string propname(name, 0, sep);
	string fieldname;
	if (sep >= 0)
		fieldname.assign(name, sep+1, name.size());
	DarkProp* prop = m_obj->GetProperty(propname);
	if (prop)
	{
		try
		{
			const StructInfo* propstruct = m_structs.GetStruct(propname);
			if (typeid(*prop) == typeid(DarkPropString))
			{
				DarkPropString* sprop = dynamic_cast<DarkPropString*>(prop);
				if (propstruct->NumFields() > 0)
				{
					string sdata = data;
					const StructField* propfield = propstruct->Field(propstruct->NumFields()-1);
					if (propfield->Type() == typeSTRING::name)
					{
						const EnumInfoString* senum = dynamic_cast<const StructFieldString*>(propfield)->Enum();
						if (senum)
						{
							try
							{
								sdata = senum->Value(data);
							}
							catch (out_of_range &e)
							{ }
						}
					}
					sprop->SetString(sdata);
				}
				else
					sprop->SetString(data);
				return true;
			}
			const StructField* propfield;
			struct_off_t fieldoff;
			if (fieldname.empty())
			{
				if (propstruct->NumFields() != 1)
					return true;
				propfield = propstruct->Field(0);
				fieldoff = propfield->Offset();
			}
			else
				propfield = find_field(propstruct, fieldname, &fieldoff);
			if (! propfield)
				return false;
			if (propfield->Type() == StructFieldStruct::type
			 || propfield->Type() == StructFieldArray::type)
				return true;

			char* propdata = reinterpret_cast<char*>(prop->GetData());
			bool _ret = parse_single_field(propstruct, propfield, fieldoff,
					data, propdata, prop->GetDataSize());
			if (_ret)
			{
				prop->SetData(propdata, prop->GetDataSize());
			}
			delete[] propdata;
			return _ret;
		}
		catch (out_of_range &e)
		{ }
		catch (value_error &e)
		{ return false; }
		try
		{
			if (typeid(*prop) == typeid(DarkPropString) || typeid(*prop) == typeid(DarkPropLabel))
			{
				dynamic_cast<DarkPropString*>(prop)->SetString(data);
			}
			else if (typeid(*prop) == typeid(DarkPropInteger))
			{
				dynamic_cast<DarkPropInteger*>(prop)->SetValue(chartosigned(data.c_str()));
			}
			else if (typeid(*prop) == typeid(DarkPropFloat))
			{
				dynamic_cast<DarkPropFloat*>(prop)->SetValue(chartofloat(data.c_str()));
			}
			else if (typeid(*prop) == typeid(DarkPropBoolean))
			{
				dynamic_cast<DarkPropBoolean*>(prop)->SetValue(chartoboolean(data.c_str()));
			}
			else
				return false;
			return true;
		}
		catch (value_error &e)
		{ }
	}
	return false;
}

bool DarkObjectPropertySource::Validate(const string& name, string& data) const
{
	int sep = name.find(PATHSEP);
	string propname(name, 0, sep);
	string fieldname;
	if (sep >= 0)
		fieldname.assign(name, sep+1, name.size());
	DarkProp* prop = m_obj->GetProperty(propname);
	if (prop)
	{
		try
		{
			const StructInfo* propstruct = m_structs.GetStruct(propname);
			if (typeid(*prop) == typeid(DarkPropString))
			{
				return true;
			}
			const StructField* propfield;
			struct_off_t fieldoff;
			if (fieldname.empty())
			{
				if (propstruct->NumFields() != 1)
					return true;
				propfield = propstruct->Field(0);
				fieldoff = propfield->Offset();
			}
			else
				propfield = find_field(propstruct, fieldname, &fieldoff);
			if (! propfield)
				return false;
			if (propfield->Type() == StructFieldStruct::type
			 || propfield->Type() == StructFieldArray::type)
				return true;

			char* propdata = reinterpret_cast<char*>(prop->GetData());
			bool _ret = parse_single_field(propstruct, propfield, fieldoff,
					data, propdata, prop->GetDataSize());
			data = format_single_field(propstruct, propfield, fieldoff,
					propdata, prop->GetDataSize());
			if (data.empty())
				data.assign("\0", 1);
			delete[] propdata;
			return _ret;
		}
		catch (out_of_range &e)
		{ }
		catch (value_error &e)
		{ return false; }
		try
		{
			if (typeid(*prop) == typeid(DarkPropString))
			{
				// good enough
			}
			if (typeid(*prop) == typeid(DarkPropLabel))
			{
				if (data.size() > 16)
					data.resize(16);
			}
			else if (typeid(*prop) == typeid(DarkPropInteger))
			{
				int _v = chartosigned(data.c_str());
				data = formatsigned(_v);
			}
			else if (typeid(*prop) == typeid(DarkPropFloat))
			{
				float _v = chartofloat(data.c_str());
				data = formatfloat(_v);
			}
			else if (typeid(*prop) == typeid(DarkPropBoolean))
			{
				bool _v = chartoboolean(data.c_str());
				data = formatboolean(_v);
			}
			else
				return false;
			return true;
		}
		catch (value_error &e)
		{ }
	}
	return false;
}


DarkMetapropertySource::~DarkMetapropertySource()
{
	m_mp->dec_ref();
	m_db->dec_ref();
}

DarkMetapropertySource::DarkMetapropertySource(DarkDB* db, DarkLinkMetaProp* mp)
	: m_mp(mp), m_db(db)
{
	m_db->inc_ref();
	m_mp->inc_ref();
}

DarkMetapropertySource::DarkMetapropertySource(const DarkMetapropertySource& cpy)
	: DarkDataSource(cpy), m_mp(cpy.m_mp)
{
	m_db->inc_ref();
	m_mp->inc_ref();
}

DarkMetapropertySource& DarkMetapropertySource::operator=(const DarkMetapropertySource& cpy)
{
	DarkDB* dbold = m_db;
	DarkLinkMetaProp* mpold = m_mp;
	m_db = cpy.m_db;
	m_mp = cpy.m_mp;
	m_mp->inc_ref();
	mpold->dec_ref();
	dbold->dec_ref();
	return *this;
}

bool DarkMetapropertySource::Get(const string& name, string& label, string& data) const
{
	label = name;
	if (name == "Metaprop")
	{
		data = print_object_name(m_db, m_db->GetObject(m_mp->GetDest()));
		if (data.empty())
			data = "0";
	}
	else if (name == "Priority")
	{
		data = formatsigned(m_mp->GetPriority());
	}
	else
		data = "";
	return true;
}

bool DarkMetapropertySource::Set(const string& name, const string& data)
{
	if (name == "Metaprop")
	{
		sint32 oid = find_object_id(m_db, data.c_str());
		if (oid == m_mp->GetDest())
			return true;
		if (oid)
		{
			sint32 i = oid;
			DarkObject* o;
			while (i)
			{
				if (i == m_mp->GetSource())
					return false;
				o = m_db->GetObject(i);
				if (!o)
					break;
				i = o->GetBase();
			}
			o = m_db->GetObject(m_mp->GetDest());
			if (o)
				o->RemoveLink(m_mp->GetId());
			m_mp->SetDest(oid);
			o = m_db->GetObject(oid);
			if (o)
				o->AddReverseLink(m_mp);
			return true;
		}
	}
	else if (name == "Priority")
	{
		try
		{
			sint32 priority = chartosigned(data.c_str());
			if (priority > 0)
			{
				m_mp->SetPriority(priority);
				return true;
			}
		}
		catch (value_error &e)
		{ }
	}
	return false;
}

bool DarkMetapropertySource::Validate(const string& name, string& data) const
{
	if (name == "Metaprop")
	{
		sint32 oid = find_object_id(m_db, data.c_str());
		if (oid)
		{
			while (oid)
			{
				if (oid == m_mp->GetSource())
					return false;
				DarkObject* o = m_db->GetObject(oid);
				if (!o)
					break;
				oid = o->GetBase();
			}
			return true;
		}
	}
	else if (name == "Priority")
	{
		try
		{
			sint32 priority = chartosigned(data.c_str());
			if (priority > 0)
				return true;
		}
		catch (value_error &e)
		{ }
	}
	return false;
}


DarkLinkSource::~DarkLinkSource()
{
	m_link->dec_ref();
	m_db->dec_ref();
}

DarkLinkSource::DarkLinkSource(DarkDB* db, DarkLink* link)
	: m_link(link), m_db(db)
{
	m_db->inc_ref();
	m_link->inc_ref();
}

DarkLinkSource::DarkLinkSource(const DarkLinkSource& cpy)
	: DarkDataSource(cpy), m_link(cpy.m_link), m_db(cpy.m_db)
{
	m_db->inc_ref();
	m_link->inc_ref();
}

DarkLinkSource& DarkLinkSource::operator=(const DarkLinkSource& cpy)
{
	DarkDB* dbold = m_db;
	DarkLink* linkold = m_link;
	m_db = cpy.m_db;
	m_link = cpy.m_link;
	m_link->inc_ref();
	linkold->dec_ref();
	dbold->dec_ref();
	return *this;
}

bool DarkLinkSource::Get(const string& name, string& label, string& data) const
{
	if (name == "__dest")
	{
		label = "Dest";
		data = print_object_name(m_db, m_db->GetObject(m_link->GetDest()));
		if (data.empty())
			data = "0";
	}
	else if (name == "__source")
	{
		label = "Source";
		data = print_object_name(m_db, m_db->GetObject(m_link->GetSource()));
		if (data.empty())
			data = "0";
	}
	else if (name == "__data")
	{
		label = "Data";
		data = "";
	}
	else
	{
		string relname = m_db->FlavorName(m_link->GetFlavor());
		label.assign(name, name.rfind(PATHSEP)+1, name.size());
		data = "<unknown>";
		try
		{
			const StructInfo* linkstruct = m_structs.GetStruct(relname);
			// All link data is (should be) fixed-size.
			struct_off_t fieldoff;
			const StructField* linkfield = find_field(linkstruct, name, &fieldoff);
			if (! linkfield)
			{
				data = "<error>";
				return true;
			}
			if (! linkfield->Label().empty())
				label = linkfield->Label();
			if (linkfield->Type() == StructFieldStruct::type
			 || linkfield->Type() == StructFieldArray::type)
			{
				data = "";
			}
			else
			{
				const char* linkdata = reinterpret_cast<const char*>(m_link->GetData());
				data = format_single_field(linkstruct, linkfield, fieldoff,
						linkdata, m_link->GetDataSize());
				if (data.empty())
					data.assign("\0", 1);
				delete[] linkdata;
			}
			return true;
		}
		catch (exception &e)
		{
			data = "<";
			data += e.what();
			data += ">";
		}
	}
	return true;
}

bool DarkLinkSource::Get(const string& name, string& label, string& data, vector<pair<string,uint32> >& symbols) const
{
	if (name == "__dest")
	{
		label = "Dest";
		data = print_object_name(m_db, m_db->GetObject(m_link->GetDest()));
		if (data.empty())
			data = "0";
	}
	else if (name == "__source")
	{
		label = "Source";
		data = print_object_name(m_db, m_db->GetObject(m_link->GetSource()));
		if (data.empty())
			data = "0";
	}
	else if (name == "__data")
	{
		label = "Data";
		data = "";
	}
	else
	{
		string relname = m_db->FlavorName(m_link->GetFlavor());
		label.assign(name, name.rfind(PATHSEP)+1, name.size());
		data = "<unknown>";
		try
		{
			const StructInfo* linkstruct = m_structs.GetStruct(relname);
			// All link data is (should be) fixed-size.
			struct_off_t fieldoff;
			const StructField* linkfield = find_field(linkstruct, name, &fieldoff);
			if (! linkfield)
			{
				data = "<error>";
				return true;
			}
			if (! linkfield->Label().empty())
				label = linkfield->Label();
			if (linkfield->Type() == StructFieldStruct::type
			 || linkfield->Type() == StructFieldArray::type)
			{
				data = "";
			}
			else
			{
				const char* linkdata = reinterpret_cast<const char*>(m_link->GetData());
				data = format_single_field(linkstruct, linkfield, fieldoff,
						linkdata, m_link->GetDataSize());
				if (data.empty())
					data.assign("\0", 1);
				delete[] linkdata;
				fill_enum_symbols(linkfield, symbols);
			}
			return true;
		}
		catch (exception &e)
		{
			data = "<";
			data += e.what();
			data += ">";
		}
	}
	return true;
}

bool DarkLinkSource::Set(const string& name, const string& data)
{
	if (name == "__dest")
	{
		sint32 oid = find_object_id(m_db, data.c_str());
		if (oid == m_link->GetDest())
			return true;
		if (oid)
		{
			DarkObject* o = m_db->GetObject(m_link->GetDest());
			if (o)
				o->RemoveLink(m_link->GetId());
			m_link->SetDest(oid);
			o = m_db->GetObject(oid);
			if (o)
				o->AddReverseLink(m_link);
			return true;
		}
	}
	else if (name == "__source")
	{
		sint32 oid = find_object_id(m_db, data.c_str());
		if (oid == m_link->GetSource())
			return true;
		DarkObject* o = m_db->GetObject(oid);
		if (o)
		{
			DarkObject* oo = m_db->GetObject(m_link->GetSource());
			// have to remove before adding... good thing we hold a reference
			oo->RemoveLink(m_link->GetId());
			m_link->SetSource(oid);
			o->AddLink(m_link);
			return true;
		}
	}
	else
	{
		string relname = m_db->FlavorName(m_link->GetFlavor());
		try
		{
			const StructInfo* linkstruct = m_structs.GetStruct(relname);
			struct_off_t fieldoff;
			const StructField* linkfield = find_field(linkstruct, name, &fieldoff);
			if (! linkfield)
				return false;
			if (linkfield->Type() == StructFieldStruct::type
			 || linkfield->Type() == StructFieldArray::type)
				return true;
				
			unsigned long datalen = m_link->GetDataSize();
			if (datalen == 0)
				datalen = linkstruct->Size();
			char* linkdata = new char[datalen];
			memset(linkdata, 0, datalen);
			m_link->GetData(linkdata, datalen);
			bool _ret = parse_single_field(linkstruct, linkfield, fieldoff,
					data, linkdata, datalen);
			if (_ret)
			{
				m_link->SetData(linkdata, datalen);
			}
			delete[] linkdata;
			return _ret;
		}
		catch (exception &e)
		{
			return false;
		}
	}
	return false;
}

bool DarkLinkSource::Validate(const string& name, string& data) const
{
	if (name == "__dest")
	{
		sint32 oid = find_object_id(m_db, data.c_str());
		if (oid)
			return true;
	}
	else if (name == "__source")
	{
		sint32 oid = find_object_id(m_db, data.c_str());
		if (m_db->GetObject(oid))
			return true;
	}
	else
	{
		string relname = m_db->FlavorName(m_link->GetFlavor());
		try
		{
			const StructInfo* linkstruct = m_structs.GetStruct(relname);
			struct_off_t fieldoff;
			const StructField* linkfield = find_field(linkstruct, name, &fieldoff);
			if (! linkfield)
				return false;
			if (linkfield->Type() == StructFieldStruct::type
			 || linkfield->Type() == StructFieldArray::type)
				return true;
				
			unsigned long datalen = m_link->GetDataSize();
			if (datalen == 0)
				datalen = linkstruct->Size();
			char* linkdata = new char[datalen];
			m_link->GetData(linkdata, datalen);
			bool _ret = parse_single_field(linkstruct, linkfield, fieldoff,
					data, linkdata, datalen);
			data = format_single_field(linkstruct, linkfield, fieldoff,
					linkdata, datalen);
			if (data.empty())
				data.assign("\0", 1);
			delete[] linkdata;
			return _ret;
		}
		catch (exception &e)
		{
			return false;
		}
	}
	return false;
}


DarkStimulusSource::~DarkStimulusSource()
{
	m_stim->dec_ref();
	m_db->dec_ref();
}

DarkStimulusSource::DarkStimulusSource(DarkDB* db, DarkLinkStimulus* stim)
	: m_stim(stim), m_db(db)
{
	m_db->inc_ref();
	m_stim->inc_ref();
}

DarkStimulusSource::DarkStimulusSource(const DarkStimulusSource& cpy)
	: DarkDataSource(cpy), m_stim(cpy.m_stim), m_db(cpy.m_db)
{
	m_db->inc_ref();
	m_stim->inc_ref();
}

DarkStimulusSource& DarkStimulusSource::operator=(const DarkStimulusSource& cpy)
{
	DarkDB* dbold = m_db;
	DarkLinkStimulus* stimold = m_stim;
	m_db = cpy.m_db;
	m_db->inc_ref();
	m_stim = cpy.m_stim;
	m_stim->inc_ref();
	stimold->dec_ref();
	dbold->dec_ref();
	return *this;
}

bool DarkStimulusSource::Get(const string& name, string& label, string& data) const
{
	if (name == "__stim")
	{
		label = "Stimulus";
		data = print_object_name(m_db, m_db->GetObject(m_stim->GetDest()));
		if (data.empty())
			data = "0";
	}
	else
	{
		label.assign(name, name.rfind(PATHSEP)+1, name.size());
		data = "<unknown>";
		try
		{
			const StructInfo* stimstruct = m_structs.GetStruct("arSrcDesc");
			struct_off_t fieldoff;
			const StructField* stimfield = find_field(stimstruct, name, &fieldoff);
			if (! stimfield)
			{
				data = "<error>";
				return true;
			}
			if (! stimfield->Label().empty())
				label = stimfield->Label();
			if (stimfield->Type() == StructFieldStruct::type
			 || stimfield->Type() == StructFieldArray::type)
			{
				data = "";
			}
			else
			{
				const char* stimdata = reinterpret_cast<const char*>(&m_stim->GetSourceDesc());
				data = format_single_field(stimstruct, stimfield, fieldoff,
						stimdata, sizeof(DarkDBLinkARSrcDesc));
				if (data.empty())
					data.assign("\0", 1);
			}
			return true;
		}
		catch (exception &e)
		{
			data = "<";
			data += e.what();
			data += ">";
		}
	}
	return true;
}

bool DarkStimulusSource::Get(const string& name, string& label, string& data, vector<pair<string,uint32> >& symbols) const
{
	if (name == "__stim")
	{
		label = "Stimulus";
		data = print_object_name(m_db, m_db->GetObject(m_stim->GetDest()));
		if (data.empty())
			data = "0";
	}
	else
	{
		label.assign(name, name.rfind(PATHSEP)+1, name.size());
		data = "<unknown>";
		try
		{
			const StructInfo* stimstruct = m_structs.GetStruct("arSrcDesc");
			struct_off_t fieldoff;
			const StructField* stimfield = find_field(stimstruct, name, &fieldoff);
			if (! stimfield)
			{
				data = "<error>";
				return true;
			}
			if (! stimfield->Label().empty())
				label = stimfield->Label();
			if (stimfield->Type() == StructFieldStruct::type
			 || stimfield->Type() == StructFieldArray::type)
			{
				data = "";
			}
			else
			{
				const char* stimdata = reinterpret_cast<const char*>(&m_stim->GetSourceDesc());
				data = format_single_field(stimstruct, stimfield, fieldoff,
						stimdata, sizeof(DarkDBLinkARSrcDesc));
				if (data.empty())
					data.assign("\0", 1);
				fill_enum_symbols(stimfield, symbols);
			}
			return true;
		}
		catch (exception &e)
		{
			data = "<";
			data += e.what();
			data += ">";
		}
	}
	return true;
}

bool DarkStimulusSource::Set(const string& name, const string& data)
{
	if (name == "__stim")
	{
		sint32 oid = find_object_id(m_db, data.c_str());
		if (oid == m_stim->GetDest())
			return true;
		if (oid)
		{
			DarkObject* o = m_db->GetObject(m_stim->GetDest());
			if (o)
				o->RemoveLink(m_stim->GetId());
			m_stim->SetDest(oid);
			o = m_db->GetObject(oid);
			if (o)
				o->AddReverseLink(m_stim);
			return true;
		}
	}
	else
	{
		try
		{
			const StructInfo* stimstruct = m_structs.GetStruct("arSrcDesc");
			struct_off_t fieldoff;
			const StructField* stimfield = find_field(stimstruct, name, &fieldoff);
			if (! stimfield)
				return false;
			if (stimfield->Type() == StructFieldStruct::type
			 || stimfield->Type() == StructFieldArray::type)
				return true;
			DarkDBLinkARSrcDesc stimdata = m_stim->GetSourceDesc();
			bool _ret = parse_single_field(stimstruct, stimfield, fieldoff,
					data, reinterpret_cast<char*>(&stimdata), sizeof(DarkDBLinkARSrcDesc));
			if (_ret)
			{
				m_stim->SetSourceDesc(stimdata);
			}
			return _ret;
		}
		catch (exception &e)
		{
			return false;
		}
	}
	return false;
}

bool DarkStimulusSource::Validate(const string& name, string& data) const
{
	if (name == "__stim")
	{
		sint32 oid = find_object_id(m_db, data.c_str());
		if (m_db->GetObject(oid))
			return true;
	}
	else
	{
		try
		{
			const StructInfo* stimstruct = m_structs.GetStruct("arSrcDesc");
			struct_off_t fieldoff;
			const StructField* stimfield = find_field(stimstruct, name, &fieldoff);
			if (! stimfield)
				return false;
			if (stimfield->Type() == StructFieldStruct::type
			 || stimfield->Type() == StructFieldArray::type)
				return true;
			DarkDBLinkARSrcDesc stimdata = m_stim->GetSourceDesc();
			bool _ret = parse_single_field(stimstruct, stimfield, fieldoff,
					data, reinterpret_cast<char*>(&stimdata), sizeof(DarkDBLinkARSrcDesc));
			data = format_single_field(stimstruct, stimfield, fieldoff,
					reinterpret_cast<char*>(&stimdata), sizeof(DarkDBLinkARSrcDesc));
			if (data.empty())
				data.assign("\0", 1);
			return _ret;
		}
		catch (exception &e)
		{
			return false;
		}
	}
	return false;
}


DarkReceptronSource::~DarkReceptronSource()
{
	m_receptron->dec_ref();
	m_db->dec_ref();
}

DarkReceptronSource::DarkReceptronSource(DarkDB* db, DarkLinkReceptron* rcptn)
	: m_receptron(rcptn), m_db(db)
{
	m_db->inc_ref();
	m_receptron->inc_ref();
}

DarkReceptronSource::DarkReceptronSource(const DarkReceptronSource& cpy)
	: DarkDataSource(cpy), m_receptron(cpy.m_receptron), m_db(cpy.m_db)
{
	m_db->inc_ref();
	m_receptron->inc_ref();
}

DarkReceptronSource& DarkReceptronSource::operator=(const DarkReceptronSource& cpy)
{
	DarkDB* dbold = m_db;
	DarkLinkReceptron* rcptnold = m_receptron;
	m_db = cpy.m_db;
	m_db->inc_ref();
	m_receptron = cpy.m_receptron;
	m_receptron->inc_ref();
	rcptnold->dec_ref();
	dbold->dec_ref();
	return *this;
}

bool DarkReceptronSource::Get(const string& name, string& label, string& data) const
{
	if (name == "__stim")
	{
		label = "Stimulus";
		data = print_object_name(m_db, m_db->GetObject(m_receptron->GetDest()));
		if (data.empty())
			data = "0";
	}
	else if (name == "__minintensity")
	{
		label = "Min. Intensity";
		if (m_receptron->GetReactionDesc().flags & RECEPTRON_NOMIN)
			data = "None";
		else
			data = formatfloat(m_receptron->GetReactionDesc().minintensity);
	}
	else if (name == "__maxintensity")
	{
		label = "Max. Intensity";
		if (m_receptron->GetReactionDesc().flags & RECEPTRON_NOMAX)
			data = "None";
		else
			data = formatfloat(m_receptron->GetReactionDesc().maxintensity);
	}
	else if (name == "__target")
	{
		label = "Target";
		data = print_object_name(m_db, m_db->GetObject(m_receptron->GetReactionDesc().target));
		if (data.empty())
			data = "0";
	}
	else if (name == "__agent")
	{
		label = "Agent";
		data = print_object_name(m_db, m_db->GetObject(m_receptron->GetReactionDesc().agent));
		if (data.empty())
			data = "0";
	}
	else
	{
		string structname;
		string fieldname;
		unsigned long datalen;
		const char* reactdata;
		if (! name.compare(0, 9, "Reaction:"))
		{
			int sep = name.find(PATHSEP);
			structname.assign(name, 0, sep);
			if (sep < 0)
			{
				label = "Data";
				data = "";
				return true;
			}
			fieldname.assign(name, sep+1, name.size());
			datalen = 32;
			reactdata = reinterpret_cast<const char*>(&m_receptron->GetReactionDesc().params);
		}
		else
		{
			structname = "Receptron";
			fieldname = name;
			datalen = sizeof(DarkDBLinkReceptron);
			reactdata = reinterpret_cast<const char*>(&m_receptron->GetReactionDesc());
		}
		label.assign(name, name.rfind(PATHSEP)+1, name.size());
		data = "<unknown>";
		try
		{
			const StructInfo* reactstruct = m_structs.GetStruct(structname);
			struct_off_t fieldoff;
			const StructField* reactfield = find_field(reactstruct, fieldname, &fieldoff);
			if (! reactfield)
			{
				data = "<error>";
				return true;
			}
			if (! reactfield->Label().empty())
				label = reactfield->Label();
			if (reactfield->Type() == StructFieldStruct::type
			 || reactfield->Type() == StructFieldArray::type)
			{
				data = "";
			}
			else
			{
				data = format_single_field(reactstruct, reactfield, fieldoff,
						reactdata, datalen);
				if (data.empty())
					data.assign("\0", 1);
				//fill_enum_symbols(reactfield, symbols);
			}
			return true;
		}
		catch (exception &e)
		{
			data = "<";
			data += e.what();
			data += ">";
		}
	}
	return true;
}

bool DarkReceptronSource::Get(const string& name, string& label, string& data, vector<pair<string,uint32> >& symbols) const
{
	if (name == "__stim")
	{
		label = "Stimulus";
		data = print_object_name(m_db, m_db->GetObject(m_receptron->GetDest()));
		if (data.empty())
			data = "0";
	}
	else if (name == "__minintensity")
	{
		label = "Min. Intensity";
		if (m_receptron->GetReactionDesc().flags & RECEPTRON_NOMIN)
			data = "None";
		else
			data = formatfloat(m_receptron->GetReactionDesc().minintensity);
		symbols.push_back(make_pair(string("None"),0));
	}
	else if (name == "__maxintensity")
	{
		label = "Max. Intensity";
		if (m_receptron->GetReactionDesc().flags & RECEPTRON_NOMAX)
			data = "None";
		else
			data = formatfloat(m_receptron->GetReactionDesc().maxintensity);
		symbols.push_back(make_pair(string("None"),0));
	}
	else if (name == "__target")
	{
		label = "Target";
		data = print_object_name(m_db, m_db->GetObject(m_receptron->GetReactionDesc().target));
		if (data.empty())
			data = "0";
		if (m_selftarget != 0)
			symbols.push_back(make_pair(print_object_name(m_db, m_db->GetObject(m_selftarget)),0));
		if (m_selfsource != 0)
			symbols.push_back(make_pair(print_object_name(m_db, m_db->GetObject(m_selfsource)),0));
	}
	else if (name == "__agent")
	{
		label = "Agent";
		data = print_object_name(m_db, m_db->GetObject(m_receptron->GetReactionDesc().agent));
		if (data.empty())
			data = "0";
		if (m_selftarget != 0)
			symbols.push_back(make_pair(print_object_name(m_db, m_db->GetObject(m_selftarget)),0));
		if (m_selfsource != 0)
			symbols.push_back(make_pair(print_object_name(m_db, m_db->GetObject(m_selfsource)),0));
	}
	else
	{
		string structname;
		string fieldname;
		unsigned long datalen;
		const char* reactdata;
		if (! name.compare(0, 9, "Reaction:"))
		{
			int sep = name.find(PATHSEP);
			structname.assign(name, 0, sep);
			if (sep < 0)
			{
				label = "Data";
				data = "";
				return true;
			}
			fieldname.assign(name, sep+1, name.size());
			datalen = 32;
			reactdata = reinterpret_cast<const char*>(&m_receptron->GetReactionDesc().params);
		}
		else
		{
			structname = "Receptron";
			fieldname = name;
			datalen = sizeof(DarkDBLinkReceptron);
			reactdata = reinterpret_cast<const char*>(&m_receptron->GetReactionDesc());
		}
		label.assign(name, name.rfind(PATHSEP)+1, name.size());
		data = "<unknown>";
		try
		{
			const StructInfo* reactstruct = m_structs.GetStruct(structname);
			struct_off_t fieldoff;
			const StructField* reactfield = find_field(reactstruct, fieldname, &fieldoff);
			if (! reactfield)
			{
				data = "<error>";
				return true;
			}
			if (! reactfield->Label().empty())
				label = reactfield->Label();
			if (reactfield->Type() == StructFieldStruct::type
			 || reactfield->Type() == StructFieldArray::type)
			{
				data = "";
			}
			else
			{
				data = format_single_field(reactstruct, reactfield, fieldoff,
						reactdata, datalen);
				if (data.empty())
					data.assign("\0", 1);
				fill_enum_symbols(reactfield, symbols);
			}
			return true;
		}
		catch (exception &e)
		{
			data = "<";
			data += e.what();
			data += ">";
		}
	}
	return true;
}

bool DarkReceptronSource::Set(const string& name, const string& data)
{
	if (name == "__stim")
	{
		sint32 oid = find_object_id(m_db, data.c_str());
		if (oid == m_receptron->GetDest())
			return true;
		if (oid)
		{
			DarkObject* o = m_db->GetObject(m_receptron->GetDest());
			if (o)
				o->RemoveLink(m_receptron->GetId());
			m_receptron->SetDest(oid);
			o = m_db->GetObject(oid);
			if (o)
				o->AddReverseLink(m_receptron);
			return true;
		}
	}
	else
	{
		try
		{
			if (name == "__minintensity")
			{
				if (! stricmp(data.c_str(), "None"))
					m_receptron->GetReactionDesc().flags |= RECEPTRON_NOMIN;
				else
				{
					m_receptron->GetReactionDesc().minintensity = chartofloat(data.c_str());
					m_receptron->GetReactionDesc().flags &= ~RECEPTRON_NOMIN;
				}
				return true;
			}
			else if (name == "__maxintensity")
			{
				if (! stricmp(data.c_str(), "None"))
					m_receptron->GetReactionDesc().flags |= RECEPTRON_NOMAX;
				else
				{
					m_receptron->GetReactionDesc().maxintensity = chartofloat(data.c_str());
					m_receptron->GetReactionDesc().flags &= ~RECEPTRON_NOMAX;
				}
				return true;
			}
			else if (name == "__target")
			{
				m_receptron->GetReactionDesc().target = find_object_id(m_db, data.c_str());
				return true;
			}
			else if (name == "__agent")
			{
				m_receptron->GetReactionDesc().agent = find_object_id(m_db, data.c_str());
				return true;
			}
			else
			{
				string structname;
				string fieldname;
				unsigned long datalen;
				char* reactdata;
				if (! name.compare(0, 9, "Reaction:"))
				{
					int sep = name.find(PATHSEP);
					structname.assign(name, 0, sep);
					if (sep < 0)
						return true;
					fieldname.assign(name, sep+1, name.size());
					datalen = 32;
					reactdata = new char[32];
					memcpy(reactdata, reinterpret_cast<const char*>(
							&m_receptron->GetReactionDesc().params), 32);
				}
				else
				{
					structname = "Receptron";
					fieldname = name;
					datalen = sizeof(DarkDBLinkReceptron);
					reactdata = new char[sizeof(DarkDBLinkReceptron)];
					*reinterpret_cast<DarkDBLinkReceptron*>(reactdata) = 
							m_receptron->GetReactionDesc();
				}
				const StructInfo* reactstruct = m_structs.GetStruct(structname);
				struct_off_t fieldoff;
				const StructField* reactfield = find_field(reactstruct, fieldname, &fieldoff);
				if (! reactfield)
					return false;
				if (reactfield->Type() == StructFieldStruct::type
				 || reactfield->Type() == StructFieldArray::type)
					return true;
				bool _ret = parse_single_field(reactstruct, reactfield, fieldoff,
						data, reactdata, datalen);
				if (_ret)
				{
					if (datalen == 32)
					{
						memcpy(reinterpret_cast<char*>(&m_receptron->GetReactionDesc().params),
								reactdata, 32);
					}
					else
					{
						m_receptron->SetReactionDesc(*reinterpret_cast<DarkDBLinkReceptron*>(reactdata));
					}
				}
				delete[] reactdata;
				return _ret;
			}
		}
		catch (exception &e)
		{
			return false;
		}
	}
	return false;
}

bool DarkReceptronSource::Validate(const string& name, string& data) const
{
	if (name == "__stim")
	{
		sint32 oid = find_object_id(m_db, data.c_str());
		if (m_db->GetObject(oid))
			return true;
	}
		try
		{
			if (name == "__minintensity" || name == "__maxintensity")
			{
				if (! stricmp(data.c_str(), "None"))
					data = "None";
				else
				{
					float _val = chartofloat(data.c_str());
					data = formatfloat(_val);
				}
				return true;
			}
			else if (name == "__target" || name == "__agent")
			{
				sint32 oid = find_object_id(m_db, data.c_str());
				data = print_object_name(m_db, m_db->GetObject(oid));
				if (data.empty())
					data = "0";
				return true;
			}
			else
			{
				string structname;
				string fieldname;
				unsigned long datalen;
				char* reactdata;
				if (! name.compare(0, 9, "Reaction:"))
				{
					int sep = name.find(PATHSEP);
					structname.assign(name, 0, sep);
					if (sep < 0)
						return true;
					fieldname.assign(name, sep+1, name.size());
					datalen = 32;
					reactdata = new char[32];
					memcpy(reactdata, reinterpret_cast<const char*>(
							&m_receptron->GetReactionDesc().params), 32);
				}
				else
				{
					structname = "Receptron";
					fieldname = name;
					datalen = sizeof(DarkDBLinkReceptron);
					reactdata = new char[sizeof(DarkDBLinkReceptron)];
					*reinterpret_cast<DarkDBLinkReceptron*>(reactdata) = 
							m_receptron->GetReactionDesc();
				}
				const StructInfo* reactstruct = m_structs.GetStruct(structname);
				struct_off_t fieldoff;
				const StructField* reactfield = find_field(reactstruct, fieldname, &fieldoff);
				if (! reactfield)
					return false;
				if (reactfield->Type() == StructFieldStruct::type
				 || reactfield->Type() == StructFieldArray::type)
					return true;
				bool _ret = parse_single_field(reactstruct, reactfield, fieldoff,
						data, reactdata, datalen);
				data = format_single_field(reactstruct, reactfield, fieldoff,
						reactdata, datalen);
				if (data.empty())
					data.assign("\0", 1);
				delete[] reactdata;
				return _ret;
			}
		}
		catch (exception &e)
		{
			return false;
		}
	return false;
}


DarkChunkSource::~DarkChunkSource()
{
	m_db->dec_ref();
}

DarkChunkSource::DarkChunkSource(DarkDB* db)
	: m_db(db)
{
	m_db->inc_ref();
}

bool DarkChunkSource::Get(const string& name, string& label, string& data) const
{
	int sep = name.find(PATHSEP);
	string chunkname(name, 0, sep);
	string fieldname;
	if (sep >= 0)
		fieldname.assign(name, sep+1, name.size());
	label.assign(name, name.rfind(PATHSEP)+1, name.size());
	data = "<unknown>";
	DarkChunk* chunk = m_db->GetChunk(chunkname);
	if (chunk)
	{
		try
		{
			const StructInfo* chunkstruct = m_structs.GetStruct(chunkname);
			if (fieldname.empty())
			{
				data = "";
				if (! chunkstruct->Label().empty())
					label = chunkstruct->Label();
				return true;
			}
			struct_off_t fieldoff;
			const StructField* chunkfield = find_field(chunkstruct, fieldname, &fieldoff);
			if (! chunkfield)
			{
				data = "<error>";
				return true;
			}
			if (! fieldname.empty() && ! chunkfield->Label().empty())
				label = chunkfield->Label();
			if (chunkfield->Type() == StructFieldStruct::type
			 || chunkfield->Type() == StructFieldArray::type)
			{
				data = "";
			}
			else
			{
				const char* chunkdata = reinterpret_cast<const char*>(chunk->GetData());
				data = format_single_field(chunkstruct, chunkfield, fieldoff,
						chunkdata, chunk->GetDataSize());
				if (data.empty())
					data.assign("\0", 1);
				delete[] chunkdata;
			}
			return true;
		}
		catch (exception &e)
		{
			data = "<";
			data += e.what();
			data += ">";
			return true;
		}
	}
	else
		data = "<error>";

	return true;
}

bool DarkChunkSource::Get(const string& name, string& label, string& data, vector<pair<string,uint32> >& symbols) const
{
	int sep = name.find(PATHSEP);
	string chunkname(name, 0, sep);
	string fieldname;
	if (sep >= 0)
		fieldname.assign(name, sep+1, name.size());
	label.assign(name, name.rfind(PATHSEP)+1, name.size());
	data = "<unknown>";
	DarkChunk* chunk = m_db->GetChunk(chunkname);
	if (chunk)
	{
		try
		{
			const StructInfo* chunkstruct = m_structs.GetStruct(chunkname);
			if (fieldname.empty())
			{
				data = "";
				if (! chunkstruct->Label().empty())
					label = chunkstruct->Label();
				return true;
			}
			struct_off_t fieldoff;
			const StructField* chunkfield = find_field(chunkstruct, fieldname, &fieldoff);
			if (! chunkfield)
			{
				data = "<error>";
				return true;
			}
			if (! fieldname.empty() && ! chunkfield->Label().empty())
				label = chunkfield->Label();
			if (chunkfield->Type() == StructFieldStruct::type
			 || chunkfield->Type() == StructFieldArray::type)
			{
				data = "";
			}
			else
			{
				const char* chunkdata = reinterpret_cast<const char*>(chunk->GetData());
				data = format_single_field(chunkstruct, chunkfield, fieldoff,
						chunkdata, chunk->GetDataSize());
				if (data.empty())
					data.assign("\0", 1);
				fill_enum_symbols(chunkfield, symbols);
				delete[] chunkdata;
			}
			return true;
		}
		catch (exception &e)
		{
			data = "<";
			data += e.what();
			data += ">";
			return true;
		}
	}
	else
		data = "<error>";

	return true;
}

bool DarkChunkSource::Set(const string& name, const string& data)
{
	int sep = name.find(PATHSEP);
	string chunkname(name, 0, sep);
	string fieldname;
	if (sep >= 0)
		fieldname.assign(name, sep+1, name.size());
	if (fieldname.empty())
		return true;
	DarkChunk* chunk = m_db->GetChunk(chunkname);
	if (chunk)
	{
		try
		{
			const StructInfo* chunkstruct = m_structs.GetStruct(chunkname);
			struct_off_t fieldoff;
			const StructField* chunkfield = find_field(chunkstruct, fieldname, &fieldoff);
			if (! chunkfield)
				return false;
			if (chunkfield->Type() == StructFieldStruct::type
			 || chunkfield->Type() == StructFieldArray::type)
				return true;
			
			char* chunkdata = reinterpret_cast<char*>(chunk->GetData());
			bool _ret = parse_single_field(chunkstruct, chunkfield, fieldoff,
					data, chunkdata, chunk->GetDataSize());
			if (_ret)
			{
				chunk->SetData(chunkdata, chunk->GetDataSize());
			}
			delete[] chunkdata;
			return _ret;
		}
		catch (exception &e)
		{ return false; }
	}

	return false;
}

bool DarkChunkSource::Validate(const string& name, string& data) const
{
	int sep = name.find(PATHSEP);
	string chunkname(name, 0, sep);
	string fieldname;
	if (sep >= 0)
		fieldname.assign(name, sep+1, name.size());
	if (fieldname.empty())
	{
		data.clear();
		return true;
	}
	DarkChunk* chunk = m_db->GetChunk(chunkname);
	if (chunk)
	{
		try
		{
			const StructInfo* chunkstruct = m_structs.GetStruct(chunkname);
			struct_off_t fieldoff;
			const StructField* chunkfield = find_field(chunkstruct, fieldname, &fieldoff);
			if (! chunkfield)
				return false;
			if (chunkfield->Type() == StructFieldStruct::type
			 || chunkfield->Type() == StructFieldArray::type)
			{
				data.clear();
				return true;
			}
			
			char* chunkdata = reinterpret_cast<char*>(chunk->GetData());
			bool _ret = parse_single_field(chunkstruct, chunkfield, fieldoff,
					data, chunkdata, chunk->GetDataSize());
			data = format_single_field(chunkstruct, chunkfield, fieldoff,
					chunkdata, chunk->GetDataSize());
			if (data.empty())
				data.assign("\0", 1);
			delete[] chunkdata;
			return _ret;
		}
		catch (exception &e)
		{ return false; }
	}

	return false;
}

