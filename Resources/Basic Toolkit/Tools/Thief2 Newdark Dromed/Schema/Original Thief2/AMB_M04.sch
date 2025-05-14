//MISSION 4  "FRAMED"

//WIND
schema m04wind
archetype AMB_M04
poly_loop 2 5000 5000
pan_range 2000
volume -1200
windlit5 windlit6 windlit7

//BIG ZAP ARC
schema m04zaparc
archetype AMB_M04
volume -1000
mono_loop 0 0
zaparc

//INSIDE HUM
schema m04hum
archetype AMB_M04
mono_loop 0 0
volume -2200
hum

//NIGHT
schema m04night
archetype AMB_M04
mono_loop 0 0
volume -3000
night1 night2 night3 night4 night5


//TANK
schema m04tank
archetype AMB_M04
mono_loop 0 0
volume -500
tempturb

//TURBINES
schema m04turbine
archetype AMB_M04
mono_loop 0 0
volume -1000
turbinlp

//WINDOBJ
schema m04windobj
archetype AMB_M04
poly_loop 2 5000 5000
volume -1200
windlit5 windlit6 windlit7

//FAN
schema m04fan
archetype AMB_M04
mono_loop 0 0
volume -1500
fan

//GEARS
schema m04gears
archetype AMB_M04
mono_loop 0 0
volume -1500
gears4 //gears2 gears3

//THROB
schema m04throb
archetype AMB_M04
mono_loop 0 0
volume -1200
throblo

//FURNACE
schema m04lava
archetype AMB_M04
mono_loop 0 0
volume -1
crackle2

//DIALS
schema m04dials
archetype AMB_M04
mono_loop 0 0
volume -2500
printing

//-----------------------------

//BASEMENT HOLLOW SND
schema m04bsmt
archetype AMB_M04
mono_loop 0 0
volume -2100
mines2

schema m04bst_var
archetype AMB_M04
volume -2200
poly_loop 2 500 7000
pan_range 3000
delay 3000
rat1 rat2 squeaks1 

//MACHINERY PULLEy
schema m04pulley
archetype AMB_M04
mono_loop 0 0
volume -2000
gears4

//PRISON HUM
schema m04prison
archetype AMB_M04
mono_loop 0 0
volume -800
subson4

//PRISON RANDOMS
schema m04prison_var
archetype AMB_M04
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

//CRAZY GORDON SMITH
schema m04smith
archetype AMB_M04
no_repeat
volume -100
mono_loop 100 500
smilaug1 smilaug2 smilaug3 smilaug4 smilaug5 smilaug6 smilaug7 smilaug8 smi0401A smi0401B smi0401C smi0401D smi0401E


//-----------------------------

//INSIDE 1st FLOOR
schema m04in1
archetype AMB_M04
mono_loop 0 0
volume -1800
voxloop2

//TONES 3rd FLOOR
schema m04tones
archetype AMB_M04
delay 5000
mono_loop 10000 15000
no_repeat
stream
volume -1000
m04lo m04ring

//TURRET ROOM
schema m04turret
archetype AMB_M04
mono_loop 0 0
volume -500
substr1

//CLOCK MECHANICS
schema m04clock1
archetype AMB_M04
mono_loop 0 0
volume -2000
printing

schema m04clock2
archetype AMB_M04
mono_loop 0 0
volume -1500
minepik1

schema m04clock3
archetype AMB_M04
mono_loop 0 0
volume -2800
noluck1