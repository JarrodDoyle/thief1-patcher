//GUARD&COP1 - BROADCAST SPEECH -Dan Thron

//----------------------------------------------------

schema sg1a0sn			//ASLEEP
archetype AI_NONE
volume -500
mono_loop 2000 3000
sg1a0sn1 sg1a0sn2 sg1a0sn3 sg1a0sn4 sg1a0sn5 sg1a0sn6
schema_voice vguard1 1 sleeping
schema_voice vcop1 1 sleeping

schema sg1a0		 	//AT ALERT 0  
archetype AI_NONE
delay 1000
volume -500
no_repeat
mono_loop 10000 20000
sg1a0hu1 sg1a0hu2 sg1a0hu3 sg1a0hu4 sg1a0hu5
sg1a0mu1 sg1a0mu2 sg1a0mu3 sg1a0mu4
sg1a0co1 sg1a0co2 sg1a0co3 sg1a0co4 sg1a0co5 sg1a0co6 sg1a0co7 sg1a0co8 sg1a0co9
schema_voice vguard1 1 atlevelzero

schema sg1a0_cop
archetype AI_NONE
delay 1000
volume -500
no_repeat
mono_loop 10000 20000
sg1a0wh1 sg1a0wh2 sg1a0wh3
sg1a0tc1 sg1a0tc2 sg1a0tc3 sg1a0tc4 sg1a0tc5 sg1a0tc6 sg1a0tc7
sg1a0th1 sg1a0th2 sg1a0th3 sg1a0th4 
schema_voice vcop1 1 atlevelzero

//----------------------------------------------------

schema sg1a1			//TO ALERT 1
archetype AI_NONE
sg1a1__1 sg1a1__2 sg1a1__5 sg1a1__6 sg1a1__8
schema_voice vguard1 1 tolevelone 

schema sg1a1_cop
archetype AI_NONE
sg1a1__3 sg1a1__1 sg1a1__2 sg1a1__5 
schema_voice vcop1 1 tolevelone  

schema sg1a1v			//TO ALERT 1 +sighted 
archetype AI_NONE
sg1a1v_1 sg1a1v_2
schema_voice vguard1 1 tolevelone (Sense Sight)

schema sg1a1v_cop
archetype AI_NONE
sg1a1v_1 sg1a1v_2
schema_voice vcop1 1 tolevelone (Sense Sight)

schema sg1a1h			//TO ALERT 1 +heard
archetype AI_NONE
sg1a1h_2 sg1a1h_3
schema_voice vguard1 2 tolevelone (Sense Sound)

schema sg1a1h_cop
archetype AI_NONE
sg1a1h_4 sg1a1h_1 sg1a1h_2 sg1a1h_3
schema_voice vcop1 2 tolevelone (Sense Sound)

schema sg1a1_w			//TO ALERT 1 +w/co
archetype AI_MINOR
sg1a1_w1 sg1a1_w2 sg1a1_w4
schema_voice vguard1 2 tolevelone (NearbyFriends 0 20)

schema sg1a1_w_cop
archetype AI_MINOR
sg1a1_w3 sg1a1_w4 sg1a1_w1 sg1a1_w2
schema_voice vcop1 2 tolevelone (NearbyFriends 0 20)

schema sg1a1vw			//TO ALERT 1 +sighted +w/co
archetype AI_MINOR
sg1a1vw2 sg1a1vw3 sg1a1vw4 sg1a1vw5 
schema_voice vguard1 2 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema sg1a1vw_cop
archetype AI_MINOR
sg1a1vw6 sg1a1vw1 sg1a1vw2 sg1a1vw3
schema_voice vcop1 2 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema sg1a1hw			//TO ALERT 1 +heard +w/co
archetype AI_MINOR
sg1a1hw2 sg1a1hw3 sg1a1hw4 sg1a1hw7
schema_voice vguard1 5 tolevelone (Sense Sound) (NearbyFriends 0 20)

