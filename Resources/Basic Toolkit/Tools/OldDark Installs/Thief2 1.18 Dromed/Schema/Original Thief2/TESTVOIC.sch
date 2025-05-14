//TEST VOICE

//-----------------------------------------------------------

//ASLEEP
schema t1asleep
archetype AI_NONE
volume -500
mono_loop 2000 3000
t1asleep
schema_voice vtest 1 sleeping

//AT ALERT 0 
schema t1at0
archetype AI_NONE
volume -1
mono_loop 1000 1000
t1at0
schema_voice vtest 1 atlevelzero

//-----------------------------------------------------------

//TO ALERT 1
schema t1to1
archetype AI_MINOR
t1to1
schema_voice vtest 1 tolevelone  

//TO ALERT 1 +heard
schema t1to1h
archetype AI_MINOR
t1to1h
schema_voice vtest 3 tolevelone  (Sense Sound)

//TO ALERT 1 +sighted
schema t1to1v
archetype AI_MINOR
t1to1v
schema_voice vtest 1 tolevelone  (Sense Sight)

//TO ALERT 1 +w/co
schema t1to1_w
archetype AI_MINOR
t1to1_w
schema_voice vtest 3 tolevelone  (NearbyFriends 0 20)

//TO ALERT 1 +heard +w/co
schema t1to1hw
archetype AI_MINOR
t1to1hw
schema_voice vtest 3 tolevelone  (Sense Sound) (NearbyFriends 0 20)

//TO ALERT 1 +sighted +w/co
schema t1to1vw
archetype AI_MINOR
t1to1vw
schema_voice vtest 3 tolevelone  (Sense Sight) (NearbyFriends 0 20)

//AT ALERT 1
schema t1at1inv
archetype AI_MINOR
delay 5000
mono_loop 10000 20000
t1at1in
schema_voice vtest 9 atlevelone (Investigate True)

//AT ALERT 1
schema t1at1
archetype AI_MINOR
delay 5000
mono_loop 5000 20000
t1at1
schema_voice vtest 1 atlevelone

//-----------------------------------------------------------

//TO ALERT 2
schema t1to2
archetype AI_MAJOR
t1to2
schema_voice vtest 1 toleveltwo

//TO ALERT 2 +heard
schema t1to2h
archetype AI_MAJOR
t1to2h
schema_voice vtest 2 toleveltwo (Sense Sound)

//TO ALERT 2 +sighted
schema t1to2v
archetype AI_MAJOR
t1to2v
schema_voice vtest 1 toleveltwo (Sense Sight)

//AT ALERT 2 INVESTIGATING
schema t1at2inv
archetype AI_MAJOR
delay 5000
mono_loop 10000 20000
t1at2in
schema_voice vtest 9 atleveltwo (Investigate True)

//AT ALERT 2
schema t1at2
archetype AI_MAJOR
delay 5000
mono_loop 20000 30000
t1at2
schema_voice vtest 1 atleveltwo

//-----------------------------------------------------------

//TO ALERT 3
schema t1to3
archetype AI_MORE_MAJOR
t1to3
schema_voice vtest 1 tolevelthree 

//SPOTTED THE PLAYER 
schema t1spot
archetype AI_MORE_MAJOR
t1spot
schema_voice vtest 1 spotplayer 

//SPOTTED THE PLAYER +body
schema t1spotb
archetype AI_MORE_MAJOR
t1spotb
schema_voice vtest 9 spotplayer (CarryBody)

//SPOTTED THE PLAYER +w/co
schema t1spotw
archetype AI_MORE_MAJOR
t1spotw
schema_voice vtest 3 spotplayer (NearbyFriends 0 20)

//SPOTTED THE PLAYER +w/co AGAIN
schema t1spotwr
archetype AI_MORE_MAJOR
t1spotwr
schema_voice vtest 4 spotplayer (NearbyFriends 0 20) (Reacquire true)

//AT ALERT 3 INVESTIGATING
schema t1at3inv
archetype AI_MAJOR
delay 5000
mono_loop 10000 20000
t1at3inv
schema_voice vtest 9 atlevelthree (Investigate True)

//AT ALERT 3
schema t1at3
archetype AI_MAJOR
delay 5000
mono_loop 5000 20000
t1at3
schema_voice vtest 1 atlevelthree

