//HAMMER 3 BROADCASTS -Joffrey Spaulding

//SLEEPING
schema hm3a0sn
archetype AI_NONE
volume -500
mono_loop 2000 3000
hm3a0sn1 hm3a0sn2 hm3a0sn3
schema_voice hammer3 1 sleeping

//AT ALERT 0 MORE REPEATABLE
schema hm3a0
archetype AI_NONE
volume -500
mono_loop 7500 15000
hm3a0co1 hm3a0co2 hm3a0co3
hm3a0hu1 hm3a0hu2 hm3a0hu3
hm3a0th1 hm3a0th2 hm3a0th3
hm3a0wh1 hm3a0wh2 hm3a0wh3
schema_voice hammer3 2 atlevelzero

//AT ALERT 0 LESS REPEATABLE
schema hm3a0ch
archetype AI_NONE
volume -1000
mono_loop 7500 15000
hm3a0ch1 hm3a0ch2 hm3a0ch3
hm3a0mu1 hm3a0mu2 hm3a0mu3
schema_voice hammer3 1 atlevelzero

//TO ALERT 1
schema hm3a1
archetype AI_NONE
hm3a1__1 hm3a1__2 hm3a1__3 hm3a1__4 
schema_voice hammer3 1 tolevelone  

//TO ALERT 1 +sighted
schema hm3a1v
archetype AI_NONE
hm3a1v_1
schema_voice hammer3 1 tolevelone (Sense Sight)

//TO ALERT 1 +heard
schema hm3a1h
archetype AI_NONE
hm3a1h_1 
schema_voice hammer3 2 tolevelone (Sense Sound)

//TO ALERT 1 +w/co
schema hm3a1_w
archetype AI_MINOR
hm3a1_w1
schema_voice hammer3 2 tolevelone (NearbyFriends 0 20)

//TO ALERT 1 +sighted +w/co
schema hm3a1vw
archetype AI_MINOR
hm3a1vw1 hm3a1vw2 hm3a1vw3
schema_voice hammer3 3 tolevelone (Sense Sight) (NearbyFriends 0 20)

//TO ALERT 1 +heard +w/co
schema hm3a1hw
archetype AI_MINOR
hm3a1hw1 hm3a1hw2 hm3a1hw3
schema_voice hammer3 3 tolevelone (Sense Sound) (NearbyFriends 0 20)

//TO ALERT 2
schema hm3a2
archetype AI_MINOR
hm3a2__1 hm3a2__2 hm3a2__3 hm3a2__4
schema_voice hammer3 1 toleveltwo  

//TO ALERT 2 +sighted
schema hm3a2v
archetype AI_MINOR
hm3a2v_1
schema_voice hammer3 1 toleveltwo (Sense Sight)  

//TO ALERT 2 +heard
schema hm3a2h
archetype AI_MINOR
hm3a2h_1 
schema_voice hammer3 2 toleveltwo (Sense Sound)

//TO ALERT 3
schema hm3a3
archetype AI_MAJOR
Hm3a3na1 Hm3a3na2
schema_voice hammer3 1 tolevelthree

//AT ALERT 2
schema hm3at2
archetype AI_MINOR
delay 6000
mono_loop 15000 30000
no_repeat
hm3a2se1 hm3a2se2 hm3a2se3 hm3a2se4
schema_voice hammer3 99 atleveltwo (Investigate True)

//AT ALERT 3
schema hm3at3
archetype AI_MAJOR
delay 6000
mono_loop 15000 30000
no_repeat
hm3a3se1 hm3a3se2 hm3a3se3 hm3a3se4
schema_voice hammer3 99 atlevelthree (Investigate True)

//SPOTTED THE PLAYER +startled
schema hm3a3s
archetype AI_MORE_MAJOR
hm3a3s_1 hm3a3s_2 hm3a3s_3 
schema_voice hammer3 1 spotplayer 

//SPOTTED THE PLAYER +not startled +alone
schema hm3a3na
archetype AI_MORE_MAJOR
hm3a3na1 hm3a3na2  
schema_voice hammer3 1 spotplayer

//SPOTTED THE PLAYER +carrying a body
schema hm3a3b
archetype AI_MORE_MAJOR
hm3a3b_1 hm3a3b_2 
schema_voice hammer3 9 spotplayer (CarryBody True)

//REACT CHARGE +alone
schema hm3chga
archetype AI_MORE_MAJOR
hm3chga1 hm3chga2 hm3chga3 hm3chga4 hm3chga5
schema_voice hammer3 1 reactcharge

//REACT CHARGE +w/co
schema hm3chgw
archetype AI_COMBAT
hm3chgw1 hm3chgw2 hm3chgw3
schema_voice hammer3 2 reactcharge (NearbyFriends 0 20)

