//MECH 3 BROADCASTS 

//----------------------------------------------------

schema mc3a0sn			//SLEEPING
archetype AI_NONE
volume -500
mono_loop 2000 3000
mc3a0sn1 mc3a0sn2 mc3a0sn3 mc3a0sn4 mc3a0sn5 mc3a0sn6
schema_voice vmech3 1 sleeping

schema mc3a0			//COUGHING
archetype AI_NONE
delay 3000
volume -500
mono_loop 7500 15000
mc3a0co1 mc3a0co2 mc3a0co3 mc3a0co4 mc3a0co5 mc3a0co6 mc3a0co7
mc3a0th1 mc3a0th2 mc3a0th3 mc3a0th4 mc3a0th5
mc3a0wh7 mc3a0hu6
schema_voice vmech3 1 atlevelzero

schema mc3a0hu			//HUMMING & WHISTLING
archetype AI_NONE
delay 3000
volume -500
mono_loop 7500 15000
mc3a0hu1 mc3a0hu2 mc3a0hu3 mc3a0hu4 mc3a0hu5 mc3a0hu6
mc3a0wh1 mc3a0wh2 mc3a0wh3 mc3a0wh4 mc3a0wh5 mc3a0wh6 mc3a0wh7
mc3a0th1 mc3a0th2
schema_voice vmech3 1 atlevelzero

schema mc3a0ch			//CHANTING & MUTTERING
archetype AI_NONE
delay 3000
volume -1000
mono_loop 7500 15000
mc3a0ch1 mc3a0ch2 mc3a0ch3 mc3a0ch4 mc3a0ch5 mc3a0ch6
mc3a0mu1 mc3a0mu2 mc3a0mu3
mc3a0th1 mc3a0th2 mc3a0th3 mc3a0th4 mc3a0th5
schema_voice vmech3 1 atlevelzero

//----------------------------------------------------

schema mc3a1			//TO ALERT 1
archetype AI_NONE
mc3a1__1 mc3a1__2 mc3a1__3 mc3a1__4 
schema_voice vmech3 1 tolevelone  

schema mc3a1v			//TO ALERT 1 +sighted
archetype AI_NONE
mc3a1v_1
schema_voice vmech3 1 tolevelone (Sense Sight)

schema mc3a1h			//TO ALERT 1 +heard
archetype AI_NONE
mc3a1h_1 
schema_voice vmech3 2 tolevelone (Sense Sound)

schema mc3a1_w			//TO ALERT 1 +w/co
archetype AI_MINOR
mc3a1_w1
schema_voice vmech3 2 tolevelone (NearbyFriends 0 20)

schema mc3a1vw			//TO ALERT 1 +sighted +w/co
archetype AI_MINOR
mc3a1vw1 mc3a1vw2 mc3a1vw3
schema_voice vmech3 3 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema mc3a1hw			//TO ALERT 1 +heard +w/co
archetype AI_MINOR
mc3a1hw1 mc3a1hw2 mc3a1hw3
schema_voice vmech3 3 tolevelone (Sense Sound) (NearbyFriends 0 20)


//----------------------------------------------------

schema mc3a2			//TO ALERT 2
archetype AI_MINOR
mc3a2__1 mc3a2__2 mc3a2__3 mc3a2__4
schema_voice vmech3 1 toleveltwo  

schema mc3a2v			//TO ALERT 2 +sighted
archetype AI_MINOR
mc3a2v_1
schema_voice vmech3 1 toleveltwo (Sense Sight)  

schema mc3a2h			//TO ALERT 2 +heard
archetype AI_MINOR
mc3a2h_1 
schema_voice vmech3 2 toleveltwo (Sense Sound)

//----------------------------------------------------

schema mc3a3 			//TO ALERT 3 NOT BY SEEING THE PLAYER
archetype AI_MAJOR
mc3a3__1 mc3a3__2 mc3a3__3 mc3a3__4 mc3amb_1
schema_voice vmech3 1 tolevelthree

schema mc3a3s			//SPOTTED THE PLAYER
archetype AI_MORE_MAJOR
mc3a3s_1 mc3a3s_2 mc3a3s_3 mc3a3s_4
mc3a3na1 mc3a3na2 mc3a3na3 mc3a3na4
schema_voice vmech3 1 spotplayer 

schema mc3telr			//SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
mc3telr1 mc3telr2 mc3telr3 
schema_voice vmech3 5 spotplayer (NearbyFriends 0 20)
schema_voice vmech3 1 reacttellrev

schema mc3a3b			//SPOTTED THE PLAYER +body
archetype AI_MORE_MAJOR
mc3a3b_1 mc3a3b_2 
schema_voice vmech3 9 spotplayer (CarryBody True)

schema mc3telc			//RE-SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
mc3telc1 mc3telc2 mc3telc3
schema_voice vmech3 5 spotplayer (NearbyFriends 0 20) (Reacquire true)
schema_voice vmech3 1 reacttellconf

//----------------------------------------------------

