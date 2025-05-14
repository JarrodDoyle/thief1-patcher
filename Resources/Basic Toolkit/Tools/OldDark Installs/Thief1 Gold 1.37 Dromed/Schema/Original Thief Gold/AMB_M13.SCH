//MISSION 13 UNDERSEIGE

//WIND
schema m13wind
archetype AMB_M13
poly_loop 2 5000 5500  
pan_range 3000
volume -1000   
wind1lo wind2lo wind3lo

//WIND TRANS
schema m13trans
archetype AMB_M13
mono_loop 0 0
volume -1000
windstil

//WIND SOFT
schema m13wind_p
archetype AMB_M13
mono_loop 0 0
volume -1500
mines2

//BELL THUMP
schema m13bellthump
archetype AMB_M13
volume -500
bellthmp

//FRONT GATE CUE1
schema m13cue1
archetype AMB_M13
volume -1000
tension1

//EEES
schema m13eees
archetype AMB_M13
volume -1500
mono_loop 0 0
eees1 eees2 eees3

//SUBSONIC
schema m13subson1
archetype AMB_M13
mono_loop 0 0
volume -300
subson1

//RUMBLES
schema m13rumbles
archetype AMB_M13
poly_loop 2 6000 30000
delay 3000
pan_range 2500
volume -1000
rumble1 rumble2 rumble3

//GARDEN GROWLS
schema m13gr
archetype AMB_M14
volume -2000
delay 3000
pan_range 2500
poly_loop 2 1000 30000
gr1 gr2 gr3 gr4 gr5 gr6 gr7 gr8 gr9

//DRIPS
schema m13drips
archetype AMB_M14
volume -2700
pan_range 2500
poly_loop 2 1000 8000
drip1 drip2 drip3

//EERIE CUES
schema m13eerie
archetype AMB_M14
volume -800
voceerie howltxta howltxtb


//DOWN THE WELL TRANS
schema m13well
archetype AMB_M13
mono_loop 0 0
volume -1000
caveamb

//UNDERGROUND
schema m13ug
archetype AMB_M13
mono_loop 0 0
volume -350
subson2

//UNDERGROUND LO VOICE
schema m13lo
archetype AMB_M13
delay 2000
poly_loop 2 5000 30000
pan_range 2500
volume -1500
lo1 lo2 lo3 lo4 lo5


//CICADAS
schema m13cicadas
archetype AMB_M14
volume -3000
poly_loop 2 2000 8000
cicad1 cicad2 cicad3 cicad4

//m13vooh
schema m13vooh
archetype AMB_M14
mono_loop 30000 30000
volume -1500
vooh

//WATERCALM
schema m13watercalm
archetype AMB_M14
volume -1500
mono_loop 0 0
waterlp2

//WATER
schema m13water
archetype AMB_M14
volume -1500
mono_loop 0 0
waterlp1

//WATERFALL
schema m13waterfall
archetype AMB_M14
volume -1000
mono_loop 0 0
waterfal