//-----------------------------------------------------------

//REACT 1ST WARNING
schema t1rwarn
archetype AI_MINOR
t1rwarn
schema_voice vtest 1 reactwarn

//REACT 2ND WARNING
schema t1rwarn2
archetype AI_MAJOR
t1rwarn2
schema_voice vtest 1 reactwarn2

//REACT CHARGE
schema t1rchg
archetype AI_MORE_MAJOR
t1rchg
schema_voice vtest 1 reactcharge 

//REACT CHARGE +w/co
schema t1rchgw
archetype AI_MORE_MAJOR
t1rchgw
schema_voice vtest 2 reactcharge (NearbyFriends 0 20)

//REACT SHOOT
schema t1rshoot
archetype AI_MORE_MAJOR
t1rshoot
schema_voice vtest 1 reactshoot

//REACT FRUSTRATION
schema t1rfrust
archetype AI_MORE_MAJOR
t1rfrust
schema_voice vtest 1 outofreach

//REACT RUN AWAY 
schema t1rrun
archetype AI_MAJOR
t1rrun
schema_voice vtest 1 reactrun 

//REACT I SOUND THE ALARM
schema t1ralarm
archetype AI_MAJOR
t1ralarm
schema_voice vtest 1 reactalarm 

//REACT YOU GO SOUND THE ALARM +w/co
schema t1ralarw
archetype AI_MORE_MAJOR
t1ralarw
schema_voice vtest 5 reactalarm (NearbyFriends 0 20)

//-----------------------------------------------------------

//BACK TO ALERT 0
schema t1back
archetype AI_NONE
t1bak
schema_voice vtest 1 backtozero  

//LOST CONTACT W/PLAYER
schema t1lost
archetype AI_MINOR
t1los
schema_voice vtest 1 lostcontact  

//NOTICE EXTINGUISHED TORCH
schema t1ntorch
archetype AI_NONE
t1ntorch
schema_voice vtest 1 notice (Item Torch)  

//NOTICE GENERIC SUSPICIOUS ITEM 
schema t1ngeneric
archetype AI_NONE
t1ngen
schema_voice vtest 1 notice (Item Generic)  

//-----------------------------------------------------------

//FOUND BODY
schema t1foubod
archetype AI_MORE_MAJOR
t1foubod
schema_voice vtest 1 foundbody  

//FOUND DESTROYED ROBOT
schema t1foubot
archetype AI_MORE_MAJOR
t1foubot
schema_voice vtest 1 foundrobot  

//FOUND SOMETHING MISSING
schema t1foumis
archetype AI_MAJOR
t1foumis
schema_voice vtest 1 foundmissing

//FOUND A SMALL ANOMALY
schema t1fousma
archetype AI_MINOR
t1fousma
schema_voice vtest 1 foundsmall  

//FOUND A LARGE ANOMALY
schema t1foular
archetype AI_MAJOR
t1foular
schema_voice vtest 1 foundlarge

//FOUND A SECURITY BREACH
schema t1foubre
archetype AI_MORE_MAJOR
t1fousec
schema_voice vtest 1 foundbreach

//-----------------------------------------------------------

//RECENTLY SAW THE PLAYER 
schema t1recint
archetype AI_INFORM
t1recint
schema_voice vtest 1 recentintruder

//RECENTLY FOUND BODY
schema t1recbod
archetype AI_INFORM
t1recbod
schema_voice vtest 1 recentbody

//RECENTLY FOUND DEAD ROBOT
schema t1recbot
archetype AI_INFORM
t1recbot
schema_voice vtest 1 recentrobot

//RECENTLY FOUND SOMETHING MISSING
schema t1recmis
archetype AI_INFORM
t1recmis
schema_voice vtest 1 recentmissing

//RECENTLY FOUND MISC ANAMOLY
schema t1recoth
archetype AI_INFORM
t1recoth
schema_voice vtest 1 recentother

//-----------------------------------------------------------

//COMBAT

//ATTACKING +not losing
schema t1att
archetype AI_COMBAT
t1att
schema_voice vtest 1 comattack (ComBal Winning Even)

