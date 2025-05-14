//GUARD 2 BROADCASTS -Geoff Stewart

/////////////
//AI SPEECH//
/////////////

//SLEEPING
schema sg2a0sn
archetype AI_NONE
volume -500
mono_loop 2000 3000
sg2a0sn1 sg2a0sn2 sg2a0sn3 sg2a0sn4
schema_voice guard2 1 sleeping


//AT ALERT 0 -WHISTLING, HUMMING & THROAT CLEARING
schema sg2a0
archetype AI_NONE
volume -500
mono_loop 7500 15000
sg2a0hu1 sg2a0hu2 sg2a0hu3 sg2a0wh1 sg2a0wh2 sg2a0wh3 sg2a0th1 sg2a0th2 sg2a0th3 sg2a0th4
schema_voice guard2 2 atlevelzero

//		-COUGHING & SIGHING
schema sg2a0co
archetype AI_NONE
volume -500
mono_loop 7500 15000
sg2a0co1 sg2a0co2 sg2a0co3 sg2a0tc1 sg2a0tc2 sg2a0tc3
schema_voice guard2 2 atlevelzero

//		-MUTTERING -All except THIEVE's (less freq)
schema sg2a0ch
archetype AI_NONE
volume -500
mono_loop 7500 15000
sg2a0mu1 sg2a0mu2 sg2a0mu3 sg2a0cn1 sg2a0cn2 sg2a0cn3
schema_voice guard2 1 atlevelzero (Mission 1 14)
schema_voice guard2 1 atlevelzero (Mission 16 17)


//TO ALERT 1
schema sg2a1
archetype AI_NONE
sg2a1__1 sg2a1__2 sg2a1__3 sg2a1__4 sg2a1__5 sg2a1__6  
schema_voice guard2 1 tolevelone 

//		+sighted
schema sg2a1v
archetype AI_NONE
sg2a1v_1 sg2a1v_2
schema_voice guard2 1 tolevelone (Sense Sight)

//		+heard
schema sg2a1h
archetype AI_NONE
sg2a1h_1 sg2a1h_2 sg2a1h_3
schema_voice guard2 2 tolevelone (Sense Sound)

//		+w/co
schema sg2a1_w
archetype AI_MINOR
sg2a1_w1 sg2a1_w2
schema_voice guard2 2 tolevelone (NearbyFriends 0 20)

//		+sighted +w/co
schema sg2a1vw
archetype AI_MINOR
sg2a1vw1 sg2a1vw2 sg2a1vw3 sg2a1vw4
schema_voice guard2 5 tolevelone (Sense Sight) (NearbyFriends 0 20)

//		+heard +w/co
schema sg2a1hw
archetype AI_MINOR
sg2a1hw1 sg2a1hw2 sg2a1hw3 sg2a1hw4
schema_voice guard2 5 tolevelone (Sense Sound) (NearbyFriends 0 20)


//AT ALERT 1, 2 & 3
schema sg2at1
archetype AI_NONE
delay 5000
volume -500
mono_loop 5000 20000
Sg2a0tc1 sg2a0tc2 sg2a0tc3
schema_voice guard2 1 atlevelone 
schema_voice guard2 1 atleveltwo 
schema_voice guard2 1 atlevelthree


//BACK TO ALERT 0
schema sg2bak
archetype AI_NONE
sg2bak_1 sg2bak_2 sg2bak_3 sg2bak_4 sg2bak_5 sg2bak_6 sg2bak_7 sg2bak_8 
schema_voice guard2 1 backtozero 



//TO ALERT 2
schema sg2a2
archetype AI_MINOR
sg2a2__1 sg2a2__2 sg2a2__3 sg2a2__4 sg2a2__5
schema_voice guard2 1 toleveltwo  

//		+sighted
schema sg2a2v
archetype AI_MINOR
sg2a2v_1 
schema_voice guard2 1 toleveltwo (Sense Sight)  

