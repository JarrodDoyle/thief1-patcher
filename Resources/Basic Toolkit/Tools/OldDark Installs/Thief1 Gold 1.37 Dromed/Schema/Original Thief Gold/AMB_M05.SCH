//MISSION 5 ASSASSIN

//START INSIDE
schema m05in1
archetype AMB_M05
mono_loop 0 0
volume -1500
windstil

//FOLLOW THE ASSASSINS

//wind
schema m05wind
archetype AMB_M05
poly_loop 2 3000 6000
delay 1000
pan_range 2500
volume -1250
wind1lo wind2lo wind3lo wind4

//Loop1
schema m05L1
archetype AMB_m05
mono_loop 0 0
volume -1200  
m05Loop1

//Loop2
schema m05L2
archetype AMB_m05
mono_loop 0 0
volume -1200 
m05Loop2

//Loop3
schema m05L3
archetype AMB_m05
mono_loop 0 0
volume -1200
m05Loop3

//End of trail trans
schema m05endtrans
archetype AMB_m05
mono_loop 0 0
volume -500
voxtrans



//PIPES
schema m05pipes
archetype AMB_M05
mono_loop 0 0
volume -800
pipelp1


//WIND TRANS
schema m05windtr
archetype AMB_M05
mono_loop 0 0 
volume -1500
windlp1

//TUNNEL
schema m05tunnel
archetype AMB_M05
mono_loop 0 0
volume -1500
caveamb

//beet
schema m05beet
archetype AMB_M05
mono_loop 0 0
volume -1400
beet1jgb

//feedback
schema m05fb
archetype AMB_M05
poly_loop 2 3000 4500
pan_range 3000
volume -1000
fb1 freq 2
fb2 freq 2
fb3 freq 2
fb4 freq 1


//crickets loop
schema m05crickets
archetype AMB_M05
mono_loop 0 0
volume -2000
crickets

//night loop
schema m05nightlp
archetype AMB_M05
mono_loop 0 0
volume -2400
nightlp


//tavern1
schema m05tavern1
archetype AMB_M05
mono_loop 0 0
volume -2600
crowdba2

//tavern2 soft
schema m05tavern2
archetype AMB_M05
mono_loop 0 0
volume -2600
crowdre2

//tavern3 soft
schema m05tavern3
archetype AMB_M05
mono_loop 0 0
volume -2600
crowdbar

//INSIDE RMZ HOUSE
schema m05sqlo
archetype AMB_M05
mono_loop 0 0
volume -500
squarelo

//INSIDE 2
schema m05rising
archetype AMB_M05
mono_loop 0 0
volume -1800  //was -1300
rising


//BALC CUE1
schema m05bellthump
archetype AMB_M05
volume -1000
bellthmp



//waterfall1
schema m05waterfall
archetype AMB_M05
mono_loop 0 0
volume -1200
waterfal

//WATER
schema m05water
archetype AMB_M05
mono_loop 0 0
volume -1700
waterlp1

//CALM WATER
schema m05watercalm
archetype AMB_M05
mono_loop 0 0
volume -1700
waterlp2

//MACHINES

//PUMP1
schema m05pump1
archetype AMB_M05
mono_loop 0 0
volume -2200
genera2r

//TWIN COILS
schema m05coils
archetype AMB_M05
mono_loop 0 0
volume -700
metalhrt

//TURBINE
schema m05turbine
archetype AMB_M05
mono_loop 0 0
volume -1200
turbinlp

//SHOCKHMR
schema m05shockhmr
archetype AMB_M05
mono_loop 0 0
volume -500
shockhmr

//THROB IN SKY
schema m05throbhi
archetype AMB_M05
mono_loop 0 0
volume -100
throbhi

//THROB
schema m05throb
archetype AMB_M05
mono_loop 0 0
volume -500
throblo

//cauldron bubbling
schema m05cauldron
archetype AMB_M05
mono_loop 0 0
volume -1000
lavalp1


