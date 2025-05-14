//GUARD&COP5 - BROADCAST SPEECH -Dan Thron

//----------------------------------------------------

schema sg5a0sn			//ASLEEP
archetype AI_NONE
volume -500
mono_loop 2000 3000
sg5a0sn1 sg5a0sn2 sg5a0sn3 sg5a0sn4 sg5a0sn5 sg5a0sn6
schema_voice vguard5 1 sleeping
schema_voice vcop5 1 sleeping

schema sg5a0		 	//AT ALERT 0  
archetype AI_NONE
stream
delay 5000
volume -500
no_repeat
mono_loop 10000 20000
sg5a0hu1 sg5a0hu2 sg5a0hu3 sg5a0hu4 sg5a0hu5
sg5a0mu1 sg5a0mu2 sg5a0mu3 
sg5a0co1 sg5a0co2 sg5a0co3 sg5a0co4 sg5a0co5 
sg5a0th1 sg5a0th2 sg5a0th3 sg5a0th4
schema_voice vguard5 1 atlevelzero

schema sg5a0_cop
archetype AI_NONE
stream
delay 5000
volume -500
no_repeat
mono_loop 10000 20000
sg5a0wh1 sg5a0wh2 sg5a0wh3 sg5a0wh4 sg5a0wh5
sg5a0co1 sg5a0co2 sg5a0co3 sg5a0co4 sg5a0co5 
sg5a0tc1 sg5a0tc2 sg5a0tc3 sg5a0th5
sg5a0mu4 sg5a0mu5 sg5a0mu6 sg5a0mu7
schema_voice vcop5 1 atlevelzero

//----------------------------------------------------

schema sg5a1			//TO ALERT 1
archetype AI_NONE
sg5a1__1 sg5a1__2 sg5a1__3 sg5a1__4 sg5a1__5 sg5a1__6
schema_voice vguard5 1 tolevelone 

schema sg5a1_cop
archetype AI_NONE
sg5a1__8 sg5a1__4 sg5a1__5 sg5a1__6
schema_voice vcop5 1 tolevelone  

schema sg5a1v			//TO ALERT 1 +sighted 
archetype AI_NONE
sg5a1v_1 sg5a1v_2
schema_voice vguard5 1 tolevelone (Sense Sight)

schema sg5a1v_cop
archetype AI_NONE
sg5a1v_3 sg5a1v_1 sg5a1v_2
schema_voice vcop5 1 tolevelone (Sense Sight)

schema sg5a1h			//TO ALERT 1 +heard
archetype AI_NONE
sg5a1h_1 sg5a1h_2 sg5a1h_3
schema_voice vguard5 2 tolevelone (Sense Sound)

schema sg5a1h_cop
archetype AI_NONE
sg5a1h_4 sg5a1h_1 sg5a1h_2 sg5a1h_3
schema_voice vcop5 2 tolevelone (Sense Sound)

schema sg5a1_w			//TO ALERT 1 +w/co
archetype AI_MINOR
sg5a1_w1 sg5a1_w2
schema_voice vguard5 2 tolevelone (NearbyFriends 0 20)

schema sg5a1_w_cop
archetype AI_MINOR
sg5a1_w3 sg5a1_w1
schema_voice vcop5 2 tolevelone (NearbyFriends 0 20)

schema sg5a1vw			//TO ALERT 1 +sighted +w/co
archetype AI_MINOR
sg5a1vw1 sg5a1vw2 sg5a1vw3 sg5a1vw4 
schema_voice vguard5 2 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema sg5a1vw_cop
archetype AI_MINOR
sg5a1vw5 sg5a1vw6 sg5a1vw3 sg5a1vw4 
schema_voice vcop5 2 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema sg5a1hw			//TO ALERT 1 +heard +w/co
archetype AI_MINOR
sg5a1hw1 sg5a1hw2 sg5a1hw3 sg5a1hw4
schema_voice vguard5 5 tolevelone (Sense Sound) (NearbyFriends 0 20)

