//MECH 2 BROADCASTS 

//----------------------------------------------------

schema mc2a0sn			//SLEEPING
archetype AI_NONE
volume -500
mono_loop 2000 3000
mc2a0sn1 mc2a0sn2 mc2a0sn3 mc2a0sn4 mc2a0sn5 
schema_voice vmech2 1 sleeping

schema mc2a0			//COUGHING
archetype AI_NONE
delay 3000
volume -500
mono_loop 7500 15000
mc2a0co1 mc2a0co2 mc2a0co3 mc2a0co4 mc2a0co5 mc2a0co6 
mc2a0th1 mc2a0th2 mc2a0th3 mc2a0th4 mc2a0th5 mc2a0th6
schema_voice vmech2 1 atlevelzero

schema mc2a0hu			//HUMMING & WHISTLING
archetype AI_NONE
delay 3000
stream
volume -500
mono_loop 7500 15000
mc2a0hu1 mc2a0hu2 mc2a0hu3 mc2a0hu4 mc2a0hu5 mc2a0hu6
mc2a0wh1 mc2a0wh2 mc2a0wh3 mc2a0wh4 mc2a0wh5 
mc2a0co1 mc2a0co2 mc2a0co3
schema_voice vmech2 1 atlevelzero

schema mc2a0ch			//CHANTING & MUTTERING
archetype AI_NONE
delay 3000
volume -500
mono_loop 7500 15000
mc2a0ch1 mc2a0ch2 mc2a0ch3 mc2a0ch4 mc2a0ch5 mc2a0ch6
mc2a0th1 mc2a0th2 mc2a0th3 mc2a0th4 mc2a0th5 mc2a0th6
schema_voice vmech2 1 atlevelzero

//----------------------------------------------------

schema mc2a1			//TO ALERT 1
archetype AI_NONE
mc2a1__1 mc2a1__2 mc2a1__3 mc2a1__4 
schema_voice vmech2 1 tolevelone  

schema mc2a1v			//TO ALERT 1 +sighted
archetype AI_NONE
mc2a1v_1
schema_voice vmech2 1 tolevelone (Sense Sight)

schema mc2a1h			//TO ALERT 1 +heard
archetype AI_NONE
mc2a1h_1 mc2a1h_2
schema_voice vmech2 2 tolevelone (Sense Sound)

schema mc2a1_w			//TO ALERT 1 +w/co
archetype AI_MINOR
mc2a1_w1
schema_voice vmech2 2 tolevelone (NearbyFriends 0 20)

schema mc2a1vw			//TO ALERT 1 +sighted +w/co
archetype AI_MINOR
mc2a1vw1 mc2a1vw2 mc2a1vw3
schema_voice vmech2 3 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema mc2a1hw			//TO ALERT 1 +heard +w/co
archetype AI_MINOR
mc2a1hw1 mc2a1hw2 mc2a1hw3
schema_voice vmech2 3 tolevelone (Sense Sound) (NearbyFriends 0 20)


//----------------------------------------------------

schema mc2a2			//TO ALERT 2
archetype AI_MINOR
mc2a2__1 mc2a2__2 mc2a2__3 mc2a2__4
schema_voice vmech2 1 toleveltwo  

schema mc2a2v			//TO ALERT 2 +sighted
archetype AI_MINOR
mc2a2v_1
schema_voice vmech2 1 toleveltwo (Sense Sight)  

schema mc2a2h			//TO ALERT 2 +heard
archetype AI_MINOR
mc2a2h_1 mc2a2h_2
schema_voice vmech2 2 toleveltwo (Sense Sound)

//----------------------------------------------------

schema mc2a3 			//TO ALERT 3 NOT BY SEEING THE PLAYER
archetype AI_MAJOR
mc2a3__1 mc2a3__2 mc2sec_1
schema_voice vmech2 1 tolevelthree

schema mc2a3s			//SPOTTED THE PLAYER
archetype AI_MORE_MAJOR
mc2a3s_1 mc2a3s_2 mc2a3s_3 
mc2a3na1 mc2a3na2 mc2a3na3 
schema_voice vmech2 1 spotplayer 

schema mc2telr			//SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
mc2telr1 mc2telr2 mc2telr3 mc2telr4
schema_voice vmech2 5 spotplayer (NearbyFriends 0 20)
schema_voice vmech2 1 reacttellrev

schema mc2a3b			//SPOTTED THE PLAYER +body
archetype AI_MORE_MAJOR
mc2a3b_1 mc2a3b_2 
schema_voice vmech2 9 spotplayer (CarryBody True)

schema mc2telc			//RE-SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
mc2telc1 mc2telc2 mc2telc3
schema_voice vmech2 5 spotplayer (NearbyFriends 0 20) (Reacquire true)
schema_voice vmech2 1 reacttellconf

//----------------------------------------------------

schema mc2at1			//AT ALERT 1 & 2
archetype AI_NONE
delay 3000
volume -500
mono_loop 7500 15000
mc2a0co1 mc2a0co2 mc2a0co3 mc2a0co4 mc2a0co5 mc2a0co6 
mc2a0th1 mc2a0th2 mc2a0th3 mc2a0th4 mc2a0th5 mc2a0th6
schema_voice vmech2 1 atlevelone
schema_voice vmech2 1 atleveltwo

