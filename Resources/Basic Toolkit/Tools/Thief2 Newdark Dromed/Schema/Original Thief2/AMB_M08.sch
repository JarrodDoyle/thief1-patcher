//MISSION 8  "COURIER"


//CICADS
schema m08cicads
archetype AMB_M08
poly_loop 2 4000 6000
delay 3000
pan_range 3000
volume -3200
cicad1 cicad2 cicad3 cicad4

//WIND
schema m08wind
archetype AMB_M08
poly_loop 2 3500 4500
pan_range 2500
volume -2400
wind1 wind2 wind3

//NIGHTLOOP
schema m08nightL
archetype AMB_M08
mono_loop 0 0
volume -2700
night1 night2 night3 night4 night5
cricket1 cricket2 cricket3 cricket4 cricket5 cricket6 cricket7

//DRIPS
schema m08drip
archetype AMB_M08
poly_loop 2 3500 4500
pan_range 2000
delay 3000
volume -2200
drip1 drip2 drip3 
drip4 drip5 drip6

//INSIDE LOOP
schema m08insideL
archetype AMB_M08
poly_loop 2 5000 6000
volume -600
no_repeat
amb_low1 amb_low2 amb_low3 amb_low4

//INSIDE HITS
schema m08hitsL
archetype AMB_M08
pan_range 3000
delay 3000
mono_loop 2000 4500
volume -1400
btrem1 btrem2 btrem3 btrem4 btrem5

//HOLLOW
schema m08hollow
archetype AMB_M08
mono_loop 0 0
volume -2200
windstil

//INSIDE HUM
schema m08in
archetype AMB_M08
mono_loop 0 0
volume -1800
hum

//TENSION IN GRAVEYARD
schema m08tension
archetype AMB_M08
poly_loop 2 8000 15000
pan_range 3000
volume -1200
tension1