//OPERA ACTOR & PATRON -Karen Wolff

/////////////
//AI SPEECH//
/////////////

//ASLEEP
schema op2a0sn
archetype AI_NONE
volume -500
mono_loop 2000 3000
sv2a0sn1 sv2a0sn2 
schema_voice vactor2 1 sleeping
schema_voice vpatron2 1 sleeping

//AT ALERT 0 -PATRON ONLY
schema op2a0co
archetype AI_NONE
volume -500
mono_loop 2000 20000
op2a0co1 op2a0co2 op2a0hu1 op2a0hu2 op2a0hu3
schema_voice vpatron2 1 atlevelzero

//		-ACTOR ONLY
schema op2a0si
archetype AI_NONE
volume -200
mono_loop 100 10000
op2a0si1 op2a0si2 op2a0si3 op2a0si4 op2a0si5 op2a0si6 op2a0si7 op2a0si8 op2a0si9 op2a0co1 op2a0co2 silenc9s silenc3s
schema_voice vactor2 1 atlevelzero


//TO ALERT 1
schema op2a1
archetype AI_NONE
op2a1__1 op2a1__2 op2a1__3 
schema_voice vactor2 1 tolevelone
schema_voice vpatron2 1 tolevelone  

//		+sighted
schema op2a1v
archetype AI_NONE
op2a1v_1
schema_voice vactor2 2 tolevelone (Sense Sight)
schema_voice vpatron2 2 tolevelone (Sense Sight)

//		+heard
//schema op2a1h
//archetype AI_NONE
//op2a1h_1  <--DID WE RECORD THIS??
//schema_voice vactor2 2 tolevelone (Sense Sound)
//schema_voice vpatron2 2 tolevelone (Sense Sound)


//AT ALERT 1, 2 & 3
schema op2at1
archetype AI_NONE
volume -500
delay 5000
mono_loop 500 15000
op2a0co1 op2a0co2
schema_voice vactor2 1 atlevelone
schema_voice vactor2 1 atleveltwo
schema_voice vactor2 1 atlevelthree
schema_voice vpatron2 1 atlevelone
schema_voice vpatron2 1 atleveltwo
schema_voice vpatron2 1 atlevelthree

//BACK TO ALERT 0
schema op2bak
archetype AI_NONE
op2bak_1 op2bak_2 op2bak_3 
schema_voice vactor2 1 backtozero  
schema_voice vpatron2 1 backtozero  

//TO ALERT 2
schema op2a2
archetype AI_MINOR
op2a2__1 op2a2__2
schema_voice vactor2 1 toleveltwo  
schema_voice vpatron2 1 toleveltwo  

//TO ALERT 3
schema op2a3
archetype AI_MAJOR
op2a3s_1 op2a3s_2
schema_voice vactor2 1 tolevelthree
schema_voice vpatron2 1 tolevelthree
schema_voice vactor2 1 spotplayer
schema_voice vpatron2 1 spotplayer

//		+carrying a body
schema op2a3b
archetype AI_MORE_MAJOR
op2a3b_1 
schema_voice vactor2 9 spotplayer (CarryBody True)
schema_voice vpatron2 9 spotplayer (CarryBody True)


//RE-SPOTTED PLAYER AFTER A SEARCH +w/co -All except THIEVE's
schema op2telc
archetype AI_COMBAT
op2telc1 op2telc2
schema_voice vactor2 9 spotplayer (NearbyFriends 0 20) (Reacquire True) 
schema_voice vpatron2 9 spotplayer (NearbyFriends 0 20) (Reacquire True) 


//REACT RUN AWAY
schema op2run_a
archetype AI_MAJOR
op2runa1 op2runa2 op2runa3 op2runa4 
schema_voice vactor2 1 reactrun
schema_voice vpatron2 1 reactrun


//REACT I SOUND THE ALARMS
schema op2alma
archetype AI_MORE_MAJOR
op2alma1
schema_voice vactor2 1 reactalarm
schema_voice vpatron2 1 reactalarm

//FOUND BODY
schema op2bod
archetype AI_MORE_MAJOR
op2bod_1 op2bod_2
schema_voice vactor2 1 foundbody  
schema_voice vpatron2 1 foundbody  

//FOUND SOMETHING MISSING
schema op2mis
archetype AI_MAJOR
op2mis_1 
schema_voice vactor2 1 foundmissing 
schema_voice vpatron2 1 foundmissing 

//FOUND A SMALL ANOMALY
schema op2sma
archetype AI_MINOR
op2sma_1
schema_voice vactor2 1 foundsmall  
schema_voice vpatron2 1 foundsmall  

//FOUND A LARGE ANOMALY
schema op2lar
archetype AI_MAJOR
op2lar_1
schema_voice vactor2 1 foundlarge
schema_voice vpatron2 1 foundlarge

//FOUND A SECURITY BREACH
schema op2sec
archetype AI_MORE_MAJOR
op2sec_1
schema_voice vactor2 1 foundbreach 
schema_voice vpatron2 1 foundbreach 

//RECENTLY SAW THE PLAYER +w/co
schema op2rint
archetype AI_INFORM
op2rint1 
schema_voice vactor2 1 recentintruder
schema_voice vpatron2 1 recentintruder

//RECENTLY FOUND BODY +w/co
schema op2rbod
archetype AI_INFORM
op2rbod1
schema_voice vactor2 1 recentbody 
schema_voice vpatron2 1 recentbody 

//RECENTLY FOUND SOMETHING MISSING +w/
schema op2rmis
archetype AI_INFORM
op2rmis1
schema_voice vactor2 1 recentmissing 
schema_voice vpatron2 1 recentmissing 

//RECENTLY FOUND MISC ANAMOLY +w/co
schema op2roth
archetype AI_INFORM
op2roth1
schema_voice vactor2 1 recentother
schema_voice vpatron2 1 recentother

//HIT BY THE PLAYER 
schema op2hlo
archetype AI_MORE_MAJOR
op2hlo_1 op2hlo_2 op2hlo_3 
schema_voice vactor2 1 comhitlow
schema_voice vactor2 1 comhithigh
schema_voice vactor2 1 comhitamb
schema_voice vpatron2 1 comhitlow
schema_voice vpatron2 1 comhithigh
schema_voice vpatron2 1 comhitamb


//HIT BY THE PLAYER +w/co
schema op2hlow
archetype AI_MORE_MAJOR
op2hlow1 op2hlow2
schema_voice vactor2 1 comhitlow (NearbyFriends 0 20)
schema_voice vactor2 1 comhithigh (NearbyFriends 0 20)
schema_voice vactor2 1 comhitamb (NearbyFriends 0 20)
schema_voice vpatron2 1 comhitlow (NearbyFriends 0 20)
schema_voice vpatron2 1 comhithigh (NearbyFriends 0 20)
schema_voice vpatron2 1 comhitamb (NearbyFriends 0 20)


//DEATH BY COMBAT -LOUD
schema op2diec
archetype AI_COMBAT
op2diec1 op2diec2 
schema_voice vactor2 1 comdieloud
schema_voice vpatron2 1 comdieloud

//DEATH (or knocked out) BY AMBUSH -MORE MUFFLED
schema op2diea
archetype AI_MINOR
volume -500
op2diea1 op2diea2 
schema_voice vactor2 1 comdiesoft
schema_voice vpatron2 1 comdiesoft



