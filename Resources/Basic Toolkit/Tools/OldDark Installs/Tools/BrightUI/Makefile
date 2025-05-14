
CC = gcc
RC = windres

RM = rm

CFLAGS = -mno-cygwin -mwindows -W -Wall
LDFLAGS = 

ifdef DEBUG
CFLAGS := $(CFLAGS) -g
endif

DEFINES =  #-DUNICODE=1

LIBS = -lshlwapi -lcomctl32

OBJS = brightui.o exec.o resources.o

SRCS = brightui.c exec.c brightui.rc
RES = bright.ico brightui.manifest COPYING 
MISC = bright.png bright.exe Bright183Public.txt

.c.o:
	$(CC) $(CFLAGS) $(DEFINES) -o $@ -c $<

all: BrightUI.exe

brightui: BrightUI.exe

clean:
	$(RM) *.o

dist:
	zip -9 brightui.zip BrightUI.exe Makefile $(SRCS) $(RES) $(MISC)

BrightUI.exe: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS)

resources.o: brightui.rc resources.h $(RES)
	$(RC) -i brightui.rc -o resources.o

brightui.o: brightui.h resources.h

exec.o: brightui.h 

