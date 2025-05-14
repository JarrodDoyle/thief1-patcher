/******************************************************************************
 *    DarkSong.cc
 *
 *    This file is part of DarkUtils
 *    Copyright (C) 2004 Tom N Harris <telliamed@whoopdedo.cjb.net>
 *
 *    This program is free software; you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation; either version 2 of the License, or
 *    (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program; if not, write to the Free Software
 *    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *****************************************************************************/
#include <string>
#include <vector>
#include <stdexcept>
#include <algorithm>

#include "DarkSong.h"

namespace Dark
{
using namespace std;

// Assignment to m_name member. Restrict to 32 characters (with \0).
// Would probably be better to subclass std::string, but I'm feeling lazy.
string & Song::operator= (const string &s)
{
	if (s.size() > 31)
		throw length_error("Song::operator=");
	return m_name = s;
}

string & SongSection::operator= (const string &s)
{
	if (s.size() > 31)
		throw length_error("SongSection::operator=");
	return m_name = s;
}

string & SongEvent::operator= (const string &s)
{
	if (s.size() > 31)
		throw length_error("SongEvent::operator=");
	return m_name = s;
}


// class Song
Song::Song(const string &s, unsigned long v)
	: m_version(v)
{
	if (s.size() > 31)
		throw length_error("Song::Song");
	m_name = s;
}

SongEvent & Song::Event(const string &name)
{
	vector<SongEvent>::iterator event = find(m_events.begin(), m_events.end(), name);
	if (event == m_events.end())
		throw out_of_range("Song::Event");
	return *event;
}

SongSection & Song::Section(const string &name)
{
	vector<SongSection>::iterator section = find(m_sections.begin(), m_sections.end(), name);
	if (section == m_sections.end())
		throw out_of_range("Song::Section");
	return *section;
}

unsigned int Song::SectionIndex(const string &name) const
{
	vector<SongSection>::const_iterator section = find(m_sections.begin(), m_sections.end(), name);
	if (section == m_sections.end())
		throw out_of_range("Song::Section");
	return section - m_sections.begin();
}

void Song::SetName(const string &s)
{
	if (s.size() > 31)
		throw length_error("Song::SetName");
	m_name = s;
}

// class SongSection
SongSection::SongSection(const string &s, long v, unsigned int c)
	: m_volume(v), m_loopCount(c)
{
	if (s.size() > 31)
		throw length_error("SongSection::SongSection");
	m_name = s;
}

SongSection::SongSection(const string &s, const string &p, long v, unsigned int c)
	: m_volume(v), m_loopCount(c)
{
	if (s.size() > 31 || p.size() > 31)
		throw length_error("SongSection::SongSection");
	m_name = s;
	m_samples.insert(m_samples.end(), p);
}

unsigned int SongSection::AddSample(const string &s)
{
	if (s.size() > 31)
		throw length_error("SongSection::AddSample");
	register unsigned int __i = m_samples.size();
	m_samples.insert(m_samples.end(), s);
	return __i;
}

SongEvent & SongSection::Event(const string &name)
{
	return *find(m_events.begin(), m_events.end(), name);
}

void SongSection::SetName(const string &s)
{
	if (s.size() > 31)
		throw length_error("SongSection::SetName");
	m_name = s;
}


// class SongEvent
SongEvent::SongEvent(const string &s, unsigned long f)
	: m_flags(f)
{
	if (s.size() > 31)
		throw length_error("SongEvent::SongEvent");
	m_name = s;
}

SongEvent::SongEvent(const string &s, unsigned long f, const SongGoto &g)
	: m_flags(f)
{
	if (s.size() > 31)
		throw length_error("SongEvent::SongEvent");
	m_name = s;
	m_gotos.insert(m_gotos.end(), g);
}

SongEvent::SongEvent(const string &s, const SongGoto &g)
	: m_flags(0)
{
	if (s.size() > 31)
		throw length_error("SongEvent::SongEvent");
	m_name = s;
	m_gotos.insert(m_gotos.end(), g);
}

void SongEvent::SetName(const string &s)
{
	if (s.size() > 31)
		throw length_error("SongEvent::SetName");
	m_name = s;
}


// Dump to binary format.
size_t Song::GetSize(void) const
{
	size_t l = 32 + 3 * sizeof(long);
	vector<SongEvent>::const_iterator i, j;
	for (i=m_events.begin(), j=m_events.end(); i!=j; ++i)
	{
		l += i->GetSize();
	}
	vector<SongSection>::const_iterator n, m;
	for (n=m_sections.begin(), m=m_sections.end(); n!=m; ++n)
	{
		l += n->GetSize();
	}
	return l;
}

size_t Song::Dump(char *buf, size_t len) const
{
	size_t l = 0;
	if (len < 3 * sizeof(long) + 32)
		return 0;
	{
		unsigned long *p = reinterpret_cast<unsigned long*>(buf);
		*p = m_version;
		l += sizeof(unsigned long);
		char *b = buf + l;
		memset(b, '\0', 32);
		m_name.copy(b, 31);
		l += 32;
	}
	{
		unsigned int *p = reinterpret_cast<unsigned int*>(buf + l);
		*p = m_events.size();
		l += sizeof(unsigned int);
		vector<SongEvent>::const_iterator i, j;
		for (i=m_events.begin(), j=m_events.end(); i!=j; ++i)
		{
			if (len - l < i->GetSize())
				return l;
			char *b = buf + l;
			l += i->Dump(b, len - l);
		}
	}
	{
		unsigned int *p = reinterpret_cast<unsigned int*>(buf + l);
		*p = m_sections.size();
		l += sizeof(unsigned int);
		vector<SongSection>::const_iterator i, j;
		for (i=m_sections.begin(), j=m_sections.end(); i!=j; ++i)
		{
			if (len - l < i->GetSize())
				return l;
			char *b = buf + l;
			l += i->Dump(b, len - l);
		}
	}
	return l;
}

size_t SongSection::GetSize(void) const
{
	// yeah, yeah... long or int or unsigned or whatever, it's all 4 bytes (or should be)
	size_t l = 32 + 4 * sizeof(long);
	l += 32 * m_samples.size();
	vector<SongEvent>::const_iterator i, j;
	for (i=m_events.begin(), j=m_events.end(); i!=j; ++i)
	{
		l += i->GetSize();
	}
	return l;
}

size_t SongSection::Dump(char *buf, size_t len) const
{
	size_t l = 0;
	if (len < 4 * sizeof(long) + 32)
		return 0;
	memset(buf, '\0', 32);
	m_name.copy(buf, 31);
	l += 32;
	{
		long *p = reinterpret_cast<long*>(buf + 32);
		p[0] = m_volume;
		// XXX: Overflow risk if you want to loop a sample more than 2 billion times you freak
		p[1] = m_loopCount;
		l += 2 * sizeof(long);
	}
	{
		unsigned int *p = reinterpret_cast<unsigned int*>(buf + l);
		*p = m_samples.size();
		l += sizeof(unsigned int);
		vector<string>::const_iterator i, j;
		for (i=m_samples.begin(), j=m_samples.end(); i!=j; ++i)
		{
			if (len - l < 32)
				return l;
			char *b = buf + l;
			memset(b, '\0', 32);
			i->copy(b, 31);
			l += 32;
		}
	}
	{
		unsigned int *p = reinterpret_cast<unsigned int*>(buf + l);
		*p = m_events.size();
		l += sizeof(unsigned int);
		vector<SongEvent>::const_iterator i, j;
		for (i=m_events.begin(), j=m_events.end(); i!=j; ++i)
		{
			if (len - l < i->GetSize())
				return l;
			char *b = buf + l;
			l += i->Dump(b, len - l);
		}
	}
	return l;
}

size_t SongEvent::Dump(char *buf, size_t len) const
{
	size_t l = 0;
	if (len < 2 * sizeof(long) + 32)
		return 0;
	memset(buf, '\0', 32);
	m_name.copy(buf, 31);
	l += 32;
	unsigned long *p = reinterpret_cast<unsigned long*>(buf + 32);
	p[0] = m_flags;
	p[1] = m_gotos.size();
	l += 2 * sizeof(long);
	vector<SongGoto>::const_iterator i, j;
	for (i=m_gotos.begin(), j=m_gotos.end(); i!=j; ++i)
	{
		if (len - l < SongGoto::GetSize())
			break;
		char *b = buf + l;
		l += i->Dump(b, len - l);
	}
	return l;
}

size_t SongGoto::Dump(char *buf, size_t len) const
{
	if (!m_valid)
		throw invalid_argument("SongGoto::m_section");
	unsigned int *p = reinterpret_cast<unsigned int*>(buf);
	size_t l = 0;
	if (len >= sizeof(unsigned int))
	{
		p[0] = m_section;
		l += sizeof(unsigned int);
		if (len >= 2*sizeof(unsigned int))
		{
			p[1] = m_probability;
			l += sizeof(unsigned int);
		}
	}
	return l;
}


// Dump to ostream

size_t Song::Dump(ostream &os) const
{
	size_t len;
	size_t buflen = 0;
	char *buf;
	{
		len = 32 + sizeof(unsigned long);
		buf = new char[len];
		memset(buf, '\0', len);
		buflen = len;
		unsigned long *p = reinterpret_cast<unsigned long*>(buf);
		*p = m_version;
		char *b = buf + sizeof(unsigned long);
		m_name.copy(b, 31);
		os.write(buf, len);
	}
	{
		unsigned int p = m_events.size();
		os.write(reinterpret_cast<char*>(&p), sizeof(unsigned int));
		len += sizeof(unsigned int);
		vector<SongEvent>::const_iterator i, j;
		for (i=m_events.begin(), j=m_events.end(); i!=j; ++i)
		{
			size_t l = i->GetSize();
			if (l > buflen)
			{
				delete[] buf;
				buf = new char[l];
				buflen = l;
			}
			l = i->Dump(buf, buflen);
			os.write(buf, l);
			len += l;
		}
	}
	{
		unsigned int p = m_sections.size();
		os.write(reinterpret_cast<char*>(&p), sizeof(unsigned int));
		len += sizeof(unsigned int);
		vector<SongSection>::const_iterator i, j;
		for (i=m_sections.begin(), j=m_sections.end(); i!=j; ++i)
		{
			size_t l = i->GetSize();
			if (l > buflen)
			{
				delete[] buf;
				buf = new char[l];
				buflen = l;
			}
			l = i->Dump(buf, buflen);
			os.write(buf, l);
			len += l;
		}
	}

	delete[] buf;
	return len;
}

} // namespace Dark

