//MISSION 14 ENDGAME


//EMDGAME SFX

//PEDESTAL WHIRLWIND
schema m14pedww
archetype AMB_M14
volume -800
egpedww

//PEDESTAL LOOP
schema m14pedlp
archetype AMB_M14
mono_loop 0 0
volume -1
egpedlp

//CENTER WHIRLWIND
schema m14ctrww
archetype AMB_M14
poly_loop 2 2500 3000
volume -1
windgst1 windgst2 windgst3

//LASER ZAP
schema m14laserzap
archetype AMB_M14
volume -1
egzap

//LASER LOOP
schema m14laserlp
archetype AMB_M14
mono_loop 0 0
volume -500
eglaser

//You win stage2 -center explodes
schema m14ctrexp 
archetype AMB_M14
volume -1
expctr




////////////
//AMBIENTS//
////////////

//LEVEL1 LOOP
schema m14L1
archetype AMB_M14
volume -800
pan_range 1200
poly_loop 2 7000 7500
pitch1 pitch2 pitch3

//LEVEL1 RANDOMS
schema m14L1var
archetype AMB_M14
volume -2000
delay 2000
pan_range 2500
poly_loop 2 1000 30000
gr1 gr2 gr3 gr4 gr5 gr6 gr7 gr8 gr9

//PURPLE DRIPS
schema m14pdrips
archetype AMB_M14
volume -1500
mono_loop 0 0
purple1 purple2 purple3

//CAVE AMB
schema m14cave
archetype AMB_M14
poly_loop 2 5000 7000
pan_range 3000
volume -1500
cave1 cave2 cave3

//CAVE TRANS
schema m14cavetr
archetype AMB_M14
mono_loop 0 0
volume -1000
caveamb

//CAVE AMB SOFT
schema m14cave_p
archetype AMB_M14
mono_loop 0 0
volume -2500
mines2


//EGGS LOOP
schema m14eggs
archetype AMB_M14
mono_loop 0 0
volume -1
egglp1

//PORTAL LOOP
schema m14portal
archetype AMB_M14
mono_loop 0 0
volume -1600
portal1

//PARTICAL BRIDGE
schema m14pbridge
archetype AMB_M14
mono_loop 0 0
volume -500
bridge1

//Cue1
schema m14cue1
archetype AMB_M14
volume -1000
vooh

//BLUE CRYSTALS
schema m14bluecry
archetype AMB_M14
mono_loop 0 0
volume -500
bluecry1 bluecry2 bluecry3

//ICE
schema m14ice1
archetype AMB_M14
volume -2300
poly_loop 2 5000 5500
bells1 bells2

schema m14ice2
archetype AMB_M14
volume -2300
poly_loop 2 3000 3500
bells3 bells4

//RUMBLE
schema m14rumble
archetype AMB_M14
volume -1000
mono_loop 10000 30000
rumble1 rumble2 rumble3

//ENDGAME RUMBLES
schema m14rumble_end
archetype AMB_M14
pan_range 2500
volume -800
delay 5000
mono_loop 1000 30000
rumble1 rumble2 rumble3


//L2
schema m14L2
archetype AMB_M14
volume -400
mono_loop 0 0
subson1

schema m14bellthump
archetype AMB_M14
volume -1000
bellthmp



//FOR TREE ROOM
schema m14cicadas
archetype AMB_M14
volume -3000
pan_range 2500
poly_loop 2 2000 2500
cicad1 cicad2 cicad3 cicad4

//SPIDER ROOM RANDOMS
schema m14L2var
archetype AMB_M14
volume -2000
delay 2000
pan_range 2500
poly_loop 2 1000 15000
gr1 gr2 gr3 gr4 gr5 gr6 gr7 gr8 gr9

//VIK GIG
schema m14vik
archetype AMB_M14
volume -2400
pan_range 2500
mono_loop 1000 10000
vikgig1 vikgig2 vikgig3 vikgig4

//L3
schema m14L3
archetype AMB_M14
volume -400
mono_loop 0 0
subson2


//LO VOICE
schema m14Lo
archetype AMB_M14
delay 2000
poly_loop 2 5000 20000
pan_range 2500
volume -1300
lo1 lo2 lo3 lo4 lo5


////////
//LAVA//
////////

schema m14lava1
archetype AMB_M14
volume -900
mono_loop 0 0
lavalp1

schema m14lava2
archetype AMB_M14
volume -900
mono_loop 0 0
lavalp2

schema m14lava3
archetype AMB_M14
volume -900
mono_loop 0 0
lavalp3

schema m14lava4
archetype AMB_M14
volume -900
mono_loop 0 0 
lavalp4

schema m14lavafalls
archetype AMB_M14
volume -100
mono_loop 0 0 
lavapour

/////////
//WATER//
/////////

schema m14waterfall
archetype AMB_M14
volume -500
mono_loop 0 0 
waterfal

schema m14water
archetype AMB_M14
volume -500
mono_loop 0 0 
waterlp1

schema m14watercalm
archetype AMB_M14
volume -1500
mono_loop 0 0 
waterlp2

schema m14drips
archetype AMB_M14
volume -2600
poly_loop 2 1000 10000 
drip1 drip2 drip3