//REACT RUN AWAY +alone
schema hm3runa
archetype AI_MAJOR
hm3runa1 hm3runa2 hm3runa3
schema_voice hammer3 1 reactrun 

//REACT I SOUND THE ALARMS +alone
schema hm3alma
archetype AI_MORE_MAJOR
hm3alma1 hm3alma2 
schema_voice hammer3 1 reactalarm

//REACT I TELL YOU TO SOUND THE ALARMS +w/co
schema hm3almw
archetype AI_COMBAT
hm3almw1
schema_voice hammer3 9 reactalarm (NearbyFriends 0 20)

//REACT TELL FRIEND BY REVELATION +w/co
schema hm3telr
archetype AI_COMBAT
hm3telr1 hm3telr2 hm3telr3 
schema_voice hammer3 5 spotplayer (NearbyFriends 0 20)

//REACT TELL FRIEND BY CONFIRMATION +w/co
schema hm3telc
archetype AI_COMBAT
hm3telc1 hm3telc2 hm3telc3
schema_voice hammer3 5 spotplayer (NearbyFriends 0 20) (Reacquire true)

//BACK TO ALERT 0
schema hm3bak
archetype AI_NONE
hm3bak_1 hm3bak_2 hm3bak_3 hm3bak_4
hm3bak_5 hm3bak_6 hm3bak_7
schema_voice hammer3 1 backtozero  

//LOST CONTACT W/PLAYER
schema hm3los
archetype AI_NONE
hm3los_1 hm3los_2 hm3los_3
schema_voice hammer3 1 lostcontact  

//FRUSTRATION
schema hm3frust
archetype AI_MAJOR
Hm3blk_1 Hm3det_1 Hm3bkd_3
schema_voice hammer3 1 outofreach  



//FOUND BODY
schema hm3bod
archetype AI_MORE_MAJOR
hm3bod_1 hm3bod_2 hm3bod_3
schema_voice hammer3 1 foundbody  

//FOUND SOMETHING MISSING
schema hm3mis
archetype AI_MAJOR
hm3mis_1 
schema_voice hammer3 1 foundmissing

//NOTICED A TORCH BEING DOUSED
schema hm3torch
archetype AI_MINOR
delay 1000
Hm3a1__1 Hm3a1__2 Hm3a1__3 Hm3a1__4 Hm3bak_4 Hm3bak_6
schema_voice hammer3 1 noticetorch

//FOUND A SMALL ANOMALY
schema hm3sma
archetype AI_MINOR
hm3sma_1 hm3sma_2
schema_voice hammer3 1 foundsmall  

//FOUND A LARGE ANOMALY
schema hm3lar
archetype AI_MAJOR
hm3lar_1 hm3lar_2
schema_voice hammer3 1 foundlarge

//FOUND A SECURITY BREACH
schema hm3sec
archetype AI_MORE_MAJOR
hm3sec_1 hm3sec_2 hm3sec_3
schema_voice hammer3 1 foundbreach

//RECENTLY SAW THE PLAYER +w/co
schema hm3rint
archetype AI_INFORM
hm3rint1 
schema_voice hammer3 1 recentintruder 

//RECENTLY FOUND BODY +w/co
schema hm3rbod
archetype AI_INFORM
hm3rbod1  
schema_voice hammer3 1 recentbody 

//RECENTLY FOUND SOMETHING MISSING +w/co
schema hm3rmis
archetype AI_INFORM
hm3rmis3 
schema_voice hammer3 1 recentmissing 

//RECENTLY FOUND MISC ANAMOLY +w/co
schema hm3roth
archetype AI_INFORM
hm3roth1 hm3roth2 hm3roth3
schema_voice hammer3 1 recentother 

//COMBAT

//ATTACKING +not losing
schema hm3atn
archetype AI_COMBAT
hm3atn_1 freq 1
hm3atn_2 freq 1
hm3atn_3 freq 6
hm3atn_4 freq 6
hm3atn_5 freq 6
hm3atn_6 freq 1
hm3atn_7 freq 1
hm3atn_8 freq 1
schema_voice hammer3 1 comattack (ComBal Winning Even)

//ATTACKING +winning
schema hm3atnw
archetype AI_COMBAT
hm3atw_1 hm3atw_2
schema_voice hammer3 3 comattack (ComBal Winning)

//ATTACKING +winning +w/co
schema hm3atww
archetype AI_COMBAT
hm3atww1 
schema_voice hammer3 4 comattack (ComBal Winning) (NearbyFriends 0 20)

//ATTACKING +losing
schema hm3atl
archetype AI_COMBAT
hm3atl_1 freq 1
hm3atl_2 freq 1
hm3atl_3 freq 2
hm3atl_4 freq 2
hm3atl_5 freq 2
hm3atl_6 freq 2
schema_voice hammer3 1 comattack (ComBal Losing)

