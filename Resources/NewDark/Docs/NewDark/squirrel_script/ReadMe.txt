SQUIRREL.OSM ReadMe
===================

SQUIRREL.OSM provides the ability to write Dark Engine scripts using the Squirrel script language
(www.squirrel-lang.org, en.wikipedia.org/wiki/Squirrel_%28programming_language%29). Squirrel uses a C-like
syntax. This documentation will not cover the language itself, the Squirrel web site and google along with
the samples will have to suffice.

Script files are text files with Squirrel code, using a ".nut" file extension. A script file can contain
any number of script classes. The game will load all ".nut" files it find in "sq_scripts\" directories of
all mod paths and the FM or base path. The load order will be with the lowest priority path first
and highest last, so that the highest priority path has the final say. In the same fashion as DML files.
Like with DML files the FM or base path, depending on if an FM is active or not, is however loaded first.

As a script editor there are various general purpose editors that can be used, like Notepad++, adding a
plugin or keywords definitions to get proper squirrel syntax hilighting. Using JavaScript syntax hilighting
would probably also be passable. A user defined syntax highlight definition and auto-complete definition
for Notepad++ is included along with this documentation.

Script messages and errors will be output to mono. Squirrel "print()" output will also be seen in mono.
When running the game exe, where mono isn't available, all output is redirected to the log file instead.

Scripts are reloaded every time the OSM is reloaded. That happens each time you return to the editor from
game mode or load a mission. This means you can edit script and the changes will get applied on next OSM
reload, without having to restart the editor. From T2 v1.25 / SS2 2.46 there's also a "script_reload"
command that will force an instant reload. The command is primarily for use in edit mode, but could have
some limited use in game mode. You have to be aware that no "EndScript", "BeginScript" or "Sim" messages
will be sent to scripts before and after reload, which could put all scripts in some weird state, but if
what you're debugging isn't dependent on that it could still be useful.

While the performance of Squirrel probably isn't the best, as long as you don't do any heavy duty processing
looping over hundreds or thousands of things, or have thousands of script instances actively doing per-frame
updates then this shouldn't be an issue. The vast majority of script functionality is based on handling events
that only fire once in a blue moon or never at all, and once they do they usually only do a few things, like
set some property, send a message and things like that. That should never affect performance.


OSM Distribution
----------------

SQUIRREL.OSM is included and maintained as part of the dark package, which means that all users that keep
their game up-to-date will automatically have the latest version of the OSM available. It's therefore not
recommended to include the OSM file in FM packages, in the same fashion as original OSMs normally aren't
included either. To use the OSM in a mission you still have to load it like any other OSM in DromEd.


Creating a Script
-----------------

To create a script you derive a class from "SqRootScript", like so

	class MyScript extends SqRootScript
	{
	}

That is already a valid script and you could add "MyScript" to an object in the editor. The script won't do
anything of course, as it doesn't have any message handling yet.

It's fine to have several levels of inheritance, if you want to have script classes with shared functionality
from which you derive other script classes.

	class MyBaseScript extends SqRootScript
	{
	}

	class MyScript extends MyBaseScript
	{
	}

Aside from message handlers (see section below), you are free declare any member functions you want. Just avoid
having their names start with "On", as that should be reserved for message handlers. Otherwise if the function
was incidentally named as en existing message it could get called as a message handler.


Message Handling
----------------

As briefly mentioned in the introduction, the core of scripts is handling messages. A message handler is
a regular squirrel function with no arguments or return value, named after the message it handles and with
an "On" prefix. If you wanted to handle the "BeginScript" message you'd declare the function:

	class MyScript extends SqRootScript
	{
		function OnBeginScript()
		{
		}
	}

The current message can be accessed by calling "message()" from any message handler. That will return a
reference to a sScrMsg or a derived message class, depending on the message. See "API-reference_messages.txt".
The reference lists which messages have special message classes with additional data in them. If we take
the "Timer" message for example, the message type for the OnTimer handler would be sScrTimerMsg, which
has the additional data member "name" with the name of the timer.

	class MyScript extends SqRootScript
	{
		function On...()
		{
			...
			SetOneShotTimer("TestTimer", 5);
			...
		}

		function OnTimer()
		{
			if (message().name == "TestTimer")
			{
				...
			}
		}
	}

Because the message name is used as part of the squirrel function name, message names should adhere to the
rules of Squirrel naming. That is only contain alpha numeric characters or underscore (see Squirrel docs).
It is however still possible to declare handlers for messages with other characters in their name by replacing
those characters with underscore in the function name.

	class MyScript extends SqRootScript
	{
		// handle "J'Accuse" (but of course this would also catch a potential "J-Accuse", "J@Accuse" etc.)
		function OnJ_Accuse()
		{
			...
		}
	}

It's also possible to handle such a message using the generic message handler, "OnMessage". When available,
this will be called if a script doesn't have an explicit message handler for a message. This is slightly
less efficient and clean, so whenever possible use an explicit message handler.

	class MyScript extends SqRootScript
	{
		function OnMessage()
		{
			if ( MessageIs("Funky-Msg-Name") )
			{
				...
			}
		}
	}

Stim message names are based on the stim archetype name with a "Stimulus" suffix. If there's a stim archetype
named "FireStim" then the message handle for it would be:

	class MyScript extends SqRootScript
	{
		function OnFireStimStimulus()
		{
			...
		}
	}

