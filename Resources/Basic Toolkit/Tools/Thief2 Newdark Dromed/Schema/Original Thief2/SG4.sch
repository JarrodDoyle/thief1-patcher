//GUARD&COP4 - BROADCAST SPEECH -Dan Krikorian

//----------------------------------------------------

schema sg4a0sn			//ASLEEP
archetype AI_NONE
volume -500
mono_loop 2000 3000
sg4a0sn1 sg4a0sn2 sg4a0sn3 sg4a0sn4 sg4a0sn5 
schema_voice vguard4 1 sleeping
schema_voice vcop4 1 sleeping

schema sg4a0		 	//AT ALERT 0  
archetype AI_NONE
delay 4000
volume -500
no_repeat
mono_loop 10000 20000
sg4a0wh1 sg4a0wh2 sg4a0wh3 sg4a0wh4 sg4a0wh5
sg4a0mu1 sg4a0mu2 sg4a0mu3 sg4a0mu4
sg4a0th1 sg4a0th2 sg4a0th3 sg4a0th4 sg4a0th5
sg4a0co1 sg4a0co2 sg4a0co3 sg4a0co4 sg4a0co5 
schema_voice vguard4 3 atlevelzero

schema sg4a0_cop
archetype AI_NONE
delay 4000
volume -500
no_repeat
mono_loop 10000 20000
sg4a0hu1 sg4a0hu2 sg4a0hu3 sg4a0hu4 sg4a0hu5
sg4a0mu5 sg4a0mu6 sg4a0mu7 
sg4a0tc1 sg4a0tc2 sg4a0tc3 sg4a0tc4 sg4a0tc5
sg4a0co3 sg4a0co4 sg4a0co5 sg4a0co6 sg4a0co7
schema_voice vcop4 1 atlevelzero

//----------------------------------------------------

schema sg4a1			//TO ALERT 1
archetype AI_NONE
sg4a1__1 sg4a1__2 sg4a1__3 sg4a1__4 sg4a1__5 sg4a1__6
schema_voice vguard4 1 tolevelone 

schema sg4a1_cop
archetype AI_NONE
sg4a1__8 sg4a1__1 sg4a1__2 sg4a1__3 sg4a1__4
schema_voice vcop4 1 tolevelone  

schema sg4a1v			//TO ALERT 1 +sighted 
archetype AI_NONE
sg4a1v_1 sg4a1v_2
schema_voice vguard4 1 tolevelone (Sense Sight)

schema sg4a1v_cop
archetype AI_NONE
sg4a1v_3 sg4a1v_1 sg4a1v_2
schema_voice vcop4 1 tolevelone (Sense Sight)

schema sg4a1h			//TO ALERT 1 +heard
archetype AI_NONE
sg4a1h_1 sg4a1h_2 sg4a1h_3
schema_voice vguard4 2 tolevelone (Sense Sound)

schema sg4a1h_cop
archetype AI_NONE
sg4a1h_2 sg4a1h_3 sg4a1h_1 
schema_voice vcop4 2 tolevelone (Sense Sound)

schema sg4a1_w			//TO ALERT 1 +w/co
archetype AI_MINOR
sg4a1_w1 sg4a1_w2
schema_voice vguard4 2 tolevelone (NearbyFriends 0 20)

schema sg4a1_w_cop
archetype AI_MINOR
sg4a1_w3 sg4a1_w1
schema_voice vcop4 2 tolevelone (NearbyFriends 0 20)

schema sg4a1vw			//TO ALERT 1 +sighted +w/co
archetype AI_MINOR
sg4a1vw1 sg4a1vw2 sg4a1vw3 sg4a1vw4
schema_voice vguard4 2 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema sg4a1vw_cop
archetype AI_MINOR
sg4a1vw5 sg4a1vw6 sg4a1vw3 sg4a1vw4
schema_voice vcop4 2 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema sg4a1hw			//TO ALERT 1 +heard +w/co
archetype AI_MINOR
sg4a1hw1 sg4a1hw2 sg4a1hw3 sg4a1hw4
schema_voice vguard4 5 tolevelone (Sense Sound) (NearbyFriends 0 20)

