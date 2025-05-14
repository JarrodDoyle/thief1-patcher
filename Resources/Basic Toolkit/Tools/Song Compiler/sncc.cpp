/*
  sncc - version 1.2
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

  History:
    1.0 (2003-08-01) * Initial release.
	1.1 (2003-11-18) * Added decompiler. Support for Windows drag-and-drop.
	1.2  * Make decompiling 2-pass so section names can be used in goto statements.
	     * Integrated into namespace Dark
*/

#include <iostream>
#include <fstream>
#include <algorithm>
#include <string>
#include <limits>
#include <exception>
#include <stdexcept>
#include "DarkLib/DarkSong.h"
#include "sncc.h"
#include "getopt.h"

using namespace Dark;
using namespace std;


static const char *whitespace = " \t\n\v\f\r";


static long stringtosigned(const string &s)
{
	char *end = NULL;
	if (s.size() == 0)
		throw invalid_argument("stringtosigned");
	long num = strtol(s.c_str(), &end, 10);
	if (*end != '\0')
		throw NumberConversionError(s);
	return num;
}

static unsigned long stringtounsigned(const string &s)
{
	char *end = NULL;
	if (s.size() == 0)
		throw invalid_argument("stringtounsigned");
	unsigned long num = strtoul(s.c_str(), &end, 0);
	if (*end != '\0')
		throw NumberConversionError(s);
	return num;
}

static string fixup_sample_name(const string &name)
{
	if (name.size() > 4) {
		string ext(name, name.size() - 4);
		if (!stricmp(ext.c_str(), ".wav"))
			return name;
	}
	string ret(name);
	ret.append(".wav");
	return ret;
}

static string read_line(istream *fin)
{
	char line[1024];
	memset(line, '\0', 1024);
	fin->getline(line, 1024);
	string s(line);
	while (fin->rdstate() == ios::failbit)
	{
		memset(line, '\0', 1024);
		fin->getline(line, 1024);
		s.append(line);
	}
	
	string::size_type p = s.find_first_not_of(whitespace);
	string::size_type q = s.find_last_not_of(whitespace) + 1;

	return (q == 0) ? string("") : s.substr(p, q - p);
}

static eToken cmd_to_token(const string &cmd)
{
	if (cmd == "flags")
		return kFlagsToken;
	else if (cmd == "goto")
		return kGotoToken;
	else if (cmd == "volume")
		return kVolumeToken;
	else if (cmd == "loop_count")
		return kLoopCountToken;
	else if (cmd == "event")
		return kEventToken;
	else if (cmd == "section")
		return kSectionToken;
	else if (cmd == "song")
		return kSongToken;
	else
		return kUnknownToken;
}

static string pop_token(string &s, string::size_type *len, bool whole_line = false)
{
	string::size_type sep;
	string token;
	if (s[0] == '"')
	{
		sep = s.find_first_of('"', 1);
		if (sep == numeric_limits<string::size_type>::max())
			throw QuoteError(s);
		if (--sep > 0)
			token = s.substr(1, sep);
		sep += 2;
	}
	else
	{
		if (whole_line)
		{
			sep = numeric_limits<string::size_type>::max();
			token = s;
		}
		else
		{
			sep = s.find_first_of(whitespace);
			token = s.substr(0, sep);
		}
	}
	sep = s.find_first_not_of(whitespace, sep);
	if (len)
		*len = (sep > s.size()) ? s.size() : sep;
	s.erase(0, sep);

	return token;
}

static SongGoto make_goto(ParserInfo &state, const Song &song, string &s, int debug = 0)
{
	SongGoto gt;
	bool is_string = s[0] == '"';
	string::size_type nextpos;
	string arg = pop_token(s, &nextpos);
	if (! s.empty())
	{
		if (is_string)
			throw NumberConversionError(arg);
		gt.Probability() = stringtounsigned(arg);
		state.position += nextpos;
		is_string = s[0] == '"';
		arg = pop_token(s, &nextpos);
		if (! s.empty())
		{
			state.position += nextpos;
			throw TrailingJunk(s);
		}
	}
	unsigned int sec;
	try
	{
		if (!is_string)
		{
			try
			{
				sec = stringtounsigned(arg);
			}
			catch (NumberConversionError &e)
			{
				sec = song.SectionIndex(arg);
			}
		}
		else
		{
			sec = song.SectionIndex(arg);
		}
		gt.Section() = sec;
		gt.IsValid() = true;
	}
	catch (out_of_range &err)
	{
		gt.SetSectionName(arg);
	}

	if (debug > 1)
	{
		cerr << "Adding Goto \"" << arg << "\" (" << gt.Section() << ") ";
		cerr << "w/ Prob. " << gt.Probability();
		if (!gt.IsValid())
		{
			cerr << " w/ Deferred indexing";
		}
		cerr << endl << flush;
	}

	return gt;
}

