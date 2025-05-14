//THIEF1 -Mike Romatelli

/////////////
//AI SPEECH//
/////////////

//ASLEEP
schema th1a0sn
archetype AI_NONE
volume -500
mono_loop 2000 3000
sg2a0sn1 sg2a0sn2 sg2a0sn3 
schema_voice vthief1 1 sleeping

//AT ALERT 0
schema th1a0hu
archetype AI_NONE
volume -500
mono_loop 2000 20000
th1a0hu1 th1a0hu2 th1a0hu3 th1a0wh1 th1a0wh2 th1a0wh3 th1a0br1 th1a0br2 th1a0br3 th1a0br4 th1a0co1 th1a0co2 th1a0co3 th1a0co4
schema_voice vthief1 3 atlevelzero


//TO ALERT 1
schema th1a1
archetype AI_NONE
th1a1__1 th1a1__2 th1a1__3 th1a1__4
schema_voice vthief1 1 tolevelone  

//		+sighted
schema th1a1v
archetype AI_NONE
th1a1v_1 th1a1v_2
schema_voice vthief1 2 tolevelone (Sense Sight)

//		+heard
schema th1a1h
archetype AI_NONE
th1a1h_1 th1a1h_2
schema_voice vthief1 2 tolevelone (Sense Sound)

//		+w/co
schema th1a1_w
archetype AI_MINOR
th1a1_w1 th1a1_w2
schema_voice vthief1 2 tolevelone (NearbyFriends 0 20)

//		+sighted +w/co
schema th1a1vw
archetype AI_MINOR
th1a1vw1 th1a1vw2 th1a1vw3 th1a1vw4
schema_voice vthief1 3 tolevelone (Sense Sight) (NearbyFriends 0 20)

//		+heard +w/co
schema th1a1hw
archetype AI_MINOR
th1a1hw1 th1a1hw2 th1a1hw3 th1a1hw4
schema_voice vthief1 3 tolevelone (Sense Sound) (NearbyFriends 0 20)


//AT ALERT 1, 2 & 3
schema th1at1
archetype AI_NONE
volume -500
delay 5000
mono_loop 2000 20000
th1a0tk1 th1a0tk2 th1a0tk3 th1a0mu1 th1a0mu2 th1a0mu3
schema_voice vthief1 1 atlevelone
schema_voice vthief1 1 atleveltwo
schema_voice vthief1 1 atlevelthree


//BACK TO ALERT 0
schema th1bak
archetype AI_NONE
th1bak_1 th1bak_2 th1bak_3 th1bak_4 
schema_voice vthief1 1 backtozero  



//TO ALERT 2
schema th1a2
archetype AI_MINOR
th1a2__1 th1a2__2 th1a2__3 th1a2__4
schema_voice vthief1 1 toleveltwo  

//		+sighted
schema th1a2v
archetype AI_MINOR
th1a2v_1
schema_voice vthief1 1 toleveltwo (Sense Sight)  

//		+heard
schema th1a2h
archetype AI_MINOR
th1a2h_1 th1a2h_2 th1a2h_3
schema_voice vthief1 2 toleveltwo (Sense Sound)


//AT ALERT 2 +Investigating
schema th1at2inv
archetype AI_MINOR
delay 3000
no_repeat
mono_loop 10000 20000
th1a2se1 th1a2se2 th1a2se3 th1a2se4 th1a3se1 th1a3se2 th1a3se3 th1a3se4
schema_voice vthief1 99 atleveltwo (Investigate true)
schema_voice vthief1 99 atlevelthree (Investigate true)


//TO ALERT 3
schema th1a3
archetype AI_MORE_MAJOR
th1a3s_1 th1a3s_2 th1a3s_3 th1a3s_4 th1a3na1 th1a3na2 th1a3na3 th1a3na4 
schema_voice vthief1 1 tolevelthree
schema_voice vthief1 1 spotplayer