schema sg4a1hw_cop
archetype AI_MINOR
sg4a1hw5 sg4a1hw6 sg4a1hw3 sg4a1hw4
schema_voice vcop4 5 tolevelone (Sense Sound) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg4a1tc			//AT ALERT 1 & 2
archetype AI_NONE
volume -500
delay 4000
mono_loop 8000 20000
sg4a0tc1 sg4a0tc2 sg4a0tc3 sg4a0tc4 sg4a0tc5
sg4a0co1 sg4a0co2 sg4a0co3 sg4a0co4
schema_voice vguard4 1 atlevelone
schema_voice vguard4 1 atleveltwo

schema sg4a1tc_cop
archetype AI_NONE
volume -500
delay 4000
mono_loop 8000 20000
sg4a0th1 sg4a0th2 sg4a0th3 sg4a0th4 sg4a0th5
sg4a0co5 sg4a0co6 sg4a0co7
schema_voice vcop4 1 atlevelone
schema_voice vcop4 1 atleveltwo

//----------------------------------------------------

schema sg4bak			//BACK TO ALERT 0
archetype AI_NONE
sg4bak_1 sg4bak_2 sg4bak_3 sg4bak_4 sg4bak_5 sg4bak_6 sg4bak_7 sg4bak_8 
schema_voice vguard4 1 backtozero  

schema sg4bak_cop
archetype AI_NONE
sg4bak_9 sg4bak_a sg4bak_b sg4bak_c sg4bak_5 sg4bak_6 sg4bak_7 sg4bak_8 
schema_voice vcop4 1 backtozero  

//----------------------------------------------------

schema sg4a2			//TO ALERT 2
archetype AI_MINOR
sg4a2__1 sg4a2__2 sg4a2__3 sg4a2__4 sg4a2__5
schema_voice vguard4 1 toleveltwo  

schema sg4a2_cop
archetype AI_MINOR
sg4a1__7 sg4a2__6 sg4a2__7 sg4a2__8 sg4a2__3 sg4a2__4
schema_voice vcop4 1 toleveltwo  
				
schema sg4a2v			//TO ALERT 2 +sighted
archetype AI_MINOR
sg4a2v_1
schema_voice vguard4 1 toleveltwo (Sense Sight)  

schema sg4a2v_cop
archetype AI_MINOR
sg4a2v_2
schema_voice vcop4 1 toleveltwo (Sense Sight)  

schema sg4a2h			//TO ALERT 2 +heard
archetype AI_MINOR
sg4a2h_2 sg4a2h_3
schema_voice vguard4 2 toleveltwo (Sense Sound)

schema sg4a2h_cop
archetype AI_MINOR
sg4a2h_1 sg4a2h_4 sg4a2h_3 sg4a1h_4 
schema_voice vcop4 2 toleveltwo (Sense Sound)

//----------------------------------------------------

schema sg4a3			//TO ALERT 3 
archetype AI_MAJOR
sg4a3__1 sg4a3__2 sg4a3s_2 sg4lar_2
schema_voice vguard4 1 tolevelthree
schema_voice vcop4  1 tolevelthree

schema sg4a3s			//SPOTTED THE PLAYER 
archetype AI_MORE_MAJOR
sg4a3s_1 sg4a3s_2 sg4a3s_3 sg4a3s_4 sg4a3s_5 
sg4a3na1 sg4a3na2 sg4a3na3 sg4a3na4 sg4a3na5
schema_voice vguard4 1 spotplayer 

schema sg4a3s_cop
archetype AI_MORE_MAJOR
sg4a3s_6 sg4a3s_7 sg4a3s_1 sg4a3s_2 sg4a3s_3
sg4a3na6 sg4a3na7 sg4a3na8 sg4a3na4 sg4a3na5
schema_voice vcop4 1 spotplayer 

schema sg4a3b			//TO ALERT 3 +carrying a body
archetype AI_MORE_MAJOR
sg4a3b_1 
schema_voice vguard4 99 spotplayer (CarryBody True)

