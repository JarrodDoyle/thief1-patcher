//Servant 2

//Unaware (Alert Level 0)
schema sv2a0hu
archetype AI_NONE
no_repeat
mono_loop 3000 15000
volume -500
sv2a0hu1 sv2a0hu2 sv2a0hu3
sv2a0hu4
schema_voice normal2 2 atlevelzero

schema sv2a0wh
archetype AI_NONE
mono_loop 3000 15000
no_repeat
volume -500
sv2a0co1 sv2a0co2 sv2a0co3
sv2a0co4 sv2a0co5 sv2a0co6
schema_voice normal2 1 atlevelzero

//Sleeping
schema sv2a0sn
archetype AI_NONE
mono_loop 1000 2000
sv2a0sn1 sv2a0sn2
schema_voice normal2 1 sleeping 

//to Alert Level 1
schema sv2a1
archetype AI_NONE
sv2a1__1 sv2a1__2 sv2a1__3 sv2a1__4
schema_voice normal2 1 tolevelone  

//to Alert Level 1 +heard
schema sv2a1h
archetype AI_NONE
sv2a1h_1 sv2a1h_2
schema_voice normal2 2 tolevelone (Sense Sound)

//to Alert Level 1 +sighted
schema sv2a1v
archetype AI_NONE
sv2a1v_1 sv2a1v_2
schema_voice normal2 1 tolevelone (Sense Sight)

//to Alert Level 2
schema sv2a2
archetype AI_MINOR
sv2a2__1 sv2a2__2 sv2a2__3 
schema_voice normal2 1 toleveltwo  

//to Alert Level3
schema sv2a3
archetype AI_MAJOR
sv2a2__4
schema_voice normal2 1 tolevelthree  

//Spotted the player
schema sv2a3s
archetype AI_MORE_MAJOR
sv2a3s_1 sv2a3s_2 sv2a3s_3 sv2a3s_4
schema_voice normal2 1 spotplayer 

//Spotted the player +w/co
schema sv2a3sw
archetype AI_COMBAT
sv2telc1 sv2telc2 sv2telc3
schema_voice normal2 3 spotplayer (NearbyFriends 0 20) 

//Spotted the player +CarryBody
schema sv2a3b
archetype AI_MORE_MAJOR
sv2a3b_1
schema_voice normal2 9 spotplayer (CarryBody True)

//React run away
schema sv2run
archetype AI_MAJOR
sv2run_1 sv2run_2 sv2run_3 sv2run_4 sv2run_5 sv2run_6
schema_voice normal2 1 reactrun


//React tell friend to sound alarm
schema sv2almw
archetype AI_MORE_MAJOR
sv2almw1
schema_voice normal2 1 reactalarm (NearbyFriends 0 20)

//Back to Alert 0
schema sv2bak
archetype AI_NONE
sv2bak_1 sv2bak_2 sv2bak_3 sv2bak_4 sv2bak_5 sv2bak_6 sv2bak_7
schema_voice normal2 1 backtozero

//Noticed a torch being doused
schema sv2torch
archetype AI_MINOR
delay 1000
Sv2a1__1 Sv2a1__2 Sv2a1__3 Sv2a2__1
schema_voice normal2 1 noticetorch

//Found a body
schema sv2bod
archetype AI_MORE_MAJOR
sv2bod_1 sv2bod_2 sv2bod_3 sv2bod_4
schema_voice normal2 1 foundbody

//Found a large anomaly
schema sv2lar
archetype AI_MAJOR
sv2lar_1 sv2lar_2
schema_voice normal2 1 foundlarge

//Found a small anomaly
schema sv2sma
archetype AI_MINOR
sv2sma_1 sv2sma_2
schema_voice normal2 1 foundsmall

//Found something missing
schema sv2mis
archetype AI_MAJOR
sv2mis_1 sv2mis_2 sv2mis_3
schema_voice normal2 1 foundmissing

//Found security breach
schema sv2sec
archetype AI_MORE_MAJOR
sv2sec_1 sv2sec_2
schema_voice normal2 1 foundbreach

//Recently saw an intruder
schema sv2rint
archetype AI_INFORM
sv2rint1 sv2rint2
schema_voice normal2 1 recentintruder

//Recently found a body
schema sv2rbod
archetype AI_INFORM
sv2rbod1
schema_voice normal2 1 recentbody

//Recently found something missing
schema sv2rmis
archetype AI_INFORM
sv2rmis1 sv2rmis2
schema_voice normal2 1 recentmissing

//Recent found other
schema sv2roth
archetype AI_INFORM
sv2roth1 sv2roth2
schema_voice normal2 1 recentother

//Hit by the player
schema sv2hit
archetype AI_MORE_MAJOR
sv2hlo_1 sv2hlo_3 sv2hlo_3
schema_voice normal2 1 comhitlow
schema_voice normal2 1 comhithigh

//Hit by the player +w/co
schema sv2hitw
archetype AI_MORE_MAJOR
sv2hlow1
schema_voice normal2 2 comhitlow (NearbyFriends 0 20)
schema_voice normal2 2 comhithigh (NearbyFriends 0 20)

//Die in Combat -Loud
schema sv2diec
archetype AI_COMBAT
sv2diec1 sv2diec2 sv2diec3
schema_voice normal2 1 comdieloud

//Die/Knocked out soft
schema sv2diea
archetype AI_MINOR
volume -500
sv2diea1 sv2diea2
schema_voice normal2 1 comdiesoft

//MISSION SPECIFIC

//Carrying the tray, complaining about Ramirez
//schema sv2m0501
//archetype AI_NONE
//play_once
//volume -1
//sv2m0501 sv2m0502
//schema_voice normal2 1 sv_m0501

//Ramirez is missing
schema sv2m0503
archetype AI_NONE
play_once
volume -1
sv2m0503
schema_voice normal2 1 sv_m0503