//SUCCESSFULLY HIT THE PLAYER +not losing
schema hm3hit
archetype AI_COMBAT
hm3hit_1 hm3hit_2 hm3hit_3 hm3hit_4
schema_voice hammer3 1 comsucchit (ComBal Winning Even)

//SUCCESSFULLY HIT THE PLAYER +not losing +w/co
schema hm3hit
archetype AI_COMBAT
hm3hitw1 hm3hitw2
schema_voice hammer3 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

//SUCCESSFULLY BLOCKED THE PLAYER +not losing
schema hm3blk
archetype AI_COMBAT
hm3blk_1 hm3blk_2 hm3blk_3
schema_voice hammer3 1 comsuccblock (ComBal Winning Even)

//SUCCESSFULLY BLOCKED THE PLAYER +not losing +w/co
schema hm3blkw
archetype AI_COMBAT
hm3blkw1
schema_voice hammer3 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)

//HIT BY THE PLAYER W/HI HIT PTS 
schema hm3hhi
archetype AI_MAJOR
hm3hhi_1 hm3hhi_2 hm3hhi_3
schema_voice hammer3 1 comhithigh

//HIT BY THE PLAYER W/LO PTS 
schema hm3hlo
archetype AI_MORE_MAJOR
hm3hlo_1 freq 1
hm3hlo_2 freq 2
hm3hlo_3 freq 2
hm3hlo_4 freq 2
schema_voice hammer3 1 comhitlow

//HIT BY THE PLAYER W/LO PTS  +w/co
schema hm3hlow
archetype AI_COMBAT
hm3hlow1
schema_voice hammer3 1 comhitlow (NearbyFriends 0 20)

//HIT BY THE PLAYER NO DAMAGE
schema hm3hnd
archetype AI_MAJOR
hm3hnd_1 hm3hnd_2 hm3hnd_3
schema_voice hammer3 1 comhitnodam

//BLOCKED BY THE PLAYER +not losing
schema hm3bkd 
archetype AI_COMBAT
hm3bkd_1 hm3bkd_2 hm3bkd_3
schema_voice hammer3 1 comblocked (ComBal Winning Even)

//BLOCKED BY THE PLAYER +not losing +w/co
schema hm3bkdw 
archetype AI_COMBAT
hm3bkdw1
schema_voice hammer3 2 comblocked (ComBal Winning Even) (NearbyFriends 0 20)

//DETECTED PLAYER TRYING TO BLOCK +not losing
schema hm3det 
archetype AI_COMBAT
hm3det_1 hm3det_2 hm3det_3
schema_voice hammer3 1 comdetblock(ComBal Winning Even)

//DETECTED PLAYER TRYING TO BLOCK +not losing +w/co
schema hm3detw 
archetype AI_COMBAT
hm3detw1
schema_voice hammer3 2 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)

//AMBUSHED -HIT BY UNSEEN PLAYER
schema hm3amb 
archetype AI_MAJOR 
hm3amb_1 hm3amb_2 hm3amb_3 hm3amb_4
schema_voice hammer3 1 comhitamb

//AMBUSHED -HIT BY UNSEEN PLAYER +w/co
schema hm3ambw
archetype AI_COMBAT
hm3ambw1 hm3ambw2 hm3ambw3
schema_voice hammer3 2 comhitamb (NearbyFriends 0 20)

//DEATH BY COMBAT -LOUD
schema hm3diec
archetype AI_COMBAT
hm3diec1 hm3diec2 hm3diec3
schema_voice hammer3 1 comdieloud

//DEATH (or knocked out)BY AMBUSH -MORE MUFFLED
schema hm3diea
archetype AI_MINOR
volume -1000
hm3diea1 hm3diea2 hm3diea3
schema_voice hammer3 1 comdiesoft

////////////////////
//MISSION SPECIFIC//
////////////////////

//MISSION 10
schema hm3m1001
archetype AI_MORE_MAJOR
hm3m1001
schema_voice hammer3 1 m1001

schema hm3m1002
archetype AI_NONE
hm3m1002
schema_voice hammer3 1 m1002

schema hm3m1003
archetype AI_MINOR
hm3m1003
schema_voice hammer3 1 m1003

schema hm3m1004
archetype AI_NONE
hm3m1004
schema_voice hammer3 1 m1004

schema hm3m1005
archetype AI_NONE
hm3m1005
schema_voice hammer3 1 m1005

schema hm3m1006
archetype AI_NONE
hm3m1006
schema_voice hammer3 1 m1006

schema hm3m1007
archetype AI_NONE
hm3m1007
schema_voice hammer3 1 m1007

schema hm3m1008
archetype AI_NONE
hm3m1008
schema_voice hammer3 1 m1008

schema hm3m1009
archetype AI_NONE
hm3m1009
schema_voice hammer3 1 m1009

schema hm3m1010
archetype AI_NONE
hm3m1010
schema_voice hammer3 1 m1010

