//MASKED SLAVE BROADCASTS 

//----------------------------------------------------

schema ms1a0			//AT ALERT 0
archetype AI_NONE
volume -750
poly_loop 2 6000 15000
ms1a0wh1 ms1a0wh2 ms1a0wh3 ms1a0wh4 ms1a0wh5 ms1a0wh6 ms1a0wh7 ms1a0wh8 ms1a0wh9 ms1a0wh0 ms1a0whA ms1a0whB ms1a0whC
schema_voice vslave 1 atlevelzero


//----------------------------------------------------

schema ms1a1			//TO ALERT 1
archetype AI_NONE
volume -500
ms1a1__1 ms1a1__2 ms1a1__3 ms1a1__4 ms1a1__5 ms1a1__6 ms1a1__7 ms1a1__8
schema_voice vslave 1 tolevelone  

schema ms1a1v			//TO ALERT 1 +sighted
archetype AI_NONE
volume -500
ms1a1v_1 ms1a1v_2 ms1a1v_3 ms1a1v_4
schema_voice vslave 1 tolevelone (Sense Sight)

schema ms1a1h			//TO ALERT 1 +heard
archetype AI_NONE
volume -500
ms1a1h_1 ms1a1h_2 ms1a1h_3 ms1a1h_4
schema_voice vslave 2 tolevelone (Sense Sound)

//----------------------------------------------------

schema ms1a2			//TO ALERT 2
archetype AI_MINOR
volume -500
ms1a2__1 ms1a2__2 ms1a2__3 ms1a2__4 ms1a2__5 ms1a2__6 ms1a2__7
schema_voice vslave 1 toleveltwo  

//----------------------------------------------------

schema ms1a3s			//TO ALERT 3
archetype AI_MORE_MAJOR
volume -500
ms1a3s_1 ms1a3s_2 ms1a3s_3 ms1a3s_4 ms1a3s_5 ms1a3s_6 ms1a3s_7 ms1a3s_8
schema_voice vslave 1 spotplayer 
schema_voice vslave 1 tolevelthree

schema ms1telr			//SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
volume -500
ms1telc1 ms1telc2 ms1telc3 ms1telc4
schema_voice vslave 5 spotplayer (NearbyFriends 0 20)

schema ms1a3b			//SPOTTED THE PLAYER +body
archetype AI_MORE_MAJOR
volume -500
ms1a3b_1 ms1a3b_2
schema_voice vslave 9 spotplayer (CarryBody True)
//----------------------------------------------------

schema ms1at1			//AT ALERT 1 & 2
archetype AI_NONE
volume -500
poly_loop 2 3000 5000
ms1a0br1 ms1a0br2 ms1a0br3 ms1a0br4 ms1a0br5 ms1a0br6 ms1a0br7 ms1a0br8 ms1a0br9 ms1a0brA ms1a0brB ms1a0brC ms1a0brD
schema_voice vslave 1 atlevelone
schema_voice vslave 1 atleveltwo
schema_voice vslave 1 atlevelthree

schema ms1at2			//AT ALERT 2 & 3 +Investigating
archetype AI_MINOR
delay 2000
volume -500
poly_loop 2 3000 5000
no_repeat
ms1a3se1 freq 1
ms1a3se2 freq 1
ms1a3se3 freq 1
ms1a3se4 freq 1
ms1a3se5 freq 1
ms1a3se6 freq 1
ms1a3se7 freq 1
ms1a3se8 freq 1
ms1a0br1 freq 2
ms1a0br2 freq 2
ms1a0br3 freq 2
ms1a0br4 freq 2
ms1a0br5 freq 2
ms1a0br6 freq 2
ms1a0br7 freq 2
ms1a0br8 freq 2
ms1a0br9 freq 2
ms1a0brA freq 2
ms1a0brB freq 2
ms1a0brC freq 2
schema_voice vslave 99 atleveltwo (Investigate True)
schema_voice vslave 99 atlevelthree (Investigate True)

//----------------------------------------------------

schema ms1chga			//REACT CHARGE
archetype AI_MORE_MAJOR
volume -500
ms1chga1 ms1chga2
schema_voice vslave 1 reactcharge