schema sg1a1hw_cop
archetype AI_MINOR
sg1a1hw1 sg1a1hw5 sg1a1hw6 sg1a1hw8
schema_voice vcop1 5 tolevelone (Sense Sound) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg1a1tc			//AT ALERT 1 & 2
archetype AI_NONE
volume -500
delay 5000
mono_loop 8000 20000
sg1a0co1 sg1a0co2 sg1a0co3 sg1a0co4 sg1a0co5 sg1a0co6 sg1a0co7 sg1a0co8 sg1a0co9
schema_voice vguard1 1 atlevelone
schema_voice vguard1 1 atleveltwo

schema sg1a1tc_cop
archetype AI_NONE
volume -500
delay 5000
mono_loop 8000 20000
sg1a0tc1 sg1a0tc2 sg1a0tc3 sg1a0tc4 sg1a0tc5 sg1a0tc6 sg1a0tc7
sg1a0th1 sg1a0th2 sg1a0th3 sg1a0th4 
schema_voice vcop1 1 atlevelone
schema_voice vcop1 1 atleveltwo

//----------------------------------------------------

schema sg1bak			//BACK TO ALERT 0
archetype AI_NONE
sg1bak_1 sg1bak_2 sg1bak_3 sg1bak_4 sg1bak_5 sg1bak_6 sg1bak_7 
schema_voice vguard1 1 backtozero  

schema sg1bak_cop
archetype AI_NONE
sg1bak_9 sg1bak_a sg1bak_b sg1bak_c sg1bak_1 sg1bak_2 sg1bak_3 sg1bak_4
schema_voice vcop1 1 backtozero  

//----------------------------------------------------

schema sg1a2			//TO ALERT 2
archetype AI_MINOR
sg1a2__1 sg1a2__2 sg1a2__3 sg1a2__4 sg1a2__5 
sg1a1__4 
schema_voice vguard1 1 toleveltwo  

schema sg1a2_cop
archetype AI_MINOR
sg1a2__6 sg1a2__7 sg1a2__8 sg1a2__3 sg1a2__4 sg1a2__5 
sg1a1__7 
schema_voice vcop1 1 toleveltwo  
				
schema sg1a2v			//TO ALERT 2 +sighted
archetype AI_MINOR
sg1a2v_1 sg1a1v_3 
schema_voice vguard1 1 toleveltwo (Sense Sight)  

schema sg1a2v_cop
archetype AI_MINOR
sg1a2v_2 sg1a2v_1
schema_voice vcop1 1 toleveltwo (Sense Sight)  

schema sg1a2h			//TO ALERT 2 +heard
archetype AI_MINOR
sg1a2h_1 sg1a2h_2 sg1a2h_3
schema_voice vguard1 2 toleveltwo (Sense Sound)

schema sg1a2h_cop
archetype AI_MINOR
sg1a2h_4 sg1a2h_5 sg1a2h_2 sg1a2h_3
schema_voice vcop1 2 toleveltwo (Sense Sound)

//----------------------------------------------------

schema sg1a3			//TO ALERT 3 
archetype AI_MAJOR
sg1a3__1 sg1a3__2 sg1a3__3 sg1a3__4
schema_voice vguard1 1 tolevelthree
schema_voice vcop1  1 tolevelthree

schema sg1a3s			//SPOTTED THE PLAYER 
archetype AI_MORE_MAJOR
sg1a3s_1 sg1a3s_2 sg1a3s_3 sg1a3s_4 sg1a3s_8
sg1a3na1 sg1a3na2 sg1a3na3 sg1a3na4 sg1a3na9
schema_voice vguard1 1 spotplayer 

schema sg1a3s_cop
archetype AI_MORE_MAJOR
sg1a3s_5 sg1a3s_6 sg1a3s_7 sg1a3s_9
sg1a3na5 sg1a3na6 sg1a3na7 sg1a3na8
schema_voice vcop1 3 spotplayer 

schema sg1a3b			//TO ALERT 3 +carrying a body
archetype AI_MORE_MAJOR
sg1a3b_1 
schema_voice vguard1 50 spotplayer (CarryBody True)

schema sg1a3b_cop
archetype AI_MORE_MAJOR
sg1a3b_2 sg1a3b_1 
schema_voice vcop1 50 spotplayer (CarryBody True)

schema sg1telr			//TO ALERT 3 +w/co
archetype AI_COMBAT
sg1telr1 sg1telr2 sg1telr3 sg1telr4 sg1telr5
schema_voice vguard1 3 spotplayer (NearbyFriends 0 20)
schema_voice vguard1 3 reacttellrev