//		+heard
schema sg2a2h
archetype AI_MINOR
sg2a2h_1 sg2a2h_2 sg2a2h_3
schema_voice guard2 2 toleveltwo (Sense Sound)


//AT ALERT 2 +Investigating
schema sg2at2se
archetype AI_MINOR
delay 4500
mono_loop 10000 20000
no_repeat
sg2a2se1 sg2a2se2 sg2a2se3 sg2a2se4 sg2a3se2 sg2a3se3 sg2a3se4 
schema_voice guard2 99 atleveltwo (Investigate True)


//TO ALERT 3
schema sg2a3
archetype AI_MAJOR
Sg2a3s_2
schema_voice guard2 1 tolevelthree

//SPOTTED THE PLAYER
schema sg2a3s
archetype AI_MORE_MAJOR
sg2a3s_1 sg2a3s_2 sg2a3s_3 sg2a3s_4
schema_voice guard2 1 spotplayer

//(more s.p.)
schema sg2a3na
archetype AI_MORE_MAJOR
sg2a3na1 sg2a3na2 sg2a3na3 sg2a3na4 sg2a3na5 sg2a3na6 
schema_voice guard2 1 spotplayer 

//		+carrying a body
schema sg2a3b
archetype AI_MORE_MAJOR
sg2a3b_1 
schema_voice guard2 9 spotplayer (CarryBody True)

//		+w/co -All except THIEVE's
schema sg2telr
archetype AI_COMBAT
sg2telr1 sg2telr2 sg2telr3 sg2telr4 
schema_voice guard2 3 spotplayer (NearbyFriends 0 20) (Mission 1 14)
schema_voice guard2 3 spotplayer (NearbyFriends 0 20) (Mission 16 17)

//		+w/co -THIEVE's ONLY
schema sg2telr_m15
archetype AI_COMBAT
sg2telr1 sg2telr2 sg2telr4 
schema_voice guard2 3 spotplayer (NearbyFriends 0 20) (Mission 15 15)


//LOST CONTACT W/PLAYER
schema sg2los
archetype AI_NONE
sg2los_1 sg2los_2 sg2los_3 sg2los_4
schema_voice guard2 1 lostcontact  


//AT ALERT 3 +Investigating -All except THIEVES
schema sg2at3
delay 4500
mono_loop 10000 20000
no_repeat
archetype AI_MAJOR
sg2a2se1 sg2a2se2 sg2a2se3 sg2a2se4 sg2a3se1 sg2a3se2 sg2a3se3 sg2a3se4 
schema_voice guard2 99 atlevelthree (Investigate True) (Mission 1 14)
schema_voice guard2 99 atlevelthree (Investigate True) (Mission 16 17)

//		+Investigating -THIEVE's ONLY
schema sg2at3_m15
delay 4500
mono_loop 15000 25000
no_repeat
archetype AI_MAJOR
sg2a2se2 sg2a2se3 sg2a2se4 sg2a3se2 sg2a3se3 sg2a3se4 
schema_voice guard2 99 atlevelthree (Investigate True) (Mission 15 15)


//RE-SPOTTED THE PLAYER +w/co -All except THIEVE's
schema sg2telc
archetype AI_COMBAT
sg2telc1 sg2telc2 sg2telc3 sg2telc4 sg2telc5 sg2telc6
schema_voice guard2 5 spotplayer (NearbyFriends 0 20) (Reacquire True) (Mission 1 14)
schema_voice guard2 5 spotplayer (NearbyFriends 0 20) (Reacquire True) (Mission 16 17)

//		+w/co -THIEVE's ONLY
schema sg2telc_m15
archetype AI_COMBAT
sg2telc1 sg2telc2 sg2telc3 sg2telc5
schema_voice guard2 5 spotplayer (NearbyFriends 0 20) (Reacquire True) (Mission 15 15)


//REACT 1ST WARNING
schema sg2warn1
archetype AI_NONE
sg2wrn11
schema_voice guard2 1 reactwarn

//REACT 2ND WARNING
schema sg2warn2
archetype AI_MINOR
sg2wrn21
schema_voice guard2 1 reactwarn2

