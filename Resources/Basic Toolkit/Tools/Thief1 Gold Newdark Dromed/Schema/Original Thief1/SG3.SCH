//GUARD 3 BROADSCASTS -Stephen Russell

/////////////
//AI SPEECH//
/////////////

//SLEEPING
schema sg3a0sn
archetype AI_NONE
volume -500
mono_loop 2000 3000
sg3a0sn1 sg3a0sn2 sg3a0sn3 
schema_voice guard3 1 sleeping


//AT ALERT 0
schema sg3a0
archetype AI_NONE
volume -500
mono_loop 7500 15000
sg3a0co1 sg3a0co2 sg3a0co3 sg3a0hu1 sg3a0hu2 sg3a0hu3 sg3a0th1 sg3a0th2 sg3a0th3 sg3a0th4 sg3a0wh1 sg3a0wh2 sg3a0wh3
schema_voice guard3 3 atlevelzero

//		-Less freq
schema sg3a0ch
archetype AI_NONE
volume -500
delay 5000
mono_loop 7500 15000
sg3a0mu1 sg3a0mu2 sg3a0mu3 sg3a0tc1 sg3a0tc2 sg3a0tc3
schema_voice guard3 1 atlevelzero

//		-SPARRING PARTNER ONLY
schema sg3a0wh
archetype AI_NONE
volume -500
mono_loop 1000 4000
sg3a0wh1 sg3a0wh2 sg3a0wh3
schema_voice vspar 1 atlevelzero


//TO ALERT 1, 2, 3, etc. -SPARRING PARTNER ONLY
schema sg3a0sp
archetype AI_NONE
volume -500
sg3a0wh3
schema_voice vspar 1 spotplayer
schema_voice vspar 1 tolevelone 
schema_voice vspar 1 toleveltwo 
schema_voice vspar 1 lostcontact  
schema_voice vspar 1 backtozero


//TO ALERT 1
schema sg3a1
archetype AI_NONE
sg3a1__1 sg3a1__2 sg3a1__3 sg3a1__4 sg3a1__4 sg3a1__5 
schema_voice guard3 1 tolevelone  

//		+sighted
schema sg3a1v
archetype AI_NONE
sg3a1v_1
schema_voice guard3 1 tolevelone (Sense Sight)

//		+heard
schema sg3a1h
archetype AI_NONE
sg3a1h_1 sg3a1h_2
schema_voice guard3 2 tolevelone (Sense Sound)

//		+w/co
schema sg3a1_w
archetype AI_MINOR
sg3a1_w1 sg3a1_w2
schema_voice guard3 3 tolevelone (NearbyFriends 0 20)

//		+sighted +w/co
schema sg3a1vw
archetype AI_MINOR
sg3a1vw1 sg3a1vw2 sg3a1vw3 sg3a1vw4
schema_voice guard3 5 tolevelone (Sense Sight) (NearbyFriends 0 20)

//		+heard +w/co
schema sg3a1hw
archetype AI_MINOR
sg3a1hw1 sg3a1hw2 sg3a1hw3 sg3a1hw4
schema_voice guard3 9 tolevelone (Sense Sound) (NearbyFriends 0 20)



//AT ALERT 1, 2, 3
schema sg3at1
archetype AI_NONE
volume -500
delay 5000
mono_loop 7500 25000
sg3a0tc1 sg3a0tc2 sg3a0tc3
schema_voice guard3 1 atlevelone
schema_voice guard3 1 atleveltwo
schema_voice guard3 1 atlevelthree
  

//BACK TO ALERT 0
schema sg3bak
archetype AI_NONE
sg3bak_1 sg3bak_2 sg3bak_3 sg3bak_4 sg3bak_5 sg3bak_6 sg3bak_7 
schema_voice guard3 1 backtozero  


//TO ALERT 2
schema sg3a2
archetype AI_MINOR
sg3a2__1 sg3a2__2 sg3a2__3 sg3a2__4 sg3a2__5
schema_voice guard3 1 toleveltwo  

