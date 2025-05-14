//Mission 9 LOST CITY

//WIND OUTSIDE
schema m09wind
archetype AMB_M09
delay 2000
poly_loop 2 4000 5000
pan_range 2500
volume -1500  //was -2000
wind1 wind2 wind3 wind1lo wind2lo

//WATER

schema m09water
archetype AMB_M09
mono_loop 0 0
volume -1500
waterlp1

schema m09waterfall
archetype AMB_M09
mono_loop 0 0
volume -700
waterfal

schema m09watercalm
archetype AMB_M09
mono_loop 0 0
volume -1500
waterlp2

schema m09watercalm_p
archetype AMB_M09
mono_loop 0 0
volume -1800
waterlp2

schema m09drips
archetype AMB_M09
mono_loop 0 0
volume -2500
waterlp1



//LOST CITY

//Cavern hum1
schema m09cave1
archetype AMB_M09
poly_loop 2 5000 7000
pan_range 3000
volume -2000
cave1 cave2 cave3

//Cavern hum quiet 
schema m09cave2
archetype AMB_M09
poly_loop 2 7500 8000
pan_range 3000
volume -2400
cave3

//Cavern tran to inside
schema m09trans
archetype AMB_M09
mono_loop 0 0
volume -1800
caveamb

//Inside building
schema m09inside
archetype AMB_M09
mono_loop 0 0
volume -1800
lostcity

//earthquake lo rumble
schema m09quake1
archetype AMB_M09
mono_loop 10000 30000
volume -1
rumble1

//earthquake hi rumbles SOFT
schema m09quake2
archetype AMB_M09
mono_loop 10000 30000
volume -300
rumble2 rumble3

//earthquake all rumbles LOUD
schema m09quake3
archetype AMB_M09
poly_loop 1 10000 30000
volume -100
rumble2 rumble3 rumble1






////////
//LAVA//
////////

//Lava1 -burbling
schema m09lava1
archetype AMB_M09
mono_loop 0 0
volume -400
lavalp1

//Lava2 -more intense
schema m09lava2
archetype AMB_M09
mono_loop 0 0
volume -400
lavalp2

//Lava3 -slurping
schema m09lava3
archetype AMB_M09
mono_loop 0 0
volume -400
lavalp3

//Lava4 -soft bubbles
schema m09lava4
archetype AMB_M09
mono_loop 0 0
volume -500
lavalp4

//lava falls
schema m09falls1
archetype AMB_M09
mono_loop 0 0
volume -400
lavapour

//lava steam1 -lava blasts
schema m09steam1
archetype AMB_M09
poly_loop 2 3000 6000
pan_range 1000
volume -500
lavabst1 lavabst2 lavabst3

//lava steam2 -soft bubbling steam
schema m09steam2
archetype AMB_M09
mono_loop 0 0
volume -1000
steamlp1

//lava crackle1
schema m09crackle1
archetype AMB_M09
mono_loop 0 0
volume -750
crackle1

//lava crackle2
schema m09crackle2
archetype AMB_M09
mono_loop 0 0
volume -750
crackle2

//Bubble -random blurps
schema m09bub1
archetype AMB_M09
poly_loop 2 3000 6000
pan_range 2000
volume -1000
bubble1 bubble2 bubble3 bubble4

//Bubble fast
schema m09bub2
archetype AMB_M09
poly_loop 2 500 2000
pan_range 2000
volume -1000
burble1 burble2 burble3 

//bubble slow -soft bubble loop
schema m09bub3
archetype AMB_M09
mono_loop 0 0
volume -1000
bubblelp

//blue lights on
schema blue_light_on
archetype AMB_M09
volume -1200
blueon1 blueon2
env_tag (Event Activate) (DeviceType BlueLight)

//blue lights off
schema blue_light_off
archetype AMB_M09
volume -1700
blueoff1 blueoff2
env_tag (Event Deactivate) (DeviceType BlueLight)


//tower
schema m09tower
archetype AMB_M09
poly_loop 3 3000 5000
volume -3000
aahs1 aahs2 aahs3

//talisman room
schema m09talisman
archetype AMB_M09
mono_loop 0 0
volume -2000
eees3



