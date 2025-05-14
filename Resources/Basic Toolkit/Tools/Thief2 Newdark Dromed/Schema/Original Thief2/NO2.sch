//NOBLE 2 BROADCASTS 

//----------------------------------------------------

schema no2a0sn			//SLEEPING
archetype AI_NONE
volume -500
mono_loop 2000 3000
no2a0sn1 no2a0sn2 no2a0sn3 no2a0sn4 no2a0sn5 
schema_voice vnoble2 1 sleeping

schema no2a0co			//COUGHING & HUMMING
archetype AI_NONE
delay 2000
volume -500
mono_loop 7500 15000
no2a0co1 no2a0co2
no2a0hu1 no2a0hu2 no2a0hu3 no2a0hu4 no2a0hu5 no2a0hu6 no2a0hu7 no2a0hu8
schema_voice vnoble2 1 atlevelzero

schema no2a0wh			//WHISTLE & MUTTERING
archetype AI_NONE
delay 2000
stream
volume -500
mono_loop 7500 15000
no2a0wh1 no2a0wh2 no2a0wh3 no2a0wh4 no2a0wh5
no2a0th1 no2a0th2 no2a0th3 no2a0th4
no2a0mu1 no2a0mu2 no2a0co1 no2a0co2
schema_voice vnoble2 1 atlevelzero


//----------------------------------------------------

schema no2a1			//TO ALERT 1
archetype AI_NONE
no2a1__1 no2a1__2 no2a1__3 no2a1__4 no2a1__5
schema_voice vnoble2 1 tolevelone  

schema no2a1v			//TO ALERT 1 +sighted
archetype AI_NONE
no2a1v_1 no2a1v_2
schema_voice vnoble2 1 tolevelone (Sense Sight)

schema no2a1h			//TO ALERT 1 +heard
archetype AI_NONE
no2a1h_1 no2a1h_2 no2a1h_3
schema_voice vnoble2 2 tolevelone (Sense Sound)

//----------------------------------------------------

schema no2a2			//TO ALERT 2
archetype AI_MINOR
no2a2__1 no2a2__2 no2a2__3 
schema_voice vnoble2 1 toleveltwo  

//----------------------------------------------------

schema no2a3 			//TO ALERT 3 NOT BY SEEING THE PLAYER
archetype AI_MAJOR
no2a3__1 no2a3__2 
schema_voice vnoble2 1 tolevelthree

schema no2a3s			//SPOTTED THE PLAYER
archetype AI_MORE_MAJOR
no2a3s_1 no2a3s_2 no2a3s_3 no2a3s_4 no2a3s_5
schema_voice vnoble2 1 spotplayer 

schema no2telc			//SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
no2telc1 no2telc2 
schema_voice vnoble2 5 spotplayer (NearbyFriends 0 20)

schema no2a3b			//SPOTTED THE PLAYER +body
archetype AI_MORE_MAJOR
no2a3b_1 
schema_voice vnoble2 9 spotplayer (CarryBody True)

//----------------------------------------------------

schema no2at1			//AT ALERT 1 & 2
archetype AI_NONE
delay 5000
volume -500
mono_loop 7500 1500
no2a0th1 no2a0th2 no2a0th3 no2a0th4
no2a0co1 no2a0co2
schema_voice vnoble2 1 atlevelone
schema_voice vnoble2 1 atleveltwo

//----------------------------------------------------

schema no2run			//REACT RUN AWAY
archetype AI_MAJOR
no2run_1 no2run_2 no2run_3 no2run_4 
schema_voice vnoble2 1 reactrun 

schema no2alma			//REACT I SOUND THE ALARMS
archetype AI_MORE_MAJOR
no2alma1 no2alma2
schema_voice vnoble2 1 reactalarm

//----------------------------------------------------

schema no2bak			//BACK TO ALERT 0
archetype AI_NONE
volume -500
no2bak_1 no2bak_2 no2bak_3 no2bak_4 no2bak_5 
schema_voice vnoble2 1 backtozero  

schema no2torch			//NOTICED DOUSED TORCH
archetype AI_MINOR
delay 2000
no2torc1 no2torc2
schema_voice vnoble2 1 notice (Item Torch)

schema no2gas			//NOTICED DOUSED GASLIGHT
archetype AI_MINOR
delay 2000
no2torc3 no2torc4
schema_voice vnoble2 1 notice (Item GasLight)


//----------------------------------------------------

schema no2bod			//FOUND BODY	
archetype AI_MORE_MAJOR
no2bod_1 no2bod_2 
schema_voice vnoble2 1 foundbody  

schema no2mis			//FOUND SOMETHING MISSING
archetype AI_MAJOR
no2mis_1 
schema_voice vnoble2 1 foundmissing
schema_voice vnoble2 1 notice (Item MissingLoot)

schema no2sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
no2sma_1 no2sma_2
schema_voice vnoble2 1 foundsmall  
schema_voice vnoble2 1 notice (Item Door Generic)

schema no2lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
no2lar_1 
schema_voice vnoble2 1 foundlarge

schema no2sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
no2sec_1 
schema_voice vnoble2 1 foundbreach

schema no2rob			//FOUND DEAD ROBOT	
archetype AI_MAJOR
no2rob_1 
schema_voice vnoble2 1 foundrobot  

//----------------------------------------------------

schema no2rint			//RECENTLY SAW THE PLAYER +w/co
archetype AI_INFORM
no2rint1 no2rint2 no2rint3
schema_voice vnoble2 1 recentintruder 

schema no2rbod			//RECENTLY FOUND BODY +w/co
archetype AI_INFORM
no2rbod1  
schema_voice vnoble2 1 recentbody 

schema no2rrob			//RECENTLY FOUND DEAD ROBOT +w/co
archetype AI_INFORM
no2rrob1
schema_voice vnoble2 1 recentrobot 

schema no2rmis			//RECENTLY FOUND MISSING +w/co
archetype AI_INFORM
no2rmis1
schema_voice vnoble2 1 recentmissing 

schema no2roth			//RECENTLY FOUND MISC ANAMOLY +w/co
archetype AI_INFORM
no2roth1 no2roth2 
schema_voice vnoble2 1 recentother 

//----------------------------------------------------

schema no2hhi			//HIT BY PLAYER 
archetype AI_MAJOR
no2hhi_1 no2hhi_2 no2hhi_3
schema_voice vnoble2 1 comhithigh


schema no2hlo			//HIT BY PLAYER 
archetype AI_MORE_MAJOR
no2hlo_1 no2hlo_2 no2hlo_3 no2hlo_4 no2hlo_5 no2hlo_6
schema_voice vnoble2 1 comhitlow
schema_voice vnoble2 1 comhitamb


schema no2hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
no2hlow1
schema_voice vnoble2 1 comhitlow (NearbyFriends 0 20)

schema no2hnde			//HIT BY PLAYER NO DAMAGE
archetype AI_MAJOR
no2hnde1 no2hnde2 no2hnde3
schema_voice vnoble2 1 comhitnodam 

//----------------------------------------------------


schema no2diea		//SOFT DEATH
archetype AI_MINOR
volume -500
no2diea1 no2diea2 no2diea3 no2diea4 
schema_voice vnoble2 1 comdiesoft

schema no2diec		//LOUD DEATH
archetype AI_COMBAT
no2diec1 no2diec2 no2diec3 no2diec4 no2diec5 no2diec6
schema_voice vnoble2 1 comdieloud

//----------------------------------------------------
//----------------------------------------------------
