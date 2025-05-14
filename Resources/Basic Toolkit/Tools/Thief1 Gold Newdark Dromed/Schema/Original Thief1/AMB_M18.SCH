//OUTTAKES MISSION 18


//TOILET
schema flush_toilet
archetype DEVICES
volume -800
toilet
env_tag (Event StateChange) (MachType Toilet) (DirectionState Reverse)

//FAKE WIND ENVIRONMENT
schema m18wind
archetype AMB_M02
delay 2000
poly_loop 2 3500 4000
pan_range 2500
volume -1400  
fakwind1 fakwind2 fakwind3 fakwind4 fakwind5

//FAKE WIND OBJECT
schema m18windobj
archetype AMB_M02
poly_loop 2 3500 4000
volume -1400  
fakwind1 fakwind2 fakwind3 fakwind4 fakwind5


/////////////
//AI SPEECH//
/////////////


//LITTLE GUARD IN MISS 18




//AT ALERT 0
schema ss1a0
archetype AI_NONE
volume -500
mono_loop 1000 8000
ss1a0hu1 ss1a0hu2 ss1a0hu3 ss1a0dr1 ss1a0dr2 ss1a0dr3 ss1a0co1 ss1a0co2 ss1a0co3 
schema_voice vshrimp 1 atlevelzero

//TO ALERT 1
schema ss1a1
archetype AI_NONE
ss1a1__1 ss1a1__2 ss1h_2
schema_voice vshrimp 1 tolevelone 

//		+w/co
schema ss1a1_w
archetype AI_MINOR
ss1a1_w1 ss1a1hw3 ss1a1vw1 ss1a1vw2
schema_voice vshrimp 2 tolevelone (NearbyFriends 0 20)

//AT ALERT 1, 2 & 3
schema ss1at1
archetype AI_NONE
delay 5000
volume -500
mono_loop 1000 8000
ss1a0hu1 ss1a0hu2 ss1a0hu3 ss1a0dr1 ss1a0dr2 ss1a0dr3 ss1a0co1 ss1a0co2 ss1a0co3 
schema_voice vshrimp 1 atlevelone 
schema_voice vshrimp 1 atleveltwo 
schema_voice vshrimp 1 atlevelthree

//BACK TO ALERT 0
schema ss1bak
archetype AI_NONE
ss1bak_2 ss1bak_6 ss1bak_8 
schema_voice vshrimp 1 backtozero 


//TO ALERT 2
schema ss1a2
archetype AI_MINOR
ss1a2__1 ss1a2__5 ss1a2h_2 ss1wrn11
schema_voice vshrimp 1 toleveltwo  

//AT ALERT 2 +Investigating
schema ss1at2se
archetype AI_MINOR
delay 3000
mono_loop 4000 10000
no_repeat
ss1a2se2 ss1a2se3 ss1a2se4 ss1a3se2 ss1a3se3 ss1a3se4 
schema_voice vshrimp 99 atleveltwo (Investigate True)


//SPOTTED THE PLAYER
schema ss1a3s
archetype AI_MORE_MAJOR
ss1a3dr1 ss1a3na3 ss1a3s_1 ss1a3s_2 ss1a3s_3
schema_voice vshrimp 1 spotplayer
schema_voice vshrimp 1 tolevelthree

//		+w/co
schema ss1telr
archetype AI_COMBAT
ss1telr3 
schema_voice vshrimp 3 spotplayer (NearbyFriends 0 20) 


//LOST CONTACT W/PLAYER
schema ss1los
archetype AI_NONE
ss1los_3
schema_voice vshrimp 1 lostcontact  


//RE-SPOTTED THE PLAYER +w/co -All except THIEVE's
schema ss1telc
archetype AI_COMBAT
ss1telc3
schema_voice vshrimp 5 spotplayer (NearbyFriends 0 20) (Reacquire True) 


//REACT 1ST WARNING
schema ss1warn1
archetype AI_NONE
ss1wrn11
schema_voice vshrimp 1 reactwarn


//REACT ATTACK AFTER FINAL WARNING
schema ss1warnf
archetype AI_MAJOR
ss1wrnf1
schema_voice vshrimp 9 reactcharge (Reiterate 9 9)


//REACT CHARGE +alone
schema ss1chga
archetype AI_MORE_MAJOR
ss1chga1 ss1chgw2 ss1wrnf1
schema_voice vshrimp 1 reactcharge


//		+w/co -All except THIEVE's
schema ss1chgw
archetype AI_COMBAT
ss1chgw1 ss1chgw2 ss1chgw3 ss1chgw4
schema_voice vshrimp 2 reactcharge (NearbyFriends 0 20)

//REACT GET READY TO FIRE YOUR BOW
schema ss1bow
archetype AI_MORE_MAJOR
no_repeat
ss1atb_3 ss1atn_1
schema_voice vshrimp 1 reactshoot


