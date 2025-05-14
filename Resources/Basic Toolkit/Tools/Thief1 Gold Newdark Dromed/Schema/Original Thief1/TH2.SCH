//THIEF2 -Mike Chrzanowski

/////////////
//AI SPEECH//
/////////////

//ASLEEP
schema th2a0sn
archetype AI_NONE
volume -500
mono_loop 2000 3000
sg3a0sn1 sg3a0sn2 sg3a0sn3 
schema_voice vthief2 1 sleeping

//AT ALERT 0 -HUMMING & WHISTLING
schema th2a0co
archetype AI_NONE
volume -500
mono_loop 2000 20000
th2a0co1 th2a0co2 th2a0co3 th2a0co4 th2a0hu1 th2a0hu2 th2a0hu3 th2a0wh1 th2a0wh2 th2a0wh3 th2a0wh4 th2a0wh5 th2a0tc1 th2a0tc2 th2a0tc3
schema_voice vthief2 3 atlevelzero

//AT ALERT 0 -MUTTERING (less freq)
schema th2a0mu
archetype AI_NONE
volume -500
mono_loop 2000 20000
th2a0co1 th2a0co2 th2a0co3 th2a0co4 th2a0mu1 th2a0mu2 th2a0mu3 th2a0tc1 th2a0tc2 th2a0tc3 th2a0__1
schema_voice vthief2 1 atlevelzero


//TO ALERT 1
schema th2a1
archetype AI_NONE
th2a1__1 th2a1__2 th2a1__3 th2a1__4
schema_voice vthief2 1 tolevelone  

//		+sighted
schema th2a1v
archetype AI_NONE
th2a1v_1 th2a1v_2
schema_voice vthief2 2 tolevelone (Sense Sight)

//		+heard
schema th2a1h
archetype AI_NONE
th2a1h_1 th2a1h_2
schema_voice vthief2 2 tolevelone (Sense Sound)

//		+w/co
schema th2a1_w
archetype AI_MINOR
th2a1_w1 th2a1_w2
schema_voice vthief2 2 tolevelone (NearbyFriends 0 20)

//		+sighted +w/co
schema th2a1vw
archetype AI_MINOR
th2a1vw1 th2a1vw2 th2a1vw3 
schema_voice vthief2 3 tolevelone (Sense Sight) (NearbyFriends 0 20)

//		+heard +w/co
schema th2a1hw
archetype AI_MINOR
th2a1hw1 th2a1hw2 th2a1hw3 th2a1hw4
schema_voice vthief2 3 tolevelone (Sense Sound) (NearbyFriends 0 20)


//AT ALERT 1, 2 & 3
schema th2at1
archetype AI_NONE
volume -500
delay 5000
mono_loop 100 20000
th2a0tc1 th2a0tc2 th2a0tc3 th2a0__1 th2a0co1 th2a0co2 
schema_voice vthief2 1 atlevelone
schema_voice vthief2 1 atleveltwo
schema_voice vthief2 1 atlevelthree


//BACK TO ALERT 0
schema th2bak
archetype AI_NONE
th2bak_1 th2bak_2 th2bak_3 th2bak_4 
schema_voice vthief2 1 backtozero  



//TO ALERT 2
schema th2a2
archetype AI_MINOR
th2a2__1 th2a2__2 th2a2__3 th2a2__4
schema_voice vthief2 1 toleveltwo  

//		+sighted
schema th2a2v
archetype AI_MINOR
th2a2v_1
schema_voice vthief2 1 toleveltwo (Sense Sight)  

//		+heard
schema th2a2h
archetype AI_MINOR
th2a2h_1 th2a2h_2 th2a2h_3
schema_voice vthief2 2 toleveltwo (Sense Sound)


//AT ALERT 2 & 3 +Investigating
schema th2at2inv
archetype AI_MINOR
delay 3000
no_repeat
mono_loop 10000 20000
th2a2se1 th2a2se2 th2a2se3 th2a3se1 th2a3se2 th2a3se3 
schema_voice vthief2 99 atleveltwo (Investigate true)
schema_voice vthief2 99 atlevelthree (Investigate true)


