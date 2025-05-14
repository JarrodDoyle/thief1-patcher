//APEBEAST1	-Dan Thron

//AT ALERT 0 COUGHING
schema ab1a0co
archetype AI_NONE
volume -500
mono_loop 5000 20000
ab1a0co1 ab1a0co2 ab1a0co3 
schema_voice vape1 2 atlevelzero

//AT ALERT 0 HUMMING
schema ab1a0hu
archetype AI_NONE
volume -500
mono_loop 500 20000
ab1a0hu1 ab1a0hu2 ab1a0hu3 
schema_voice vape1 2 atlevelzero
schema_voice vape1 2 atlevelone

//AT ALERT 0 MUTTERING
schema ab1a0mu
archetype AI_NONE
volume -500
mono_loop 7500 20000
ab1a0mu1 ab1a0mu2 ab1a0mu3
schema_voice vape1 1 atlevelzero

//AT ALERT 2 & 3 NOT INVESTIGATING
schema ab1a2mu
archetype AI_NONE
volume -500
delay 3000
mono_loop 7500 20000
ab1a0mu1 ab1a0mu2 ab1a0mu3
schema_voice vape1 1 atleveltwo
schema_voice vape1 1 atlevelthree

//TO ALERT 1
schema ab1a1
archetype AI_NONE
ab1a1__1 ab1a1__2 ab1a1__3 ab1a1__4
ab1a1__5 ab1a1__6 ab1grun1
schema_voice vape1 1 tolevelone  

//TO ALERT 1 +sighted
schema ab1a1v
archetype AI_NONE
ab1a1v_1 ab1a1v_2
schema_voice vape1 1 tolevelone (Sense Sight)

//TO ALERT 1 +heard
schema ab1a1h
archetype AI_NONE
ab1a1h_1 ab1a1h_2
schema_voice vape1 1 tolevelone (Sense Sound)

//TO ALERT 1 +w/co
schema ab1a1_w
archetype AI_MINOR
ab1a1_w1 ab1a1_w2
schema_voice vape1 1 tolevelone (NearbyFriends 0 20)

//TO ALERT 1 +sighted +w/co
schema ab1a1vw
archetype AI_MINOR
ab1a1vw1 ab1a1vw2 ab1a1vw3 ab1a1vw4
schema_voice vape1 1 tolevelone (Sense Sight) (NearbyFriends 0 20)

//TO ALERT 1 +heard +w/co
schema ab1a1hw
archetype AI_MINOR
ab1a1hw1 ab1a1hw2 ab1a1hw3 ab1a1hw4 ab1a1hw5
schema_voice vape1 1 tolevelone (Sense Sound) (NearbyFriends 0 20)

//TO ALERT 2
schema ab1a2
archetype AI_MINOR
ab1a2__1 ab1a2__2 ab1a2__3 ab1a2__4 ab1a2__5 ab1a2__6
schema_voice vape1 1 toleveltwo  

//TO ALERT 2 +sighted
schema ab1a2v
archetype AI_MINOR
ab1a2v_1 ab1a2v_2
schema_voice vape1 1 toleveltwo (Sense Sight)  

//TO ALERT 2 +heard
schema ab1a2h
archetype AI_MINOR
ab1a2h_1 ab1a2h_2 
schema_voice vape1 1 toleveltwo (Sense Sound)

//AT ALERT 1
schema ab1at1
archetype AI_NONE
delay 5000
mono_loop 2000 8000
ab1snif1 ab1snif2 ab1snif3 silenc9s
schema_voice vape1 9 atlevelone (Investigate true)

//AT ALERT 2
schema ab1at2
archetype AI_MINOR
delay 5000
mono_loop 2000 8000
ab1snrt1 ab1snrt2 ab1snif1 ab1snif2 ab1snif3 silenc9s
schema_voice vape1 9 atleveltwo (Investigate true)

//AT ALERT 3
schema ab1at3
archetype AI_MAJOR
delay 5000
mono_loop 1000 5000
ab1snrt1 ab1snrt2 ab1snif1 ab1snif2 ab1snif3 ab1amb_1
schema_voice vape1 9 atlevelthree (Investigate true)

//TO LEVEL THREE
schema ab1a3
archetype AI_MAJOR
ab1a3s_2 ab1grun1 ab1amb_4
schema_voice vape1 1 tolevelthree

//SPOTTED THE PLAYER
schema ab1a3s
archetype AI_MORE_MAJOR
ab1a3s_1 ab1a3s_2 ab1a3s_3 ab1a3s_4 ab1a3s_5
schema_voice vape1 1 spotplayer

