//ROBOT 2 COMBATBOT BROADCASTS 

//SEARCHING MODE SNDS	<--ATTACHED TO SEARCHING MOTION
schema rb2search
archetype DEVICE_MISC
no_repeat
volume -1000
rb2srch1 rb2srch2 rb2srch3
env_tag (Event Search) (CreatureType CombatBot)

//FIRING POWERUP	<--ATTACHED TO BEG OF FIRING MOTION
schema rb2powerup
archetype DEVICE_MISC
volume -1
rb2pwup1
env_tag (Event WeaponCharge) (CreatureType CombatBot)



//----------------------------------------------------

schema rb2a0			//AT ALERT 0
archetype AI_NONE
volume -200
delay 3000
mono_loop 15000 30000
rb2a0nz1 rb2a0nz2 rb2a0nz3 rb2a0nz4 rb2a0nz5 rb2a0nz6 rb2a0nz7
rb2a0_01 rb2a0_02 rb2a0_03 rb2a0_04 rb2a0_05 rb2a0_06 rb2a0_07 rb2a0_08 rb2a0_09 rb2a0_010 
schema_voice vcombatbot 1 atlevelzero

schema rb2a0alt	      	//ALERT 0 ALTERNATE
archetype AI_NONE
delay 2000
volume -200
mono_loop 15000 30000
rb2a0nz1 rb2a0nz2 rb2a0nz3 rb2a0nz4 rb2a0nz5 rb2a0nz6 rb2a0nz7
rb2a0_11 rb2a0_12 rb2a0_13 rb2a0_14 rb2a0_15 rb2a0_16 rb2a0_01 rb2a0_02
rb2a0_03 rb2a0_04
schema_voice vcombatbot 1 atlevelzero

//----------------------------------------------------

schema rb2a1			//TO ALERT 1
archetype AI_NONE
volume -1
rb2a1__1 rb2a1__2 rb2a1__3 rb2a1__4 
schema_voice vcombatbot 1 tolevelone  

schema rb2a1v			//TO ALERT 1 +sighted
archetype AI_NONE
volume -1
rb2a1v_1 rb2a1v_2 rb2a1v_3
schema_voice vcombatbot 1 tolevelone (Sense Sight)

schema rb2a1h			//TO ALERT 1 +heard
archetype AI_NONE
volume -1
rb2a1h_1 rb2a1h_2 rb2a1h_3
schema_voice vcombatbot 2 tolevelone (Sense Sound)

schema rb2a1_w			//TO ALERT 1 +w/co
archetype AI_MINOR
volume -1
rb2a1_w1 rb2a1_w2
schema_voice vcombatbot 2 tolevelone (NearbyFriends 0 20)

schema rb2a1vw			//TO ALERT 1 +sighted +w/co
archetype AI_MINOR
volume -1
rb2a1vw1
schema_voice vcombatbot 3 tolevelone (Sense Sight) (NearbyFriends 0 20)

schema rb2a1hw			//TO ALERT 1 +heard +w/co
archetype AI_MINOR
volume -1
rb2a1hw1
schema_voice vcombatbot 3 tolevelone (Sense Sound) (NearbyFriends 0 20)


//----------------------------------------------------

schema rb2a2			//TO ALERT 2
archetype AI_MINOR
volume -1
rb2a2__1 rb2a2__2
schema_voice vcombatbot 1 toleveltwo  

schema rb2a2h			//TO ALERT 2 +heard
archetype AI_MINOR
volume -1
rb2a2h_1 
schema_voice vcombatbot 2 toleveltwo (Sense Sound)

//----------------------------------------------------

schema rb2a3s			//SPOTTED THE PLAYER
archetype AI_MORE_MAJOR
volume -1
rb2a3s_1 rb2a3s_2 rb2a3s_3
rb2a3na1
schema_voice vcombatbot 1 spotplayer 
schema_voice vcombatbot 1 tolevelthree

