//TREEBEAST 1 BROADCASTS

//TREEBEAST ARM SWING
schema tb1swing
archetype DEVICE_MISC
no_repeat
delay 100
volume -1
tbswing1 tbswing2 tbswing3 tbswing4 tbswing5
env_tag (Event WeaponSwing) (CreatureType TreeBeast)

//----------------------------------------------------

schema tb1a0			//AT ALERT 0
archetype AI_NONE
volume -500
poly_loop 2 4000 8000
tb1rat01 tb1rat02 tb1rat03 tb1rat04 tb1rat05 tb1rat06 tb1rat07 tb1rat08 tb1rat09 tb1rat10 tb1rat11 tb1rat12 tb1rat13
schema_voice vtree 1 atlevelzero

schema tb1a1			//TO ALERT 1
archetype AI_NONE
tb1a1__1 tb1a1__2 tb1a1__3
schema_voice vtree 1 tolevelone  
schema_voice vtree 1 backtozero  
schema_voice vtree 1 lostcontact 
schema_voice vtree 1 comhitnodam 

schema tb1a2			//TO ALERT 2
archetype AI_MINOR
tb1a2__1 tb1a2__2 tb1a2__3 tb1a2__4 tb1a2__5
schema_voice vtree 1 toleveltwo  
schema_voice vtree 1 tolevelthree
schema_voice vtree 1 spotplayer 

//----------------------------------------------------

schema tb1at1			//AT ALERT 1 & 2
archetype AI_NONE
delay 3000
volume -500
mono_loop 500 5000
tb1a0__1 tb1a0__2 tb1a0__3 tb1a0__4 tb1a0__5 tb1a0__6 tb1a0__7 tb1a0__8
schema_voice vtree 1 atlevelone  
schema_voice vtree 1 atleveltwo

schema tb1at2			//AT ALERT 2 & 3 +Investigating
archetype AI_MINOR
delay 6000
mono_loop 500 6000
tb1a2__1 tb1a2__2 tb1a2__3 tb1a2__4 tb1a2__5
schema_voice vtree 99 atleveltwo (Investigate True)
schema_voice vtree 99 atlevelthree (Investigate True)

//----------------------------------------------------




//COMBAT
schema tb1atn			//ATTACKING
archetype AI_COMBAT
tb1atk_1 tb1atk_2 tb1atk_3 tb1atk_4 tb1atk_5 tb1atk_6 tb1atk_7 tb1atk_8
schema_voice vtree 1 comattack
schema_voice vtree 1 reactcharge
schema_voice vtree 1 outofreach

schema tb1hhi			//HIT BY PLAYER W/HI HIT PTS 
archetype AI_MAJOR
tb1hhi_1 tb1hhi_2 tb1hhi_3
schema_voice vtree 1 comhithigh
schema_voice vtree 1 comhitlow
schema_voice vtree 1 comhitamb

schema tb1die		//DEATH
archetype AI_MINOR
tb1die_1 tb1die_2
schema_voice vtree 1 comdiesoft
schema_voice vtree 1 comdieloud

//----------------------------------------------------
//----------------------------------------------------

