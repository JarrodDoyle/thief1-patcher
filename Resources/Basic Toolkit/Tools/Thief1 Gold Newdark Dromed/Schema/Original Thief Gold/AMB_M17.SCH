//MISSION 17 OPERA HOUSE

//BEGINNING OUTSITE SEWERS

//START
schema m17start
archetype AMB_M17
volume -500
keehit_s   

//WIND OBJ
schema m17windobj
archetype AMB_M17
volume -700
poly_loop 2 5000 6000
wind1lo wind2lo wind3lo

//WIND LITE OBJ
schema m17windlite
archetype AMB_M01
volume -50
poly_loop 2 4000 7000
windlit1 windlit2

//NIGHTLOOP
schema m17night
archetype AMB_M17
mono_loop 0 0
volume -1000
nightlp

//CRICKETS
schema m17crickets
archetype AMB_M17
mono_loop 0 0
volume -1000
crickets

//INSIDE TOWER
schema m17tower
archetype AMB_M17
mono_loop 0 0
volume -800
lostcity

//SEWER PUMP
schema m17pump
archetype AMB_M17
mono_loop 0 0
volume -500  //was -1000
metalhrt

//SEWER PIPES
schema m17pipes
archetype AMB_M17
mono_loop 0 0
volume -1000  //was -1800
pipelp1 pipelp2 pipelp3

//WATER
schema m17water
archetype AMB_M17
mono_loop 0 0
volume -1800
waterlp1


//CALM WATER
schema m17watercalm
archetype AMB_M17
mono_loop 0 0
volume -2000
waterlp2

//VERY CALM WATER
schema m17waterlp3
archetype AMB_M17
mono_loop 0 0
volume -1600
waterlp3

//IN THE CAVERNS

//CAVE TR
schema m17cavetr
archetype AMB_M17
mono_loop 0 0
volume -2000
caveamb

//CAVE HOLLOW HUM
schema m17cave
archetype AMB_M17
mono_loop 0 0
volume -2000
mines2

//DRIPS IN CAVE
schema m17drips
archetype AMB_M17
poly_loop 2 2000 12000
volume -2200
pan_range 2500
drip4 drip5 drip6

//CAVE WITH LO TONE
schema m17cavetone
archetype AMB_M17
mono_loop 0 0
volume -1200
cavetone

//CAVE FALLS
schema m17cavefalls
archetype AMB_M17
poly_loop 2 6000 20000
delay 3000
pan_range 3000
volume -700
cave4 cave5 cave6 cave7

//HERMIT ECHOS
schema m17hermit
archetype AMB_M17
no_repeat
mono_loop 100 5000
volume -1500  //was -1300
hmA12100 hmA12101 hmA12102 hmA12103 hmA12104 hmAa0co1 hmAa0co2 hmAa0co3 hmAa0co4 hmAa0co5 hmAa0hu1 hmAa0hu2 hmAa0hu3 hmAa0si1 hmAa0si2 hmAa0si3 

//SHRINE ROOM HUM
schema m17shrine
archetype AMB_M17
no_repeat
poly_loop 2 6000 7500
pan_range 3000
volume -600
cave8 cave9 cave10

//OPERA HOUSE OUTSIDE

//WIND OUTSIDE OPERA HOUSE
schema m17wind2
archetype AMB_M17
volume -1800
poly_loop 2 5000 6000
wind1lo wind2lo wind3lo

//OPERA HOUSE TRANS
schema m17optr
archetype AMB_M17
mono_loop 0 0
volume -300
metalp4

//TAPPING BOX
schema m17tapping
archetype AMB_M17
mono_loop 0 0
volume -2400
tapping


//INSIDE BASEMENT

//BASEMENT TRANSITION
schema m17bsTr
archetype AMB_M17
mono_loop 0 0
volume -100
subson3

//BASEMENT HUM (S)
schema m17bs
archetype AMB_M17
mono_loop 0 0
volume -100
subson3

//BASEMENT LO STRINGS
schema m17bsstr
archetype AMB_M17
volume -1300  //was -1200
mono_loop 5000 15000
pan_range 500
no_repeat
m17A1 m17A2 m17A3 m17A4 m17A5 m17A6

//BASEMENT HITS
schema m17bshit
archetype AMB_M17
no_repeat
delay 5000
volume -1000  //was -1500
pan_range 3000
mono_loop 2000 20000
m17str1 m17str2 m17str3 m17str4 m17bells m17bells2 m17pizz m17fh

//BASEMENT LOOPED OBJS
schema m17bslp
archetype AMB_M17
volume -1700
mono_loop 0 0
m17clu1 m17clu2 m17clu3 m17clu4 m17aug1 m17aug2 



//1ST FLOOR AUDITORIUM
schema m17orchtune
archetype AMB_M17
poly_loop 2 8000 10000
pan_range 2000
volume -1500
orchtun1 orchtun2 orchtun3 orchtun4 orchtun5 orchtun6

//1st FLOOR LOOP
schema m17voxloop
archetype AMB_M17
volume -1800
mono_loop 0 0
voxloop2

//LIBRARY
schema m17lib
archetype AMB_M17
volume -1200  //was -1500
mono_loop 0 0
hum

//3rd FLOOR LOOP
schema m17pulsebs
archetype AMB_M17
volume -1500
mono_loop 0 0
pulsebsq


//FURNACE ROOM
schema m17furnace
archetype AMB_M17
mono_loop 0 0
volume -600
throblo

//FOUNTAIN
schema m17fountain
archetype AMB_M17
mono_loop 0 0
volume -2700
waterfal
