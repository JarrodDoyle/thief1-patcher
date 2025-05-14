//MISSION 9  "BLACKMAIL"

//GREGORIAN CHANT IN CHURCH 	
schema m09gregorian
archetype AMB_M09
stream
mono_loop 5 15
volume -2000
gregfull

//OUTSIDE WIND (LIGHT) 	
schema m09wind
archetype AMB_M09
poly_loop 2 3000 4500
volume -2700
wind1 wind2 wind3


//ROOFTOP WIND (MEDIUM GUSTS) 	
schema m09wind_roof
archetype AMB_M09
poly_loop 2 2000 3000
volume -2500
wind4 wind5 wind6
wind7 wind8


//CHURCH BELL	
schema m09churchbell
archetype AMB_M09
mono_loop 0 0
volume -400
beatbel1

//2ND FLOOR VOICE LOOP	
schema m09voiceL1
archetype AMB_M09
mono_loop 0 0
volume -2300
voiceL1

//1ST FLOOR TONE BEND LOOP	
schema m09tonebend
archetype AMB_M09
mono_loop 0 0
volume -1100
tonebend

//1ST FLOOR LOBBY STRING MUSIC	
schema m09vlncalm1
archetype AMB_M09
delay 60000
mono_loop 90000 120000
stream
volume -3000
vlncalm1

//1ST FLOOR HOT HOUSE AMB STEAM HISS
schema m09hissL
archetype AMB_M09
mono_loop 0 0
volume -2100
hiss1L

//1ST FLOOR HOT HOUSE STEAM SPURTS
schema m09hisses
archetype AMB_M09
mono_loop  2000 4500
volume -2600
hiss1 hiss2 hiss3

//TO 2ND FLOOR TRANSITION
schema m09pianoL1
archetype AMB_M09
mono_loop  0 0
volume -2000
voiceL1

//BASEMENT/1ST FLOOR VOICE LOOP
schema m09basementL
archetype AMB_M09
mono_loop  0 0
volume -1700
basemen2

//TREM "HITS"
schema m09trem_hits
archetype AMB_M09
delay 10000
poly_loop  2 7000 12000
pan_range 2000
volume -1400
trem___1 trem___2 trem___3
trem___1 trem___4 trem___6

//CREEPY STRING "HITS"
schema m09string_hits
archetype AMB_M09
delay 15000
mono_loop 7000 18000
pan_range 2000
volume -1700
vln_hit1 vln_hit2 vln_hit3
vln_hit4 vln_hit5 
