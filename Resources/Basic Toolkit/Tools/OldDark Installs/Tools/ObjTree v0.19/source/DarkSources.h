#ifndef DARKSOURCES_H
#define DARKSOURCES_H

#include "PropertySource.h"

#include "DarkLib/DarkDB.h"
#include "DarkLib/StructReader.h"


class DarkDataSource : public PropertySource
{
protected:
	static Dark::StructReader	m_structs;
	static sint32	m_selftarget, m_selfsource;

public:
	static bool ReloadStructInfo(std::istream& _inp)
		{ m_structs.Reset(); return XML_STATUS_OK == m_structs.Parse(_inp); }
	static bool LoadStructInfo(std::istream& _inp)
		{ return XML_STATUS_OK == m_structs.Parse(_inp); }
	static const Dark::StructReader& GetStructReader()
		{ return m_structs; }
	static void SetSelfTargetObject(sint32 oid)
		{ m_selftarget = oid; }
	static void SetSelfSourceObject(sint32 oid)
		{ m_selfsource = oid; }

	static Dark::DarkProp* CreateStandardProperty(Dark::DarkDB* db, const std::string& name, sint32 oid);
};

class DarkObjectPropertySource : public DarkDataSource
{
public:
	virtual ~DarkObjectPropertySource();
	DarkObjectPropertySource(Dark::DarkObject* obj);
	DarkObjectPropertySource(const DarkObjectPropertySource&);
	DarkObjectPropertySource& operator=(const DarkObjectPropertySource&);
	
	virtual bool Get(const std::string& name, std::string& label, std::string& data) const;
	virtual bool Get(const std::string& name, std::string& label, std::string& data, std::vector<std::pair<std::string,uint32> >& symbols) const;
	virtual bool Set(const std::string& name, const std::string& data);
	virtual bool Validate(const std::string& name, std::string& data) const;

private:
	Dark::DarkObject* m_obj;
};

class DarkMetapropertySource : public DarkDataSource
{
public:
	virtual ~DarkMetapropertySource();
	DarkMetapropertySource(Dark::DarkDB* db, Dark::DarkLinkMetaProp* mp);
	DarkMetapropertySource(const DarkMetapropertySource&);
	DarkMetapropertySource& operator=(const DarkMetapropertySource&);
	
	virtual bool Get(const std::string& name, std::string& label, std::string& data) const;
	virtual bool Get(const std::string& name, std::string& label, std::string& data, std::vector<std::pair<std::string,uint32> >&) const
		{ return Get(name, label, data); }
	virtual bool Set(const std::string& name, const std::string& data);
	virtual bool Validate(const std::string& name, std::string& data) const;

private:
	Dark::DarkLinkMetaProp* m_mp;
	Dark::DarkDB* m_db;
};

class DarkLinkSource : public DarkDataSource
{
public:
	virtual ~DarkLinkSource();
	DarkLinkSource(Dark::DarkDB* db, Dark::DarkLink* link);
	DarkLinkSource(const DarkLinkSource&);
	DarkLinkSource& operator=(const DarkLinkSource&);
	
	virtual bool Get(const std::string& name, std::string& label, std::string& data) const;
	virtual bool Get(const std::string& name, std::string& label, std::string& data, std::vector<std::pair<std::string,uint32> >& symbols) const;
	virtual bool Set(const std::string& name, const std::string& data);
	virtual bool Validate(const std::string& name, std::string& data) const;

private:
	Dark::DarkLink* m_link;
	Dark::DarkDB* m_db;
};

class DarkStimulusSource : public DarkDataSource
{
public:
	virtual ~DarkStimulusSource();
	DarkStimulusSource(Dark::DarkDB* db, Dark::DarkLinkStimulus* stim);
	DarkStimulusSource(const DarkStimulusSource&);
	DarkStimulusSource& operator=(const DarkStimulusSource&);
	
	virtual bool Get(const std::string& name, std::string& label, std::string& data) const;
	virtual bool Get(const std::string& name, std::string& label, std::string& data, std::vector<std::pair<std::string,uint32> >& symbols) const;
	virtual bool Set(const std::string& name, const std::string& data);
	virtual bool Validate(const std::string& name, std::string& data) const;

private:
	Dark::DarkLinkStimulus* m_stim;
	Dark::DarkDB* m_db;
};

class DarkReceptronSource : public DarkDataSource
{
public:
	virtual ~DarkReceptronSource();
	DarkReceptronSource(Dark::DarkDB* db, Dark::DarkLinkReceptron* rcptn);
	DarkReceptronSource(const DarkReceptronSource&);
	DarkReceptronSource& operator=(const DarkReceptronSource&);
	
	virtual bool Get(const std::string& name, std::string& label, std::string& data) const;
	virtual bool Get(const std::string& name, std::string& label, std::string& data, std::vector<std::pair<std::string,uint32> >& symbols) const;
	virtual bool Set(const std::string& name, const std::string& data);
	virtual bool Validate(const std::string& name, std::string& data) const;

private:
	Dark::DarkLinkReceptron* m_receptron;
	Dark::DarkDB* m_db;
};

class DarkChunkSource : public DarkDataSource
{
public:
	virtual ~DarkChunkSource();
	DarkChunkSource(Dark::DarkDB* db);

	virtual bool Get(const std::string& name, std::string& label, std::string& data) const;
	virtual bool Get(const std::string& name, std::string& label, std::string& data, std::vector<std::pair<std::string,uint32> >& symbols) const;
	virtual bool Set(const std::string& name, const std::string& data);
	virtual bool Validate(const std::string& name, std::string& data) const;

private:
	Dark::DarkDB* m_db;
};

#endif // DARKSOURCES_H
