//WORKER BOT BROADCASTS 

//----------------------------------------------------

schema rb1a0			//AT ALERT 0
archetype AI_NONE
mono_loop 15000 20000
volume -200
no_repeat
rb1a0nz1 rb1a0nz2 rb1a0nz3 rb1a0nz4 rb1a0nz5 rb1a0nz6 rb1a0nz7
rb1a0_01 rb1a0_02 rb1a0_03 rb1a0_04 rb1a0_05 rb1a0_06 rb1a0_07 rb1a0_08 rb1a0_09 rb1a0_10 rb1a0_11 rb1a0_12 rb1a0_13 
schema_voice vworkerbot 1 atlevelzero
schema_voice vworkerbot 1 atlevelone


//----------------------------------------------------

schema rb1a1			//TO ALERT 1
archetype AI_NONE
volume -1
rb1a1__1 rb1a1__2 rb1a1__3
schema_voice vworkerbot 1 tolevelone  

schema rb1a1v			//TO ALERT 1 +sighted
archetype AI_NONE
volume -1
rb1a1v_1 rb1a1v_2
schema_voice vworkerbot 1 tolevelone (Sense Sight)

schema rb1a1h			//TO ALERT 1 +heard
archetype AI_NONE
volume -1
rb1a1h_1 rb1a1h_2
schema_voice vworkerbot 2 tolevelone (Sense Sound)

schema rb1a1_w			//TO ALERT 1 +w/co
archetype AI_MINOR
volume -1
rb1a1_w1
schema_voice vworkerbot 2 tolevelone (NearbyFriends 0 20)

schema rb1a1vw			//TO ALERT 1 +sighted +w/co
archetype AI_MINOR
volume -1
rb1a1vw1
schema_voice vworkerbot 3 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema rb1a1hw			//TO ALERT 1 +heard +w/co
archetype AI_MINOR
volume -1
rb1a1hw1
schema_voice vworkerbot 3 tolevelone (Sense Sound) (NearbyFriends 0 20)


//----------------------------------------------------

schema rb1a2			//TO ALERT 2
archetype AI_MINOR
volume -1
rb1a2__1 
schema_voice vworkerbot 1 toleveltwo  

schema rb1a2v			//TO ALERT 2 +sighted
archetype AI_MINOR
volume -1
rb1a2v_1
schema_voice vworkerbot 1 toleveltwo (Sense Sight)  

schema rb1a2h			//TO ALERT 2 +heard
archetype AI_MINOR
volume -1
rb1a2h_1
schema_voice vworkerbot 2 toleveltwo (Sense Sound)

//----------------------------------------------------

schema rb1a3s			//SPOTTED THE PLAYER
archetype AI_MORE_MAJOR
volume -1
rb1a3s_1 rb1a3s_2 rb1a3na1 
schema_voice vworkerbot 1 spotplayer 
schema_voice vworkerbot 1 tolevelthree

schema rb1telr			//SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
volume -1
rb1telr1
schema_voice vworkerbot 5 spotplayer (NearbyFriends 0 20)
schema_voice vworkerbot 1 reacttellrev

schema rb1a3b			//SPOTTED THE PLAYER +body
archetype AI_MORE_MAJOR
volume -1
rb1a3b_1
schema_voice vworkerbot 9 spotplayer (CarryBody True)

schema rb1telc			//RE-SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
volume -1
rb1telc1
schema_voice vworkerbot 5 spotplayer (NearbyFriends 0 20) (Reacquire true)
schema_voice vworkerbot 1 reacttellconf

//----------------------------------------------------

schema rb1at1			//AT ALERT 1 & 2
archetype AI_NONE
volume -200
mono_loop 1000 5000
rb1a0nz1 rb1a0nz2 rb1a0nz3 rb1a0nz4 rb1a0nz5 rb1a0nz6 rb1a0nz7
schema_voice vworkerbot 1 atleveltwo
schema_voice vworkerbot 1 atlevelthree

schema rb1at2			//AT ALERT 2 & 3 +Investigating
archetype AI_MINOR
volume -1
delay 6000
mono_loop 7500 15000
no_repeat
rb1a2se1 rb1a2se2 rb1a3se1
schema_voice vworkerbot 99 atleveltwo (Investigate True)
schema_voice vworkerbot 99 atlevelthree (Investigate True)