schema rb2telr			//SPOTTED THE PLAYER +w/co
archetype AI_COMBAT
volume -1
rb2telr1 rb2telc1
schema_voice vcombatbot 5 spotplayer (NearbyFriends 0 20)
schema_voice vcombatbot 1 reacttellrev

schema rb2a3b			//SPOTTED THE PLAYER +body
archetype AI_MORE_MAJOR
volume -1
rb2a3b_1
schema_voice vcombatbot 9 spotplayer (CarryBody True)

//----------------------------------------------------

schema rb2at1			//AT ALERT 1 & 2
archetype AI_NONE
volume -200
mono_loop 2000 10000
rb2a0nz1 rb2a0nz2 rb2a0nz3 rb2a0nz4 rb2a0nz5 rb2a0nz6 rb2a0nz7
schema_voice vcombatbot 1 atlevelone
schema_voice vcombatbot 1 atleveltwo

schema rb2at2			//AT ALERT 2 & 3 +Investigating
archetype AI_MINOR
volume -1
delay 3000
mono_loop 15000 30000
no_repeat
rb2a2se1 rb2a2se2 rb2a2se3 rb2a3se1
schema_voice vcombatbot 99 atleveltwo (Investigate True)
schema_voice vcombatbot 99 atlevelthree (Investigate True)

//----------------------------------------------------

schema rb2chga			//REACT CHARGE
archetype AI_MORE_MAJOR
volume -1
rb2chga1
schema_voice vcombatbot 1 reactcharge

schema rb2chgw			//REACT CHARGE +w/co
archetype AI_COMBAT
volume -1
rb2chgw1
schema_voice vcombatbot 2 reactcharge (NearbyFriends 0 20)

schema rb2runa			//REACT RUN AWAY +alone
archetype AI_MAJOR
volume -1
rb2runa1 rb2alma1 
schema_voice vcombatbot 1 reactrun 
schema_voice vcombatbot 1 getbowman 
schema_voice vcombatbot 1 reactalarm

schema rb2almw			//REACT YOU TO SOUND THE ALARMS +w/co
archetype AI_COMBAT
volume -1
rb2almw1
schema_voice vcombatbot 9 reactalarm (NearbyFriends 0 20)

//----------------------------------------------------

schema rb2bak			//BACK TO ALERT 0
archetype AI_NONE
volume -1
rb2bak_1 rb2bak_2
schema_voice vcombatbot 1 backtozero  

schema rb2los			//LOST CONTACT W/PLAYER
archetype AI_NONE
volume -1
rb2los_1 rb2los_2
schema_voice vcombatbot 1 lostcontact  

schema rb2frust			//FRUSTRATION
archetype AI_MAJOR
volume -1
rb2frus1 rb2frus2
schema_voice vcombatbot 1 outofreach 

//----------------------------------------------------

schema rb2bod			//FOUND BODY	
archetype AI_MORE_MAJOR
volume -1
rb2bod_1
schema_voice vcombatbot 1 foundbody  
schema_voice vcombatbot 1 foundrobot  

schema rb2mis			//FOUND SOMETHING MISSING
archetype AI_MAJOR
volume -1
rb2mis_1 rb2mis_2
schema_voice vcombatbot 1 foundmissing
schema_voice vcombatbot 1 notice (Item MissingLoot)

schema rb2sma			//FOUND A SMALL ANOMALY
archetype AI_MINOR
volume -1
rb2sma_1 rb2sma_2
schema_voice vcombatbot 1 foundsmall  
schema_voice vcombatbot 1 notice (Item Door Generic)

schema rb2lar			//FOUND A LARGE ANOMALY
archetype AI_MAJOR
volume -1
rb2lar_1
schema_voice vcombatbot 1 foundlarge

schema rb2sec			//FOUND A SECURITY BREACH
archetype AI_MORE_MAJOR
volume -1
rb2sec_1
schema_voice vcombatbot 1 foundbreach