//ATTACKING +not losing +w/co
schema t1att_w
archetype AI_COMBAT
t1att_w
schema_voice vtest 2 comattack (ComBal Winning Even) (NearbyFriends 0 20)

//ATTACKING +winning
schema t1attw
archetype AI_COMBAT
t1attw
schema_voice vtest 2 comattack (ComBal Winning)

//ATTACKING +winning +w/co
schema t1attw
archetype AI_COMBAT
t1attw
schema_voice vtest 2 comattack (ComBal Winning) (NearbyFriends 0 20)

//ATTACKING +losing
schema t1attl
archetype AI_COMBAT
t1attl
schema_voice vtest 1 comattack (ComBal Losing)

//ATTACKING +losing +w/co
schema t1attlw
archetype AI_COMBAT
t1attlw
schema_voice vtest 2 comattack (ComBal Losing) (NearbyFriends 0 20)

//-----------------------------------------------------------

//SUCCESSFULLY HIT THE PLAYER 
schema t1suchit
archetype AI_COMBAT
t1suchit
schema_voice vtest 1 comsucchit 

//SUCCESSFULLY HIT THE PLAYER +w/co
schema t1suchiw
archetype AI_COMBAT
t1suchiw
schema_voice vtest 2 comsucchit (NearbyFriends 0 20)

//SUCCESSFULLY BLOCKED THE PLAYER 
schema t1sucblo
archetype AI_COMBAT
t1sucblo
schema_voice vtest 1 comsuccblock

//SUCCESSFULLY BLOCKED THE PLAYER +w/co
schema t1sucblw
archetype AI_COMBAT
t1sucblw
schema_voice vtest 2 comsuccblock (NearbyFriends 0 20)

//-----------------------------------------------------------

//HIT BY THE PLAYER W/HI HIT PTS 
schema t1hhi
archetype AI_COMBAT
t1hhi
schema_voice vtest 1 comhithigh

//HIT BY THE PLAYER W/HI HIT PTS 
schema t1hhiw
archetype AI_COMBAT
t1hhiw
schema_voice vtest 2 comhithigh (NearbyFriends 0 20)

//HIT BY THE PLAYER W/HI LO PTS 
schema t1hlo
archetype AI_COMBAT
t1hlo
schema_voice vtest 1 comhitlow

//HIT BY THE PLAYER W/HI LO PTS +w/co
schema t1hlow
archetype AI_COMBAT
t1hlow
schema_voice vtest 2 comhitlow (NearbyFriends 0 20)

//HIT BY THE PLAYER NO DAMAGE
schema t1hnodam
archetype AI_COMBAT
t1hnodam
schema_voice vtest 1 comhitnodam

//-----------------------------------------------------------

//BLOCKED BY THE PLAYER
schema t1blkd
archetype AI_COMBAT
t1blkd
schema_voice vtest 1 comblocked

//BLOCKED BY THE PLAYER +w/co
schema t1blkdw
archetype AI_COMBAT
t1blkdw
schema_voice vtest 2 comblocked (NearbyFriends 0 20)

//DETECTED PLAYER TRYING TO BLOCK +not losing
schema t1detblo
archetype AI_COMBAT
t1detblo
schema_voice vtest 1 comdetblock (Combal Winning Even)

//DETECTED PLAYER TRYING TO BLOCK +not losing +w/co
schema t1detblw
archetype AI_COMBAT
t1detblw
schema_voice vtest 2 comdetblock (Combal Winning Even) (NearbyFriends 0 20)

//-----------------------------------------------------------

//AMBUSHED -HIT BY UNSEEN PLAYER
schema t1hamb 
archetype AI_COMBAT
t1hamb
schema_voice vtest 1 comhitamb

//AMBUSHED -HIT BY UNSEEN PLAYER +w/co
schema t1hambw
archetype AI_COMBAT
t1hambw
schema_voice vtest 2 comhitamb (NearbyFriends 0 20)

//DEATH BY COMBAT -LOUD
schema t1diec
archetype AI_COMBAT
t1diec
schema_voice vtest 1 comdieloud

//DEATH (or knocked out) BY AMBUSH -MORE MUFFLED
schema t1diea
archetype AI_MINOR
volume -500
t1diea
schema_voice vtest 1 comdiesoft

//-----------------------------------------------------------
//-----------------------------------------------------------