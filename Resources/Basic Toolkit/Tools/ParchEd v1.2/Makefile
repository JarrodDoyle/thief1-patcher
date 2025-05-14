###############################################################################
#    Makefile
#
#    This file is part of DarkUtils/ParchEd
#    Copyright (C) 2004 Tom N Harris <telliamed@whoopdedo.cjb.net>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
###############################################################################

CC = gcc
RC = windres

RM = rm

CFLAGS = -mno-cygwin -mwindows -W -Wall -I.
LDFLAGS = 

ifdef DEBUG
CFLAGS := $(CFLAGS) -g
else
CFLAGS := $(CFLAGS) -O3 -fomit-frame-pointer
endif

DEFINES = #-DUNICODE=1 

LIBS = -lshlwapi -lcomctl32

OBJS = parched.o file.o pcx.o fon.o str.o resources.o

SRCS = parched.c file.c pcx.c fon.c str.c parched.rc 
HEADERS = parched.h fon.h resources.h Dark/fon.h Dark/utils.h 
RES = app.ico ParchEd.manifest 
MISC = ReadMe.txt Copying.txt 

.c.o:
	$(CC) $(CFLAGS) $(DEFINES) -o $@ -c $<

all: ParchEd.exe

parched: ParchEd.exe
	

clean:
	$(RM) *.o

dist:
	zip -9u parched.zip ParchEd.exe Makefile $(SRCS) $(HEADERS) $(RES) $(MISC)

ParchEd.exe: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS)

resources.o: parched.rc resources.h $(RES)
	$(RC) -i parched.rc -o resources.o

parched.o: parched.h fon.h resources.h

fon.o: fon.h

