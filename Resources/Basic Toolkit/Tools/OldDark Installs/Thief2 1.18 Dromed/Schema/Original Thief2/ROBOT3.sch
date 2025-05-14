
//---------------------------------------------------------------
//ROBOT 3 -SPIDER BOT

//TO ALERT 1 & 2
schema rb3a1
archetype AI_NONE
volume -1
rb3a1__1
schema_voice vspiderbot 1 tolevelone
schema_voice vspiderbot 1 toleveltwo

//TO ALERT 3
schema rb3a3
archetype AI_NONE
volume -1
rb3a3__1
schema_voice vspiderbot 1 tolevelthree
schema_voice vspiderbot 1 spotplayer

//AT ALERT 3 SEARCHING
schema rb3a3se
archetype AI_NONE
volume -1
mono_loop 10000 15000
rb3a3se1 rb3a3se2
schema_voice vspiderbot 1 atleveltwo (Investigate True)
schema_voice vspiderbot 1 atlevelthree (Investigate True)

//BACK TO ZERO
schema rb3bak
archetype AI_NONE
volume -1
rb3bak_1
schema_voice vspiderbot 1 backtozero 
schema_voice vspiderbot 1 lostcontact 

//ATTACKING
schema rb3ats
archetype AI_NONE
volume -1
rb3ats_1 rb3ats_2
schema_voice vspiderbot 1 reactcharge
schema_voice vspiderbot 1 reactshoot 
schema_voice vspiderbot 1 comattack 

//DEATH
schema rb3death
archetype AI_NONE
rb3death
env_tag (event Death) (CreatureType SpiderBot)

//---------------------------------------------------------------

//SCURRY BOT 

schema scurry_loop		//<--AmbientHacked R=20, NoSharpCurve
archetype AI_NONE
mono_loop 0 0
volume -100
scurry

//DEATH
schema scurry_death
archetype AI_NONE
scurdie1
env_tag (event Death) (CreatureType ScurryBot)

//---------------------------------------------------------------

//MECHANICAL CHERUB

//ALL ALERT LEVELS
schema mcha0
archetype AI_NONE
volume -500
no_repeat
mono_loop 2000 20000
cerub1 cerub2 cerub3 cerub4 cerub5 cerub6 cerub7 cerub8
schema_voice vcherub 1 atlevelzero
schema_voice vcherub 1 atlevelone
schema_voice vcherub 1 atleveltwo
schema_voice vcherub 1 atlevelthree
schema_voice vcherub 1 tolevelone
schema_voice vcherub 1 toleveltwo
schema_voice vcherub 1 tolevelthree
schema_voice vcherub 1 spotplayer
schema_voice vcherub 1 reactrun

schema mch_loop
archetype AI_NONE
volume -1500
mono_loop 0 0
cerubl

//---------------------------------------------------------------
//---------------------------------------------------------------