If the stim name has non alpha-numeric characters then those have to be replaced with underscore in the handler
name, or the message has to be handled through OnMessage just as any other messages, as described above.

Message names in Dark are case insensitive, the correct handler function will be found even if there is a case
mismatch. It's however good practice to stick with one version of the names throughout the code. It's not
allowed to declare multiple handler functions for the same message, where the functions just differ by case.
Only one of the handlers will end up being used and the rest ignored.


What a script actually does in a message handler can be a variety of things. Look at the samples to
get an idea and browse through the API reference. Looking at other open source OSM code can also be
helpful even if that's written in C++. The principles are the same even if there are some slight
differences in naming any layout.


For very special cases, usually debugging, it is possible to declare a global catch-all message handler.
This is a function declared outside of any class:

	function PreFilterMessage(message)
	{
		// return 'true' if message should be intercepted and not sent to the target script instance
		return false;
	}

It will receive all messages sent to squirrel script instances. It even has the ability to prevent the
message from reaching the intended script instance by returning 'true'. Normally you don't want to use
or declare this function, but it could come in handy for tricky debugging cases.


Script Variables
----------------

While it is possible to declare regular member variables in the script classes, it's important to note that
script instances can be destroyed and recreated at any time. For persistent data you should use the Data
functions in SqRootScript (see "API-reference.txt"), SetData, GetData etc.. This is data that survives
a script reconstruct and is properly handled with savegames.


Debugging
---------

Debugging can be a bit tricky, keeping an eye on mono is a good start. The best way to do that is to run
in windowed mode so you can see both the game and the mono window. Also don't be afraid to make use of the
"print()" function in squirrel during development. That way you can easily keep track of when some handler
is called, what values things have etc.. When the script is done and working you can remove or comment out
the print() calls again.

One thing to remember about Squirrel is that while blatant syntax errors will be caught when a script is
loaded and you'll see error messages, other errors like misspelling of variable or function names, or using
wrong types or argument counts for functions, are run-time errors and won't cause an actual error until that
code executes. If you have conditional statements in your code it would be a good idea to make sure all code
paths have been tested to ensure that the code is working.


Custom Overlays
---------------

For details on the overlay script services see the documentation "doc\script\DarkOverlay.txt" for Thief
or "doc\script\ShockOverlay.txt" for SS2. The squirrel script implementation of the overlay handler
works pretty much the same as the C/C++ interfaces described in that documentation. To make a handler
you just derive a script class from IDarkOverlayHandler for Thief or IShockOverlayHandler for SS2.
The supported handler functions are shown below, they have the same arguments and return values as
the C/C++ counterpart.

There is one big difference however, and that is that script code can register multiple overlay handlers.
The overlay service has AddHandler/RemoveHandler functions, instead of SetHandler as the C counterpart.
The reason is to avoid conflicts if there a multiple mods active that contain squirrel scripts. It's
possible that two different mods might want to add overlay elements. Accidentally calling Add/RemoveHandler
multiple times won't cause any problems, the only thing to note is that the last added handler is always
moved up to highest priority.

Just like with regular SqRootScript derived scripts, you only have to declare the functions that you need
to implement custom functionality in. If you for example don't intend to have any code in DrawTOverlay()
then you're better off not declaring that function at all. Even a completely empty handler class is
a valid handler, that does nothing but it is valid.

	// Thief
	class MyOverlay extends IDarkOverlayHandler
	{
		function DrawHUD()
		{
		}

		function DrawTOverlay()
		{
		}

		function OnUIEnterMode()
		{
		}
	}

	// SS2
	class MyOverlay extends IShockOverlayHandler
	{
		function DrawHUD()
		{
		}

		function DrawTOverlay()
		{
		}

		function OnUIEnterMode()
		{
		}

		function CanEnableElement(which)
		{
			return true;
		}

		function IsMouseOver(x, y)
		{
			return false;
		}

		function MouseClick(x, y)
		{
			return false;
		}

		function MouseDblClick(x, y)
		{
			return false;
		}

		function MouseDragDrop(x, y, start_drag, cursor_mode)
		{
			return false;
		}
	}


Installing an overlay handler also works largely the same as the C/C++ samples, except that AddHandler
and RemoveHandler is used.

	// create a global instance of the overlay handler
	myOverlay <- MyOverlay();

	//
	// Script that installs and uninstalls the overlay handler
	// Add this script to one (dummy) object in the mission
	//
	class MyHudScript extends SqRootScript
	{
		function destructor()
		{
			// to be on the safe side make really sure the handler is removed when this script is destroyed
			// (calling RemoveHandler if it's already been removed is no problem)
			DarkOverlay.RemoveHandler(myOverlay);
		}

		function OnBeginScript()
		{
			DarkOverlay.AddHandler(myOverlay);
		}

		function OnEndScript()
		{
			DarkOverlay.RemoveHandler(myOverlay);
		}
	}
	
The above example is for Thief, replace "DarkOverlay" with "ShockOverlay" for SS2.


Script Destructor
-----------------

Squirrel has built-in reference counting and normally things will get cleaned up automatically. For other
game related cleanup there's the "EndScript" message. But should there for some reason or another be a
need for it, it's possible to declare an optional destructor which acts like a C++ destructor, it gets
called when the script instance is about to be deleted. Don't call any script services or engine functions
in this.

	class MyScript extends SqRootScript
	{
		function destructor()
		{
			...
		}
	}