//REACT ATTACK AFTER FINAL WARNING
schema sg2warnf
archetype AI_MAJOR
sg2wrnf1
schema_voice guard2 9 reactcharge (Reiterate 9 9)



//REACT CHARGE +alone
schema sg2chga
archetype AI_MORE_MAJOR
sg2chga1 sg2chga2 sg2chgw2
schema_voice guard2 1 reactcharge
schema_voice vass2 1 reactcharge

//		+w/co -All except THIEVE's
schema sg2chgw
archetype AI_COMBAT
sg2chgw1 sg2chgw2 sg2chgw3 sg2chgw4
schema_voice guard2 2 reactcharge (NearbyFriends 0 20) (Mission 1 14)
schema_voice guard2 2 reactcharge (NearbyFriends 0 20) (Mission 16 17)
schema_voice vass2 2 reactcharge (NearbyFriends 0 20)

//		+w/co -THIEVE's ONLY
schema sg2chgw_m15
archetype AI_COMBAT
sg2chgw2 sg2chgw3 sg2chgw4
schema_voice guard2 2 reactcharge (NearbyFriends 0 20) (Mission 15 15)



//REACT GET READY TO FIRE YOUR BOW
schema sg2bow
archetype AI_MORE_MAJOR
no_repeat
sg2atb_1 sg2atb_2 sg2atb_3 Sg2atn_1 Sg2atw_2
schema_voice guard2 1 reactshoot


//REACT RUN AWAY -All except THIEVE's
schema sg2runa
archetype AI_MAJOR
sg2runa1 sg2runa2 sg2runa3 sg2runa4
schema_voice guard2 1 reactrun (Mission 1 14)
schema_voice guard2 1 reactrun (Mission 16 17)

//		-THIEVE's ONLY
schema sg2runa_m15
archetype AI_MAJOR
sg2runa1 sg2runa2 sg2runa3
schema_voice guard2 1 reactrun (Mission 15 15)


//REACT SOUND THE ALARMS
schema sg2alma
archetype AI_MORE_MAJOR
sg2alma1 sg2alma2 sg2alma3
schema_voice guard2 1 reactalarm 

//		+w/co
schema sg2almw
archetype AI_COMBAT
sg2almw1 sg2almw2
schema_voice guard2 3 reactalarm (NearbyFriends 0 20)



//FRUSTRATION
schema sg2frust
archetype AI_MAJOR
Sg2bkd_1 Sg2det_2 sg2runa3 Sg2a3s_3 Sg2a3se3
schema_voice guard2 1 outofreach



//FOUND BODY
schema sg2bod
archetype AI_MORE_MAJOR
sg2bod_1 sg2bod_2 sg2bod_3
schema_voice guard2 1 foundbody  



//FOUND SOMETHING MISSING -All except THIEVE's
schema sg2mis
archetype AI_MAJOR
sg2mis_1 sg2mis_3
schema_voice guard2 2 foundmissing (Mission 1 14)
schema_voice guard2 2 foundmissing (Mission 16 17)

//		-BAFFORD ONLY
schema sg2mis_miss2
archetype AI_MAJOR
sg2mis_2
schema_voice guard2 1 foundmissing (Mission 2 2)

//		-SWORD ONLY
schema sg2mis_m06
archetype AI_MAJOR
sg2mis_4
schema_voice guard2 1 foundmissing (Mission 6 6)

//		-THIEVE's ONLY
schema sg2mis_m15
archetype AI_MAJOR
sg2mis_3
schema_voice guard2 1 foundmissing (Mission 15 15)



//NOTICED A TORCH BEING DOUSED
schema sg2torch
archetype AI_MINOR
delay 1000
sg2a1__4 sg2a1__5 sg2a1__6
schema_voice guard2 1 noticetorch
schema_voice vass2 1 noticetorch



//FOUND A SMALL ANOMALY
schema sg2sma
archetype AI_MINOR
sg2sma_1 sg2sma_2 sg2sma_3 sg2sma_4
schema_voice guard2 1 foundsmall  

