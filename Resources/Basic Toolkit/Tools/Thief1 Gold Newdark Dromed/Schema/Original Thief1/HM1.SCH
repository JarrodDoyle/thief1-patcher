//HAMMER 1 BROADCASTS -Stephen Russell

//AT ALERT 0 MORE REPEATABLE
schema hm1a0
archetype AI_NONE
volume -500
mono_loop 7500 10000
hm1a0co1 hm1a0co2 hm1a0co3
hm1a0hu1 hm1a0hu2 hm1a0hu3
hm1a0th1 hm1a0th2 hm1a0th3
hm1a0wh1 hm1a0wh2 hm1a0wh3
schema_voice hammer1 3 atlevelzero

//AT ALERT 0 LESS REPEATABLE
schema hm1a0ch
archetype AI_NONE
volume -500
mono_loop 7500 10000
hm1a0ch1 hm1a0ch2 hm1a0ch3
hm1a0mu1 hm1a0mu2 hm1a0mu3
schema_voice hammer1 1 atlevelzero
schema_voice hammer1 1 atlevelone

//AT ALERT 0 ASLEEP
schema hm1a0sn
archetype AI_NONE
volume -500
mono_loop 2000 3000
hm1a0sn1 hm1a0sn2 hm1a0sn3
schema_voice hammer1 1 sleeping

//TO ALERT 1
schema hm1a1
archetype AI_NONE
hm1a1__1 hm1a1__2 hm1a1__3 hm1a1__4 
schema_voice hammer1 1 tolevelone  

//TO ALERT 1 +sighted
schema hm1a1v
archetype AI_NONE
hm1a1v_1
schema_voice hammer1 1 tolevelone (Sense Sight)

//TO ALERT 1 +heard
schema hm1a1h
archetype AI_NONE
hm1a1h_1 hm1a1h_2
schema_voice hammer1 2 tolevelone (Sense Sound)

//TO ALERT 1 +w/co
schema hm1a1_w
archetype AI_MINOR
hm1a1_w1
schema_voice hammer1 2 tolevelone (NearbyFriends 0 20)

//TO ALERT 1 +sighted +w/co
schema hm1a1vw
archetype AI_MINOR
hm1a1vw1 hm1a1vw2 hm1a1vw3
schema_voice hammer1 3 tolevelone (Sense Sight) (NearbyFriends 0 20)

//TO ALERT 1 +heard +w/co
schema hm1a1hw
archetype AI_MINOR
hm1a1hw1 hm1a1hw2 hm1a1hw3
schema_voice hammer1 3 tolevelone (Sense Sound) (NearbyFriends 0 20)

//TO ALERT 2
schema hm1a2
archetype AI_MINOR
hm1a2__1 hm1a2__2 hm1a2__3 hm1a2__4
schema_voice hammer1 1 toleveltwo  

//TO ALERT 2 +sighted
schema hm1a2v
archetype AI_MINOR
hm1a2v_1
schema_voice hammer1 1 toleveltwo (Sense Sight)  

//TO ALERT 2 +heard
schema hm1a2h
archetype AI_MINOR
hm1a2h_1 hm1a2h_2
schema_voice hammer1 2 toleveltwo (Sense Sound)

//TO ALERT 3
schema hm1a3
archetype AI_MAJOR
Hm1a3s_3
schema_voice hammer1 1 tolevelthree


//AT ALERT 2
schema hm1at2
archetype AI_MINOR
delay 3000
no_repeat
mono_loop 10000 30000
hm1a2se1 hm1a2se2 hm1a2se3 hm1a2se4
schema_voice hammer1 99 atleveltwo (Investigate True)

//AT ALERT 3
schema hm1at3
archetype AI_MAJOR
delay 3000
no_repeat
mono_loop 15000 30000
hm1a3se1 hm1a3se2 hm1a3se3 hm1a3se4
schema_voice hammer1 99 atlevelthree (Investigate True)

//SPOTTED THE PLAYER +startled
schema hm1a3s
archetype AI_MORE_MAJOR
hm1a3s_1 hm1a3s_2 hm1a3s_3
schema_voice hammer1 1 spotplayer 

