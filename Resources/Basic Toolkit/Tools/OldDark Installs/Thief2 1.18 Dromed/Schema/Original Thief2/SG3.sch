//GUARD&COP3 - BROADCAST SPEECH -Stephen Russell

//----------------------------------------------------

schema sg3a0sn			//ASLEEP
archetype AI_NONE
volume -500
mono_loop 2000 3000
sg3a0sn1 sg3a0sn2 sg3a0sn3 sg3a0sn4 sg3a0sn5 sg3a0sn6 sg3a0sn7 sg3a0sn8
schema_voice vguard3 1 sleeping
schema_voice vcop3 1 sleeping

schema sg3a0		 	//AT ALERT 0  
archetype AI_NONE
delay 3000
stream
volume -500
no_repeat
mono_loop 10000 20000
sg3a0wh1 sg3a0wh2 sg3a0wh3 sg3a0wh4
sg3a0mu1 sg3a0mu2 sg3a0mu3 sg3a0mu4 sg3a0mu5 
sg3a0co1 sg3a0co2 sg3a0co3 sg3a0co4 sg3a0co5 sg3a0co6
sg3a0tc1 sg3a0tc2 sg3a0tc3 sg3a0tc4 sg3a0tc5
schema_voice vguard3 1 atlevelzero

schema sg3a0_cop
archetype AI_NONE
delay 3000
stream
volume -500
no_repeat
mono_loop 10000 20000
sg3a0hu1 sg3a0hu2 sg3a0hu3 sg3a0hu4 sg3a0hu5 sg3a0hu6
sg3a0th1 sg3a0th2 sg3a0th3 sg3a0th4 sg3a0th5 sg3a0th6 sg3a0th7
sg3a0mu6 sg3a0mu7 sg3a0mu8 sg3a0mu9
sg3a0tc1 sg3a0tc2 sg3a0tc3 
schema_voice vcop3 1 atlevelzero

//----------------------------------------------------

schema sg3a1			//TO ALERT 1
archetype AI_NONE
sg3a1__1 sg3a1__2 sg3a1__3 sg3a1__5 sg3a1__8
schema_voice vguard3 1 tolevelone 

schema sg3a1_cop
archetype AI_NONE
sg3a1__7 sg3a1__1 sg3a1__2 sg3a1__3
schema_voice vcop3 1 tolevelone  

schema sg3a1v			//TO ALERT 1 +sighted 
archetype AI_NONE
sg3a1v_1 sg3a1v_3 sg3a1v_4
schema_voice vguard3 1 tolevelone (Sense Sight)

schema sg3a1v_cop
archetype AI_NONE
sg3a1v_2 sg3a1v_1 sg3a1v_3
schema_voice vcop3 1 tolevelone (Sense Sight)

schema sg3a1h			//TO ALERT 1 +heard
archetype AI_NONE
sg3a1h_1 sg3a1h_2 sg3a1h_4 sg3a1h_5
schema_voice vguard3 2 tolevelone (Sense Sound)

schema sg3a1h_cop
archetype AI_NONE
sg3a1h_3 sg3a1h_1 sg3a1h_2
schema_voice vcop3 2 tolevelone (Sense Sound)

schema sg3a1_w			//TO ALERT 1 +w/co
archetype AI_MINOR
sg3a1_w1 sg3a1_w2 
schema_voice vguard3 2 tolevelone (NearbyFriends 0 20)

schema sg3a1_w_cop
archetype AI_MINOR
sg3a1_w3 sg3a1_w1 sg3a1_w2 
schema_voice vcop3 2 tolevelone (NearbyFriends 0 20)

schema sg3a1vw			//TO ALERT 1 +sighted +w/co
archetype AI_MINOR
sg3a1vw1 sg3a1vw2 sg3a1vw3 sg3a1vw4 sg3a1vw7
schema_voice vguard3 2 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema sg3a1vw_cop
archetype AI_MINOR
sg3a1vw5 sg3a1vw6 sg3a1vw8 sg3a1vw1 sg3a1vw2 sg3a1vw3
schema_voice vcop3 3 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema sg3a1hw			//TO ALERT 1 +heard +w/co
archetype AI_MINOR
sg3a1hw1 sg3a1hw2 sg3a1hw3 sg3a1hw4 sg3a1hw7 sg3a1hw8
schema_voice vguard3 5 tolevelone (Sense Sound) (NearbyFriends 0 20)