//FOUND A LARGE ANOMALY
schema sg2lar
archetype AI_MAJOR
sg2lar_1 sg2lar_2 sg2lar_3
schema_voice guard2 1 foundlarge


//FOUND A SECURITY BREACH -All except THIEVE's
schema sg2sec
archetype AI_MORE_MAJOR
sg2sec_1 sg2sec_2 sg2sec_3 sg2sec_4
schema_voice guard2 1 foundbreach (Mission 1 14)
schema_voice guard2 1 foundbreach (Mission 16 17)

//		-THIEVE's ONLY
schema sg2sec_m15
archetype AI_MORE_MAJOR
sg2sec_1 sg2sec_2 sg2sec_3
schema_voice guard2 1 foundbreach (Mission 15 15)


//RECENTLY SAW THE PLAYER +w/co -All except THIEVE's
schema sg2rint
archetype AI_INFORM
sg2rint1 sg2rint2 sg2rint3
schema_voice guard2 1 recentintruder (Mission 1 14)
schema_voice guard2 1 recentintruder (Mission 16 17)

//		-THIEVE's ONLY
schema sg2rint_m15
archetype AI_INFORM
sg2rint1 sg2rint2
schema_voice guard2 1 recentintruder (Mission 15 15)


//RECENTLY FOUND BODY +w/co
schema sg2rbod
archetype AI_INFORM
sg2rbod1 sg2rbod2 sg2rbod3 
schema_voice guard2 1 recentbody 



//RECENTLY FOUND SOMETHING MISSING +w/co -All except THIEVE's
schema sg2rmis
archetype AI_INFORM
sg2rmis1 sg2rmis2 sg2rmis4
schema_voice guard2 1 recentmissing (mission 1 14)
schema_voice guard2 1 recentmissing (mission 16 17)

//		+w/co -BAFF ONLY
schema sg2rmis_miss2
archetype AI_INFORM
sg2rmis3 
schema_voice guard2 1 recentmissing (Mission 2 2)

//		+w/co -THIEVE's ONLY
schema sg2rmis_m15
archetype AI_INFORM
sg2rmis1
schema_voice guard2 1 recentmissing (Mission 15 15)


//RECENTLY FOUND MISC ANAMOLY +w/co -All except THIEVE's
schema sg2roth
archetype AI_INFORM
sg2roth1 sg2roth2 sg2roth3 sg2roth4 sg2roth5
schema_voice guard2 1 recentother (Mission 1 14)
schema_voice guard2 1 recentother (Mission 16 17)

//		+w/co -THIEVE's ONLY
schema sg2roth_m15
archetype AI_INFORM
sg2roth1 sg2roth2 sg2roth3 sg2roth4
schema_voice guard2 1 recentother (Mission 15 15)



//COMBAT

//ATTACKING +not losing
schema sg2atn
archetype AI_COMBAT
sg2atn_1 sg2atn_2 sg2atn_3 sg2atn_4 sg2atn_5 sg2atn_6 
schema_voice guard2 1 comattack (ComBal Winning Even)
schema_voice vass2 1 comattack (ComBal Winning Even)

//		+winning
schema sg2atw
archetype AI_COMBAT
sg2atw_1 sg2atw_2
schema_voice guard2 3 comattack (ComBal Winning)

//		+winning +w/co
schema sg2atww
archetype AI_COMBAT
sg2atww1 
schema_voice guard2 3 comattack (ComBal Winning) (NearbyFriends 0 20)

//		+losing
schema sg2atl
archetype AI_COMBAT
sg2atl_1 sg2atl_2 sg2atl_3 
schema_voice guard2 5 comattack (ComBal Losing)
schema_voice drunk1 1 comattack
schema_voice vass2 5 comattack (ComBal Losing)



//SUCCESSFULLY HIT THE PLAYER +not losing
schema sg2hit
archetype AI_COMBAT
sg2hit_1 sg2hit_2 sg2hit_3 sg2hit_4
schema_voice guard2 1 comsucchit (ComBal Winning Even)

