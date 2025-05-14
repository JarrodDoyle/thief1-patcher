//GUARD&COP2 - BROADCAST SPEECH -Kevin Callow

//----------------------------------------------------

schema sg2a0sn			//ASLEEP
archetype AI_NONE
volume -500
mono_loop 2000 3000
sg2a0sn1 sg2a0sn2 sg2a0sn3 sg2a0sn4 
schema_voice vguard2 1 sleeping
schema_voice vcop2 1 sleeping
schema_voice vdrunk1 1 sleeping

schema sg2a0		 	//AT ALERT 0  
archetype AI_NONE
delay 2000
volume -500
no_repeat
mono_loop 10000 20000
sg2a0hu1 sg2a0hu2 sg2a0hu3 sg2a0hu4 sg2a0hu5 sg2a0hu6
sg2a0mu1 sg2a0mu2 sg2a0mu3 sg2a0mu4
sg2a0co1 sg2a0co2 sg2a0co3 sg2a0co4 sg2a0co5 sg2a0co6 sg2a0co7 
schema_voice vguard2 1 atlevelzero

schema sg2a0_cop
archetype AI_NONE
delay 2000
stream
volume -500
no_repeat
mono_loop 10000 20000
sg2a0wh1 sg2a0wh2 sg2a0wh3 sg2a0wh4
sg2a0tc1 sg2a0tc2 
sg2a0th1 sg2a0th2 sg2a0th3 sg2a0th4 sg2a0th5 sg2a0th6
schema_voice vcop2 1 atlevelzero



//----------------------------------------------------

schema sg2a1			//TO ALERT 1
archetype AI_NONE
sg2a1__1 sg2a1__3 sg2a1__4 sg2a1__5 sg2a1__6 
schema_voice vguard2 1 tolevelone 
schema_voice vcop2 1 tolevelone  

schema sg2a1v			//TO ALERT 1 +sighted 
archetype AI_NONE
sg2a1v_1 sg2a1v_2
schema_voice vguard2 1 tolevelone (Sense Sight)
schema_voice vcop2 1 tolevelone (Sense Sight)

schema sg2a1h			//TO ALERT 1 +heard
archetype AI_NONE
sg2a1h_1 sg2a1h_2 sg2a1h_3
schema_voice vguard2 2 tolevelone (Sense Sound)
schema_voice vcop2 2 tolevelone (Sense Sound)

schema sg2a1_w			//TO ALERT 1 +w/co
archetype AI_MINOR
sg2a1_w1 sg2a1_w2 
schema_voice vguard2 2 tolevelone (NearbyFriends 0 20)
schema_voice vcop2 2 tolevelone (NearbyFriends 0 20)

schema sg2a1vw			//TO ALERT 1 +sighted +w/co
archetype AI_MINOR
sg2a1vw1 sg2a1vw2 sg2a1vw3 sg2a1vw4  
schema_voice vguard2 2 tolevelone (Sense Sight) (NearbyFriends 0 20)
schema_voice vcop2 2 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema sg2a1hw			//TO ALERT 1 +heard +w/co
archetype AI_MINOR
sg2a1hw1 sg2a1hw2 sg2a1hw3 sg2a1hw4
schema_voice vguard2 5 tolevelone (Sense Sound) (NearbyFriends 0 20)
schema_voice vcop2 5 tolevelone (Sense Sound) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg2a1tc			//AT ALERT 1 & 2
archetype AI_NONE
volume -500
delay 5000
mono_loop 8000 20000
sg2a0mu1 sg2a0mu2 sg2a0mu3 sg2a0mu4
sg2a0co1 sg2a0co2 sg2a0co3 sg2a0co4 sg2a0co5 sg2a0co6 sg2a0co7 
schema_voice vguard2 1 atlevelone
schema_voice vguard2 1 atleveltwo

schema sg2a1tc_cop
archetype AI_NONE
volume -500
delay 5000
mono_loop 8000 20000
sg2a0tc1 sg2a0tc2 
sg2a0th1 sg2a0th2 sg2a0th3 sg2a0th4 sg2a0th5 sg2a0th6
schema_voice vcop2 1 atlevelone
schema_voice vcop2 1 atleveltwo

