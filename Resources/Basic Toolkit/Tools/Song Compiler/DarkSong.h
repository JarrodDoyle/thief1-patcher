/******************************************************************************
 *    DarkSong.h
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
#ifndef DARKLIB_DARKSONG_H
#define DARKLIB_DARKSONG_H

#include <string>
#include <vector>
#include <iostream>

namespace Dark
{

class SongGoto {
	unsigned int	m_section;
	unsigned int	m_probability;
	bool			m_valid;
	std::string		m_sectionName;

public:
	SongGoto(const SongGoto &o)
		: m_section(o.m_section), m_probability(o.m_probability), 
		  m_valid(o.m_valid), m_sectionName(o.m_sectionName)
		{ }
	SongGoto & operator=(const SongGoto &o)
		{ 
			m_section = o.m_section;
			m_probability = o.m_probability;
			m_valid = o.m_valid;
			m_sectionName = o.m_sectionName;
			return *this;
		}

	SongGoto()
		: m_section(0), m_probability(100), m_valid(false), m_sectionName("")
		{ }
	SongGoto(unsigned int s, unsigned int p = 100)
		: m_section(s), m_probability(p), m_valid(true)
		{ }
	SongGoto(const std::string &s, unsigned int p = 100)
		: m_section(0), m_probability(p), m_valid(false), m_sectionName(s)
		{ }

	unsigned int & Section(void)
		{ return m_section; }
	unsigned int & Probability(void)
		{ return m_probability; }
	bool & IsValid(void)
		{ return m_valid; }
	// The section name is meaningless if the int reference is valid.
	const std::string & SectionName(void) const
		{ return m_sectionName; }
	void SetSectionName(const std::string &s)
		{ m_sectionName = s; m_valid = false; }

	static size_t GetSize(void) 
		{ return sizeof(unsigned int) + sizeof(unsigned int); }
	size_t Dump(char *buf, size_t len) const;
};

class SongEvent {
	std::string				m_name;
	unsigned long			m_flags;
	std::vector<SongGoto>	m_gotos;

public:
	SongEvent(const SongEvent &o)
		: m_name(o.m_name), m_flags(o.m_flags), m_gotos(o.m_gotos)
		{ }
	SongEvent & operator=(const SongEvent &o)
		{ m_name = o.m_name; m_flags = o.m_flags; m_gotos = o.m_gotos; return *this; }

	SongEvent()
		: m_name(""), m_flags(0) { }
	SongEvent(const SongGoto &g)
		: m_name(""), m_flags(0)
		{ m_gotos.insert(m_gotos.end(), g); }
	SongEvent(const std::string &s, unsigned long f = 0);
	SongEvent(const std::string &s, const SongGoto &g);
	SongEvent(const std::string &s, unsigned long f, const SongGoto &g);

	std::string & operator=(const std::string &s);
	void SetName(const std::string &s);
	bool operator==(const std::string &s) const
		{ return m_name == s; }
	const std::string & Name(void)
		{ return m_name; }
	unsigned long & Flags(void)
		{ return m_flags; }
	std::vector<SongGoto> & Gotos(void)
		{ return m_gotos; }

	unsigned int NumGotos(void) const
		{ return m_gotos.size(); }
	SongGoto& Goto(unsigned int i)
		{ return m_gotos.at(i); }
	SongGoto& operator[](unsigned int i)
		{ return Goto(i); }

	unsigned int AddGoto(const SongGoto &g)
		{ m_gotos.insert(m_gotos.end(), g); return m_gotos.size() - 1; }

	size_t GetSize(void) const 
		{ return 32		// m_name
			   + sizeof(unsigned long)	// m_flags
			   + sizeof(unsigned int)	// num. gotos
			   + SongGoto::GetSize() * m_gotos.size();
		}
	size_t Dump(char *buf, size_t len) const;
};

class SongSection {
	std::string					m_name;
	long						m_volume;
	unsigned int				m_loopCount;
	std::vector<std::string>	m_samples;
	std::vector<SongEvent>		m_events;

public:
	SongSection(const SongSection &o)
		: m_name(o.m_name), m_volume(o.m_volume), m_loopCount(o.m_loopCount),
		  m_samples(o.m_samples), m_events(o.m_events)
		{ }
	SongSection & operator=(const SongSection &o)
		{ 
			m_name = o.m_name;
			m_volume = o.m_volume;
			m_loopCount = o.m_loopCount;
			m_samples = o.m_samples;
			m_events = o.m_events;
			return *this;
		}

	SongSection()
		: m_name(""), m_volume(0), m_loopCount(1) { }
	SongSection(const std::string &s, long v = 0, unsigned int c = 1);
	SongSection(const std::string &s, const std::string &p, long v = 0, unsigned int c = 1);

	std::string & operator=(const std::string &s);
	void SetName(const std::string &s);
	bool operator==(const std::string &s) const
		{ return m_name == s; }
	const std::string & Name(void)
		{ return m_name; }
	long & Volume(void)
		{ return m_volume; }
	unsigned int & LoopCount(void)
		{ return m_loopCount; }

	unsigned int NumSamples(void) const
		{ return m_samples.size(); }
	unsigned int NumEvents(void) const
		{ return m_events.size(); }

	const std::string & Sample(unsigned int i)
		{ return m_samples.at(i); }
	SongEvent & Event(unsigned int i)
		{ return m_events.at(i); }
	SongEvent & Event(const std::string &name);

	unsigned int AddSample(const std::string &s);
	unsigned int AddEvent(const SongEvent &e)
		{ m_events.insert(m_events.end(), e); return m_events.size() - 1; }

	size_t GetSize(void) const;
	size_t Dump(char *buf, size_t len) const;
};

class Song {
	unsigned long				m_version;
	std::string					m_name;
	std::vector<SongEvent>		m_events;
	std::vector<SongSection>	m_sections;

public:
	Song()
		: m_version(1), m_name("") { }
	Song(const std::string &s, unsigned long v = 1);

	std::string & operator=(const std::string &s);
	void SetName(const std::string &s);
	bool operator==(const std::string &s) const
		{ return m_name == s; }
	const std::string & Name(void)
		{ return m_name; }
	unsigned long Version(void) const
		{ return m_version; }

	unsigned int NumEvents(void) const
		{ return m_events.size(); }
	unsigned int NumSections(void) const
		{ return m_sections.size(); }

	SongEvent & Event(unsigned int i)
		{ return m_events.at(i); }
	SongSection & Section(unsigned int i)
		{ return m_sections.at(i); }
	SongSection & operator[](unsigned int i)
		{ return Section(i); }
	SongEvent & Event(const std::string &name);
	SongSection & Section(const std::string &name);
	unsigned int SectionIndex(const std::string &name) const;

	unsigned int AddEvent(const SongEvent &e)
		{ m_events.insert(m_events.end(), e); return m_events.size() - 1; }
	unsigned int AddSection(const SongSection &s)
		{ m_sections.insert(m_sections.end(), s); return m_sections.size() - 1; }

	size_t GetSize(void) const;
	size_t Dump(char *buf, size_t len) const;
	size_t Dump(std::ostream &os) const;
};

} // namespace Dark

#endif
