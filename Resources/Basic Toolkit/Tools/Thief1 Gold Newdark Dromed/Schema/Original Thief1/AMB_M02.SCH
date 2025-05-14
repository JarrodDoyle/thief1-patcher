//MISSION 2 -BAFFORD

//START
schema m02start
archetype AMB_M02
volume -500
keehit_s   

//WIND ENVIRONMENT
schema m02wind
archetype AMB_M02
delay 2000
poly_loop 2 4000 5000
pan_range 2500
volume -1200  //was -2000
wind1 wind2 wind3 wind1lo wind2lo

//WIND OBJECT
schema m02windobj
archetype AMB_M02
poly_loop 2 4000 5000
volume -1200  //was -100
wind4 wind5 wind1 wind2 wind3

//INSIDE-OUTSIDE TRANS
schema m02cave
archetype AMB_M02
mono_loop 0 0
volume -1500
caveamb

//INSIDE TONES
schema m02tones
archetype AMB_M02
poly_loop 2 4000 10000
volume -1500
pan_range 2500
tone1 tone2 tone3 tone4 tone5

//BASEMENT 1 -AT WATER
schema m02basement1
archetype AMB_M02
mono_loop 0 0
volume -2000
m02bs1

//BASEMENT 2 -AT BLACKJACK GUY
schema m02basement2
archetype AMB_M02
poly_loop 2 2000 15000
pan_range 2500
volume -2700
m02bs2A m02bs2B m02bs2C m02bs2D

//BASEMENT 2A -BJACK GUY CUE
schema m02bjcue
archetype AMB_M02
volume -1500
tension7

//BASEMENT 3 -SERVANT LEVEL CUE
schema m02svcue
archetype AMB_M02
volume -1500
tension1

//BASEMENT - 1st FL TRANS
schema m02voxtrans
archetype AMB_M02
mono_loop 0 0
volume -1800 
voxtrans


//INSIDE 1st FLOOR
schema m02vox
archetype AMB_M02
mono_loop 0 0
volume -1800  //was -1700
voxloop

//TILED FLOOR
//schema m02tiles
//archetype AMB_M02
//mono_loop 0 0
//volume -1300
//tilelp1

//TILED FLOOR
schema m02tiles
archetype AMB_M02
poly_loop 2 2000 3000
pan_range 1000
volume -1000
vox1 vox2 vox3



//CUE1 -UPSTAIRS LOCKED ROUND ROOM NEW SCEPTRE
schema m02cue1
archetype AMB_M02
volume -1800
tension3

//CUE2 -SCEPTRE ROOM
schema m02cue2
archetype AMB_M02
volume -1800
tension2

//RAFTERS
schema m02rafters
archetype AMB_M02
volume -1500
mono_loop 0 0
voxtrans


//DOWN BACK STAIRS RANDOMS
schema m02creaks
archetype AMB_M02
volume -2000
poly_loop 2 500 7000
pan_range 3000
delay 2000
drip1 freq 1
drip2 freq 1
drip3 freq 1
squeaks1 freq 2

//DOWN BACK STAIRS ENVIRON
schema m02abyss
archetype AMB_M02
volume -1000
mono_loop 0 0
abyss1

//COURT YARD

//CRICKETS
schema m02crickets
archetype AMB_M02
mono_loop 0 0
volume -2400
crickets

//NIGHTLOOP
schema m02nightlp
archetype AMB_M02
mono_loop 0 0
volume -2400
nightlp

//SEWERS

//CALM WATER
schema m02watercalm
archetype AMB_M02
mono_loop 0 0
volume -1500  //was -2000
waterlp2

//WATER
schema m02water
archetype AMB_M02
mono_loop 0 0
volume -1500  //was -1500
waterlp1

//MANHOLE TRANS
schema m02mhtr
archetype AMB_M02
mono_loop 0 0
volume -1500
caveamb

//DRIPS
schema m02drips
archetype AMB_M02
mono_loop 1000 6000
volume -2700
drip1 drip2 drip3



//MACHINES

//TAPPING BOX
schema m02tapping
archetype AMB_M02
mono_loop 0 0
volume -2400
tapping

//PIPES
schema m02pipes
archetype AMB_M02
mono_loop 0 0
volume -1500
bubblelp

//PEOPLE1
schema m02people1
archetype AMB_M02
mono_loop 0 0
volume -2600
crowdbar

//PEOPLE2
schema m02people2
archetype AMB_M02
mono_loop 0 0
volume -2600
crowdba2