//REACT RUN AWAY -All except THIEVE's
schema ss1runa
archetype AI_MAJOR
ss1runa1 ss1runa3
schema_voice vshrimp 1 reactrun
schema_voice vshrimp 1 reactalarm 


//FRUSTRATION
schema ss1frust
archetype AI_MAJOR
ss1det_2 ss1runa3 ss1a3s_3 ss1a3se3
schema_voice vshrimp 1 outofreach


//FOUND A BODY
schema ss1bod
archetype AI_MAJOR
ss1bod_2
schema_voice vshrimp 2 foundbody

//FOUND SOMETHING MISSING
schema ss1mis
archetype AI_MAJOR
ss1mis_1 
schema_voice vshrimp 2 foundmissing


//FOUND A SMALL ANOMALY
schema ss1sma
archetype AI_MINOR
ss1sma_2 ss1lar_3
schema_voice vshrimp 1 foundsmall 
schema_voice vshrimp 1 foundlarge


//FOUND A SECURITY BREACH -All except THIEVE's
schema ss1sec
archetype AI_MORE_MAJOR
ss1sec_1 
schema_voice vshrimp 1 foundbreach 

//RECENTLY SAW THE PLAYER +w/co -All except THIEVE's
schema ss1rint
archetype AI_INFORM
ss1rint2
schema_voice vshrimp 1 recentintruder

//RECENTLY FOUND BODY +w/co
schema ss1rbod
archetype AI_INFORM
ss1rbod1
schema_voice vshrimp 1 recentbody 



//RECENTLY FOUND SOMETHING MISSING +w/co 
schema ss1rmis
archetype AI_INFORM
ss1rmis1 
schema_voice vshrimp 1 recentmissing 


//RECENTLY FOUND MISC ANAMOLY +w/co -All except THIEVE's
schema ss1roth
archetype AI_INFORM
ss1roth4
schema_voice vshrimp 1 recentother



//COMBAT

//ATTACKING +not losing
schema ss1atn
archetype AI_COMBAT
ss1atn_1 ss1atn_2 ss1atn_3 ss1atn_4 ss1atn_5 ss1atn_6 
schema_voice vshrimp 1 comattack (ComBal Winning Even)

//		+losing
schema ss1atl
archetype AI_COMBAT
ss1atl_1 ss1atl_2 ss1atl_3 
schema_voice vshrimp 5 comattack (ComBal Losing)


//SUCCESSFULLY HIT THE PLAYER +not losing
schema ss1hit
archetype AI_COMBAT
ss1hit_2 ss1hitw1
schema_voice vshrimp 1 comsucchit (ComBal Winning Even)


//SUCCESSFULLY BLOCKED THE PLAYER +not losing
schema ss1blk
archetype AI_COMBAT
ss1blk_2
schema_voice vshrimp 1 comsuccblock (ComBal Winning Even)


//HIT BY THE PLAYER W/HI HIT PTS 
schema ss1hhi
archetype AI_MAJOR
ss1hhi_1 ss1hhi_2 ss1hhi_3
schema_voice vshrimp 1 comhithigh

//HIT BY THE PLAYER W/LO PTS 
schema ss1hlo
archetype AI_MORE_MAJOR
ss1hlo_2 ss1hlo_4
schema_voice vshrimp 1 comhitlow

//		+w/co
schema ss1hlow
archetype AI_COMBAT
ss1hlow1
schema_voice vshrimp 2 comhitlow (NearbyFriends 0 20)


//HIT BY THE PLAYER NO DAMAGE
schema ss1hnd
archetype AI_MAJOR
ss1hnd_1
schema_voice vshrimp 1 comhitnodam


//BLOCKED BY THE PLAYER +not losing
schema ss1bkd 
archetype AI_COMBAT
ss1bkd_2
schema_voice vshrimp 1 comblocked 


//DETECTED PLAYER TRYING TO BLOCK +not losing
schema ss1det 
archetype AI_COMBAT
ss1det_2
schema_voice vshrimp 1 comdetblock

//		+not losing +w/co
schema ss1detw 
archetype AI_COMBAT
ss1detw1
schema_voice vshrimp 5 comdetblock (NearbyFriends 0 20)



//AMBUSHED -HIT BY UNSEEN PLAYER
schema ss1amb 
archetype AI_MAJOR
ss1amb_4 ss1ambw2
schema_voice vshrimp 1 comhitamb




//DEATH BY COMBAT -LOUD
schema ss1diec
archetype AI_COMBAT
ss1diec1
schema_voice vshrimp 1 comdieloud


//DEATH (or knocked out)BY AMBUSH -MORE MUFFLED
schema ss1diea
archetype AI_MINOR
volume -500
ss1diea3
schema_voice vshrimp 1 comdiesoft



