/*
  sncc - version 1.1
  Dark Engine song compiler
  Copyright (C) 2003 Tom N Harris

  This program is free software; you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published by the
  Free Software Foundation; either version 2, or (at your option) any
  later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

*/

#include <exception>
#include <string>

class ParseError : public std::exception
{
protected:
	std::string m_offender;

public:
	virtual ~ParseError() throw() { }
	ParseError(const std::string& _arg)
		: m_offender(_arg) { }
	ParseError(const char * _arg1, const std::string& _arg2)
		: m_offender(_arg1)
		{ m_offender.append(_arg2); }

	virtual const char * what() const throw()
		{ return m_offender.c_str(); }
};

class NumberConversionError : public ParseError
{
public:
	virtual ~NumberConversionError() throw() { }
	NumberConversionError(const std::string& _arg)
		: ParseError("Number conversion error: ", _arg) 
		{ }
};

class QuoteError : public ParseError
{
public:
	virtual ~QuoteError() throw() { }
	QuoteError(const std::string& _arg)
		: ParseError("Missing quote: ", _arg) 
		{ }
};

class UnexpectedToken : public ParseError
{
public:
	virtual ~UnexpectedToken() throw() { }
	UnexpectedToken(const std::string& _arg)
		: ParseError("Unexpected token: ", _arg) 
		{ }
};

class TrailingJunk : public ParseError
{
public:
	virtual ~TrailingJunk() throw() { }
	TrailingJunk(const std::string& _arg)
		: ParseError("Trailing junk: ", _arg) 
		{ }
};


enum eParserContext {
	kRootContext,
	kEventContext,
	kSectionContext
};

enum eToken {
	kUnknownToken,
	kVolumeToken,
	kLoopCountToken,
	kEventToken,
	kSectionToken,
	kSongToken,
	kFlagsToken,
	kGotoToken,
};


struct ParserInfo
{
	long section;
	long event;
	eParserContext context;
	unsigned long line;
	unsigned long position;
	std::string current;

	ParserInfo()
		: section(-1),
		  event(-1),
		  context(kRootContext),
		  line(0),
		  position(1)
	{ }
};
