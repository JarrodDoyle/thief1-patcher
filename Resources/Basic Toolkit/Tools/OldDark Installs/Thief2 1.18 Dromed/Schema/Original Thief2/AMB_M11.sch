//MISSION 11  "UNWELCOME GUEST"

//START MISSION
schema M11start
archetype AMB_M11
volume -500
ambstart

//OUTSIDE WIND
schema M11wind
archetype AMB_M11
poly_loop 2 5000 6000
volume -1800 //was -2300
wind1lo wind2lo wind3lo

schema M11windlit
archetype AMB_M11
poly_loop 2 5000 6000
volume -1400 //was -1800
windlit5 windlit6 windlit7

schema M11windgust
archetype AMB_M11
poly_loop 2 4000 5000
volume -1500
wind1 wind2 wind3 wind4 wind5

//NIGHTLOOPS
schema M11night
archetype AMB_M11
mono_loop 0 0
volume -2800 
night1 night2 night3 night4 night5
cricket1 cricket2 cricket3 cricket4 cricket5 cricket6 cricket7
//CHURCHBELL
schema M11bellchurch
archetype AMB_M11
volume -1500
delay 5000
poly_loop 2 5000 5020
loop_count 12
bellchur

//PIPES
schema M11pipes
archetype AMB_M11
mono_loop 0 0
volume -1700 
pipelp1 pipelp2 pipelp3

//PUMP
schema M11pump
archetype AMB_M11
mono_loop 0 0
volume -1200  
metalhrt

//BIG ZAP ARC
schema M11zaparc
archetype AMB_M11
volume -1000
mono_loop 0 0
zaparc

//TURBINES
schema M11turbine
archetype AMB_M11
volume -1800
mono_loop 0 0
Turbinlp Shockhmr

//TICKING
schema M11ticking
archetype AMB_M11
mono_loop 0 0
volume -2000  
tapping

//PRINTING
schema M11printing
archetype AMB_M11
mono_loop 0 0
volume -2000  
printing

//INSIDE HUM
schema M11hum
archetype AMB_M11
mono_loop 0 0
volume -1800
hum2

//BELL THUMP
schema M11thump
archetype AMB_M11
volume -500
bellthmp

//SINGING
schema M11singing
archetype AMB_M11
volume -2000
poly_loop 2 4000 7000
singing1 singing2 singing3 singing4 singing5

//GEARS
schema M11gears
archetype AMB_M11
mono_loop 0 0
volume -2000
gears1r gears2r

//STEAMLOOP
schema M11steam
archetype AMB_M11
mono_loop 0 0
volume -1800
steamlp4 steamlp2 steamlp3

//TUNNEL
schema M11tunnel
archetype AMB_M11
mono_loop 0 0
volume -1000
mines2

//CHURCH
schema M11gregorian
archetype AMB_M11
mono_loop 15 25
stream 
volume -2000
gregfull


//MACHINES


//SMALL GRINDING STONE GEARS
schema m11gearM1
archetype AMB_M11
mono_loop 0 0
volume -1000
gear_md1

schema m11gearM2
archetype AMB_M11
mono_loop 0 0
volume -1000
gear_md2


schema m11gearM3
archetype AMB_M11
mono_loop 0 0
volume -1000
gear_md3



//LARGE GRINDING STONE GEARS
schema m11gearLG
archetype AMB_M11
mono_loop 0 0
volume -750
gear_lg1


//SMALL MACHINE1
schema m11machS1
archetype AMB_M11
mono_loop 0 0
volume -1000
machsm01

//SMALL MACHINE2
schema m11machS2
archetype AMB_M11
mono_loop 0 0
volume -1000
machsm02

//SMALL MACHINE3
schema m11machS3
archetype AMB_M11
mono_loop 0 0
volume -1000
machsm03

//SMALL MACHINE4
schema m11machS4
archetype AMB_M11
mono_loop 0 0
volume -1000
machsm04

//SMALL MACHINE5
schema m11machS5
archetype AMB_M11
mono_loop 0 0
volume -1000
machsm05

//SMALL MACHINE6
schema m11machS6
archetype AMB_M11
mono_loop 0 0
volume -1000
machsm06

//LARGE MACHINE1
schema m11machL1
archetype AMB_M11
mono_loop 0 0
volume -1000
machlg01

//LARGE MACHINE2
schema m11machL2
archetype AMB_M11
mono_loop 0 0
volume -1000
machlg02

//LARGE MACHINE3
schema m11machL3
archetype AMB_M11
mono_loop 0 0
volume -1000
machlg03

//LARGE MACHINE4
schema m11machL4
archetype AMB_M11
mono_loop 0 0
volume -1000
machlg04

//LARGE MACHINE5
schema m11machL5
archetype AMB_M11
mono_loop 0 0
volume -1000
machlg05

//LARGE MACHINE6
schema m11machL6
archetype AMB_M11
mono_loop 0 0
volume -1000
machlg06

//LARGE MACHINE7
schema m11machL7
archetype AMB_M11
mono_loop 0 0
volume -1000
machlg07

//LARGE MACHINE8
schema m11machL8
archetype AMB_M11
mono_loop 0 0
volume -1000
machlg08

//LARGE MACHINE9
schema m16machL9
archetype AMB_M11
mono_loop 0 0
volume -1000
machlg09

//WINGED STATUE MALE
schema m11wingedM
archetype AMB_M11
mono_loop 0 0
volume -2400
wingedM

//WINGED STATUE FEMALE
schema m11wingedF
archetype AMB_M11
mono_loop 0 0
volume -1800
wingedF





