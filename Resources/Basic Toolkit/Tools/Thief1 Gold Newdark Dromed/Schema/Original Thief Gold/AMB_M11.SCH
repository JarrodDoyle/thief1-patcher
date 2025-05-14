//AMBIENT ENVIRONMENTS & OBJECTS

//WARDS
schema unlock_fireward
archetype AMB_M11
volume -1
wardfire
env_tag (Event statechange) (Lockstate unlocked) (WardType FireWard)

schema unlock_earthward
archetype AMB_M11
volume -1
warderth
env_tag (Event statechange) (Lockstate unlocked) (WardType EarthWard)

schema unlock_waterward
archetype AMB_M11
volume -1
wardh20
env_tag (Event statechange) (Lockstate unlocked) (WardType WaterWard)

schema unlock_airward
archetype AMB_M11
volume -1
wardair
env_tag (Event statechange) (Lockstate unlocked) (WardType AirWard)

//MURUS APPEARING & DISAPPEARING
schema mur_appear
archetype AMB_M11
volume -2000
murappr

//TASK DONE
schema task_done
archetype AMB_M11
volume -1500
taskdone

//FF IN FRONT OF DOOR
schema ffield
archetype AMB_M11
volume -500
mono_loop 0 0
bridge1

//EYE ACTIVATED
schema the_eye
archetype AMB_M11
volume -1000
mono_loop 0 0
theeye





//OUTSIDE

//OUTSIDE WIND
schema m11wind
archetype AMB_M03
poly_loop 2 3000 4000
pan_range 2000
volume -1700
wind1 freq 5
wind2 freq 5
wind3 freq 5
wind4 freq 1
wind5 freq 1

//MAIN CATHEDRAL

//GASP AT DOORS
schema m11gasp
archetype AMB_m11
mono_loop 30000 30000
volume -1000
whgasp

//MAIN CATHEDRAL TONE
schema m11subsonic
archetype AMB_m11
mono_loop 0 0
volume -500
subson1

//HOLYWATER ROOM
schema m11holywater
archetype AMB_m11
poly_loop 2 4000 6000
volume -1300
aahs1 aahs2 aahs3

//UPPER FLOORS

//LEDGE1
schema m11ledge1
archetype AMB_m11
volume -1000
vbreath

//LEDGE2
schema m11ledge2
archetype AMB_m11
volume -1000
vooh

//LEDGE3
schema m11ledge3
archetype AMB_m11
volume -1500
vforever

//ENCLOSED AREAS
schema m11caveamb
archetype AMB_m11
mono_loop 0 0
volume -1500
caveamb

//SPARKLY BELLS AT EYE
schema m11bells
archetype AMB_M11
poly_loop 2 5000 5500
volume -2700
bells1 bells2

//PANTING ON EYE
schema m11pant
archetype AMB_M11
mono_loop 0 0
volume -2200
panting

//BELL TOWER
schema m11windbells
archetype AMB_m11
mono_loop 0 0
volume -1500
windbell

//WE STARVE WHISPERS
schema m11westarve
archetype AMB_m11
poly_loop 2 1500 6000
pan_range 1500
volume -2000
vneedyou vplease vhearme vhungry vwestarv 


//BASEMENT

//drips
schema m11drips
archetype AMB_m11
mono_loop 10 10000
volume -2500
drip1 freq 4
drip2 freq 4
drip3 freq 4
rat1 freq 1
rat2 freq 1

//SQUEAKS
schema m11squeaks
archetype AMB_m11
mono_loop 10000 20000
volume -1500
squeaks1

//WATER IN BASEMENT
schema m11watercalm
archetype AMB_m11
mono_loop 0 0
volume -1500
waterlp2

//PIPES IN BASEMENT
schema m11pipes
archetype AMB_m11
mono_loop 0 0
volume -1000
bubblelp

//TRAP1 COLLAPSING CORNER
schema m11trap1
archetype AMB_m11
mono_loop 10000 10000
volume -1200
squeaks

//OUTSIDE IN REAR

//STILL WIND IN BACK
schema m11windstil
archetype AMB_m11
mono_loop 0 0
volume -1500
windstil

//1ST BUILDING

//1st BLDG HUM
schema m11hum
archetype AMB_m11
mono_loop 0 0
volume -600
hum

//MOANS
schema m11moans
archetype AMB_m11
volume -2000
pan_range 2500
poly_loop 2 4000 15000
zommoan1 zommoan2 zommoan3 zommoan4

//BELLTHUMP
schema m11bellthump
archetype AMB_m11
volume -700
bellthmp

//WHISPER ONE SHOT
schema m11comehere
archetype AMB_m11
volume -1500
vcomhere vcomher2 vforever

//HOLY ROOM
schema m11holyroom
archetype AMB_m11
volume -1500
mono_loop 0 0
belltoll

//2nd BLDG
schema m11subson2
archetype AMB_m11
volume -1200
mono_loop 0 0
subson2

//UNDERGROUND TUNNELS
schema m11tunnels
archetype AMB_m11
volume -2500
pan_range 1500
poly_loop 2 3000 15000
m04cat1a m04cat1c m04cat2a m04cat2b m04cat2c

//LIBRARY

//WHISPERS
schema m11whispers
archetype AMB_m11
poly_loop 2 1500 6000
pan_range 2500
volume -1500
vneedyou vplease vhearme vhungry vwestarv 

//PUFFY
schema m11puffyA
archetype AMB_m11
mono_loop 0 0
pan -3000
volume -1000
puffy

schema m11puffyB
archetype AMB_m11
mono_loop 0 0
delay 50
pan 3000
volume -1000
puffy

//GRAVEYARD
schema m11windlite
archetype AMB_m11
poly_loop 2 5000 5000
volume -1000
windlit1 windlit2

schema m11aahs
archetype AMB_m11
poly_loop 2 5000 6000
pan_range 3000
delay 3000
volume -2500
aahs1 aahs2 aahs3 empty



















