//GUARD&COP6 - BROADCAST SPEECH -Carole Simms

//----------------------------------------------------

schema sg6a0sn			//ASLEEP
archetype AI_NONE
volume -500
mono_loop 2000 3000
sg6a0sn1 sg6a0sn2 sg6a0sn3 sg6a0sn4 sg6a0sn5 
schema_voice vguard6 1 sleeping
schema_voice vcop6 1 sleeping

schema sg6a0		 	//AT ALERT 0  
archetype AI_NONE
delay 6000
stream
volume -500
no_repeat
mono_loop 10000 20000
sg6a0wh1 sg6a0wh2 sg6a0wh3
sg6a0hu1 sg6a0hu2 sg6a0hu3 sg6a0hu4
sg6a0mu1 sg6a0mu2 sg6a0mu3
sg6a0co1 sg6a0co2 sg6a0co3 sg6a0co4 sg6a0co5 
schema_voice vguard6 1 atlevelzero

schema sg6a0_cop
archetype AI_NONE
delay 6000
volume -500
no_repeat
mono_loop 10000 20000
sg6a0mu5 sg6a0mu5 sg6a0mu6 sg6a0mu7 
sg6a0th1 sg6a0th2 sg6a0th3
sg6a0tc1 sg6a0tc2 sg6a0tc3
sg6a0wh1 sg6a0wh2 sg6a0wh3
sg6a0co1 sg6a0co2 sg6a0co3 sg6a0co4 sg6a0co5 
schema_voice vcop6 1 atlevelzero

//----------------------------------------------------

schema sg6a1			//TO ALERT 1
archetype AI_NONE
sg6a1__1 sg6a1__2 sg6a1__3 sg6a1__4 sg6a1__5 
schema_voice vguard6 1 tolevelone 

schema sg6a1_cop
archetype AI_NONE
sg6a1__7 sg6a1__3 sg6a1__4 sg6a1__5 
schema_voice vcop6 1 tolevelone  

schema sg6a1v			//TO ALERT 1 +sighted 
archetype AI_NONE
sg6a1v_1
schema_voice vguard6 1 tolevelone (Sense Sight)

schema sg6a1v_cop
archetype AI_NONE
sg6a1v_2 sg6a1v_1
schema_voice vcop6 1 tolevelone (Sense Sight)

schema sg6a1h			//TO ALERT 1 +heard
archetype AI_NONE
sg6a1h_1 sg6a1h_2
schema_voice vguard6 2 tolevelone (Sense Sound)

schema sg6a1h_cop
archetype AI_NONE
sg6a1h_3 sg6a1h_1 sg6a1h_2
schema_voice vcop6 2 tolevelone (Sense Sound)

schema sg6a1_w			//TO ALERT 1 +w/co
archetype AI_MINOR
sg6a1_w1 sg6a1_w2
schema_voice vguard6 2 tolevelone (NearbyFriends 0 20)

schema sg6a1_w_cop
archetype AI_MINOR
sg6a1_w3 sg6a1_w1
schema_voice vcop6 2 tolevelone (NearbyFriends 0 20)

schema sg6a1vw			//TO ALERT 1 +sighted +w/co
archetype AI_MINOR
sg6a1vw1 sg6a1vw2 sg6a1vw3 sg6a1vw4
schema_voice vguard6 2 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema sg6a1vw_cop
archetype AI_MINOR
sg6a1vw5 sg6a1vw6 sg6a1vw3 sg6a1vw4
schema_voice vcop6 2 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema sg6a1hw			//TO ALERT 1 +heard +w/co
archetype AI_MINOR
sg6a1hw1 sg6a1hw2 sg6a1hw3 sg6a1hw4
schema_voice vguard6 5 tolevelone (Sense Sound) (NearbyFriends 0 20)