schema sg1telr_cop
archetype AI_COMBAT
sg1telr6 sg1telr7 sg1telr8 sg1telr1 sg1telr2 sg1telr3
schema_voice vcop1 3 spotplayer (NearbyFriends 0 20)
schema_voice vcop1 3 reacttellrev

//----------------------------------------------------

schema sg1at2			//AT ALERT 2 & 3 +Investigating
archetype AI_MINOR
delay 4000
no_repeat
mono_loop 10000 20000
sg1a2se1 sg1a2se2 sg1a2se3 sg1a2se4 sg1a2se5 sg1a2se6 sg1a2se7 sg1a2se8
sg1a3se1 sg1a3se2 sg1a3se3 sg1a3se4 sg1a3se5 sg1a3se6 sg1a3se7 sg1a3se8
schema_voice vguard1 99 atleveltwo (Investigate true)
schema_voice vguard1 99 atlevelthree (Investigate true)
schema_voice vcop1 99 atleveltwo (Investigate true)
schema_voice vcop1 99 atlevelthree (Investigate true)

//----------------------------------------------------

schema sg1telc			//RE-SPOTTED PLAYER +w/co
archetype AI_COMBAT
sg1telc1 sg1telc2 sg1telc3 sg1telc4 sg1telc5 sg1telc6
schema_voice vguard1 99 spotplayer (NearbyFriends 0 20) (Reacquire True) 
schema_voice vguard1 99 reacttellconf

schema sg1telc_cop
archetype AI_COMBAT
sg1telc7 sg1telc8 sg1telc9 sg1telc1 sg1telc2 sg1telc3 sg1telc4
schema_voice vcop1 99 spotplayer (NearbyFriends 0 20) (Reacquire True) 
schema_voice vcop1 99 reacttellconf

//----------------------------------------------------

schema sg1los			//LOST CONTACT W/PLAYER
archetype AI_NONE
sg1los_1 sg1los_2 sg1los_3 sg1los_4 sg1los_5
schema_voice vguard1 1 lostcontact  

schema sg1los_cop
archetype AI_NONE
sg1los_6 sg1los_7 sg1los_8 sg1los_1 sg1los_2 sg1los_3
schema_voice vcop1 1 lostcontact  

//----------------------------------------------------

schema sg1chga			//REACT CHARGE
archetype AI_MORE_MAJOR
sg1chga1 sg1chga2 sg1chga4 sg1chga5
schema_voice vguard1 1 reactcharge

schema sg1chga_cop
archetype AI_MORE_MAJOR
sg1chga3 sg1chga1 sg1chga2 sg1chga4
schema_voice vcop1 1 reactcharge

schema sg1chgw			//REACT CHARGE +w/co
archetype AI_COMBAT
sg1chgw1 sg1chgw2 sg1chgw3 sg1chgw6 sg1chgw7
schema_voice vguard1 3 reactcharge (NearbyFriends 0 20)

schema sg1chgw_cop
archetype AI_COMBAT
sg1chgw4 sg1chgw5 sg1chgw1 sg1chgw2 sg1chgw3 
schema_voice vcop1 3 reactcharge (NearbyFriends 0 20)

schema sg1runa			//REACT RUN AWAY
archetype AI_MAJOR
sg1runa1 sg1runa3 sg1runa4
schema_voice vguard1 1 reactrun 

schema sg1runa_cop
archetype AI_MAJOR
sg1runa2 sg1runa5 sg1runa6 sg1runa4
schema_voice vcop1 1 reactrun 

schema sg1alma			//REACT I SOUND ALARMS
archetype AI_MORE_MAJOR
sg1alma1 sg1alma2 sg1alma3 sg1alma6
schema_voice vguard1 1 reactalarm

schema sg1alma_cop
archetype AI_MORE_MAJOR
sg1alma4 sg1alma5 sg1alma1 sg1alma2 sg1alma3
schema_voice vcop1 1 reactalarm

schema sg1almw			//REACT YOU SOUND ALARMS +w/co
archetype AI_COMBAT
sg1almw1 sg1almw2 sg1almw4
schema_voice vguard1 3 reactalarm (NearbyFriends 0 20)

