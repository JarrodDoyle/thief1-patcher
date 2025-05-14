@echo off
rem		Resize pre-conversion script
rem		for
rem		DARK ENGINE TEXTURES, 256x256
rem
rem		by Nameless Voice
rem
rem		Usage: Drag a texture onto the batch file, and it will be converted to a 256x256 BMP file,
rem		ready to be processed by one of my palettising batch scripts.
rem
rem		Note: You need IrfanView installed to use this batch file. (Freeware; get it here: http://www.irfanview.com )
rem		Note: You need to specify the path to IrfanView using 'SET' lines below.

rem		Settings:
rem			The path to IrfanView:
set IrfanViewPath=%programfiles%\IrfanView
rem			The path to output files to:
rem			use 'set OutputPath=.' to save files to the current folder.

if "%~n1" == "" goto nodrag
rem		The batch script itself:
"%IrfanViewPath%\i_view32.exe" %1 /resample=(256,256) /convert="%~dp0\%~n1.bmp"
rem pause
goto endhere

:nodrag
echo No input file.
pause


:endhere