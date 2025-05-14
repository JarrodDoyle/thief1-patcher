//MECH 4 BROADCASTS 

//----------------------------------------------------

schema mc4a0sn			//SLEEPING
archetype AI_NONE
volume -500
mono_loop 2000 3000
mc4a0sn1 mc4a0sn2 mc4a0sn3 mc4a0sn4
schema_voice vmech4 1 sleeping

schema mc4a0			//COUGHING & HUMMING
archetype AI_NONE
delay 4000
volume -500
mono_loop 7500 15000
mc4a0co1 mc4a0co2 mc4a0co3 mc4a0co4 mc4a0co5
mc4a0hu1 mc4a0hu2 mc4a0hu3 mc4a0hu4 mc4a0hu5 mc4a0hu6
schema_voice vmech4 1 atlevelzero

schema mc4a0hu			//HUMMING, WHISTLING & MUTTERING
archetype AI_NONE
delay 4000
volume -500
mono_loop 7500 15000
mc4a0hu1 mc4a0hu2 mc4a0hu3 mc4a0hu4 mc4a0hu5 mc4a0hu6
mc4a0wh1 mc4a0wh2 mc4a0wh3 mc4a0wh4 mc4a0wh5
mc4a0mu1 mc4a0mu1 mc4a0mu1 
mc4a0th1 mc4a0th2 mc4a0th3 mc4a0th4 mc4a0th5
schema_voice vmech4 1 atlevelzero

schema mc4a0ch			//CHANTING & THROAT
archetype AI_NONE
delay 4000
volume -1000
mono_loop 7500 15000
mc4a0ch1 mc4a0ch2 mc4a0ch3 mc4a0ch4 mc4a0ch5 mc4a0ch6 mc4a0ch7 mc4a0ch8 mc4a0ch9 mc4a0cha mc4a0chb
mc4a0th1 mc4a0th2 mc4a0th3 mc4a0th4 mc4a0th5
schema_voice vmech4 1 atlevelzero

//----------------------------------------------------

schema mc4a1			//TO ALERT 1
archetype AI_NONE
mc4a1__1 mc4a1__2 mc4a1__3 mc4a1__4 
schema_voice vmech4 1 tolevelone  

schema mc4a1v			//TO ALERT 1 +sighted
archetype AI_NONE
mc4a1v_1
schema_voice vmech4 1 tolevelone (Sense Sight)

schema mc4a1h			//TO ALERT 1 +heard
archetype AI_NONE
mc4a1h_1 mc4a1h_2
schema_voice vmech4 2 tolevelone (Sense Sound)

schema mc4a1_w			//TO ALERT 1 +w/co
archetype AI_MINOR
mc4a1_w1
schema_voice vmech4 2 tolevelone (NearbyFriends 0 20)

schema mc4a1vw			//TO ALERT 1 +sighted +w/co
archetype AI_MINOR
mc4a1vw1 mc4a1vw2 mc4a1vw3
schema_voice vmech4 3 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema mc4a1hw			//TO ALERT 1 +heard +w/co
archetype AI_MINOR
mc4a1hw1 mc4a1hw2 mc4a1hw3
schema_voice vmech4 3 tolevelone (Sense Sound) (NearbyFriends 0 20)


//----------------------------------------------------

schema mc4a2			//TO ALERT 2
archetype AI_MINOR
mc4a2__1 mc4a2__2 mc4a2__3 mc4a2__4
schema_voice vmech4 1 toleveltwo  

schema mc4a2v			//TO ALERT 2 +sighted
archetype AI_MINOR
mc4a2v_1
schema_voice vmech4 1 toleveltwo (Sense Sight)  

schema mc4a2h			//TO ALERT 2 +heard
archetype AI_MINOR
mc4a2h_1 mc4a2h_2
schema_voice vmech4 2 toleveltwo (Sense Sound)

//----------------------------------------------------