schema sg4a3b_cop
archetype AI_MORE_MAJOR
sg4a3b_2
schema_voice vcop4 99 spotplayer (CarryBody True)

schema sg4telr			//TO ALERT 3 +w/co
archetype AI_COMBAT
sg4telr1 sg4telr2 sg4telr3 sg4telr4 sg4telr5
schema_voice vguard4 3 spotplayer (NearbyFriends 0 20)
schema_voice vguard4 1 reacttellrev

schema sg4telr_cop
archetype AI_COMBAT
sg4telr6 sg4telr7 sg4telr8 sg4telr3 sg4telr4
schema_voice vcop4 3 spotplayer (NearbyFriends 0 20)
schema_voice vcop4 1 reacttellrev

//----------------------------------------------------

schema sg4at2			//AT ALERT 2 & 3 +Investigating
archetype AI_MINOR
delay 4000
no_repeat
mono_loop 10000 20000
sg4a3se1 sg4a3se2 sg4a3se3 sg4a3se4 sg4a3se5 sg4a3se6 sg4a3se7 sg4a3se8
schema_voice vguard4 99 atleveltwo (Investigate true)
schema_voice vguard4 99 atlevelthree (Investigate true)
schema_voice vcop4 99 atleveltwo (Investigate true)
schema_voice vcop4 99 atlevelthree (Investigate true)

//----------------------------------------------------

schema sg4telc			//RE-SPOTTED PLAYER +w/co
archetype AI_COMBAT
sg4telc1 sg4telc2 sg4telc3 sg4telc4 sg4telc5 sg4telc6
schema_voice vguard4 99 spotplayer (NearbyFriends 0 20) (Reacquire True) 
schema_voice vguard4 1 reacttellconf

schema sg4telc_cop
archetype AI_COMBAT
sg4telc7 sg4telc8 sg4telc9 sg4telc5 sg4telc6
schema_voice vcop4 99 spotplayer (NearbyFriends 0 20) (Reacquire True) 
schema_voice vcop4 1 reacttellconf

//----------------------------------------------------

schema sg4los			//LOST CONTACT W/PLAYER
archetype AI_NONE
sg4los_1 sg4los_2 sg4los_3 sg4los_4 sg4los_5
schema_voice vguard4 1 lostcontact  

schema sg4los_cop
archetype AI_NONE
sg4los_6 sg4los_7 sg4los_8 sg4los_4 sg4los_5
schema_voice vcop4 1 lostcontact  

//----------------------------------------------------

schema sg4chga			//REACT CHARGE
archetype AI_MORE_MAJOR
sg4chga1 sg4chga2 
schema_voice vguard4 1 reactcharge

schema sg4chga_cop
archetype AI_MORE_MAJOR
sg4chga3 sg4chga1 sg4chga2 
schema_voice vcop4 1 reactcharge

schema sg4chgw			//REACT CHARGE +w/co
archetype AI_COMBAT
sg4chgw1 sg4chgw2 sg4chgw3
schema_voice vguard4 3 reactcharge (NearbyFriends 0 20)

schema sg4chgw_cop
archetype AI_COMBAT 
sg4chgw4 sg4chgw5 sg4chgw1 sg4chgw2 sg4chgw3
schema_voice vcop4 3 reactcharge (NearbyFriends 0 20)

schema sg4runa			//REACT RUN AWAY
archetype AI_MAJOR
sg4runa1 sg4runa3 sg4runa4
schema_voice vguard4 1 reactrun 

schema sg4runa_cop
archetype AI_MAJOR
sg4runa2 sg4runa5 sg4runa1 sg4runa3 sg4runa4
schema_voice vcop4 1 reactrun 

schema sg4alma			//REACT I SOUND ALARMS
archetype AI_MORE_MAJOR
sg4alma1 sg4alma2 sg4alma3
schema_voice vguard4 1 reactalarm

schema sg4alma_cop
archetype AI_MORE_MAJOR
sg4alma4 sg4alma5 sg4alma1 sg4alma2
schema_voice vcop4 1 reactalarm

