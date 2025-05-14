[DromEd Basic]
July 21, 2019
Version 1.14

[Notes]
This toolkit is based on the DromEd Toolkit by Nameless Voice and was made to
get DromEd working properly with Newdark. It features updated menus that have been
streamlined and bugfixed. Newdark features have been added to the menus and bindings.

The Menus included in this toolkit have been edited from original DromEd, The 
DromEd Toolkit and the menus released with the Newdark Patch. Some commands and
redundant commands have been moved or removed.

This package can be used with Thief1, Thief Gold, and Thief2.

[Installation]
Thief1/Gold
1. Install Thief1/Gold, and ensure it is patched to its latest version
(1.33 for Thief1, and 1.37 for Thief Gold).
2. Install Newdark, and follow the instructions provided in .\Doc\T1.7z to get it
working with Thief1. 
3. Extract this toolkit to your root Thief directory. Overwrite any files when prompted.
4. Copy the contents of .\tools\Thief1 Gold Newdark Dromed\ to your root Thief Directory


Thief2
1. Install Thief II and ensure it is patched to its latest version (1.18).
2. Install Newdark
3. Decompress this toolkit to your root Thief2 directory. Overwrite any files when prompted.
4. Copy the contents of .\Tools\Thief2 Newdark Dromed\ to your root Thief2 directory.


[Changelog]
1.14
Added .\RES\Editor.crf which includes larger fonts for running DromEd in higher resolutions
Added (disabled) lines to DromEd.cfg to enable larger fonts added to Editor.crf
Added resolutions up to 4k to DromEd.cfg
Added comments on brush_color commands to Default.bnd
Replaced wall_obj with align_obj in edit menu and bindings
Added Edit Script Data... to script submenu
Added Replace Texture... to texture menu
Added (disabled) Game Mode Backup submenu
Removed Unnecessary Quest data fixes
Moved OldDark Cmds to OldDark install directories in .\Tools\OldDark Installs\
Added Remove Empty Groups, Dissolve All Groups, and Dissolve Empty Groups to multibrush menu
Added Flow Groups... to show/hide submenu
Added shift+f8 brush_to_cam binding
Hilight unsnapped now hilights unsnapped angled brushed
Removed original Thief1 convict superceded by Thief Gold convict
Steamlined install directions to be more idiotproof
Added R Soul's ConvMaster, GoalMaster, and AutomapPNG tools
Added Pinkdots' Dark Animation Tools
Moved deprecated tools to .\Tools\OldDark Installs\Tools

1.13
Added "Particle Color Palette.jpg" to docs
Added "Draw Link type..." and "Hide Link type..." to Show/Hide submenu
Added New EAX values (22-25) to EAX menu
Added "Reorder Scripts..." to Script submenu

1.12
Updated 3ds to bin application
Updated DEOCI to 1.41
Added "Runtimes" directory containing *.ocx files required for 3ds to bin, Thief Objective
wizard, and monolog viewer and installation instructions

1.11
Added disabled window resolutions for DromEd in User.cfg for easy setup.
Added "redraw_always" to olddark startup.cmd
Added "Toggle_book_autoreload" to startup.cmd
Added EditMode.cmd
Added EditModeAtPlr.cmd
Changed "Parameters"->"Variables" in Editors Menu to reflect the actual window title
Listed keyboard shortcuts for a number of menu options
Added "Camera to" submenu to View menu
Added "AI Cell" to "Camera to" submenu
Added "Object" to "Camera to" submenu
Renamed "Show" submenu in "View" to "Show/Hide"
Added "Objects" to "Show/Hide" submenu
Added "Creature Joints" to Show/Hide menu
Reorganized Hilight Menu
Added "Add Hilighted to Group" to Hilight menu
Added "Hilight Non-Axial" to Hilight menu
Merged Show "Non-Hilighted" and "Hide Non-hilighted" into "Toggle Hilighted Only"
Added Quick Link submenu to Tools menu, moved Link group items into it
Added Link Group Contains,TPath,TPathInit,DetailAttachement to quicklink menu
Added "Set Animlight cutoff" to Extra menu
Added "Set Lightmap Parameters" to Extra menu
Changed F1, now opens command help dialog, instead of printing all commands
Added Alt+R returns camera to edit mode at player position
Added Ctrl+I Spews info on selected brush to mono
Added ';' deviously selects the default face of the currently selected brush
Fixed Home binding to teleport to 0,0,0 as intended
Added Shift+U selects active meonly area brush
Added Shift+O toggle object rendering
Added Shift+F1-F7: Filter Terrain, Light, Area, Room, Object, Flow, or None
Added F9, 10 Play/Halt All Schemas
Changed Ctrl+Alt+<#> to scale player speed to more usable levels
Added Wall and Ceil object bindings to Shift+W, and Shift+C, respectively
Replaced a few non-existent commands with correct ones (Draw Path Cells->AI_Draw_cells,
Draw_AIs->AI_draw, draw_path_cell_links->AI_Draw_links, path_test->AI_Test_Cells,
draw_move_suggestions->ai_draw_suggestsions)
A few other fixes and enhancements

1.10
Added "Open Template" menu option that opens .\levels\template.mis
"Set GameSys..." should now properly show the file browser, instead of a dialog box
The "Drop Script..." option now brings up the drop script box instead of a dialog box
Added disabled menu options for loading NVScript, VK's Script, and tnhscript
Added disabled menu options for loading NVDebug, and playtesting difficulty
Added disabled option in startup.cmd to load levels\template.mis on start
Improved several dialog box defaults
Added updated Thieffont tool 1.2 by Telliamed
Added Dark Engine Object Converter Interface 1.3.2 by R Soul
Added an updated version of BintoE.exe. Old version renamed to "BintoE-old.exe
General nitpicking

1.09
Added the "Recent Files" menu option to the newdark menus

1.08
Initial Release

[Disclaimer]
Thief, DromEd and everything else is the property of their respective owners. 
USE THIS PACKAGE AT YOUR OWN RISK

[Links]
DromEd Basic Thread on TTLG
http://www.ttlg.com/forums/showthread.php?t=141708

ShockEd Basic on Systemshock.org
http://www.systemshock.org/index.php?topic=5312

Unofficial Newdark 1.19 Patch on TTLG
http://www.ttlg.com/forums/showthread.php?t=140085

Unofficial Newdark 1.20 Patch on TTLG
http://www.ttlg.com/forums/showthread.php?t=141028

Unofficial Newdark 1.21 Patch on TTLG
http://www.ttlg.com/forums/showthread.php?t=141132

Original DromEd Toolkit by Nameless Voice
http://www.ttlg.com/forums/showthread.php?t=114292