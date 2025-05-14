//APEBEAST2	-Joffrey Spaulding

//AT ALERT 0 COUGHING
schema ab2a0co
archetype AI_NONE
volume -500
mono_loop 5000 20000
ab2a0co1 ab2a0co2 ab2a0co3 
schema_voice vape2 2 atlevelzero

//AT ALERT 0 HUMMING
schema ab2a0hu
archetype AI_NONE
volume -500
mono_loop 1000 3000
ab2a0hu1 ab2a0hu2 ab2a0hu3 silenc9s
schema_voice vape2 2 atlevelzero
schema_voice vape2 2 atlevelone

//AT ALERT 0 MUTTERING
schema ab2a0mu
archetype AI_NONE
volume -500
mono_loop 7500 20000
ab2a0mu1 ab2a0mu2 ab2a0mu3
schema_voice vape2 1 atlevelzero

//AT ALERT 2 & 3 NOT INVESTIGATING
schema ab2a2mu
archetype AI_NONE
volume -500
delay 3000
mono_loop 7500 20000
ab2a0mu1 ab2a0mu2 ab2a0mu3
schema_voice vape2 1 atleveltwo
schema_voice vape2 1 atlevelthree

//TO ALERT 1
schema ab2a1
archetype AI_NONE
ab2a1__1 ab2a1__2 ab2a1__3 ab2a1__4
ab2a1__5 ab2a1__6 ab2grun1
schema_voice vape2 1 tolevelone  

//TO ALERT 1 +sighted
schema ab2a1v
archetype AI_NONE
ab2a1v_1 
schema_voice vape2 1 tolevelone (Sense Sight)

//TO ALERT 1 +heard
schema ab2a1h
archetype AI_NONE
ab2a1h_1 ab2a1h_2
schema_voice vape2 1 tolevelone (Sense Sound)

//TO ALERT 1 +w/co
schema ab2a1_w
archetype AI_MINOR
ab2a1_w1 ab2a1_w2
schema_voice vape2 1 tolevelone (NearbyFriends 0 20)

//TO ALERT 1 +sighted +w/co
schema ab2a1vw
archetype AI_MINOR
ab2a1vw1 ab2a1vw2 ab2a1vw3 ab2a1vw4
schema_voice vape2 1 tolevelone (Sense Sight) (NearbyFriends 0 20)

//TO ALERT 1 +heard +w/co
schema ab2a1hw
archetype AI_MINOR
ab2a1hw1 ab2a1hw2 ab2a1hw3 ab2a1hw4 ab2a1hw5
schema_voice vape2 1 tolevelone (Sense Sound) (NearbyFriends 0 20)

//TO ALERT 2
schema ab2a2
archetype AI_MINOR
ab2a2__1 ab2a2__2 ab2a2__3 ab2a2__4 ab2a2__5 ab2a2__6
schema_voice vape2 1 toleveltwo  

//TO ALERT 2 +sighted
schema ab2a2v
archetype AI_MINOR
ab2a2v_1 ab2a2v_2
schema_voice vape2 1 toleveltwo (Sense Sight)  

//TO ALERT 2 +heard
schema ab2a2h
archetype AI_MINOR
ab2a2h_1 ab2a2h_2 
schema_voice vape2 1 toleveltwo (Sense Sound)

//AT ALERT 1
schema ab2at1
archetype AI_NONE
delay 5000
mono_loop 2000 8000
ab2snif1 ab2snif2 ab2snif3 silenc9s
schema_voice vape2 1 atlevelone (Investigate true)

//AT ALERT 2
schema ab2at2
archetype AI_MINOR
delay 5000
mono_loop 2000 8000
ab2snrt1 ab2snrt2 ab2snif1 ab2snif2 ab2snif3 silenc9s
schema_voice vape2 1 atleveltwo (Investigate true)

//AT ALERT 3
schema ab2at3
archetype AI_MAJOR
delay 5000
mono_loop 1000 5000
ab2snrt1 ab2snrt2 ab2snif1 ab2snif2 ab2snif3 
schema_voice vape2 1 atlevelthree (Investigate true)

//TO LEVEL THREE
schema ab2a3
archetype AI_MAJOR
ab2a3s_2 ab2grun1 ab2amb_4
schema_voice vape2 1 tolevelthree

//SPOTTED THE PLAYER
schema ab2a3s
archetype AI_MORE_MAJOR
ab2a3s_1 ab2a3s_2 ab2a3s_3 ab2a3s_4 
schema_voice vape2 1 spotplayer

//SPOTTED THE PLAYER
schema ab2a3na
archetype AI_MORE_MAJOR
ab2a3na1 ab2a3na2 ab2a3na3 
ab2a3na4 ab2a3na5 ab2a3na6 
schema_voice vape2 1 spotplayer