//		+sighted
schema sg3a2v
archetype AI_MINOR
sg3a2v_1 
schema_voice guard3 2 toleveltwo (Sense Sight)  

//		+heard
schema sg3a2h
archetype AI_MINOR
sg3a2h_1 sg3a2h_2 
schema_voice guard3 5 toleveltwo (Sense Sound)



//AT ALERT 2 + Investigating, Also AT ALERT 3 THIEVE's ONLY
schema sg3at2
archetype AI_MINOR
delay 6000
mono_loop 10000 20000
no_repeat
sg3a2se1 sg3a2se2 sg3a2se3 sg3a2se4 sg3a3se1 sg3a3se2 sg3a3se4
schema_voice guard3 99 atleveltwo (Investigate True)
schema_voice guard3 99 atlevelthree (Investigate True) (Mission 15 15)



//TO ALERT 3
schema sg3a3
archetype AI_MAJOR
Sg3a3s_1 Sg3a3s_3
schema_voice guard3 1 tolevelthree 



//SPOTTED THE PLAYER -All except THIEVE's
schema sg3a3s
archetype AI_MORE_MAJOR
sg3a3s_1 sg3a3s_2 sg3a3s_3 sg3a3s_4
schema_voice guard3 1 spotplayer (Mission 1 14)
schema_voice guard3 1 spotplayer (Mission 16 17)

//		-THIEVE's ONLY
schema sg3a3s_m15
archetype AI_MORE_MAJOR
sg3a3s_1 sg3a3s_2 sg3a3s_3 
schema_voice guard3 1 spotplayer (mission 15 15)

//		-more spotted the player
schema sg3a3na
archetype AI_MORE_MAJOR
sg3a3na1 sg3a3na2 sg3a3na3 sg3a3na4 
schema_voice guard3 1 spotplayer (Mission 1 14)
schema_voice guard3 1 spotplayer (Mission 16 17)

//		-THIEVE's ONLY
schema sg3a3na_m15
archetype AI_MORE_MAJOR
sg3a3na1 sg3a3na2 sg3a3na4 
schema_voice guard3 1 spotplayer (mission 15 15)

//		 +carrying a body
schema sg3a3b
archetype AI_MORE_MAJOR
sg3a3b_1 
schema_voice guard3 9 spotplayer (CarryBody True)

//		+w/co -All except THIEVE's
schema sg3telr
archetype AI_COMBAT
sg3telr1 sg3telr2 sg3telr3 sg3telr4 
schema_voice guard3 3 spotplayer (NearbyFriends 0 20) (Mission 1 14) 
schema_voice guard3 3 spotplayer (NearbyFriends 0 20) (Mission 16 17) 

//		+w/co -THIEVE's ONLY
schema sg3telr_m15
archetype AI_COMBAT
sg3telr1 sg3telr2
schema_voice guard3 3 spotplayer (NearbyFriends 0 20) (Mission 15)



//LOST CONTACT W/PLAYER -All except THIEVE's
schema sg3los
archetype AI_NONE
sg3los_1 sg3los_2 sg3los_3 sg3los_4
schema_voice guard3 1 lostcontact (Mission 1 14) 
schema_voice guard3 1 lostcontact (Mission 16 17) 

//		-THIEVE's ONLY
schema sg3los_m15
archetype AI_NONE
sg3los_1 sg3los_2 sg3los_3
schema_voice guard3 1 lostcontact (mission 15 15) 



//AT ALERT 3 +Investigating
schema sg3at3
archetype AI_MAJOR
delay 6000
mono_loop 10000 20000
no_repeat
sg3a2se1 sg3a2se2 sg3a2se3 sg3a2se4 sg3a3se1 sg3a3se2 sg3a3se3 sg3a3se4
schema_voice guard3 99 atlevelthree (Investigate True) (Mission 1 14)
schema_voice guard3 99 atlevelthree (Investigate True) (Mission 16 17)


