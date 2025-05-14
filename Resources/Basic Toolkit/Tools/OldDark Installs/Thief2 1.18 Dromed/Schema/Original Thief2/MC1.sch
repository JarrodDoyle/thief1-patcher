//MECH 1 BROADCASTS 

//----------------------------------------------------

schema mc1a0sn			//SLEEPING
archetype AI_NONE
volume -500
mono_loop 2000 3000
mc1a0sn1 mc1a0sn2 mc1a0sn3 mc1a0sn4 
schema_voice vmech1 1 sleeping

schema mc1a0			//COUGHING
archetype AI_NONE
volume -500
mono_loop 7500 15000
mc1a0co1 mc1a0co2 mc1a0co3 mc1a0co4 mc1a0co5
mc1a0th1 mc1a0th2 mc1a0th3 mc1a0th4 mc1a0th5 
schema_voice vmech1 1 atlevelzero

schema mc1a0hu			//HUMMING & WHISTLING
archetype AI_NONE
stream
volume -500
mono_loop 7500 15000
mc1a0hu1 mc1a0hu2 mc1a0hu3 mc1a0hu4 mc1a0hu5 
mc1a0wh1 mc1a0wh2 mc1a0wh3 
mc1a0co1 mc1a0co2 mc1a0co3 mc1a0co4 mc1a0co5
schema_voice vmech1 1 atlevelzero

schema mc1a0ch			//CHANTING 
archetype AI_NONE
volume -500
stream
mono_loop 7500 15000
mc1a0ch1 mc1a0ch2 mc1a0ch3 mc1a0ch4 mc1a0ch5 mc1a0ch6 mc1a0ch7 mc1a0ch8 mc1a0ch9 mc1a0cha mc1a0chb 
mc1a0hu1 mc1a0hu2 mc1a0hu3 mc1a0hu4 mc1a0hu5 
mc1a0th1 mc1a0th2 mc1a0th3 mc1a0th4 
schema_voice vmech1 1 atlevelzero

//----------------------------------------------------

schema mc1a1			//TO ALERT 1
archetype AI_NONE
mc1a1__1 mc1a1__2 mc1a1__3 mc1a1__4 
schema_voice vmech1 1 tolevelone  

schema mc1a1v			//TO ALERT 1 +sighted
archetype AI_NONE
mc1a1v_1
schema_voice vmech1 1 tolevelone (Sense Sight)

schema mc1a1h			//TO ALERT 1 +heard
archetype AI_NONE
mc1a1h_1 mc1a1h_2
schema_voice vmech1 2 tolevelone (Sense Sound)

schema mc1a1_w			//TO ALERT 1 +w/co
archetype AI_MINOR
mc1a1_w1
schema_voice vmech1 2 tolevelone (NearbyFriends 0 20)

schema mc1a1vw			//TO ALERT 1 +sighted +w/co
archetype AI_MINOR
mc1a1vw1 mc1a1vw2 mc1a1vw3
schema_voice vmech1 3 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema mc1a1hw			//TO ALERT 1 +heard +w/co
archetype AI_MINOR
mc1a1hw1 mc1a1hw2 mc1a1hw3
schema_voice vmech1 3 tolevelone (Sense Sound) (NearbyFriends 0 20)


//----------------------------------------------------

schema mc1a2			//TO ALERT 2
archetype AI_MINOR
mc1a2__1 mc1a2__2 mc1a2__3 
schema_voice vmech1 1 toleveltwo  

schema mc1a2v			//TO ALERT 2 +sighted
archetype AI_MINOR
mc1a2v_1
schema_voice vmech1 1 toleveltwo (Sense Sight)  

schema mc1a2h			//TO ALERT 2 +heard
archetype AI_MINOR
mc1a2h_1 mc1a2h_2
schema_voice vmech1 2 toleveltwo (Sense Sound)

//----------------------------------------------------