//SPOTTED THE PLAYER +carrying a body
schema ab2a3b
archetype AI_MORE_MAJOR
ab2a3b_1 
schema_voice vape2 9 spotplayer (CarryBody)

//REACT CHARGE
schema ab2chga
archetype AI_MORE_MAJOR
ab2chga1 ab2chga2 ab2chga3
schema_voice vape2 1 reactcharge

//REACT CHARGE +w/co
schema ab2chgw
archetype AI_COMBAT
ab2chgw1 ab2chgw2 ab2chgw3 ab2chgw4 ab2chgw5
schema_voice vape2 1 reactcharge (NearbyFriends 0 20)

//REACT RUN AWAY +alone
schema ab2runa
archetype AI_MAJOR
ab2runa1 ab2runa2 ab2runa3 ab2runa4 ab2runa5
schema_voice vape2 1 reactrun

//REACT I SOUND THE ALARMS +alone
schema ab2alma
archetype AI_MORE_MAJOR
ab2alma1 ab2alma2 ab2alma3
schema_voice vape2 1 reactalarm

//REACT I TELL YOU TO SOUND THE ALARMS +w/co
schema ab2almw
archetype AI_COMBAT
ab2almw1
schema_voice vape2 9 reactalarm (NearbyFriends 0 20)

//REACT TELL FRIEND BY REVELATION +w/co
schema ab2telr
archetype AI_COMBAT
ab2telr1 ab2telr2 ab2telr3 ab2telr4 ab2telr5
schema_voice vape2 3 spotplayer (NearbyFriends 0 20)

//REACT TELL FRIEND BY CONFIRMATION +w/co
schema ab2telc
archetype AI_COMBAT
ab2telc1 ab2telc2 ab2telc3
ab2telc4 ab2telc5 ab2telc6
schema_voice vape2 4 spotplayer (NearbyFriends 0 20) (Reacquire True)

//BACK TO ALERT 0
schema ab2bak
archetype AI_NONE
ab2bak_1 ab2bak_2 ab2bak_3 ab2bak_4
ab2bak_5 ab2bak_6 ab2bak_7 ab2bak_8 
schema_voice vape2 1 backtozero  

//LOST CONTACT W/PLAYER
schema ab2los
archetype AI_NONE
ab2los_1 ab2los_2 ab2los_3 ab2los_4
schema_voice vape2 1 lostcontact  

//FRUSTRATION
schema ab2frust
archetype AI_MAJOR
ab2det_1 ab2det_2 ab2det_3 ab2det_4 ab2amb_3
schema_voice vape2 1 outofreach

//NOTICED A TORCH BEING DOUSED
schema ab2torch
archetype AI_MINOR
delay 1000
ab2a1__1 ab2a1__2 ab2a1__4 ab2a1__5 ab2sma_2
schema_voice vape2 1 noticetorch




//FOUND BODY
schema ab2bod
archetype AI_MORE_MAJOR
ab2bod_1 ab2bod_2
schema_voice vape2 1 foundbody  

//FOUND SOMETHING MISSING
schema ab2mis
archetype AI_MAJOR
ab2mis_1 ab2mis_2 ab2mis_3
schema_voice vape2 1 foundmissing

//FOUND A SMALL ANOMALY
schema ab2sma
archetype AI_MINOR
ab2sma_1 ab2sma_2 ab2sma_3
schema_voice vape2 1 foundsmall  

//FOUND A LARGE ANOMALY
schema ab2lar
archetype AI_MAJOR
ab2lar_1 ab2lar_2 ab2lar_3
schema_voice vape2 1 foundlarge

//FOUND A SECURITY BREACH
schema ab2sec
archetype AI_MORE_MAJOR
ab2sec_1 ab2sec_2 ab2sec_3 ab2sec_4
schema_voice vape2 1 foundbreach

//RECENTLY SAW THE PLAYER +w/co
schema ab2rint
archetype AI_INFORM
ab2rint1 ab2rint2 ab2rint3
schema_voice vape2 1 recentintruder (NearbyFriends 0 20)

//RECENTLY FOUND BODY +w/co
schema ab2rbod
archetype AI_INFORM
ab2rbod1 ab2rbod2 ab2rbod3
schema_voice vape2 1 recentbody (NearbyFriends 0 20)

//RECENTLY FOUND SOMETHING MISSING +w/co
schema ab2rmis
archetype AI_INFORM
ab2rmis1 ab2rmis2 ab2rmis3
schema_voice vape2 1 recentmissing (NearbyFriends 0 20)

//RECENTLY FOUND MISC ANAMOLY +w/co
schema ab2roth
archetype AI_INFORM
ab2roth1 ab2roth2 ab2roth3 ab2roth4 ab2roth5
schema_voice vape2 1 recentother (NearbyFriends 0 20)