//----------------------------------------------------

schema rb1alma			//REACT I SOUND THE ALARMS
archetype AI_MORE_MAJOR
volume -1
rb1alma1
schema_voice vworkerbot 1 reactalarm
schema_voice vworkerbot 1 reactrun 

//----------------------------------------------------

schema rb1bak			//BACK TO ALERT 0
archetype AI_NONE
volume -1
rb1bak_1 rb1bak_2
schema_voice vworkerbot 1 backtozero  

schema rb1los			//LOST CONTACT W/PLAYER
archetype AI_NONE
volume -1
rb1los_1 rb1los_2 
schema_voice vworkerbot 1 lostcontact  

schema rb1frust			//FRUSTRATION
archetype AI_MAJOR
volume -1
rb1frus1 rb1frus2 
schema_voice vworkerbot 1 outofreach 

//----------------------------------------------------

schema rb1bod			//FOUND BODY	
archetype AI_MORE_MAJOR
volume -1
rb1bod_1
schema_voice vworkerbot 1 foundbody  
schema_voice vworkerbot 1 foundrobot

schema rb1mis			//FOUND SOMETHING MISSING
archetype AI_MAJOR
volume -1
rb1mis_1
schema_voice vworkerbot 1 foundmissing
schema_voice vworkerbot 1 notice (Item MissingLoot)

schema rb1sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
volume -1
rb1sma_1 rb1sma_2
schema_voice vworkerbot 1 foundsmall  
schema_voice vworkerbot 1 notice (Item Door Generic)

schema rb1lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
volume -1
rb1lar_1
schema_voice vworkerbot 1 foundlarge

schema rb1sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
volume -1
rb1sec_1
schema_voice vworkerbot 1 foundbreach

//----------------------------------------------------

schema rb1rint			//RECENTLY SAW THE PLAYER +w/co
archetype AI_INFORM
volume -1
rb1rint1 
schema_voice vworkerbot 1 recentintruder 

schema rb1rbod			//RECENTLY FOUND BODY +w/co
archetype AI_INFORM
volume -1
rb1rbod1
schema_voice vworkerbot 1 recentbody 
schema_voice vworkerbot 1 recentrobot 

schema rb1rmis			//RECENTLY FOUND MISSING +w/co
archetype AI_INFORM
volume -1
rb1rmis1
schema_voice vworkerbot 1 recentmissing 

schema rb1roth			//RECENTLY FOUND MISC ANAMOLY +w/co
archetype AI_INFORM
volume -1
rb1roth1
schema_voice vworkerbot 1 recentother 

//----------------------------------------------------



schema rb1hhi			//HIT BY PLAYER W/HI HIT PTS 
archetype AI_MAJOR
volume -1
rb1hhi_1 rb1hhi_2 rb1hhi_3
schema_voice vworkerbot 1 comhithigh

schema rb1hlo			//HIT BY PLAYER W/LO PTS 
archetype AI_MORE_MAJOR
volume -1
rb1hlo_1 rb1hlo_2 rb1hlo_3 rb1hlo_4
schema_voice vworkerbot 1 comhitlow

schema rb1hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
volume -1
rb1hlow1
schema_voice vworkerbot 1 comhitlow (NearbyFriends 0 20)

schema rb1hnd			//HIT BY PLAYER NO DAMAGE +Winning
archetype AI_MAJOR
volume -1
rb1hnd_1
schema_voice vworkerbot 1 comhitnodam 


//----------------------------------------------------

schema rb1amb 		//AMBUSHED
archetype AI_MAJOR 
volume -1
rb1amb_1 
schema_voice vworkerbot 1 comhitamb

schema rb1ambw		//AMBUSHED +w/co
archetype AI_COMBAT
volume -1
rb1ambw1
schema_voice vworkerbot 2 comhitamb (NearbyFriends 0 20)

schema rb1die		//DEATH
archetype AI_MINOR
volume -1
rb1die_1 rb1die_2 rb1die_3
env_tag (event Death) (CreatureType WorkerBot)




//----------------------------------------------------
//----------------------------------------------------