schema sg6a1hw_cop
archetype AI_MINOR
sg6a1hw5 sg6a1hw6 sg6a1hw3 sg6a1hw4
schema_voice vcop6 5 tolevelone (Sense Sound) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg6a1tc			//AT ALERT 1 & 2
archetype AI_NONE
volume -500
delay 4000
mono_loop 8000 20000
sg6a0tc1 sg6a0tc2 sg6a0tc3 
sg6a0th1 sg6a0th2 sg6a0th3
sg6a0co1 sg6a0co2 sg6a0co3 sg6a0co4 sg6a0co5
schema_voice vguard6 1 atlevelone
schema_voice vguard6 1 atleveltwo
schema_voice vcop6 1 atlevelone
schema_voice vcop6 1 atleveltwo

//----------------------------------------------------

schema sg6bak			//BACK TO ALERT 0
archetype AI_NONE
sg6bak_1 sg6bak_2 sg6bak_3 sg6bak_4 sg6bak_5 sg6bak_6 sg6bak_7 
schema_voice vguard6 1 backtozero  

schema sg6bak_cop
archetype AI_NONE
sg6bak_8 sg6bak_9 sg6bak_a sg6bak_b sg6bak_1 sg6bak_2 sg6bak_3 sg6bak_4
schema_voice vcop6 1 backtozero  

//----------------------------------------------------

schema sg6a2			//TO ALERT 2
archetype AI_MINOR
sg6a2__1 sg6a2__2 sg6a2__3 sg6a2__4 sg6a2__5
schema_voice vguard6 1 toleveltwo  

schema sg6a2_cop
archetype AI_MINOR
sg6a2__6 sg6a2__7 sg6a2__8 sg6a2__1 sg6a2__2 sg6a2__3 sg6a1__6 
schema_voice vcop6 2 toleveltwo  
				
schema sg6a2v			//TO ALERT 2 +sighted
archetype AI_MINOR
sg6a2v_1
schema_voice vguard6 1 toleveltwo (Sense Sight)  

schema sg6a2v_cop
archetype AI_MINOR
sg6a2v_2 sg6a2v_1
schema_voice vcop6 2 toleveltwo (Sense Sight)  

schema sg6a2h			//TO ALERT 2 +heard
archetype AI_MINOR
sg6a2h_1 sg6a2h_2
schema1voice vguard6 2 toleveltwo (Sense Sound)

schema sg6a2h_cop
archetype AI_MINOR
sg6a2h_3 sg6a2h_4 sg6a2h_1 sg6a2h_2
schema_voice vcop6 2 toleveltwo (Sense Sound)

//----------------------------------------------------

schema sg6a3			//TO ALERT 3 
archetype AI_MAJOR
sg6a3__1 sg6a3__2 sg6a3__3 sg6a3__4
schema_voice vguard6 1 tolevelthree
schema_voice vcop6  1 tolevelthree

schema sg6a3s			//SPOTTED THE PLAYER 
archetype AI_MORE_MAJOR
sg6a3s_1 sg6a3s_2 sg6a3s_3 sg6a3s_4 
sg6a3na1 sg6a3na4 
schema_voice vguard6 1 spotplayer 

schema sg6a3s_cop
archetype AI_MORE_MAJOR
sg6a3s_5 sg6a3s_6 sg6a3s_7 sg6a3s_8 sg6a3s_1 sg6a3s_2 
sg6a3na5 sg6a3na6 sg6a3na7 sg6a3na1 sg6a3na4 
schema_voice vcop6 2 spotplayer 

schema sg6a3b			//TO ALERT 3 +carrying a body
archetype AI_MORE_MAJOR
sg6a3b_1 
schema_voice vguard6 99 spotplayer (CarryBody True)

schema sg6a3b_cop
archetype AI_MORE_MAJOR
sg6a3b_2
schema_voice vcop6 99 spotplayer (CarryBody True)

schema sg6telr			//TO ALERT 3 +w/co
archetype AI_COMBAT
sg6telr1 sg6telr2 sg6telr3 sg6telr4 sg6telr5
schema_voice vguard6 6 spotplayer (NearbyFriends 0 20)
schema_voice vguard6 1 reacttellrev

