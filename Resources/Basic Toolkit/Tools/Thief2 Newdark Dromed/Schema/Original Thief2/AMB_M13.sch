//MISSION 13  "MASKS" &12

//OUTSIDE WIND LO
schema m13wind
archetype AMB_M13
poly_loop 2 3500 5000
volume -1800
wind1 wind2 wind3
wind1lo wind2lo wind3lo

//OUTSIDE WIND LO TRANS
schema m13windTrans
archetype AMB_M13
poly_loop 2 3500 5000
volume -1400
wind1lo wind2lo wind3lo

//RAIN SNDS FOR LEVEL 13 
schema m13rain
archetype AMB_M13
poly_loop 2 3000 5000
volume -1400
rain_lt1 rain_lt2 rain_lt3
rain_lt4 rain_lt5

//WATER HOLY
schema m13holyW
archetype AMB_M13
mono_loop 0 0
volume -1800
wtr_holy

//GREGORIAN CHANT IN CHURCH 	
schema m13gregorian
archetype AMB_M09
stream
mono_loop 5 15
volume -2000
gregfull

//SUBWAY TO SALLY AMBIENT
schema m13STS_amb
archetype AMB_M13
mono_loop 0 0
volume -1500
STS_amb1

//AMB HITS CHANGE THESE!!!! 
schema m13tones
archetype AMB_M13
poly_loop 2 10000 17000
delay 15000
pan_range 2500
volume -2900
airtone1 airtone2 airtone3
airtone4 airtone5 airtone6