GoalMaster 1.0 by R Soul

**** Introduction ****
Goals in Dromed can be set up with various commands (e.g. quest_create_mis goal_visible_3, 1). This is very tedious, and error prone, so many years ago William The Taffer realsed Thief Objective Wizard, which uses an easy-to-use GUI program to save the commands in a text file (.cmd) that Dromed can run.

GoalMaster takes this idea even further. As well as generating the .cmd file, it also generates goals.str. For each goal you can enter in the 'fiction' and 'text' strings. You can also set the mission number so goals.str is placed in the correct folder.

A further improvement is the ability to modify goals after they've been created. The list of goals can also be saved in the program's native format (which uses a .gml extension) so they can be saved, reloaded and edited.

**** Installation ****
Extract GoalMaster.exe and dirs.txt to any folder, and it will be ready to run.

dirs.txt MUST be edited so GoalMaster can find your Thief2 folder. The file can be opened directly from GoalMaster via the Tools menu.

**** Instructions ****

On the left is the current Goal List. 
Above and on the right is the mission number, which should match the value in Dromed's 'Dark Mission Description' property.

On the right, the Goal Number menu tells you which goal you're currently editing.
Fiction is the text you see while choosing your difficulty level.
Text is the text you see during the mission.
Summary is an optional field which is only used by GoalMaster.

The Goal List will try to display the summary. If that is blank, or it says (Optional), it will try to display the Text. If that's blank, it will try to display the Fiction.
If that is also blank, it will simply display 'Goal: X'.

The purpose of the summary is to allow you to be more precise (e.g. "Steal object 1251, Hard only) without affecting the Fiction or Text values.

At first, the only available goal number is 0.

** Setting up a goal **
This is the simplest part. Choose whatever values apply to the first goal (0). The original Dromed tutorial/Komag's tutorial explains these values.

For the Type, select 'No Type' if the objective's state will be managed by a QuestVarTrap in Dromed.

** Buttons **
Update List adds the current goal to the Goal List. If there's already a goal with the selcted goal number, you'll be asked if you want to overwrite.

Each time you update, GoalMaster will take you to the next goal to be added. E.g. if the last goal in the list is goal 5, GM will set up an empty goal 6.

Reset Target fields resets the values of the selected Type to the default value. This can be useful if you've previously set a complicated loot goal with gold, gems and goods, and now want another loot goal with a simple loot value.

Reset All Variables does exactly that - sets all values to their defaults. This will uncheck all of the 'Other' flags, reset difficulty etc.

** Updating an exisitng goal **

If a goal is in the Goal List and needs to be updated, just click on it and its values will be shown on the right. Edit them and click on Update List.
You can also update a goal by changing the Goal Number from the menu at the top.

** Re-ordering and deleting goals **

Select a goal from the list and the Up/Down buttons can rearrange them.

When a goal is deleted, any goals that came after it will have their numbers reset. The Dark Engine does not allow goal numbers to be skipped. If you want to disable a goal, just make it invisible.

**** Saving and Exporting ****

If you go to File > Save, all the goal data are saved in the program's own format, i.e. the goal list, the text values and the mission number. You can reload the file and continue making changes. This has no effect on your FM's goals or .cmd files.

File > Export gives you the option of generating the .cmd and or goals.str files. The Export window shows you what files will be created. You can change the paths by going back to the main window and going to Tools > Open "dirs.txt". If you edit the file you don't have to restart the program.

**** Languages ****
dirs.txt gives you the option to type in a language folder name. The author has briefly tested it with some German characters and it looks okay, but futher testing is required.

**** Dromed ****
If the export setting were correct, the objective text will already be in place.

Make sure your Editors > Mission Variables > Dark Mission Description is set up.

Run the .cmd file that GoalMaster generated, and you should then be able to see your objectives.

********** It may be necessary to delete old objective data before you run GoalMaster's .cmd file. Many packages, e.g. the Dromed Toolkit/Tafferpather, include a 'nogoals.cmd' file.

**** Extra thing *****
If you run GoalMaster with a single parameter, a number, the program will use that as your mission number.

Robin Collier, 2015