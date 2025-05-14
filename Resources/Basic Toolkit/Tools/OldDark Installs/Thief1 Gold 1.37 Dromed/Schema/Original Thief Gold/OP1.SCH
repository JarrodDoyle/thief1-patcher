//OPERA ACTOR & PATRON -Emil

/////////////
//AI SPEECH//
/////////////

//ASLEEP
schema op1a0sn
archetype AI_NONE
volume -500
mono_loop 2000 3000
sg1a0sn1 sg1a0sn2 sg1a0sn3 
schema_voice vactor1 1 sleeping
schema_voice vpatron1 1 sleeping

//AT ALERT 0 -PATRON ONLY
schema op1a0co
archetype AI_NONE
volume -500
mono_loop 2000 20000
op1a0co1 op1a0co2 op1a0co3 op1a0co4
schema_voice vpatron1 1 atlevelzero

//		-ACTOR ONLY
schema op1a0si
archetype AI_NONE
volume -200
mono_loop 100 10000
op1a0si1 op1a0si2 op1a0si3 op1a0si4 op1a0si5 op1a0si6 op1a0si7 op1a0si8 op1a0si9 op1a0s10 op1a0s11 op1a0s12 op1a0s13 op1a0hu1 op1a0hu2 op1a0hu3 op1a0hu4 silenc9s
silenc3s
schema_voice vactor1 1 atlevelzero


//TO ALERT 1
schema op1a1
archetype AI_NONE
op1a1__1 op1a1__2 op1a1__3 op1a1__4
schema_voice vactor1 1 tolevelone
schema_voice vpatron1 1 tolevelone  

//		+sighted
schema op1a1v
archetype AI_NONE
op1a1v_1
schema_voice vactor1 2 tolevelone (Sense Sight)
schema_voice vpatron1 2 tolevelone (Sense Sight)

//		+heard
schema op1a1h
archetype AI_NONE
op1a1h_1
schema_voice vactor1 2 tolevelone (Sense Sound)
schema_voice vpatron1 2 tolevelone (Sense Sound)


//AT ALERT 1, 2 & 3
schema op1at1
archetype AI_NONE
volume -500
delay 5000
mono_loop 500 15000
op1a0co1 op1a0co2 op1a0co3 op1a0co4
schema_voice vactor1 1 atlevelone
schema_voice vactor1 1 atleveltwo
schema_voice vactor1 1 atlevelthree
schema_voice vpatron1 1 atlevelone
schema_voice vpatron1 1 atleveltwo
schema_voice vpatron1 1 atlevelthree

//BACK TO ALERT 0
schema op1bak
archetype AI_NONE
op1bak_1 op1bak_2 op1bak_3 op1bak_4 
schema_voice vactor1 1 backtozero  
schema_voice vpatron1 1 backtozero  

//TO ALERT 2
schema op1a2
archetype AI_MINOR
op1a2__1 op1a2__2
schema_voice vactor1 1 toleveltwo  
schema_voice vpatron1 1 toleveltwo  

//TO ALERT 3
schema op1a3
archetype AI_MAJOR
op1a3s_1 op1a3s_2
schema_voice vactor1 1 tolevelthree
schema_voice vpatron1 1 tolevelthree
schema_voice vactor1 1 spotplayer
schema_voice vpatron1 1 spotplayer

//		+carrying a body
schema op1a3b
archetype AI_MORE_MAJOR
op1a3b_1 
schema_voice vactor1 9 spotplayer (CarryBody True)
schema_voice vpatron1 9 spotplayer (CarryBody True)


//RE-SPOTTED PLAYER AFTER A SEARCH +w/co -All except THIEVE's
schema op1telc
archetype AI_COMBAT
op1telc1 op1telc2
schema_voice vactor1 9 spotplayer (NearbyFriends 0 20) (Reacquire True) 
schema_voice vpatron1 9 spotplayer (NearbyFriends 0 20) (Reacquire True) 


