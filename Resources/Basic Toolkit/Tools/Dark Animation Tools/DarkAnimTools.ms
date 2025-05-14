/* -------------------------------------------------------
/* 			Dark Animation Tools
/*					Main
/* -------------------------------------------------------
/* author: Juliusz Kaczmarek
/* ver. 0.01
/* Nov. 2012, 2013
/* ver. 0.9
/* June 2015
/*
/* tools for importing and exporting
/* rigged characters and their motions
/* from and to dark engine games. 
/*
/* this script was possible thanks to the knowledge and experience 
/* of Volca, Shadowspawn, Weyoun, Telliamed
/* ------------------------------------------------------
*/


global DATMain

global DATImport

global DATRig


fileIn "DarkAnimTools_CommonFunc.ms"		-- some useful common functions

fileIn "DarkAnimTools_h.ms"						-- main structs and declarations

global CAL = CALstruct()							-- struct holding the current CAL file data

global BIN = BINfileStruct()						-- struct holding the current BIN file data

global currentAnimInfo = AnimInfoStruct()	-- struct holding the curent motion data - MI and MC files

global AI 												-- struct holding currently built character's data

fileIn "DarkAnimTools_DAT.ms"					-- main functions of Dark Animation Tools

fileIn "DarkAnimTools_MotSch.ms"				-- motion schema browser 

fileIn "DarkAnimTools_CA.ms"						-- custom attributes definitions

fileIn "DarkAnimTools_Rollouts.ms"				-- main rollouts definitions

fileIn "DarkMaxTools_Menu.ms"					-- menu registration





-------------------------------------------------------------------------------------------
--------------------------------  Some Global Settings     -----------------------------
-------------------------------------------------------------------------------------------

units.SystemScale =1
units.SystemType = #Feet
animationRange = (interval 1 animationRange.end)