schema mc2at2			//AT ALERT 2 & 3 +Investigating
archetype AI_MINOR
delay 6000
mono_loop 15000 30000
no_repeat
mc2a2se1 mc2a2se2 mc2a2se3 mc2a2se4 mc2a3se1 mc2a3se2 mc2a3se3 mc2a3se4
schema_voice vmech2 99 atleveltwo (Investigate True)
schema_voice vmech2 99 atlevelthree (Investigate True)

//----------------------------------------------------

schema mc2chga			//REACT CHARGE
archetype AI_MORE_MAJOR
mc2chga1 mc2chga2 mc2chga3 mc2chga4
schema_voice vmech2 1 reactcharge

schema mc2chgw			//REACT CHARGE +w/co
archetype AI_COMBAT
mc2chgw2 mc2chgw3 mc2chga1 mc2chga4//mc2chgw1 "mace" NG for RC
schema_voice vmech2 2 reactcharge (NearbyFriends 0 20)

schema mc2atb			//REACT SHOOT	
archetype AI_MORE_MAJOR
mc2atb_1 mc2atb_2 mc2atb_3
mc2ats_1 mc2ats_2 mc2ats_3
schema_voice vmech2 1 reactshoot

schema mc2runa			//REACT RUN AWAY +alone
archetype AI_MAJOR
mc2runa1 mc2runa2 mc2runa3
schema_voice vmech2 1 reactrun 

schema mc2alma			//REACT I SOUND THE ALARMS
archetype AI_MORE_MAJOR
mc2alma1 mc2alma2 mc2alma3
schema_voice vmech2 1 reactalarm

schema mc2almw			//REACT YOU TO SOUND THE ALARMS +w/co
archetype AI_COMBAT
mc2almw1
schema_voice vmech2 9 reactalarm (NearbyFriends 0 20)

//----------------------------------------------------

schema mc2bak			//BACK TO ALERT 0
archetype AI_NONE
volume -500
mc2bak_1 mc2bak_2 mc2bak_3 mc2bak_4 mc2bak_5 mc2bak_6 
schema_voice vmech2 1 backtozero  

schema mc2los			//LOST CONTACT W/PLAYER
archetype AI_NONE
mc2los_1 mc2los_2 mc2los_3
schema_voice vmech2 1 lostcontact  

schema mc2frust			//FRUSTRATION
archetype AI_MAJOR
mc2frus1 mc2frus2 mc2frus3
schema_voice vmech2 1 outofreach 

schema mc2torch			//NOTICED A DOUSED TORCH
archetype AI_MINOR
delay 1000
mc2torc1 mc2torc2
schema_voice vmech2 1 notice (Item GasLight Torch)

schema mc2getbowman		//RUN & GET A BOWMAN
archetype AI_MORE_MAJOR
mc2runa1 mc2runa2
schema_voice vmech2 1 getbowman 

//----------------------------------------------------

schema mc2bod			//FOUND BODY	
archetype AI_MORE_MAJOR
mc2bod_1 mc2bod_2 mc2bod_3
schema_voice vmech2 1 foundbody  

schema mc2mis			//FOUND SOMETHING MISSING
archetype AI_MAJOR
mc2mis_1 mc2mis_2
schema_voice vmech2 1 foundmissing
schema_voice vmech2 1 notice (Item MissingLoot)

schema mc2sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
mc2sma_1 mc2sma_2
schema_voice vmech2 1 foundsmall  
schema_voice vmech2 1 notice (Item Door Generic)

schema mc2lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
mc2lar_1 mc2lar_2
schema_voice vmech2 1 foundlarge

schema mc2sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
mc2sec_1 mc2sec_2 mc2sec_3
schema_voice vmech2 1 foundbreach

schema mc2rob			//FOUND DEAD ROBOT	
archetype AI_MAJOR
mc2rob_1 mc2rob_2 mc2rob_3
schema_voice vmech2 1 foundrobot  

//----------------------------------------------------

schema mc2rint			//RECENTLY SAW THE PLAYER +w/co
archetype AI_INFORM
mc2rint1 mc2rint2 mc2rint3
schema_voice vmech2 1 recentintruder 

schema mc2rbod			//RECENTLY FOUND BODY +w/co
archetype AI_INFORM
mc2rbod1 mc2rbod2
schema_voice vmech2 1 recentbody 

schema mc2rmis			//RECENTLY FOUND MISSING +w/co
archetype AI_INFORM
mc2rmis2 
schema_voice vmech2 1 recentmissing 

schema mc2roth			//RECENTLY FOUND MISC ANAMOLY +w/co
archetype AI_INFORM
mc2roth1 mc2roth2 mc2roth3
schema_voice vmech2 1 recentother 

schema mc2rrob			//RECENTLY FOUND DEAD ROBOT +w/co
archetype AI_INFORM
mc2rrob1
schema_voice vmech2 1 recentrobot 

//----------------------------------------------------