//		+not losing +w/co
schema sg2hitw
archetype AI_COMBAT
sg2hitw1 sg2hitw2
schema_voice guard2 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)



//SUCCESSFULLY BLOCKED THE PLAYER +not losing
schema sg2blk
archetype AI_COMBAT
sg2blk_1 sg2blk_2 sg2blk_3
schema_voice guard2 1 comsuccblock (ComBal Winning Even)

//		+not losing +w/co
schema sg2blkw
archetype AI_COMBAT
sg2blkw1
schema_voice guard2 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)


//HIT BY THE PLAYER W/HI HIT PTS 
schema sg2hhi
archetype AI_MAJOR
sg2hhi_1 sg2hhi_2 sg2hhi_3
schema_voice guard2 1 comhithigh
schema_voice drunk1 1 comhithigh
schema_voice vass2 1 comhithigh

//HIT BY THE PLAYER W/LO PTS 
schema sg2hlo
archetype AI_MORE_MAJOR
sg2hlo_1 sg2hlo_2 sg2hlo_3 sg2hlo_4
schema_voice guard2 1 comhitlow
schema_voice drunk1 1 comhitlow
schema_voice vass2 1 comhitlow

//		+w/co
schema sg2hlow
archetype AI_COMBAT
sg2hlow1
schema_voice guard2 2 comhitlow (NearbyFriends 0 20)
schema_voice vass2 2 comhitlow (NearbyFriends 0 20)

//HIT BY THE PLAYER NO DAMAGE
schema sg2hnd
archetype AI_MAJOR
sg2hnd_1 sg2hnd_2 sg2hnd_3
schema_voice guard2 1 comhitnodam


//BLOCKED BY THE PLAYER +not losing
schema sg2bkd 
archetype AI_COMBAT
sg2bkd_1 sg2bkd_2 sg2bkd_3
schema_voice guard2 1 comblocked (ComBal Winning Even)

//		+not losing +w/co
schema sg2bkdw 
archetype AI_COMBAT
sg2bkdw1
schema_voice guard2 5 comblocked (ComBal Winning Even) (NearbyFriends 0 20)


//DETECTED PLAYER TRYING TO BLOCK +not losing
schema sg2det 
archetype AI_COMBAT
sg2det_1 sg2det_2 sg2det_3
schema_voice guard2 1 comdetblock (ComBal Winning Even)

//		+not losing +w/co
schema sg2detw 
archetype AI_COMBAT
sg2detw1
schema_voice guard2 5 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)



//AMBUSHED -HIT BY UNSEEN PLAYER
schema sg2amb 
archetype AI_MAJOR
sg2amb_1 sg2amb_2 sg2amb_3 sg2amb_4
schema_voice guard2 1 comhitamb
schema_voice vass2 1 comhitamb

//		+w/co
schema sg2ambw
archetype AI_COMBAT
sg2ambw1 sg2ambw2 sg2ambw3
schema_voice guard2 5 comhitamb (NearbyFriends 0 20)
schema_voice vass2 5 comhitamb (NearbyFriends 0 20)


//DEATH BY COMBAT -LOUD
schema sg2diec
archetype AI_COMBAT
sg2diec1 sg2diec2 sg2diec3
schema_voice guard2 1 comdieloud
schema_voice drunk1 1 comdieloud
schema_voice vass2 1 comdieloud

//DEATH (or knocked out)BY AMBUSH -MORE MUFFLED
schema sg2diea
archetype AI_MINOR
volume -500
sg2diea1 sg2diea2 sg2diea3
schema_voice guard2 1 comdiesoft
schema_voice drunk1 1 comdiesoft
schema_voice vass2 1 comdieloud


///////////////////////////////////
/DRUNKEN GUARD AT ALERT 0
schema dr2a0
archetype AI_NONE
volume -500
mono_loop 1000 5000
sg2a0dr1 freq 2 
sg2a0dr2 freq 2
sg2a0dr3 freq 2
sg2a0dr4 freq 1
sg2a0dr5 freq 1
sg2a0dr6 freq 1
sg2a0dr7 freq 1
schema_voice drunk1 1 atlevelzero
schema_voice drunk1 1 backtozero