schema mc1a3 			//TO ALERT 3 NOT BY SEEING THE PLAYER
archetype AI_MAJOR
mc1a3__1 mc1a3__2 mc1a3__3
schema_voice vmech1 1 tolevelthree

schema mc1a3s			//SPOTTED THE PLAYER
archetype AI_MORE_MAJOR
mc1a3s_1 mc1a3s_2 mc1a3s_3 mc1a3s_4
mc1a3na1 mc1a3na2 mc1a3na3 mc1a3na4
schema_voice vmech1 1 spotplayer 

schema mc1telr			//SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
mc1telr1 mc1telr2 mc1telr3 
schema_voice vmech1 5 spotplayer (NearbyFriends 0 20)
schema_voice vmech1 1 reacttellrev

schema mc1a3b			//SPOTTED THE PLAYER +body
archetype AI_MORE_MAJOR
mc1a3b_1 mc1a3b_2 mc1a3b_3
schema_voice vmech1 9 spotplayer (CarryBody True)

schema mc1telc			//RE-SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
mc1telc1 mc1telc2 mc1telc3
schema_voice vmech1 5 spotplayer (NearbyFriends 0 20) (Reacquire true)
schema_voice vmech1 1 reacttellconf

//----------------------------------------------------

schema mc1at1			//AT ALERT 1 & 2
archetype AI_NONE
delay 3000
volume -500
mono_loop 7500 15000
mc1a0co1 mc1a0co2 mc1a0co3 mc1a0co4 mc1a0co5
mc1a0th1 mc1a0th2 mc1a0th3 mc1a0th4 mc1a0th5 
schema_voice vmech1 1 atlevelone
schema_voice vmech1 1 atleveltwo

schema mc1at2			//AT ALERT 2 & 3 +Investigating
archetype AI_MINOR
delay 6000
mono_loop 15000 30000
no_repeat
mc1a2se1 mc1a2se2 mc1a2se3 mc1a2se4 mc1a3se1 mc1a3se2 mc1a3se3 mc1a3se4
schema_voice vmech1 99 atleveltwo (Investigate True)
schema_voice vmech1 99 atlevelthree (Investigate True)

//----------------------------------------------------

schema mc1chga			//REACT CHARGE
archetype AI_MORE_MAJOR
mc1chga1 mc1chga2 mc1chga3 mc1chga4
schema_voice vmech1 1 reactcharge

schema mc1chgw			//REACT CHARGE +w/co
archetype AI_COMBAT
mc1chgw1 mc1chgw2 mc1chgw3
schema_voice vmech1 2 reactcharge (NearbyFriends 0 20)

schema mc1atb			//REACT SHOOT	
archetype AI_MORE_MAJOR
mc1atb_1 mc1atb_2 mc1atb_3
mc1ats_1 mc1ats_2 mc1ats_3
schema_voice vmech1 1 reactshoot

schema mc1runa			//REACT RUN AWAY +alone
archetype AI_MAJOR
mc1runa1 mc1runa2 mc1runa3
schema_voice vmech1 1 reactrun 

schema mc1alma			//REACT I SOUND THE ALARMS
archetype AI_MORE_MAJOR
mc1alma1 mc1alma2 
schema_voice vmech1 1 reactalarm

schema mc1almw			//REACT YOU SOUND ALARMS +w/co
archetype AI_COMBAT
mc1almw1
schema_voice vmech1 9 reactalarm (NearbyFriends 0 20)

//----------------------------------------------------

schema mc1bak			//BACK TO ALERT 0
archetype AI_NONE
volume -500
mc1bak_1 mc1bak_2 mc1bak_3 mc1bak_4 mc1bak_5 mc1bak_6 mc1bak_7 mc1bak_8
schema_voice vmech1 1 backtozero  

schema mc1los			//LOST CONTACT W/PLAYER
archetype AI_NONE
mc1los_1 mc1los_2 mc1los_3
schema_voice vmech1 1 lostcontact  