schema ms1runa			//REACT RUN AWAY +alone
archetype AI_MAJOR
volume -500
ms1run_1 ms1run_2 ms1run_3 ms1run_4 ms1run_5 ms1run_6 ms1run_7 ms1run_8 ms1run_9 ms1run10 ms1run11 ms1run12
schema_voice vslave 1 reactrun 

schema ms1alma			//REACT I SOUND THE ALARMS
archetype AI_MORE_MAJOR
volume -500
ms1almw1 ms1almw2
schema_voice vslave 1 reactalarm

//----------------------------------------------------

schema ms1bak			//BACK TO ALERT 0
archetype AI_NONE
volume -500
ms1bak_1 ms1bak_2 ms1bak_3 ms1bak_4 ms1bak_5 ms1bak_6 ms1bak_7 ms1bak_8 ms1bak_9 ms1bak10 ms1bak11 ms1bak12 ms1bak13 ms1bak14
schema_voice vslave 1 backtozero  

schema ms1los			//LOST CONTACT W/PLAYER
archetype AI_NONE
volume -500
ms1los_1 ms1los_2 ms1los_3
schema_voice vslave 1 lostcontact  

schema ms1frust			//FRUSTRATION
archetype AI_MAJOR
volume -500
ms1los_2 ms1rint3 ms1rint5
schema_voice vslave 1 outofreach 

//----------------------------------------------------

schema ms1bod			//FOUND BODY	
archetype AI_MORE_MAJOR
volume -500
ms1bod_1 ms1bod_2 ms1bod_3 ms1bod_4 ms1bod_5 ms1bod_6 ms1bod_7 ms1bod_8
schema_voice vslave 1 foundbody  

schema ms1mis			//FOUND SOMETHING MISSING
archetype AI_MAJOR
volume -500
ms1mis_1 ms1mis_2 ms1mis_3 ms1mis_4 ms1mis_5 ms1mis_6
schema_voice vslave 1 foundmissing
schema_voice vslave 1 notice (Item MissingLoot)

schema ms1sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
volume -500
ms1sma_1 ms1sma_2 ms1sma_3 ms1sma_4
schema_voice vslave 1 foundsmall  
schema_voice vslave 1 notice (Item Door Generic)

schema ms1lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
volume -500
ms1lar_1 ms1lar_2 ms1lar_3 ms1lar_4
schema_voice vslave 1 foundlarge

schema ms1sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
volume -500
ms1sec_1 ms1sec_2 ms1sec_3 ms1sec_4
schema_voice vslave 1 foundbreach

schema ms1rob			//FOUND DEAD ROBOT	
archetype AI_MAJOR
volume -500
ms1bod_1 ms1bod_2
schema_voice vslave 1 foundrobot  

//----------------------------------------------------

schema ms1rint			//RECENTLY SAW THE PLAYER +w/co
archetype AI_INFORM
volume -1
ms1rint1 ms1rint2 ms1rint3 ms1rint4 ms1rint5 ms1rint6
schema_voice vslave 1 recentintruder 

schema ms1rbod			//RECENTLY FOUND BODY +w/co
archetype AI_INFORM
volume -1
ms1rbod1 ms1rbod2
schema_voice vslave 1 recentbody 

schema ms1rmis			//RECENTLY FOUND MISSING +w/co
archetype AI_INFORM
volume -1
ms1rmis1 ms1rmis2 ms1rmis3 ms1rmis4
schema_voice vslave 1 recentmissing 

schema ms1roth			//RECENTLY FOUND MISC ANAMOLY +w/co
archetype AI_INFORM
volume -1
ms1roth1 ms1roth2 ms1roth3 ms1roth4
schema_voice vslave 1 recentother 

schema ms1rrob			//RECENTLY FOUND DEAD ROBOT +w/co
archetype AI_INFORM
volume -1
ms1rbod_1
schema_voice vslave 1 recentrobot 

//----------------------------------------------------

