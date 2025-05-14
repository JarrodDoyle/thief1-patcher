What is this?

SPEECH.SPC and ENVSOUND.SPC are two schema files that were not included in
SCHEMAS.ZIP on the Thief Gold CD.

Unzip SCHEMAS.ZIP to a folder called "schema" under Thief, and add these
two files. (The folder is unimportant if you only want to browse them for
info, but it is important for running DromEd commands that access these
files.)

There is currently no documentation for these files (or the ones in
SCHEMAS.ZIP for that matter) but here's what I know:

When you run the DromEd command "reload_schemas", DromEd processes schema
files in this order.

schemas\*.spc
schemas\*.arc
schemas\*.sch

These are all the same format, but the different extensions indicates what
order they should be loaded. In other words, stuff in *.sch (schemas)
depends on stuff defined in *.arc (archetypes) which may depend on stuff
in *.spc (speech? just guessing.)

Without these two files "reload_schemas" crashes DromEd with an error about
a non-existent voice.

Thanks to Tim Stellmach (EvilSpirit) of LGS for providing these files.
Here's his reply to my question about distributing these files:

[Datoyminaytah]
>> May I assume these are OK to distribute to other Thief editors? If so
>> I'll get them to Digital Nightfall.

[EvilSpirit]
>Really, we meant to include all that in the Thief Gold dromed release and   
>I believe those files just accidentally didn't get in because of the   
>different extension.  I can't imagine anyone will mind.

Wes Morrison
(Datoyminaytah)