//----------------------------------------------------

schema sg2bak			//BACK TO ALERT 0
archetype AI_NONE
sg2bak_1 sg2bak_2 sg2bak_3 sg2bak_4 sg2bak_5 sg2bak_6 sg2bak_7 sg2bak_8
schema_voice vguard2 1 backtozero  
schema_voice vcop2 1 backtozero  

//----------------------------------------------------

schema sg2a2			//TO ALERT 2
archetype AI_MINOR
sg2a2__1 sg2a2__2 sg2a2__3 sg2a2__4 sg2a2__5 
schema_voice vguard2 1 toleveltwo  
schema_voice vcop2 1 toleveltwo  
				
schema sg2a2v			//TO ALERT 2 +sighted
archetype AI_MINOR
sg2a2v_1 sg2a1__2
schema_voice vguard2 1 toleveltwo (Sense Sight)  
schema_voice vcop2 1 toleveltwo (Sense Sight)  

schema sg2a2h			//TO ALERT 2 +heard
archetype AI_MINOR
sg2a2h_1 sg2a2h_2 sg2a2h_3
schema_voice vguard2 4 toleveltwo (Sense Sound)
schema_voice vcop2 4 toleveltwo (Sense Sound)

//----------------------------------------------------

schema sg2a3			//TO ALERT 3 
archetype AI_MAJOR
sg2a3__1 sg2a3__2
schema_voice vguard2 1 tolevelthree
schema_voice vcop2  1 tolevelthree

schema sg2a3s			//SPOTTED THE PLAYER 
archetype AI_MORE_MAJOR
sg2a3s_1 sg2a3s_2 sg2a3s_3 sg2a3s_4 sg2a3s_5
sg2a3na1 sg2a3na2 sg2a3na3 sg2a3na4 sg2a3na5 sg2a3na6
schema_voice vguard2 1 spotplayer 

schema sg2a3s_cop
archetype AI_MORE_MAJOR
sg2a3s_6 sg2a3s_7 sg2a3s_1 sg2a3s_2 
sg2a3na7 sg2a3na8 sg2a3na1 sg2a3na2 
schema_voice vcop2 1 spotplayer 

schema sg2a3b			//TO ALERT 3 +carrying a body
archetype AI_MORE_MAJOR
sg2a3b_1 
schema_voice vguard2 99 spotplayer (CarryBody True)
schema_voice vcop2 99 spotplayer (CarryBody True)

schema sg2a3b_cop
archetype AI_MORE_MAJOR
sg2a3b_2
schema_voice vcop2 99 spotplayer (CarryBody True)

schema sg2telr			//TO ALERT 3 +w/co
archetype AI_COMBAT
sg2telr1 sg2telr2 sg2telr3 sg2telr4 
schema_voice vguard2 3 spotplayer (NearbyFriends 0 20)
schema_voice vcop2 3 spotplayer (NearbyFriends 0 20)
schema_voice vguard2 3 reacttellrev
schema_voice vcop2 3 reacttellrev

//----------------------------------------------------

schema sg2at2			//AT ALERT 2 & 3 +Investigating
archetype AI_MINOR
delay 4000
no_repeat
mono_loop 10000 20000
sg2a3se1 sg2a3se2 sg2a3se3 sg2a3se4 sg2a3se5 sg2a3se6 sg2a3se7 sg2a3se8
schema_voice vguard2 99 atleveltwo (Investigate true)
schema_voice vguard2 99 atlevelthree (Investigate true)

schema sg2at2_cop			//AT ALERT 2 & 3 +Investigating
archetype AI_MINOR
delay 4000
no_repeat
mono_loop 10000 20000
sg2a3se9 sg2a3sea sg2a3se3 sg2a3se4 sg2a3se5 sg2a3se6 sg2a3se7 sg2a3se8
schema_voice vcop2 99 atleveltwo (Investigate true)
schema_voice vcop2 99 atlevelthree (Investigate true)

//----------------------------------------------------