static int resolve_gotos(Song &song, int debug = 0)
{
	unsigned int numgotos, numevents, numsections;

	if (debug > 1)
		cerr << "Re-Verifying Gotos...\n" << flush;

	numevents = song.NumEvents();
	for (unsigned int e = 0; e < numevents; ++e)
	{
		SongEvent &event = song.Event(e);
		numgotos = event.NumGotos();
		for (unsigned int g = 0; g < numgotos; ++g)
		{
			SongGoto &gt = event.Goto(g);
			if (! gt.IsValid())
			{
				unsigned int sec;
				try
				{
					if (debug > 2)
						cerr << "Resolving section \"" << gt.SectionName() << "\"\n" << flush;
					sec = song.SectionIndex(gt.SectionName());
				}
				catch (out_of_range &err)
				{
					cerr << "Unknown section name: \"" << gt.SectionName() << "\"";
					cerr << " (Goto " << g << ", Event " << e << ")\n";
					return -1;
				}
				gt.Section() = sec;
				gt.IsValid() = true;
			}
			else
			{
				if (gt.Section() > song.NumSections())
				{
					cerr << "Bad section index: " << gt.Section();
					cerr << " (Goto " << g << ", Event " << e << ")\n";
					return -1;
				}
			}
		}
	}

	numsections = song.NumSections();
	for (unsigned int s = 0; s < numsections; ++s)
	{
		SongSection &section = song.Section(s);
		numevents = section.NumEvents();
		for (unsigned int e = 0; e < numevents; ++e)
		{
			SongEvent &event = section.Event(e);
			numgotos = event.NumGotos();
			for (unsigned int g = 0; g < numgotos; ++g)
			{
				SongGoto &gt = event.Goto(g);
				if (! gt.IsValid())
				{
					unsigned int sec;
					try
					{
						if (debug > 2)
							cerr << "Resolving section \"" << gt.SectionName() << "\"\n" << flush;
						sec = song.SectionIndex(gt.SectionName());
					}
					catch (out_of_range &err)
					{
						cerr << "Unknown Section name: \"" << gt.SectionName() << "\"";
						cerr << " (Goto " << g << ", Event " << e << ", Section " << s << ")\n";
						return -1;
					}
					gt.Section() = sec;
					gt.IsValid() = true;
				}
				else
				{
					if (gt.Section() > song.NumSections())
					{
						cerr << "Bad section index: " << gt.Section();
						cerr << " (Goto " << g << ", Event " << e << ", Section " << s << ")\n";
						return -1;
					}
				}
			}
		}
	}

	return 0;
}

