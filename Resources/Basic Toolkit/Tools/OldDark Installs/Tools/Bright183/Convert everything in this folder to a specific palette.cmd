@echo off
rem		Bright conversion script
rem		for
rem		OBJECT TEXTURES
rem
rem		by Nameless Voice
rem
rem		Usage: First, save the textures (resized if necessary) in BMP format, and place them in a new folder.
rem		Next, *COPY* the file containing the source palette and rename it to 'full.???'
rem		(Where ??? is the file extension: supported formats are .pcx, .gif, .bmp, and .png)
rem
rem		Finally, copy this batch file into the same folder and run it.
rem
rem		WARNING: The palette source file is converted to .pcx format and renamed to Full.pal;
rem		THE ORIGINAL FILE IS NOT KEPT. Always use a copy of your palette source file.
rem
rem		The textures will be converted to a common palette and then converted to GIF format and moved to
rem		the output path specified below.
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
rem OutputPath=%t%\Obj\Txt16
set OutputPath=.


rem		The batch script itself:
if exist full.xxx del full.xxx
if exist full.pcx ren full.pcx full.xxx
if exist *.pcx echo All .pcx files in this folder will be lost.
if exist *.pcx echo Press Ctrl-C to abort or
if exist *.pcx pause
if exist *.pcx del *.pcx
if exist full.xxx ren full.xxx full.pcx

if "%1" == "" goto nodrag
"%IrfanViewPath%\i_view32.exe" %1 /convert="%~dp0Full.pcx"
cd /D "%~dp0"
if exist "Full.pcx" goto namepalette
goto nopal
:nodrag

Rem		Check if the palette file is in GIF format.
if exist Full.gif echo Using palette: Full.gif
if exist Full.gif if exist Full.pal del Full.pal
if exist Full.gif "%IrfanViewPath%\i_view32.exe" Full.gif /convert="Full.pcx"
if exist Full.gif del Full.gif
if exist Full.pcx goto namepalette

Rem		Check if the palette file is in BMP format.
if exist Full.bmp echo Using palette: Full.bmp
if exist Full.bmp if exist Full.pal	 del Full.pal
if exist Full.bmp "%IrfanViewPath%\i_view32.exe" Full.bmp /convert="Full.pcx"
if exist Full.bmp del Full.bmp
if exist Full.pcx goto namepalette

Rem		Check if the palette file is in PNG format.
if exist Full.png echo Using palette: Full.png
if exist Full.png if exist Full.pal del Full.pal
if exist Full.png "%IrfanViewPath%\i_view32.exe" Full.png /convert="Full.pcx"
if exist Full.png del Full.png
if exist Full.pcx goto namepalette

if exist Full.pcx Echo Using palette: Full.pcx

:namepalette
rem		Check if Full.pcx exists and rename it.
if exist Full.pcx if exist Full.pal del Full.pal
if exist Full.pcx ren Full.pcx Full.pal

if not exist Full.pal goto nopal


"%BrightPath%\bright.exe" -8 -palette full.pal -o *.bmp
if not exist "%OutputPath%" md "%OutputPath%"
"%IrfanViewPath%\i_view32.exe" *.pcx /convert="%OutputPath%\*.gif"
del *.pcx
goto endhere

:nopal
echo.
echo No palette file specified.
echo Either drag and drop an image onto this batch file, or
echo the palette must be placed in the same folder as this batch file
echo and named Full.???; valid formats are .pcx, .gif, .bmp, and .png
echo.
echo The file will be converted to .pcx and renamed to Full.pal.
echo The original file is NOT kept.

:endhere
pause