schema sg1almw_cop
archetype AI_COMBAT
sg1almw3 sg1almw4 sg1almw1
schema_voice vcop1 3 reactalarm (NearbyFriends 0 20)

//----------------------------------------------------

schema sg1bow			//REACT SHOOT
archetype AI_MORE_MAJOR
no_repeat
sg1atb_1 freq 2
sg1atb_2 freq 2
sg1atb_3 freq 2
sg1atb_4 freq 1
sg1atb_5 freq 1
sg1atb_6 freq 1
schema_voice vguard1 1 reactshoot
schema_voice vcop1 1 reactshoot

schema sg1frust			//FRUSTRATION
archetype AI_MAJOR
sg1frus1 sg1frus2 sg1frus3
schema_voice vguard1 1 outofreach
schema_voice vcop1 1 outofreach

schema sg1frust_cop
archetype AI_MAJOR
sg1frus4 sg1frus1 sg1frus2 sg1frus3
schema_voice vcop1 2 outofreach

schema sg1torch			//NOTICED A DOUSED TORCH
archetype AI_NONE
delay 1000
sg1torc1 sg1torc2
schema_voice vguard1 1 notice (Item Torch)
schema_voice vcop1 1 notice (Item Torch)

schema sg1gas			//NOTICED A DOUSED GASLIGHT
archetype AI_NONE
delay 1000
sg1torc1
schema_voice vguard1 1 notice (Item Gaslight)
schema_voice vcop1 1 notice (Item Gaslight)

schema sg1getbowman
archetype AI_MAJOR
delay 1000
sg1runa1 sg1runa3 sg1gbow1
schema_voice vguard1 1 getbowman
schema_voice vcop1 1 getbowman 

//----------------------------------------------------

schema sg1bod			//FOUND BODY
archetype AI_MORE_MAJOR
sg1bod_1 sg1bod_2 sg1bod_3
schema_voice vguard1 1 foundbody  

schema sg1bod_cop
archetype AI_MORE_MAJOR
sg1bod_4 sg1bod_5 sg1bod_1
schema_voice vcop1 2 foundbody  

schema sg1rob			//FOUND DEAD ROBOT
archetype AI_MORE_MAJOR
sg1rob_1 sg1rob_2
schema_voice vguard1 1 foundrobot  
schema_voice vcop1 1 foundrobot 

schema sg1mis			//FOUND SOMETHING MISSING 
archetype AI_MAJOR
sg1mis_1 sg1mis_2 sg1mis_3 sg1mis_4
schema_voice vguard1 1 foundmissing 
schema_voice vguard1 1 notice (Item MissingLoot)

schema sg1mis_cop
archetype AI_MAJOR
sg1mis_5 sg1mis_6 sg1mis_1 sg1mis_2
schema_voice vcop1 1 foundmissing 
schema_voice vcop1 1 notice (Item MissingLoot)

schema sg1sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
sg1sma_1 sg1sma_2 sg1sma_3 sg1sma_4
schema_voice vguard1 1 foundsmall  
schema_voice vguard1 1 notice (Item Door Generic)

schema sg1sma_cop
archetype AI_MINOR
sg1sma_5 sg1sma_6 sg1sma_1 sg1sma_2 
schema_voice vcop1 1 foundsmall  
schema_voice vcop1 1 notice (Item Door Generic)

schema sg1lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
sg1lar_1 sg1lar_2 sg1lar_3
schema_voice vguard1 1 foundlarge

schema sg1lar_cop
archetype AI_MAJOR
sg1lar_4 sg1lar_5 sg1lar_2 sg1lar_3
schema_voice vcop1 1 foundlarge

schema sg1sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
sg1sec_1 sg1sec_2 sg1sec_3 sg1sec_4
schema_voice vguard1 1 foundbreach 

schema sg1sec_cop
archetype AI_MORE_MAJOR
sg1sec_5 sg1sec_6 sg1sec_3 sg1sec_4
schema_voice vcop1 1 foundbreach 

//----------------------------------------------------

schema sg1rint			//RECENTLY SAW THE PLAYER
archetype AI_INFORM
sg1rint1 sg1rint2 sg1rint3
schema_voice vguard1 1 recentintruder 