schema mc4a3 			//TO ALERT 3 NOT BY SEEING THE PLAYER
archetype AI_MAJOR
mc4a3__1 mc4a3__2 mc4a3__3 mc4a3__4 mc4a3__5 mc4a3__6
schema_voice vmech4 1 tolevelthree

schema mc4a3s			//SPOTTED THE PLAYER
archetype AI_MORE_MAJOR
mc4a3s_1 mc4a3s_2 mc4a3s_3 mc4a3s_4
mc4a3na1 mc4a3na2 mc4a3na3 mc4a3na4
schema_voice vmech4 1 spotplayer 

schema mc4telr			//SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
mc4telr1 mc4telr2 mc4telr3 
schema_voice vmech4 5 spotplayer (NearbyFriends 0 20)
schema_voice vmech4 1 reacttellrev

schema mc4a3b			//SPOTTED THE PLAYER +body
archetype AI_MORE_MAJOR
mc4a3b_1 mc4a3b_2 
schema_voice vmech4 9 spotplayer (CarryBody True)

schema mc4telc			//RE-SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
mc4telc1 mc4telc2 mc4telc3
schema_voice vmech4 5 spotplayer (NearbyFriends 0 20) (Reacquire true)
schema_voice vmech4 1 reacttellconf

//----------------------------------------------------

schema mc4at1			//AT ALERT 1 & 2
archetype AI_NONE
delay 4000
volume -500
mono_loop 7500 15000
mc4a0co1 mc4a0co2 mc4a0co3 mc4a0co4 mc4a0co5
mc4a0th1 mc4a0th2 mc4a0th3 mc4a0th4 mc4a0th5
schema_voice vmech4 1 atlevelone
schema_voice vmech4 1 atleveltwo

schema mc4at2inv			//AT ALERT 2 & 3 +Investigating
archetype AI_MINOR
delay 6000
mono_loop 15000 30000
no_repeat
mc4a2se1 mc4a2se2 mc4a2se3 mc4a2se4 mc4a3se1 mc4a3se2 mc4a3se3 mc4a3se4
schema_voice vmech4 99 atleveltwo (Investigate True)
schema_voice vmech4 99 atlevelthree (Investigate True)

//----------------------------------------------------

schema mc4chga			//REACT CHARGE
archetype AI_MORE_MAJOR
mc4chga1 mc4chga2 mc4chga3
schema_voice vmech4 1 reactcharge

schema mc4chgw			//REACT CHARGE +w/co
archetype AI_COMBAT
mc4chgw1 mc4chgw2 mc4chgw3
schema_voice vmech4 2 reactcharge (NearbyFriends 0 20)

schema mc4atb			//REACT SHOOT	
archetype AI_MORE_MAJOR
mc4atb_1 mc4atb_2 mc4atb_3
mc4ats_1 mc4ats_2
schema_voice vmech4 1 reactshoot

schema mc4runa			//REACT RUN AWAY
archetype AI_MAJOR
mc4runa1 mc4runa2 mc4runa3
schema_voice vmech4 1 reactrun 

schema mc4alma			//REACT I SOUND THE ALARMS
archetype AI_MORE_MAJOR
mc4alma1 mc4alma2 
schema_voice vmech4 1 reactalarm

schema mc4almw			//REACT YOU TO SOUND THE ALARMS +w/co
archetype AI_COMBAT
mc4almw1
schema_voice vmech4 9 reactalarm (NearbyFriends 0 20)

//----------------------------------------------------

schema mc4bak			//BACK TO ALERT 0
archetype AI_NONE
volume -500
mc4bak_1 mc4bak_2 mc4bak_3 mc4bak_4 mc4bak_5 mc4bak_6 mc4bak_7 mc4bak_8
schema_voice vmech4 1 backtozero  

schema mc4los			//LOST CONTACT W/PLAYER
archetype AI_NONE
mc4los_1 mc4los_2 mc4los_3
schema_voice vmech4 1 lostcontact  

