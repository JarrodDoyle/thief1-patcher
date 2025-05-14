//THIEFGOLD DEMO -MISSION 15


//START MISSION
schema d15start
archetype AMB_D15
volume -500
keehit_s   

//WIND ENV. -SOFT
schema d15windp
audio_class ambient
archetype AMB_D15
volume -700  //was -1400
pan_range 3000   
poly_loop 2 4000 7000
windlit1 windlit2

//TRANS INSIDE-OUTSIDE
schema d15trans
archetype AMB_D15
mono_loop 0 0
volume -1500
windstil

//LAUNDRY CHUTE
schema d15chute
archetype AMB_D15
mono_loop 0 0
volume -1000
cavetone

//INSIDE 1ST FLOOR
schema d15loopL
archetype AMB_D15
mono_loop 0 0
pan -5000
volume -1400
thloop1

schema d15loopR
archetype AMB_D15
mono_loop 0 0
delay 100
pan 5000
volume -1400
thloop1


//BELLTHUMP
schema d15thump
archetype AMB_D15
volume -500
bellthmp

//DOWNSTAIRS HUM (S)
schema d15down
archetype AMB_D15
mono_loop 0 0
volume -1000 
thdown

schema d15down2
archetype AMB_D15
mono_loop 0 0
volume -600 
thdown2

//DOWNSTAIRS OBJS
schema d15sub3
archetype AMB_D15
mono_loop 0 0
volume -800 
M13str

//TENSION
schema d15tension
archetype AMB_D15
volume -600 
ten1 ten2 