//SPOTTED THE PLAYER
schema ab1a3na
archetype AI_MORE_MAJOR
ab1a3na1 ab1a3na2 ab1a3na3 
ab1a3na4 ab1a3na5 ab1a3na6 
schema_voice vape1 1 spotplayer

//SPOTTED THE PLAYER +carrying a body
schema ab1a3b
archetype AI_MORE_MAJOR
ab1a3b_1 
schema_voice vape1 9 spotplayer (CarryBody)

//REACT CHARGE
schema ab1chga
archetype AI_MORE_MAJOR
ab1chga1 ab1chga2 ab1chga3
schema_voice vape1 1 reactcharge

//REACT CHARGE +w/co
schema ab1chgw
archetype AI_COMBAT
ab1chgw1 ab1chgw2 ab1chgw3 ab1chgw4 ab1chgw5
schema_voice vape1 1 reactcharge (NearbyFriends 0 20)

//REACT RUN AWAY +alone
schema ab1runa
archetype AI_MAJOR
ab1runa1 ab1runa2 ab1runa3 ab1runa4 ab1runa5
schema_voice vape1 1 reactrun

//REACT I SOUND THE ALARMS +alone
schema ab1alma
archetype AI_MORE_MAJOR
ab1alma1 ab1alma2 ab1alma3
schema_voice vape1 1 reactalarm

//REACT I TELL YOU TO SOUND THE ALARMS +w/co
schema ab1almw
archetype AI_COMBAT
ab1almw1
schema_voice vape1 9 reactalarm (NearbyFriends 0 20)

//REACT TELL FRIEND BY REVELATION +w/co
schema ab1telr
archetype AI_COMBAT
ab1telr1 ab1telr2 ab1telr3 ab1telr4 ab1telr5
schema_voice vape1 3 spotplayer (NearbyFriends 0 20)

//REACT TELL FRIEND BY CONFIRMATION +w/co
schema ab1telc
archetype AI_COMBAT
ab1telc1 ab1telc2 ab1telc3
ab1telc4 ab1telc5 ab1telc6
schema_voice vape1 4 spotplayer (NearbyFriends 0 20) (Reacquire True)

//BACK TO ALERT 0
schema ab1bak
archetype AI_NONE
ab1bak_1 ab1bak_2 ab1bak_3 ab1bak_4
ab1bak_5 ab1bak_6 ab1bak_7 ab1bak_8 
schema_voice vape1 1 backtozero  

//LOST CONTACT W/PLAYER
schema ab1los
archetype AI_NONE
ab1los_1 ab1los_2 ab1los_3 ab1los_4
schema_voice vape1 1 lostcontact  

//FRUSTRATION
schema ap1frust
archetype AI_MAJOR
ab1det_1 ab1det_2 ab1det_3 ab1bkd_1 ab1bkd_3 ab1chga1 ab1chga2
schema_voice vape1 1 outofreach

//NOTICED A TORCH BEING DOUSED
schema ap1torch
archetype AI_MINOR
delay 1000
ab1a1__1 ab1a1__2 ab1a1__3 ab1a1__5 ab1a2__3 ab1bak_5
schema_voice vape1 1 noticetorch


//FOUND BODY
schema ab1bod
archetype AI_MORE_MAJOR
ab1bod_1 ab1bod_2
schema_voice vape1 1 foundbody  

//FOUND SOMETHING MISSING
schema ab1mis
archetype AI_MAJOR
ab1mis_1 ab1mis_2 ab1mis_3
schema_voice vape1 1 foundmissing

//FOUND A SMALL ANOMALY
schema ab1sma
archetype AI_MINOR
ab1sma_1 ab1sma_2 ab1sma_3
schema_voice vape1 1 foundsmall  

//FOUND A LARGE ANOMALY
schema ab1lar
archetype AI_MAJOR
ab1lar_1 ab1lar_2 ab1lar_3
schema_voice vape1 1 foundlarge

//FOUND A SECURITY BREACH
schema ab1sec
archetype AI_MORE_MAJOR
ab1sec_1 ab1sec_2 ab1sec_3 ab1sec_4
schema_voice vape1 1 foundbreach

//RECENTLY SAW THE PLAYER +w/co
schema ab1rint
archetype AI_INFORM
ab1rint1 ab1rint2 ab1rint3
schema_voice vape1 1 recentintruder (NearbyFriends 0 20)

//RECENTLY FOUND BODY +w/co
schema ab1rbod
archetype AI_INFORM
ab1rbod1 ab1rbod2 ab1rbod3
schema_voice vape1 1 recentbody (NearbyFriends 0 20)

//RECENTLY FOUND SOMETHING MISSING +w/co
schema ab1rmis
archetype AI_INFORM
ab1rmis1 ab1rmis2 ab1rmis3
schema_voice vape1 1 recentmissing (NearbyFriends 0 20)