//SPOTTED THE PLAYER +mission3
schema hm1a3s_m3
archetype AI_MORE_MAJOR
hm1a3s_4
schema_voice hammer1 1 spotplayer (mission 3 3)


//SPOTTED THE PLAYER +not startled +alone
schema hm1a3na
archetype AI_MORE_MAJOR
hm1a3na1 hm1a3na2 hm1a3na3 hm1a3na4
schema_voice hammer1 1 spotplayer

//SPOTTED THE PLAYER +carrying a body
schema hm1a3b
archetype AI_MORE_MAJOR
hm1a3b_1 hm1a3b_2 
schema_voice hammer1 9 spotplayer (CarryBody True)

//REACT CHARGE +alone
schema hm1chga
archetype AI_MORE_MAJOR
hm1chga1 hm1chga2 hm1chga3
schema_voice hammer1 1 reactcharge

//REACT CHARGE +w/co
schema hm1chgw
archetype AI_COMBAT
hm1chgw1 hm1chgw2 hm1chgw3
schema_voice hammer1 2 reactcharge (NearbyFriends 0 20)

//REACT RUN AWAY +alone
schema hm1runa
archetype AI_MAJOR
hm1runa1 hm1runa2 hm1runa3
schema_voice hammer1 1 reactrun

//REACT I SOUND THE ALARMS +alone
schema hm1alma
archetype AI_MORE_MAJOR
hm1alma1 hm1alma2
schema_voice hammer1 1 reactalarm

//REACT I TELL YOU TO SOUND THE ALARMS +w/co
schema hm1almw
archetype AI_COMBAT
hm1almw1
schema_voice hammer1 5 reactalarm (NearbyFriends 0 20)

//REACT TELL FRIEND BY REVELATION +w/co
schema hm1telr
archetype AI_COMBAT
hm1telr1 hm1telr2 hm1telr3
schema_voice hammer1 5 spotplayer (NearbyFriends 0 20)

//REACT TELL FRIEND BY CONFIRMATION +w/co
schema hm1telc
archetype AI_COMBAT
hm1telc1 hm1telc2 hm1telc3
schema_voice hammer1 5 spotplayer (NearbyFriends 0 20) (Reacquire true)

//BACK TO ALERT 0
schema hm1bak
archetype AI_NONE
hm1bak_1 hm1bak_2 hm1bak_3 hm1bak_4
hm1bak_5 hm1bak_6 hm1bak_7 hm1bak_8
schema_voice hammer1 1 backtozero  

//LOST CONTACT W/PLAYER
schema hm1los
archetype AI_NONE
hm1los_1 hm1los_2 hm1los_3
schema_voice hammer1 1 lostcontact  

//FRUSTRATION
schema hm1frust
archetype AI_MAJOR
Hm1a3se2 Hm1det_2 Hm1det_1 Hm1bkd_1
schema_voice hammer1 1 outofreach  

//FOUND BODY
schema hm1bod
archetype AI_MORE_MAJOR
hm1bod_1 hm1bod_2 hm1bod_3
schema_voice hammer1 1 foundbody  

//FOUND SOMETHING MISSING
schema hm1mis
archetype AI_MAJOR
hm1mis_1 hm1mis_2
schema_voice hammer1 1 foundmissing

//NOTICED A TORCH BEING DOUSED
schema hm1torch
archetype AI_MINOR
delay 1000
Hm1a1__1 Hm1a1__3 Hm1bak_6
schema_voice hammer1 1 noticetorch 


//FOUND A SMALL ANOMALY
schema hm1sma
archetype AI_MINOR
hm1sma_1 hm1sma_2
schema_voice hammer1 1 foundsmall  

//FOUND A LARGE ANOMALY
schema hm1lar
archetype AI_MAJOR
hm1lar_1 hm1lar_2
schema_voice hammer1 1 foundlarge

//FOUND A SECURITY BREACH
schema hm1sec
archetype AI_MORE_MAJOR
hm1sec_1 hm1sec_2 hm1sec_3
schema_voice hammer1 1 foundbreach

