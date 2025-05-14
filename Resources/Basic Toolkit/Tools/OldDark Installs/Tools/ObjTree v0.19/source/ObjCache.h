#ifndef OBJCACHE_H
#define OBJCACHE_H

#include "Dark/utils.h"
#include "DarkLib/DarkDB.h"
#include "DarkLib/ncstr_functions.h"

#include <string>
#include <map>

/****
 * This is a quick'n'dirty way to speed up object searches.
 * There's a better way to do this, but I'm lazy.
 */
class ObjCache
{
	typedef std::map<std::string,sint32,__std::ncstr_less> cache_t;

public:
	~ObjCache();
	ObjCache(Dark::DarkDB* db)
		: database(db)
	{
		if (database) database->inc_ref();
	}

	sint32 find(const std::string& name, bool missing=true);
	void add(const std::string& name, sint32 id);

private:
	cache_t objs;
	Dark::DarkDB* database;
};

#endif // OBJCACHE_H