//RE-SPOTTED THE PLAYER AFTER A SEARCH
schema sg3telc
archetype AI_COMBAT
sg3telc1 sg3telc2 sg3telc3 sg3telc4 sg3telc5 
schema_voice guard3 5 spotplayer (NearbyFriends 0 20) (Reacquire true)



//REACT 1ST WARNING
schema sg3warn1
archetype AI_NONE
sg3wrn11
schema_voice guard3 1 reactwarn

//REACT 2ND WARNING
schema sg3warn2
archetype AI_MINOR
sg3wrn21
schema_voice guard3 1 reactwarn2

//REACT ATTACK AFTER FINAL WARNING
schema sg3warnf
archetype AI_MORE_MAJOR
sg3wrnf1
schema_voice guard3 9 reactcharge (Reiterate 9 9)


//REACT CHARGE +alone
schema sg3chga
archetype AI_MORE_MAJOR
sg3chga1 sg3chga2 
schema_voice guard3 1 reactcharge

//REACT CHARGE +w/co
schema sg3chgw
archetype AI_MORE_MAJOR
sg3chgw1 sg3chgw2 sg3chgw3 
schema_voice guard3 9 reactcharge (NearbyFriends 0 20)


//REACT TAUNT WHILE FIRING THE BOW
schema sg3bow
archetype AI_MORE_MAJOR
no_repeat
Sg3atb_1 Sg3atb_2 Sg3atb_3 Sg3atw_1 Sg3atw_2 Sg3chga1
schema_voice guard3 1 reactshoot 


//REACT RUN AWAY
schema sg3runa
archetype AI_MAJOR
sg3runa1 sg3runa2 sg3runa3 sg3runa4
schema_voice guard3 1 reactrun 


//REACT SOUND THE ALARMS
schema sg3alma
archetype AI_MORE_MAJOR
sg3alma1 sg3alma2 sg3alma3
schema_voice guard3 1 reactalarm

//		+w/co
schema sg3almw
archetype AI_COMBAT
sg3almw1 sg3almw2
schema_voice guard3 5 reactalarm (NearbyFriends 0 20)



//FRUSTRATION
schema sg3frust
archetype AI_MAJOR
Sg3a3se4 Sg3amb_2 Sg3amb_3 Sg3bkd_2 Sg3det_2 Sg3det_3
schema_voice guard3 1 outofreach



//FOUND BODY -All except THIEVE's
schema sg3bod
archetype AI_MORE_MAJOR
sg3bod_1 sg3bod_2 
schema_voice guard3 1 foundbody (Mission 1 14) 
schema_voice guard3 1 foundbody (Mission 16 17) 

//		-THIEVE's ONLY
schema sg3bod_m15
archetype AI_MORE_MAJOR
sg3bod_1
schema_voice guard3 1 foundbody (Mission 15 15)


//FOUND SOMETHING MISSING -All except THIEVE's
schema sg3mis
archetype AI_MAJOR
sg3mis_1 sg3mis_3
schema_voice guard3 1 foundmissing (Mission 1 14)
schema_voice guard3 1 foundmissing (Mission 16 17)

//		-BAFFORD ONLY
schema sg3mis_miss2
archetype AI_MAJOR
sg3mis_2
schema_voice guard3 1 foundmissing (Mission 2 2)

//		-THIEVE's ONLY
schema sg3mis_m15
archetype AI_MAJOR
sg3mis_1
schema_voice guard3 1 foundmissing (Mission 15 15)



//NOTICED A TORCH BEING DOUSED
schema sg3torch
archetype AI_MINOR
delay 1000
sg3sma_2 Sg3a1__1 Sg3a1__2 Sg3a1__3 Sg3a1__4 Sg3a1__5 
schema_voice guard3 1 noticetorch



//FOUND A SMALL ANOMALY
schema sg3sma
archetype AI_MINOR
sg3sma_1 sg3sma_2 
schema_voice guard3 1 foundsmall  

//FOUND A LARGE ANOMALY
schema sg3lar
archetype AI_MAJOR
sg3lar_1 sg3lar_2 
schema_voice guard3 1 foundlarge


