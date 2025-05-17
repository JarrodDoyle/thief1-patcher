//MISSION 7

//LEVEL 1

//LEVEL1 AMB
schema m07L1
archetype AMB_M07
volume -1400
mono_loop 0 0
windstil

//FEEDBACK
schema m07fb
archetype AMB_M07
volume -1800
pan_range 2500
poly_loop 2 3000 5000
fb1 fb2 fb3 fb4

//CRICKETS
schema m07crickets
archetype AMB_M07
volume -2400
mono_loop 0 0
crickets

//NIGHTLOOP
schema m07nightlp
archetype AMB_M07
volume -2400
mono_loop 0 0
nightlp

//CUE1
schema m07cue
archetype AMB_M07
volume -1300
howltxta howltxtb voceerie 

//LEVEL2 AMB
schema m07L2
archetype AMB_M07
volume -800
mono_loop 0 0
subson1



//QUEST2 -two pedestals
schema m07organ
archetype AMB_M07
volume -1500
pan_range 2500
no_repeat
poly_loop 2 8200 8200
organ1 organ2


//TRANS TO CAVES
schema m07trans
archetype AMB_M07
mono_loop 0 0
volume -2000
caveamb

//CAVES
schema m07caves
archetype AMB_M07
poly_loop 2 3000 4000
volume -1500
pan_range 2500
cave1 cave2 cave3

//BIG CAVE
schema m07drips
archetype AMB_M07
poly_loop 2 2000 10000
delay 2000
volume -2500
drip1 drip2 drip3 squeaks

//OUTSIDE WIND
schema m07wind
archetype AMB_M03
poly_loop 2 3000 4000
pan_range 2000
volume -1200
wind1 freq 5
wind2 freq 5
wind3 freq 5
wind4 freq 1
wind5 freq 1


//HAUNTS
schema m07haunts
archetype AMB_M07
poly_loop 2 7500 30000
no_repeat
pan_range 2400
volume -2100
HH1a0mo1 HH1a0mo2 HH1a0mo3 HH1a0wh1 HH1a0wh2 HH1a0wh3

//BELLTHUMP
schema m07bellthump
archetype AMB_M07
volume -500
mono_loop 0 0
bellthmp




//WATER

schema m07watercalm
archetype AMB_M07
mono_loop 0 0
volume -1500
waterlp2

schema m07water
archetype AMB_M07
mono_loop 0 0
volume -1500
waterlp1

schema m07waterfall
archetype AMB_M07
mono_loop 0 0
volume -1500
waterfal