static int parse_line(istream *fin, ParserInfo &state, Song &song, int debug = 0)
{
	string line = read_line(fin);
	state.line++;
	state.position = 1;
	if (line.size() == 0)
		return 0;
	if (line[0] == '#' || line[0] == ';' || !line.compare(0, 2, "//"))
		return 0;

	if (debug > 2)
		cerr << "Parsing line " << state.line << endl << flush;

	state.current = line;
	string::size_type nextpos;
	string command = pop_token(line, &nextpos);

	switch (cmd_to_token(command))
	{
	case kSectionToken:
	{	// All contexts
		state.position += nextpos;
		string name = pop_token(line, &nextpos, true);
		if (! line.empty())
		{
			state.position += nextpos;
			throw TrailingJunk(line);
		}
		if (debug > 1)
			cerr << "Adding Section \"" << name << "\"\n" << flush;
		song.AddSection(SongSection(name));
		state.event = -1;
		state.section++;
		state.context = kSectionContext;
		break;
	}
	case kEventToken:
	{	// All contexts
		state.position += nextpos;
		string name = pop_token(line, &nextpos, true);
		if (! line.empty())
		{
			state.position += nextpos;
			throw TrailingJunk(line);
		}
		if (debug > 1)
			cerr << "Adding Event \"" << name << "\"\n" << flush;
		if (state.section >= 0)
			song.Section(state.section).AddEvent(SongEvent(name));
		else
			song.AddEvent(SongEvent(name));
		state.event++;
		state.context = kEventContext;
		break;
	}
	case kGotoToken:
	{
		if (state.context != kEventContext)
			throw UnexpectedToken(command);
		state.position += nextpos;
		if (state.section >= 0)
			song.Section(state.section).Event(state.event).AddGoto(make_goto(state, song, line, debug));
		else
			song.Event(state.event).AddGoto(make_goto(state, song, line, debug));
		break;
	}
	case kSongToken:
	{
		if (state.context != kRootContext)
			throw UnexpectedToken(command);
		state.position += nextpos;
		string name = pop_token(line, &nextpos, true);
		if (! line.empty())
		{
			state.position += nextpos;
			throw TrailingJunk(line);
		}
		if (debug > 1)
			cerr << "Setting song name to \"" << name << "\"\n" << flush;
		song.SetName(name);
		break;
	}
	case kFlagsToken:
	{
		if (state.context != kEventContext)
			throw UnexpectedToken(command);
		state.position += nextpos;
		unsigned long flags = stringtounsigned(pop_token(line, &nextpos));
		if (! line.empty())
		{
			state.position += nextpos;
			throw TrailingJunk(line);
		}
		if (debug > 1)
		{
			cerr << "Setting event flags to 0x";
			cerr.width(8);
			cerr.fill('0');
			cerr << hex << flags << dec << endl << flush;
		}
		if (state.section >= 0)
			song.Section(state.section).Event(state.event).Flags() = flags;
		else
			song.Event(state.event).Flags() = flags;
		break;
	}
	case kVolumeToken:
	{
		if (state.context != kSectionContext)
			throw UnexpectedToken(command);
		state.position += nextpos;
		long vol = stringtosigned(pop_token(line, &nextpos));
		if (! line.empty())
		{
			state.position += nextpos;
			throw TrailingJunk(line);
		}
		if (debug > 1)
			cerr << "Setting volume to " << vol << endl << flush;
		song.Section(state.section).Volume() = vol;
		break;
	}
	case kLoopCountToken:
	{
		if (state.context != kSectionContext)
			throw UnexpectedToken(command);
		state.position += nextpos;
		unsigned int loops = stringtounsigned(pop_token(line, &nextpos));
		if (! line.empty())
		{
			state.position += nextpos;
			throw TrailingJunk(line);
		}
		if (debug > 1)
			cerr << "Setting loop count to " << loops << endl << flush;
		song.Section(state.section).LoopCount() = loops;
		break;
	}
	case kUnknownToken:
	{
		if (state.context == kSectionContext)
		{
			string sample = fixup_sample_name(command);
			if (debug > 1)
				cerr << "Adding samples \"" << sample << "\"" << flush;
			song.Section(state.section).AddSample(sample);
			while (! line.empty())
			{
				state.position += nextpos;
				sample = fixup_sample_name(pop_token(line, &nextpos));
				if (debug > 1)
					cerr << ", \"" << sample << "\"" << flush;
				song.Section(state.section).AddSample(sample);
			}
			if (debug > 1)
				cerr << endl << flush;
			break;
		}
	} // fall-through
	default:
		throw UnexpectedToken(command);
		break;
	}

	return 0;
}

static int parse_input(istream *fin, const string &fname, Song **psong, int debug = 0)
{
	int ret = 0;

	if (debug > 2)
		cerr << "Initializing song with name \"" << fname << "\"\n" << flush;
	Song *song = new Song(fname);
	ParserInfo parser;

	try
	{
		while (!ret && fin->good())
		{
			ret = parse_line(fin, parser, *song, debug);
		}
		if (!ret)
			ret = resolve_gotos(*song, debug);
	}
	catch (ParseError &err)
	{
		cerr << fname << ":" << parser.line << ":" << parser.position;
		cerr << ": Parse Error: " << err.what() << endl;
		delete song;
		return -1;
	}
	catch (exception &err)
	{
		cerr << fname << ":" << parser.line << ":" << parser.position;
		cerr << ": Runtime Error: " << err.what() << endl;
		delete song;
		return 2;
	}

	if (!ret)
	{
		if (debug)
		{
			cerr << "Song: \"" << song->Name() << "\"  ";
			cerr << song->NumSections() << " sections\n" << flush;
		}

		*psong = song;
	}
	return ret;
}

