//HAMMER 2 BROADCASTS -Geoff Stewart

//SLEEPING
schema hm2a0sn
archetype AI_NONE
volume -500
mono_loop 2000 3000
hm2a0sn1 hm2a0sn2 hm2a0sn3
schema_voice hammer2 1 sleeping

//AT ALERT 0 MORE REPEATABLE
schema hm2a0
archetype AI_NONE
volume -500
mono_loop 7500 10000
hm2a0co1 hm2a0co2 hm2a0co3
hm2a0hu1 hm2a0hu2 hm2a0hu3
hm2a0th1 hm2a0th2 hm2a0th3
hm2a0wh1 hm2a0wh2 hm2a0wh3
schema_voice hammer2 3 atlevelzero

//AT ALERT 0 LESS REPEATABLE
schema hm2a0ch
archetype AI_NONE
volume -1000
mono_loop 7500 10000
hm2a0ch1 hm2a0ch2 hm2a0ch3
hm2a0mu1 hm2a0mu2 hm2a0mu3
schema_voice hammer2 1 atlevelzero

//TO ALERT 1
schema hm2a1
archetype AI_NONE
hm2a1__1 hm2a1__2 hm2a1__3 hm2a1__4 
schema_voice hammer2 1 tolevelone  

//TO ALERT 1 +sighted
schema hm2a1v
archetype AI_NONE
hm2a1v_1
schema_voice hammer2 1 tolevelone (Sense Sight)

//TO ALERT 1 +heard
schema hm2a1h
archetype AI_NONE
hm2a1h_1 hm2a1h_2
schema_voice hammer2 2 tolevelone (Sense Sound)

//TO ALERT 1 +w/co
schema hm2a1_w
archetype AI_MINOR
hm2a1_w1
schema_voice hammer2 2 tolevelone (NearbyFriends 0 20)

//TO ALERT 1 +sighted +w/co
schema hm2a1vw
archetype AI_MINOR
hm2a1vw1 hm2a1vw2 hm2a1vw3
schema_voice hammer2 3 tolevelone (Sense Sight) (NearbyFriends 0 20)

//TO ALERT 1 +heard +w/co
schema hm2a1hw
archetype AI_MINOR
hm2a1hw1 hm2a1hw2 hm2a1hw3
schema_voice hammer2 3 tolevelone (Sense Sound) (NearbyFriends 0 20)

//TO ALERT 2
schema hm2a2
archetype AI_MINOR
hm2a2__1 hm2a2__2 hm2a2__3 hm2a2__4
schema_voice hammer2 1 toleveltwo  

//TO ALERT 2 +sighted
schema hm2a2v
archetype AI_MINOR
hm2a2v_1
schema_voice hammer2 1 toleveltwo (Sense Sight)  

//TO ALERT 2 +heard
schema hm2a2h
archetype AI_MINOR
hm2a2h_1 hm2a2h_2
schema_voice hammer2 2 toleveltwo (Sense Sound)

//TO ALERT 3
schema hm2a3
archetype AI_MAJOR
Hm2a3na3
schema_voice hammer2 1 tolevelthree

//AT ALERT 1
schema hm2at1
archetype AI_NONE
delay 5000
mono_loop 5000 10000
Hm2a0ch1 Hm2a0ch3 Hm2a0ch3
schema_voice hammer2 1 atlevelone

//AT ALERT 2
schema hm2at2
archetype AI_MINOR
delay 4500
no_repeat
mono_loop 10000 30000
hm2a2se1 hm2a2se2 hm2a2se3 hm2a2se4
schema_voice hammer2 99 atleveltwo (Investigate True)

//AT ALERT 3
schema hm2at3
archetype AI_MAJOR
delay 4500
no_repeat
mono_loop 15000 30000
hm2a3se1 hm2a3se2 hm2a3se3 hm2a3se4
schema_voice hammer2 99 atlevelthree (Investigate True)

//SPOTTED THE PLAYER +startled
schema hm2a3s
archetype AI_MORE_MAJOR
hm2a3s_1 hm2a3s_2 hm2a3s_3 
schema_voice hammer2 1 spotplayer 

//SPOTTED THE PLAYER +not startled +alone
schema hm2a3na
archetype AI_MORE_MAJOR
hm2a3na1 hm2a3na2 hm2a3na3 
schema_voice hammer2 1 spotplayer 

//SPOTTED THE PLAYER +carrying a body
schema hm2a3b
archetype AI_MORE_MAJOR
hm2a3b_1 hm2a3b_2 
schema_voice hammer2 9 spotplayer (CarryBody True)

//REACT CHARGE +alone
schema hm2chga
archetype AI_MORE_MAJOR
hm2chga1 hm2chga2 
schema_voice hammer2 1 reactcharge

//REACT CHARGE +w/co
schema hm2chgw
archetype AI_COMBAT
hm2chgw1 hm2chgw2 hm2chgw3
schema_voice hammer2 2 reactcharge (NearbyFriends 0 20)

