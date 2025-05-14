//MISSION 2  "SHIPPING & RECEIVING"

//LITE OUTSIDE WIND 
schema m02_litewind
archetype AMB_M02
poly_loop 2 5000 6500
volume -1000
Windlit5 Windlit6

//SEA WIND GUSTY
schema m02seawind
archetype AMB_M02
poly_loop 2 3000 4000
volume -2000
Wind6 Wind7 Wind8

//CICADS 
schema m02_cicads
archetype AMB_M02
mono_loop 0 0  	//was poly_loop 2 2000 3000
volume -2700  //was -2400 
night1 night2 night3 night4 night5  
			//was cicad1 cicad2 cicad3 cicad4

//OFFICE MACHINE
schema m02machine1
archetype AMB_M02
mono_loop 0 0
volume -2400
tapping

//COLD STORAGE HUM
schema m02fridge
archetype AMB_M02
mono_loop 0 0
volume -1500
fridge1

//MAIN BACKGROUND LOOP
schema m02mainL
archetype AMB_M02
mono_loop 0 0
volume -3000
L2_base1

//ORCHESTRA THEME
schema m02orchestra
archetype AMB_M02
delay 90000
stream
no_repeat
mono_loop 60000 90000
volume -1300
swells1 swells2

//TREM HITS
schema m02hits1
archetype AMB_M02
poly_loop 2 6500 20000 //was 9000
pan_range 2500
volume -1700
trem___1 trem___2 trem___3

//MACHINES

//SMALL GRINDING STONE GEARS
schema m02gearM
archetype AMB_M02
mono_loop 0 0
volume -1000
gear_md1

//LARGE GRINDING STONE GEARS
schema m02gearLG
archetype AMB_M02
mono_loop 0 0
volume -750
gear_lg1

//SMALL MACHINE1
schema m02machS1
archetype AMB_M02
mono_loop 0 0
volume -1000
machsm01

//SMALL MACHINE2
schema m02machS2
archetype AMB_M02
mono_loop 0 0
volume -1000
machsm02

//SMALL MACHINE3
schema m02machS3
archetype AMB_M02
mono_loop 0 0
volume -1000
machsm03

//SMALL MACHINE4
schema m02machS4
archetype AMB_M02
mono_loop 0 0
volume -1000
machsm04

//SMALL MACHINE5
schema m02machS5
archetype AMB_M02
mono_loop 0 0
volume -1000
machsm05

//SMALL MACHINE6
schema m02machS6
archetype AMB_M02
mono_loop 0 0
volume -1000
machsm06

//LARGE MACHINE1
schema m02machL1
archetype AMB_M02
mono_loop 0 0
volume -1000
machlg01

//LARGE MACHINE2
schema m02machL2
archetype AMB_M02
mono_loop 0 0
volume -1000
machlg02

//LARGE MACHINE3
schema m02machL3
archetype AMB_M02
mono_loop 0 0
volume -1000
machlg03

//LARGE MACHINE4
schema m02machL4
archetype AMB_M02
mono_loop 0 0
volume -1000
machlg04

//LARGE MACHINE5
schema m02machL5
archetype AMB_M02
mono_loop 0 0
volume -1000
machlg05

//LARGE MACHINE6
schema m02machL6
archetype AMB_M02
mono_loop 0 0
volume -1000
machlg06

//LARGE MACHINE7
schema m02machL7
archetype AMB_M02
mono_loop 0 0
volume -1000
machlg07

//LARGE MACHINE8
schema m02machL8
archetype AMB_M02
mono_loop 0 0
volume -1000
machlg08

//LARGE MACHINE9
schema m02machL9
archetype AMB_M02
mono_loop 0 0
volume -1000
machlg09

//SHIP CREAK
schema m02creaks
archetype AMB_M02
poly_loop 2 7500 15000
volume -1100
creak1 creak2 creak3





