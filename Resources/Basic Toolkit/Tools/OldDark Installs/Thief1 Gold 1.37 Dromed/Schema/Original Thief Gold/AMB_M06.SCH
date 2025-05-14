//MISSION 6 -STEAL FROM CON

//OUTSIDE

//START WIND
schema m06wind
archetype AMB_M06
delay 2000
poly_loop 2 5500 6000
volume -1200
wind1lo wind2lo wind3lo

//CRICKETS
schema m06crickets
archetype AMB_M06
mono_loop 0 0
volume -2000
crickets

//NIGHTLOOP
schema m06nightlp
archetype AMB_M06
mono_loop 0 0
volume -2000
nightlp

//TRANS AT FRONT ENTRANCE
schema m06trans
archetype AMB_M06
mono_loop 0 0
volume -1500
windstil

//1ST FLOOR

//1ST FLOOR MAIN
schema m06f1
archetype AMB_M06
mono_loop 0 0
volume -1300
abyss1

//BALCONY CUE
schema m06balcue
archetype AMB_M06
volume -500
bellthmp

//1ST FLOOR CUE1 -IN & OUT OF ROOMS
schema m06f1cue1
archetype AMB_M06
volume -1000
howltxta   //try string or synth note

//1ST FLOOR CUE2 -IN & OUT OF ROOMS
schema m06f1cue2
archetype AMB_M06
volume -1000
howltxtb

//1ST FLOOR CUE3 -IN & OUT OF ROOMS
schema m06f1cue3
archetype AMB_M06
volume -1000
bellthmp

//GARDEN
schema m06garden
archetype AMB_M06
mono_loop 0 0
volume -3000
nightlp

//GARDEN RANDOMS
schema M06forest
archetype AMB_M06
mono_loop 0 0
volume -1500
forest1 forest2 forest3 forest4 forest5 forest6


//CAVE BEHIND GARDEN
schema m06cave
archetype AMB_M06
mono_loop 0 0
volume -500
subson1

//CAVE TRANS
schema m06cavetrans
archetype AMB_M06
mono_loop 0 0
volume -500
subson1

//PUFFY
schema m06puffyL
archetype AMB_M06
mono_loop 0 0
pan -2500
volume -1200
puffy

schema m06puffyR
archetype AMB_M06
delay 50
mono_loop 0 0
pan 2500
volume -1200
puffy



//2ND FLOOR

//2ND FLOOR MAIN
schema m06f2
archetype AMB_M06
mono_loop 0 0
volume -700
subson2

//2ND FLOOR CUE1
schema m06f2cue1
archetype AMB_M06
volume -500
bellthmp

//2ND FLOOR CUE2
schema m06f2cue2
archetype AMB_M06
volume -1000
diffuse

//2ND FLOOR CUE3 -Con's room
schema m06f2cue3
archetype AMB_M06
volume -1000
voceerie

//HARSH
schema m06harsh
archetype AMB_M06
mono_loop 0 0
volume -1000
harsh1 harsh2




//3rd FLOOR
schema m06F3
archetype AMB_M06
mono_loop 0 0
volume -400
subson1

//VIK GIGGLE
schema m06vikgig
archetype AMB_m06
mono_loop 1000 5000
volume -2500
delay 1000
pan_range 3000
vikgig1 vikgig2 vikgig3 vikgig4

//growls & Vik
schema m06grvik
archetype AMB_m06
mono_loop 1000 5000
volume -2500
delay 1000
pan_range 3000
vikgig1 vikgig2 vikgig3 vikgig4 gr1 gr2 gr3 gr4 gr5 gr6 gr7 gr8 gr9


//SPACE WHISPERS
schema m06westarve
archetype AMB_m06
poly_loop 2 1500 8000
no_repeat
pan_range 2500
volume -2500
vneedyou vplease vhearme vhungry vwestarv 

//CURLY ROOM
schema m06warble
archetype AMB_m06
no_repeat
poly_loop 2 2000 3000
pan_range 2500
volume -3200
warble1 warble2 warble3 

//SPACE
schema m06space
archetype AMB_m06
mono_loop 0 0
volume -2200
bridge1
 


/////////
//WATER//
/////////

//WATER SMALL -FOUNTAIN
schema m06watersm
archetype AMB_M06
mono_loop 0 0
volume -2500
waterlp1

//WATERCALM
schema m06watercalm
archetype AMB_M06
mono_loop 0 0
volume -2000
waterlp2

//WATER STREAM
schema m06water
archetype AMB_M06
mono_loop 0 0
volume -1800
waterlp1

//DRIPS IN BATHROOM
schema m06drips
archetype AMB_M06
poly_loop 2 1500 8000
volume -2500
drip1 drip2 drip3

//WATER IN SMALL TOWN & GIANT HOUSE


//WATER FALL IN SMALL TOWN
schema m06townfalls
archetype AMB_M06
mono_loop 0 0
volume -1000
wtr__md2

//WATER LAKE1 IN SMALL TOWN
schema m06townlake1
archetype AMB_M06
mono_loop 0 0
volume -1000
wtr__md3

//WATER LAKE1 IN SMALL TOWN
schema m06townlake2
archetype AMB_M06
mono_loop 0 0
volume -1000
wtr__md4


//WATER STREAM IN SMALL TOWN
schema m06townstream
archetype AMB_M06
mono_loop 0 0
volume -1500
wtr__sm3

//BIG HOUSE

//FIRE IN BIG HOUSE
schema m06bigfire
archetype AMB_M06
mono_loop 0 0
volume -1000
firelp2

//BIG HOUSE AMBS

schema m06belleamb
archetype AMB_M06
mono_loop 0 0
volume -1000
belles

schema m06choirLo
archetype AMB_M06
mono_loop 0 0
volume -1500
choirLo

schema m06tonebend
archetype AMB_M06
mono_loop 0 0
volume -1000
tonebend


//3rd FLOOR-KEMAL///////

//ENTER 3rd FLOOR GRASS TUNNELS
schema m06f3cue1
archetype AMB_M06
volume -1000
howltxta 
//change snd to cymbal???

//ENTER CON'S SWORD  ROOM
schema m06f3cue2
archetype AMB_M06
volume -1000
howltxtb 

//SWORD  ROOM
schema m06sword
archetype AMB_M06
poly_loop 2 1500 3300
volume -2200
eees1 eees2 eees3
//replace snd with pulsing sword //sound

//OVERLOOK GARDEN
schema m06f3cue3
archetype AMB_M06
volume -1000
bellthmp
//replace snd with ahh
//sound




 


