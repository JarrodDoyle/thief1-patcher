Simple instuctions for using MeshUp and MatTweak. - Shadowspawn

MeshUp will convert a Rev 1 Thief (or SS2) AI Mesh to Rev 2 format. Don't worry,
it won't do anything to a Rev 2 mesh, just bitch at you. It doesn't need the .CAL
file or anything else.

This is a command line tool, so it works like all the other tools I've written.

Syntax: MeshUp Rev1file Rev2File.

For example: MeshUp rabbit.bin rabbit2.bin

You need to provide it an output name, it won't overwrite the original.
Remember to rename (or copy and rename) the .CAL file which matches the .BIN file.
There have to be matching .bin and .cal files for Thief to load them properly.

That's it. Now you can use Renderer -> Mesh Textures and it will work. (It never
worked on Rev 1 meshes). You can also use the next tool on your mesh now.







MatTweak will only work on Rev 2 AI meshes, Thief2 or SS2. When you run it, it
will list the materials and prompt you to make changes. Hitting "Enter" by
itself will not make any changes, so it's always safe to do.

This program WILL OVERWRITE the original file, no output name is allowed.
It's easy enough to put things back the way the were, so no need. I WOULD make
a backup first, in any case.

Example:
MatTweak robotwoa.bin
MatTweak Version 1.00 by Shadowspawn

For changes to the Material values, use TRANSP 0-100 and ILLUM 0-100
Combine values like TRANSP 50, ILLUM 100
Hit RETURN to accept the values. Empty line means no changes

Material 0: ComBot.gif
Active Attributes:
Changes:TRANSP 50

Material 1: FURN_.gif
Active Attributes:  ILLUM
ILLUM  100
Changes:illum 0

This example shows how to make the main body of the worker bot 50% transparent,
and to turn off the illumination on the furnace port.

BTW: I noticed when playing with this that the bots don't stay transparent when
they move, only when they are at rest. So you probably shouldn't make the bots
transparent. I haven't seen this effect on any other AI, yet.