//COMBAT

//ATTACKING +not losing
schema ab2atn
archetype AI_COMBAT
ab2atn_1 freq 1
ab2atn_2 freq 1
ab2atn_3 freq 3
schema_voice vape2 1 comattack (ComBal Winning Even Losing)

//ATTACKING +winning
schema ab2atnw
archetype AI_COMBAT
ab2atw_1 ab2atw_2
schema_voice vape2 3 comattack (ComBal Winning)

//ATTACKING +winning +w/co
schema ab2atww
archetype AI_COMBAT
ab2atww1 
schema_voice vape2 3 comattack (ComBal Winning) (NearbyFriends 0 20)

//SUCCESSFULLY HIT THE PLAYER +not losing
schema ab2hit
archetype AI_COMBAT
ab2hit_1 ab2hit_2 ab2hit_3 ab2hit_4 ab2hit_5 ab2hit_6
schema_voice vape2 1 comsucchit (ComBal Winning Even)

//SUCCESSFULLY HIT THE PLAYER +not losing +w/co
schema ab2hit
archetype AI_COMBAT
ab2hitw1 ab2hitw2 ab2hitw3
schema_voice vape2 1 comsucchit (ComBal Winning Even) (NearbyFriends 0 20)

//SUCCESSFULLY BLOCKED THE PLAYER +not losing
schema ab2blk
archetype AI_COMBAT
ab2blk_1 ab2blk_2 ab2blk_3 ab2blk_4
schema_voice vape2 1 comsuccblock (ComBal Winning Even)

//SUCCESSFULLY BLOCKED THE PLAYER +not losing +w/co
schema ab2blkw
archetype AI_COMBAT
ab2blkw1
schema_voice vape2 1 comsuccblock (ComBal Winning Even) (NearbyFriends 0 20)

//HIT BY THE PLAYER W/HI HIT PTS 
schema ab2hhi
archetype AI_MAJOR
ab2hhi_1 ab2hhi_2 ab2hhi_3
schema_voice vape2 1 comhithigh

//HIT BY THE PLAYER W/LO PTS 
schema ab2hlo
archetype AI_MORE_MAJOR
ab2hlo_1 ab2hlo_2 ab2hlo_3 
schema_voice vape2 1 comhitlow

//HIT BY THE PLAYER W/LO PTS  +w/co
schema ab2hlow
archetype AI_COMBAT
ab2hlow1
schema_voice vape2 1 comhitlow (NearbyFriends 0 20)

//HIT BY THE PLAYER NO DAMAGE
schema ab2hnd
archetype AI_MAJOR
ab2hnd_1 ab2hnd_2 ab2hnd_3
schema_voice vape2 1 comhitnodam

//BLOCKED BY THE PLAYER +not losing
schema ab2bkd 
archetype AI_COMBAT
ab2bkd_1 ab2bkd_2 ab2bkd_3
schema_voice vape2 1 comblocked (ComBal Winning Even)

//BLOCKED BY THE PLAYER +not losing +w/co
schema ab2bkdw 
archetype AI_COMBAT
ab2bkdw1
schema_voice vape2 1 comblocked (ComBal Winning Even) (NearbyFriends 0 20)

//DETECTED PLAYER TRYING TO BLOCK +not losing
schema ab2det 
archetype AI_COMBAT
ab2det_1 ab2det_2 ab2det_3
schema_voice vape2 1 comdetblock(ComBal Winning Even)

//DETECTED PLAYER TRYING TO BLOCK +not losing +w/co
schema ab2detw 
archetype AI_COMBAT
ab2detw1
schema_voice vape2 1 comdetblock (ComBal Winning Even) (NearbyFriends 0 20)

//AMBUSHED -HIT BY UNSEEN PLAYER
schema ab2amb 
archetype AI_MAJOR
ab2amb_1 ab2amb_2 ab2amb_3 ab2amb_4
schema_voice vape2 1 comhitamb

//AMBUSHED -HIT BY UNSEEN PLAYER +w/co
schema ab2ambw
archetype AI_COMBAT
ab2ambw1 ab2ambw2 ab2ambw3
schema_voice vape2 1 comhitamb (NearbyFriends 0 20)

//DEATH BY COMBAT -LOUD
schema ab2diec
archetype AI_COMBAT
ab2diec1 ab2diec2 ab2diec3
schema_voice vape2 1 comdieloud

//DEATH (or knocked out) BY AMBUSH -MORE MUFFLED
schema ab2diea
archetype AI_MINOR
volume -500
ab2diea1 ab2diea2 ab2diea3
schema_voice vape2 1 comdiesoft