schema mc3at1			//AT ALERT 1 & 2
archetype AI_NONE
delay 3000
volume -500
mono_loop 7500 15000
mc3a0co1 mc3a0co2 mc3a0co3 mc3a0co4 mc3a0co5 mc3a0co6 mc3a0co7
mc3a0th1 mc3a0th2 mc3a0th3 mc3a0th4 mc3a0th5
schema_voice vmech3 1 atlevelone
schema_voice vmech3 1 atleveltwo

schema mc3at2			//AT ALERT 2 & 3 +Investigating
archetype AI_MINOR
delay 6000
mono_loop 15000 30000
no_repeat
mc3a2se1 mc3a2se2 mc3a2se3 mc3a2se4 mc3a3se1 mc3a3se2 mc3a3se3 mc3a3se4
schema_voice vmech3 99 atleveltwo (Investigate True)
schema_voice vmech3 99 atlevelthree (Investigate True)

//----------------------------------------------------

schema mc3chga			//REACT CHARGE
archetype AI_MORE_MAJOR
mc3chga1 mc3chga2 mc3chga3 mc3chga4
schema_voice vmech3 1 reactcharge

schema mc3chgw			//REACT CHARGE +w/co
archetype AI_COMBAT
mc3chgw1 mc3chgw2 mc3chgw3
schema_voice vmech3 2 reactcharge (NearbyFriends 0 20)

schema mc3atb			//REACT SHOOT	
archetype AI_MORE_MAJOR
mc3atb_1 mc3atb_2 mc3atb_3
mc3ats_1 mc3ats_2 mc3ats_3
schema_voice vmech3 1 reactshoot

schema mc3runa			//REACT RUN AWAY +alone
archetype AI_MAJOR
mc3runa1 mc3runa2 mc3runa3
schema_voice vmech3 1 reactrun 
schema_voice vmech3 1 getbowman 

schema mc3alma			//REACT I SOUND THE ALARMS
archetype AI_MORE_MAJOR
mc3alma1 mc3alma2 
schema_voice vmech3 1 reactalarm

schema mc3almw			//REACT YOU TO SOUND THE ALARMS +w/co
archetype AI_COMBAT
mc3almw1
schema_voice vmech3 9 reactalarm (NearbyFriends 0 20)

//----------------------------------------------------

schema mc3bak			//BACK TO ALERT 0
archetype AI_NONE
volume -500
mc3bak_1 mc3bak_2 mc3bak_3 mc3bak_4 mc3bak_5 mc3bak_6 mc3bak_7
schema_voice vmech3 1 backtozero  

schema mc3los			//LOST CONTACT W/PLAYER
archetype AI_NONE
mc3los_1 mc3los_2 mc3los_3
schema_voice vmech3 1 lostcontact  

schema mc3frust			//FRUSTRATION
archetype AI_MAJOR
mc3frus1 mc3frus2 mc3frus3
schema_voice vmech3 1 outofreach 

schema mc3torch			//NOTICED DOUSED TORCH
archetype AI_MINOR
delay 1000
mc3torc1 mc3torc2
schema_voice vmech3 1 notice (Item Torch)

schema mc3gas			//NOTICED DOUSED GASLIGHT
archetype AI_MINOR
delay 1000
mc3torc2 mc3torc3
schema_voice vmech3 1 notice (Item GasLight)

//[see REACTRUN]			//RUN & GET A BOWMAN 

//----------------------------------------------------

schema mc3bod			//FOUND BODY	
archetype AI_MORE_MAJOR
mc3bod_1 mc3bod_2 mc3bod_3
schema_voice vmech3 1 foundbody  

schema mc3mis			//FOUND SOMETHING MISSING
archetype AI_MAJOR
mc3mis_1 
schema_voice vmech3 1 foundmissing
schema_voice vmech3 1 notice (Item MissingLoot)

schema mc3sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
mc3sma_1 mc3sma_2
schema_voice vmech3 1 foundsmall  
schema_voice vmech3 1 notice (Item Door Generic)

schema mc3lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
mc3lar_1 mc3lar_2
schema_voice vmech3 1 foundlarge

schema mc3sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
mc3sec_1 mc3sec_2 mc3sec_3
schema_voice vmech3 1 foundbreach

schema mc3rob			//FOUND DEAD ROBOT	
archetype AI_MAJOR
mc3rob_1 mc3rob_2 mc3rob_3
schema_voice vmech3 1 foundrobot  

//----------------------------------------------------

schema mc3rint			//RECENTLY SAW THE PLAYER +w/co
archetype AI_INFORM
mc3rint1 
schema_voice vmech3 1 recentintruder 

schema mc3rbod			//RECENTLY FOUND BODY +w/co
archetype AI_INFORM
mc3rbod1  
schema_voice vmech3 1 recentbody 

schema mc3rmis			//RECENTLY FOUND MISSING +w/co
archetype AI_INFORM
mc3rmis1
schema_voice vmech3 1 recentmissing 

schema mc3roth			//RECENTLY FOUND MISC ANAMOLY +w/co
archetype AI_INFORM
mc3roth1 mc3roth2 mc3roth3
schema_voice vmech3 1 recentother 
schema_voice vmech3 1 recentrobot 

//----------------------------------------------------