//RECENTLY SAW THE PLAYER +w/co
schema hm1rint
archetype AI_INFORM
hm1rint1 hm1rint2 hm1rint3
schema_voice hammer1 1 recentintruder 

//RECENTLY FOUND BODY +w/co
schema hm1rbod
archetype AI_INFORM
hm1rbod1 hm1rbod2 hm1rbod3
schema_voice hammer1 1 recentbody 

//RECENTLY FOUND SOMETHING MISSING +w/co
schema hm1rmis
archetype AI_INFORM
hm1rmis1 
schema_voice hammer1 1 recentmissing 

//RECENTLY FOUND MISC ANAMOLY +w/co
schema hm1roth
archetype AI_INFORM
hm1roth1 hm1roth2 hm1roth3
schema_voice hammer1 1 recentother 

//COMBAT

//ATTACKING +not losing
schema hm1atn
archetype AI_COMBAT
hm1atn_1 freq 1
hm1atn_2 freq 1
hm1atn_3 freq 5
hm1atn_4 freq 5
hm1atn_5 freq 5
hm1atn_6 freq 1
hm1atn_7 freq 1
hm1atn_8 freq 1
hm1atn_9 freq 1
hm1atn_A freq 3
schema_voice hammer1 1 comattack (ComBal Winning Even)

//ATTACKING +winning
schema hm1atnw
archetype AI_COMBAT
hm1atw_1 hm1atw_2
schema_voice hammer1 3 comattack (ComBal Winning)

//ATTACKING +winning +w/co
schema hm1atww
archetype AI_COMBAT
hm1atww1 hm1atww1
schema_voice hammer1 3 comattack (ComBal Winning) (NearbyFriends 0 20)

//ATTACKING +losing
schema hm1atl
archetype AI_COMBAT
hm1atl_1 hm1atl_2 hm1atl_3 hm1atl_4 hm1atl_5 hm1atl_6 
schema_voice hammer1 1 comattack (ComBal Losing)

//SUCCESSFULLY HIT THE PLAYER +not losing
schema hm1hit
archetype AI_COMBAT
hm1hit_1 hm1hit_2 hm1hit_3 hm1hit_4
schema_voice hammer1 1 comsucchit (ComBal Winning Even)

//SUCCESSFULLY HIT THE PLAYER +not losing +w/co
schema hm1hitw
archetype AI_COMBAT
hm1hitw1 hm1hitw2
schema_voice hammer1 2 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

//SUCCESSFULLY BLOCKED THE PLAYER +not losing
schema hm1blk
archetype AI_COMBAT
hm1blk_1 hm1blk_2 hm1blk_3
schema_voice hammer1 1 comsuccblock (ComBal Winning Even)

//SUCCESSFULLY BLOCKED THE PLAYER +not losing +w/co
schema hm1blkw
archetype AI_COMBAT
hm1blkw1
schema_voice hammer1 2 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)

//HIT BY THE PLAYER W/HI HIT PTS 
schema hm1hhi
archetype AI_MAJOR
hm1hhi_1 hm1hhi_2 hm1hhi_3
schema_voice hammer1 1 comhithigh

//HIT BY THE PLAYER W/LO PTS 
schema hm1hlo
archetype AI_MORE_MAJOR
hm1hlo_1 freq 1
hm1hlo_2 freq 2
hm1hlo_3 freq 2
hm1hlo_4 freq 2
schema_voice hammer1 1 comhitlow

//HIT BY THE PLAYER W/LO PTS  +w/co
schema hm1hlow
archetype AI_COMBAT
hm1hlow1
schema_voice hammer1 1 comhitlow (NearbyFriends 0 20)

//HIT BY THE PLAYER NO DAMAGE
schema hm1hnd
archetype AI_MAJOR
hm1hnd_1 hm1hnd_2 hm1hnd_3
schema_voice hammer1 1 comhitnodam

//BLOCKED BY THE PLAYER +not losing
schema hm1bkd 
archetype AI_COMBAT
hm1bkd_1 hm1bkd_2 hm1bkd_3
schema_voice hammer1 1 comblocked (ComBal Winning Even)