schema sg3a1hw_cop
archetype AI_MINOR
sg3a1hw5 sg3a1hw6 sg3a1hw3 sg3a1hw4 sg3a1hw8
schema_voice vcop3 5 tolevelone (Sense Sound) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg3a1tc			//AT ALERT 1 & 2
archetype AI_NONE
volume -500
delay 3000
mono_loop 8000 20000
sg3a0tc1 sg3a0tc2 sg3a0tc3 sg3a0tc4 sg3a0tc5
schema_voice vguard3 1 atlevelone
schema_voice vguard3 1 atleveltwo

schema sg3a1tc_cop
archetype AI_NONE
volume -500
delay 3000
mono_loop 8000 20000
sg3a0th1 sg3a0th2 sg3a0th3 sg3a0th4 sg3a0th5 sg3a0th6 sg3a0th7
schema_voice vcop3 1 atlevelone
schema_voice vcop3 1 atleveltwo

//----------------------------------------------------

schema sg3bak			//BACK TO ALERT 0
archetype AI_NONE
sg3bak_0 sg3bak_1 sg3bak_2 sg3bak_3 sg3bak_4 sg3bak_5 sg3bak_6 sg3bak_7 
schema_voice vguard3 1 backtozero  

schema sg3bak_cop
archetype AI_NONE
sg3bak_8 sg3bak_9 sg3bak_a sg3bak_b sg3bak_d sg3bak_1 sg3bak_2
schema_voice vcop3 1 backtozero  

//----------------------------------------------------

schema sg3a2			//TO ALERT 2
archetype AI_MINOR
sg3a2__1 sg3a2__2 sg3a2__3 sg3a2__4 sg3a2__5 sg3a1__4
schema_voice vguard3 1 toleveltwo  

schema sg3a2_cop
archetype AI_MINOR
sg3a2__6 sg3a2__7 sg3a2__8 sg3a2__9 sg3a2__1 sg3a2__2 sg3a2__3 sg3a1__6 
schema_voice vcop3 1 toleveltwo  
				
schema sg3a2v			//TO ALERT 2 +sighted
archetype AI_MINOR
sg3a2v_1 sg3a2v_3
schema_voice vguard3 1 toleveltwo (Sense Sight)  

schema sg3a2v_cop
archetype AI_MINOR
sg3a2v_2 sg3a2v_1 sg3a2v_3
schema_voice vcop3 1 toleveltwo (Sense Sight)  

schema sg3a2h			//TO ALERT 2 +heard
archetype AI_MINOR
sg3a2h_1 sg3a2h_2 sg3a2h_5
schema_voice vguard3 2 toleveltwo (Sense Sound)

schema sg3a2h_cop
archetype AI_MINOR
sg3a2h_3 sg3a2h_4 sg3a2h_2 sg3a2h_5
schema_voice vcop3 2 toleveltwo (Sense Sound)

//----------------------------------------------------

schema sg3a3			//TO ALERT 3 
archetype AI_MAJOR
sg3a3__1 sg3a3__2 sg3a3__3 sg3a3__4 sg3a3__5 sg3a3__6
schema_voice vguard3 1 tolevelthree
schema_voice vcop3  1 tolevelthree

schema sg3a3s			//SPOTTED THE PLAYER 
archetype AI_MORE_MAJOR
sg3a3s_1 sg3a3s_2 sg3a3s_3 sg3a3s_4 
sg3a3na1 sg3a3na2 sg3a3na3 sg3a3na4 sg3a3na8 sg3a3na9
schema_voice vguard3 1 spotplayer 

schema sg3a3s_cop
archetype AI_MORE_MAJOR
sg3a3s_5 sg3a3s_6 sg3a3s_7 sg3a3s_8
sg3a3na5 sg3a3na6 sg3a3na7 sg3a3na1 sg3a3na2 sg3a3na3
schema_voice vcop3 3 spotplayer 

schema sg3a3b			//TO ALERT 3 +carrying a body
archetype AI_MORE_MAJOR
sg3a3b_1 sg3a3b_3
schema_voice vguard3 99 spotplayer (CarryBody True)

schema sg3a3b_cop
archetype AI_MORE_MAJOR
sg3a3b_2 
schema_voice vcop3 99 spotplayer (CarryBody True)