//COMBAT
schema mc2atn			//ATTACKING +not losing
archetype AI_COMBAT
mc2atn_1 freq 1
mc2atn_2 freq 1
mc2atn_3 freq 2
mc2atn_4 freq 2
mc2atn_5 freq 2
mc2atn_6 freq 1
mc2atn_7 freq 1
mc2atn_8 freq 1
mc2atn_9 freq 1
mc2atn_a freq 1
mc2atn_b freq 2
mc2atn_c freq 2
mc2atn_d freq 2
schema_voice vmech2 1 comattack (ComBal Winning Even)

schema mc2atnw			//ATTACKING +winning
archetype AI_COMBAT
mc2atw_1 mc2atw_2
schema_voice vmech2 2 comattack (ComBal Winning)

schema mc2atww			//ATTACKING +winning +w/co
archetype AI_COMBAT
mc2atww1
schema_voice vmech2 2 comattack (ComBal Winning) (NearbyFriends 0 20)

schema mc2atl			//ATTACKING +losing
archetype AI_COMBAT
mc2atl_1 mc2atl_2 mc2atl_3 mc2atl_4 mc2atl_5 mc2atl_6 mc2atl_7 mc2atl_8 
schema_voice vmech2 1 comattack (ComBal Losing)

//----------------------------------------------------

schema mc2hit			//HIT THE PLAYER
archetype AI_COMBAT
mc2hit_1 mc2hit_2 mc2hit_3 mc2hit_4
schema_voice vmech2 1 comsucchit (ComBal Winning Even)

schema mc2hitw			//HIT THE PLAYER +w/co
archetype AI_COMBAT
mc2hitw1 mc2hitw2
schema_voice vmech2 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

schema mc2blk			//BLOCKED THE PLAYER
archetype AI_COMBAT
mc2blk_1 mc2blk_2 mc2blk_3
schema_voice vmech2 1 comsuccblock (ComBal Winning Even)

schema mc2blkw			//BLOCKED THE PLAYER +w/co
archetype AI_COMBAT
mc2blkw1
schema_voice vmech2 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema mc2hhi			//HIT BY PLAYER W/HI HIT PTS 
archetype AI_MAJOR
mc2hhi_1 mc2hhi_2 mc2hhi_3 mc2hhi_4 mc2hhi_5 
schema_voice vmech2 1 comhithigh
schema_voice vmech2 99 comhitnodam (ComBal Losing)

schema mc2hlo			//HIT BY PLAYER W/LO PTS 
archetype AI_MORE_MAJOR
mc2hlo_1 mc2hlo_2 mc2hlo_3 mc2hlo_4 
schema_voice vmech2 1 comhitlow

schema mc2hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
mc2hlow1
schema_voice vmech2 1 comhitlow (NearbyFriends 0 20)

schema mc2hnd			//HIT BY PLAYER NO DAMAGE +Winning
archetype AI_MAJOR
mc2hnd_1 mc2hnd_2 mc2hnd_3
schema_voice vmech2 1 comhitnodam (ComBal Winning)
schema_voice vmech2 1 comhitnodam 

schema mc2hnde			//HIT BY PLAYER NO DAMAGE +Even
archetype AI_MAJOR
mc2hnde1 mc2hnde2 mc2hnde3
schema_voice vmech2 99 comhitnodam (ComBal Even)
schema_voice vmech2 3 comhitnodam 

//----------------------------------------------------

schema mc2bkd 			//BLOCKED BY PLAYER
archetype AI_COMBAT
mc2bkd_1 mc2bkd_2 mc2bkd_3
schema_voice vmech2 1 comblocked (ComBal Winning Even)

schema mc2bkdw 			//BLOCKED BY THE PLAYER +w/co
archetype AI_COMBAT
mc2bkdw1
schema_voice vmech2 2 comblocked (ComBal Winning Even) (NearbyFriends 0 20)

schema mc2det 			//DETECTED BLOCK
archetype AI_COMBAT
mc2det_1 mc2det_2 mc2det_3
schema_voice vmech2 1 comdetblock (ComBal Winning Even)

schema mc2detw 			//DETECTED BLOCK +w/co
archetype AI_COMBAT
mc2detw1
schema_voice vmech2 2 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema mc2amb 		//AMBUSHED
archetype AI_MAJOR 
mc2amb_1 mc2amb_2 mc2amb_3 mc2amb_4
schema_voice vmech2 1 comhitamb

schema mc2ambw		//AMBUSHED +w/co
archetype AI_COMBAT
mc2ambw1 mc2ambw2 mc2ambw3
schema_voice vmech2 2 comhitamb (NearbyFriends 0 20)

schema mc2diea		//SOFT DEATH
archetype AI_MINOR
volume -500
mc2diea1 mc2diea2 mc2diea3 mc2diea4 mc2diea5
schema_voice vmech2 1 comdiesoft

schema mc2diec		//LOUD DEATH
archetype AI_COMBAT
mc2diec1 mc2diec2 mc2diec3 mc2diec4 mc2diec5 
schema_voice vmech2 1 comdieloud

//----------------------------------------------------
//----------------------------------------------------