schema sg1rint_cop
archetype AI_INFORM
sg1rint4 sg1rint5 sg1rint1 sg1rint2
schema_voice vcop1 1 recentintruder 

schema sg1rbod			//RECENTLY FOUND BODY
archetype AI_INFORM
sg1rbod1 sg1rbod2 sg1rbod3 sg1rbod4 
schema_voice vguard1 1 recentbody 

schema sg1rbod_cop
archetype AI_INFORM
sg1rbod5 sg1rbod6 sg1rbod3 sg1rbod4 
schema_voice vcop1 1 recentbody 

schema sg1rrob			//RECENTLY FOUND DEAD ROBOT
archetype AI_INFORM
sg1rrob1
schema_voice vguard1 1 recentrobot 
schema_voice vcop1 1 recentrobot 

schema sg1rmis			//RECENTLY FOUND MISSING
archetype AI_INFORM
sg1rmis1 sg1rmis2
schema_voice vguard1 1 recentmissing 

schema sg1rmis_cop
archetype AI_INFORM
sg1rmis3 sg1rmis4
schema_voice vcop1 1 recentmissing 

schema sg1roth			//RECENTLY FOUND ANAMOLY
archetype AI_INFORM
sg1roth1 sg1roth2 sg1roth3 sg1roth4
schema_voice vguard1 1 recentother 

schema sg1roth_cop
archetype AI_INFORM
sg1roth5 sg1roth6 sg1roth1 sg1roth2
schema_voice vcop1 1 recentother 

//----------------------------------------------------
//COMBAT

schema sg1atn			//ATTACKING +not losing
archetype AI_COMBAT
sg1atn_1 freq 1
sg1atn_2 freq 1
sg1atn_3 freq 2
sg1atn_4 freq 2
sg1atn_5 freq 2
sg1atn_6 freq 1
sg1atn_7 freq 2
sg1atn_8 freq 2
schema_voice vguard1 1 comattack (ComBal Even)
schema_voice vcop1 1 comattack (ComBal Even)

schema sg1atnw			//ATTACKING	+winning
archetype AI_COMBAT
sg1atw_1 sg1atw_2 sg1atn_3 sg1atn_7 sg1atn_8
schema_voice vguard1 3 comattack (ComBal Winning)
schema_voice vcop1 3 comattack (ComBal Winning)

schema sg1atww			//ATTACKING +winning +w/co
archetype AI_COMBAT
sg1atww1 sg1atn_3 sg1atn_4 sg1atn_5
schema_voice vguard1 99 comattack (ComBal Winning) (NearbyFriends 0 20)
schema_voice vcop1 99 comattack (ComBal Winning) (NearbyFriends 0 20)

schema sg1atl			//ATTACKING	+losing
archetype AI_COMBAT
sg1atl_1 sg1atl_2 sg1atl_3 
schema_voice vguard1 99 comattack (ComBal Losing)
schema_voice vcop1 99 comattack (ComBal Losing)

//----------------------------------------------------

schema sg1hit			//HIT THE PLAYER +not losing
archetype AI_COMBAT
sg1hit_1 sg1hit_2 sg1hit_3 sg1hit_4
schema_voice vguard1 1 comsucchit (ComBal Winning Even)
schema_voice vcop1 1 comsucchit (ComBal Winning Even)

schema sg1hitw			//HIT THE PLAYER +not losing +w/co
archetype AI_COMBAT
sg1hitw1 sg1hitw2
schema_voice vguard1 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop1 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

schema sg1blk			//BLOCKED THE PLAYER +not losing
archetype AI_COMBAT
sg1blk_1 sg1blk_2 sg1blk_3 sg1blk_4
schema_voice vguard1 1 comsuccblock (ComBal Winning Even)
schema_voice vcop1 1 comsuccblock (ComBal Winning Even)