//REACT RUN AWAY +alone
schema hm2runa
archetype AI_MAJOR
hm2runa1 hm2runa2 hm2runa3
schema_voice hammer2 1 reactrun

//REACT I SOUND THE ALARMS +alone
schema hm2alma
archetype AI_MORE_MAJOR
hm2alma1 hm2alma2 hm2alma3
schema_voice hammer2 1 reactalarm 

//REACT I TELL YOU TO SOUND THE ALARMS +w/co
schema hm2almw
archetype AI_COMBAT
hm2almw1
schema_voice hammer2 9 reactalarm (NearbyFriends 0 20)

//REACT TELL FRIEND BY REVELATION +w/co
schema hm2telr
archetype AI_COMBAT
hm2telr1 hm2telr2 hm2telr3 hm2telr4
schema_voice hammer2 5 spotplayer (NearbyFriends 0 20)

//REACT TELL FRIEND BY CONFIRMATION +w/co
schema hm2telc
archetype AI_COMBAT
hm2telc1 hm2telc2 hm2telc3
schema_voice hammer2 5 spotplayer (NearbyFriends 0 20) (Reacquire true)

//BACK TO ALERT 0
schema hm2bak
archetype AI_NONE
hm2bak_1 hm2bak_2 hm2bak_3 hm2bak_4
hm2bak_5 hm2bak_6 
schema_voice hammer2 1 backtozero  

//LOST CONTACT W/PLAYER
schema hm2los
archetype AI_NONE
hm2los_1 hm2los_2 hm2los_3
schema_voice hammer2 1 lostcontact  

//FRUSTRATION
schema hm2frust
archetype AI_MAJOR
hm2a3se2 hm2amb_3 hm2bkd_1 hm2bkd_2
schema_voice hammer2 1 outofreach  

//FOUND BODY
schema hm2bod
archetype AI_MORE_MAJOR
hm2bod_1 hm2bod_2 hm2bod_3
schema_voice hammer2 1 foundbody  

//FOUND SOMETHING MISSING
schema hm2mis
archetype AI_MAJOR
hm2mis_1 hm2mis_2
schema_voice hammer2 1 foundmissing

//NOTICED A TORCH BEING DOUSED
schema hm2torch
archetype AI_MINOR
delay 1000
Hm2a1__4 Hm2a1__2
schema_voice hammer2 1 noticetorch

//FOUND A SMALL ANOMALY
schema hm2sma
archetype AI_MAJOR
hm2sma_1 hm2sma_2
schema_voice hammer2 1 foundsmall  

//FOUND A LARGE ANOMALY
schema hm2lar
archetype AI_MAJOR
hm2lar_1 hm2lar_2
schema_voice hammer2 1 foundlarge

//FOUND A SECURITY BREACH
schema hm2sec
archetype AI_MORE_MAJOR
hm2sec_1 hm2sec_2 hm2sec_3
schema_voice hammer2 1 foundbreach

//RECENTLY SAW THE PLAYER +w/co
schema hm2rint
archetype AI_INFORM
hm2rint1 hm2rint2 hm2rint3
schema_voice hammer2 1 recentintruder 

//RECENTLY FOUND BODY +w/co
schema hm2rbod
archetype AI_INFORM
hm2rbod1 hm2rbod2 
schema_voice hammer2 1 recentbody 

//RECENTLY FOUND SOMETHING MISSING +w/co
schema hm2rmis
archetype AI_INFORM
hm2rmis2 
schema_voice hammer2 1 recentmissing 

//RECENTLY FOUND MISC ANAMOLY +w/co
schema hm2roth
archetype AI_INFORM
hm2roth1 hm2roth2 hm2roth3
schema_voice hammer2 1 recentother 

//COMBAT

//ATTACKING +not losing
schema hm2atn
archetype AI_COMBAT
hm2atn_1 freq 1
hm2atn_2 freq 1
hm2atn_3 freq 6
hm2atn_4 freq 6
hm2atn_5 freq 6
hm2atn_6 freq 1
hm2atn_7 freq 1
hm2atn_8 freq 1
hm2atn_9 freq 1
schema_voice hammer2 1 comattack (ComBal Winning Even)

//ATTACKING +winning
schema hm2atnw
archetype AI_COMBAT
hm2atw_1 hm2atw_1
schema_voice hammer2 3 comattack (ComBal Winning)

//ATTACKING +winning +w/co
schema hm2atww
archetype AI_COMBAT
hm2atww1 
schema_voice hammer2 4 comattack (ComBal Winning) (NearbyFriends 0 20)

//ATTACKING +losing
schema hm2atl
archetype AI_COMBAT
hm2atl_1 freq 1
hm2atl_2 freq 1
hm2atl_3 freq 2
hm2atl_4 freq 2
hm2atl_5 freq 2
schema_voice hammer2 1 comattack (ComBal Losing)

