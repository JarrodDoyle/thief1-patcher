//GUARD 1 -Dan

/////////////
//AI SPEECH//
/////////////

//ASLEEP
schema sg1a0sn
archetype AI_NONE
volume -500
mono_loop 2000 3000
sg1a0sn1 sg1a0sn2 sg1a0sn3 
schema_voice guard1 1 sleeping


//AT ALERT 0 -HUMMING & WHISTLING (Most Freq)
schema sg1a0hu
archetype AI_NONE
volume -500
mono_loop 2000 20000
sg1a0hu1 sg1a0hu2 sg1a0hu3 sg1a0wh1 sg1a0wh2 sg1a0wh3
schema_voice guard1 3 atlevelzero

//		-COUGHING
schema sg1a0co
archetype AI_NONE
volume -500
mono_loop 5000 20000
sg1a0co1 sg1a0co2 sg1a0co3 sg1a0co4 sg1a0th1 sg1a0th2 sg1a0th3
schema_voice guard1 2 atlevelzero

//		-MUTTERING (Least freq)
schema sg1a0mu
archetype AI_NONE
volume -500
mono_loop 7500 20000
sg1a0mu1 sg1a0mu2 sg1a0mu3
schema_voice guard1 1 atlevelzero (Mission 1 14)
schema_voice guard1 1 atlevelzero (Mission 16 17)


//TO ALERT 1
schema sg1a1
archetype AI_NONE
sg1a1__1 sg1a1__2 sg1a1__3 sg1a1__4 sg1a1__5 sg1a1__6
schema_voice guard1 1 tolevelone  

//		+sighted
schema sg1a1v
archetype AI_NONE
sg1a1v_1 sg1a1v_2
schema_voice guard1 2 tolevelone (Sense Sight)

//		+heard
schema sg1a1h
archetype AI_NONE
sg1a1h_1 sg1a1h_2 sg1a1h_3
schema_voice guard1 2 tolevelone (Sense Sound)

//		+w/co
schema sg1a1_w
archetype AI_MINOR
sg1a1_w1 sg1a1_w2
schema_voice guard1 2 tolevelone (NearbyFriends 0 20)

//		+sighted +w/co
schema sg1a1vw
archetype AI_MINOR
sg1a1vw1 sg1a1vw2 sg1a1vw3 sg1a1vw4
schema_voice guard1 3 tolevelone (Sense Sight) (NearbyFriends 0 20)

//		+heard +w/co
schema sg1a1hw
archetype AI_MINOR
sg1a1hw1 sg1a1hw2 sg1a1hw3 sg1a1hw4
schema_voice guard1 3 tolevelone (Sense Sound) (NearbyFriends 0 20)


//AT ALERT 1, 2 & 3
schema sg1a1tc
archetype AI_NONE
volume -500
delay 5000
mono_loop 2000 20000
sg1a0tc1 sg1a0tc2 sg1a0tc3 sg1a0cn1 sg1a0cn2 sg1a0cn3
schema_voice guard1 1 atlevelone
schema_voice guard1 1 atleveltwo
schema_voice guard1 1 atlevelthree


//BACK TO ALERT 0
schema sg1bak
archetype AI_NONE
sg1bak_1 sg1bak_2 sg1bak_3 sg1bak_4 sg1bak_5 sg1bak_6 sg1bak_7 sg1bak_8 
schema_voice guard1 1 backtozero  



//TO ALERT 2
schema sg1a2
archetype AI_MINOR
sg1a2__1 sg1a2__2 sg1a2__3 sg1a2__4 sg1a2__5
schema_voice guard1 1 toleveltwo  

//		+sighted
schema sg1a2v
archetype AI_MINOR
sg1a2v_1
schema_voice guard1 1 toleveltwo (Sense Sight)  

//		+heard
schema sg1a2h
archetype AI_MINOR
sg1a2h_1 sg1a2h_2 sg1a2h_3
schema_voice guard1 2 toleveltwo (Sense Sound)


//AT ALERT 2 +Investigating
schema sg1at2
archetype AI_MINOR
delay 3000
no_repeat
mono_loop 10000 20000
sg1a2se1 sg1a2se2 sg1a2se3 sg1a2se4 sg1a3se1 sg1a3se2 sg1a3se3 sg1a3se4
schema_voice guard1 99 atleveltwo (Investigate true)



//TO LEVEL THREE
schema sg1a3
archetype AI_MAJOR
sg1a3__1 sg1a3__2
schema_voice guard1 1 tolevelthree