schema sg6telr_cop
archetype AI_COMBAT
sg6telr6 sg6telr7 sg6telr8 sg6telr1 sg6telr2 sg6telr3 
schema_voice vcop6 6 spotplayer (NearbyFriends 0 20)
schema_voice vcop6 1 reacttellrev


//----------------------------------------------------

schema sg6at2			//AT ALERT 2 & 3 +Investigating
archetype AI_MINOR
delay 4000
no_repeat
mono_loop 10000 20000
sg6a3se1 sg6a3se2 sg6a3se3 sg6a3se4 sg6a3se5 sg6a3se6 sg6a3se7 sg6a3se8
schema_voice vguard6 99 atleveltwo (Investigate true)
schema_voice vguard6 99 atlevelthree (Investigate true)
schema_voice vcop6 99 atleveltwo (Investigate true)
schema_voice vcop6 99 atlevelthree (Investigate true)

//----------------------------------------------------

schema sg6telc			//RE-SPOTTED PLAYER +w/co
archetype AI_COMBAT
sg6a3na2 sg6a3na3 sg6telc1 sg6telc2 sg6telc3 sg6telc4 sg6telc5 
schema_voice vguard6 50 spotplayer (NearbyFriends 0 20) (Reacquire True) 
schema_voice vguard6 1 reacttellconf

schema sg6telc_cop
archetype AI_COMBAT
sg6telc6 sg6telc7 sg6telc8 sg6a3na2 sg6a3na3 sg6telc1 sg6telc2 sg6telc3 
schema_voice vcop6 99 spotplayer (NearbyFriends 0 20) (Reacquire True) 
schema_voice vcop6 1 reacttellconf

//----------------------------------------------------

schema sg6los			//LOST CONTACT W/PLAYER
archetype AI_NONE
sg6los_1 sg6los_2 sg6los_3 sg6los_4 
schema_voice vguard6 1 lostcontact  

schema sg6los_cop
archetype AI_NONE
sg6los_5 sg6los_6 sg6los_7 sg6los_1 sg6los_2 sg6los_3 
schema_voice vcop6 1 lostcontact  

//----------------------------------------------------

schema sg6chga			//REACT CHARGE
archetype AI_MORE_MAJOR
sg6chga1 sg6chga2 sg6chga4
schema_voice vguard6 1 reactcharge

schema sg6chga_cop
archetype AI_MORE_MAJOR
sg6chga3 sg6chga1 sg6chga2 sg6chga4
schema_voice vcop6 1 reactcharge

schema sg6chgw			//REACT CHARGE +w/co
archetype AI_COMBAT
sg6chgw1 sg6chgw2 sg6chgw3
schema_voice vguard6 3 reactcharge (NearbyFriends 0 20)

schema sg6chgw_cop
archetype AI_COMBAT
sg6chgw4 sg6chgw5 sg6chgw1 sg6chgw2 sg6chgw3
schema_voice vcop6 3 reactcharge (NearbyFriends 0 20)

schema sg6runa			//REACT RUN AWAY
archetype AI_MAJOR
sg6runa1 sg6runa2 sg6runa3 sg6runa4
schema_voice vguard6 1 reactrun 

schema sg6runa_cop
archetype AI_MAJOR
sg6runa5 sg6runa6 sg6runa1 sg6runa2 sg6runa3 sg6runa4
schema_voice vcop6 1 reactrun 

schema sg6alma			//REACT I SOUND ALARMS
archetype AI_MORE_MAJOR
sg6alma1 sg6alma2 sg6alma3
schema_voice vguard6 1 reactalarm

schema sg6alma_cop
archetype AI_MORE_MAJOR
sg6alma4 sg6alma5 sg6alma1
schema_voice vcop6 1 reactalarm

schema sg6almw			//REACT YOU SOUND ALARMS +w/co
archetype AI_COMBAT
sg6almw1 sg6almw2
schema_voice vguard6 3 reactalarm (NearbyFriends 0 20)

