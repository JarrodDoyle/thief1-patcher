#ifndef PROPERTYSOURCE_H
#define PROPERTYSOURCE_H

#include <string>
#include <vector>
#include <utility>
#include "Dark/utils.h"

class PropertySource
{
public:
	virtual ~PropertySource()
		{ }
	PropertySource()
		{ }
	PropertySource(const PropertySource&)
		{ }
	PropertySource& operator=(const PropertySource&)
		{ return *this; }
	
	/* Retrieve the data and label associated with a property. 
	   Return true if successful, false otherwise.
	 */
	virtual bool Get(const std::string& name, std::string& label, std::string& data) const = 0;
	/* Also outputs the relevant symbols for the property.
	   The integer is optional, and should be zero if not used.
	 */
	virtual bool Get(const std::string& name, std::string& label, std::string& data, std::vector<std::pair<std::string,uint32> >& symbols) const = 0;
	/* Update a property with new data.
	   Return true if data is valid and was stored.
	 */
	virtual bool Set(const std::string& name, const std::string& data) = 0;
	/* Sanitize input data. Return true if the data can be set.
	   The data may be modified whether or not the string is valid.
	 */
	virtual bool Validate(const std::string& name, std::string& data) const = 0;
};


#endif
