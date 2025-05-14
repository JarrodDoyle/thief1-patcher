//MISSION 15  "KIDNAP"

//GRINDING STONE GEARS
schema m15gearM
archetype AMB_m15
mono_loop 0 0
volume -1000
gear_md1

//SMALL MACHINE1
schema m15machS1
archetype AMB_m15
mono_loop 0 0
volume -1000
machsm01

//SMALL MACHINE2
schema m15machS2
archetype AMB_m15
mono_loop 0 0
volume -1000
machsm02

//SMALL MACHINE3
schema m15machS3
archetype AMB_m15
mono_loop 0 0
volume -1000
machsm03

//SMALL MACHINE4
schema m15machS4
archetype AMB_m15
mono_loop 0 0
volume -1200
machsm04 machsm07
machsm08 machsm09

//SMALL MACHINE5
schema m15machS5
archetype AMB_m15
mono_loop 0 0
volume -1000
machsm05

//SMALL MACHINE6
schema m15machS6
archetype AMB_m15
mono_loop 0 0
volume -1000
machsm06

//LARGE MACHINE1
schema m15machL1
archetype AMB_m15
mono_loop 0 0
volume -1000
machlg01

//LARGE MACHINE2
schema m15machL2
archetype AMB_m15
mono_loop 0 0
volume -1000
machlg02

//LARGE MACHINE3
schema m15machL3
archetype AMB_m15
mono_loop 0 0
volume -1300
machlg03

//LARGE MACHINE4
schema m15machL4
archetype AMB_m15
mono_loop 0 0
volume -1000
machlg04

//LARGE MACHINE5
schema m15machL5
archetype AMB_m15
mono_loop 0 0
volume -850
machlg05

//LARGE MACHINE6
schema m15machL6
archetype AMB_m15
mono_loop 0 0
volume -1000
machlg06

//LARGE MACHINE7
schema m15machL7
archetype AMB_m15
mono_loop 0 0
volume -1000
machlg07

//LARGE MACHINE8
schema m15machL8
archetype AMB_m15
mono_loop 0 0
volume -1000
machlg08

//LARGE MACHINE9
schema m15machL9
archetype AMB_m15
mono_loop 0 0
volume -1000
machlg09

//TAPPING- CHANGE SOUND FOR VARIETY!!!
schema m15tapping
archetype AMB_m15
mono_loop 0 0
volume -2000
tapping

//WIND OUTSIDE
schema m15wind
archetype AMB_m15
delay 2000
poly_loop 2 4000 5000
pan_range 2500
volume -1500  //was -2000
wind1 wind2 wind3 wind1lo wind2lo


//LOST CITY

//Cavern hum1
schema m15cave1
archetype AMB_m15
poly_loop 2 5000 7000
pan_range 3000
volume -2000
cave1 cave2 cave3
cave4 cave5 cave6 
cave7 cave8 cave9
cave10

//Cavern hum quiet 
schema m15cave2
archetype AMB_m15
poly_loop 2 7500 8000
pan_range 3000
volume -2400
cave3

//Cavern tran to inside
schema m15trans
archetype AMB_m15
mono_loop 0 0
volume -1800
caveamb

//Inside building
schema m15inside
archetype AMB_m15
mono_loop 0 0
volume -1800
lostcity

//earthquake lo rumble
schema m15quake1
archetype AMB_m15
mono_loop 10000 30000
volume -1
rumble1

//earthquake hi rumbles SOFT
schema m15quake2
archetype AMB_m15
mono_loop 10000 30000
volume -300
rumble2 rumble3

//earthquake all rumbles T2 miss15
schema m15quake3
archetype AMB_m15
pan_range 2000
poly_loop 1 10000 30000
volume -1700
rumble2 rumble3 rumble1






////////
//LAVA//
////////

//Lava1 -burbling
schema m15lava1
archetype AMB_m15
mono_loop 0 0
volume -400
lavalp1

//Lava2 -more intense
schema m15lava2
archetype AMB_m15
mono_loop 0 0
volume -400
lavalp2

//Lava3 -slurping
schema m15lava3
archetype AMB_m15
mono_loop 0 0
volume -400
lavalp3

//Lava4 -soft bubbles
schema m15lava4
archetype AMB_m15
mono_loop 0 0
volume -500
lavalp4

//lava falls
schema m15falls1
archetype AMB_m15
mono_loop 0 0
volume -400
lavapour

//lava steam1 -lava blasts
schema m15steam1
archetype AMB_m15
poly_loop 2 3000 6000
pan_range 1000
volume -500
lavabst1 lavabst2 lavabst3

//lava steam2 -soft bubbling steam
schema m15steam2
archetype AMB_m15
mono_loop 0 0
volume -1000
steamlp1

//lava crackle1
schema m15crackle1
archetype AMB_m15
mono_loop 0 0
volume -750
crackle1

//lava crackle2
schema m15crackle2
archetype AMB_m15
mono_loop 0 0
volume -750
crackle2

//Bubble -random blurps
schema m15bub1
archetype AMB_m15
poly_loop 2 3000 6000
pan_range 2000
volume -1000
bubble1 bubble2 bubble3 bubble4

//Bubble fast
schema m15bub2
archetype AMB_m15
poly_loop 2 500 2000
pan_range 2000
volume -1000
burble1 burble2 burble3 

//bubble slow -soft bubble loop
schema m15bub3
archetype AMB_m15
mono_loop 0 0
volume -1000
bubblelp

//CHURCH BELL	
schema m15churchbell
archetype AMB_M15
mono_loop 0 0
volume -400
beatbel1

