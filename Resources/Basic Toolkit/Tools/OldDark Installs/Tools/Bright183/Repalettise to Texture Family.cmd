@echo off
rem		Bright conversion script
rem		for
rem		BRUSH TEXTURE FAMILIES
rem
rem		by Nameless Voice
rem
rem		Usage: First, save the textures (resized if necessary) in BMP format, and place them in a new folder.
rem		Next, copy this batch file into the same folder and run it.
rem
rem		The textures will be converted to a common palette and a Full.gif will be created automatically.
rem
rem		Note: You need IrfanView installed to use this batch file. (Freeware; get it here: http://www.irfanview.com )
rem		Note: You need to specify the path to Bright and IrfanView using 'SET' lines below.

rem		Settings:
rem			The path to Bright:
set BrightPath=C:\Games\DromEd\Bright183
rem			The path to IrfanView:
set IrfanViewPath=%programfiles%\IrfanView
rem			The path to output files to:
rem			use 'set OutputPath=.' to save files to the current folder.
set OutputPath=.\Output


rem		The batch script itself:
if exist *.pcx echo All .pcx files in this folder will be lost.
if exist *.pcx echo Press Ctrl-C to abort or
if exist *.pcx pause
if exist *.pcx del *.pcx
echo Conversion process started...
"%BrightPath%\bright.exe" -8 -colmask 255 0 255 -common -o -writepal Full.pcx *.bmp
if not exist "%OutputPath%" md "%OutputPath%"
"%IrfanViewPath%\i_view32.exe" *.pcx /convert="%OutputPath%\*.gif"
del *.pcx
pause