schema sg3telr			//TO ALERT 3 +w/co
archetype AI_COMBAT
sg3telr1 sg3telr2 sg3telr3 sg3telr4 sg3telr9
schema_voice vguard3 3 spotplayer (NearbyFriends 0 20)
schema_voice vguard3 3 reacttellrev

schema sg3telr_cop
archetype AI_COMBAT
sg3telr5 sg3telr6 sg3telr7 sg3telr8 sg3telr1 sg3telr2
schema_voice vcop3 4 spotplayer (NearbyFriends 0 20)
schema_voice vcop3 4 reacttellrev

//----------------------------------------------------

schema sg3at2			//AT ALERT 2 & 3 +Investigating
archetype AI_MINOR
delay 4000
no_repeat
mono_loop 10000 20000
sg3a2se1 sg3a2se2 sg3a2se3 sg3a2se4 sg3a2se5 sg3a2se6 sg3a2se7 sg3a2se8
sg3a3se1 sg3a3se2 sg3a3se3 sg3a3se4 sg3a3se5 sg3a3se6 sg3a3se7 sg3a3se8
schema_voice vguard3 99 atleveltwo (Investigate true)
schema_voice vguard3 99 atlevelthree (Investigate true)
schema_voice vcop3 99 atleveltwo (Investigate true)
schema_voice vcop3 99 atlevelthree (Investigate true)

//----------------------------------------------------

schema sg3telc			//RE-SPOTTED PLAYER +w/co
archetype AI_COMBAT
sg3telc1 sg3telc2 sg3telc3 sg3telc4 sg3telc5 sg3telc9
schema_voice vguard3 99 spotplayer (NearbyFriends 0 20) (Reacquire True) 
schema_voice vguard3 99 reacttellconf

schema sg3telc_cop
archetype AI_COMBAT
sg3tel6 sg3telc7 sg3telc8 sg3telca sg3telc2 sg3telc3
schema_voice vcop3 99 spotplayer (NearbyFriends 0 20) (Reacquire True) 
schema_voice vcop3 99 reacttellconf

//----------------------------------------------------

schema sg3los			//LOST CONTACT W/PLAYER
archetype AI_NONE
sg3los_1 sg3los_2 sg3los_3 sg3los_4
schema_voice vguard3 1 lostcontact  

schema sg3los_cop
archetype AI_NONE
sg3los_5 sg3los_6 sg3los_7 sg3los_8 sg3los_1 sg3los_2
schema_voice vcop3 2 lostcontact  

//----------------------------------------------------

schema sg3chga			//REACT CHARGE
archetype AI_MORE_MAJOR
sg3chga1 sg3chga2 sg3chga4
schema_voice vguard3 1 reactcharge

schema sg3chga_cop
archetype AI_MORE_MAJOR
sg3chga3 sg3chga1 sg3chga2 sg3chga4
schema_voice vcop3 1 reactcharge

schema sg3chgw			//REACT CHARGE +w/co
archetype AI_COMBAT
sg3chgw1 sg3chgw2 sg3chgw3 sg3chgw7
schema_voice vguard3 3 reactcharge (NearbyFriends 0 20)

schema sg3chgw_cop
archetype AI_COMBAT
sg3chgw4 sg3chgw5 sg3chgw6 sg3chgw1 sg3chgw2 sg3chgw3
schema_voice vcop3 3 reactcharge (NearbyFriends 0 20)

schema sg3runa			//REACT RUN AWAY
archetype AI_MAJOR
sg3runa1 sg3runa2 sg3runa3 sg3runa4
schema_voice vguard3 1 reactrun 

schema sg3runa_cop
archetype AI_MAJOR
sg3runa5 sg3runa6 sg3runa1 sg3runa2 sg3runa3
schema_voice vcop3 1 reactrun 

schema sg3alma			//REACT I SOUND ALARMS
archetype AI_MORE_MAJOR
sg3alma1 sg3alma2 sg3alma3 sg3alma6
schema_voice vguard3 1 reactalarm

schema sg3alma_cop
archetype AI_MORE_MAJOR
sg3alma4 sg3alma5 sg3alma1 sg3alma2 sg3alma3
schema_voice vcop3 1 reactalarm

schema sg3almw			//REACT YOU SOUND ALARMS +w/co
archetype AI_COMBAT
sg3almw1 sg3almw2 sg3almw4
schema_voice vguard3 3 reactalarm (NearbyFriends 0 20)