schema sg2telc			//RE-SPOTTED PLAYER +w/co
archetype AI_COMBAT
sg2telc1 sg2telc2 sg2telc3 sg2telc4 sg2telc5 sg2telc6
schema_voice vguard2 99 spotplayer (NearbyFriends 0 20) (Reacquire True) 
schema_voice vcop2 99 spotplayer (NearbyFriends 0 20) (Reacquire True) 
schema_voice vguard2 99 reacttellconf 
schema_voice vcop2 99 reacttellconf 

//----------------------------------------------------

schema sg2los			//LOST CONTACT W/PLAYER
archetype AI_NONE
sg2los_1 sg2los_2 sg2los_3 sg2los_4
schema_voice vguard2 1 lostcontact  

schema sg2los_cop
archetype AI_NONE
sg2los_5 sg2los_6 sg2los_1 sg2los_2
schema_voice vcop2 1 lostcontact  

//----------------------------------------------------

schema sg2chga			//REACT CHARGE
archetype AI_MORE_MAJOR
sg2chga1 sg2chga2 sg2chga4 sg2chga5
schema_voice vguard2 1 reactcharge

schema sg2chga_cop
archetype AI_MORE_MAJOR
sg2chga3 sg2chga1 sg2chga2 sg2chga4 sg2chga5
schema_voice vcop2 1 reactcharge

schema sg2chgw			//REACT CHARGE +w/co
archetype AI_COMBAT
sg2chgw1 sg2chgw2 sg2chgw3
schema_voice vguard2 3 reactcharge (NearbyFriends 0 20)

schema sg2chgw_cop
archetype AI_COMBAT
sg2chgw1 sg2chgw2 sg2chgw3 sg2chgw4 
schema_voice vcop2 3 reactcharge (NearbyFriends 0 20)

schema sg2runa			//REACT RUN AWAY
archetype AI_MAJOR
sg2runa1 sg2runa2 sg2runa3 sg2runa4
schema_voice vguard2 1 reactrun 

schema sg2runa_cop
archetype AI_MAJOR
sg2runa5 sg2runa6 sg2runa1 sg2runa2 sg2runa3 sg2runa4
schema_voice vcop2 1 reactrun 

schema sg2alma			//REACT I SOUND ALARMS
archetype AI_MORE_MAJOR
sg2alma1 sg2alma2 sg2alma3
schema_voice vguard2 1 reactalarm
schema_voice vcop2 1 reactalarm

schema sg2almw			//REACT YOU SOUND ALARMS +w/co
archetype AI_COMBAT
sg2almw1 sg2almw2
schema_voice vguard2 3 reactalarm (NearbyFriends 0 20)
schema_voice vcop2 3 reactalarm (NearbyFriends 0 20)

//----------------------------------------------------

schema sg2bow			//REACT SHOOT
archetype AI_MORE_MAJOR
no_repeat
sg2atb_1 sg2atb_2 sg2atb_3 sg2atb_4 
schema_voice vguard2 1 reactshoot
schema_voice vcop2 1 reactshoot

schema sg2frust			//FRUSTRATION
archetype AI_MAJOR
sg2frus1 sg2frus2 sg2frus3
schema_voice vguard2 1 outofreach

schema sg2frust_cop
archetype AI_MAJOR
sg2frus4 sg2frus1 sg2frus2 sg2frus3
schema_voice vcop2 1 outofreach

schema sg2torch			//NOTICED A DOUSED TORCH
archetype AI_NONE
delay 1000
sg2torc1 sg2torc2
schema_voice vguard2 1 notice (Item Gaslight Torch)
schema_voice vcop2 1 notice (Item Gaslight Torch)

schema sg2getbow			//RUN TO GET A BOWMAN
archetype AI_MAJOR
delay 1000
sg2runa1 sg2runa3
schema_voice vguard2 1 getbowman
schema_voice vcop2 1 getbowman

//----------------------------------------------------

schema sg2bod			//FOUND BODY
archetype AI_MORE_MAJOR
sg2bod_1 sg2bod_2 sg2bod_3
schema_voice vguard2 1 foundbody  
schema_voice vcop2 1 foundbody  

schema sg2rob			//FOUND DEAD ROBOT
archetype AI_MORE_MAJOR
sg2rob_1 sg2rob_2
schema_voice vguard2 1 foundrobot  
schema_voice vcop2 1 foundrobot 