schema mc1frust			//FRUSTRATION
archetype AI_MAJOR
mc1frus1 mc1frus2 mc1frus3
schema_voice vmech1 1 outofreach 

schema mc1torch			//NOTICED DOUSED TORCH
archetype AI_MINOR
delay 1000
mc1torc1 mc1torc2
schema_voice vmech1 1 notice (Item Torch)

schema mc1gas			//NOTICED DOUSED GASLIGHT
archetype AI_MINOR
delay 1000
mc1torc1 mc1torc3
schema_voice vmech1 1 notice (Item Gaslight)

schema mc1getbowman		//RUN TO GET A BOWMAN
archetype AI_MORE_MAJOR
mc1runa3 mc1telr1
schema_voice vmech1 1 getbowman 

//----------------------------------------------------

schema mc1bod			//FOUND BODY	
archetype AI_MORE_MAJOR
mc1bod_1 mc1bod_2 mc1bod_3
schema_voice vmech1 1 foundbody  

schema mc1mis			//FOUND SOMETHING MISSING
archetype AI_MAJOR
mc1mis_1 mc1mis_2
schema_voice vmech1 1 foundmissing
schema_voice vmech1 1 notice (Item MissingLoot)

schema mc1sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
mc1sma_1 mc1sma_2
schema_voice vmech1 1 foundsmall  
schema_voice vmech1 1 notice (Item Door Generic)

schema mc1lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
mc1lar_1 mc1lar_2
schema_voice vmech1 1 foundlarge

schema mc1sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
mc1sec_1 mc1sec_2 mc1sec_3
schema_voice vmech1 1 foundbreach

schema mc1rob			//FOUND DEAD ROBOT	
archetype AI_MAJOR
mc1rob_1 mc1rob_2 mc1rob_3
schema_voice vmech1 1 foundrobot  

//----------------------------------------------------

schema mc1rint			//RECENTLY SAW THE PLAYER +w/co
archetype AI_INFORM
mc1rint1 mc1rint2 mc1rint3
schema_voice vmech1 1 recentintruder 

schema mc1rbod			//RECENTLY FOUND BODY +w/co
archetype AI_INFORM
mc1rbod1 mc1rbod2
schema_voice vmech1 1 recentbody 

schema mc1rmis			//RECENTLY FOUND MISSING +w/co
archetype AI_INFORM
mc1rmis1
schema_voice vmech1 1 recentmissing 

schema mc1roth			//RECENTLY FOUND MISC ANAMOLY +w/co
archetype AI_INFORM
mc1roth1 mc1roth2 mc1roth3
schema_voice vmech1 1 recentother 

schema mc1rrob			//RECENTLY FOUND DEAD ROBOT +w/co
archetype AI_INFORM
mc1rob_2
schema_voice vmech1 1 recentrobot 

//----------------------------------------------------

//COMBAT
schema mc1atn			//ATTACKING +not losing
archetype AI_COMBAT
mc1atn_1 freq 1
mc1atn_2 freq 1
mc1atn_3 freq 2
mc1atn_4 freq 3
mc1atn_5 freq 3
mc1atn_6 freq 1
mc1atn_7 freq 1
mc1atn_8 freq 1
mc1atn_9 freq 1
mc1atn_a freq 2
mc1atn_b freq 3
mc1atn_c freq 3
schema_voice vmech1 1 comattack (ComBal Winning Even)

schema mc1atnw			//ATTACKING +winning
archetype AI_COMBAT
mc1atw_1 mc1atw_2
schema_voice vmech1 2 comattack (ComBal Winning)

schema mc1atww			//ATTACKING +winning +w/co
archetype AI_COMBAT
mc1atww1
schema_voice vmech1 2 comattack (ComBal Winning) (NearbyFriends 0 20)

schema mc1atl			//ATTACKING +losing
archetype AI_COMBAT
mc1atl_1 mc1atl_2 mc1atl_3 mc1atl_4 mc1atl_5 mc1atl_6 
schema_voice vmech1 1 comattack (ComBal Losing)