//SUCCESSFULLY HIT THE PLAYER +not losing
schema hm2hit
archetype AI_COMBAT
hm2hit_1 hm2hit_2 hm2hit_3 hm2hit_4
schema_voice hammer2 1 comsucchit (ComBal Winning Even)

//SUCCESSFULLY HIT THE PLAYER +not losing +w/co
schema hm2hit
archetype AI_COMBAT
hm2hitw1 hm2hitw2
schema_voice hammer2 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

//SUCCESSFULLY BLOCKED THE PLAYER +not losing
schema hm2blk
archetype AI_COMBAT
hm2blk_1 hm2blk_2 hm2blk_3
schema_voice hammer2 1 comsuccblock (ComBal Winning Even)

//SUCCESSFULLY BLOCKED THE PLAYER +not losing +w/co
schema hm2blkw
archetype AI_COMBAT
hm2blkw1
schema_voice hammer2 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)

//HIT BY THE PLAYER W/HI HIT PTS 
schema hm2hhi
archetype AI_MAJOR
hm2hhi_1 hm2hhi_2 hm2hhi_3
schema_voice hammer2 1 comhithigh

//HIT BY THE PLAYER W/LO PTS 
schema hm2hlo
archetype AI_MORE_MAJOR
hm2hlo_1 freq 1
hm2hlo_2 freq 2
hm2hlo_3 freq 2
hm2hlo_4 freq 2
schema_voice hammer2 1 comhitlow

//HIT BY THE PLAYER W/LO PTS  +w/co
schema hm2hlow
archetype AI_COMBAT
hm2hlow1 freq 1
hm2hlo_1 freq 2
hm2hlo_2 freq 2
schema_voice hammer2 2 comhitlow (NearbyFriends 0 20)

//HIT BY THE PLAYER NO DAMAGE
schema hm2hnd
archetype AI_MAJOR
hm2hnd_1 hm2hnd_2 hm2hnd_3
schema_voice hammer2 1 comhitnodam

//BLOCKED BY THE PLAYER +not losing
schema hm2bkd 
archetype AI_COMBAT
hm2bkd_1 hm2bkd_2 hm2bkd_3
schema_voice hammer2 1 comblocked (ComBal Winning Even)

//BLOCKED BY THE PLAYER +not losing +w/co
schema hm2bkdw 
archetype AI_COMBAT
hm2bkdw1
schema_voice hammer2 2 comblocked (ComBal Winning Even) (NearbyFriends 0 20)

//DETECTED PLAYER TRYING TO BLOCK +not losing
schema hm2det 
archetype AI_COMBAT
hm2det_1 hm2det_2 hm2det_3
schema_voice hammer2 1 comdetblock(ComBal Winning Even)

//DETECTED PLAYER TRYING TO BLOCK +not losing +w/co
schema hm2detw 
archetype AI_COMBAT
hm2detw1
schema_voice hammer2 2 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)

//AMBUSHED -HIT BY UNSEEN PLAYER
schema hm2amb 
archetype AI_MAJOR
hm2amb_1 hm2amb_2 hm2amb_3 hm2amb_4
schema_voice hammer2 1 comhitamb

//AMBUSHED -HIT BY UNSEEN PLAYER +w/co
schema hm2ambw
archetype AI_COMBAT
hm2ambw1 hm2ambw2 hm2ambw3
schema_voice hammer2 2 comhitamb (NearbyFriends 0 20)

//DEATH BY COMBAT -LOUD
schema hm2diec
archetype AI_COMBAT
hm2diec1 hm2diec2 hm2diec3
schema_voice hammer2 1 comdieloud

//DEATH (or knocked out)BY AMBUSH -MORE MUFFLED
schema hm2diea
archetype AI_MINOR
hm2diea1 hm2diea2 hm2diea3
schema_voice hammer2 1 comdiesoft

////////////////////
//MISSION SPECIFIC//
////////////////////

//MISSION 10
schema hm2m1001
archetype AI_MORE_MAJOR
hm2m1001
schema_voice hammer2 1 m1001

schema hm2m1002
archetype AI_NONE
hm2m1002
schema_voice hammer2 1 m1002

schema hm2m1003
archetype AI_MINOR
hm2m1003
schema_voice hammer2 1 m1003

schema hm2m1004
archetype AI_NONE
hm2m1004
schema_voice hammer2 1 m1004

schema hm2m1005
archetype AI_NONE
hm2m1005
schema_voice hammer2 1 m1005

schema hm2m1006
archetype AI_NONE
hm2m1006
schema_voice hammer2 1 m1006

schema hm2m1007
archetype AI_NONE
hm2m1007
schema_voice hammer2 1 m1007

schema hm2m1008
archetype AI_NONE
hm2m1008
schema_voice hammer2 1 m1008

schema hm2m1009
archetype AI_NONE
hm2m1009
schema_voice hammer2 1 m1009

schema hm2m1010
archetype AI_NONE
hm2m1010
schema_voice hammer2 1 m1010