//MISSION 10 UNDERCOVER

//5-SWITCH PUZZEL SUCCESS
schema switch_succ
archetype DEVICES
volume -100
m10succ

//5-SWITCH PUZZEL FAIL
schema switch_fail
archetype DEVICES
volume -100
m10fail

//OUTSIDE FRONT

//WIND
schema m10wind
archetype AMB_M10
poly_loop 2 3000 4000
pan_range 2000
volume -1000
wind1 wind2 wind3

//SINGING
schema m10singing
archetype AMB_M10
volume -1700
poly_loop 2 7000 8000
singing1 freq 2
singing2 freq 1

//PEOPLE1
schema m10tavern1
archetype AMB_M10
volume -2200
mono_loop 0 0
crowdres

//PEOPLE2
schema m10tavern2
archetype AMB_M10
volume -2500
mono_loop 0 0
crowdbar

//PEOPLE3
schema m10tavern3
archetype AMB_M10
volume -2700
mono_loop 0 0
crowdre2

//BELLCHURCH
schema m10bellchur
archetype AMB_M10
volume -2000
poly_loop 1 5000 5010
bellchur freq 6
silenc9s freq 1

//WIND TRANS
schema m10trans
archetype AMB_M10
mono_loop 0 0
volume -800
windstil

//GEARS
schema m10gears
archetype AMB_M10
mono_loop 0 0
volume -1500
gears1r 

//INSIDE LOOP
schema m10inside
archetype AMB_M10
volume -1500
mono_loop 0 0
diffuse

//INSIDE RANDOMS
schema m10insidevar
archetype AMB_M10
volume -1000
poly_loop 2 4000 30000
pan_range 2000
howltxta freq 2
howltxtb freq 2
voceerie freq 2

//GARDEN

//CRICKETS
schema m10crickets
archetype AMB_M10
mono_loop 0 0
volume -1700
crickets

//MIGHTLP
schema m10nightlp
archetype AMB_M10
mono_loop 0 0
volume -2000
nightlp

//CHAPEL
schema m10chapel
archetype AMB_M10
poly_loop 2 2000 3000
volume -2500
me1 me2 me3

schema m10chapelvar
archetype AMB_M10
mono_loop 100 200
volume -1000
singing1 singing2


//HAMMER RHY1
schema m10hamrhy1
mono_loop 0 0
volume -1000
hammer2

//HAMMER RHY2
schema m10hamrhy2
mono_loop 0 0
volume -1000
hammer2

//DRUMLOOP
schema m10drumloop
mono_loop 0 0
volume -1000
drumloop

//BASEMENT


//bell thump
schema m10bellthump
archetype AMB_M10
volume -1000
mono_loop 0 0
bellthmp


//vocal eerie
schema m10voceerie
archetype AMB_M10
volume -1000
mono_loop 5000 10000 
pan_range 2000
voceerie

//howltexture A
schema m10howlA
archetype AMB_M10
volume -700
mono_loop 5000 10000 
pan_range 2000
howltxta

//howltexture B
schema m10howlB
archetype AMB_M10
volume -700
mono_loop 5000 10000 
pan_range 2000
howltxtb

//washroom drips
schema m10drips
archetype AMB_M10
volume -3200
poly_loop 1 2000 4000 
pan_range 3000
drip1 drip2 drip3

//Pipes
schema m10pipes
archetype AMB_M10
volume -1000
mono_loop 0 0 
bubblelp

//AT TALISMANS
schema m10eees
archetype AMB_M10
mono_loop 0 0
volume -2000	
eees1

//TALISMAN ROOM
schema m10talisrm
archetype AMB_M10
mono_loop 0 0
volume -100	
SquareLo

//crypt transition
schema M10crypt
archetype AMB_M10
mono_loop 0 0
volume -1500
caveamb

//AMB LEDGE
schema m10cue1
archetype AMB_M10
volume -500
voceerie

//AMB CHANT NEAR LEDGE
schema m10ledgetrans
archetype AMB_M10
mono_loop 0 0
volume -500
SquareLo


//random snds below basement
schema m10crypt_var
archetype AMB_M10
volume -3000
mono_loop 7000 20000
pan_range 3000
delay 3000
rat1 rat2 squeaks1