//FOUND A SECURITY BREACH -All except THIEVE's
schema sg3sec
archetype AI_MORE_MAJOR
sg3sec_1 sg3sec_2 sg3sec_3 sg3sec_4
schema_voice guard3 1 foundbreach (mission 1 14)
schema_voice guard3 1 foundbreach (mission 16 17)

//		-THIEVE's ONLY
schema sg3sec_m15
archetype AI_MORE_MAJOR
sg3sec_1 sg3sec_3
schema_voice guard3 1 foundbreach (mission 15 15)



//RECENTLY SAW THE PLAYER +w/co -All except THIEVE's
schema sg3rint
archetype AI_INFORM
sg3rint1 sg3rint2 sg3rint3
schema_voice guard3 1 recentintruder (Mission 1 14)
schema_voice guard3 1 recentintruder (Mission 16 17)

//		-THIEVE's ONLY
schema sg3rint_m15
archetype AI_INFORM
sg3rint1 sg3rint2
schema_voice guard3 1 recentintruder (Mission 15 15)


//RECENTLY FOUND BODY +w/co -All except THIEVE's
schema sg3rbod
archetype AI_INFORM
sg3rbod1 sg3rbod2 sg3rbod3 
schema_voice guard3 1 recentbody (mission 1 14)
schema_voice guard3 1 recentbody (mission 16 17)

//		-THIEVE's ONLY
schema sg3rbod_m15
archetype AI_INFORM
sg3rbod1 sg3rbod2
schema_voice guard3 1 recentbody 



//RECENTLY FOUND SOMETHING MISSING +w/co -All except THIEVE's
schema sg3rmis
archetype AI_INFORM
sg3rmis1 sg3rmis2 sg3rmis3 
schema_voice guard3 1 recentmissing (mission 1 14)
schema_voice guard3 1 recentmissing (mission 16 17)

//		-SWORD ONLY
schema sg3rmis_m06
archetype AI_INFORM
sg3rmis3 
schema_voice guard3 1 recentmissing (mission 6 6)

//		-THIEVE's ONLY
schema sg3rmis_m15
archetype AI_INFORM
sg3rmis2
schema_voice guard3 1 recentmissing (mission 15 15)



//RECENTLY FOUND MISC ANAMOLY +w/co -All except THIEVE's
schema sg3roth
archetype AI_INFORM
sg3roth1 sg3roth2 sg3roth3 sg3roth4 
schema_voice guard3 1 recentother (mission 1 14)
schema_voice guard3 1 recentother (mission 16 17)

//		-THIEVE's ONLY
schema sg3roth_m15
archetype AI_INFORM
sg3roth1 sg3roth2 sg3roth3
schema_voice guard3 1 recentother (mission 15 15)



//COMBAT

//ATTACKING +not losing
schema sg3atn
archetype AI_COMBAT
sg3atn_1 freq 1
sg3atn_2 freq 1
sg3atn_3 freq 2
sg3atn_4 freq 2
sg3atn_5 freq 2
sg3atn_6 freq 2
schema_voice guard3 1 comattack (ComBal Winning Even)
schema_voice vspar 1 comattack (ComBal Winning Even)

//		+winning
schema sg3atnw
archetype AI_COMBAT
sg3atw_1 sg3atw_2
schema_voice guard3 3 comattack (ComBal Winning)
schema_voice vspar 3 comattack (ComBal Winning)

//		+winning +w/co
schema sg3atww
archetype AI_COMBAT
sg3atww1 
schema_voice guard3 4 comattack (ComBal Winning) (NearbyFriends 0 20)

//		+losing
schema sg3atl
archetype AI_COMBAT
sg3atl_1 sg3atl_2 sg3atl_3 sg3atl_4
schema_voice guard3 3 comattack (ComBal Losing)
schema_voice vspar 3 comattack (ComBal Losing)


//SUCCESSFULLY HIT THE PLAYER +not losing
schema sg3hit
archetype AI_COMBAT
sg3hit_1 sg3hit_2 sg3hit_3 sg3hit_4
schema_voice guard3 1 comsucchit (ComBal Winning Even)
schema_voice vspar 1 comsucchit (ComBal Winning Even)

