//MISSION 5  "AMBUSH"

//CICADS
schema m05cicads
archetype AMB_M05
poly_loop 2 2500 4000
delay 2000
pan_range 3000
volume -3200
cicad1 cicad2 cicad3 cicad4

//WIND
schema m05wind
archetype AMB_M05
poly_loop 2 3500 4500
pan_range 2500
volume -2400
wind1 wind2 wind3

//WIND LO -GRAVEYARD
schema m05windlo
archetype AMB_M05
poly_loop 2 5000 6250
pan_range 2500
volume -2400
wind1lo wind2lo wind3lo


//NIGHTLOOP
schema m05nightL
archetype AMB_M05
mono_loop 0 0
volume -3000
night1 night2 night3 night4 night5
cricket1 cricket2 cricket3 cricket4 cricket5 cricket6 cricket7

//DRIPS
schema m05drip
archetype AMB_M05
poly_loop 2 3500 4500
delay 5000
pan_range 2000
volume -2000
drip1 drip2 drip3 drip4 drip5 drip6

//MAIN AMB
schema m05maintrem
archetype AMB_M05
mono_loop 0 0
volume -900 //was -1100
lowtrem

//MAIN HITS
schema m05mainhits
archetype AMB_M05
poly_loop 2 6500 8500
pan_range 3000
volume -1400 //was -1800
m01tone1 m01tone2 m01tone3 m01tone4 m01tone5 m01tone6 m01tone7 m01tone8

//INSIDE HUM
schema m05in
archetype AMB_M05
mono_loop 0 0
volume -1800
hum

//HOLLOW
schema m05hollow
archetype AMB_M05
mono_loop 0 0
volume -2400
caveamb

//GARRETT's APT
schema m05apt
archetype AMB_M05
mono_loop 0 0
volume -1000
voicel1