schema sg5a1hw_cop
archetype AI_MINOR
sg5a1hw5 sg5a1hw6 sg5a1hw1 sg5a1hw2 
schema_voice vcop5 5 tolevelone (Sense Sound) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg5at1			//AT ALERT 1 & 2
archetype AI_NONE
volume -500
delay 5000
mono_loop 8000 20000
sg5a0co1 sg5a0co2 sg5a0co3 sg5a0co4 sg5a0co5 
sg5a0th1 sg5a0th2 sg5a0th3 sg5a0th4 
schema_voice vguard5 1 atlevelone
schema_voice vguard5 1 atleveltwo

schema sg5at1_cop
archetype AI_NONE
volume -500
delay 5000
mono_loop 8000 20000
sg5a0co1 sg5a0co2 sg5a0co3 sg5a0co4 sg5a0co5 
sg5a0tc1 sg5a0tc2 sg5a0tc3 sg5a0th5
schema_voice vcop5 1 atlevelone
schema_voice vcop5 1 atleveltwo

//----------------------------------------------------

schema sg5bak			//BACK TO ALERT 0
archetype AI_NONE
sg5bak_1 sg5bak_2 sg5bak_3 sg5bak_4 sg5bak_5 sg5bak_6 sg5bak_7 sg5bak_8
schema_voice vguard5 1 backtozero  

schema sg5bak_cop
archetype AI_NONE
sg5bak_9 sg5bak_a sg5bak_b sg5bak_c sg5bak_1 sg5bak_2 sg5bak_3 sg5bak_4 
schema_voice vcop5 1 backtozero  

//----------------------------------------------------

schema sg5a2			//TO ALERT 2
archetype AI_MINOR
sg5a2__1 sg5a2__2 sg5a2__3 sg5a2__4 sg5a2__5
schema_voice vguard5 1 toleveltwo  

schema sg5a2_cop
archetype AI_MINOR
sg5a2__6 sg5a2__7 sg5a2__1 sg5a2__2 sg5a2__3 sg5a1__7 
schema_voice vcop5 1 toleveltwo  
				
schema sg5a2v			//TO ALERT 2 +sighted
archetype AI_MINOR
sg5a2v_1
schema_voice vguard5 1 toleveltwo (Sense Sight)  

schema sg5a2v_cop
archetype AI_MINOR
sg5a2v_2 sg5a2v_1
schema_voice vcop5 1 toleveltwo (Sense Sight)  

schema sg5a2h			//TO ALERT 2 +heard
archetype AI_MINOR
sg5a2h_1 sg5a2h_2 
schema_voice vguard5 2 toleveltwo (Sense Sound)

schema sg5a2h_cop
archetype AI_MINOR
sg5a2h_3 sg5a2h_4 sg5a2h_1 sg5a2h_2 
schema_voice vcop5 2 toleveltwo (Sense Sound)

//----------------------------------------------------

schema sg5a3			//TO ALERT 3 
archetype AI_MAJOR
sg5a3__1 sg5a3__2 sg5a3__3 sg5a3__4
schema_voice vguard5 1 tolevelthree
schema_voice vcop5  1 tolevelthree

schema sg5a3s			//SPOTTED THE PLAYER 
archetype AI_MORE_MAJOR
sg5a3s_1 sg5a3s_2 sg5a3s_3 sg5a3s_4
schema_voice vguard5 1 spotplayer 

schema sg5a3s_cop
archetype AI_MORE_MAJOR
sg5a3s_5 sg5a3s_6 sg5a3s_7 sg5a3s_3 sg5a3s_4
schema_voice vcop5 3 spotplayer 

schema sg5a3b			//TO ALERT 3 +carrying a body
archetype AI_MORE_MAJOR
sg5a3b_1 
schema_voice vguard5 99 spotplayer (CarryBody True)

schema sg5a3b_cop
archetype AI_MORE_MAJOR
sg5a3b_2
schema_voice vcop5 99 spotplayer (CarryBody True)

schema sg5telr			//TO ALERT 3 +w/co
archetype AI_COMBAT
sg5a3na3 sg5a3na4 sg5a3na5
sg5telr1 sg5telr2 sg5telr3 sg5telr4
schema_voice vguard5 3 spotplayer (NearbyFriends 0 20)
schema_voice vguard5 1 reacttellrev