schema sg2mis			//FOUND SOMETHING MISSING 
archetype AI_MAJOR
sg2mis_1 sg2mis_2 sg2mis_3 
schema_voice vguard2 1 foundmissing 
schema_voice vcop2 1 foundmissing 
schema_voice vguard2 1 notice (Item MissingLoot)
schema_voice vcop2 1 notice (Item MissingLoot)

schema sg2sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
sg2sma_1 sg2sma_2 sg2sma_3 sg2sma_4
schema_voice vguard2 1 foundsmall  
schema_voice vcop2 1 foundsmall  
schema_voice vguard2 1 notice (Item Door Generic)
schema_voice vcop2 1 notice (Item Door Generic)

schema sg2lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
sg2lar_1 sg2lar_2 sg2lar_3 sg2lar_4
schema_voice vguard2 1 foundlarge
schema_voice vcop2 1 foundlarge

schema sg2sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
sg2sec_1 sg2sec_2 sg2sec_3 sg2sec_4
schema_voice vguard2 1 foundbreach 
schema_voice vcop2 1 foundbreach 

//----------------------------------------------------

schema sg2rint			//RECENTLY SAW THE PLAYER
archetype AI_INFORM
sg2rint1 sg2rint2 sg2rint3
schema_voice vguard2 1 recentintruder 
schema_voice vcop2 1 recentintruder 

schema sg2rbod			//RECENTLY FOUND BODY
archetype AI_INFORM
sg2rbod1 sg2rbod2 sg2rbod3 
schema_voice vguard2 1 recentbody 

schema sg2rbod_cop
archetype AI_INFORM
sg2rbod4 sg2rbod1
schema_voice vcop2 1 recentbody 

schema sg2rrob			//RECENTLY FOUND DEAD ROBOT
archetype AI_INFORM
sg2rrob1
schema_voice vguard2 1 recentrobot 
schema_voice vcop2 1 recentrobot 

schema sg2rmis			//RECENTLY FOUND MISSING
archetype AI_INFORM
sg2rmis1 sg2rmis2
schema_voice vguard2 1 recentmissing 

schema sg2rmis_cop
archetype AI_INFORM
sg2rmis3 
schema_voice vcop2 1 recentmissing 

schema sg2roth			//RECENTLY FOUND ANAMOLY
archetype AI_INFORM
sg2roth1 sg2roth2 sg2roth3
schema_voice vguard2 1 recentother 
schema_voice vcop2 1 recentother 

schema sg2roth_cop
archetype AI_INFORM
sg2roth4 sg2roth5 sg2roth2
schema_voice vcop2 1 recentother 

//----------------------------------------------------
//COMBAT

schema sg2atn			//ATTACKING +not losing
archetype AI_COMBAT
sg2atn_1 sg2atn_2 sg2atn_3 sg2atn_4 sg2atn_5 sg2atn_6 sg2atn_7 sg2atn_8
schema_voice vguard2 1 comattack (ComBal Even)
schema_voice vcop2 1 comattack (ComBal Even)

schema sg2atnw			//ATTACKING	+winning
archetype AI_COMBAT
sg2atw_1 sg2atw_2 sg2atn_1 sg2atn_2 sg2atn_3
schema_voice vguard2 3 comattack (ComBal Winning)
schema_voice vcop2 3 comattack (ComBal Winning)

schema sg2atww			//ATTACKING +winning +w/co
archetype AI_COMBAT
sg2atww1 sg2atw_1 sg2atw_2
schema_voice vguard2 3 comattack (ComBal Winning) (NearbyFriends 0 20)
schema_voice vcop2 3 comattack (ComBal Winning) (NearbyFriends 0 20)

schema sg2atl			//ATTACKING	+losing
archetype AI_COMBAT
sg2atl_1 sg2atl_2 sg2atl_3 sg2atl_4
schema_voice vguard2 2 comattack (ComBal Losing)
schema_voice vcop2 2 comattack (ComBal Losing)
schema_voice vdrunk1 1 comattack

//----------------------------------------------------

schema sg2hit			//HIT THE PLAYER +not losing
archetype AI_COMBAT
sg2hit_1 sg2hit_2 sg2hit_3 sg2hit_4
schema_voice vguard2 1 comsucchit (ComBal Winning Even)
schema_voice vcop2 1 comsucchit (ComBal Winning Even)

