#include "ObjCache.h"
#include "dbtools.h"

using namespace std;
using namespace Dark;

ObjCache::~ObjCache()
{
	if (database)
		database->dec_ref();
}

sint32 ObjCache::find(const string& name, bool missing)
{
	if (!database)
		return 0;

	cache_t::const_iterator p = objs.find(name);
	if (p != objs.end())
		return p->second;
	sint32 id = find_object_id(database, name);
	if (missing || id != 0)
		objs.insert(make_pair(name, id));
	return id;
}

void ObjCache::add(const string& name, sint32 id)
{
	if (!database)
		return;
	objs.insert(make_pair(name, id));
}