//----------------------------------------------------

schema rb2rint			//RECENTLY SAW THE PLAYER +w/co
archetype AI_INFORM
volume -1
rb2rint1 
schema_voice vcombatbot 1 recentintruder 

schema rb2rbod			//RECENTLY FOUND BODY +w/co
archetype AI_INFORM
volume -1
rb2rbod1  
schema_voice vcombatbot 1 recentbody 

schema rb2rmis			//RECENTLY FOUND MISSING +w/co
archetype AI_INFORM
volume -1
rb2rmis1
schema_voice vcombatbot 1 recentmissing 

schema rb2roth			//RECENTLY FOUND MISC ANAMOLY +w/co
archetype AI_INFORM
volume -1
rb2roth1
schema_voice vcombatbot 1 recentother 
schema_voice vcombatbot 1 recentrobot 

//----------------------------------------------------

//COMBAT
schema rb2atn			//ATTACKING +not losing
archetype AI_COMBAT
volume -1
rb2atn_1 rb2atn_2 rb2atn_3 rb2atn_4 rb2atw_1 rb2atl_1
schema_voice vcombatbot 1 comattack
schema_voice vcombatbot 1 reactshoot

schema rb2atww			//ATTACKING +winning +w/co
archetype AI_COMBAT
volume -1
rb2atww1 rb2atw_1 rb2atn_1 rb2atn_2 rb2atn_3 rb2atn_4
schema_voice vcombatbot 5 comattack (NearbyFriends 0 20)
schema_voice vcombatbot 5 reactshoot (NearbyFriends 0 20)

//----------------------------------------------------

schema rb2hit			//HIT THE PLAYER
archetype AI_COMBAT
volume -1
rb2hit_1
schema_voice vcombatbot 1 comsucchit

schema rb2hitw			//HIT THE PLAYER +w/co
archetype AI_COMBAT
volume -1
rb2hitw1 rb2hitw2
schema_voice vcombatbot 2 comsucchit (NearbyFriends 0 20)

schema rb2blk			//BLOCKED THE PLAYER
archetype AI_COMBAT
volume -1
rb2blk_1
schema_voice vcombatbot 1 comsuccblock 

schema rb2blkw			//BLOCKED THE PLAYER +w/co
archetype AI_COMBAT
volume -1
rb2blkw1
schema_voice vcombatbot 2 comsuccblock (NearbyFriends 0 20)

//----------------------------------------------------

schema rb2hhi			//HIT BY PLAYER W/HI HIT PTS 
archetype AI_MAJOR
volume -1
rb2hhi_1 rb2hhi_2 rb2hhi_3 rb2hlo_1 rb2hlo_2
schema_voice vcombatbot 1 comhithigh
schema_voice vcombatbot 1 comhitlow

schema rb2hlow			//HIT BY PLAYER W/LO PTS  +w/co
archetype AI_COMBAT
volume -1
rb2hlow1
schema_voice vcombatbot 1 comhitlow (NearbyFriends 0 20)

schema rb2hnd			//HIT BY PLAYER NO DAMAGE +Winning
archetype AI_MAJOR
volume -1
rb2hnd_1
schema_voice vcombatbot 1 comhitnodam

//----------------------------------------------------

schema rb2amb 		//AMBUSHED
archetype AI_MAJOR 
volume -1
rb2amb_1 
schema_voice vcombatbot 1 comhitamb

schema rb2ambw		//AMBUSHED +w/co
archetype AI_COMBAT
volume -1
rb2ambw1
schema_voice vcombatbot 2 comhitamb (NearbyFriends 0 20)

schema rb2die		//DEATH
archetype AI_MINOR
volume -1
rb2die_1 rb2die_2 rb2die_3
env_tag (event Death) (CreatureType CombatBot)


//----------------------------------------------------
//----------------------------------------------------