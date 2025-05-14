//MAGE 1 --Ian Vogel

/////////////
//AI SPEECH//
/////////////

//AT ALERT 0
schema mg1a0
archetype AI_NONE
volume -500
mono_loop 2000 20000
mg1a0hu1 mg1a0hu2 mg1a0hu3 mg1a0hu4 mg1a0co1 mg1a0co2 mg1a0co3 mg1a0co4 mg1a0ch1 mg1a0ch2 mg1a0ch3
schema_voice vmage1 3 atlevelzero

//TO ALERT 1
schema mg1a1
archetype AI_NONE
mg1a1__1 mg1a1__2 mg1a1__3
schema_voice vmage1 1 tolevelone  

//		+sighted
schema mg1a1v
archetype AI_NONE
mg1a1v_1 
schema_voice vmage1 2 tolevelone (Sense Sight)

//		+heard
schema mg1a1h
archetype AI_NONE
mg1a1h_1 mg1a1h_2
schema_voice vmage1 2 tolevelone (Sense Sound)

//		+w/co
schema mg1a1_w
archetype AI_MINOR
mg1a1_w1 
schema_voice vmage1 2 tolevelone (NearbyFriends 0 20)

//		+sighted +w/co
schema mg1a1vw
archetype AI_MINOR
mg1a1vw1 mg1a1vw2
schema_voice vmage1 3 tolevelone (Sense Sight) (NearbyFriends 0 20)

//		+heard +w/co
schema mg1a1hw
archetype AI_MINOR
mg1a1hw1 mg1a1hw2 
schema_voice vmage1 3 tolevelone (Sense Sound) (NearbyFriends 0 20)

//AT ALERT 1, 2 & 3
schema mg1at1
archetype AI_NONE
volume -500
delay 4000
mono_loop 2000 20000
mg1a0co1 mg1a0co2 mg1a0co3 mg1a0co4 
schema_voice vmage1 1 atlevelone
schema_voice vmage1 1 atleveltwo
schema_voice vmage1 1 atlevelthree

//BACK TO ALERT 0
schema mg1bak
archetype AI_NONE
mg1bak_1 mg1bak_2 mg1bak_3 mg1bak_4 mg1bak_5 
schema_voice vmage1 1 backtozero  

//TO ALERT 2
schema mg1a2
archetype AI_MINOR
mg1a2__1 mg1a2__2 mg1a2__3 
schema_voice vmage1 1 toleveltwo  

//		+sighted
schema mg1a2v
archetype AI_MINOR
mg1a2v_1
schema_voice vmage1 1 toleveltwo (Sense Sight)  

//		+heard
schema mg1a2h
archetype AI_MINOR
mg1a2h_1 mg1a2h_2 
schema_voice vmage1 2 toleveltwo (Sense Sound)


//AT ALERT 2 & 3 +Investigating
schema mg1at2
archetype AI_MINOR
delay 1000
no_repeat
mono_loop 9000 18000
mg1a2se1 mg1a2se2 mg1a3se1 mg1a3se2 mg1a3se3 mg1m1602
schema_voice vmage1 99 atleveltwo (Investigate true)
schema_voice vmage1 99 atlevelthree (Investigate true)


//TO LEVEL THREE
schema mg1a3
archetype AI_MAJOR
mg1a3s_1 mg1a3s_2 mg1a3s_3 mg1a3na1 mg1a3na2 mg1a3na3 mg1a3na4 mg1sec_1 mg1sec_2
schema_voice vmage1 1 tolevelthree
schema_voice vmage1 1 spotplayer

//		+carrying a body
schema mg1a3b
archetype AI_MORE_MAJOR
mg1a3b_1 
schema_voice vmage1 9 spotplayer (CarryBody True)

//		+w/co
schema mg1telr
archetype AI_COMBAT
mg1telr1 mg1telr2 mg1telr3 
schema_voice vmage1 3 spotplayer (NearbyFriends 0 20) 


//LOST CONTACT W/PLAYER
schema mg1los
archetype AI_NONE
mg1los_1 mg1los_2 mg1m1606
schema_voice vmage1 1 lostcontact  

//RE-SPOTTED PLAYER AFTER A SEARCH +w/co
schema mg1telc
archetype AI_COMBAT
mg1telc1 mg1telc2 mg1telc3 
schema_voice vmage1 3 spotplayer (NearbyFriends 0 20) (Reacquire True) 


//REACT CHARGE
schema mg1chga
archetype AI_MORE_MAJOR
mg1chga1 freq 3
mg1chga2 freq 3 
mg1hit_2 freq 3
mg1m1601 freq 1
schema_voice vmage1 1 reactcharge
schema_voice vmage1 1 outofreach

//		+w/co
schema mg1chgw
archetype AI_COMBAT
mg1chgw1 mg1chgw2 
schema_voice vmage1 3 reactcharge (NearbyFriends 0 20)