//		+not losing +w/co
schema sg3hitw
archetype AI_COMBAT
sg3hitw1 sg3hitw2
schema_voice guard3 5 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)



//SUCCESSFULLY BLOCKED THE PLAYER +not losing
schema sg3blk
archetype AI_COMBAT
sg3blk_1 sg3blk_2 sg3blk_3
schema_voice guard3 1 comsuccblock (ComBal Winning Even)
schema_voice vspar 1 comsuccblock (ComBal Winning Even)

//		+not losing +w/co
schema sg3blkw
archetype AI_COMBAT
sg3blkw1
schema_voice guard3 5 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)


//HIT BY THE PLAYER W/HI HIT PTS 
schema sg3hhi
archetype AI_MAJOR
sg3hhi_1 sg3hhi_2 sg3hhi_3
schema_voice guard3 1 comhithigh
schema_voice vspar 1 comhithigh

//HIT BY THE PLAYER W/LO PTS 
schema sg3hlo
archetype AI_MORE_MAJOR
sg3hlo_1 sg3hlo_2 sg3hlo_3
schema_voice guard3 1 comhitlow
schema_voice vspar 1 comhitlow

//		+w/co
schema sg3hlow
archetype AI_COMBAT
sg3hlow1 sg3ambw3 sg3hlo_2 sg3hlo_3
schema_voice guard3 9 comhitlow (NearbyFriends 0 20)

//HIT BY THE PLAYER NO DAMAGE
schema sg3hnd
archetype AI_MAJOR
sg3hnd_1 sg3hnd_2 sg3hnd_3
schema_voice guard3 1 comhitnodam
schema_voice vspar 1 comhitnodam


//BLOCKED BY THE PLAYER +not losing
schema sg3bkd 
archetype AI_COMBAT
sg3bkd_1 sg3bkd_2 sg3bkd_3
schema_voice guard3 1 comblocked (ComBal Winning Even)
schema_voice vspar 1 comblocked (ComBal Winning Even)

//		+not losing +w/co
schema sg3bkdw 
archetype AI_COMBAT
sg3bkdw1
schema_voice guard3 5 comblocked (ComBal Winning Even) (NearbyFriends 0 20)


//DETECTED PLAYER TRYING TO BLOCK +not losing
schema sg3det 
archetype AI_COMBAT
sg3det_1 sg3det_2 sg3det_3
schema_voice guard3 1 comdetblock (ComBal Winning Even)
schema_voice vspar 1 comdetblock (ComBal Winning Even)

//		+not losing +w/co
schema sg3detw 
archetype AI_COMBAT
sg3detw1
schema_voice guard3 5 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)


//AMBUSHED -HIT BY UNSEEN PLAYER
schema sg3amb 
archetype AI_MAJOR
sg3amb_1 sg3amb_2 sg3amb_3 sg3amb_4
schema_voice guard3 1 comhitamb

//		+w/co
schema sg3ambw
archetype AI_COMBAT
sg3ambw1 sg3ambw2 sg3ambw3
schema_voice guard3 2 comhitamb (NearbyFriends 0 20)

//DEATH BY COMBAT -LOUD
schema sg3diec
archetype AI_COMBAT
sg3diec1 sg3diec2 sg3diec3
schema_voice guard3 1 comdieloud

//DEATH (or knocked out)BY AMBUSH -MORE MUFFLED
schema sg3diea
archetype AI_MINOR
volume -1000
sg3diea1 sg3diea2 sg3diea3
schema_voice guard3 1 comdiesoft








//MISSION 5

schema sg3m0203
archetype AI_NONE
sg3c3601 
schema_voice guard3 1 SG_M0203

//SEEING GARRETT EXIT THE BLDG.
schema sg3m0501
archetype AI_COMBAT
Sg3telc3 Sg3runa3
schema_voice guard3 1 sg_m0502