//REACT RUN AWAY -ACTOR ONLY
schema op1run_a
archetype AI_MAJOR
op1runa1 op1runa2 op1runa3 op1runa4 op1runa5
schema_voice vactor1 1 reactrun

//			-PATRON ONLY		
schema op1run_p
archetype AI_MAJOR
op1runa1 op1runa2 op1runa3 op1runa4
schema_voice vpatron1 1 reactrun


//REACT I SOUND THE ALARMS
schema op1alma
archetype AI_MORE_MAJOR
op1alma1
schema_voice vactor1 1 reactalarm
schema_voice vpatron1 1 reactalarm

//FOUND BODY
schema op1bod
archetype AI_MORE_MAJOR
op1bod_1 op1bod_2
schema_voice vactor1 1 foundbody  
schema_voice vpatron1 1 foundbody  

//FOUND SOMETHING MISSING
schema op1mis
archetype AI_MAJOR
op1mis_1 
schema_voice vactor1 1 foundmissing 
schema_voice vpatron1 1 foundmissing 

//FOUND A SMALL ANOMALY
schema op1sma
archetype AI_MINOR
op1sma_1
schema_voice vactor1 1 foundsmall  
schema_voice vpatron1 1 foundsmall  

//FOUND A LARGE ANOMALY
schema op1lar
archetype AI_MAJOR
op1lar_1
schema_voice vactor1 1 foundlarge
schema_voice vpatron1 1 foundlarge

//FOUND A SECURITY BREACH
schema op1sec
archetype AI_MORE_MAJOR
op1sec_1
schema_voice vactor1 1 foundbreach 
schema_voice vpatron1 1 foundbreach 

//RECENTLY SAW THE PLAYER +w/co
schema op1rint
archetype AI_INFORM
op1rint1 op1rint2
schema_voice vactor1 1 recentintruder
schema_voice vpatron1 1 recentintruder

//RECENTLY FOUND BODY +w/co
schema op1rbod
archetype AI_INFORM
op1rbod1
schema_voice vactor1 1 recentbody 
schema_voice vpatron1 1 recentbody 

//RECENTLY FOUND SOMETHING MISSING +w/
schema op1rmis
archetype AI_INFORM
op1rmis1
schema_voice vactor1 1 recentmissing 
schema_voice vpatron1 1 recentmissing 

//RECENTLY FOUND MISC ANAMOLY +w/co
schema op1roth
archetype AI_INFORM
op1roth1
schema_voice vactor1 1 recentother
schema_voice vpatron1 1 recentother

//HIT BY THE PLAYER 
schema op1hlo
archetype AI_MORE_MAJOR
op1hlo_1 op1hlo_2 op1hlo_3 
schema_voice vactor1 1 comhitlow
schema_voice vactor1 1 comhithigh
schema_voice vactor1 1 comhitamb
schema_voice vpatron1 1 comhitlow
schema_voice vpatron1 1 comhithigh
schema_voice vpatron1 1 comhitamb


//HIT BY THE PLAYER +w/co
schema op1hlow
archetype AI_MORE_MAJOR
op1hlow1
schema_voice vactor1 1 comhitlow (NearbyFriends 0 20)
schema_voice vactor1 1 comhithigh (NearbyFriends 0 20)
schema_voice vactor1 1 comhitamb (NearbyFriends 0 20)
schema_voice vpatron1 1 comhitlow (NearbyFriends 0 20)
schema_voice vpatron1 1 comhithigh (NearbyFriends 0 20)
schema_voice vpatron1 1 comhitamb (NearbyFriends 0 20)


//DEATH BY COMBAT -LOUD
schema op1diec
archetype AI_COMBAT
op1diec1 op1diec2 op1diec3
schema_voice vactor1 1 comdieloud
schema_voice vpatron1 1 comdieloud

//DEATH (or knocked out) BY AMBUSH -MORE MUFFLED
schema op1diea
archetype AI_MINOR
volume -500
op1diea1 op1diea2 op1diea3
schema_voice vactor1 1 comdiesoft
schema_voice vpatron1 1 comdiesoft



