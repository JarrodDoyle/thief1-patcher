//NOBLE 1 BROADCASTS 

//----------------------------------------------------

schema no1a0sn			//SLEEPING
archetype AI_NONE
volume -500
mono_loop 2000 3000
no1a0sn1 no1a0sn2 no1a0sn3 no1a0sn4 no1a0sn5 no1a0sn6 no1a0sn7
schema_voice vnoble1 1 sleeping

schema no1a0co			//COUGHING & HUMMING
archetype AI_NONE
delay 2000
volume -500
mono_loop 7500 15000
no1a0co1 no1a0co2 no1a0co3 no1a0co4
no1a0hu1 no1a0hu2 no1a0hu3 no1a0hu4
schema_voice vnoble1 1 atlevelzero

schema no1a0wh			//WHISTLE & MUTTERING
archetype AI_NONE
delay 2000
stream
volume -500
mono_loop 7500 15000
no1a0wh1 no1a0wh2 no1a0wh3 no1a0wh4 no1a0wh5 no1a0wh6
no1a0th1 no1a0th2 no1a0th3 no1a0th4 no1a0th5 no1a0th6
no1a0mu1 no1a0mu2 
schema_voice vnoble1 1 atlevelzero


//----------------------------------------------------

schema no1a1			//TO ALERT 1
archetype AI_NONE
no1a1__1 no1a1__2 no1a1__3 no1a1__4 
schema_voice vnoble1 1 tolevelone  

schema no1a1v			//TO ALERT 1 +sighted
archetype AI_NONE
no1a1v_1 no1a1v_2
schema_voice vnoble1 1 tolevelone (Sense Sight)

schema no1a1h			//TO ALERT 1 +heard
archetype AI_NONE
no1a1h_1 no1a1h_2 
schema_voice vnoble1 2 tolevelone (Sense Sound)

//----------------------------------------------------

schema no1a2			//TO ALERT 2
archetype AI_MINOR
no1a2__1 no1a2__2 no1a2__3 no1a2__4
schema_voice vnoble1 1 toleveltwo  

//----------------------------------------------------

schema no1a3 			//TO ALERT 3 NOT BY SEEING THE PLAYER
archetype AI_MAJOR
no1a3__1 no1a3__2 
schema_voice vnoble1 1 tolevelthree

schema no1a3s			//SPOTTED THE PLAYER
archetype AI_MORE_MAJOR
no1a3s_1 no1a3s_2 no1a3s_3 no1a3s_4 
schema_voice vnoble1 1 spotplayer 

schema no1telc			//SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
no1telc1 no1telc2 
schema_voice vnoble1 5 spotplayer (NearbyFriends 0 20)

schema no1a3b			//SPOTTED THE PLAYER +body
archetype AI_MORE_MAJOR
no1a3b_1 
schema_voice vnoble1 9 spotplayer (CarryBody True)

//----------------------------------------------------

schema no1at1			//AT ALERT 1 & 2
archetype AI_NONE
delay 5000
volume -500
mono_loop 7500 1500
no1a0th1 no1a0th2 no1a0th3 no1a0th4 no1a0th5 no1a0th6
schema_voice vnoble1 1 atlevelone
schema_voice vnoble1 1 atleveltwo

//----------------------------------------------------

schema no1run			//REACT RUN AWAY
archetype AI_MAJOR
no1runa1 no1runa2 no1runa3 no1runa4 no1runa5
schema_voice vnoble1 1 reactrun 

schema no1alma			//REACT I SOUND THE ALARMS
archetype AI_MORE_MAJOR
no1alma1 
schema_voice vnoble1 1 reactalarm

//----------------------------------------------------

schema no1bak			//BACK TO ALERT 0
archetype AI_NONE
volume -500
no1bak_1 no1bak_2 no1bak_3 no1bak_4 no1bak_5 
schema_voice vnoble1 1 backtozero  

schema no1torch			//NOTICED A DOUSED TORCH
archetype AI_MINOR
delay 2000
no1torc1 no1torc2
schema_voice vnoble1 1 notice (Item GasLight Torch)

//----------------------------------------------------

schema no1bod			//FOUND BODY	
archetype AI_MORE_MAJOR
no1bod_1 no1bod_2 
schema_voice vnoble1 1 foundbody  

schema no1mis			//FOUND SOMETHING MISSING
archetype AI_MAJOR
no1mis_1 
schema_voice vnoble1 1 foundmissing
schema_voice vnoble1 1 notice (Item MissingLoot)

schema no1sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
no1sma_1 
schema_voice vnoble1 1 foundsmall  
schema_voice vnoble1 1 notice (Item Door Generic)

schema no1lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
no1lar_1 
schema_voice vnoble1 1 foundlarge

schema no1sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
no1sec_1 
schema_voice vnoble1 1 foundbreach

schema no1rob			//FOUND DEAD ROBOT	
archetype AI_MAJOR
no1rob_1 
schema_voice vnoble1 1 foundrobot  

//----------------------------------------------------

schema no1rint			//RECENTLY SAW THE PLAYER +w/co
archetype AI_INFORM
no1rint1 no1rint2
schema_voice vnoble1 1 recentintruder 

schema no1rbod			//RECENTLY FOUND BODY +w/co
archetype AI_INFORM
no1rbod1  
schema_voice vnoble1 1 recentbody 

schema no1rrob			//RECENTLY FOUND DEAD ROBOT +w/co
archetype AI_INFORM
no1rrob1
schema_voice vnoble1 1 recentrobot 

schema no1rmis			//RECENTLY FOUND MISSING +w/co
archetype AI_INFORM
no1rmis1
schema_voice vnoble1 1 recentmissing 

schema no1roth			//RECENTLY FOUND MISC ANAMOLY +w/co
archetype AI_INFORM
no1roth1
schema_voice vnoble1 1 recentother 

//----------------------------------------------------

schema no1hhi			//HIT BY PLAYER 
archetype AI_MORE_MAJOR
no1hhi_1 no1hlo_1 no1hlo_2 no1hlo_3
schema_voice vnoble1 1 comhithigh


schema no1hlo			//HIT BY PLAYER 
archetype AI_MORE_MAJOR
no1hlo_1 no1hlo_2 no1hlo_3 
schema_voice vnoble1 1 comhitlow
schema_voice vnoble1 1 comhitamb

schema no1hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
no1hlow1
schema_voice vnoble1 1 comhitlow (NearbyFriends 0 20)

schema no1hnd			//HIT BY PLAYER NO DAMAGE
archetype AI_MAJOR
no1hnd_1 no1hnd_2 no1hnd_3
schema_voice vnoble1 1 comhitnodam 

//----------------------------------------------------


schema no1diea		//SOFT DEATH
archetype AI_MINOR
volume -500
no1diea1 no1diea2 no1diea3 
schema_voice vnoble1 1 comdiesoft

schema no1diec		//LOUD DEATH
archetype AI_COMBAT
no1diec1 no1diec2 no1diec3 
schema_voice vnoble1 1 comdieloud

//----------------------------------------------------
//----------------------------------------------------

