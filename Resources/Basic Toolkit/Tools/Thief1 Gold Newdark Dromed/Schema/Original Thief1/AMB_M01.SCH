//MISSION 1 -TRAINING

//START MISSION
schema m01start
archetype AMB_M01
volume -500
keehit_s   

//HALLWAYS
schema m01halls
archetype AMB_M01
mono_loop 0 0
volume -1000
abyss1

//SIGHT ROOM HUM
schema m01sightrm
archetype AMB_M01
volume -1500 //was -100 
mono_loop 0 0
windlp1

//AUDIO ROOM HUM
schema m01audiorm
archetype AMB_M01
volume -1500  //was -100
mono_loop 0 0
windstil

//WIND ENV. -SOFT
schema m01windp
audio_class ambient
archetype AMB_M01
volume -700  //was -1400
pan_range 3000   
poly_loop 2 4000 7000
windlit1 windlit2

//WIND OBJECT
schema m01wind
archetype AMB_M01
volume -700  //was -200 
poly_loop 2 4000 7000
windlit1 windlit2

//NIGHT LOOP
schema m01nightlp
archetype AMB_M01
mono_loop 0 0
volume -2200  //was -2500 
nightlp

//BIRDS
schema m01birds
archetype AMB_M01
delay 3000
poly_loop 2 4000 20000
pan_range 2000
volume -2500  //was -3500
bird1 bird2 bird3 

//TRANS INSIDE-OUTSIDE
schema m01trans
archetype AMB_M01
mono_loop 0 0
volume -1500
windstil

//WATER
schema m01water
archetype AMB_M01
mono_loop 0 0
volume -1000 
waterlp1

//WATER IN TUNNELS
schema m01waterslo
archetype AMB_M01
mono_loop 0 0
volume -1000 
waterlp2