static int dump_song(ostream *fout, Song *song, int debug = 0)
{
	size_t bytes = song->Dump(*fout);

	if (debug > 1)
	{
		cerr << bytes << " bytes.\n" << flush;
	}

	return 0;
}

static int print_song(ostream *fout, const string &fname, Song *song, int debug = 0)
{
	*fout << "song \"";
	*fout << ((song->Name().size() == 0) ? fname : song->Name());
	*fout << "\"" << endl;

	for (unsigned int e = 0; e < song->NumEvents(); ++e)
	{
		*fout << "event \"" << song->Event(e).Name() << "\"" << endl;
		*fout << "flags " << song->Event(e).Flags() << endl;
		for (unsigned int g = 0; g < song->Event(e).NumGotos(); ++g)
		{
			*fout << "goto " << song->Event(e).Goto(g).Probability() << " ";
			unsigned int s = song->Event(e).Goto(g).Section();
			if (s < song->NumSections())
				*fout << song->Section(s).Name();
			else
				*fout << s;
			*fout << endl;
		}
	}
	*fout << endl;
	for (unsigned int n = 0; n < song->NumSections(); ++n)
	{
		SongSection& section = song->Section(n);
		*fout << "section \"" << section.Name() << "\"" << endl;
		*fout << "volume " << section.Volume() << endl;
		*fout << "loop_count " << section.LoopCount() << endl;
		for (unsigned int w = 0; w < section.NumSamples(); ++w)
			*fout << section.Sample(w) << endl;
		for (unsigned int e = 0; e < section.NumEvents(); ++e)
		{
			*fout << endl;
			*fout << "event \"" << section.Event(e).Name() << "\"" << endl;
			*fout << "flags " << section.Event(e).Flags() << endl;
			for (unsigned int g = 0; g < section.Event(e).NumGotos(); ++g)
			{
				*fout << "goto " << section.Event(e).Goto(g).Probability() << " ";
				unsigned int s = section.Event(e).Goto(g).Section();
				if (s < song->NumSections())
					*fout << song->Section(s).Name();
				else
					*fout << s;
				*fout << endl;
			}
		}
		*fout << endl << endl;
	}
	return 0;
}

static int decode_event(istream *fin, const string &fname, ParserInfo *state, Song *song, int debug = 0)
{
	int ret = 0;
	struct 
	{
		unsigned int section,probability;
	} go;
	char buf[64];
	unsigned int count = 0;
	unsigned long val = 0;

	fin->read(buf, 32);
	fin->read(reinterpret_cast<char*>(&val), sizeof(val));
	buf[32] = '\0';
	SongEvent *event;
	if (state->section < 0)
	{
		unsigned int n = song->AddEvent(SongEvent(string(buf),val));
		event = &song->Event(n);
		++state->event;
	}
	else
	{
		unsigned int n = song->Section(state->section).AddEvent(SongEvent(string(buf),val));
		event = &song->Section(state->section).Event(n);
		++state->event;
	}

	fin->read(reinterpret_cast<char*>(&count), sizeof(count));
	while (!ret && fin->good() && count--)
	{
		fin->read(reinterpret_cast<char*>(&go), sizeof(go));
		event->AddGoto(SongGoto(go.section, go.probability));
	}
	return ret;
}

static int decode_section(istream *fin, const string &fname, ParserInfo *state, Song *song, int debug = 0)
{
	int ret = 0;
	char buf[64];
	unsigned int count = 0;
	long vol = 0;
	unsigned int loop = 0;

	fin->read(buf, 32);
	fin->read(reinterpret_cast<char*>(&vol), sizeof(vol));
	fin->read(reinterpret_cast<char*>(&loop), sizeof(loop));
	buf[32] = '\0';
	unsigned int n = song->AddSection(SongSection(string(buf),vol,loop));

	fin->read(reinterpret_cast<char*>(&count), sizeof(count));
	while (!ret && fin->good() && count--)
	{
		fin->read(buf, 32);
		buf[32] = '\0';
		song->Section(n).AddSample(string(buf));
	}
	fin->read(reinterpret_cast<char*>(&count), sizeof(count));
	while (!ret && fin->good() && count--)
	{
		++state->event;
		ret = decode_event(fin, fname, state, song, debug);
	}

	return ret;
}

