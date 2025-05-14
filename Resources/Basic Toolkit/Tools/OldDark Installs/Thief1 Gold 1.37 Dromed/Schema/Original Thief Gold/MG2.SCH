//MAGE 2 -Fred S. Galpern

/////////////
//AI SPEECH//
/////////////

//AT ALERT 0 
schema mg2a0
archetype AI_NONE
volume -500
delay 1500
mono_loop 2000 15000
mg2a0hu1 mg2a0hu2 mg2a0hu3 mg2a0co1 mg2a0co2 mg2a0co3 mg2a0co4 mg2a0ch1 mg2a0ch2 mg2a0ch3
schema_voice vmage2 1 atlevelzero


//TO ALERT 1
schema mg2a1
archetype AI_NONE
mg2a1__1 mg2a1__2 mg2a1__3
schema_voice vmage2 1 tolevelone  

//		+sighted
schema mg2a1v
archetype AI_NONE
mg2a1v_1 
schema_voice vmage2 2 tolevelone (Sense Sight)

//		+heard
schema mg2a1h
archetype AI_NONE
mg2a1h_1 mg2a1h_2 mg2a1hw2
schema_voice vmage2 2 tolevelone (Sense Sound)

//		+w/co
schema mg2a1_w
archetype AI_MINOR
mg2a1_w1 
schema_voice vmage2 2 tolevelone (NearbyFriends 0 20)

//		+sighted +w/co
schema mg2a1vw
archetype AI_MINOR
mg2a1vw1 mg2a1vw2
schema_voice vmage2 3 tolevelone (Sense Sight) (NearbyFriends 0 20)

//		+heard +w/co
schema mg2a1hw
archetype AI_MINOR
mg2a1hw1 mg2a1hw2 mg2a1hw3
schema_voice vmage2 3 tolevelone (Sense Sound) (NearbyFriends 0 20)


//AT ALERT 1, 2 & 3
schema mg2at1
archetype AI_NONE
volume -500
delay 6000
mono_loop 2000 15000
mg2a0co1 mg2a0co2 mg2a0co3 mg2a0co4
schema_voice vmage2 1 atlevelone
schema_voice vmage2 1 atleveltwo
schema_voice vmage2 1 atlevelthree


//BACK TO ALERT 0
schema mg2bak
archetype AI_NONE
mg2bak_1 mg2bak_2 mg2bak_3 mg2bak_4 mg2bak_5
schema_voice vmage2 1 backtozero  



//TO ALERT 2
schema mg2a2
archetype AI_MINOR
mg2a2__1 mg2a2__2 mg2a2__3 
schema_voice vmage2 1 toleveltwo  

//		+sighted
schema mg2a2v
archetype AI_MINOR
mg2a2v_1
schema_voice vmage2 1 toleveltwo (Sense Sight)  

//		+heard
schema mg2a2h
archetype AI_MINOR
mg2a2h_1 mg2a2h_2 
schema_voice vmage2 2 toleveltwo (Sense Sound)


//AT ALERT 2 & 3 +Investigating
schema mg2at2
archetype AI_MINOR
delay 3000
no_repeat
mono_loop 6000 18000
mg2a2se1 mg2a2se2 mg2a2se3 mg2a2se4 mg2a3se1 mg2a3se2 mg2a3se3 Mg2det_1
schema_voice vmage2 99 atleveltwo (Investigate true)
schema_voice vmage2 99 atlevelthree (Investigate true)


//TO LEVEL THREE
schema mg2a3
archetype AI_MAJOR
mg2a3s_1 mg2a3s_2 mg2a3s_3 mg2a3na1 mg2a3na2 mg2a3na3 mg2a3na4
schema_voice vmage2 1 tolevelthree
schema_voice vmage2 1 spotplayer

//		+carrying a body
schema mg2a3b
archetype AI_MORE_MAJOR
mg2a3b_1 
schema_voice vmage2 9 spotplayer (CarryBody True)

//		+w/co
schema mg2telr
archetype AI_COMBAT
mg2telr1 mg2telr2 mg2telr3 
schema_voice vmage2 3 spotplayer (NearbyFriends 0 20) 


//LOST CONTACT W/PLAYER
schema mg2los
archetype AI_NONE
mg2los_1 mg2los_2
schema_voice vmage2 1 lostcontact  

//RE-SPOTTED PLAYER AFTER A SEARCH +w/co
schema mg2telc
archetype AI_COMBAT 
mg2telc1 mg2telc2 mg2telc3 mg2telc4
schema_voice vmage2 3 spotplayer (NearbyFriends 0 20) (Reacquire True) 


//REACT CHARGE
schema mg2chga
archetype AI_MORE_MAJOR
mg2chga1 mg2chga2 mg2hit_2
schema_voice vmage2 1 reactcharge
schema_voice vmage2 1 outofreach

//		+w/co
schema mg2chgw
archetype AI_COMBAT
mg2chgw1 mg2chgw2 
schema_voice vmage2 3 reactcharge (NearbyFriends 0 20)