schema sg2hitw			//HIT THE PLAYER +not losing +w/co
archetype AI_COMBAT
sg2hitw1 sg2hitw2
schema_voice vguard2 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop2 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

schema sg2blk			//BLOCKED THE PLAYER +not losing
archetype AI_COMBAT
sg2blk_1 sg2blk_2 sg2blk_3
schema_voice vguard2 1 comsuccblock (ComBal Winning Even)
schema_voice vcop2 1 comsuccblock (ComBal Winning Even)

schema sg2blkw			//BLOCKED THE PLAYER +not losing +w/co
archetype AI_COMBAT
sg2blkw1
schema_voice vguard2 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop2 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg2hhi			//HIT BY PLAYER W/HI HIT PTS 
archetype AI_MAJOR
sg2hhi_1 sg2hhi_2 sg2hhi_3 sg2hhi_4 sg2hhi_5
schema_voice vguard2 1 comhithigh
schema_voice vguard2 99 comhitnodam (ComBal Losing)
schema_voice vcop2 1 comhithigh
schema_voice vcop2 99 comhitnodam (ComBal Losing)
schema_voice vdrunk1 1 comhithigh

schema sg2hlo			//HIT BY PLAYER W/LO PTS 
archetype AI_MORE_MAJOR
sg2hlo_1 sg2hlo_2 sg2hlo_3 sg2hlo_4 sg2hlo_5
schema_voice vguard2 1 comhitlow
schema_voice vcop2 1 comhitlow
schema_voice vdrunk1 1 comhitlow

schema sg2hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
sg2hlow1 sg2hlo_1 sg2hlo_2 sg2hlo_3 
schema_voice vguard2 99 comhitlow (NearbyFriends 0 20)
schema_voice vcop2 99 comhitlow (NearbyFriends 0 20)

schema sg2hnd			//HIT BY PLAYER NO DAMAGE +Winning
archetype AI_NONE
sg2hnd_1 sg2hnd_2 sg2hnd_3 
schema_voice vguard2 99 comhitnodam (ComBal Winning)
schema_voice vcop2 99 comhitnodam (ComBal Winning)
schema_voice vguard2 1 comhitnodam
schema_voice vcop2 1 comhitnodam

schema sg2hnd_e			//HIT BY THE PLAYER NO DAMAGE +Even
archetype AI_NONE
sg2hnde1 sg2hnde2 sg2hnde3
schema_voice vguard2 99 comhitnodam (ComBal Even)
schema_voice vcop2 99 comhitnodam (ComBal Even)
schema_voice vguard2 3 comhitnodam
schema_voice vcop2 3 comhitnodam

//----------------------------------------------------

schema sg2bkd 			//BLOCKED BY PLAYER +not losing
archetype AI_COMBAT
sg2bkd_1 sg2bkd_2 sg2bkd_3
schema_voice vguard2 1 comblocked (ComBal Winning Even)
schema_voice vcop2 1 comblocked (ComBal Winning Even)

