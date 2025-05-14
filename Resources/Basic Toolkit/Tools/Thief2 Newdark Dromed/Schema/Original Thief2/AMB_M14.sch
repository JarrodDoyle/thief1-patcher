//MISSION 14  "PRECIOUS CARGO"

//CAVE LOOP
schema m14cave
archetype AMB_M14
mono_loop 0 0
volume -3900
nightlp3

//CAVE HITS
schema m14cavehit
archetype AMB_M14
mono_loop 1000 2500
volume -2200
cave1 cave2 cave3
cave4 cave5 cave6 
cave7 cave8 cave9
cave10


//DRIPS
schema m14drips
archetype AMB_M14
poly_loop 2 3000 5500
volume -3000
drip1 drip2 drip3 
drip4 drip5 drip6


//LO WIND
schema m14windlo
archetype AMB_M14
poly_loop 2 3000 5500
volume -3000
Wind1lo Wind2lo Wind3lo

//LO WIND
schema m14fridge
archetype AMB_M14
mono_loop 0 0
volume -2000
fridge1

//LIGHTHOUSE
schema m14lighthouse
archetype AMB_M14
mono_loop 0 0
volume -1000
Lhouse


//WIND GUSTY 
schema m14windhi
archetype AMB_M14
poly_loop 2 3000 4000
volume -1600
Wind4 Wind5

//SUB LEVEL AMB LOOP 
schema m14wail
archetype AMB_M14
mono_loop 0 0
volume -2000
L14_wail

//SUB LEVEL TENSION ONE OFF
schema m14tension1
archetype AMB_M14
volume -1200
tension1

//SUB LEVEL AMB LOOP 
schema m14rain
archetype AMB_M14
poly_loop 2 3000 5000
volume -1200
rain_lt1 rain_lt2 rain_lt3
rain_lt4 rain_lt5

//SUB LEVEL AMB LOOP loud 
schema m14rainL
archetype AMB_M14
poly_loop 2 3000 5000
volume -600
rain_lt1 rain_lt2 rain_lt3
rain_lt4 rain_lt5

//STEAMLOOP
schema M14steam
archetype AMB_M14
mono_loop 0 0
volume -1800
steamlp4 steamlp2 steamlp3

//INSIDE LOOP
schema m14insideL
archetype AMB_M14
poly_loop 2 5000 7000
volume -1700
no_repeat
L14wail1 L14wail2
L14wail3 L14wail4

//INSIDE HITS
schema m14hitsL
archetype AMB_M14
pan_range 2000
delay 3000
mono_loop 4000 7000
volume -1900
btrem1 btrem2 btrem3
btrem4 btrem5
L14wail1