//TO ALERT 3
schema th2a3
archetype AI_MORE_MAJOR
th2a3s_1 th2a3s_2 th2a3s_3 th2a3s_4 th2a3na1  th2a3na3 th2a3na4 //th2a3na2
schema_voice vthief2 1 tolevelthree
schema_voice vthief2 1 spotplayer

//		+w/co 
schema th2telr
archetype AI_COMBAT
th2telr1 th2telr2 th2telr3 th2telr4 th2telr5
schema_voice vthief2 3 spotplayer (NearbyFriends 0 20)

//		+carrying a body
schema th2a3b
archetype AI_MORE_MAJOR
th2a3b_1 
schema_voice vthief2 9 spotplayer (CarryBody True)


//LOST CONTACT W/PLAYER
schema th2los
archetype AI_NONE
th2los_1 th2los_2 th2los_3
schema_voice vthief2 1 lostcontact  


//RE-SPOTTED PLAYER AFTER A SEARCH +w/co
schema th2telc
archetype AI_COMBAT
th2telc1 th2telc2 th2telc3
schema_voice vthief2 3 spotplayer (NearbyFriends 0 20) (Reacquire True) 


//REACT CHARGE
schema th2chga
archetype AI_MORE_MAJOR
th2chga1 th2chga2
schema_voice vthief2 1 reactcharge

//		+w/co
schema th2chgw
archetype AI_COMBAT
th2chgw1 th2chgw2 th2chgw3
schema_voice vthief2 3 reactcharge (NearbyFriends 0 20)

//REACT GET READY TO FIRE YOUR BOW
//schema th2bow
//archetype AI_MORE_MAJOR
//no_repeat
//th2atb_1 th2atb_2 th2atb_3
//schema_voice vthief2 1 reactshoot

//REACT RUN AWAY
schema th2runa
archetype AI_MAJOR
th2runa1 th2runa2 th2runa3
schema_voice vthief2 1 reactrun 


//REACT I SOUND THE ALARMS
schema th2alma
archetype AI_MORE_MAJOR
th2alma1 
schema_voice vthief2 1 reactalarm

//		+w/co
schema th2almw
archetype AI_COMBAT
th2almw1 th2almw2
schema_voice vthief2 3 reactalarm (NearbyFriends 0 20)


//FRUSTRATION
//schema th2frust
//archetype AI_MAJOR
//    ? 
//schema_voice vthief2 1 outofreach
 

//FOUND BODY
schema th2bod
archetype AI_MORE_MAJOR
th2bod_1 th2bod_2 
schema_voice vthief2 1 foundbody  

//FOUND SOMETHING MISSING
schema th2mis
archetype AI_MAJOR
th2mis_1 th2mis_2 
schema_voice vthief2 1 foundmissing


//NOTICED A TORCH BEING DOUSED
//schema th2torch
//archetype AI_MINOR
//delay 1000
// ????
//schema_voice vthief2 1 noticetorch

//FOUND A SMALL ANOMALY
schema th2sma
archetype AI_MINOR
th2sma_1 th2sma_2 th2sma_3 
schema_voice vthief2 1 foundsmall  

//FOUND A LARGE ANOMALY
schema th2lar
archetype AI_MAJOR
th2lar_1 th2lar_2
schema_voice vthief2 1 foundlarge

//FOUND A SECURITY BREACH 
schema th2sec
archetype AI_MORE_MAJOR
th2sec_1 th2sec_2 
schema_voice vthief2 1 foundbreach 

//RECENTLY SAW THE PLAYER +w/co 
schema th2rint
archetype AI_INFORM
th2rint1 th2rint2 th2rint3
schema_voice vthief2 1 recentintruder 


//RECENTLY FOUND BODY +w/co 
schema th2rbod
archetype AI_INFORM
th2rbod1 th2rbod2 
schema_voice vthief2 1 recentbody 


//RECENTLY FOUND SOMETHING MISSING +w/co 
schema th2rmis
archetype AI_INFORM
th2rmis1 th2rmis2 th2rmis3
schema_voice vthief2 1 recentmissing 

