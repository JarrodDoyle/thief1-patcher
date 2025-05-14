//MISSION 1  "INTERFERENCE"

//WIND
schema m01wind
archetype AMB_M01
volume -3000
pan_range 2500
poly_loop 2 4000 5000
windlit1 windlit2 windlit3 windlit4

//CRICKETS
schema m01crickets
archetype AMB_M01
mono_loop 0 0
volume -2200 //was -3000
cricket1 cricket2 cricket3 cricket4 cricket5 cricket6 cricket7

//NIGHT
schema m01night
archetype AMB_M01
mono_loop 0 0
volume -2200 //was -3000
night1 night2 night3 night4 night5

//TRANSITION & TUNNELS
schema m01trans
archetype AMB_M01
mono_loop 0 0
volume -1200
windstil

//INSIDE
schema m01inside
archetype AMB_M01
mono_loop 0 0
volume -1500
hum

//TURBINES
schema m01turbine
archetype AMB_M01
mono_loop 0 0
volume -800
tempturb
  
//PIPES
schema m01pipes
archetype AMB_M01
mono_loop 0 0
volume -1000
pipelp2

//2nd FLOOR
schema m01drone
archetype AMB_M01
mono_loop 0 0
volume -1200
m01drone

//3rd FLOOR TONES
schema m01tones
archetype AMB_M01
poly_loop 2 3000 10000
pan_range 3000
no_repeat
volume -1800
m01tone1 m01tone2 m01tone3 m01tone4 m01tone5 m01tone6 m01tone7 m01tone8

