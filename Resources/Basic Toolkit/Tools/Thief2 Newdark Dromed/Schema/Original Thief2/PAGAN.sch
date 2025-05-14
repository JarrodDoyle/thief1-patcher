//PAGAN MAN - BROADCASTS 

//----------------------------------------------------

schema pg1a0			//AT ALERT 0, 1, 2
archetype AI_NONE
volume -500
delay 3000
mono_loop 3000 20000
pg1a0co1 pg1a0co2 pg1a0co3 pg1a0co4 
pg1a0hu1 pg1a0hu2 pg1a0hu3 pg1a0hu4
pg1a0mu1 pg1a0mu2 pg1a0mu3 pg1a0mu4 pg1a0mu5 pg1a0mu6
schema_voice vpaganman 1 atlevelzero
schema_voice vpaganman 1 atlevelone
schema_voice vpaganman 1 atleveltwo

//----------------------------------------------------

schema pg1a1			//TO ALERT 1
archetype AI_NONE
pg1a1__1 pg1a1__2 pg1a1__3 pg1a1__4 
schema_voice vpaganman 1 tolevelone  

schema pg1a1v			//TO ALERT 1 +sighted
archetype AI_NONE
pg1a1v_1 pg1a1v_2
schema_voice vpaganman 1 tolevelone (Sense Sight)

schema pg1a1h			//TO ALERT 1 +heard
archetype AI_NONE
pg1a1h_1 pg1a1h_2
schema_voice vpaganman 2 tolevelone (Sense Sound)

//----------------------------------------------------

schema pg1a2			//TO ALERT 2
archetype AI_MINOR
pg1a2__1 pg1a2__2 pg1a2__3 pg1a2__4
schema_voice vpaganman 1 toleveltwo  

//----------------------------------------------------

schema pg1a3 			//TO ALERT 3 NOT BY SEEING THE PLAYER
archetype AI_MAJOR
pg1a3__1 pg1a3__2 pg1a3__3
schema_voice vpaganman 1 tolevelthree

schema pg1a3s			//SPOTTED THE PLAYER
archetype AI_MORE_MAJOR
pg1a3s_1 pg1a3s_2 pg1a3s_3 pg1a3s_4
schema_voice vpaganman 1 spotplayer 

schema pg1a3b			//SPOTTED THE PLAYER +body
archetype AI_MORE_MAJOR
pg1a3b_1 
schema_voice vpaganman 9 spotplayer (CarryBody True)

schema pg1telc			//SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
pg1telc1 pg1telc2 
schema_voice vpaganman 5 spotplayer (NearbyFriends 0 20) 

//----------------------------------------------------

schema pg1run			//REACT RUN AWAY +alone
archetype AI_MAJOR
pg1run_1 pg1run_2 pg1run_3 pg1run_4 pg1run_5 pg1run_6
schema_voice vpaganman 1 reactrun 

//----------------------------------------------------

schema pg1bak			//BACK TO ALERT 0
archetype AI_NONE
volume -500
pg1bak_1 pg1bak_2 pg1bak_3 pg1bak_4 pg1bak_5 pg1bak_6 pg1bak_7
schema_voice vpaganman 1 backtozero  

//----------------------------------------------------

schema pg1bod			//FOUND BODY	
archetype AI_MORE_MAJOR
pg1bod_1 pg1bod_2 pg1bod_3 pg1bod_4
schema_voice vpaganman 1 foundbody  

schema pg1mis			//FOUND SOMETHING MISSING
archetype AI_MAJOR
pg1mis_1 pg1mis_2 pg1mis_3
schema_voice vpaganman 1 foundmissing
schema_voice vpaganman 1 notice (Item MissingLoot)

schema pg1sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
pg1sma_1 pg1sma_2
schema_voice vpaganman 1 foundsmall  
schema_voice vpaganman 1 notice (Item Door Generic)

schema pg1lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
pg1lar_1 pg1lar_2
schema_voice vpaganman 1 foundlarge

schema pg1sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
pg1sec_1 pg1sec_2
schema_voice vpaganman 1 foundbreach

//----------------------------------------------------

schema pg1rint			//RECENTLY SAW THE PLAYER +w/co
archetype AI_INFORM
pg1rint1 pg1rint2 pg1rint3
schema_voice vpaganman 1 recentintruder 

schema pg1rbod			//RECENTLY BODY +w/co
archetype AI_INFORM
pg1rbod1
schema_voice vpaganman 1 recentbody 

schema pg1rmis			//RECENTLY MISSING +w/co
archetype AI_INFORM
pg1rmis1 pg1rmis2
schema_voice vpaganman 1 recentmissing 

schema pg1roth			//RECENTLY MISC ANAMOLY +w/co
archetype AI_INFORM
pg1roth1 pg1roth2 
schema_voice vpaganman 1 recentother 

//----------------------------------------------------

//COMBAT

schema pg1hhi			//HIT BY PLAYER W/HI HIT PTS 
archetype AI_MAJOR
pg1hhi_1 pg1hhi_2 pg1hhi_3 
schema_voice vpaganman 1 comhithigh

schema pg1hlo			//HIT BY PLAYER W/LO PTS 
archetype AI_MORE_MAJOR
pg1hlo_1 pg1hlo_2 pg1hlo_3 
schema_voice vpaganman 1 comhitlow

schema pg1hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
pg1hlow1
schema_voice vpaganman 1 comhitlow (NearbyFriends 0 20)

schema pg1hnde			//HIT BY PLAYER NO DAMAGE +Winning
archetype AI_MAJOR
pg1hnde1 pg1hnde2 pg1hnde3
schema_voice vpaganman 1 comhitnodam 

schema pg1diea		//SOFT DEATH
archetype AI_MINOR
volume -500
pg1diea1 pg1diea2 pg1diea3 
schema_voice vpaganman 1 comdiesoft

schema pg1diec		//LOUD DEATH
archetype AI_COMBAT
pg1diec1 pg1diec2 pg1diec3 pg1diec4 
schema_voice vpaganman 1 comdieloud

//----------------------------------------------------
//----------------------------------------------------
