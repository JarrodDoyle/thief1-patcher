//MISSION 15 -THIEVES GUILD

//START MISSION
schema m15start
archetype AMB_M15
volume -500
keehit_s   

//WIND ENV. -SOFT
schema m15windp
archetype AMB_M15
volume -700  
pan_range 3000   
poly_loop 2 4000 7000
windlit1 windlit2

//WIND OBJECT
schema m15wind
archetype AMB_M15
volume -700  
poly_loop 2 4000 7000
windlit1 windlit2

//INSIDE 1ST FLOOR
schema m15loop
archetype AMB_M15
mono_loop 0 0
volume -1400
thloop1

//TRANS 
schema m15trans
archetype AMB_M15
mono_loop 0 0
volume -1200  //was -1500
caveamb

//INSIDE 1ST FLOOR
schema m15loop
archetype AMB_M15
mono_loop 0 0
volume -1400
thloop1

schema m15bigbeet
archetype AMB_M15
mono_loop 0 0
volume -800
Beet1812

//tones
schema m15btones
archetype AMB_M15
delay 3000
poly_loop 2 4000 6000
pan_range 3000
volume -2000
fb5 fb6 fb7 fb8 fb9 fb10

//TRANS FROM BIG BEET
schema m15ahhs
archetype AMB_M15
mono_loop 0 0
volume -1200
velour2


//DOWNSTAIRS HUM (S)
schema m15down
archetype AMB_M15
mono_loop 0 0
volume -1000 
thdown

schema guildhits
archetype AMB_M15
poly_loop 2 1000 10000
delay 2000
pan_range 3000
volume -400 //was -700
guildH1 guildH2 guildH3 guildH4

//tones
schema m15tones
archetype AMB_M15
poly_loop 2 4000 20000
pan_range 3000
volume -2200
fb5 fb6 fb7 fb8 fb9 fb10

//beat1
schema m15beat1
archetype AMB_M15
mono_loop 0 0
volume -800  //was -1200
tonebend

//tension
schema m15tension
archetype AMB_M15
volume -1400  
tension1 tension2 tension3 tension7


////////////////////////////////

//NIGHT LOOP
schema m15nightlp
archetype AMB_M15
mono_loop 0 0
volume -2200  
nightlp

//BIRDS
schema m15birds
archetype AMB_M15
delay 3000
poly_loop 2 4000 20000
pan_range 2000
volume -2500  
bird1 bird2 bird3 



//WATER SMALL1
schema m15waterS1
archetype AMB_M15
mono_loop 0 0
volume -1600 
Wtr__sm1 

//WATER SMALL2
schema m15waterS2
archetype AMB_M15
mono_loop 0 0
volume -1600 
Wtr__sm2 

//WATER SMALL3
schema m15waterS3
archetype AMB_M15
mono_loop 0 0
volume -1600 
Wtr__sm3


//WATER MEDIUM1
schema m15waterM1
archetype AMB_M15
mono_loop 0 0
volume -1900 
Wtr__md1

//WATER MEDIUM2
schema m15waterM2
archetype AMB_M15
mono_loop 0 0
volume -1900 
Wtr__md2 

//WATER MEDIUM3
schema m15waterM3
archetype AMB_M15
mono_loop 0 0
volume -1900 
Wtr__md3

//WATER MEDIUM4
schema m15waterM4
archetype AMB_M15
mono_loop 0 0
volume -1900 
Wtr__md4


//WATER IN TUNNELS
schema m15waterslo
archetype AMB_M15
mono_loop 0 0
volume -1000 
waterlp2

//WATER DRIPS
schema m15water_drip
archetype AMB_M15
poly_loop 2 3000 6000
volume -1600 
Drip1 Drip2 Drip3
Drip4 Drip5 Drip6

//TICKING MACHINES
schema m15ticking
archetype AMB_M15
mono_loop 0 0
volume -1000 
tapping

//TICKING MACHINES2
schema m15ticking2
archetype AMB_M15
mono_loop 0 0
volume -1000 
printing




schema m15down2
archetype AMB_M15
mono_loop 0 0
volume -200 
thdown2




schema m15down3
archetype AMB_M15
mono_loop 0 0
volume -1100 
thdown3









//throbs hi
schema m15throbH
archetype AMB_M15
mono_loop 0 0
volume -1400
throbhi

//throbs low
schema m15throbL
archetype AMB_M15
mono_loop 0 0
volume -1400
throblo







