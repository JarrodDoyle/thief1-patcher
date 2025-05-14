//MISSION 7  "BANK"

//WAXCYLINDER w/TRUART's VOICE
schema m07wax
archetype DEVICE_MISC
volume -500
m07wax

//---------------------------------------------------------------

//NIGHT LOOP
schema m07night
archetype AMB_M07
no_repeat
mono_loop 0 0
volume -2500 
nightlp nightlp2 nightlp3 cricket2 cricket5 cricket6 

//CRICKET LOOP
schema m07cricket
archetype AMB_M07
mono_loop 0 0
volume -2000
cricket3 cricket4 cricket7 

//HOLLOW
schema m07hollow
archetype AMB_M07
mono_loop 0 0
volume -2200
windstil

//NIGHT WIND (LITE BREEZE)
schema m07wind
archetype AMB_M07
poly_loop 2 5000 6500
volume -2000
Windlit5 Windlit6 Windlit7

//---------------------------------------------------------------

//BASEMENT SUBSONIC
schema m07sub
archetype AMB_M07
mono_loop 0 0
volume -1000
subson4

//BASEMENT LOOP
schema m07basement
archetype AMB_M07
mono_loop 0 0
volume -1400 //-2000
brassL //was L7_base1

//ENTER CREEPY BASEMENT HITS
schema m07basementH
archetype AMB_M07
delay 6000
poly_loop 2 2000 15000
pan_range 3000
volume -1200 //was -2000
L7flut_1 L7flut_2 L7flut_3


//---------------------------------------------------------------

//MAIN LOOP MASK
schema m07bass
archetype AMB_M07
mono_loop 0 0
volume -2500 //was-3000
L7_baseM

//MAIN LOOP
schema m07mainL
archetype AMB_M07
delay 15000
stream
mono_loop 15000 35000
volume -1600 //was-2000
L7_base1 

//---------------------------------------------------------------



//TREE-BIRD LOOP
schema m07birdtree
archetype AMB_M07
mono_loop 0 0
volume -2000
L7_treeL

//DOME CYMBAL LOOP
schema m07domecym
archetype AMB_M07
mono_loop 0 0
volume -800
beatcym2

//GRANDFATHER CLOCK [use both clock2 & 3]
schema m07clock2
archetype AMB_M04
mono_loop 0 0
volume -1500
minepik1

schema m07clock3
archetype AMB_M04
mono_loop 0 0
volume -2800
noluck1