schema mc4frust			//FRUSTRATION
archetype AI_MAJOR
mc4frus1 mc4frus2 mc4frus3
schema_voice vmech4 1 outofreach 

schema mc4torch			//NOTICED A DOUSED TORCH
archetype AI_MINOR
delay 1000
mc4torc1 mc4torc2
schema_voice vmech4 1 notice (Item Torch)

schema mc4gas			//NOTICED A DOUSED GASLIGHT
archetype AI_MINOR
delay 1000
mc4torc3
schema_voice vmech4 1 notice (Item GasLight)

schema mc4getbowman		//RUN & GET A BOWMAN
archetype AI_MAJOR
mc4runa1 mc4runa2
schema_voice vmech4 1 getbowman 

//----------------------------------------------------

schema mc4bod			//FOUND BODY	
archetype AI_MORE_MAJOR
mc4bod_1 mc4bod_2 mc4bod_3
schema_voice vmech4 1 foundbody  

schema mc4mis			//FOUND SOMETHING MISSING
archetype AI_MAJOR
mc4mis_1 mc4mis_2
schema_voice vmech4 1 foundmissing
schema_voice vmech4 1 notice (Item MissingLoot)

schema mc4sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
mc4sma_1 mc4sma_2
schema_voice vmech4 1 foundsmall  
schema_voice vmech4 1 notice (Item Door Generic)

schema mc4lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
mc4lar_1 mc4lar_2
schema_voice vmech4 1 foundlarge

schema mc4sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
mc4sec_1 mc4sec_2 mc4sec_3
schema_voice vmech4 1 foundbreach

schema mc4rob			//FOUND DEAD ROBOT	
archetype AI_MAJOR
mc4rob_1 mc4rob_2 mc4rob_3
schema_voice vmech4 1 foundrobot  

//----------------------------------------------------

schema mc4rint			//RECENTLY SAW THE PLAYER +w/co
archetype AI_INFORM
mc4rint1 
schema_voice vmech4 1 recentintruder 

schema mc4rbod			//RECENTLY FOUND BODY +w/co
archetype AI_INFORM
mc4rbod1  
schema_voice vmech4 1 recentbody 

schema mc4rrob			//RECENTLY FOUND DEAD ROBOT +w/co
archetype AI_INFORM
mc4rrob1
schema_voice vmech4 1 recentrobot 


schema mc4rmis			//RECENTLY FOUND MISSING +w/co
archetype AI_INFORM
mc4rmis1
schema_voice vmech4 1 recentmissing 

schema mc4roth			//RECENTLY FOUND MISC ANAMOLY +w/co
archetype AI_INFORM
mc4roth1 mc4roth2 mc4roth3
schema_voice vmech4 1 recentother 

//----------------------------------------------------

//COMBAT
schema mc4atn			//ATTACKING +not losing
archetype AI_COMBAT
mc4atn_1 freq 1
mc4atn_2 freq 1
mc4atn_3 freq 2
mc4atn_4 freq 2
mc4atn_5 freq 2
mc4atn_6 freq 1
mc4atn_7 freq 1
mc4atn_8 freq 1
mc4atn_9 freq 1
mc4atn_a freq 2
mc4atn_b freq 2
mc4atn_c freq 2
schema_voice vmech4 1 comattack (ComBal Winning Even)

schema mc4atnw			//ATTACKING +winning
archetype AI_COMBAT
mc4atw_1 mc4atw_2
schema_voice vmech4 2 comattack (ComBal Winning)

schema mc4atww			//ATTACKING +winning +w/co
archetype AI_COMBAT
mc4atww1
schema_voice vmech4 2 comattack (ComBal Winning) (NearbyFriends 0 20)

schema mc4atl			//ATTACKING +losing
archetype AI_COMBAT
mc4atl_1 mc4atl_2 mc4atl_3 mc4atl_4 mc4atl_5 mc4atl_6 mc4atl_7
schema_voice vmech4 1 comattack (ComBal Losing)

//----------------------------------------------------