//SPOTTED THE PLAYER -All except THIEVE's MISSION
schema sg1a3s
archetype AI_MORE_MAJOR
sg1a3s_1 sg1a3s_2 sg1a3s_3 sg1a3s_4
schema_voice guard1 1 spotplayer (Mission 1 14)
schema_voice guard1 1 spotplayer (Mission 16 17)

//		-THIEVE's ONLY
schema sg1a3s_m15
archetype AI_MORE_MAJOR
sg1a3na7 sg1a3s_2 sg1a3s_4
schema_voice guard1 1 spotplayer (Mission 15 15)

//(more sp)	-All except THIEVE's MISSION
schema sg1a3na
archetype AI_MORE_MAJOR
sg1a3na1 sg1a3na2 sg1a3na3 sg1a3na4 sg1a3na5 sg1a3na6 
schema_voice guard1 1 spotplayer (Mission 1 14)
schema_voice guard1 1 spotplayer (Mission 16 17)

//		-THIEVE's ONLY
schema sg1a3na_m15
archetype AI_MORE_MAJOR
sg1a3na1 sg1a3na2 sg1a3na3 sg1a3na4 sg1a3na7
schema_voice guard1 1 spotplayer (Mission 15 15)

//		-OPERA ONLY
schema sg1a3na_m17
archetype AI_MORE_MAJOR
sg117100 sg117101 sg117102
schema_voice guard1 1 spotplayer (Mission 17 17)


//		+carrying a body
schema sg1a3b
archetype AI_MORE_MAJOR
sg1a3b_1 
schema_voice guard1 9 spotplayer (CarryBody True)

//		+w/co -All except THIEVE's
schema sg1telr
archetype AI_COMBAT
sg1telr1 sg1telr2 sg1telr3 sg1telr4 sg1telr5
schema_voice guard1 3 spotplayer (NearbyFriends 0 20) (Mission 1 14)
schema_voice guard1 3 spotplayer (NearbyFriends 0 20) (Mission 16 17)

//		+w/co -THIEVE's ONLY
schema sg1telr_m15
archetype AI_COMBAT
sg1telr4 sg1telr6 sg1telr7
schema_voice guard1 3 spotplayer (NearbyFriends 0 20) (Mission 15 15)



//LOST CONTACT W/PLAYER
schema sg1los
archetype AI_NONE
sg1los_1 sg1los_2 sg1los_3 sg1los_4
schema_voice guard1 1 lostcontact  



//AT ALERT 3 +Investigating
schema sg1at3
archetype AI_MAJOR
delay 3000
no_repeat
mono_loop 10000 20000
sg1a2se1 sg1a2se2 sg1a2se3 sg1a2se4 sg1a3se1 sg1a3se2 sg1a3se3 sg1a3se4
schema_voice guard1 99 atlevelthree (Investigate true)



//RE-SPOTTED PLAYER AFTER A SEARCH +w/co -All except THIEVE's
schema sg1telc
archetype AI_COMBAT
sg1telc1 sg1telc2 sg1telc3 sg1telc4 sg1telc5 sg1telc6
schema_voice guard1 3 spotplayer (NearbyFriends 0 20) (Reacquire True) (Mission 1 14)
schema_voice guard1 3 spotplayer (NearbyFriends 0 20) (Reacquire True) (Mission 16 17)

//		-THIEVE's ONLY
schema sg1telc_m15
archetype AI_COMBAT
sg1telc3 sg1telc7
schema_voice guard1 5 spotplayer (NearbyFriends 0 20) (Reacquire True) (Mission 15 15)


//REACT 1ST WARNING
schema sg1warn1
archetype AI_NONE
sg1wrn11
schema_voice guard1 1 reactwarn

//REACT 2ND WARNING
schema sg1warn2
archetype AI_MINOR
sg1wrn21
schema_voice guard1 1 reactwarn2

//REACT ATTACK AFTER FINAL WARNING
schema sg1warnf
archetype AI_MAJOR
sg1wrnf1
schema_voice guard1 9 reactcharge (Reiterate 9 9)


//REACT CHARGE
schema sg1chga
archetype AI_MORE_MAJOR
sg1chga1 sg1chga2 
schema_voice guard1 1 reactcharge
schema_voice vass1 1 reactcharge

//		+w/co
schema sg1chgw
archetype AI_COMBAT
sg1chgw1 sg1chgw2 sg1chgw3
schema_voice guard1 3 reactcharge (NearbyFriends 0 20)
schema_voice vass1 3 reactcharge (NearbyFriends 0 20)

//REACT CHARGE
schema sg1chga_M17
archetype AI_MORE_MAJOR
sg117100 sg117102 sg117103
schema_voice guard1 1 reactcharge (Mission 17 17)

 

