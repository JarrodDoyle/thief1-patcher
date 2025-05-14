Before using ObjTree you must have the game-specific data definitions in the 
same folder as the application. The file is named "structinfo.xml", and a 
version for Thief 2 is provided by default. You can change the definitions while 
ObjTree is with the "Load Struct Info" menu item. When you load new info, the 
existing definitions are not destroyed. If you want to forget the old 
definitions, hold down the SHIFT key while selecting the menu item.

So you open a gamesys file (.GAM) with ObjTree, and the object hierarchy shows 
up in the left-hand pane. All of the major categories are shown in a single 
view. ObjTree treats all types of objects the same. It won't stop you from 
moving any type of object to any other category. But that's something you may 
want to do if, for instance, you have texture objects in the "Missing" branch.

Most commands are in the "Object" menu. Only the "Find Object" search can be 
used, though. The two items: "Add Object" and "Delete Object" will change to 
reflect the editing context. They are also used to add and remove properties, 
links, meta-properties, etc.

The "View Chunks" item lets you edit some of the global gamesys data, as long as 
the necessary structures are defined. "Import Objects" will create new objects 
from a file. This feature is very limited, however.

There is an undo option, and it usually works.

Edit an object by double-clicking on it. An object editor window is created (or 
made visible, if the object had already been opened) and the property list is 
shown. You can have any number of object editors open at a time. The property 
list will always show at least two properties: "DonorType" and "SymbolicName". 
These properties aren't shown in DromEd. DonorType should be 1 for meta- 
properties, and 0 for any other object. The symbolic name is just the object's 
name.

Data in the property list can be edited by double-clicking on the property name. 
If a property is made up of many fields, then the fields are shown on separate 
lines in the property list and each field can be edited individually.

Property data is modified in the edit-line at the top of the window. Type the 
new data in the edit-line and press ENTER or click the blue button to change the 
property. Press ESCAPE or click the red button to leave the property unchanged.

Some data is stored as a number, but uses named flags to represent the value. An 
enumeration can have one value chosen from a list. Properties of this type 
display a drop-down list with the available names. Bitfields can have more than 
one value combined together. These properties use a pop-up menu with the names. 
In both cases, you can ignore the names altogether and type a number in 
directly.

The names of properties and associated data depend on the structure definitions. 
If the required information for a property isn't available, then you'll only see 
the internal property name and won't be able to edit it.

Click on the header buttons to change the object editor's view. Meta-properties, 
links, stim sources, and receptrons (which are all types of links) are shown as 
lists. Edit a link by double-clicking on it. A link editor sub-window is 
displayed showing a property list for the link data. Link editors are tool 
windows, and you can have any number of them open for one object. But if you 
change to another object editor, they'll be hidden.

Link editors are like the property editor, except you can also modify the 
destination of the links, as well as the data fields. The link destination, 
meta-property name, stimulus, or receptron is an object. You can type the name 
of the object, or just its ID number to change it. The source of a link can't be 
changed this way.

Meta-properties have a priority associated with them. Those with a higher 
priority will be checked before lower ones. A priority of 0 is used for the 
relation between an object and its parents. Usually, meta-properties start at 
1024 and increase in increments of 8.

The "Import Objects" command reads object descriptions from an XML file. The 
format, called GMVL, is currently incomplete, but has enough to create or modify 
objects, properties, and create new meta-properties and links. Importing 
properties or links with data requires the structure definitions.

A GMVL file must be well-formed XML. This is an example of a simple file:

<?xml version="1.0" encoding="ISO-8859-1"?>
<gmvl version="0.9">
  <object base="Marker" name="NewPt" type="abstract">
    <property name="DesignNot">
      <field name="" value="Simple types don't need a name." />
    </property>
    <property name="AICoverPt">
      <field name="value" value="10" />
    </property>
    <metaprop name="M-NoteToScripts" priority="1024" />
  </object>
  <link flavor="AIDefendObj" src="NewPt" dest="NewPt">
    <field name="range/0/radius" value="8" />
    <field name="range/1/radius" value="12" />
    <field name="range/2/radius" value="20" />
  </link>
</gmvl>

The "version" attribute is required on the "gmvl" tag.

The "object" tag must have "name" and "base". ObjTree only recognizes abstract 
types. The attribute is technically optional, but it should always be used since 
a future version of the schema will likely use "concrete" as the default.

If an object with the same name already exists, it will be modified, including 
changing its parent to the new base.

The property name is the internal name, not the label that is shown in the 
property editor. Look-up the correct name in the structinfo.xml file. You don't 
have to use all of the fields of a property. Special characters (which includes 
'/' and '\' in property names) must be escaped using '%xx', substituting the 
ASCII hex code for the character.

The "priority" attribute for meta-properties is optional.

Links are created separate from objects, and can reference any object, not just 
those defined in the file. A link definition must come after the definitions of 
objects that it references.
