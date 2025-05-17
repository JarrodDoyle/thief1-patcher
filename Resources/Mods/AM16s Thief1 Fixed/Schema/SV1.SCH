//Servant 1

//Unaware (Alert Level 0)
schema sv1a0hu
archetype AI_NONE
no_repeat
mono_loop 3000 15000
volume -500
sv1a0hu1 sv1a0hu2 sv1a0hu3
sv1a0hu4 sv1a0hu5
schema_voice normal1 2 atlevelzero

schema sv1a0wh
archetype AI_NONE
mono_loop 3000 15000
volume -500
sv1a0wh1 sv1a0wh2 sv1a0wh3
sv1a0wh4
schema_voice normal1 1 atlevelzero

//Sleeping
schema sv1a0sn
archetype AI_NONE
mono_loop 1000 2000
sv1a0sn1 freq 3
sv1a0sn2 freq 1
sv1a0sn3 freq 3
sv1a0sn4 freq 1
schema_voice normal1 1 sleeping 

//to Alert Level 1
schema sv1a1
archetype AI_NONE
sv1a1__1 sv1a1__2 sv1a1__3 sv1a1__4
schema_voice normal1 1 tolevelone  

//to Alert Level 1 +heard
schema sv1a1h
archetype AI_NONE
sv1a1h_1 sv1a1h_2 sv1a1h_3
schema_voice normal1 1 tolevelone (Sense Sound)

//to Alert Level 1 +sighted
schema sv1a1v
archetype AI_NONE
sv1a1v_1 sv1a1v_2 sv1a1v_3
schema_voice normal1 2 tolevelone (Sense Sight)

//to Alert Level 2
schema sv1a2
archetype AI_MINOR
sv1a2__1 sv1a2__2 sv1a2__3 sv1a2__4
schema_voice normal1 1 toleveltwo  

//to Alert Level3
schema sv1a3
archetype AI_MAJOR
sv1a3__1
schema_voice normal1 1 tolevelthree  

//Spotted the player
schema sv1a3s
archetype AI_MORE_MAJOR
sv1a3s_1 sv1a3s_2 sv1a3s_3 sv1a3s_4
schema_voice normal1 1 spotplayer 

//Spotted the player +w/co
schema sv1a3sw
archetype AI_COMBAT
sv1telc1 sv1telc2
schema_voice normal1 5 spotplayer (NearbyFriends 0 20) 

//Spotted the player +CarryBody
schema sv1a3b
archetype AI_MORE_MAJOR
sv1a3b_1
schema_voice normal1 9 spotplayer (CarryBody True)

//React run away
schema sv1run
archetype AI_MAJOR
sv1run_1 sv1run_2 sv1run_3 sv1run_4 sv1run_5 sv1run_6
schema_voice normal1 1 reactrun


//React tell friend to sound alarm
schema sv1almw
archetype AI_MORE_MAJOR
sv1almw1
schema_voice normal1 1 reactalarm (NearbyFriends 0 20)

//Back to Alert 0
schema sv1bak
archetype AI_NONE
sv1bak_1 sv1bak_2 sv1bak_3 sv1bak_4 sv1bak_5 sv1bak_6 sv1bak_7
schema_voice normal1 1 backtozero

//Noticed a torch being doused
schema sv1torch
archetype AI_MINOR
delay 1000
Sv1a1__1 Sv1a1__4 Sv1bak_1 Sv1bak_4 Sv1sma_1
schema_voice normal1 1 noticetorch

//Found a body
schema sv1bod
archetype AI_MORE_MAJOR
sv1bod_1 sv1bod_2 sv1bod_3 sv1bod_4
schema_voice normal1 1 foundbody

//Found a small anomaly
schema sv1sma
archetype AI_MINOR
sv1sma_1 sv1sma_2
schema_voice normal1 1 foundsmall

//Found a large anomaly
schema sv1lar
archetype AI_MAJOR
sv1lar_1 sv1lar_2
schema_voice normal1 1 foundlarge

//Found something missing
schema sv1mis
archetype AI_MAJOR
sv1mis_1 sv1mis_2 sv1mis_3
schema_voice normal1 1 foundmissing

//Found security breach
schema sv1sec
archetype AI_MORE_MAJOR
sv1sec_1 sv1sec_2
schema_voice normal1 1 foundbreach

//Recently saw an intruder
schema sv1rint
archetype AI_INFORM
sv1rint1 sv1rint2 sv1rint3
schema_voice normal1 1 recentintruder

//Recently found a body
schema sv1rbod
archetype AI_INFORM
sv1rbod1
schema_voice normal1 1 recentbody

//Recently found something missing
schema sv1rmis
archetype AI_INFORM
sv1rmis1 sv1rmis2
schema_voice normal1 1 recentmissing

//Recent found other
schema sv1roth
archetype AI_INFORM
sv1roth1 sv1roth2
schema_voice normal1 1 recentother

//Hit by the player
schema sv1hit
archetype AI_MAJOR
sv1hlo_1 sv1hlo_3 sv1hlo_3
schema_voice normal1 1 comhitlow
schema_voice normal1 1 comhithigh

//Hit by the player +w/co
schema sv1hitw
archetype AI_MORE_MAJOR
sv1hlow1
schema_voice normal1 2 comhitlow (NearbyFriends 0 20)
schema_voice normal1 2 comhithigh (NearbyFriends 0 20)

//Die in Combat -Loud
schema sv1diec
archetype AI_COMBAT
sv1diec1 sv1diec2 sv1diec3
schema_voice normal1 1 comdieloud

//Die/Knocked out soft
schema sv1diea
archetype AI_MINOR
volume -500
sv1diea1 sv1diea2 sv1diea3
schema_voice normal1 1 comdiesoft

//MISSION SPECIFIC

//Carrying the tray, complaining about Ramirez
schema sv1m0501
archetype AI_NONE
play_once
volume -1
sv1m0501
schema_voice normal1 1 sv_m0501

//Ramirez is missing
schema sv1m0503
archetype AI_NONE
play_once
volume -1
sv1m0503
schema_voice normal1 1 sv_m0503