schema sg4almw			//REACT YOU SOUND ALARMS +w/co
archetype AI_COMBAT
sg4almw1 sg4almw2
schema_voice vguard4 3 reactalarm (NearbyFriends 0 20)

schema sg4almw_cop
archetype AI_COMBAT
sg4almw3 sg4almw1 
schema_voice vcop4 3 reactalarm (NearbyFriends 0 20)

//----------------------------------------------------

schema sg4bow			//REACT SHOOT
archetype AI_MORE_MAJOR
no_repeat
sg4atb_1 sg4atb_2 sg4atb_3
schema_voice vguard4 1 reactshoot
schema_voice vcop4 1 reactshoot

schema sg4frust			//FRUSTRATION
archetype AI_MAJOR
sg4frus1 sg4frus2 sg4frus3
schema_voice vguard4 1 outofreach

schema sg4frust_cop
archetype AI_MAJOR
sg4frus4 sg4frus1 sg4frus2 sg4frus3
schema_voice vcop4 1 outofreach

schema sg4torch			//NOTICED A DOUSED TORCH
archetype AI_NONE
delay 1000
sg4torc1 sg4torc2
schema_voice vguard4 1 notice (Item Torch)
schema_voice vcop4 1 notice (Item Torch)

schema sg4gas		//NOTICED A DOUSED GASLIGHT
archetype AI_NONE
delay 1000
sg4torc2 sg4torc3
schema_voice vguard4 1 notice (Item Gaslight)
schema_voice vcop4 1 notice (Item Gaslight)

schema sg4getbowman		//RUN & GET A BOWMAN
archetype AI_MORE_MAJOR
sg4runa2 sg4runa5
schema_voice vguard4 1 getbowman
schema_voice vcop4 1 getbowman

//----------------------------------------------------

schema sg4bod			//FOUND BODY
archetype AI_MORE_MAJOR
sg4bod_1 sg4bod_2 sg4bod_3
schema_voice vguard4 1 foundbody  

schema sg4bod_cop
archetype AI_MORE_MAJOR
sg4bod_4 sg4bod_5 sg4bod_2 sg4bod_3
schema_voice vcop4 1 foundbody  

schema sg4rob			//FOUND DEAD ROBOT
archetype AI_MORE_MAJOR
sg4rob_1 sg4rob_2
schema_voice vguard4 1 foundrobot  
schema_voice vcop4 1 foundrobot 

schema sg4mis			//FOUND SOMETHING MISSING 
archetype AI_MAJOR
sg4mis_1 sg4mis_2 sg4mis_3 sg4mis_4
schema_voice vguard4 1 foundmissing 
schema_voice vguard4 1 notice (Item MissingLoot)


schema sg4mis_cop
archetype AI_MAJOR
sg4mis_5 sg4mis_6 sg4mis_1 sg4mis_2 
schema_voice vcop4 1 foundmissing 
schema_voice vcop4 1 notice (Item MissingLoot)

schema sg4sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
sg4sma_1 sg4sma_2 sg4sma_3 sg4sma_4
schema_voice vguard4 1 foundsmall  
schema_voice vguard4 1 notice (Item Door Generic)

schema sg4sma_cop
archetype AI_MINOR
sg4sma_5 sg4sma_6 sg4sma_3 sg4sma_4
schema_voice vcop4 2 foundsmall  
schema_voice vcop4 2 notice (Item Door Generic)

schema sg4lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
sg4lar_1 sg4lar_2 sg4lar_3
schema_voice vguard4 1 foundlarge

schema sg4lar_cop
archetype AI_MAJOR
sg4lar_4 sg4lar_5 sg4lar_1 sg4lar_2 
schema_voice vcop4 1 foundlarge

schema sg4sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
sg4sec_1 sg4sec_2 sg4sec_3 sg4sec_4
schema_voice vguard4 1 foundbreach 

schema sg4sec_cop
archetype AI_MORE_MAJOR
sg4sec_5 sg4sec_6 sg4sec_3 sg4sec_4
schema_voice vcop4 1 foundbreach 

//----------------------------------------------------

