##############################################################################
#    Makefile for thieffon
#
#    This file is part of DarkUtils
#    Copyright (C) 2013 Tom N Harris <telliamed@whoopdedo.org>
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
##############################################################################
.SUFFIXES:
.SUFFIXES: .c .o .exe

CC = gcc -mno-cygwin -std=c99
CFLAGS = -W -Wall -Wno-strict-aliasing -O2 -I/usr/local/include
LDFLAGS = -s
LIBS = /usr/local/lib/libungif.a /usr/local/lib/libpng.a /usr/local/lib/libz.a
RC = windres
RCFLAGS = -O res

.c.o:
	$(CC) $(CFLAGS) -c -o $@ $<

.o.exe:
	$(CC) $(CFLAGS) -o $@ $<

all: thieffon.exe wfon.exe

thieffon.exe: thieffon.o file.o bmp.o pcx.o gif.o png.o pal.o
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)

thieffon.o: thieffon.c defs.h
file.o: file.c defs.h
bmp.o: bmp.c defs.h
pcx.o: pcx.c defs.h
gif.o: gif.c defs.h
png.o: png.c defs.h
pal.o: pal.c defs.h

#mkresinc.exe: mkresinc.o
#	$(CC) $(LDFLAGS) -o $@ mkresinc.o

#wfon.res: wfon.rc
#	$(RC) $(RCFLAGS) -o $@ -i wfon.rc 

#wfon-dlg.h: wfon.res mkresinc.exe
#	./mkresinc.exe wfon.res wfon-dlg.h

#wfon.o: wfon.c wfon-dlg.h
#	$(CC) $(CFLAGS) -c wfon.c

#wfon.exe: wfon.o
#	$(CC) $(LDFLAGS) -I. -mwindows -o $@ wfon.o