schema sg5telr_cop
archetype AI_COMBAT
sg5telr5 sg5telr6 sg5telr7 
sg5a3na8 sg5a3na9 sg5a3na3 sg5a3na4 sg5a3na5
schema_voice vcop5 3 spotplayer (NearbyFriends 0 20)
schema_voice vcop5 1 reacttellrev

//----------------------------------------------------

schema sg5at2			//AT ALERT 2 & 3 +Investigating
archetype AI_MINOR
delay 4000
no_repeat
mono_loop 10000 20000
sg5a3se1 sg5a3se2 sg5a3se3 sg5a3se4 sg5a3se5 sg5a3se6 sg5a3se7 sg5a3se8
schema_voice vguard5 99 atleveltwo (Investigate true)
schema_voice vguard5 99 atlevelthree (Investigate true)
schema_voice vcop5 99 atleveltwo (Investigate true)
schema_voice vcop5 99 atlevelthree (Investigate true)

//----------------------------------------------------

schema sg5telc			//RE-SPOTTED PLAYER +w/co
archetype AI_COMBAT
sg5telc1 sg5telc2 sg5telc3 sg5telc4 sg5telc5 sg5telc6
sg5a3na1 sg5a3na2 sg5a3na6
schema_voice vguard5 99 spotplayer (NearbyFriends 0 20) (Reacquire True) 
schema_voice vguard5 1 reacttellconf

schema sg5telc_cop
archetype AI_COMBAT
sg5telc7 sg5telc8 sg5telc9 sg5telc1 sg5telc2 sg5telc3
sg5a3na7 sg5a3na1 sg5a3na2 
schema_voice vcop5 99 spotplayer (NearbyFriends 0 20) (Reacquire True) 
schema_voice vcop5 1 reacttellconf

//----------------------------------------------------

schema sg5los			//LOST CONTACT W/PLAYER
archetype AI_NONE
sg5los_1 sg5los_2 sg5los_3 sg5los_4 
schema_voice vguard5 1 lostcontact  

schema sg5los_cop
archetype AI_NONE
sg5los_5 sg5los_6 sg5los_7 sg5los_8 sg5los_1 sg5los_2
schema_voice vcop5 2 lostcontact  

//----------------------------------------------------

schema sg5chga			//REACT CHARGE
archetype AI_MORE_MAJOR
sg5chga1 sg5a3s_4 sg5atw_1
//sg5chga2 "blade" no good for RC guys
schema_voice vguard5 1 reactcharge

schema sg5chga_cop
archetype AI_MORE_MAJOR
sg5chga3 sg5chga4 sg5chga1 sg5a3s_4 sg5atw_1
schema_voice vcop5 1 reactcharge

schema sg5chgw			//REACT CHARGE +w/co
archetype AI_COMBAT
sg5chgw1 sg5chgw2 sg5chgw3 sg5chgw4 sg5a3na3
schema_voice vguard5 3 reactcharge (NearbyFriends 0 20)

schema sg5chgw_cop
archetype AI_COMBAT
sg5chgw5 sg5chgw6 sg5chgw1 sg5chgw2 sg5chgw3 sg5chgw4 sg5a3na3
schema_voice vcop5 3 reactcharge (NearbyFriends 0 20)

schema sg5runa			//REACT RUN AWAY
archetype AI_MAJOR
sg5runa1 sg5runa2 sg5runa3 sg5runa4
schema_voice vguard5 1 reactrun 

schema sg5runa_cop
archetype AI_MAJOR
sg5runa5 sg5runa6 sg5runa1 sg5runa2 sg5runa3 sg5runa4
schema_voice vcop5 1 reactrun 

schema sg5alma			//REACT I SOUND ALARMS
archetype AI_MORE_MAJOR
sg5alma1 sg5alma2 sg5alma3
schema_voice vguard5 1 reactalarm