//RECENTLY FOUND MISC ANAMOLY +w/co 
schema th2roth
archetype AI_INFORM
th2roth2 th2roth2 
schema_voice vthief2 1 recentother 


//COMBAT
//ATTACKING +not losing
schema th2atn
archetype AI_COMBAT
th2atn_1 freq 1
th2atn_2 freq 2
th2atn_3 freq 2
th2atn_4 freq 2
schema_voice vthief2 1 comattack (ComBal Winning Even)

//		+winning
schema th2atnw
archetype AI_COMBAT
th2atw_1
schema_voice vthief2 2 comattack (ComBal Winning)

//		+winning +w/co
schema th2atww
archetype AI_COMBAT
th2atww1 
schema_voice vthief2 3 comattack (ComBal Winning) (NearbyFriends 0 20)

//		+losing
schema th2atl
archetype AI_COMBAT
th2atl_1 th2atl_2 th2atl_3 
schema_voice vthief2 2 comattack (ComBal Losing)


//SUCCESSFULLY HIT THE PLAYER +not losing
schema th2hit
archetype AI_COMBAT
th2hit_1 th2hit_2 th2hit_3 
schema_voice vthief2 1 comsucchit (ComBal Winning Even)

//		+not losing +w/co
schema th2hitw
archetype AI_COMBAT
th2hitw1 th2hitw2
schema_voice vthief2 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)


//SUCCESSFULLY BLOCKED THE PLAYER +not losing
schema th2blk
archetype AI_COMBAT
th2blk_1 th2blk_2 
schema_voice vthief2 1 comsuccblock (ComBal Winning Even)

//		+not losing +w/co
schema th2blkw
archetype AI_COMBAT
th2blkw1
schema_voice vthief2 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)


//HIT BY THE PLAYER W/HI HIT PTS 
schema th2hhi
archetype AI_MAJOR
th2hhi_1 th2hhi_2 th2hhi_3
schema_voice vthief2 1 comhithigh

//HIT BY THE PLAYER W/LO PTS 
schema th2hlo
archetype AI_MORE_MAJOR
th2hlo_1 th2hlo_2 //th2hlo_3 <--MISSING SAMPLE!
schema_voice vthief2 1 comhitlow

//		+w/co
schema th2hlow
archetype AI_COMBAT
th2hlow1
schema_voice vthief2 2 comhitlow (NearbyFriends 0 20)

//HIT BY THE PLAYER NO DAMAGE
schema th2hnd
archetype AI_MAJOR
th2hnd_1 th2hnd_2 
schema_voice vthief2 1 comhitnodam

//BLOCKED BY THE PLAYER +not losing
schema th2bkd 
archetype AI_COMBAT
th2bkd_1 th2bkd_2 
schema_voice vthief2 1 comblocked (ComBal Winning Even)

//		+not losing +w/co
schema th2bkdw 
archetype AI_COMBAT
th2bkdw1
schema_voice vthief2 1 comblocked (ComBal Winning Even) (NearbyFriends 0 20)


//DETECTED PLAYER TRYING TO BLOCK +not losing
schema th2det 
archetype AI_COMBAT
th2det_1 th2det_2 
schema_voice vthief2 1 comdetblock(ComBal Winning Even)

//		+not losing +w/co
schema th2detw 
archetype AI_COMBAT
th2detw1
schema_voice vthief2 2 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)



//AMBUSHED -HIT BY UNSEEN PLAYER
schema th2amb 
archetype AI_MAJOR
th2amb_1 
schema_voice vthief2 1 comhitamb

//		+w/co
schema th2ambw
archetype AI_COMBAT
th2ambw1 th2ambw2 
schema_voice vthief2 2 comhitamb (NearbyFriends 0 20)


//DEATH BY COMBAT -LOUD
schema th2diec
archetype AI_COMBAT
th2diec1 th2diec2 
schema_voice vthief2 1 comdieloud


//DEATH (or knocked out) BY AMBUSH -MORE MUFFLED
schema th2diea
archetype AI_MINOR
volume -500
th2diea1 th2diea2 
schema_voice vthief2 1 comdiesoft