schema sg3almw_cop
archetype AI_COMBAT
sg3almw3 sg3almw1 sg3almw2
schema_voice vcop3 3 reactalarm (NearbyFriends 0 20)

//----------------------------------------------------

schema sg3bow			//REACT SHOOT
archetype AI_MORE_MAJOR
no_repeat
sg3atb_1 freq 2
sg3atb_2 freq 2
sg3atb_3 freq 2
sg3atb_4 freq 1
sg3atb_5 freq 1
sg3atb_6 freq 1
schema_voice vguard3 1 reactshoot
schema_voice vcop3 1 reactshoot

schema sg3frust			//FRUSTRATION
archetype AI_MAJOR
sg3frus1 sg3frus2 sg3frus3
schema_voice vguard3 1 outofreach
schema_voice vcop3 1 outofreach

schema sg3torch			//NOTICED A DOUSED TORCH
archetype AI_NONE
delay 1000
sg3torc1 sg3torc2
schema_voice vguard3 1 notice (Item Torch)
schema_voice vcop3 1 notice (Item Torch)

schema sg3gas			//NOTICED A DOUSED GASLIGHT
archetype AI_NONE
delay 1000
sg3torc3
schema_voice vguard3 1 notice (Item Gaslight)
schema_voice vcop3 1 notice (Item Gaslight)

schema sg3getbowman		//RUN AND GET A BOWMAN
archetype AI_MAJOR
sg3runa1 sg3runa3
schema_voice vguard3 1 getbowman
schema_voice vcop3 1 getbowman


//----------------------------------------------------

schema sg3bod			//FOUND BODY
archetype AI_MORE_MAJOR
sg3bod_1 sg3bod_2 sg3bod_5 sg3bod_6
schema_voice vguard3 1 foundbody  

schema sg3bod_cop
archetype AI_MORE_MAJOR
sg3bod_3 sg3bod_4 sg3bod_1 sg3bod_2 
schema_voice vcop3 1 foundbody  

schema sg3rob			//FOUND DEAD ROBOT
archetype AI_MORE_MAJOR
sg3rob_1 sg3rob_2
schema_voice vguard3 1 foundrobot  
schema_voice vcop3 1 foundrobot 

schema sg3mis			//FOUND SOMETHING MISSING 
archetype AI_MAJOR
sg3mis_1 sg3mis_2 sg3mis_5
schema_voice vguard3 1 foundmissing 
schema_voice vcop3 1 foundmissing 

schema sg3mis_cop
archetype AI_MAJOR
sg3mis_3 sg3mis_4 sg3mis_2 sg3mis_5
schema_voice vcop3 1 foundmissing 
schema_voice vcop3 1 notice (Item MissingLoot)

schema sg3sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
sg3sma_1 sg3sma_2 sg3sma_5 sg3sma_6 sg3sma_8
schema_voice vguard3 1 foundsmall  
schema_voice vguard3 1 notice (Item Door Generic)

schema sg3sma_cop
archetype AI_MINOR
sg3sma_3 sg3sma_4 sg3sma_7 sg3sma_1 sg3sma_2 
schema_voice vcop3 1 foundsmall  
schema_voice vcop3 1 notice (Item Door Generic)

schema sg3lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
sg3lar_1 sg3lar_2 sg3lar_5 sg3lar_6
schema_voice vguard3 1 foundlarge

schema sg3lar_cop
archetype AI_MAJOR
sg3lar_3 sg3lar_4 sg3lar_1 sg3lar_2
schema_voice vcop3 1 foundlarge

schema sg3sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
sg3sec_1 sg3sec_2 sg3sec_3 
schema_voice vguard3 1 foundbreach 

schema sg3sec_cop
archetype AI_MORE_MAJOR
sg3sec_4 sg3sec_5 sg3sec_1 sg3sec_2
schema_voice vcop3 1 foundbreach 

//----------------------------------------------------

schema sg3rint			//RECENTLY SAW THE PLAYER
archetype AI_INFORM
sg3rint1 sg3rint2 sg3rint3
schema_voice vguard3 1 recentintruder 

schema sg3rint_cop
archetype AI_INFORM
sg3rint4 sg3rint5 sg3rint1 sg3rint2 
schema_voice vcop3 1 recentintruder 

schema sg3rbod			//RECENTLY FOUND BODY
archetype AI_INFORM
sg3rbod1 sg3rbod2 sg3rbod3 sg3rbod6
schema_voice vguard3 1 recentbody 

