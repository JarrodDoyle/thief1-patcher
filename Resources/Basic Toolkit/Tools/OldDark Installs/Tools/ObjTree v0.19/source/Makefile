
.SUFFIXES:
.SUFFIXES: .cpp .o .rc .exe
.PRECIOUS: %.o

PACKAGE = ObjTree
VERSION = 0.10
WINVERSION = 0,1,0,0

CC = gcc
CPP = gcc -E
CXX = g++
CXXCPP = g++ -E
AR = ar rc
RANLIB = ranlib
DLLTOOL = dlltool
OBJCOPY = objcopy
RC = windres
WARN_FLAGS = -W -Wall -Wno-unused-parameter 
EXEEXT = .exe
OBJEXT = o

DARKLIB = ../DarkLib
XMLLIB = ../expat

INCLUDES = -I.. -I$(XMLLIB)
DEFINES = -DWIN32_LEAN_AND_MEAN=1 -D_WINVER=0x400 -D_WIN32_IE=0x400 -DXML_STATIC

ifdef DEBUG
CFLAGS = -mno-cygwin -O0 -g -DDEBUG $(WARN_FLAGS) $(DEFINES) -I. $(INCLUDES)
else
CFLAGS = -mno-cygwin -O3 $(WARN_FLAGS) $(DEFINES) -I. $(INCLUDES)
endif
ifdef GPROF
CFLAGS := $(CFLAGS) -g -pg
endif

LDFLAGS = -L$(DARKLIB) -L$(XMLLIB) -lDark -lexpat -lcomctl32

OBJS =	objtree.o \
		ObjTreeWindow.o \
		ObjWindow.o \
		PropertyTree.o \
		DarkSources.o \
		ObjTreeDialogs.o \
		UndoHistory.o \
		GmvlImport.o \
		ObjCache.o \
		resources.o

DATAFILES = app.ico mdi.ico ok.ico cancel.ico list.bmp

all: ObjTree.exe

clean:
	rm -f *.o *~ 

.rc.o:
	$(RC) -o $@ -i $<

.cpp.o:
	$(CXX) $(CFLAGS) -c $<

.o.exe: $(LIBS)
	$(CXX) $(CFLAGS) -o $@ $< $(LDFLAGS)

resources.o: objtree.rc resources.h $(DATAFILES)
	$(RC) -o resources.o -i objtree.rc

ObjTree.exe: $(OBJS) ../dbtools.o
	$(CXX) -mwindows $(CFLAGS) -o $@ $(OBJS) ../dbtools.o $(LDFLAGS)

objtree.o: objtree.cpp objtree.h ObjTreeWindow.h ObjWindow.h PropertyTree.h WindowBase.h resources.h 
ObjTreeDialogs.o: ObjTreeDialogs.cpp ObjTreeDialogs.h resources.h
ObjTreeWindow.o: ObjTreeWindow.cpp ObjTreeWindow.h ObjWindow.h ObjTreeDialogs.h PropertyTree.h WindowBase.h DarkSources.h GmvlImport.h UndoHistory.h objtree.h resources.h
ObjWindow.o: ObjWindow.cpp ObjWindow.h ObjTreeWindow.h PropertyTree.h WindowBase.h DarkSources.h UndoHistory.h objtree.h resources.h 
PropertyTree.o: PropertyTree.cpp PropertyTree.h PropertySource.h WindowBase.h resources.h
DarkSources.o: DarkSources.cpp DarkSources.h
UndoHistory.o: UndoHistory.cpp UndoHistory.h
GmvlImport.o: GmvlImport.cpp GmvlImport.h DarkSources.h ObjCache.h
ObjCache.o: ObjCache.cpp ObjCache.h