//		+w/co 
schema th1telr
archetype AI_COMBAT
th1telr1 th1telr2 th1telr3 th1telr4 th1telr5
schema_voice vthief1 3 spotplayer (NearbyFriends 0 20)

//		+carrying a body
schema th1a3b
archetype AI_MORE_MAJOR
th1a3b_1 
schema_voice vthief1 9 spotplayer (CarryBody True)


//LOST CONTACT W/PLAYER
schema th1los
archetype AI_NONE
th1los_1 th1los_2 th1los_3
schema_voice vthief1 1 lostcontact  


//RE-SPOTTED PLAYER AFTER A SEARCH +w/co
schema th1telc
archetype AI_COMBAT
th1telc1 th1telc2 th1telc3
schema_voice vthief1 3 spotplayer (NearbyFriends 0 20) (Reacquire True) 


//REACT CHARGE
schema th1chga
archetype AI_MORE_MAJOR
th1chga1 th1chga2 
schema_voice vthief1 1 reactcharge

//		+w/co
schema th1chgw
archetype AI_COMBAT
th1chgw1 th1chgw2 th1chgw3
schema_voice vthief1 3 reactcharge (NearbyFriends 0 20)

//REACT GET READY TO FIRE YOUR BOW
schema th1bow
archetype AI_MORE_MAJOR
no_repeat
th1atb_1 th1atb_2 th1atb_3
schema_voice vthief1 1 reactshoot

//REACT RUN AWAY
schema th1runa
archetype AI_MAJOR
th1runa1 th1runa2 th1runa3
schema_voice vthief1 1 reactrun 


//REACT I SOUND THE ALARMS
schema th1alma
archetype AI_MORE_MAJOR
th1alma1 
schema_voice vthief1 1 reactalarm

//		+w/co
schema th1almw
archetype AI_COMBAT
th1almw1 th1almw2
schema_voice vthief1 3 reactalarm (NearbyFriends 0 20)


//FRUSTRATION
schema th1frust
archetype AI_MAJOR
th1det_2 
schema_voice vthief1 1 outofreach
 

//FOUND BODY
schema th1bod
archetype AI_MORE_MAJOR
th1bod_1 th1bod_2 th1bod_3
schema_voice vthief1 1 foundbody  

//FOUND SOMETHING MISSING
schema th1mis
archetype AI_MAJOR
th1mis_1 th1mis_2 
schema_voice vthief1 1 foundmissing


//NOTICED A TORCH BEING DOUSED
//schema th1torch
//archetype AI_MINOR
//delay 1000
// ????
//schema_voice vthief1 1 noticetorch

//FOUND A SMALL ANOMALY
schema th1sma
archetype AI_MINOR
th1sma_1 th1sma_2 th1sma_3 
schema_voice vthief1 1 foundsmall  

//FOUND A LARGE ANOMALY
schema th1lar
archetype AI_MAJOR
th1lar_1 th1lar_2
schema_voice vthief1 1 foundlarge

//FOUND A SECURITY BREACH 
schema th1sec
archetype AI_MORE_MAJOR
th1sec_1 th1sec_2 
schema_voice vthief1 1 foundbreach 

//RECENTLY SAW THE PLAYER +w/co 
schema th1rint
archetype AI_INFORM
th1rint1 th1rint2 th1rint3
schema_voice vthief1 1 recentintruder 


//RECENTLY FOUND BODY +w/co 
schema th1rbod
archetype AI_INFORM
th1rbod1 th1rbod2 th1rbod3
schema_voice vthief1 1 recentbody 


//RECENTLY FOUND SOMETHING MISSING +w/co 
schema th1rmis
archetype AI_INFORM
th1rmis1 th1rmis2 th1rmis3
schema_voice vthief1 1 recentmissing 

//RECENTLY FOUND MISC ANAMOLY +w/co 
schema th1roth
archetype AI_INFORM
th1roth1 th1roth2 
schema_voice vthief1 1 recentother 


