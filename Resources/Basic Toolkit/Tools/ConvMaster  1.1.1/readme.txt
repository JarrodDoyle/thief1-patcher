ConvMaster 1.1.1 by R Soul

Testing and suggestions by LarryG

*** Introduction ***
The Thief NewDark patch gives us the ability to store object properties in text files (with the DML extension). ConvMaster makes use of this feature to create/modify the Conversation property. The program's interface makes it easy to rearrange actions and steps. Individual actions or entire steps can be cleared, cut, copied and pasted.

Existing conversations can be loaded so you can edit them without having to start from scratch.

*** Installation ***
ConvMaster.exe can go anywhere. There are no special requirements.

*** Using ConvMaster ***

Most of the controls are self explanatory.

** Modifying an Existing Conv. **

1) Export the conv property from Dromed
Properties can only be exported from archetypes, not concrete objects.
Select your conversation object, go to the properties, select Conversation and then Copy.
Go to the object hierarchy, edit any archetype, and select Paste.
Go back to the hierarchy and click on Export, and Export Single as DML.

2) Load into ConvMaster
When you run ConvMaster, you can load the DML from the file menu. This will contain all the archetype's properties, but ConvMaster should ingore them and find the conversation.

3) Change the object name/ID
There's a text field at the top that should have the name/ID of the conv object. You should change this to match your concrete object.

4) Edit things
Now you can start moving things around, adding/removing actions or complete steps as required. 

You can right click on an action to get a menu allowing clearing, cutting, copying and pasting. You can choose the specific action or the entire step. You can also right click on the Step # label at the top to get the latter set of features.

Moving an action up/down swaps it with the one above/below. Similarly, moving a step left/right swaps it with the one next to it.

The Tools menu contains a tool that swaps two actions/steps even when they're not next to each other.

5) Undo
Ctrl Z will undo the last action. If you type in some text, it will be undone letter by letter. Pasted text will be undone in one go. When steps/actions are moved, undo will work on each input field one at a time.

6) Shortcut keys and scrolling to steps
Use Ctrl and any number to scroll to that step (e.g. Ctrl 5). You can scroll to step 10 with Ctrl T, and the abort steps with Ctrl A.
You can go to Tools > Scroll to Step and enter a step number.

7) Window > New ConvMaster Instance
If your conv is so long it requires more than one object (i.e. more than 10 steps) you can use this to quickly bring up a new window. When you have cut or copied a step/action, you can paste it into any other window, ***but only while the 'source window' is still open***. The 'source window' is the one from which the step/action was cut or copied from.

8) Loading in to Dromed.
Load your mission.
If you have a 'Load DbMod' item in the File menu, use that. If not, use the dbmod_load command.
Selecting the dml file should update your conversation object (if you remembered to correctly enter the object name/ID in ConvMaster).

** Creating a New Conv **
The same as the above steps from 3 onwards.

*** Bear Icon? ***

For many of us, the first conversation we set up was a copy of Thief 1's bear pits conv, so I thought a bear would be a good icon.

*** Changes ***
1.1.1
Fixed scrolling bug (only partial steps would be shown when step number was on the right).
Changed Alt shortcuts back to Ctrl - Alt cuased a scrolling bug.
Removed Ctrl S for 'scroll to selected step number' - conflicts with Ctrl S for 'save'.

1.1
Added comments for each step.
Added an undo function.
Changed original shortcut 'modifier' keys from Ctrl to Alt.
Most menu items now of Ctrl shortcuts.

1.0
Release!