//BLOCKED BY THE PLAYER +not losing +w/co
schema hm1bkdw 
archetype AI_COMBAT
hm1bkdw1
schema_voice hammer1 2 comblocked (ComBal Winning Even) (NearbyFriends 0 20)

//DETECTED PLAYER TRYING TO BLOCK +not losing
schema hm1det 
archetype AI_COMBAT
hm1det_1 hm1det_2 hm1det_3
schema_voice hammer1 1 comdetblock (ComBal Winning Even)

//DETECTED PLAYER TRYING TO BLOCK +not losing +w/co
schema hm1detw 
archetype AI_COMBAT
hm1detw1
schema_voice hammer1 2 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)

//AMBUSHED -HIT BY UNSEEN PLAYER
schema hm1amb 
archetype AI_MAJOR
hm1amb_1 hm1amb_2 hm1amb_3 hm1amb_4
schema_voice hammer1 1 comhitamb

//AMBUSHED -HIT BY UNSEEN PLAYER +w/co
schema hm1ambw
archetype AI_COMBAT
hm1ambw1 hm1ambw2 hm1ambw3
schema_voice hammer1 2 comhitamb (NearbyFriends 0 20)

//DEATH BY COMBAT -LOUD
schema hm1diec
archetype AI_COMBAT
hm1diec1 hm1diec2 hm1diec3
schema_voice hammer1 1 comdieloud

//DEATH (or knocked out)BY AMBUSH -MORE MUFFLED
schema hm1diea
archetype AI_MINOR
volume -1000
hm1diea1 hm1diea2 hm1diea3
schema_voice hammer1 1 comdiesoft

////////////////////
//MISSION SPECIFIC//
////////////////////

//MISSION 10
schema hm1m1001
archetype AI_MORE_MAJOR
hm1m1001
schema_voice hammer1 1 m1001

schema hm1m1002
archetype AI_NONE
hm1m1002
schema_voice hammer1 1 m1002

schema hm1m1003
archetype AI_MINOR
hm1m1003
schema_voice hammer1 1 m1003

schema hm1m1004
archetype AI_NONE
hm1m1004
schema_voice hammer1 1 m1004

schema hm1m1005
archetype AI_NONE
hm1m1005
schema_voice hammer1 1 m1005

schema hm1m1006
archetype AI_NONE
hm1m1006
schema_voice hammer1 1 m1006

schema hm1m1007
archetype AI_NONE
hm1m1007
schema_voice hammer1 1 m1007

schema hm1m1008
archetype AI_NONE
hm1m1008
schema_voice hammer1 1 m1008

schema hm1m1009
archetype AI_NONE
delay 3000
hm1m1009
schema_voice hammer1 1 m1009

schema hm1m1010
archetype AI_NONE
hm1m1010
schema_voice hammer1 1 m1010

//////////////
//MISSION 13//
//////////////

schema hm1m1302
archetype AI_NONE
hm1m1302
schema_voice hammer1 1 m1302

schema hm1m1303
archetype AI_NONE
hm1m1303
schema_voice hammer1 1 m1303

schema hm1m1304
archetype AI_NONE
hm1m1304
schema_voice hammer1 1 m1304

schema hm1m1305
archetype AI_NONE
hm1m1305
schema_voice hammer1 1 m1305

schema hm1m1306
archetype AI_NONE
hm1m1306
schema_voice hammer1 1 m1306

schema hm1m1307
archetype AI_NONE
hm1m1307
schema_voice hammer1 1 m1307

schema hm1m1308
archetype AI_NONE
hm1m1308
schema_voice hammer1 1 m1308

schema hm1m1309
archetype AI_NONE
hm1m1309
schema_voice hammer1 1 m1309

schema hm1m1310
archetype AI_NONE
hm1m1310
schema_voice hammer1 1 m1310

schema hm1m1311
archetype AI_NONE
hm1m1311
schema_voice hammer1 1 m1311

schema hm1m1312
archetype AI_NONE
hm1m1312
schema_voice hammer1 1 m1312

schema hm1m1313
archetype AI_NONE
hm1m1313
schema_voice hammer1 1 m1313