static int decode_input(istream *fin, ostream *fout, const string &fname, Song **psong, int debug = 0)
{
	int ret = 0;

	if (debug > 2)
		cerr << "Decompiling song from file \"" << fname << "\"\n" << flush;
	Song *song = new Song(fname);
	ParserInfo parser;

	char buf[64];
	unsigned int count = 0;
	try
	{
		fin->read(buf, 36);
		buf[36] = '\0';
		if (*reinterpret_cast<unsigned long*>(buf) != 1)
		{
			ret = -1;
		}
		else
		{
			song->SetName(string(&buf[4]));
		}
		fin->read(reinterpret_cast<char*>(&count), sizeof(count));
		while (!ret && fin->good() && count--)
		{
			++parser.event;
			ret = decode_event(fin, fname, &parser, song, debug);
		}
		fin->read(reinterpret_cast<char*>(&count), sizeof(count));
		while (!ret && fin->good() && count--)
		{
			parser.event = -1;
			++parser.section;
			ret = decode_section(fin, fname, &parser, song, debug);
		}

		print_song(fout, fname, song, debug);
	}
	catch (exception &err)
	{
		cerr << fname << ":" << parser.position;
		cerr << ": error during decode: " << err.what() << endl;
		delete song;
		return 2;
	}
	
	delete song;
	return ret;
}


#define PROGRAM_VERSION   "sncc version 1.2  "
#define PROGRAM_COPYRIGHT "Dark Engine song compiler\n" \
                          "Copyright (C) 2003 Tom N Harris\n" \
                          "This is free software; see the source for copying conditions.  There is NO\n" \
                          "warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE,\n" \
                          "to the extent permitted by law.\n"

static void usage(void)
{
	cerr << PROGRAM_VERSION << endl;
	cerr << "Usage: sncc [-c|-d] [OPTION] [input-file]\n"
	        "\n"
			"  -c                compile song\n"
			"  -d                decompile song\n"
	        "  -o output-file    write (de)compiled song to output-file\n"
	        "  -v                increase verbosity each time used\n"
	        "  -V                just print the program version\n"
	        "\n"
	        "If no input-file is specified, the song script will be read from the\n"
	        "standard input.  The name of the compiled song, if not specified, is\n"
	        "either the name of the input file with the extension \".snc\" or (when\n"
	        "reading from standard input) the internal name of the song plus \".snc\"\n"
	        "Decompiled songs are printed to standard output unless an output file name\n"
	        "is specified.  If neither -c nor -d is used, the name of the file will be\n"
			"used to determine whether to compile or decompile.  Files that end in .snc\n"
			"will be decompiled; all others will be compiled.\n";
}