schema sg5alma_cop
archetype AI_MORE_MAJOR
sg5alma4 sg5alma5 sg5alma1 sg5alma2 
schema_voice vcop5 1 reactalarm

schema sg5almw			//REACT YOU SOUND ALARMS +w/co
archetype AI_COMBAT
sg5almw1 sg5almw2
schema_voice vguard5 3 reactalarm (NearbyFriends 0 20)

schema sg5almw_cop
archetype AI_COMBAT
sg5almw3 sg5almw1
schema_voice vcop5 2 reactalarm (NearbyFriends 0 20)

//----------------------------------------------------

schema sg5bow			//REACT SHOOT
archetype AI_MORE_MAJOR
no_repeat
sg5atb_1 sg5atb_2 sg5atb_3
schema_voice vguard5 1 reactshoot
schema_voice vcop5 1 reactshoot

schema sg5frust			//FRUSTRATION
archetype AI_MAJOR
sg5frus1 sg5frus2 sg5frus3 sg5frus4
schema_voice vguard5 1 outofreach
schema_voice vcop5 1 outofreach

schema sg5torch			//NOTICED DOUSED TORCH-GASLIGHT
archetype AI_NONE
delay 1000
sg5torc1 sg5torc2
schema_voice vguard5 1 notice (Item Gaslight Torch)
schema_voice vcop5 1 notice (Item Gaslight Torch)

schema sg5getbowman	//RUN AND GET A BOWMAN
archetype AI_MORE_MAJOR
sg5runa6 sg5telr4 sg5runa2
schema_voice vguard5 1 getbowman
schema_voice vcop5 1 getbowman

//----------------------------------------------------

schema sg5bod			//FOUND BODY
archetype AI_MORE_MAJOR
sg5bod_1 sg5bod_2 sg5bod_3
schema_voice vguard5 1 foundbody  

schema sg5bod_cop
archetype AI_MORE_MAJOR
sg5bod_4 sg5bod_5 sg5bod_1 sg5bod_2 
schema_voice vcop5 1 foundbody  

schema sg5rob			//FOUND DEAD ROBOT
archetype AI_MORE_MAJOR
sg5rob_1 sg5rob_2
schema_voice vguard5 1 foundrobot  
schema_voice vcop5 1 foundrobot 

schema sg5mis			//FOUND SOMETHING MISSING 
archetype AI_MAJOR
sg5mis_1 sg5mis_2 sg5mis_3 sg5mis_4
schema_voice vguard5 1 foundmissing 
schema_voice vguard5 1 notice (Item MissingLoot)

schema sg5mis_cop
archetype AI_MAJOR
sg5mis_5 sg5mis_6 sg5mis_1 sg5mis_2 
schema_voice vcop5 1 foundmissing 
schema_voice vcop5 1 notice (Item MissingLoot)

schema sg5sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
sg5sma_1 sg5sma_2 sg5sma_3 sg5sma_4
schema_voice vguard5 1 foundsmall  
schema_voice vguard5 1 notice (Item Door Generic)

schema sg5sma_cop
archetype AI_MINOR
sg5sma_5 sg5sma_6 sg5sma_3 sg5sma_4
schema_voice vcop5 2 foundsmall  
schema_voice vcop5 2 notice (Item Door Generic)

schema sg5lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
sg5lar_1 sg5lar_2 sg5lar_3
schema_voice vguard5 1 foundlarge

schema sg5lar_cop
archetype AI_MAJOR
sg5lar_4 sg5lar_5 sg5lar_1
schema_voice vcop5 1 foundlarge

schema sg5sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
sg5sec_1 sg5sec_2 sg5sec_3 sg5sec_4
schema_voice vguard5 1 foundbreach 

schema sg5sec_cop
archetype AI_MORE_MAJOR
sg5sec_5 sg5sec_6 sg5sec_1 sg5sec_2 
schema_voice vcop5 1 foundbreach 

//----------------------------------------------------

schema sg5rint			//RECENTLY SAW THE PLAYER
archetype AI_INFORM
sg5rint1 sg5rint2 sg5rint3
schema_voice vguard5 1 recentintruder 

