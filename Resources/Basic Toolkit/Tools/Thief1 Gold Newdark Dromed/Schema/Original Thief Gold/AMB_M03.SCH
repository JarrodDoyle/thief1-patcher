//MISSION 3 -PRISON

///////////
//OUTSIDE//
///////////

//WIND ENVIRONMENT
schema m03wind
archetype AMB_M03
poly_loop 2 5000 9000
pan_range 2000
volume -1300
windlit1 windlit2

//BIRDS
schema m03birds
archetype AMB_M01
delay 3000
poly_loop 2 2000 30000
pan_range 2500
volume -3000
bird1 bird2 bird3 

//CAVE TRANSITION
schema M03trans
mono_loop 0 0
volume -1500
caveamb

/////////
//WATER//
/////////

//CALM WATER
schema M03watercalm
archetype AMB_M03
mono_loop 0 0
volume -1500
waterlp2

//WATER
schema m03water
archetype AMB_M03
mono_loop 0 0
volume -2000
waterlp1

//WATERFALL
schema m03waterfall
archetype AMB_M03
mono_loop 0 0
volume -500
waterfal

/////////
//MINES//
/////////

//MINES AMB
schema m03mines
archetype AMB_M03
mono_loop 0 0
volume -1500  
mines2

//RANDOM SOUND IN MINES
schema M03mines_var
archetype AMB_M03
volume -2000
poly_loop 2 500 7000
pan_range 3000
delay 3000
drip1 drip2 drip3 squeaks1 
zommoan1 zommoan2 zommoan3 zommoan4
rat1 rat2

//RANDOM SOUND IN MINES2 NO ZOMBS
schema M03mines_var2
archetype AMB_M03
volume -2200
poly_loop 2 500 7000
pan_range 3000
delay 3000
rat1 rat2 squeaks1 

//BIG ZAP ARC
schema m03zaparc
archetype AMB_M03
volume -1800
mono_loop 0 0
zaparc

//HOLYWATER
schema m04holywater
archetype AMB_M04
poly_loop 3 3000 5000
volume -2000
aahs1 aahs2 aahs3

///////////
//FACTORY//
///////////

//LOWER FACTORY 
schema m03factory
archetype AMB_M04
mono_loop 0 0
volume -1500
abyss1

//MINES FADE OUT
schema M03mines_p1
archetype AMB_M03
mono_loop 0 0
volume -1800
mines2

schema M03mines_p2
archetype AMB_M03
mono_loop 0 0
volume -2200
mines2

schema M03mines_p3
archetype AMB_M03
mono_loop 0 0
volume -2700
mines2

schema M03mines_p4
archetype AMB_M03
mono_loop 0 0
volume -3300
mines2

//MACHINE ROOM

//MACH ROOM THROB
schema m03machrm
archetype AMB_M03
mono_loop 0 0
volume -800
throbhi


//MACHINE ROOM FADE
schema m03machrm_p1
archetype AMB_M03
mono_loop 0 0
volume -1200
throbhi

schema m03machrm_p2
archetype AMB_M03
mono_loop 0 0
volume -1500
throbhi

schema m03machrm_p3
archetype AMB_M03
mono_loop 0 0
volume -1800
throbhi

schema m03machrm_p4
archetype AMB_M03
mono_loop 0 0
volume -2300
throbhi

schema m03machrm_p5
archetype AMB_M03
mono_loop 0 0
volume -3000
throbhi

//MACHINE ROOM 2 -UPPER

schema m03machrm2
archetype AMB_M03
mono_loop 0 0
volume -750
throblo

//MACHINE ROOM 2 FADE
schema m03machrm2_p
archetype AMB_M03
mono_loop 0 0
volume -900
throblo

schema m03machrm2_p1
archetype AMB_M03
mono_loop 0 0
volume -1200
throblo

schema m03machrm2_p2
archetype AMB_M03
mono_loop 0 0
volume -1500
throblo

//MISC MACHINERY
schema m03tapping
archetype AMB_M03
mono_loop 0 0
volume -1800
tappingr

schema m03arcs
archetype AMB_M03
mono_loop 0 0
volume -2500
arcsr

schema m03gears2
archetype AMB_M03
mono_loop 0 0
volume -800
gears2r

schema m03shockhmr
archetype AMB_M03
mono_loop 0 0
volume -1700
shockhmr 

schema M03pipes1
archetype AMB_M03
mono_loop 0 0
volume -1000
pipelp1

schema M03pipes2
archetype AMB_M03
mono_loop 0 0
volume -1500
bubblelp

schema m03fan
archetype AMB_M03
mono_loop 0 0
volume -1000  //was -1500
fan

schema m03zot
archetype AMB_M03
poly_loop 2 5000 10000
volume -2800
zotr 

//////////
//PRISON//
//////////

//PRISON
schema m03prison
archetype AMB_M03
mono_loop 0 0
volume -900
abyss1

//PRISON RANDOMS
schema m03prison_var
archetype AMB_M03
volume -1200
poly_loop 2 4000 10000
pan_range 3000
delay 3000
rat1 freq 1
rat2 freq 1
chain1 freq 2
moan1 freq 7
moan2 freq 7
moan3 freq 7
moan4 freq 2
plead1 freq 1
plead2 freq 1
plead3 freq 1

////////////
//UPSTAIRS//
////////////

//DRUMLOOP
schema m03drumloop
archetype AMB_M03
mono_loop 0 0
volume -1200
drumloop

//MEES
schema m03mees
archetype AMB_M03
poly_loop 2 2000 3000
pan_range 2500
volume -2200
me1 me2 me3p

//CHANTS
schema m03chants
archetype AMB_M03
mono_loop 0 0
volume -1500
chantlo

//BELLTHUMP
schema m03bellthump
archetype AMB_M03
volume -1000
bellthmp

//EEES
schema m03eees
archetype AMB_M03
mono_loop 0 0
volume -1800
eees1 eees2 eees3






