schema sg2bkdw 			//BLOCKED BY PLAYER +not losing +w/co
archetype AI_COMBAT
sg2bkdw1
schema_voice vguard2 3 comblocked (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop2 3 comblocked (ComBal Winning Even) (NearbyFriends 0 20)

schema sg2det 			//DETECTED BLOCK +not losing
archetype AI_MORE_MAJOR
sg2det_1 sg2det_2 sg2det_3
schema_voice vguard2 1 comdetblock (ComBal Winning Even)
schema_voice vcop2 1 comdetblock (ComBal Winning Even)

schema sg2detw 			//DETECTED BLOCK  +not losing +w/co
archetype AI_MORE_MAJOR
sg2detw1 
schema_voice vguard2 3 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop2 3 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg2amb 			//AMBUSHED
archetype AI_MAJOR
sg2amb_1 sg2amb_2 sg2amb_3 sg2amb_4
schema_voice vguard2 1 comhitamb (ComBal Winning Even)
schema_voice vcop2 1 comhitamb (ComBal Winning Even)

schema sg2ambw			//AMBUSHED +w/co
archetype AI_COMBAT
sg2ambw1 sg2ambw2 sg2ambw3
schema_voice vguard2 2 comhitamb (NearbyFriends 0 20)
schema_voice vcop2 2 comhitamb (NearbyFriends 0 20)

schema sg2diea			//DEATH BY AMBUSH
archetype AI_MINOR
volume -500
sg2diea1 sg2diea2 sg2diea3 sg2diea4
schema_voice vguard2 1 comdiesoft
schema_voice vcop2 1 comdiesoft
schema_voice vdrunk1 1 comdiesoft

schema sg2diec			//DEATH BY COMBAT
archetype AI_COMBAT
sg2diec1 sg2diec2 sg2diec3 sg2diec4 sg2diec5
schema_voice vguard2 1 comdieloud
schema_voice vcop2 1 comdieloud
schema_voice vdrunk1 1 comdieloud

//----------------------------------------------------
//----------------------------------------------------

//DRUNK GUARD

schema dr1a0			//DRUNK AT ALERT ZERO
archetype AI_NONE
volume -500
delay 1000
no_repeat
mono_loop 1000 5000
dr1a0hc1 dr1a0hc2 dr1a0hc3 dr1a0hc4
dr1a0si1 dr1a0si2 dr1a0si3 dr1a0si4 dr1a0si5 dr1a0si6 dr1a0si7 dr1a0si8 dr1a0si9
schema_voice vdrunk1 1 atlevelzero
schema_voice vdrunk1 1 atlevelone

schema dr1a1			//DRUNK TO ALERT 1
archetype AI_NONE
dr1a1__1 dr1a1__2 dr1a1__3
schema_voice vdrunk1 1 tolevelone 
schema_voice vdrunk1 1 foundbody 

schema dr1at1			//DRUNK AT ALERT 1, 2, 3
archetype AI_NONE
volume -500
delay 2000
no_repeat
mono_loop 1000 10000
dr1a0hc1 dr1a0hc2 dr1a0hc3 dr1a0hc4
schema_voice vdrunk1 1 atleveltwo
schema_voice vdrunk1 1 atlevelthree


schema dr1a2			//DRUNK TO ALERT 2
archetype AI_NONE
dr1a2__1 dr1a2__2 dr1a2__3
schema_voice vdrunk1 1 toleveltwo

schema dr1a3			//DRUNK TO ALERT 3
archetype AI_MINOR
dr1a3__1 dr1a3__2 dr1a3__3
schema_voice vdrunk1 1 tolevelthree

schema dr1at2			//DRUNK AT ALERT 1, 2, 3
archetype AI_MINOR
volume -500
delay 2000
no_repeat
mono_loop 500 10000
dr1a0hc1 dr1a0hc2 dr1a0hc3 dr1a0hc4 
dr1a2__1 dr1a2__2 dr1a2__3 
dr1a1__2
dr1a0si6
schema_voice vdrunk1 1 atleveltwo (Investigate True)
schema_voice vdrunk1 1 atlevelthree (Investigate True)

schema dr1bak			//BACK TO ZERO
archetype AI_NONE
dr1a0hc1 dr1a0hc2 dr1a0hc3 dr1a0hc4
schema_voice vdrunk1 1 backtozero
schema_voice vdrunk1 1 comhitnodam
schema_voice vdrunk1 1 lostcontact
schema_voice vdrunk1 1 foundbreach 

schema dr1sma			//NOTICE MOST STUFF
archetype AI_NONE
dr1a2__1 dr1a2__3 dr1a1__1 dr1a1__3
schema_voice vdrunk1 1 notice (Item Door Generic Torch GasLight)
schema_voice vdrunk1 1 foundsmall
schema_voice vdrunk1 1 foundlarge
schema_voice vdrunk1 1 foundbody
schema_voice vdrunk1 1 foundrobot

schema dr1mis			//MISSING LOOT
archetype AI_NONE
dr1a2__1 dr1a2__3
schema_voice vdrunk1 1 notice (Item MissingLoot)
schema_voice vdrunk1 1 foundmissing

schema dr1chg
archetype AI_MINOR
dr1a2__2
schema_voice vdrunk1 1 reactcharge

//----------------------------------------------------
//----------------------------------------------------
//----------------------------------------------------