//REACT GET READY TO FIRE YOUR BOW
schema mg2bow
archetype AI_MORE_MAJOR
no_repeat
mg2atb_1 mg2atb_2 mg2atb_3 
schema_voice vmage2 1 reactshoot



//REACT RUN AWAY 
schema mg2runa
archetype AI_MAJOR
mg2runa1 mg2runa2 
schema_voice vmage2 1 reactrun 




//REACT I SOUND THE ALARMS
schema mg2alma
archetype AI_MORE_MAJOR
mg2alma1 mg2alma2
schema_voice vmage2 1 reactalarm

//		+w/co
schema mg2almw
archetype AI_COMBAT
mg2almw1 
schema_voice vmage2 3 reactalarm (NearbyFriends 0 20)


//FRUSTRATION -see REACTCHARGE


//FOUND BODY
schema mg2bod
archetype AI_MORE_MAJOR
mg2bod_1 mg2bod_2
schema_voice vmage2 1 foundbody  



//FOUND SOMETHING MISSING 
schema mg2mis
archetype AI_MAJOR
mg2mis_1 mg2mis_2 
schema_voice vmage2 1 foundmissing 


//FOUND A SMALL ANOMALY
schema mg2sma
archetype AI_MINOR
mg2sma_1 mg2sma_2
schema_voice vmage2 1 foundsmall  

//FOUND A LARGE ANOMALY
schema mg2lar
archetype AI_MAJOR
mg2lar_1 mg2lar_2
schema_voice vmage2 1 foundlarge


//FOUND A SECURITY BREACH
schema mg2sec
archetype AI_MORE_MAJOR
mg2sec_1 mg2sec_2
schema_voice vmage2 1 foundbreach 



//RECENTLY SAW THE PLAYER +w/co
schema mg2rint
archetype AI_INFORM
mg2rint1 mg2rint2
schema_voice vmage2 1 recentintruder



//RECENTLY FOUND BODY +w/co 
schema mg2rbod
archetype AI_INFORM
mg2rbod1 mg2rbod2
schema_voice vmage2 1 recentbody 




//RECENTLY FOUND SOMETHING MISSING +w/co 
schema mg2rmis
archetype AI_INFORM
mg2rmis1 mg2rmis2 mg2rmis3
schema_voice vmage2 1 recentmissing 



//RECENTLY FOUND MISC ANAMOLY +w/co
schema mg2roth
archetype AI_INFORM
mg2roth1 mg2roth2 
schema_voice vmage2 1 recentother 



//COMBAT

//SUCCESSFULLY HIT THE PLAYER +not losing
schema mg2hit
archetype AI_COMBAT
mg2hit_1 mg2hit_2 mg2m1603
schema_voice vmage2 1 comsucchit (ComBal Winning Even)

//		+not losing +w/co
schema mg2hitw
archetype AI_COMBAT
mg2hitw1
schema_voice vmage2 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

//HIT BY THE PLAYER W/HI HIT PTS 
schema mg2hhi
archetype AI_MAJOR
mg2hhi_1 mg2hhi_2 mg2hhi_3 mg2m1609
schema_voice vmage2 1 comhithigh

//HIT BY THE PLAYER W/LO PTS 
schema mg2hlo
archetype AI_MORE_MAJOR
mg2hlo_1 mg2hlo_2 mg2hlo_3 mg2hlow1
schema_voice vmage2 1 comhitlow


//HIT BY THE PLAYER NO DAMAGE
schema mg2hnd
archetype AI_MAJOR
mg2hnd_1 mg2hnd_2 mg2m1604 
schema_voice vmage2 1 comhitnodam





//AMBUSHED -HIT BY UNSEEN PLAYER
schema mg2amb 
archetype AI_MAJOR
mg2amb_1 mg2amb_2 mg2amb_3
schema_voice vmage2 1 comhitamb


//		+w/co
schema mg2ambw
archetype AI_COMBAT
mg2ambw1
schema_voice vmage2 2 comhitamb (NearbyFriends 0 20)




//DEATH BY COMBAT -LOUD
schema mg2diec
archetype AI_COMBAT
mg2diec1 mg2diec2 mg2diec3
schema_voice vmage2 1 comdieloud

//DEATH (or knocked out) BY AMBUSH -MORE MUFFLED
schema mg2diea
archetype AI_MINOR
volume -500
mg2diea1 mg2diea2 mg2diea3
schema_voice vmage2 1 comdiesoft


//////////////////////////
//MISSION SPECIFIC STUFF//
//////////////////////////

//"The seasons move faster invader."
//schema mg2m1603
//archetype AI_NONE
//mg2m1603 
//schema_voice vmage2 1 mg_m1603

//"He strikes as a dying wind."
//schema mg2m1604
//archetype AI_NONE
//mg2m1604
//schema_voice vmage2 1 mg_m1604

//"The earth will protect me."
//schema mg2m1609
//archetype AI_NONE
//mg2m1609
//schema_voice vmage2 1 mg_m1609