schema sg5rint_cop
archetype AI_INFORM
sg5rint4 sg5rint1 sg5rint2 sg5rint3
schema_voice vcop5 1 recentintruder 

schema sg5rbod			//RECENTLY FOUND BODY
archetype AI_INFORM
sg5rbod1 sg5rbod2 sg5rbod3
schema_voice vguard5 1 recentbody 

schema sg5rbod_cop
archetype AI_INFORM
sg5rbod4 sg5rbod5 sg5rbod1 sg5rbod2 
schema_voice vcop5 1 recentbody 

schema sg5rrob			//RECENTLY FOUND DEAD ROBOT
archetype AI_INFORM
sg5rrob1 sg5rint1 sg5roth2
schema_voice vguard5 1 recentrobot 
schema_voice vcop5 1 recentrobot 

schema sg5rmis			//RECENTLY FOUND MISSING
archetype AI_INFORM
sg5rmis1 sg5rmis2 sg5rmis3 sg5rmis4
schema_voice vguard5 1 recentmissing 

schema sg5rmis_cop
archetype AI_INFORM
sg5rmis5 sg5rmis6 sg5rmis1 sg5rmis2 
schema_voice vcop5 1 recentmissing 

schema sg5roth			//RECENTLY FOUND ANAMOLY
archetype AI_INFORM
sg5roth1 sg5roth2 sg5roth3 sg5roth4 sg5roth5
schema_voice vguard5 1 recentother 

schema sg5roth_cop
archetype AI_INFORM
sg5roth6 sg5roth7 sg5roth1 sg5roth2 sg5roth3
schema_voice vcop5 1 recentother 

//----------------------------------------------------
//COMBAT

schema sg5atn			//ATTACKING +not losing
archetype AI_COMBAT
sg5atn_1 freq 1
sg5atn_2 freq 1
sg5atn_3 freq 2
sg5atn_4 freq 2
sg5atn_5 freq 2
sg5atn_6 freq 2
sg5atn_7 freq 2
schema_voice vguard5 1 comattack (ComBal Even)
schema_voice vcop5 1 comattack (ComBal Even)

schema sg5at_w			//ATTACKING	+winning
archetype AI_COMBAT
sg5atw_1 sg5atw_2 sg5atn_3 sg5atn_4 
schema_voice vguard5 3 comattack (ComBal Winning)
schema_voice vcop5 3 comattack (ComBal Winning)

schema sg5atww			//ATTACKING +winning +w/co
archetype AI_COMBAT
sg5atww1 sg5atn_2 sg5atn_1
schema_voice vguard5 3 comattack (ComBal Winning) (NearbyFriends 0 20)
schema_voice vcop5 3 comattack (ComBal Winning) (NearbyFriends 0 20)

schema sg5atl			//ATTACKING	+losing
archetype AI_COMBAT
sg5atl_1 sg5atl_2 sg5atl_3 sg5atl_4 sg5atl_5
schema_voice vguard5 2 comattack (ComBal Losing)
schema_voice vcop5 2 comattack (ComBal Losing)

//----------------------------------------------------

schema sg5hit			//HIT THE PLAYER +not losing
archetype AI_COMBAT
sg5hit_1 sg5hit_2 sg5hit_3 sg5hit_4
schema_voice vguard5 1 comsucchit (ComBal Winning Even)
schema_voice vcop5 1 comsucchit (ComBal Winning Even)

schema sg5hitw			//HIT THE PLAYER +not losing +w/co
archetype AI_COMBAT
sg5hitw1 sg5hitw2
schema_voice vguard5 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop5 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

schema sg5blk			//BLOCKED THE PLAYER +not losing
archetype AI_COMBAT
sg5blk_1 sg5blk_2 sg5blk_3
schema_voice vguard5 1 comsuccblock (ComBal Winning Even)
schema_voice vcop5 1 comsuccblock (ComBal Winning Even)

