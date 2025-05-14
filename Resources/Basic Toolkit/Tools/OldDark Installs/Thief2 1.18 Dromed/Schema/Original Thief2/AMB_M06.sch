//MISSION 6  "EAVESDROPPING"


//CHURCHBELL TO SIGNAL START OF BIG KARRAS-TRUART CONV.
schema m06bell
archetype AMB_M06
volume -1000
priority 255
stream
bellchu2

//ERRIE OUTSIDE WIND
schema m06wind
archetype AMB_M06
poly_loop 2 4000 5500
pan_range 2500
volume -1700
windele1 windele2 windele3 windele4 windele5

//TRANSITION-MASKING WIND
schema m06windtrans
archetype AMB_M06
mono_loop 0 0 		//WAS poly_loop 2 3000 4500
volume -2400
windstil 			//WAS wind1 wind2 wind3

//WINGED STATUE MALE
schema m06wingedM
archetype AMB_M06
mono_loop 0 0
volume -2000
wingedM

//WINGED STATUE FEMALE
schema m06wingedF
archetype AMB_M06
mono_loop 0 0
volume -1700
wingedF

//CREEPY BRASS LOOP IN LAB
schema m06brass
archetype AMB_M06
mono_loop 0 0
volume -1300
brassL

//BUBBLES IN LAB
schema m06bubbles
archetype AMB_M06
poly_loop 2 1000 5000
volume -1200
bubble1 bubble2 bubble3 bubble4

//MEDIUM STONE WHEEL-GEAR
schema m06gearM
archetype AMB_M06
mono_loop 0 0
volume -1900
gear_md1

//METAL SQUEAKS FOR STONE GEAR
schema m06squeaks
archetype AMB_M06
poly_loop 2 1000 2500
volume -2000 		//WAS -1200
squeakM1 squeakM2 squeakM3
squeakM4 

//GRAVEYARD WHISPERS
schema m06whispers
archetype AMB_M06
poly_loop 2 7000 8000
volume -2600
Hh1a0wh1 Hh1a0wh2 Hh1a0wh3
Hh1a0mo1 Hh1a0mo2 Hh1a0mo3

//GRAVEYARD SCREAMS
schema m06screams
archetype AMB_M06
poly_loop 2 4000 9000
volume -1800
scream1 scream2 scream3 
scream4 scream5

//GRAVEYARD LAUGHS
schema m06laughs
archetype AMB_M06
poly_loop 2 4000 10000
volume -1800
laugh1 laugh2 laugh3 laugh4

//INSIDE HITS-CHANGE!!
schema m06insidehits
archetype AMB_M06
delay 10000
pan_range 3000
poly_loop 2 6000 10000
volume -2400
fb1 fb2 fb3 fb4 fb5
fb6 fb7 fb8 fb9 fb10

//INSIDE MAIN LOOP-CHANGE!!
schema m06mainL
archetype AMB_M06
mono_loop 0 0
volume -1300
basement

//BASEMENT
schema m06subson
archetype AMB_M06
mono_loop 0 0
volume -1000
substr1

//BALCONY HUM
schema m06balc
archetype AMB_M06
mono_loop 0 0
volume -2200
hum2

//BALCONY OBJ
schema m06balcobj
archetype AMB_M06
mono_loop 0 0
volume -1400
hum2

//STEAMLOOP
schema M06steam
archetype AMB_M06
mono_loop 0 0
volume -2000
steamlp4 steamlp2 steamlp3

//LARGE MACHINE1
schema m06machL1
archetype AMB_M06
mono_loop 0 0
volume -500
machlg01

//LARGE MACHINE2
schema m06machL2
archetype AMB_M06
mono_loop 0 0
volume -1500
machlg02

//SMALL MACHINE3
schema m06machs3
archetype AMB_M06
mono_loop 0 0
volume -1800
machsm03

//LARGE MACHINE4
schema m06machL4
archetype AMB_M06
mono_loop 0 0
volume -1000
machlg04

//LARGE MACHINE5
schema m06machL5
archetype AMB_M06
mono_loop 0 0
volume -1000
machlg05

//LARGE MACHINE6
schema m06machL6
archetype AMB_M06
mono_loop 0 0
volume -1000
machlg06

//LARGE MACHINE7
schema m06machL7
archetype AMB_M06
mono_loop 0 0
volume -1000
machlg07

//LARGE MACHINE8
schema m06machL8
archetype AMB_M06
mono_loop 0 0
volume -1000
machlg08

//LARGE MACHINE9
schema m16machL9
archetype AMB_M06
mono_loop 0 0
volume -1000
machlg09