schema sg6almw_cop
archetype AI_COMBAT
sg6almw3 sg6almw1 
schema_voice vcop6 6 reactalarm (NearbyFriends 0 20)

//----------------------------------------------------

schema sg6bow			//REACT SHOOT
archetype AI_MORE_MAJOR
no_repeat
sg6atb_1 sg6atb_2 sg6atb_3
schema_voice vguard6 1 reactshoot
schema_voice vcop6 1 reactshoot

schema sg6frust			//FRUSTRATION
archetype AI_MAJOR
sg6frus1 sg6frus2 sg6frus3 sg6frus4
schema_voice vguard6 1 outofreach
schema_voice vcop6 1 outofreach

schema sg6torch			//NOTICED DOUSED TORCH-GASLIGHT
archetype AI_NONE
delay 1000
sg6torc1 sg6torc2
schema_voice vguard6 1 notice (Item Gaslight Torch)
schema_voice vcop6 1 notice (Item Gaslight Torch)

schema sg6getbowman		//RUN & GET A BOWMAN
archetype AI_MAJOR
sg6runa2 sg6runa4
schema_voice vguard6 1 getbowman
schema_voice vcop6 1 getbowman

//----------------------------------------------------

schema sg6bod			//FOUND BODY
archetype AI_MORE_MAJOR
sg6bod_1 sg6bod_2 
schema_voice vguard6 1 foundbody  

schema sg6bod_cop
archetype AI_MORE_MAJOR
sg6bod_3 sg6bod_4 sg6bod_1 sg6bod_2 
schema_voice vcop6 1 foundbody  

schema sg6rob			//FOUND DEAD ROBOT
archetype AI_MORE_MAJOR
sg6rob_1 sg6rob_2
schema_voice vguard6 1 foundrobot  
schema_voice vcop6 1 foundrobot 

schema sg6mis			//FOUND SOMETHING MISSING 
archetype AI_MAJOR
sg6mis_1 sg6mis_2 sg6mis_3 
schema_voice vguard6 1 foundmissing 
schema_voice vguard6 1 notice (Item MissingLoot)

schema sg6mis_cop
archetype AI_MAJOR
sg6mis_4 sg6mis_5 sg6mis_1 sg6mis_2 
schema_voice vcop6 2 foundmissing 
schema_voice vcop6 2 notice (Item MissingLoot)

schema sg6sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
sg6sma_1 sg6sma_2 
schema_voice vguard6 1 foundsmall  
schema_voice vguard6 1 notice (Item Door Generic)

schema sg6sma_cop
archetype AI_MINOR
sg6sma_3 sg6sma_4 sg6sma_1 sg6sma_2 
schema_voice vcop6 1 foundsmall  
schema_voice vcop6 1 notice (Item Door Generic)

schema sg6lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
sg6lar_1 sg6lar_2 
schema_voice vguard6 1 foundlarge

schema sg6lar_cop
archetype AI_MAJOR
sg6lar_3 sg6lar_4 sg6lar_1 
schema_voice vcop6 1 foundlarge

schema sg6sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
sg6sec_1 sg6sec_2 sg6sec_3 sg6sec_4
schema_voice vguard6 1 foundbreach 

schema sg6sec_cop
archetype AI_MORE_MAJOR
sg6sec_5 sg6sec_6 sg6sec_1 sg6sec_2 
schema_voice vcop6 1 foundbreach 

//----------------------------------------------------

schema sg6rint			//RECENTLY SAW THE PLAYER
archetype AI_INFORM
sg6rint1 sg6rint2 sg6rint3
schema_voice vguard6 1 recentintruder 

schema sg6rint_cop
archetype AI_INFORM
sg6rint4 sg6rint1 sg6rint2 sg6rint3
schema_voice vcop6 1 recentintruder 

schema sg6rbod			//RECENTLY FOUND BODY
archetype AI_INFORM
sg6rbod1 sg6rbod2 sg6rbod3
schema_voice vguard6 1 recentbody 