schema sg5blkw			//BLOCKED THE PLAYER +not losing +w/co
archetype AI_COMBAT
sg5blkw1
schema_voice vguard5 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop5 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg5hhi			//HIT BY PLAYER W/HI HIT PTS 
archetype AI_MAJOR
sg5hhi_1 sg5hhi_2 sg5hhi_3 sg5hhi_4 sg5hhi_5 sg5hhi_6
schema_voice vguard5 1 comhithigh
schema_voice vguard5 99 comhitnodam (ComBal Losing)
schema_voice vcop5 1 comhithigh
schema_voice vcop5 99 comhitnodam (ComBal Losing)

schema sg5hlo			//HIT BY PLAYER W/LO PTS 
archetype AI_MORE_MAJOR
sg5hlo_1 sg5hlo_2 sg5hlo_3 sg5hlo_4
schema_voice vguard5 1 comhitlow
schema_voice vcop5 1 comhitlow

schema sg5hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
sg5hlow1 sg5hlow2 sg5hlo_1 sg5hlo_2 sg5hlo_3 
schema_voice vguard5 99 comhitlow (NearbyFriends 0 20)
schema_voice vcop5 99 comhitlow (NearbyFriends 0 20)

schema sg5hnd			//HIT BY PLAYER NO DAMAGE +Winning
archetype AI_NONE
sg5hnd_1 sg5hnd_2 sg5hnd_3 
schema_voice vguard5 99 comhitnodam (ComBal Winning)
schema_voice vcop5 99 comhitnodam (ComBal Winning)
schema_voice vguard5 1 comhitnodam
schema_voice vcop5 1 comhitnodam

schema sg5hnd_e			//HIT BY THE PLAYER NO DAMAGE +Even
archetype AI_NONE
sg5hnde1 sg5hnde2 sg5hnde3
schema_voice vguard5 99 comhitnodam (ComBal Even)
schema_voice vcop5 99 comhitnodam (ComBal Even)
schema_voice vguard5 3 comhitnodam 
schema_voice vcop5 3 comhitnodam 

//----------------------------------------------------

schema sg5bkd 			//BLOCKED BY PLAYER +not losing
archetype AI_COMBAT
sg5bkd_1 sg5bkd_2 sg5bkd_3 
schema_voice vguard5 1 comblocked (ComBal Winning Even)
schema_voice vcop5 1 comblocked (ComBal Winning Even)

schema sg5bkdw 			//BLOCKED BY PLAYER +not losing +w/co
archetype AI_COMBAT
sg5bkdw1
schema_voice vguard5 3 comblocked (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop5 3 comblocked (ComBal Winning Even) (NearbyFriends 0 20)

schema sg5det 			//DETECTED BLOCK +not losing
archetype AI_MORE_MAJOR
sg5det_1 sg5det_2 sg5det_3
schema_voice vguard5 1 comdetblock (ComBal Winning Even)
schema_voice vcop5 1 comdetblock (ComBal Winning Even)

schema sg5detw 			//DETECTED BLOCK  +not losing +w/co
archetype AI_MORE_MAJOR
sg5detw1
schema_voice vguard5 3 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop5 3 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg5amb 			//AMBUSHED
archetype AI_MAJOR
sg5amb_1 sg5amb_2 sg5amb_3 sg5amb_4
schema_voice vguard5 1 comhitamb (ComBal Winning Even)
schema_voice vcop5 1 comhitamb (ComBal Winning Even)

schema sg5ambw			//AMBUSHED +w/co
archetype AI_COMBAT
sg5ambw1 sg5ambw2 sg5ambw3 
schema_voice vguard5 2 comhitamb (NearbyFriends 0 20)
schema_voice vcop5 2 comhitamb (NearbyFriends 0 20)

schema sg5diea			//DEATH BY AMBUSH
archetype AI_MINOR
volume -500
sg5diea1 sg5diea2 sg5diea3 sg5diea4
schema_voice vguard5 1 comdiesoft
schema_voice vcop5 1 comdiesoft

schema sg5diec			//DEATH BY COMBAT
archetype AI_COMBAT
sg5diec1 sg5diec2 sg5diec3
schema_voice vguard5 1 comdieloud
schema_voice vcop5 1 comdieloud

//----------------------------------------------------
//----------------------------------------------------




