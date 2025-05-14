//MISSION 16 MAGES' TOWER


//START
schema m16start
archetype AMB_M16
volume -500
keehit_s   

//OUTSIDE HUM
schema m16cavetone
archetype AMB_M16
mono_loop 0 0
volume -1500
cavetone

//WIND LO
schema m16windobj
archetype AMB_M16
volume -800  //was -1800
poly_loop 2 6000 6500
windele1 windele2 windele3 windele4 windele5

//WIND HI
schema m16windhi
archetype AMB_M16
volume -2300
poly_loop 2 3800 4200
windgst1 windgst2 windgst3 wind3 wind5

//NIGHTLOOP
schema m16night
archetype AMB_M16
mono_loop 0 0
volume -1200
nightlp nightlp2 crickets cricket2



//INSIDE-OUTSIDE TRANS
schema m16trans
archetype AMB_M16
volume -1500
caveamb


//FIRE TOWER

//FIRE TOWER HUM
schema m16firetower
archetype AMB_M16
volume -500
mono_loop 0 0
humfire

//FIRE CRYSTAL LOOP
schema m16firecrystal
archetype AMB_M16
volume -1500
mono_loop 0 0
redcrys1 redcrys2 redcrys3


//Lava 1 -burbling
schema m16lava1
archetype AMB_M16
mono_loop 0 0
volume -400
lavalp1 lavalp2

//lava 2 -steam blasts
schema m16lava2
archetype AMB_M16
poly_loop 2 3000 4500
volume -500
lavabst1 lavabst2 lavabst3

//lava 3 -soft bubbling steam
schema m16lava3
archetype AMB_M16
mono_loop 0 0
volume -1000
steamlp1

//lava 4 -crackle
schema m16lava4
archetype AMB_M16
mono_loop 0 0
volume -750
crackle2


//AIR

//AIR TOWER TONES
schema m16airtower
archetype AMB_M16
delay 1000
volume -1700
pan_range 3000
poly_loop 2 3000 10000
airtone1 airtone2 airtone3 airtone4 airtone5 airtone6

//AIRTOWER HUM
schema m16airhum
archetype AMB_M16
volume -1500  //was -1200
mono_loop 0 0
humair
 
//ROCKLIFT LOOP
schema m16rocklift
archetype AMB_M16
volume -1800 //was -2500
mono_loop 0 0
rocklif1 rocklif2 rocklif3 rocklif4 rocklif5

//WATER TOWER

//WATER TOWER HUM
schema m16watertower
archetype AMB_M16
volume -1500
mono_loop 0 0
waterlp4

//WATER
schema m16water
archetype AMB_M16
mono_loop 0 0
volume -2000
waterlp1

//CALM WATER
schema m16watercalm
archetype AMB_M16
mono_loop 0 0
volume -2000
waterlp2

//VERY CALM WATER
schema m16water3
archetype AMB_M16
mono_loop 0 0
volume -2000
waterlp3

//EARTH HUM
schema m16earthhum
archetype AMB_M16
mono_loop 0 0
volume -1000
abyss2

//EARTH TOWER CHANTS
schema m16earthtower
archetype AMB_M16
poly_loop 2 8000 30000
pan_range 2000
volume -1000
rumble2 rumble3 rumble1