schema sg1blkw			//BLOCKED THE PLAYER +not losing +w/co
archetype AI_COMBAT
sg1blkw1 sg1blkw2
schema_voice vguard1 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop1 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg1hhi			//HIT BY PLAYER W/HI HIT PTS 
archetype AI_MAJOR
sg1hhi_1 sg1hhi_2 sg1hhi_3 sg1hhi_4 sg1hhi_5 sg1hhi_6
schema_voice vguard1 1 comhithigh
schema_voice vguard1 99 comhitnodam (ComBal Losing)
schema_voice vcop1 1 comhithigh
schema_voice vcop1 99 comhitnodam (ComBal Losing)

schema sg1hlo			//HIT BY PLAYER W/LO PTS 
archetype AI_MORE_MAJOR
sg1hlo_1 sg1hlo_2 sg1hlo_3 sg1hlo_4 sg1hlo_5 sg1hlo_6
schema_voice vguard1 1 comhitlow
schema_voice vcop1 1 comhitlow

schema sg1hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
sg1hlow1 sg1hlow2 sg1hlo_1 sg1hlo_2 sg1hlo_3 
schema_voice vguard1 99 comhitlow (NearbyFriends 0 20)
schema_voice vcop1 99 comhitlow (NearbyFriends 0 20)

schema sg1hnd			//HIT BY PLAYER NO DAMAGE +Winning
archetype AI_NONE
sg1hnd_1 sg1hnd_2 sg1hnd_3 
schema_voice vguard1 99 comhitnodam (ComBal Winning)
schema_voice vcop1 99 comhitnodam (ComBal Winning)
schema_voice vguard1 1 comhitnodam
schema_voice vcop1 1 comhitnodam

schema sg1hnd_e			//HIT BY THE PLAYER NO DAMAGE +Even
archetype AI_NONE
sg1hnde1 sg1hnde2 sg1hnde3
schema_voice vguard1 99 comhitnodam (ComBal Even)
schema_voice vcop1 99 comhitnodam (ComBal Even)
schema_voice vguard1 3 comhitnodam
schema_voice vcop1 3 comhitnodam

//----------------------------------------------------

schema sg1bkd 			//BLOCKED BY PLAYER +not losing
archetype AI_COMBAT
sg1bkd_1 sg1bkd_2 sg1bkd_3 sg1bkd_4
schema_voice vguard1 1 comblocked (ComBal Winning Even)
schema_voice vcop1 1 comblocked (ComBal Winning Even)

schema sg1bkdw 			//BLOCKED BY PLAYER +not losing +w/co
archetype AI_COMBAT
sg1bkdw1
schema_voice vguard1 3 comblocked (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop1 3 comblocked (ComBal Winning Even) (NearbyFriends 0 20)

schema sg1det 			//DETECTED BLOCK +not losing
archetype AI_MORE_MAJOR
sg1det_1 sg1det_2 sg1det_3
schema_voice vguard1 1 comdetblock (ComBal Winning Even)
schema_voice vcop1 1 comdetblock (ComBal Winning Even)

schema sg1detw 			//DETECTED BLOCK  +not losing +w/co
archetype AI_MORE_MAJOR
sg1detw1 sg1detw2
schema_voice vguard1 3 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop1 3 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg1amb 			//AMBUSHED
archetype AI_MAJOR
sg1amb_1 sg1amb_2 sg1amb_3 sg1amb_4 sg1amb_5
schema_voice vguard1 1 comhitamb (ComBal Winning Even)
schema_voice vcop1 1 comhitamb (ComBal Winning Even)

schema sg1ambw			//AMBUSHED +w/co
archetype AI_COMBAT
sg1ambw1 sg1ambw2 sg1ambw3 sg1ambw4
schema_voice vguard1 2 comhitamb (NearbyFriends 0 20)
schema_voice vcop1 2 comhitamb (NearbyFriends 0 20)

schema sg1diea			//DEATH BY AMBUSH
archetype AI_MINOR
volume -500
sg1diea1 sg1diea2 sg1diea3 sg1diea4 sg1diea5 sg1diea6
schema_voice vguard1 1 comdiesoft
schema_voice vcop1 1 comdiesoft

schema sg1diec			//DEATH BY COMBAT
archetype AI_COMBAT
sg1diec1 sg1diec2 sg1diec3 sg1diec4 sg1diec5
schema_voice vguard1 1 comdieloud
schema_voice vcop1 1 comdieloud

//----------------------------------------------------
//----------------------------------------------------