//COMBAT
schema mc3atn			//ATTACKING +not losing
archetype AI_COMBAT
mc3atn_1 freq 1
mc3atn_2 freq 1
mc3atn_3 freq 2
mc3atn_4 freq 2
mc3atn_5 freq 2
mc3atn_6 freq 1
mc3atn_7 freq 1
mc3atn_8 freq 1
mc3atn_9 freq 2
mc3atn_a freq 2
mc3atn_b freq 2
schema_voice vmech3 1 comattack (ComBal Winning Even)

schema mc3atnw			//ATTACKING +winning
archetype AI_COMBAT
mc3atw_1 mc3atw_2
schema_voice vmech3 2 comattack (ComBal Winning)

schema mc3atww			//ATTACKING +winning +w/co
archetype AI_COMBAT
mc3atww1
schema_voice vmech3 2 comattack (ComBal Winning) (NearbyFriends 0 20)

schema mc3atl			//ATTACKING +losing
archetype AI_COMBAT
mc3atl_1 mc3atl_2 mc3atl_3 mc3atl_4 mc3atl_5 mc3atl_6 mc3atl_7 mc3atl_8 mc3atl_9
schema_voice vmech3 1 comattack (ComBal Losing)

//----------------------------------------------------

schema mc3hit			//HIT THE PLAYER
archetype AI_COMBAT
mc3hit_1 mc3hit_2 mc3hit_3 mc3hit_4
schema_voice vmech3 1 comsucchit (ComBal Winning Even)

schema mc3hitw			//HIT THE PLAYER +w/co
archetype AI_COMBAT
mc3hitw1 mc3hitw2
schema_voice vmech3 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

schema mc3blk			//BLOCKED THE PLAYER
archetype AI_COMBAT
mc3blk_1 mc3blk_2 mc3blk_3
schema_voice vmech3 1 comsuccblock (ComBal Winning Even)

schema mc3blkw			//BLOCKED THE PLAYER +w/co
archetype AI_COMBAT
mc3blkw1
schema_voice vmech3 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema mc3hhi			//HIT BY PLAYER W/HI HIT PTS 
archetype AI_MAJOR
mc3hhi_1 mc3hhi_2 mc3hhi_3 mc3hhi_4 mc3hhi_5 mc3hhi_6
schema_voice vmech3 1 comhithigh
schema_voice vmech3 99 comhitnodam (ComBal Losing)

schema mc3hlo			//HIT BY PLAYER W/LO PTS 
archetype AI_MORE_MAJOR
mc3hlo_1 mc3hlo_2 mc3hlo_3 mc3hlo_4 mc3hlo_5 mc3hlo_6 
schema_voice vmech3 1 comhitlow

schema mc3hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
mc3hlow1
schema_voice vmech3 1 comhitlow (NearbyFriends 0 20)

schema mc3hnd			//HIT BY PLAYER NO DAMAGE +Winning
archetype AI_MAJOR
mc3hnd_1 mc3hnd_2 mc3hnd_3
schema_voice vmech3 99 comhitnodam (ComBal Winning)
schema_voice vmech3 1 comhitnodam

schema mc3hnde			//HIT BY PLAYER NO DAMAGE +Even
archetype AI_MAJOR
mc3hnde1 mc3hnde2 mc3hnde3
schema_voice vmech3 99 comhitnodam (ComBal Even)
schema_voice vmech3 3 comhitnodam

//----------------------------------------------------

schema mc3bkd 			//BLOCKED BY PLAYER
archetype AI_COMBAT
mc3bkd_1 mc3bkd_2 mc3bkd_3
schema_voice vmech3 1 comblocked (ComBal Winning Even)

schema mc3bkdw 			//BLOCKED BY THE PLAYER +w/co
archetype AI_COMBAT
mc3bkdw1
schema_voice vmech3 2 comblocked (ComBal Winning Even) (NearbyFriends 0 20)

schema mc3det 			//DETECTED BLOCK
archetype AI_COMBAT
mc3det_1 mc3det_2 mc3det_3
schema_voice vmech3 1 comdetblock (ComBal Winning Even)

schema mc3detw 			//DETECTED BLOCK +w/co
archetype AI_COMBAT
mc3detw1
schema_voice vmech3 2 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema mc3amb 		//AMBUSHED
archetype AI_MAJOR 
mc3amb_1 mc3amb_2 mc3amb_3 mc3amb_4
schema_voice vmech3 1 comhitamb

schema mc3ambw		//AMBUSHED +w/co
archetype AI_COMBAT
mc3ambw1 mc3ambw2 mc3ambw3
schema_voice vmech3 2 comhitamb (NearbyFriends 0 20)

schema mc3diea		//SOFT DEATH
archetype AI_MINOR
volume -500
mc3diea1 mc3diea2 mc3diea3 mc3diea4 mc3diea5 mc3diea6
schema_voice vmech3 1 comdiesoft

schema mc3diec		//LOUD DEATH
archetype AI_COMBAT
mc3diec1 mc3diec2 mc3diec3 mc3diec4 mc3diec5 mc3diec6
schema_voice vmech3 1 comdieloud

//----------------------------------------------------