//REACT GET READY TO FIRE YOUR BOW
schema sg1bow
archetype AI_MORE_MAJOR
no_repeat
sg1atb_1 sg1atb_2 sg1atb_3 sg1atn_1
schema_voice guard1 1 reactshoot



//REACT RUN AWAY -All except THIEVE's
schema sg1runa
archetype AI_MAJOR
sg1runa1 sg1runa2 sg1runa3 sg1runa4
schema_voice guard1 1 reactrun (Mission 1 14)
schema_voice guard1 1 reactrun (Mission 16 17)

//		-THIEVE's ONLY
schema sg1runa_m15
archetype AI_MAJOR
sg1runa1 sg1runa2 sg1runa3
schema_voice guard1 1 reactrun (Mission 15 15)



//REACT I SOUND THE ALARMS
schema sg1alma
archetype AI_MORE_MAJOR
sg1alma1 sg1alma2 sg1alma3
schema_voice guard1 1 reactalarm

//		+w/co
schema sg1almw
archetype AI_COMBAT
sg1almw1 sg1almw2
schema_voice guard1 3 reactalarm (NearbyFriends 0 20)




//FRUSTRATION
schema sg1frust
archetype AI_MAJOR
sg1bkd_1 sg1bkd_2 sg1a2se2 sg1det_1
schema_voice guard1 1 outofreach
 

//FOUND BODY
schema sg1bod
archetype AI_MORE_MAJOR
sg1bod_1 sg1bod_2 sg1bod_3
schema_voice guard1 1 foundbody  



//FOUND SOMETHING MISSING -All except THIEVE's
schema sg1mis
archetype AI_MAJOR
sg1mis_1 sg1mis_2 sg1mis_5 sg1mis_6 sg1lar_2 
schema_voice guard1 1 foundmissing (Mission 1 14)
schema_voice guard1 1 foundmissing (Mission 16 17)

//		-BAFFORD ONLY
schema sg1mis_miss2
archetype AI_MAJOR
sg1mis_3
schema_voice guard1 1 foundmissing (Mission 2 2)

//		-SWORD ONLY
schema sg1mis_m06
archetype AI_MAJOR
sg1mis_4 
schema_voice guard1 1 foundmissing (Mission 6 6)

//		-THIEVE'S ONLY
schema sg1mis_m15
archetype AI_MAJOR
sg1mis_5 sg1mis_2 sg1mis_6 
schema_voice guard1 5 foundmissing (Mission 15 15)



//NOTICED A TORCH BEING DOUSED
schema sg1torch
archetype AI_MINOR
delay 1000
sg1a1__1 sg1a1__2 sg1a1__3 sg1a1__6 sg1sma_4 sg1bak_6
schema_voice guard1 1 noticetorch
schema_voice vass1 1 noticetorch



//FOUND A SMALL ANOMALY
schema sg1sma
archetype AI_MINOR
sg1sma_1 sg1sma_2 sg1sma_3 sg1sma_4
schema_voice guard1 1 foundsmall  

//FOUND A LARGE ANOMALY
schema sg1lar
archetype AI_MAJOR
sg1lar_1 sg1lar_3
schema_voice guard1 1 foundlarge


//FOUND A SECURITY BREACH -All except THIEVE's
schema sg1sec
archetype AI_MORE_MAJOR
sg1sec_1 sg1sec_2 sg1sec_3 sg1sec_4
schema_voice guard1 1 foundbreach (Mission 1 14)
schema_voice guard1 1 foundbreach (Mission 16 17)

//		-THIEVE's ONLY
schema sg1sec_m15
archetype AI_MORE_MAJOR
sg1sec_1 sg1sec_2 sg1sec_3
schema_voice guard1 1 foundbreach (Mission 15 15)



//RECENTLY SAW THE PLAYER +w/co All except THIEVE's
schema sg1rint
archetype AI_INFORM
sg1rint1 sg1rint2 sg1rint3
schema_voice guard1 1 recentintruder (Mission 1 14) 
schema_voice guard1 1 recentintruder (Mission 16 17) 

//		-THIEVE's ONLY
schema sg1rint_m15
archetype AI_INFORM
sg1rint4 sg1rint2 
schema_voice guard1 1 recentintruder (Mission 15 15) 



//RECENTLY FOUND BODY +w/co -All except THIEVE's
schema sg1rbod
archetype AI_INFORM
sg1rbod1 sg1rbod2 sg1rbod4
schema_voice guard1 1 recentbody (Mission 1 14) 
schema_voice guard1 1 recentbody (Mission 16 17) 

