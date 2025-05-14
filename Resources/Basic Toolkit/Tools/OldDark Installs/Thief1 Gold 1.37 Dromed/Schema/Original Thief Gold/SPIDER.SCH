//SPIDER SPEECH

//AT ALERT LEVEL ZERO
schema sp1a0
archetype AI_NONE
mono_loop 1000 20000
volume -1500
sp1a0__1 sp1a0__2 sp1a0__3 sp1a0__4
schema_voice vspider 1 atlevelzero
schema_voice vspider 1 atlevelone 
schema_voice vspider 1 atleveltwo 

//TO ALERT LEVEL ONE & TWO
schema sp1to1
archetype AI_NONE
volume -1000
sp1to1_1
schema_voice vspider 1 tolevelone
schema_voice vspider 1 toleveltwo

//AT ALERT LEVEL ONE & TWO
schema sp1a1
archetype AI_NONE
mono_loop 100 8000
volume -1200
sp1a1__1 sp1a1__2 sp1a1__3 sp1a1__4
schema_voice vspider 9 atlevelone (Investigate True)
schema_voice vspider 9 atleveltwo (Investigate True)

//TO ALERT LEVEL THREE
schema sp1to3
archetype AI_NONE
volume -750
sp1to3_1
schema_voice vspider 1 spotplayer
schema_voice vspider 1 tolevelthree
schema_voice vspider 1 reactcharge


//REACT CHARGE
schema sp1a3
archetype AI_NONE
poly_loop 2 2000 8000
volume -1200
sp1a3__1 sp1a3__2 sp1a3__3
schema_voice vspider 1 atlevelthree 


//BACK TO ZERO & LOST CONTACT
schema sp1bak
archetype AI_NONE
volume -1000
sp1bak_1
schema_voice vspider 1 backtozero
schema_voice vspider 1 lostcontact


//COMBAT ATTACK
schema sp1att
archetype AI_NONE
volume -100
sp1att_1 sp1att_2 sp1att_3 sp1att_4
schema_voice vspider 1 comattack

//HIT BY PLAYER W/HI PTS
schema sp1hhi
archetype AI_NONE
volume -100
sp1hhi_1 sp1hhi_2
schema_voice vspider 1 comhithigh
schema_voice vspider 1 comhitamb

//HIT BY PLAYER w/LO PTS
schema sp1hlo
archetype AI_NONE
volume -100
sp1hlo_1
schema_voice vspider 1 comhitlow

//DEATH
schema sp1die
archetype AI_NONE
volume -500
sp1die_1
schema_voice vspider 1 comdieloud
schema_voice vspider 1 comdiesoft