//RECENTLY FOUND MISC ANAMOLY +w/co
schema ab1roth
archetype AI_INFORM
ab1roth1 ab1roth2 ab1roth3 ab1roth4 ab1roth5
schema_voice vape1 1 recentother (NearbyFriends 0 20)

//COMBAT

//ATTACKING +not losing
schema ab1atn
archetype AI_COMBAT
ab1atn_1 freq 1
ab1atn_2 freq 1
ab1atn_3 freq 3
schema_voice vape1 1 comattack (ComBal Winning Even Losing)

//ATTACKING +winning
schema ab1atnw
archetype AI_COMBAT
ab1atw_1 ab1atw_2
schema_voice vape1 3 comattack (ComBal Winning)

//ATTACKING +winning +w/co
schema ab1atww
archetype AI_COMBAT
ab1atww1 
schema_voice vape1 3 comattack (ComBal Winning) (NearbyFriends 0 20)

//SUCCESSFULLY HIT THE PLAYER +not losing
schema ab1hit
archetype AI_COMBAT
ab1hit_1 ab1hit_2 ab1hit_3 ab1hit_4 ab1hit_5 ab1hit_6
schema_voice vape1 1 comsucchit (ComBal Winning Even)

//SUCCESSFULLY HIT THE PLAYER +not losing +w/co
schema ab1hit
archetype AI_COMBAT
ab1hitw1 ab1hitw2 ab1hitw3
schema_voice vape1 1 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

//SUCCESSFULLY BLOCKED THE PLAYER +not losing
schema ab1blk
archetype AI_COMBAT
ab1blk_1 ab1blk_2 ab1blk_3 ab1blk_4
schema_voice vape1 1 comsuccblock (ComBal Winning Even)

//SUCCESSFULLY BLOCKED THE PLAYER +not losing +w/co
schema ab1blkw
archetype AI_COMBAT
ab1blkw1
schema_voice vape1 1 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)

//HIT BY THE PLAYER W/HI HIT PTS 
schema ab1hhi
archetype AI_MAJOR
ab1hhi_1 ab1hhi_2 ab1hhi_3
schema_voice vape1 1 comhithigh

//HIT BY THE PLAYER W/LO PTS 
schema ab1hlo
archetype AI_MORE_MAJOR
ab1hlo_1 ab1hlo_2 ab1hlo_3 
schema_voice vape1 1 comhitlow

//HIT BY THE PLAYER W/LO PTS  +w/co
schema ab1hlow
archetype AI_COMBAT
ab1hlow1
schema_voice vape1 1 comhitlow (NearbyFriends 0 20)

//HIT BY THE PLAYER NO DAMAGE
schema ab1hnd
archetype AI_MAJOR
ab1hnd_1 ab1hnd_2 ab1hnd_3
schema_voice vape1 1 comhitnodam

//BLOCKED BY THE PLAYER +not losing
schema ab1bkd 
archetype AI_COMBAT
ab1bkd_1 ab1bkd_2 ab1bkd_3
schema_voice vape1 1 comblocked (ComBal Winning Even)

//BLOCKED BY THE PLAYER +not losing +w/co
schema ab1bkdw 
archetype AI_COMBAT
ab1bkdw1
schema_voice vape1 1 comblocked (ComBal Winning Even) (NearbyFriends 0 20)

//DETECTED PLAYER TRYING TO BLOCK +not losing
schema ab1det 
archetype AI_COMBAT
ab1det_1 ab1det_2 ab1det_3
schema_voice vape1 1 comdetblock(ComBal Winning Even)

//DETECTED PLAYER TRYING TO BLOCK +not losing +w/co
schema ab1detw 
archetype AI_COMBAT
ab1detw1
schema_voice vape1 1 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)

//AMBUSHED -HIT BY UNSEEN PLAYER
schema ab1amb 
archetype AI_MAJOR
ab1amb_1 ab1amb_2 ab1amb_3 ab1amb_4
schema_voice vape1 1 comhitamb

//AMBUSHED -HIT BY UNSEEN PLAYER +w/co
schema ab1ambw
archetype AI_COMBAT
ab1ambw1 ab1ambw2 ab1ambw3
schema_voice vape1 1 comhitamb (NearbyFriends 0 20)

//DEATH BY COMBAT -LOUD
schema ab1diec
archetype AI_COMBAT
ab1diec1 ab1diec2 ab1diec3
schema_voice vape1 1 comdieloud

//DEATH (or knocked out) BY AMBUSH -MORE MUFFLED
schema ab1diea
archetype AI_MINOR
volume -500
ab1diea1 ab1diea2 ab1diea3
schema_voice vape1 1 comdiesoft