//RECENTLY FOUND BODY +w/co -BAFFORD ONLY
schema sg1rbod_miss2
archetype AI_INFORM
sg1rbod3
schema_voice guard1 2 recentbody (Mission 2 2)

//RECENTLY FOUND BODY +w/co -THIEVE's ONLY
schema sg1rbod_m15
archetype AI_INFORM
sg1rbod1 sg1rbod2
schema_voice guard1 1 recentbody (Mission 15 15)



//RECENTLY FOUND SOMETHING MISSING +w/co -All except THIEVE's
schema sg1rmis
archetype AI_INFORM
sg1rmis1 sg1rmis2 sg1rmis7
schema_voice guard1 1 recentmissing (Mission 1 14)
schema_voice guard1 1 recentmissing (Mission 16 17)

//		-BAFFORD ONLY
schema sg1rmis_miss2
archetype AI_INFORM
sg1rmis1 sg1rmis3
schema_voice guard1 5 recentmissing (Mission 2 2)

//		+w/co -SWORD ONLY
schema sg1rmis_m06
archetype AI_INFORM
sg1rmis4
schema_voice guard1 3 recentmissing (Mission 6 6)

//		+w/co -THIEVE'S ONLY
schema sg1rmis_m15
archetype AI_INFORM
sg1rmis5 sg1rmis6 sg1rmis7
schema_voice guard1 5 recentmissing (Mission 15 15)



//RECENTLY FOUND MISC ANAMOLY +w/co -All except THIEVE's
schema sg1roth
archetype AI_INFORM
sg1roth1 sg1roth2 sg1roth3 sg1roth4
schema_voice guard1 1 recentother (Mission 1 14)
schema_voice guard1 1 recentother (Mission 16 17)

//		-THIEVE's ONLY
schema sg1roth_m15
archetype AI_INFORM
sg1roth1 sg1roth2 Sg1rint4
schema_voice guard1 1 recentother (Mission 15 15)



//COMBAT
//ATTACKING +not losing
schema sg1atn
archetype AI_COMBAT
sg1atn_1 freq 1
sg1atn_2 freq 1
sg1atn_3 freq 3
sg1atn_4 freq 3
sg1atn_5 freq 3
schema_voice guard1 1 comattack (ComBal Winning Even)
schema_voice vass1 1 comattack (ComBal Winning Even)

//		+winning
schema sg1atnw
archetype AI_COMBAT
sg1atw_1 sg1atw_2
schema_voice guard1 2 comattack (ComBal Winning)
schema_voice vass1 2 comattack (ComBal Winning)

//		+winning +w/co
schema sg1atww
archetype AI_COMBAT
sg1atww1 
schema_voice guard1 3 comattack (ComBal Winning) (NearbyFriends 0 20)
schema_voice vass1 3 comattack (ComBal Winning) (NearbyFriends 0 20)

//		+losing
schema sg1atl
archetype AI_COMBAT
sg1atl_1 sg1atl_2 sg1atl_3 
schema_voice guard1 2 comattack (ComBal Losing)
schema_voice vass1 2 comattack (ComBal Losing)



//SUCCESSFULLY HIT THE PLAYER +not losing
schema sg1hit
archetype AI_COMBAT
sg1hit_1 sg1hit_2 sg1hit_3 sg1hit_4
schema_voice guard1 1 comsucchit (ComBal Winning Even)
schema_voice vass1 1 comsucchit (ComBal Winning Even)

//		+not losing +w/co
schema sg1hitw
archetype AI_COMBAT
sg1hitw1 sg1hitw2
schema_voice guard1 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vass1 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)



//SUCCESSFULLY BLOCKED THE PLAYER +not losing
schema sg1blk
archetype AI_COMBAT
sg1blk_1 sg1blk_2 sg1blk_3
schema_voice guard1 1 comsuccblock (ComBal Winning Even)
schema_voice vass1 1 comsuccblock (ComBal Winning Even)

//		+not losing +w/co
schema sg1blkw
archetype AI_COMBAT
sg1blkw1
schema_voice guard1 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vass1 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)



//HIT BY THE PLAYER W/HI HIT PTS 
schema sg1hhi
archetype AI_MAJOR
sg1hhi_1 sg1hhi_2 sg1hhi_3
schema_voice guard1 1 comhithigh
schema_voice vass1 1 comhithigh

//HIT BY THE PLAYER W/LO PTS 
schema sg1hlo
archetype AI_MORE_MAJOR
sg1hlo_1 sg1hlo_2 sg1hlo_3 
schema_voice guard1 1 comhitlow
schema_voice vass1 1 comhitlow