//COMBAT
schema ms1atn			//ATTACKING +not losing
archetype AI_COMBAT
volume -500
ms1atn_1 freq 1
ms1atn_2 freq 1
ms1atn_3 freq 2
ms1atn_4 freq 2
ms1atn_5 freq 2
ms1atn_6 freq 2
schema_voice vslave 1 comattack (ComBal Winning Even)

schema ms1atww			//ATTACKING +winning +w/co
archetype AI_COMBAT
volume -1
ms1atww1 ms1atww2
schema_voice vslave 2 comattack (ComBal Winning) (NearbyFriends 0 20)

schema ms1atl			//ATTACKING +losing
archetype AI_COMBAT
volume -500
ms1atl_1 ms1atl_2 ms1atn_3 ms1atn_4 ms1atn_5 ms1atn_6
schema_voice vslave 1 comattack (ComBal Losing)

//----------------------------------------------------

schema ms1hit			//HIT THE PLAYER
archetype AI_COMBAT
volume -500
ms1hit_1 ms1hit_2
schema_voice vslave 1 comsucchit (ComBal Winning Even)

schema ms1blk			//BLOCKED THE PLAYER
archetype AI_COMBAT
volume -500
ms1blk_1 ms1blk_2 
schema_voice vslave 1 comsuccblock (ComBal Winning Even)

schema ms1blkw			//BLOCKED THE PLAYER +w/co
archetype AI_COMBAT
volume -1
ms1blkw1
schema_voice vslave 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema ms1hhi			//HIT BY PLAYER W/HI HIT PTS 
archetype AI_MAJOR
volume -500
ms1hhi_1 ms1hhi_2 ms1hhi_3 ms1hhi_4 ms1hhi_5 ms1atn_3 ms1atn_4
schema_voice vslave 1 comhithigh
schema_voice vslave 1 comhitnodam (ComBal Losing)

schema ms1hlo			//HIT BY PLAYER W/LO PTS 
archetype AI_MORE_MAJOR
volume -500
ms1hlo_1 ms1hlo_2 ms1hlo_3 ms1hhi_4 ms1hhi_5
schema_voice vslave 1 comhitlow

schema ms1hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
volume -1
ms1hlow1
schema_voice vslave 1 comhitlow (NearbyFriends 0 20)

schema ms1hnd			//HIT BY PLAYER NO DAMAGE +Winning
archetype AI_MAJOR
volume -500
ms1hnd_1 ms1hnd_2 ms1hnd_3
schema_voice vslave 1 comhitnodam

//----------------------------------------------------

schema ms1bkd 			//BLOCKED BY PLAYER
archetype AI_COMBAT
volume -500
ms1bkd_1 ms1bkd_2
schema_voice vslave 1 comblocked (ComBal Winning Even)

schema ms1bkdw 			//BLOCKED BY THE PLAYER +w/co
archetype AI_COMBAT
volume -1
ms1bkdw1
schema_voice vslave 2 comblocked (ComBal Winning Even) (NearbyFriends 0 20)

schema ms1det 			//DETECTED BLOCK
archetype AI_COMBAT
volume -500
ms1det_1 ms1det_2
schema_voice vslave 1 comdetblock (ComBal Winning Even)

schema ms1detw 			//DETECTED BLOCK +w/co
archetype AI_COMBAT
volume -1
ms1detw1
schema_voice vslave 2 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)

//----------------------------------------------------

schema ms1amb 		//AMBUSHED
archetype AI_MAJOR 
volume -500
ms1amb_1 ms1amb_2 ms1amb_3 ms1amb_4
schema_voice vslave 1 comhitamb

schema ms1ambw		//AMBUSHED +w/co
archetype AI_COMBAT
volume -1
ms1ambw1 ms1ambw2 ms1ambw3
schema_voice vslave 2 comhitamb (NearbyFriends 0 20)

schema ms1diea		//SOFT DEATH
archetype AI_MINOR
volume -500
ms1diea1 ms1diea2 ms1diea3 ms1diea4
schema_voice vslave 1 comdiesoft

schema ms1diec		//LOUD DEATH
archetype AI_COMBAT
volume -500
ms1diec1 ms1diec2 ms1diec3 ms1diec4 
schema_voice vslave 1 comdieloud

//----------------------------------------------------
//----------------------------------------------------