//COMBAT
//ATTACKING +not losing
schema th1atn
archetype AI_COMBAT
th1atn_1 freq 1
th1atn_2 freq 1
th1atn_3 freq 2
th1atn_4 freq 2
th1atn_5 freq 2
schema_voice vthief1 1 comattack (ComBal Winning Even)

//		+winning
schema th1atnw
archetype AI_COMBAT
th1atw_1
schema_voice vthief1 2 comattack (ComBal Winning)

//		+winning +w/co
schema th1atww
archetype AI_COMBAT
th1atww1 
schema_voice vthief1 3 comattack (ComBal Winning) (NearbyFriends 0 20)

//		+losing
schema th1atl
archetype AI_COMBAT
th1atl_1 th1atl_2 th1atl_3 th1atl_4
schema_voice vthief1 2 comattack (ComBal Losing)


//SUCCESSFULLY HIT THE PLAYER +not losing
schema th1hit
archetype AI_COMBAT
th1hit_1 th1hit_2 th1hit_3 
schema_voice vthief1 1 comsucchit (ComBal Winning Even)

//		+not losing +w/co
schema th1hitw
archetype AI_COMBAT
th1hitw1 th1hitw2
schema_voice vthief1 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)


//SUCCESSFULLY BLOCKED THE PLAYER +not losing
schema th1blk
archetype AI_COMBAT
th1blk_1 th1blk_2 
schema_voice vthief1 1 comsuccblock (ComBal Winning Even)

//		+not losing +w/co
schema th1blkw
archetype AI_COMBAT
th1blkw1
schema_voice vthief1 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)


//HIT BY THE PLAYER W/HI HIT PTS 
schema th1hhi
archetype AI_MAJOR
th1hhi_1 th1hhi_2 th1hhi_3
schema_voice vthief1 1 comhithigh

//HIT BY THE PLAYER W/LO PTS 
schema th1hlo
archetype AI_MORE_MAJOR
th1hlo_1 th1hlo_2 th1hlo_3 
schema_voice vthief1 1 comhitlow
schema_voice vass1 1 comhitlow

//		+w/co
schema th1hlow
archetype AI_COMBAT
th1hlow1
schema_voice vthief1 2 comhitlow (NearbyFriends 0 20)

//HIT BY THE PLAYER NO DAMAGE
schema th1hnd
archetype AI_MAJOR
th1hnd_1 th1hnd_2 th1hnd_3
schema_voice vthief1 1 comhitnodam

//BLOCKED BY THE PLAYER +not losing
schema th1bkd 
archetype AI_COMBAT
th1bkd_1 th1bkd_2 
schema_voice vthief1 1 comblocked (ComBal Winning Even)

//		+not losing +w/co
schema th1bkdw 
archetype AI_COMBAT
th1bkdw1
schema_voice vthief1 1 comblocked (ComBal Winning Even) (NearbyFriends 0 20)


//DETECTED PLAYER TRYING TO BLOCK +not losing
schema th1det 
archetype AI_COMBAT
th1det_1 th1det_2 
schema_voice vthief1 1 comdetblock(ComBal Winning Even)

//		+not losing +w/co
schema th1detw 
archetype AI_COMBAT
th1detw1
schema_voice vthief1 2 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)



//AMBUSHED -HIT BY UNSEEN PLAYER
schema th1amb 
archetype AI_MAJOR
th1amb_1 th1amb_2 
schema_voice vthief1 1 comhitamb

//		+w/co
schema th1ambw
archetype AI_COMBAT
th1ambw1 th1ambw2 
schema_voice vthief1 2 comhitamb (NearbyFriends 0 20)


//DEATH BY COMBAT -LOUD
schema th1diec
archetype AI_COMBAT
th1diec1 th1diec2 th1diec3
schema_voice vthief1 1 comdieloud


//DEATH (or knocked out) BY AMBUSH -MORE MUFFLED
schema th1diea
archetype AI_MINOR
volume -500
th1diea1 th1diea2 th1diea3
schema_voice vthief1 1 comdiesoft



