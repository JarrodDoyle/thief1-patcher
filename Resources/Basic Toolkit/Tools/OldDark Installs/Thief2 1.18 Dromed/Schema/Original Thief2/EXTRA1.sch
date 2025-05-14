//EXTRA 1 BROADCASTS 

//----------------------------------------------------

schema ex1a0sn			//SLEEPING
archetype AI_NONE
volume -500
mono_loop 2000 3000
ex1a0sn1 ex1a0sn2 ex1a0sn3 ex1a0sn4 ex1a0sn5 ex1a0sn6
schema_voice vextra1 1 sleeping

schema ex1a0			//COUGHING & HUMMING
archetype AI_NONE
delay 2000
stream
volume -500
mono_loop 7500 15000
ex1a0co1 ex1a0co2 ex1a0co3 ex1a0co4 ex1a0co5
ex1a0hu1 ex1a0hu2 ex1a0hu3 ex1a0hu4 
ex1a0wh1 ex1a0wh2 ex1a0wh3 ex1a0wh4 ex1a0wh5
schema_voice vextra1 1 atlevelzero


//----------------------------------------------------

schema ex1a1			//TO ALERT 1
archetype AI_NONE
ex1a1__1 ex1a1__2 ex1a1__3 ex1a1__4 
schema_voice vextra1 1 tolevelone  

schema ex1a1v			//TO ALERT 1 +sighted
archetype AI_NONE
ex1a1v_1 ex1a1v_2
schema_voice vextra1 1 tolevelone (Sense Sight)

schema ex1a1h			//TO ALERT 1 +heard
archetype AI_NONE
ex1a1h_1 ex1a1h_2
schema_voice vextra1 2 tolevelone (Sense Sound)

//----------------------------------------------------

schema ex1a2			//TO ALERT 2
archetype AI_MINOR
ex1a2__1 ex1a2__2 ex1a2__3 ex1a2__4
schema_voice vextra1 1 toleveltwo  

//----------------------------------------------------

schema ex1a3 			//TO ALERT 3 NOT BY SEEING THE PLAYER
archetype AI_MAJOR
ex1a3__1 ex1a3__2 ex1a3__3 
schema_voice vextra1 1 tolevelthree

schema ex1a3s			//SPOTTED THE PLAYER
archetype AI_MORE_MAJOR
ex1a3s_1 ex1a3s_2 ex1a3s_3 ex1a3s_4
schema_voice vextra1 1 spotplayer 

schema ex1telc			//SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
ex1telc1 ex1telc2 
schema_voice vextra1 5 spotplayer (NearbyFriends 0 20)

schema ex1a3b			//SPOTTED THE PLAYER +body
archetype AI_MORE_MAJOR
ex1a3b_1 
schema_voice vextra1 9 spotplayer (CarryBody True)

//----------------------------------------------------

schema ex1at1			//AT ALERT 1 & 2
archetype AI_NONE
delay 4000
volume -500
mono_loop 7500 1500
ex1a0co1 ex1a0co2 ex1a0co3 ex1a0co4 ex1a0co5
schema_voice vextra1 1 atlevelone
schema_voice vextra1 1 atleveltwo

//----------------------------------------------------

schema ex1run			//REACT RUN AWAY
archetype AI_MAJOR
ex1run_1 ex1run_2 ex1run_3 ex1run_4 ex1run_5 ex1run_6
schema_voice vextra1 1 reactrun 

schema ex1alma			//REACT I SOUND THE ALARMS
archetype AI_MORE_MAJOR
ex1almw1
schema_voice vextra1 1 reactalarm

//----------------------------------------------------

schema ex1bak			//BACK TO ALERT 0
archetype AI_NONE
volume -500
ex1bak_1 ex1bak_2 ex1bak_3 ex1bak_4 ex1bak_5 ex1bak_6 ex1bak_7 
schema_voice vextra1 1 backtozero  

schema ex1torch			//NOTICED A DOUSED TORCH
archetype AI_MINOR
delay 2000
ex1torc1 ex1torc2
schema_voice vextra1 1 notice (Item GasLight Torch)

//----------------------------------------------------

schema ex1bod			//FOUND BODY	
archetype AI_MORE_MAJOR
ex1bod_1 ex1bod_2 ex1bod_3 ex1bod_4
schema_voice vextra1 1 foundbody  

schema ex1mis			//FOUND SOMETHING MISSING
archetype AI_MAJOR
ex1mis_1 
schema_voice vextra1 1 foundmissing
schema_voice vextra1 1 notice (Item MissingLoot)

schema ex1sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
ex1sma_1 ex1sma_2
schema_voice vextra1 1 foundsmall  
schema_voice vextra1 1 notice (Item Door Generic)

schema ex1lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
ex1lar_1 ex1lar_2
schema_voice vextra1 1 foundlarge

schema ex1sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
ex1sec_1 ex1sec_2 
schema_voice vextra1 1 foundbreach

schema ex1rob			//FOUND DEAD ROBOT	
archetype AI_MAJOR
ex1rob_1 
schema_voice vextra1 1 foundrobot  

//----------------------------------------------------

schema ex1rint			//RECENTLY SAW THE PLAYER +w/co
archetype AI_INFORM
ex1rint1 ex1rint2 ex1rint3
schema_voice vextra1 1 recentintruder 

schema ex1rbod			//RECENTLY FOUND BODY +w/co
archetype AI_INFORM
ex1rbod1  
schema_voice vextra1 1 recentbody 

schema ex1rrob			//RECENTLY FOUND DEAD ROBOT +w/co
archetype AI_INFORM
ex1rrob1
schema_voice vextra1 1 recentrobot 

schema ex1rmis			//RECENTLY FOUND MISSING +w/co
archetype AI_INFORM
ex1rmis3 
schema_voice vextra1 1 recentmissing 

schema ex1roth			//RECENTLY FOUND MISC ANAMOLY +w/co
archetype AI_INFORM
ex1roth1 ex1roth2 
schema_voice vextra1 1 recentother 

//----------------------------------------------------

schema ex1hlo			//HIT BY PLAYER 
archetype AI_MORE_MAJOR
ex1hlo_1 ex1hlo_2 ex1hlo_3 ex1hlo_4 ex1hlo_5 ex1hlo_6 
schema_voice vextra1 1 comhitlow
schema_voice vextra1 1 comhithigh
schema_voice vbasso 1 comhitlow
schema_voice vbasso 1 comhithigh

schema ex1hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
ex1hlow1
schema_voice vextra1 1 comhitlow (NearbyFriends 0 20)
schema_voice vbasso 1 comhitlow (NearbyFriends 0 20)


schema ex1hnde			//HIT BY PLAYER NO DAMAGE
archetype AI_MAJOR
ex1hnde1 ex1hnde2 ex1hnde3
schema_voice vextra1 1 comhitnodam 
schema_voice vbasso 1 comhitnodam 

//----------------------------------------------------


schema ex1diea		//SOFT DEATH
archetype AI_MINOR
volume -500
ex1diea1 ex1diea2 ex1diea3 ex1diea4 
schema_voice vextra1 1 comdiesoft
schema_voice vbasso 1 comdiesoft

schema ex1diec		//LOUD DEATH
archetype AI_COMBAT
ex1diec1 ex1diec2 ex1diec3 
schema_voice vextra1 1 comdieloud
schema_voice vbasso 1 comdieloud

//----------------------------------------------------
//----------------------------------------------------