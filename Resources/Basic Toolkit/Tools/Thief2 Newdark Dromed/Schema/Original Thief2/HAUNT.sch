//HAMMER HAUNT BROADCASTS

//AT ALERT LEVEL ZERO
schema HH1a0
archetype AI_NONE
poly_loop 2 7500 12000
volume -1000
HH1a0mo1 HH1a0mo2 HH1a0mo3 HH1a0wh1 HH1a0wh2 HH1a0wh3 silenc3s silenc9s
schema_voice vhaunt 1 atlevelzero

//BACK TO ZERO
schema HH1bak
archetype AI_NONE
volume -500
HH1bak__1
schema_voice vhaunt 1 backtozero
schema_voice vhaunt 1 lostcontact

//TO ALERT LEVEL ONE & TWO
schema HH1to1
archetype AI_NONE
volume -300
HH1to1_1
schema_voice vhaunt 1 tolevelone
schema_voice vhaunt 1 toleveltwo
schema_voice vhaunt 1 tolevelthree
schema_voice vhaunt 1 comdieloud
schema_voice vhaunt 1 comdiesoft
schema_voice vhaunt 1 comhithigh
schema_voice vhaunt 1 comhitlow
schema_voice vhaunt 1 foundbody


//AT ALERT LEVEL ONE & TWO
schema HH1a1
archetype AI_NONE
poly_loop 2 4000 5000
volume -500
HH1a1__1 HH1a1__2 HH1a1__3 HH1a1__4 HH1a1__5 HH1a1__6 
schema_voice vhaunt 1 atlevelone
schema_voice vhaunt 1 atleveltwo

//TO ALERT LEVEL 3
schema HH1to3
archetype AI_MINOR  //poly_loop 2 2500 3500
no_repeat
volume -100
HH1a3__1 HH1a3__2 HH1a3__3 HH1a3__4 HH1a3__5 HH1a3__6
schema_voice vhaunt 1 spotplayer
schema_voice vhaunt 1 reactcharge
schema_voice vhaunt 1 comattack


//AT ALERT LEVEL 3
schema HH1a3
archetype AI_MINOR  
poly_loop 2 2500 3500
no_repeat
volume -100
HH1a3__1 HH1a3__2 HH1a3__3 HH1a3__4 HH1a3__5 HH1a3__6
schema_voice vhaunt 1 atlevelthree





