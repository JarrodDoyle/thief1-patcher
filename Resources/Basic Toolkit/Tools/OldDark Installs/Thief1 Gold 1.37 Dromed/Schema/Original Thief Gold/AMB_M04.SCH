
//Mission 4 -Catacombs

//Haunt Trap -speech
schema m0401
archetype OTHER_CONV
hh1m0401

//Stone Face
schema m0402
archetype OTHER_CONV
fac001

//Stone Face laughter
schema m0402a
archetype OTHER_CONV
fac002

//Thank you
schema m0403
archetype OTHER_CONV
gh1gold

//Horn of Quintus
schema Horn_of_Quintus
archetype AMB_M04
audio_class speech
volume -500
mono_loop 0 0
hornofq

///////////
//OUTSIDE//
///////////

//START
schema m01start
archetype AMB_M04
volume -500
keehit_s

schema m04wind
archetype AMB_M04
volume -2000
pan_range 3000
poly_loop 2 5000 6000
wind1lo wind2lo wind3lo

//TRANS1 WIND
schema m04trans
archetype AMB_M04
volume -1500
mono_loop 0 0
caveamb

////////////
//1ST ROOM//
////////////

//CATACOMBS AMB 1 1st BIG ROOM 
schema m04cat1
archetype AMB_M04
mono_loop 0 0
volume -400
subson1

//RANDOMS
schema m04cat1var
archetype AMB_M04
volume -1600
pan_range 500
poly_loop 2 5000 15000
m04cat1a m04cat1b m04cat1c 

//CUE1
schema m04cue1
archetype AMB_M04
volume -1500
m04cat2a m04cat2b m04cat2c


//CUE -OVERLOOKING THE LEDGE
schema m04ledge
archetype AMB_M04
volume -100
howltxtb howltxta

//SPARKLY BELLS
schema m04bells
archetype AMB_M04
volume -3000
poly_loop 2 5000 5500
bells1 bells2


//RUMBLES
schema m04rumble_p
archetype AMB_M04
volume -1
mono_loop 20000 30000
rumble1 rumble2

//MOANS
schema m04moans
archetype AMB_M04
volume -1200
pan_range 2500
delay 2000
poly_loop 2 4000 15000
zommoan1 zommoan2 zommoan3 zommoan4

//CREAKING WOOD
schema m04creak
archetype AMB_M04
volume -2000
delay 3000
mono_loop 8000 10000
squeaks1
 
//JUMP CUE 	
schema m04jump
archetype AMB_M04
volume -500
bellthmp

//REDBOOK ROOM OBJ  
schema m04redbook
archetype AMB_M04
mono_loop 0 0
volume -2600
beams		

//HOLY WATER ROOM OBJ
schema m04holywater
archetype AMB_M04
poly_loop 3 3000 5000
volume -2000
aahs1 aahs2 aahs3


//CATACOMBS AMB 2 HALLWAY  <<lo music2
schema m04cat2
archetype AMB_M04
volume -500
mono_loop 0 0
subson2

//CUE2
schema m04cue2
archetype AMB_M04
volume -1800
pan_range 3000
poly_loop 2 4000 30000
m04cat2a m04cat2b m04cat2c


//TRAP1 -CREAKING FALLING ROCKS  <<get rickety snd 
schema m04trap1    
archetype AMB_M04
volume -500
mono_loop 4000 8000
rumble3  

///////////////////
//BURRICK TUNNELS//
///////////////////

//TRANS2 TO TUNNELS
schema m04trans2
archetype AMB_M04
volume -1200
mono_loop 0 0
caveamb

//NARROW TUNNELS
schema m04tunnels
archetype AMB_M04
mono_loop 0 0
volume -1500
lostcity

//CAVES AMB
schema m04caves
archetype AMB_M04
poly_loop 2 5000 7000
pan_range 3000
volume -2000
cave1 cave2 cave3

//CATACOMBS 3 -AFTER TUNNELS   
schema m04cat3
archetype AMB_M04
mono_loop 0 0
volume -500
subson1

//CATACOMBS 3 CUE	<<??
schema m04cue3
archetype AMB_M04
volume -100
howltxtb

//PYRAMID ROOM OBJ
schema m04pyramid
archetype AMB_M04
volume -100
mines2

//RUMBLES2
schema m04rumbles
archetype AMB_M04
volume -1
pan_range 3000
poly_loop 2 5000 30000
rumble1 rumble2 rumble3

schema m04hornhum
archetype AMB_M04
volume -250
mono_loop 0 0
subson2

schema m04cat4
archetype AMB_M04
volume -1200
pan_range 3000
delay 3000
mono_loop 3000 25000
m04cat2a m04cat2b m04cat2c

//WATER
schema m04water
archetype AMB_M04
mono_loop 0 0
volume -500
waterlp2

//WATER QUIET
schema m04water_p
archetype AMB_M04
mono_loop 0 0
volume -2000
waterlp2