//DRUNKEN GUARD TO ALERT 1
schema dr2a1
archetype AI_NONE
volume -500
sg2a1dr1
schema_voice drunk1 1 tolevelone
schema_voice drunk1 1 noticetorch

//DRUNKEN GUARD TO ALERT 2
schema dr2a2
archetype AI_NONE
volume -500
sg2a2dr1 
schema_voice drunk1 1 toleveltwo
schema_voice drunk1 1 tolevelthree
schema_voice drunk1 1 comhitamb
schema_voice drunk1 1 noticetorch

//DRUNKEN GUARD TO ALERT 3
schema dr2a3
archetype AI_MINOR
volume -500
sg2a3dr1
schema_voice drunk1 1 spotplayer

//DRUNKEN GUARD AT ALERT 1
schema dr2at1
archetype AI_NONE
mono_loop 4000 10000
volume -500
sg2a0dr4 sg2a0dr5 sg2a0dr6 sg2a0dr7 
schema_voice drunk1 1 atlevelone

//DRUNKEN GUARD AT ALERT 2-3
schema dr2at2
archetype AI_NONE
mono_loop 4000 10000
volume -500
sg2a0dr4 freq 2
sg2a0dr5 freq 2
sg2a0dr6 freq 2
sg2a0dr7 freq 2
sg2a2dr2 freq 1
schema_voice drunk1 1 atleveltwo
schema_voice drunk1 1 atlevelthree

//DRUNKEN GUARD LOST CONTACT
schema dr2lost
archetype AI_NONE
volume -500
sg2a2dr2
schema_voice drunk1 1 lostcontact
schema_voice drunk1 1 tolevelthree

//////////////////////////
//MISSION SPECIFIC STUFF//
//////////////////////////

//MISSION 2

schema sg2m0201 
archetype AI_NONE
sg2m0201
schema_voice guard2 1 SG_m0201

schema sg2m0202
archetype AI_NONE
sg2m0202
schema_voice guard2 1 SG_m0202

schema sg2m0203
archetype AI_NONE
sg2c3301 
schema_voice guard2 1 SG_M0203

schema sg2m02d1
archetype AI_NONE
sg2m02d1
schema_voice drunk1 1 drunka3



//MISSION 5 

//SEEING GARRETT EXIT THE BUILDING
schema sg2m0501
archetype AI_MORE_MAJOR
sg2m0502 sg2m0501
schema_voice vass2 1 sg_m0502
schema_voice guard2 1 sg_m0502

//ASSASSIN TO ALERT 1
schema as2a1
archetype AI_NONE
sg2m0503 sg2m0507 sg2m0508
schema_voice vass2 1 tolevelone  

//ASSASSIN TO ALERT 2
schema as1a2
archetype AI_MINOR
sg2m0505 sg2m0509 sg2m0510 sg2m0504
schema_voice vass2 1 toleveltwo
schema_voice vass2 1 tolevelthree

//ASSASSIN TO ALERT 3
schema as2a3
archetype AI_MAJOR
sg2m0506 
schema_voice vass2 1 spotplayer

//ASSASSIN REACT TELL FRIEND BY REVELATION +w/co
schema as2telr
archetype AI_COMBAT
sg2telr1
schema_voice vass2 3 spotplayer (NearbyFriends 0 20)

//ASSASSIN REACT TELL FRIEND BY CONFIRMATION +w/co
schema as2telc
archetype AI_COMBAT
sg2telc1 sg2telc3 sg2telc5
schema_voice vass2 5 spotplayer (NearbyFriends 0 20) (Reacquire True)

//ASSASSIN BACK TO ALERT 0
schema as2bak
archetype AI_NONE
sg2bak_3 sg2bak_5 sg2bak_8 
schema_voice vass2 1 backtozero   