schema sg3rbod_cop
archetype AI_INFORM
sg3rbod4  sg3rbod5 sg3rbod1 sg3rbod2
schema_voice vcop3 1 recentbody 

schema sg3rrob			//RECENTLY FOUND DEAD ROBOT
archetype AI_INFORM
sg3roth3 sg3roth1
schema_voice vguard3 1 recentrobot 
schema_voice vcop3 1 recentrobot 

schema sg3rmis			//RECENTLY FOUND MISSING
archetype AI_INFORM
sg3rmis1 sg3rmis2 sg3rmis5
schema_voice vguard3 1 recentmissing 

schema sg3rmis_cop
archetype AI_INFORM
sg3rmis3 sg3rmis4 sg3rmis2 sg3rmis5
schema_voice vcop3 1 recentmissing 

schema sg3roth			//RECENTLY FOUND ANAMOLY
archetype AI_INFORM
sg3roth1 sg3roth2 sg3roth3 sg3roth4
schema_voice vguard3 1 recentother 

schema sg3roth_cop
archetype AI_INFORM 
sg3roth5 sg3roth6 sg3roth7 sg3roth3 sg3roth4
schema_voice vcop3 1 recentother 

//----------------------------------------------------
//COMBAT

schema sg3atn			//ATTACKING +not losing
archetype AI_COMBAT
sg3atn_1 freq 1
sg3atn_2 freq 1
sg3atn_3 freq 2
sg3atn_4 freq 2
sg3atn_5 freq 2
sg3atn_6 freq 2
sg3atn_7 freq 2
sg3atn_8 freq 2
schema_voice vguard3 1 comattack (ComBal Even)
schema_voice vcop3 1 comattack (ComBal Even)

schema sg3atnw			//ATTACKING	+winning
archetype AI_COMBAT
sg3atw_1 sg3atw_2 sg3atn_3 sg3atn_4 sg3atn_5 sg3atn_6
schema_voice vguard3 3 comattack (ComBal Winning)
schema_voice vcop3 3 comattack (ComBal Winning)

schema sg3atww			//ATTACKING +winning +w/co
archetype AI_COMBAT
sg3atww1 sg3atn_7 sg3atn_8 sg3atn_1
schema_voice vguard3 3 comattack (ComBal Winning) (NearbyFriends 0 20)
schema_voice vcop3 3 comattack (ComBal Winning) (NearbyFriends 0 20)

schema sg3atww_cop			//ATTACKING +winning +w/co
archetype AI_COMBAT
sg3atww2 sg3atn_3 sg3atn_4 sg3atn_2
schema_voice vguard3 3 comattack (ComBal Winning) (NearbyFriends 0 20)
schema_voice vcop3 3 comattack (ComBal Winning) (NearbyFriends 0 20)

schema sg3atl			//ATTACKING	+losing
archetype AI_COMBAT
sg3atl_1 sg3atl_2 sg3atl_3 sg3atl_4 sg3atl_5 sg3atl_6
schema_voice vguard3 2 comattack (ComBal Losing)
schema_voice vcop3 2 comattack (ComBal Losing)

//----------------------------------------------------

schema sg3hit			//HIT THE PLAYER +not losing
archetype AI_COMBAT
sg3hit_1 sg3hit_2 sg3hit_3 sg3hit_4 sg3hit_5
schema_voice vguard3 1 comsucchit (ComBal Winning Even)
schema_voice vcop3 1 comsucchit (ComBal Winning Even)

schema sg3hitw			//HIT THE PLAYER +not losing +w/co
archetype AI_COMBAT
sg3hitw1 sg3hitw2
schema_voice vguard3 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop3 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

schema sg3blk			//BLOCKED THE PLAYER +not losing
archetype AI_COMBAT
sg3blk_1 sg3blk_2 sg3blk_3 sg3blk_4 sg3blk_5 sg3blk_6
schema_voice vguard3 1 comsuccblock (ComBal Winning Even)
schema_voice vcop3 1 comsuccblock (ComBal Winning Even)