schema sg6rbod
archetype AI_INFORM
sg6rbod4 sg6rbod5 sg6rbod1 sg6rbod2 sg6rbod3
schema_voice vcop6 1 recentbody 

schema sg6rrob			//RECENTLY FOUND DEAD ROBOT
archetype AI_INFORM
sg6rrob1
schema_voice vguard6 1 recentrobot 
schema_voice vcop6 1 recentrobot 

schema sg6rmis			//RECENTLY FOUND MISSING
archetype AI_INFORM
sg6rmis1 sg6rmis2 sg6rmis3 sg6rmis4
schema_voice vguard6 1 recentmissing 

schema sg6rmis_cop
archetype AI_INFORM
sg6rmis4 sg6rmis6 sg6rmis1 sg6rmis2
schema_voice vcop6 2 recentmissing 

schema sg6roth			//RECENTLY FOUND ANAMOLY
archetype AI_INFORM
sg6roth1 sg6roth2 sg6roth3 sg6roth4
schema_voice vguard6 1 recentother 

schema sg6roth_cop
archetype AI_INFORM
sg6roth5 sg6roth6 sg6roth1 sg6roth2
schema_voice vcop6 1 recentother 

//----------------------------------------------------
//COMBAT

schema sg6atn			//ATTACKING +not losing
archetype AI_COMBAT
sg6atn_1 freq 1
sg6atn_2 freq 1
sg6atn_3 freq 2
sg6atn_4 freq 2
sg6atn_5 freq 2
sg6atn_6 freq 2
schema_voice vguard6 1 comattack (ComBal Even)
schema_voice vcop6 1 comattack (ComBal Even)

schema sg6atnw			//ATTACKING	+winning
archetype AI_COMBAT
sg6atw_1 sg6atw_2 sg6atn_3 sg6atn_4 sg6atn_5 sg6atn_6
schema_voice vguard6 2 comattack (ComBal Winning)
schema_voice vcop6 2 comattack (ComBal Winning)

schema sg6atww			//ATTACKING +winning +w/co
archetype AI_COMBAT
sg6atww1 sg6atn_3 sg6atn_4 sg6atn_5 sg6atn_6
schema_voice vguard6 4 comattack (ComBal Winning) (NearbyFriends 0 20)
schema_voice vcop6 4 comattack (ComBal Winning) (NearbyFriends 0 20)

schema sg6atww_cop
archetype AI_COMBAT
sg6atww2 sg6atn_3 sg6atn_4 sg6atn_5 sg6atn_6
schema_voice vcop6 4 comattack (ComBal Winning) (NearbyFriends 0 20)

schema sg6atl			//ATTACKING	+losing
archetype AI_COMBAT
sg6atl_1 sg6atl_2 sg6atl_3 sg6atl_4 sg6atl_5
schema_voice vguard6 2 comattack (ComBal Losing)
schema_voice vcop6 2 comattack (ComBal Losing)

//----------------------------------------------------

schema sg6hit			//HIT THE PLAYER +not losing
archetype AI_COMBAT
sg6hit_1 sg6hit_2 sg6hit_3 sg6hit_4 sg6hit_5
schema_voice vguard6 1 comsucchit (ComBal Winning Even)
schema_voice vcop6 1 comsucchit (ComBal Winning Even)

schema sg6hitw			//HIT THE PLAYER +not losing +w/co
archetype AI_COMBAT
sg6hitw1 sg6hitw2
schema_voice vguard6 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop6 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

schema sg6blk			//BLOCKED THE PLAYER +not losing
archetype AI_COMBAT
sg6blk_1 sg6blk_2 sg6blk_3
schema_voice vguard6 1 comsuccblock (ComBal Winning Even)
schema_voice vcop6 1 comsuccblock (ComBal Winning Even)