schema mc4hit			//HIT THE PLAYER
archetype AI_COMBAT
mc4hit_1 mc4hit_2 mc4hit_3 mc4hit_4
schema_voice vmech4 1 comsucchit (ComBal Winning Even)

schema mc4hitw			//HIT THE PLAYER +w/co
archetype AI_COMBAT
mc4hitw1 mc4hitw2
schema_voice vmech4 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

schema mc4blk			//BLOCKED THE PLAYER
archetype AI_COMBAT
mc4blk_1 mc4blk_2 mc4blk_3
schema_voice vmech4 1 comsuccblock (ComBal Winning Even)

schema mc4blkw			//BLOCKED THE PLAYER +w/co
archetype AI_COMBAT
mc4blkw1
schema_voice vmech4 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema mc4hhi			//HIT BY PLAYER W/HI HIT PTS 
archetype AI_MAJOR
mc4hhi_1 mc4hhi_2 mc4hhi_3 mc4hhi_4 mc4hhi_5 mc4hhi_6 mc4hhi_7 mc4hhi_8 mc4hhi_9
schema_voice vmech4 1 comhithigh
schema_voice vmech4 99 comhitnodam (ComBal Losing)

schema mc4hlo			//HIT BY PLAYER W/LO PTS 
archetype AI_MORE_MAJOR
mc4hlo_1 mc4hlo_2 mc4hlo_3 mc4hlo_4 mc4hlo_5 mc4hlo_6 
schema_voice vmech4 1 comhitlow

schema mc4hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
mc4hlow1
schema_voice vmech4 1 comhitlow (NearbyFriends 0 20)

schema mc4hnd			//HIT BY PLAYER NO DAMAGE +Winning
archetype AI_MAJOR
mc4hnd_1 mc4hnd_2 mc4hnd_3
schema_voice vmech4 99 comhitnodam (ComBal Winning)
schema_voice vmech4 1 comhitnodam

schema mc4hnde			//HIT BY PLAYER NO DAMAGE +Even
archetype AI_MAJOR
mc4hnde1 mc4hnde2 mc4hnde3
schema_voice vmech4 99 comhitnodam (ComBal Even)
schema_voice vmech4 3 comhitnodam

//----------------------------------------------------

schema mc4bkd 			//BLOCKED BY PLAYER
archetype AI_COMBAT
mc4bkd_1 mc4bkd_2 mc4bkd_3
schema_voice vmech4 1 comblocked (ComBal Winning Even)

schema mc4bkdw 			//BLOCKED BY THE PLAYER +w/co
archetype AI_COMBAT
mc4bkdw1
schema_voice vmech4 2 comblocked (ComBal Winning Even) (NearbyFriends 0 20)

schema mc4det 			//DETECTED BLOCK
archetype AI_COMBAT
mc4det_1 mc4det_2 mc4det_3
schema_voice vmech4 1 comdetblock (ComBal Winning Even)

schema mc4detw 			//DETECTED BLOCK +w/co
archetype AI_COMBAT
mc4detw1
schema_voice vmech4 2 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema mc4amb 		//AMBUSHED
archetype AI_MAJOR 
mc4amb_1 mc4amb_2 mc4amb_3 mc4amb_4
schema_voice vmech4 1 comhitamb

schema mc4ambw		//AMBUSHED +w/co
archetype AI_COMBAT
mc4ambw1 mc4ambw2 mc4ambw3
schema_voice vmech4 2 comhitamb (NearbyFriends 0 20)

schema mc4diea		//SOFT DEATH
archetype AI_MINOR
volume -500
mc4diea1 mc4diea2 mc4diea3 mc4diea4 mc4diea5
schema_voice vmech4 1 comdiesoft

schema mc4diec		//LOUD DEATH
archetype AI_COMBAT
mc4diec1 mc4diec2 mc4diec3 mc4diec4 mc4diec5 mc4diec6
schema_voice vmech4 1 comdieloud

//----------------------------------------------------