//----------------------------------------------------

schema mc1hit			//HIT THE PLAYER
archetype AI_COMBAT
mc1hit_1 mc1hit_2 mc1hit_3 mc1hit_4
schema_voice vmech1 1 comsucchit (ComBal Winning Even)

schema mc1hitw			//HIT THE PLAYER +w/co
archetype AI_COMBAT
mc1hitw1 mc1hitw2
schema_voice vmech1 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

schema mc1blk			//BLOCKED THE PLAYER
archetype AI_COMBAT
mc1blk_1 mc1blk_2 mc1blk_3
schema_voice vmech1 1 comsuccblock (ComBal Winning Even)

schema mc1blkw			//BLOCKED THE PLAYER +w/co
archetype AI_COMBAT
mc1blkw1
schema_voice vmech1 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema mc1hhi			//HIT BY PLAYER W/HI HIT PTS 
archetype AI_MAJOR
mc1hhi_1 mc1hhi_2 mc1hhi_3 mc1hhi_4 mc1hhi_5 mc1hhi_6
schema_voice vmech1 1 comhithigh
schema_voice vmech1 99 comhitnodam (ComBal Losing)

schema mc1hlo			//HIT BY PLAYER W/LO PTS 
archetype AI_MORE_MAJOR
mc1hlo_1 mc1hlo_2 mc1hlo_3 mc1hlo_4 mc1hlo_5 mc1hlo_6
schema_voice vmech1 1 comhitlow

schema mc1hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
mc1hlow1
schema_voice vmech1 1 comhitlow (NearbyFriends 0 20)

schema mc1hnd			//HIT BY PLAYER NO DAMAGE +Winning
archetype AI_MAJOR
mc1hnd_1 mc1hnd_2 mc1hnd_3
schema_voice vmech1 99 comhitnodam (ComBal Winning)
schema_voice vmech1 1 comhitnodam

schema mc1hnde			//HIT BY PLAYER NO DAMAGE +Even
archetype AI_MAJOR
mc1hnde1 mc1hnde2 mc1hnde3
schema_voice vmech1 99 comhitnodam (ComBal Even)
schema_voice vmech1 3 comhitnodam

//----------------------------------------------------

schema mc1bkd 			//BLOCKED BY PLAYER
archetype AI_COMBAT
mc1bkd_1 mc1bkd_2 mc1bkd_3
schema_voice vmech1 1 comblocked (ComBal Winning Even)

schema mc1bkdw 			//BLOCKED BY THE PLAYER +w/co
archetype AI_COMBAT
mc1bkdw1
schema_voice vmech1 2 comblocked (ComBal Winning Even) (NearbyFriends 0 20)

schema mc1det 			//DETECTED BLOCK
archetype AI_COMBAT
mc1det_1 mc1det_2 mc1det_3
schema_voice vmech1 1 comdetblock (ComBal Winning Even)

schema mc1detw 			//DETECTED BLOCK +w/co
archetype AI_COMBAT
mc1detw1
schema_voice vmech1 2 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema mc1amb 		//AMBUSHED
archetype AI_MAJOR 
mc1amb_1 mc1amb_2 mc1amb_3 mc1amb_4
schema_voice vmech1 1 comhitamb

schema mc1ambw		//AMBUSHED +w/co
archetype AI_COMBAT
mc1ambw1 mc1ambw2 mc1ambw3
schema_voice vmech1 2 comhitamb (NearbyFriends 0 20)

schema mc1diea		//SOFT DEATH
archetype AI_MINOR
volume -500
mc1diea1 mc1diea2 mc1diea3 mc1diea4 mc1diea5
schema_voice vmech1 1 comdiesoft

schema mc1diec		//LOUD DEATH
archetype AI_COMBAT
mc1diec1 mc1diec2 mc1diec3 mc1diec4 
schema_voice vmech1 1 comdieloud

//----------------------------------------------------
//----------------------------------------------------
