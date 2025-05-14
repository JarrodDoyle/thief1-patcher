Thief Objective Wizard - Version 1.01
---------------------------------------

---------------
How to Install:
---------------
Unzip the files to wherever you wish. Note that the OCX files are important if for some odd reason or another you don't have them (in which case TOW will not start). You should put these in your Windows/System directory.
Also, if you get the error that it can't find the file "MSVBVM60.DLL", this means that you need Visual Basic 6 Run-Times. You can download the file from a number of locations, including these two places:
http://members.nbci.com/dromed/downloads/vb6rt.zip
http://download.cnet.com/downloads/0-10082-100-2521933.html

---------------------------------------
An Intro to the Thief Objective Wizard:
---------------------------------------
The purpose of Thief Objective Wizard is to simplify the process of creating objectives for your mission, both for Thief 1 and Thief 2. Instead of spending an hour typing your objectives into the Dromed Console, you can spend a minute hitting buttons and be done with it.
In no way is this meant to do objectives entirely for you; You, the user, are expected to have a beginner's knowledge of how objectives work. While it does write all of the commands for you, you're the one who has to determine if you need to make that stealable object a Type 1 goal or a Type 3 Special, or determine if that Optional-Reverse-Final-Bonus-Steal-The-Sceptre objective combo will crash the game or not.

--------------------------------------
How to use the Thief Objective Wizard:
--------------------------------------
I wouldn't have made a program to simplify objective creation if the program itself wasn't simple. But there are a few parts of it that can boggle a mind or two, so here's your complete User Manual to what I couldn't explain in one or two words.
*-First off are the Goal Types. When you put the object/creature/loot/room numbers into the text boxes, don't include the '#' sign. I don't know why you would, but some people have, so I suppose I should warn against it. If you need to steal object 1243, then 1243 is all you need in the box.
*-No Type. This is for you advanced QVar junkies, who don't want or need types for your unique objectives.
*-Also, if you don't change the words in the # Box next to the Type you selected, the default words (Object #, Creature #, etc.) will be what pops into the objective list, and objective "goal_type_0, Object #" certainly won't work in Thief.
*-You'll notice that the third goal type has four text boxes for loot, and two others for Specials. If you change what's in any of the boxes to something other than the default, then that will be added. For example:
If you're wanting an objective to get a Total Loot sum of 5000, only edit the 'Total' text box (and type in 5000, obviously). If you edit any other boxes, then those objectives will be added, too. If you didn't mean to change the contents of a box, just change it back to its original wording or hit the Reset button.
The Special boxes. If you have no idea what these are, then you probably should leave them alone. These are for objects with the 'Special' flag on them. As a note, T2's "Special" list box is the goal_special command, and the input-textbox is the goal_specials command. Again, unless you know how to use them, they're best untouched.
*-Goal visibility. One thing you'll want to note is that if you have 'Bonus' checked, your objective will be added as Invisible, no matter whether you have 'Visible' clicked or not. The purpose to this is that invisibility is the whole point to a 'Bonus' objective; it only becomes visible when you've completed it and doesn't matter to the mission until it's visible.
*-Other. If you're making a mission for T1, you probably wouldn't want to use the T2-only objectives. Otherwise, that Beginner's Knowledge of objectives I mentioned earlier should kick in and tell you what the others mean.
*-Add/Reset. Hit the Add button when you've got *everything* selected for the goal, and not just when you've picked the type or the visibility. Everything. The Reset button is for just in case you screw up and want to reset all the boxes to default positions. The reset button does not change the Goal #, nor does it change the Objective List.
*-Goal #. You're only allowed to have up to 30 goals. Mainly because having more than 30 can crash a mission. The number in the box automatically goes up every time you hit add, but just in case you want to be queer and jump ahead a few numbers, you're able to select which goal number you want it to be. And that Beginner's Knowledge should tell you that '0' is the first objective.

*-The New button, in the File Menu. Alright, you've screwed up. You put in objectives you didn't mean to, nobody asked if it was your final answer and you hit 'Add' anyway. But you can't sue NBC, instead you've got to settle with the New button, which resets the Objective List to nothing and the Goal Number to 0. Perhaps in a later version I'll allow you to delete objectives from the list instead of start all over again. Or maybe I'll put Regis in front of the Add button. 

--------------------------------------------------------
What To Do Once You've Got Your Objective List complete:
--------------------------------------------------------
Go to File, Save. Save your objective list wherever you wish. Open DromEd, and load the mission you want the objectives to be placed in. If you saved your objective list into your root Thief directory, type the following into the Dromed command box and hit enter:

run WhateverYouSavedItAs.cmd

This will automatically load all of your objectives into your mission. If you didn't save it into your Thief directory, you need to specify the path to the file with the 'run' Dromed command. Example:

run c:\windows\desktop\MyThiefObjectives\WhateverYouSavedItAs.cmd

Voila. Your mission now has objectives.

----------------
Version History:
----------------
1.02 -
	* Optimized the code
	* Fixed a bug with the Difficulty Levels that would result in broken objectives.
1.01 -
	* Fixed the error that made the GoalNumber box a wee little thing. Now both numbers can fit in there.
	* General bug-fixing.


1.00 - 
	The Beginning.

----------------------------------------------------------
All That Extra Stuff that Goes At the End of These Things:
----------------------------------------------------------
Thief Objective Wizard is (Copyright) ©2001 by Avalon (And don't think I can't prove that I'm him). All your Thief Objective Wizard copyright are belong to me.
Thanks go out to UnderTow, who found all the bugs (No, that one *isn't* a bug. It's a feature), and to d0om for willingly being my unwilling technical advisor. Oh yes, and UnderTow was in no way associated with the naming of this program.
If you have any comments, suggestions, death threats, love letters, you can reach me at sir_avalonian@hotmail.com , or find me 24-hours-a-day in the #dromed IRC channel on the StarChat network.
Useful links:

http://www.thief-thecircle.com/teg/  -- The Thief Editors' Guild. Uglier than sin now that they tore out our Hammerite theme, but still home.

http://www.ttlg.com/forums/cgi-bin/forumdisplay.cgi?action=topics&number=17&start=here -- It's been an odd neighbourhood since they let the ShockEdites in, but it's also home. Don't worry, they won't get near you if you have a stick.

http://www.3dactionplanet.com/thief/ -- They actually update more than once a decade, and could be the size of T-TC given time.

http://www.ttlg.com/fmp/default.asp -- The 'T2x: Shadows of the Metal Age' homepage. A great campaign, if I may say so...

http://members.nbci.com/dromed/ -- Avalon's Sanctum. That is, my site. It's a mess. Avoid the piles of rubble and feces and you should escape unharmed...

http://pub14.ezboard.com/bavalonssanctum -- The Avalon's Sanctum discussion forums. That is, my discussion forums. You can stare at locked forums and wonder what we do behind those closed doors.