schema sg4rint			//RECENTLY SAW THE PLAYER
archetype AI_INFORM
sg4rint1 sg4rint2 sg4rint3
schema_voice vguard4 1 recentintruder 

schema sg4rint_cop
archetype AI_INFORM
sg4rint4 sg4rint1 sg4rint2 sg4rint3
schema_voice vcop4 1 recentintruder 

schema sg4rbod			//RECENTLY FOUND BODY
archetype AI_INFORM
sg4rbod1 sg4rbod2 sg4rbod3
schema_voice vguard4 1 recentbody

schema sg4rbod_cop
archetype AI_INFORM
sg4rbod4 sg4rbod5 sg4rbod1 sg4rbod2 
schema_voice vcop4 1 recentbody 

schema sg4rrob			//RECENTLY FOUND DEAD ROBOT
archetype AI_INFORM
sg4rrob1
schema_voice vguard4 1 recentrobot 
schema_voice vcop4 1 recentrobot 

schema sg4rmis			//RECENTLY FOUND MISSING
archetype AI_INFORM
sg4rmis1 sg4rmis2 sg4rmis3 sg4rmis4
schema_voice vguard4 1 recentmissing 

schema sg4rmis_cop
archetype AI_INFORM
sg4rmis5 sg4rmis6 sg4rmis3 sg4rmis4
schema_voice vcop4 1 recentmissing 

schema sg4roth			//RECENTLY FOUND ANAMOLY
archetype AI_INFORM
sg4roth1 sg4roth2 sg4roth3 sg4roth4
schema_voice vguard4 1 recentother 

schema sg4roth_cop
archetype AI_INFORM
sg4roth5 sg4roth6 sg4roth1 sg4roth2 
schema_voice vcop4 1 recentother 

//----------------------------------------------------
//COMBAT

schema sg4atn			//ATTACKING +not losing
archetype AI_COMBAT
sg4atn_1 freq 1
sg4atn_2 freq 1
sg4atn_3 freq 3
sg4atn_4 freq 3
sg4atn_5 freq 3
schema_voice vguard4 1 comattack (ComBal Even)
schema_voice vcop4 1 comattack (ComBal Even)

schema sg4atnw			//ATTACKING	+winning
archetype AI_COMBAT
sg4atw_1 sg4atw_2 sg4atn_3 sg4atn_4 sg4atn_5
schema_voice vguard4 3 comattack (ComBal Winning)
schema_voice vcop4 3 comattack (ComBal Winning)

schema sg4atww			//ATTACKING +winning +w/co
archetype AI_COMBAT
sg4atww1 sg4atn_3 sg4atn_4 sg4atn_5
schema_voice vguard4 3 comattack (ComBal Winning) (NearbyFriends 0 20)
schema_voice vcop4 3 comattack (ComBal Winning) (NearbyFriends 0 20)

schema sg4atl			//ATTACKING	+losing
archetype AI_COMBAT
sg4atl_1 sg4atl_2 sg4atl_3 
schema_voice vguard4 2 comattack (ComBal Losing)
schema_voice vcop4 2 comattack (ComBal Losing)

//----------------------------------------------------

schema sg4hit			//HIT THE PLAYER +not losing
archetype AI_COMBAT
sg4hit_1 sg4hit_2 sg4hit_3 sg4hit_4
schema_voice vguard4 1 comsucchit (ComBal Winning Even)
schema_voice vcop4 1 comsucchit (ComBal Winning Even)

schema sg4hitw			//HIT THE PLAYER +not losing +w/co
archetype AI_COMBAT
sg4hitw1 sg4hitw2
schema_voice vguard4 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop4 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

schema sg4blk			//BLOCKED THE PLAYER +not losing
archetype AI_COMBAT
sg4blk_1 sg4blk_2 sg4blk_3
schema_voice vguard4 1 comsuccblock (ComBal Winning Even)
schema_voice vcop4 1 comsuccblock (ComBal Winning Even)