schema sg3blkw			//BLOCKED THE PLAYER +not losing +w/co
archetype AI_COMBAT
sg3blkw1 sg3blkw2
schema_voice vguard3 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop3 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg3hhi			//HIT BY PLAYER W/HI HIT PTS 
archetype AI_MAJOR
sg3hhi_1 sg3hhi_2 sg3hhi_3 sg3hhi_4 sg3hhi_5 sg3hhi_6 sg3hhi_7
schema_voice vguard3 1 comhithigh
schema_voice vguard3 99 comhitnodam (ComBal Losing)
schema_voice vcop3 1 comhithigh
schema_voice vcop3 99 comhitnodam (ComBal Losing)

schema sg3hlo			//HIT BY PLAYER W/LO PTS 
archetype AI_MORE_MAJOR
sg3hlo_1 sg3hlo_2 sg3hlo_3 sg3hlo_4 sg3hlo_5 sg3hhi_6 sg3hhi_7
schema_voice vguard3 1 comhitlow
schema_voice vcop3 1 comhitlow

schema sg3hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
sg3hlow1 sg3hlo_1 sg3hlo_2 sg3hlo_3 sg3hlo_4
schema_voice vguard3 99 comhitlow (NearbyFriends 0 20)
schema_voice vcop3 99 comhitlow (NearbyFriends 0 20)

schema sg3hnd			//HIT BY PLAYER NO DAMAGE +Winning
archetype AI_NONE
sg3hnd_1 sg3hnd_2 sg3hnd_3 
schema_voice vguard3 99 comhitnodam (ComBal Winning)
schema_voice vcop3 99 comhitnodam (ComBal Winning)
schema_voice vguard3 1 comhitnodam
schema_voice vcop3 1 comhitnodam


schema sg3hnd_e			//HIT BY THE PLAYER NO DAMAGE +Even
archetype AI_NONE
sg3hnde1 sg3hnde2 sg3hnde3 sg3hnde4
schema_voice vguard3 99 comhitnodam (ComBal Even)
schema_voice vcop3 99 comhitnodam (ComBal Even)
schema_voice vguard3 3 comhitnodam
schema_voice vcop3 3 comhitnodam

//----------------------------------------------------

schema sg3bkd 			//BLOCKED BY PLAYER +not losing
archetype AI_COMBAT
sg3bkd_1 sg3bkd_2 sg3bkd_3 sg3bkd_4
schema_voice vguard3 1 comblocked (ComBal Winning Even)
schema_voice vcop3 1 comblocked (ComBal Winning Even)

schema sg3bkdw 			//BLOCKED BY PLAYER +not losing +w/co
archetype AI_COMBAT
sg3bkdw1 sg3bkdw2
schema_voice vguard3 3 comblocked (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop3 3 comblocked (ComBal Winning Even) (NearbyFriends 0 20)

schema sg3det 			//DETECTED BLOCK +not losing
archetype AI_MORE_MAJOR
sg3det_1 sg3det_2 sg3det_3
schema_voice vguard3 1 comdetblock (ComBal Winning Even)
schema_voice vcop3 1 comdetblock (ComBal Winning Even)

schema sg3detw 			//DETECTED BLOCK  +not losing +w/co
archetype AI_MORE_MAJOR
sg3detw1 sg3detw2
schema_voice vguard3 3 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop3 3 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg3amb 			//AMBUSHED
archetype AI_MAJOR
sg3amb_1 sg3amb_2 sg3amb_3 sg3amb_4 sg3amb_5 sg3amb_6 sg3amb_7
schema_voice vguard3 1 comhitamb (ComBal Winning Even)
schema_voice vcop3 1 comhitamb (ComBal Winning Even)

schema sg3ambw			//AMBUSHED +w/co
archetype AI_COMBAT
sg3ambw1 sg3ambw2 sg3ambw3 sg3ambw4 sg3ambw5
schema_voice vguard3 2 comhitamb (NearbyFriends 0 20)
schema_voice vcop3 2 comhitamb (NearbyFriends 0 20)

schema sg3diea			//DEATH BY AMBUSH
archetype AI_MINOR
volume -500
sg3diea1 sg3diea2 sg3diea3 sg3diea4 
schema_voice vguard3 1 comdiesoft
schema_voice vcop3 1 comdiesoft

schema sg3diec			//DEATH BY COMBAT
archetype AI_COMBAT
sg3diec1 sg3diec2 sg3diec3 sg3diec4 sg3diec5 sg3diec6 sg3diec7
schema_voice vguard3 1 comdieloud
schema_voice vcop3 1 comdieloud

//----------------------------------------------------
//----------------------------------------------------




