//RAMIREZ -a lout

//AT ALERT 0 
schema RMZa0
archetype AI_NONE
volume -500
mono_loop 3000 20000
rmza0wh1 freq 6
rmza0wh2 freq 6
rmza0mu1 freq 1
schema_voice vRamirez 1 atlevelzero

//TO ALERT 1
schema RMZa1
archetype AI_MINOR
rmza1__1
schema_voice vRamirez 1 tolevelone  

//TO ALERT 1 +sighted
schema RMZa1v
archetype AI_MINOR
rmza1v_1
schema_voice vRamirez 1 tolevelone (Sense Sight)

//TO ALERT 1 +heard
schema RMZa1h
archetype AI_MINOR
Rmza1h_1
schema_voice vRamirez 2 tolevelone (Sense Sound)

//TO ALERT 1 +w/co
schema RMZa1_w
archetype AI_MINOR
Rmza1_w1
schema_voice vRamirez 2 tolevelone (NearbyFriends 0 10)

//TO ALERT 1 +sighted +w/co
schema RMZa1vw
archetype AI_MINOR
rmza1vw1
schema_voice vRamirez 2 tolevelone (NearbyFriends 0 10) (Sense Sight) 

//TO ALERT 1 +heard +w/co
schema RMZa1hw
archetype AI_MINOR
rmza1hw1
schema_voice vRamirez 3 tolevelone (NearbyFriends 0 10) (Sense Sound) 

//TO ALERT 2
schema RMZa2
archetype AI_MAJOR
rmza2__1
schema_voice vRamirez 1 toleveltwo  

//TO ALERT 2 +sighted
schema RMZa2v
archetype AI_MAJOR
rmza2v_1
schema_voice vRamirez 1 toleveltwo (Sense Sight)  

//TO ALERT 2 +heard
schema RMZa2h
archetype AI_MAJOR
rmza2h_1
schema_voice vRamirez 2 toleveltwo (Sense Sound)

//SPOTTED THE PLAYER +startled
schema RMZa3s
archetype AI_MORE_MAJOR
rmza3s_1
schema_voice vRamirez 1 spotplayer 

//SPOTTED THE PLAYER 
schema RMZa3na
archetype AI_MORE_MAJOR
rmza3na1
schema_voice vRamirez 1 spotplayer 

//REACT CHARGE
schema RMZchg
archetype AI_MORE_MAJOR
rmzchg_1
schema_voice vRamirez 1 reactcharge

//REACT RUN AWAY +alone
schema RMZruna
archetype AI_MORE_MAJOR
rmzruna1
schema_voice vRamirez 1 reactrun 

//REACT I SOUND THE ALARMS +alone
schema RMZalma
archetype AI_MORE_MAJOR
rmzalma1
schema_voice vRamirez 1 reactalarm

//BACK TO ALERT 0
schema RMZbak
archetype AI_NONE
rmzbak_1
schema_voice vRamirez 1 backtozero  

//LOST CONTACT W/PLAYER
schema RMZlos
archetype AI_MAJOR
rmzlos_1
schema_voice vRamirez 1 lostcontact  

//FOUND BODY
schema RMZbod
archetype AI_MORE_MAJOR
rmzbod_1
schema_voice vRamirez 1 foundbody  

//FOUND SOMETHING MISSING
schema RMZmis
archetype AI_MORE_MAJOR
rmzmis_1
schema_voice vRamirez 1 foundmissing

//FOUND A SMALL ANOMALY
schema RMZsma
archetype AI_MINOR
rmzsma_1
schema_voice vRamirez 1 foundsmall  

//FOUND A LARGE ANOMALY
schema RMZlar
archetype AI_MAJOR
rmzlar_1
schema_voice vRamirez 1 foundlarge

//FOUND A SECURITY BREACH
schema RMZsec
archetype AI_MORE_MAJOR
rmzsec_1
schema_voice vRamirez 1 foundbreach


//COMBAT

//HIT BY THE PLAYER W/HI HIT PTS 
schema RMZhhi
archetype AI_COMBAT
Rmzhhi_1 Rmzhhi_2 Rmzhhi_3
schema_voice vRamirez 1 comhithigh
schema_voice vRamirez 1 comhitnodam
schema_voice vRamirez 1 comhitamb

//HIT BY THE PLAYER W/HI LO PTS 
schema RMZhlo
archetype AI_COMBAT
rmzhlo_1 rmzhlo_2 rmzhlo_3
schema_voice vRamirez 1 comhitlow

//HIT BY THE PLAYER W/HI LO PTS  +w/co
schema RMZhlow
archetype AI_COMBAT
rmzhlow1
schema_voice vRamirez 2 comhitlow (NearbyFriends 0 10)

//DEATH BY COMBAT -LOUD
schema RMZdiec
archetype AI_COMBAT
rmzdiec1
schema_voice vRamirez 1 comdieloud

//DEATH (or knocked out) BY AMBUSH -MORE MUFFLED
schema RMZdiea
archetype AI_MINOR
volume -500
rmzdiea1
schema_voice vRamirez 1 comdiesoft