int main(int argc, char *argv[])
{
	int ret = 0;
	Song *song = NULL;

	char *output_filename = NULL;
	int verbosity = 0;
	int operation = 0;
	int c;
	while ((c = getopt(argc, argv, "cdo:vVh?")) != EOF)
	{
		switch (c)
		{
		case 'c':
			operation = 1;
			break;
		case 'd':
			operation = -1;
			break;
		case 'o':
			output_filename = optarg;
			break;
		case 'v':
			++verbosity;
			break;
		case 'V':
			cout << PROGRAM_VERSION << PROGRAM_COPYRIGHT;
			exit(0);
		case '?':
		default:
			usage();
			exit(1);
		}
	}

	if (verbosity)
		cerr << PROGRAM_VERSION << endl << flush;

	if (!operation)
	{
		if (optind == argc || !strcmp(argv[optind], "-"))
		{
			operation = 1;
		}
		else
		{
			const char *fname = argv[optind];
			if (!stricmp(fname + strlen(fname) - 4, ".snc"))
				operation = -1;
			else
				operation = 1;
		}
	}
	else if (operation < 0)
	{
		if (!output_filename)
			output_filename = "-";
	}

	if (operation < 0)
	{
		ostream *fout;
		if (output_filename)
		{
			if (!strcmp(output_filename,"-"))
			{
				fout = &cout;
			}
			else
			{
				fout = new ofstream(output_filename);
				if (!dynamic_cast<ofstream*>(fout)->is_open())
				{
					cerr << "Error opening file " << output_filename << endl;
					return 1;
				}
			}
		}
		else
		{
			string ofname(argv[optind]);
			replace(ofname.begin(), ofname.end(), '\\', '/');
			string::size_type baseoffset = ofname.rfind('/');
			if (baseoffset == numeric_limits<string::size_type>::max())
				baseoffset = 0;
			string::size_type offset = ofname.rfind('.') + 1;
			if (offset > baseoffset)	// max overflows so no check needed
			{
				ofname.replace(offset, numeric_limits<string::size_type>::max(), "sn", 2);
			}
			else
			{
				ofname.append(".sn");
			}
			fout = new ofstream(ofname.c_str());
			if (!dynamic_cast<ofstream*>(fout)->is_open())
			{
				cerr << "Error opening file " << ofname << endl;
				return 1;
			}
		}

		if (optind == argc || !strcmp(argv[optind], "-"))
		{
			if (verbosity > 1)
				cerr << "Reading from standard input\n" << flush;
			ret = decode_input(&cin, fout, string(""), &song, verbosity);
		}
		else
		{
			if (verbosity > 1)
				cerr << "Reading from " << argv[optind] << endl << flush;
			ifstream* fin = new ifstream();
			fin->open(argv[optind], ios::in | ios::binary);
			if (! fin->is_open())
			{
				cerr << "Error opening file: " << argv[optind] << endl;
				return 1;
			}
			string shortname(argv[optind]);
			string::size_type offset;
			replace(shortname.begin(), shortname.end(), '\\', '/');
			if ((offset = shortname.rfind('/') + 1) != 0)
				shortname.erase(0, offset);
			if ((offset = shortname.rfind('.')) != numeric_limits<string::size_type>::max())
				shortname.erase(offset);
			ret = decode_input(fin, fout, shortname, &song, verbosity);
			delete fin;
		}
	}
	else
	{
		if (optind == argc || !strcmp(argv[optind], "-"))
		{
			if (verbosity > 1)
				cerr << "Reading from standard input\n" << flush;
			ret = parse_input(&cin, string(""), &song, verbosity);
		}
		else
		{
			if (verbosity > 1)
				cerr << "Reading from " << argv[optind] << endl << flush;
			ifstream* fin = new ifstream(argv[optind]);
			if (! fin->is_open())
			{
				cerr << "Error opening file: " << argv[optind] << endl;
				return 1;
			}
			string shortname(argv[optind]);
			string::size_type offset;
			replace(shortname.begin(), shortname.end(), '\\', '/');
			if ((offset = shortname.rfind('/') + 1) != 0)
				shortname.erase(0, offset);
			if ((offset = shortname.rfind('.')) != numeric_limits<string::size_type>::max())
				shortname.erase(offset);
			ret = parse_input(fin, shortname, &song, verbosity);
			delete fin;
		}

		if (!ret && song)
		{
			string ofname;
			if (output_filename != NULL && strcmp(output_filename, "-") != 0)
			{
				ofname = output_filename;
			}
			else
			{
				if (optind == argc)
				{
					ofname = song->Name();
					if (ofname.empty())
					{
						cerr << "No internal song name when reading from STDIN!\n"
								"Please specify a \"song\" directive or use the \"-o\" option.\n";
						delete song;
						return 1;
					}
					ofname.append(".snc");
				}
				else
				{
					ofname = argv[optind];
					replace(ofname.begin(), ofname.end(), '\\', '/');
					string::size_type baseoffset = ofname.rfind('/');
					if (baseoffset == numeric_limits<string::size_type>::max())
						baseoffset = 0;
					string::size_type offset = ofname.rfind('.') + 1;
					if (offset > baseoffset)	// max overflows so no check needed
					{
						ofname.replace(offset, numeric_limits<string::size_type>::max(), "snc", 3);
					}
					else
					{
						ofname.append(".snc");
					}
				}
			}

			if (verbosity > 1)
				cerr << "Writing to " << ofname << endl << flush;
			ofstream *fout = new ofstream();
			fout->open(ofname.c_str(), ios::out | ios::trunc | ios::binary);
			if (fout->is_open())
			{
				ret = dump_song(fout, song, verbosity);
				delete fout;
			}
			else {
				cerr << "Error opening file " << ofname << endl;
				ret = 1;
			}
		}
	}

	if (song)
		delete song;

	return ret;
}
