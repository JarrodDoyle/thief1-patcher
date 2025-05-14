//MISSION 16  "ENDGAME"

//SMALL GRINDING STONE GEARS
schema m16gearM
archetype AMB_M16
mono_loop 0 0
volume -1000
gear_md1

//LARGE GRINDING STONE GEARS
schema m16gearLG
archetype AMB_M16
mono_loop 0 0
volume -750
gear_lg1

//SMALL MACHINE1
schema m16machS1
archetype AMB_M16
mono_loop 0 0
volume -1000
machsm01

//SMALL MACHINE2
schema m16machS2
archetype AMB_M16
mono_loop 0 0
volume -1000
machsm02

//SMALL MACHINE3
schema m16machS3
archetype AMB_M16
mono_loop 0 0
volume -1000
machsm03

//SMALL MACHINE4
schema m16machS4
archetype AMB_M16
mono_loop 0 0
volume -1000
machsm04

//SMALL MACHINE5
schema m16machS5
archetype AMB_M16
mono_loop 0 0
volume -1000
machsm05

//SMALL MACHINE6
schema m16machS6
archetype AMB_M16
mono_loop 0 0
volume -1000
machsm06

//LARGE MACHINE1
schema m16machL1
archetype AMB_M16
mono_loop 0 0
volume -1000
machlg01

//LARGE MACHINE2
schema m16machL2
archetype AMB_M16
mono_loop 0 0
volume -1000
machlg02

//LARGE MACHINE3
schema m16machL3
archetype AMB_M16
mono_loop 0 0
volume -1000
machlg03

//LARGE MACHINE4
schema m16machL4
archetype AMB_M16
mono_loop 0 0
volume -1000
machlg04

//LARGE MACHINE5
schema m16machL5
archetype AMB_M16
mono_loop 0 0
volume -1000
machlg05

//LARGE MACHINE6
schema m16machL6
archetype AMB_M16
mono_loop 0 0
volume -1000
machlg06

//LARGE MACHINE7
schema m16machL7
archetype AMB_M16
mono_loop 0 0
volume -1000
machlg07

//LARGE MACHINE8
schema m16machL8
archetype AMB_M16
mono_loop 0 0
volume -1000
machlg08

//LARGE MACHINE9
schema m16machL9
archetype AMB_M16
mono_loop 0 0
volume -1000
machlg09

//WINGED STATUE MALE
schema m16wingedM
archetype AMB_M16
mono_loop 0 0
volume -1600
wingedM

//WINGED STATUE FEMALE
schema m16wingedF
archetype AMB_M16
mono_loop 0 0
volume -1200
wingedF


//BEACON CHOIR LOOP 
schema m16beacon
archetype AMB_M16
mono_loop 0 0
volume -1000
wingedF

//MEDIUM  SIZE METAL SQUEAKS 
schema m16squeakM
archetype AMB_M16
poly_loop 2 3000 5000
volume -1000
squeakM1 squeakM2 squeakM3
squeakM4 squeakM5

//Lava2 -more intense
schema m16lava2
archetype AMB_M16
mono_loop 0 0
volume -400
lavalp2

//lava steam2 -soft bubbling steam
schema m16steam2
archetype AMB_M16
mono_loop 0 0
volume -1300
steamlp1

//lava crackle1
schema m16crackle1
archetype AMB_M16
mono_loop 0 0
volume -1100
crackle1

//BELL AMBIENT
schema m16bell1
archetype AMB_M16
mono_loop 0 0
volume -600
beatcym2

//VIOLENT FIRE
schema m16fireV
archetype AMB_M16
mono_loop 0 0
volume -150
firebst1 firebst2 firebst3

//BLADES (SAW)
schema m16blade
archetype AMB_M16
mono_loop 0 0
volume -700
blade1 blade2

//WIND AT BEACONS
schema m16topwind
archetype AMB_M16
poly_loop 2 2500 4000
volume -1300
wind1 wind2 wind3

//LARGE REFRIDGERATION UNITS
schema m16bigfridge
archetype AMB_M16
mono_loop 0 0
volume -1000
fridge2

//OUTSIDE
//WIND FRONT
schema m16windLo
archetype AMB_M16
poly_loop 2 3000 5000
volume -2200
windele1 windele2 windele3
windele4 windele5

//CICADS
schema m16cicads
archetype AMB_M16
poly_loop 2 3000 5000
pan_range 2400
volume -1800
cicad1 cicad2 cicad3
cicad4

//ORCHESTRA THEME
schema m16orchestra
archetype AMB_M02
delay 90000
stream
no_repeat
mono_loop 60000 90000
volume -1300
s01mel1

//INSIDE LOOP
schema m16insideL
archetype AMB_M16
poly_loop 2 5000 6000
volume -1000
no_repeat
amb_low1 amb_low2
amb_low3 amb_low4

//INSIDE HITS
schema m16hitsL
archetype AMB_M16
pan_range 2000
delay 3000
mono_loop 6000 10000
volume -1400
btrem1 btrem2 btrem3
btrem4 btrem5
m01tone1 m01tone2 m01tone3
m01tone4 m01tone5 m01tone6
m01tone7 m01tone8

//WATER HOLY
schema m16holyW
archetype AMB_M16
mono_loop 0 0
volume -1800
wtr_holy

//SCRIPTED MACHINES

//ELECTRIC ARC
schema m16arc
archetype DEVICE_MISC
mono_loop 0 0
volume -300
zaparc

//STEAM LOOP
schema m16steam
archetype DEVICE_MISC
mono_loop 0 0
volume -300
steamlp2 steamlp3 steamlp4

//STEAM LOOP BUBBLY
schema m16steambub
archetype DEVICE_MISC
mono_loop 0 0
volume -300
steamlp1

//STEAM BLAST
schema m16steamblast
archetype DEVICE_MISC
volume -1
steambla

//BUZZER
schema m16buzzer
archetype DEVICE_MISC
volume -1
buzzer

//FAN
schema m16fan
archetype DEVICE_MISC
mono_loop 0 0
volume -1
fan

//CLICKING
schema m16dial1
archetype DEVICE_MISC
mono_loop 0 0
volume -500
printing

schema m16dial2
archetype DEVICE_MISC
mono_loop 0 0
volume -500
camstop

schema m16dial3
archetype DEVICE_MISC
mono_loop 0 0
volume -500
wheelstp

//GEARS
schema m16gear1
archetype DEVICE_MISC
mono_loop 0 0
volume -1
gears1r

schema m16gear2
archetype DEVICE_MISC
mono_loop 0 0
volume -1
gears2r

schema m16gear3
archetype DEVICE_MISC
mono_loop 0 0
volume -1
gears4

//MACHINES
schema m16mach1
archetype DEVICE_MISC
mono_loop 0 0
volume -1
machlg01

schema m16mach2
archetype DEVICE_MISC
mono_loop 0 0
volume -1
machlg06

schema m16mach3
archetype DEVICE_MISC
mono_loop 0 0
volume -1
machlg07

schema m16mach4
archetype DEVICE_MISC
mono_loop 0 0
volume -1
machlg08

schema m16mach5
archetype DEVICE_MISC
mono_loop 0 0
volume -1
machlg09