schema sg4blkw			//BLOCKED THE PLAYER +not losing +w/co
archetype AI_COMBAT
sg4blkw1
schema_voice vguard4 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop4 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg4hhi			//HIT BY PLAYER W/HI HIT PTS 
archetype AI_MAJOR
sg4hhi_1 sg4hhi_2 sg4hhi_3 sg4hhi_4 sg4hhi_5
schema_voice vguard4 1 comhithigh
schema_voice vguard4 99 comhitnodam (ComBal Losing)
schema_voice vcop4 1 comhithigh
schema_voice vcop4 99 comhitnodam (ComBal Losing)

schema sg4hlo			//HIT BY PLAYER W/LO PTS 
archetype AI_MORE_MAJOR
sg4hlo_1 sg4hlo_2 sg4hlo_3 
schema_voice vguard4 1 comhitlow
schema_voice vcop4 1 comhitlow

schema sg4hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
sg4hlow1 sg4hlo_1 sg4hlo_2 sg4hlo_3 
schema_voice vguard4 99 comhitlow (NearbyFriends 0 20)
schema_voice vcop4 99 comhitlow (NearbyFriends 0 20)

schema sg4hnd			//HIT BY PLAYER NO DAMAGE +Winning
archetype AI_NONE
sg4hnd_1 sg4hnd_2 sg4hnd_3 
schema_voice vguard4 99 comhitnodam (ComBal Winning)
schema_voice vcop4 99 comhitnodam (ComBal Winning)
schema_voice vguard4 3 comhitnodam
schema_voice vcop4 3 comhitnodam

schema sg4hnd_e			//HIT BY THE PLAYER NO DAMAGE +Even
archetype AI_NONE
sg4hnde1 sg4hnde2 sg4hnde3
schema_voice vguard4 99 comhitnodam (ComBal Even)
schema_voice vcop4 99 comhitnodam (ComBal Even)
schema_voice vguard4 3 comhitnodam
schema_voice vcop4 3 comhitnodam

//----------------------------------------------------

schema sg4bkd 			//BLOCKED BY PLAYER +not losing
archetype AI_COMBAT
sg4bkd_1 sg4bkd_2 sg4bkd_3
schema_voice vguard4 1 comblocked (ComBal Winning Even)
schema_voice vcop4 1 comblocked (ComBal Winning Even)

schema sg4bkdw 			//BLOCKED BY PLAYER +not losing +w/co
archetype AI_COMBAT
sg4bkdw1
schema_voice vguard4 3 comblocked (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop4 3 comblocked (ComBal Winning Even) (NearbyFriends 0 20)

schema sg4det 			//DETECTED BLOCK +not losing
archetype AI_MORE_MAJOR
sg4det_1 sg4det_2 sg4det_3
schema_voice vguard4 1 comdetblock (ComBal Winning Even)
schema_voice vcop4 1 comdetblock (ComBal Winning Even)

schema sg4detw 			//DETECTED BLOCK  +not losing +w/co
archetype AI_MORE_MAJOR
sg4detw1
schema_voice vguard4 3 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop4 3 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg4amb 			//AMBUSHED
archetype AI_MAJOR
sg4amb_1 sg4amb_2 sg4amb_3 sg4amb_4
schema_voice vguard4 1 comhitamb (ComBal Winning Even)
schema_voice vcop4 1 comhitamb (ComBal Winning Even)

schema sg4ambw			//AMBUSHED +w/co
archetype AI_COMBAT
sg4ambw1 sg4ambw2 sg4ambw3
schema_voice vguard4 2 comhitamb (NearbyFriends 0 20)
schema_voice vcop4 2 comhitamb (NearbyFriends 0 20)

schema sg4diea			//DEATH BY AMBUSH
archetype AI_MINOR
volume -500
sg4diea1 sg4diea2 sg4diea3 sg4diea4 sg4diea5
schema_voice vguard4 1 comdiesoft
schema_voice vcop4 1 comdiesoft

schema sg4diec			//DEATH BY COMBAT
archetype AI_COMBAT
sg4diec1 sg4diec2 sg4diec3 sg4diec4
schema_voice vguard4 1 comdieloud
schema_voice vcop4 1 comdieloud

//----------------------------------------------------
//----------------------------------------------------