schema sg6blkw			//BLOCKED THE PLAYER +not losing +w/co
archetype AI_COMBAT
sg6blkw1
schema_voice vguard6 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop6 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg6hhi			//HIT BY PLAYER W/HI HIT PTS 
archetype AI_MAJOR
sg6hhi_1 sg6hhi_2 sg6hhi_3 sg6hhi_4 sg6hhi_5
schema_voice vguard6 1 comhithigh
schema_voice vguard6 99 comhitnodam (ComBal Losing)
schema_voice vcop6 1 comhithigh
schema_voice vcop6 99 comhitnodam (ComBal Losing)

schema sg6hlo			//HIT BY PLAYER W/LO PTS 
archetype AI_MORE_MAJOR
sg6hlo_1 sg6hlo_2 sg6hlo_3 sg6hlo_4
schema_voice vguard6 1 comhitlow
schema_voice vcop6 1 comhitlow

schema sg6hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
sg6hlow1 sg6hlo_1 sg6hlo_2 sg6hlo_3 sg6hlo_4
schema_voice vguard6 99 comhitlow (NearbyFriends 0 20)
schema_voice vcop6 99 comhitlow (NearbyFriends 0 20)

schema sg6hnd			//HIT BY PLAYER NO DAMAGE +Winning
archetype AI_NONE
sg6hnd_1 sg6hnd_2 
schema_voice vguard6 99 comhitnodam (ComBal Winning)
schema_voice vcop6 99 comhitnodam (ComBal Winning)
schema_voice vguard6 1 comhitnodam 
schema_voice vcop6 1 comhitnodam

schema sg6hnd_e			//HIT BY THE PLAYER NO DAMAGE +Even
archetype AI_NONE
sg6hnde1 sg6hnde2 sg6hnde3
schema_voice vguard6 99 comhitnodam (ComBal Even)
schema_voice vcop6 99 comhitnodam (ComBal Even)
schema_voice vguard6 3 comhitnodam
schema_voice vcop6 3 comhitnodam


//----------------------------------------------------

schema sg6bkd 			//BLOCKED BY PLAYER +not losing
archetype AI_COMBAT
sg6bkd_1 sg6bkd_2 sg6bkd_3
schema_voice vguard6 1 comblocked (ComBal Winning Even)
schema_voice vcop6 1 comblocked (ComBal Winning Even)

schema sg6bkdw 			//BLOCKED BY PLAYER +not losing +w/co
archetype AI_COMBAT
sg6bkdw1
schema_voice vguard6 3 comblocked (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop6 3 comblocked (ComBal Winning Even) (NearbyFriends 0 20)

schema sg6det 			//DETECTED BLOCK +not losing
archetype AI_MORE_MAJOR
sg6det_1 sg6det_2 sg6det_3
schema_voice vguard6 1 comdetblock (ComBal Winning Even)
schema_voice vcop6 1 comdetblock (ComBal Winning Even)

schema sg6detw 			//DETECTED BLOCK  +not losing +w/co
archetype AI_MORE_MAJOR
sg6detw1
schema_voice vguard6 3 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)
schema_voice vcop6 3 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema sg6amb 			//AMBUSHED
archetype AI_MAJOR
sg6amb_1 sg6amb_2 sg6amb_3 sg6amb_4
schema_voice vguard6 1 comhitamb (ComBal Winning Even)
schema_voice vcop6 1 comhitamb (ComBal Winning Even)

schema sg6ambw			//AMBUSHED +w/co
archetype AI_COMBAT
sg6ambw1 sg6ambw2 sg6ambw3
schema_voice vguard6 2 comhitamb (NearbyFriends 0 20)
schema_voice vcop6 2 comhitamb (NearbyFriends 0 20)

schema sg6diea			//DEATH BY AMBUSH
archetype AI_MINOR
volume -500
sg6diea1 sg6diea2 sg6diea3 sg6diea4 sg6diea5
schema_voice vguard6 1 comdiesoft
schema_voice vcop6 1 comdiesoft

schema sg6diec			//DEATH BY COMBAT
archetype AI_COMBAT
sg6diec1 sg6diec2 sg6diec3 
schema_voice vguard6 1 comdieloud
schema_voice vcop6 1 comdieloud

//----------------------------------------------------
//----------------------------------------------------



