//EXTRA 2 BROADCASTS 

//----------------------------------------------------

schema ex2a0sn			//SLEEPING
archetype AI_NONE
volume -500
mono_loop 2000 3000
ex2a0sn1 ex2a0sn2 ex2a0sn3 ex2a0sn4
schema_voice vextra2 1 sleeping

schema ex2a0			//COUGHING & HUMMING
archetype AI_NONE
delay 2000
volume -500
mono_loop 7500 15000
ex2a0co1 ex2a0co2 ex2a0co3 ex2a0co4 ex2a0co5
ex2a0hu1 ex2a0hu2 ex2a0hu3 ex2a0hu4 ex2a0hu5 
schema_voice vextra2 1 atlevelzero

schema ex2a0hu			//COUGHING & WHISTLING
archetype AI_NONE
delay 2000
stream
volume -500
mono_loop 7500 15000
ex2a0wh1 ex2a0wh2 ex2a0wh3 ex2a0wh4 ex2a0wh5
ex2a0co1 ex2a0co2 
schema_voice vextra2 1 atlevelzero

//----------------------------------------------------

schema ex2a1			//TO ALERT 1
archetype AI_NONE
ex2a1__1 ex2a1__2 ex2a1__3 ex2a1__4 
schema_voice vextra2 1 tolevelone  

schema ex2a1v			//TO ALERT 1 +sighted
archetype AI_NONE
ex2a1v_1 ex2a1v_2
schema_voice vextra2 1 tolevelone (Sense Sight)

schema ex2a1h			//TO ALERT 1 +heard
archetype AI_NONE
ex2a1h_1 ex2a1h_2
schema_voice vextra2 2 tolevelone (Sense Sound)

//----------------------------------------------------

schema ex2a2			//TO ALERT 2
archetype AI_MINOR
ex2a2__1 ex2a2__2 ex2a2__3 ex2a2__4
schema_voice vextra2 1 toleveltwo  

//----------------------------------------------------

schema ex2a3 			//TO ALERT 3 NOT BY SEEING THE PLAYER
archetype AI_MAJOR
ex2a3__1 ex2a3__2 ex2a3__3 ex2a3__4
schema_voice vextra2 1 tolevelthree

schema ex2a3s			//SPOTTED THE PLAYER
archetype AI_MORE_MAJOR
ex2a3s_1 ex2a3s_2 ex2a3s_3 ex2a3s_4
schema_voice vextra2 1 spotplayer 

schema ex2telc			//SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
ex2telc1 ex2telc2 ex2telc3 
schema_voice vextra2 5 spotplayer (NearbyFriends 0 20)

schema ex2a3b			//SPOTTED THE PLAYER +body
archetype AI_MORE_MAJOR
ex2a3b_1 
schema_voice vextra2 9 spotplayer (CarryBody True)

//----------------------------------------------------

schema ex2at1			//AT ALERT 1 & 2
archetype AI_NONE
delay 4000
volume -500
mono_loop 7500 1500
ex2a0co1 ex2a0co2 ex2a0co3 ex2a0co4 ex2a0co5
schema_voice vextra2 1 atlevelone
schema_voice vextra2 1 atleveltwo

//----------------------------------------------------

schema ex2run			//REACT RUN AWAY
archetype AI_MAJOR
ex2run_1 ex2run_2 ex2run_3 ex2run_4 ex2run_5 ex2run_6
schema_voice vextra2 1 reactrun 

schema ex2alma			//REACT I SOUND THE ALARMS
archetype AI_MORE_MAJOR
ex2almw1
schema_voice vextra2 1 reactalarm

//----------------------------------------------------

schema ex2bak			//BACK TO ALERT 0
archetype AI_NONE
volume -500
ex2bak_1 ex2bak_2 ex2bak_3 ex2bak_4 ex2bak_5 ex2bak_6 ex2bak_7 
schema_voice vextra2 1 backtozero  

schema ex2torch			//NOTICED A DOUSED TORCH
archetype AI_MINOR
delay 2000
ex2torc1 ex2torc2
schema_voice vextra2 1 notice (Item GasLight Torch)

//----------------------------------------------------

schema ex2bod			//FOUND BODY	
archetype AI_MORE_MAJOR
ex2bod_1 ex2bod_2 ex2bod_3 ex2bod_4
schema_voice vextra2 1 foundbody  

schema ex2mis			//FOUND SOMETHING MISSING
archetype AI_MAJOR
ex2mis_1 ex2mis_2
schema_voice vextra2 1 foundmissing
schema_voice vextra2 1 notice (Item MissingLoot)

schema ex2sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
ex2sma_1 ex2sma_2
schema_voice vextra2 1 foundsmall  
schema_voice vextra2 1 notice (Item Door Generic)

schema ex2lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
ex2lar_1 ex2lar_2
schema_voice vextra2 1 foundlarge

schema ex2sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
ex2sec_1 ex2sec_2 
schema_voice vextra2 1 foundbreach

schema ex2rob			//FOUND DEAD ROBOT	
archetype AI_MAJOR
ex2rob_1 
schema_voice vextra2 1 foundrobot  

//----------------------------------------------------

schema ex2rint			//RECENTLY SAW THE PLAYER +w/co
archetype AI_INFORM
ex2rint1 ex2rint2
schema_voice vextra2 1 recentintruder 

schema ex2rbod			//RECENTLY FOUND BODY +w/co
archetype AI_INFORM
ex2rbod1  
schema_voice vextra2 1 recentbody 

schema ex2rrob			//RECENTLY FOUND DEAD ROBOT +w/co
archetype AI_INFORM
ex2rrob1
schema_voice vextra2 1 recentrobot 

schema ex2rmis			//RECENTLY FOUND MISSING +w/co
archetype AI_INFORM
ex2rmis3 
schema_voice vextra2 1 recentmissing 

schema ex2roth			//RECENTLY FOUND MISC ANAMOLY +w/co
archetype AI_INFORM
ex2roth1 ex2roth2 
schema_voice vextra2 1 recentother 

//----------------------------------------------------

schema ex2hlo			//HIT BY PLAYER 
archetype AI_MORE_MAJOR
ex2hlo_1 ex2hlo_2 ex2hlo_3 ex2hlo_4 ex2hlo_5 ex2hlo_6 
schema_voice vextra2 1 comhitlow
schema_voice vextra2 1 comhithigh

schema ex2hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
ex2hlow1
schema_voice vextra2 1 comhitlow (NearbyFriends 0 20)

schema ex2hnde			//HIT BY PLAYER NO DAMAGE
archetype AI_MAJOR
ex2hnde1 ex2hnde2 ex2hnde3
schema_voice vextra2 1 comhitnodam 

//----------------------------------------------------


schema ex2diea		//SOFT DEATH
archetype AI_MINOR
volume -500
ex2diea1 ex2diea2 ex2diea3 ex2diea4 
schema_voice vextra2 1 comdiesoft

schema ex2diec		//LOUD DEATH
archetype AI_COMBAT
ex2diec1 ex2diec2 ex2diec3 ex2diec4 
schema_voice vextra2 1 comdieloud

//----------------------------------------------------
//----------------------------------------------------