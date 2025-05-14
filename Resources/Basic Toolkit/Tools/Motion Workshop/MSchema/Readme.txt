About the Motion Schemas;

There is so much I'm still unsure about, so things are going to look artificial
for a while. I've dumped out the schemas in what appears to be the order they
were read in. So things are separated which probably shouldn't be, etc. I don't
know how much the order of reading the schemas in will affect things. And I don't
know if the motion Hierarchy needs to be very similar to the original, or if any
consistant Hierarchy will work.

Things things will be answered over the next few weeks.

There are two kinds of files in the motion schema. .moc and .mos

The .moc files are similar to the .SPC files in the sound schemas, they define
concepts. In the case of .MOC files, they define MotionGroups, MotionTags, and
Torsos.

The .MOS files define the motion schema, where they belong in the hierarchy, and
which motion files get used to create the motion.

.MOC Files;
The 3 critical files here lay out the way the motions are linked into the engine.
First, the Groups.moc file defines the kind of motions that exist, like GroundAction,
GroundLocoPair, and PlayerSword. I suspect the order of these is important to
the Dark Engine, so don't change this unless you really believe you know what you
are doing.

Next, the Torso.moc file defines which slot the different kinds of motions belong
to. For example, all Biped motions ( Human, Crayman, BugDemon, etc ) fall under
torso group 0. Spiders (and mech spiders) are under torso group 4. All similar
motions better belong to the correct torso group, or the Dark Engine will probably
hurt you. I don't know if the order of these is important, it does seem to change
slightly between Thief 1, Thief 2, and SS2.

Finally, the Tags.moc file. If you are going to use a tag, it must be defined
here. It's just the keyword (Conv), the number can be different and is defined
in the schemas. You will probably notice there are a bunch of unused tags in T2,
I'll see if I can remove them later on. You will notice there are two numbers
which follow each tag. I have no idea what they are for (although the first one
being a 1 usually indicates its an important primary part of the Hierarchy). If
you create a new tag, try and pick numbers from a similar tag.

.MOS files
These define the schemas, and is where most of the work is.

There is one critical keyword which must be present in the first few lines,
before any schemas are define. It's "torso", and it must have following it a
valid (i.e. previously defined in Torso.moc) torso name.

Another keyword, which is optional is "global". This adds whatever follows to any
schema name defined in the file. It's just an option to improve readability, so
you don't have to have the same text in each schema. For example, under Bot.mos,
the global is defined as "Droid 0", so you don't have to add it to every schema
line.

The MType line defines what kind of motion this is, as far as the engine is
concerned. There does seem to be confusion between GroundAction and
StandWith90s, but the rest of them seem to match up fairly well.

The TimeScale value seems to work like the Creature -> Time Warp in Dromed. Zero
is the default speed. Making it less than 1 will speed up the motion, making it
greater than 1 slows it down.

Similarly, the XYZScale seems to make the motions 'bigger' or 'smaller'. Raising
this value above 1 makes the motion more exaggerated, while reducing it makes it
more subtle. Zero uses the default size.

After each motion name (in the first entry of bot.mos, it's "mbtstd"), there are
two numbers. I've spend several weeks trying to figure out what they are and
where they come from. No luck! So, instead of waiting forever while I figure it
out, I just put the burden on you to make up something. Using 0 500 should work
for most anything. If it doesn't, we'll mess with it until it does. The 500 seems
to be a default speed of playing the motion. Turning it up high seems to make
the motions slower, so we can play with that and see if it's true.



