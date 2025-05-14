///PRISONER 1 BROADCASTS -Geoff Stewart

//AT ALERT LEVEL 0
schema pr1a0
archetype AI_NONE
mono_loop 8000 20000
volume -500
pr1a0mu1 pr1a0mu2 pr1a0mu3
pr1a0wh1 pr1a0wh2 pr1a0wh3
schema_voice pris1 1 atlevelzero

schema pr1a0hu
archetype AI_NONE
mono_loop 8000 20000
volume -500
pr1a0hu1 pr1a0hu2 pr1a0hu3
pr1a0la1 pr1a0la2 pr1a0la3
schema_voice pris1 1 atlevelzero
schema_voice pris1 1 atlevelone
schema_voice pris1 1 atleveltwo
schema_voice pris1 1 atlevelthree

//TO ALERT LEVEL 1
schema pr1a1
archetype AI_NONE
pr1a1__1 pr1a1__2 
schema_voice pris1 1 tolevelone

//TO ALERT LEVEL 2
schema pr1a2
archetype AI_MINOR
pr1a2__1 pr1a2__2 
schema_voice pris1 1 toleveltwo

//TO ALERT LEVEL 3 -spotted the player
schema PR1a3
archetype AI_MAJOR
pr1a3__1 pr1a3__2 pr1a3__3 
schema_voice pris1 1 spotplayer
schema_voice pris1 1 tolevelthree

//BACK TO ZERO from AL1 or 2
schema pr1bak
archetype AI_NONE
pr1bak_1 pr1bak_2
schema_voice pris1 1 backtozero
schema_voice pris1 1 lostcontact

//Injured yelps
schema PR1hhi
archetype AI_MINOR
pr1hhi_1 pr1hhi_2
schema_voice pris1 1 comhithigh
schema_voice pris1 1 comhitamb

//Injured yelps
schema PR1hlo
archetype AI_MINOR
pr1hlo_1 pr1hlo_2
schema_voice pris1 1 comhitlow

//Death cries
schema PR1die
archetype AI_MAJOR
pr1diea1 pr1diec1
schema_voice pris1 1 comdieloud
schema_voice pris1 1 comdiesoft