//		+w/co
schema sg1hlow
archetype AI_COMBAT
sg1hlow1 sg1hlo_1 
schema_voice guard1 2 comhitlow (NearbyFriends 0 20)
schema_voice vass1 2 comhitlow (NearbyFriends 0 20)

//HIT BY THE PLAYER NO DAMAGE
schema sg1hnd
archetype AI_MAJOR
sg1hnd_1 sg1hnd_2 sg1hnd_3 
schema_voice guard1 1 comhitnodam
schema_voice vass1 1 comhitnodam



//BLOCKED BY THE PLAYER +not losing
schema sg1bkd 
archetype AI_COMBAT
sg1bkd_1 sg1bkd_2 sg1bkd_3
schema_voice guard1 1 comblocked (ComBal Winning Even)
schema_voice vass1 1 comblocked (ComBal Winning Even)

//		+not losing +w/co
schema sg1bkdw 
archetype AI_COMBAT
sg1bkdw1
schema_voice guard1 1 comblocked (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vass1 1 comblocked (ComBal Winning Even) (NearbyFriends 0 20)
 


//DETECTED PLAYER TRYING TO BLOCK +not losing
schema sg1det 
archetype AI_COMBAT
sg1det_1 sg1det_2 sg1det_3
schema_voice guard1 1 comdetblock(ComBal Winning Even)
schema_voice vass1 1 comdetblock(ComBal Winning Even)

//		+not losing +w/co
schema sg1detw 
archetype AI_COMBAT
sg1detw1
schema_voice guard1 2 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vass1 2 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)


//AMBUSHED -HIT BY UNSEEN PLAYER
schema sg1amb 
archetype AI_MAJOR
sg1amb_1 sg1amb_2 sg1amb_3 sg1amb_4
schema_voice guard1 1 comhitamb
schema_voice vass1 1 comhitamb

//		+w/co
schema sg1ambw
archetype AI_COMBAT
sg1ambw1 sg1ambw2 sg1ambw3
schema_voice guard1 2 comhitamb (NearbyFriends 0 20)
schema_voice vass1 2 comhitamb (NearbyFriends 0 20)



//DEATH BY COMBAT -LOUD
schema sg1diec
archetype AI_COMBAT
sg1diec1 sg1diec2 sg1diec3
schema_voice guard1 1 comdieloud
schema_voice vass1 1 comdieloud

//DEATH (or knocked out) BY AMBUSH -MORE MUFFLED
schema sg1diea
archetype AI_MINOR
volume -500
sg1diea1 sg1diea2 sg1diea3
schema_voice guard1 1 comdiesoft
schema_voice vass1 1 comdiesoft


//////////////////////////
//MISSION SPECIFIC STUFF//
//////////////////////////

//MISSION 2
schema sg1m0203
archetype AI_NONE
sg1c3001 
schema_voice guard1 1 SG_M0203


//MISSION 5

//ASSASSIN 1 AFTER 'GARRETT' DIES
schema as1m0501
archetype AI_NONE
sg1m0500

//AFTER FINDING RAMIREZ DEAD
schema sg1m0501
archetype AI_MORE_MAJOR
sg1m0506
schema_voice vass1 1 sg_m0502
schema_voice guard1 1 sg_m0502

//ASSASSIN TO ALERT 1
schema as1a1
archetype AI_MINOR
sg1m0503 sg1m0504 sg1m0508
schema_voice vass1 1 tolevelone  

//ASSASSIN TO ALERT 2
schema as1a2
archetype AI_MAJOR
sg1m0505 sg1m0510 sg1m0509
schema_voice vass1 1 toleveltwo
schema_voice vass1 1 tolevelthree

//ASSASSIN TO ALERT 3
schema as1a3
archetype AI_MORE_MAJOR
sg1m0507 sg1m0501
schema_voice vass1 1 spotplayer=

//REACT TELL FRIEND BY REVELATION +w/co
schema as1telr
archetype AI_COMBAT
sg1telc3
schema_voice vass1 3 spotplayer (NearbyFriends 0 20)

//REACT TELL FRIEND BY CONFIRMATION +w/co
schema as1telc
archetype AI_COMBAT
sg1telc3
schema_voice vass1 3 spotplayer (NearbyFriends 0 20) (Reacquire True)

//BACK TO ALERT 0
schema as1bak
archetype AI_NONE
sg1bak_1 sg1bak_6 sg1bak_8 
schema_voice vass1 1 backtozero