//REACT GET READY TO FIRE YOUR BOW
schema mg1bow
archetype AI_MORE_MAJOR
no_repeat
mg1atb_1 mg1atb_2 mg1atb_3 
schema_voice vmage1 1 reactshoot

//REACT RUN AWAY -All except THIEVE's
schema mg1runa
archetype AI_MAJOR
mg1runa1 mg1runa2 
schema_voice vmage1 1 reactrun 

//REACT I SOUND THE ALARMS
schema mg1alma
archetype AI_MORE_MAJOR
mg1alma1 
schema_voice vmage1 1 reactalarm

//		+w/co
schema mg1almw
archetype AI_COMBAT
mg1almw1 
schema_voice vmage1 3 reactalarm (NearbyFriends 0 20)

//FRUSTRATION -SEE REACTCHARGE

//FOUND BODY
schema mg1bod
archetype AI_MORE_MAJOR
mg1bod_1
schema_voice vmage1 1 foundbody  

//FOUND SOMETHING MISSING 
schema mg1mis
archetype AI_MAJOR
mg1mis_1 mg1mis_2 
schema_voice vmage1 1 foundmissing 

//FOUND A SMALL ANOMALY
schema mg1sma
archetype AI_MINOR
mg1sma_1 mg1sma_2
schema_voice vmage1 1 foundsmall  

//FOUND A LARGE ANOMALY
schema mg1lar
archetype AI_MAJOR
mg1lar_1 mg1lar_2
schema_voice vmage1 1 foundlarge

//FOUND A SECURITY BREACH
schema mg1sec
archetype AI_MORE_MAJOR
mg1sec_1 mg1sec_2
schema_voice vmage1 1 foundbreach 

//RECENTLY SAW THE PLAYER +w/co All except THIEVE's
schema mg1rint
archetype AI_INFORM
mg1rint1 mg1rint2
schema_voice vmage1 1 recentintruder

//RECENTLY FOUND BODY +w/co 
schema mg1rbod
archetype AI_INFORM
mg1rbod1 mg1rbod2
schema_voice vmage1 1 recentbody 

//RECENTLY FOUND SOMETHING MISSING +w/co -All except THIEVE's
schema mg1rmis
archetype AI_INFORM
mg1rmis1 mg1rmis2 mg1rmis3
schema_voice vmage1 1 recentmissing 

//RECENTLY FOUND MISC ANAMOLY +w/co
schema mg1roth
archetype AI_INFORM
mg1roth1 mg1roth2 
schema_voice vmage1 1 recentother 



//COMBAT

//SUCCESSFULLY HIT THE PLAYER +not losing
schema mg1hit
archetype AI_COMBAT
mg1hit_1 mg1hit_2
schema_voice vmage1 1 comsucchit (ComBal Winning Even)

//		+not losing +w/co
schema mg1hitw
archetype AI_COMBAT
mg1hitw1
schema_voice vmage1 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

//HIT BY THE PLAYER W/HI HIT PTS 
schema mg1hhi
archetype AI_MAJOR
mg1hhi_1 mg1hhi_2 mg1hhi_3 mg1hhi_4 mg1hhi_5
schema_voice vmage1 1 comhithigh

//HIT BY THE PLAYER W/LO PTS 
schema mg1hlo
archetype AI_MORE_MAJOR
mg1hlo_1 mg1hlo_2 mg1hlo_3 mg1hlow1
schema_voice vmage1 1 comhitlow

//HIT BY THE PLAYER NO DAMAGE
schema mg1hnd
archetype AI_MAJOR
mg1hnd_1
schema_voice vmage1 1 comhitnodam

//AMBUSHED -HIT BY UNSEEN PLAYER
schema mg1amb 
archetype AI_MAJOR
mg1amb_1 mg1amb_2 
schema_voice vmage1 1 comhitamb

//		+w/co
schema mg1ambw
archetype AI_COMBAT
mg1ambw1
schema_voice vmage1 2 comhitamb (NearbyFriends 0 20)

//DEATH BY COMBAT -LOUD
schema mg1diec
archetype AI_COMBAT
mg1diec1 mg1diec2 mg1diec3
schema_voice vmage1 1 comdieloud

//DEATH (or knocked out) BY AMBUSH -MORE MUFFLED
schema mg1diea
archetype AI_MINOR
volume -500
mg1diea1 mg1diea2 mg1diea3
schema_voice vmage1 1 comdiesoft


//////////////////////////
//MISSION SPECIFIC STUFF//
//////////////////////////

//"Resistance is futile."
//schema mg1m1601
//archetype AI_NONE
//mg1m1601 
//schema_voice vmage1 1 mg_m1601

//"You cannot escape the inevitable."
//schema mg1m1602
//archetype AI_NONE
//mg1m1602
//schema_voice vmage1 1 mg_m1602

//"His winds blow quickly."
//schema mg1m1606
//archetype AI_NONE
//mg1m1606
//schema_voice vmage1 1 mg_m1602


