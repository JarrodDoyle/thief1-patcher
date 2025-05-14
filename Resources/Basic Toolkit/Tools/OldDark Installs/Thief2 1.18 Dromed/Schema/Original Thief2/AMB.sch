//GLOBAL AMBIENTS

//HIT THAT PLAYS WHEN YOU START THE MISSION
schema m00start
archetype AMB_MISC
volume -800
ambstart


//////////
//LIGHTS//
//////////

//TORCHES	<--on "Extinguishable" obj
schema torch_flame
archetype AMB_MISC
mono_loop 0 0
volume -1700
firelp1 firelp8 firelp9

//GAS TORCHES	<--on "Gaslight" obj
schema gaslight_lp
archetype AMB_MISC
mono_loop 0 0
volume -3000
gaslp1 gaslp2 gaslp3

//FIREPLACE FLAMES	<--on "Flame" obj
schema fire_flame
archetype AMB_MISC
mono_loop 0 0
volume -1000
firelp1 firelp8 firelp9

//COLLECTOR TOWER LIGHT	<--on "CollTower Ball Glow" obj
schema glowball_lp
archetype AMB_MISC
mono_loop 0 0
volume -100
glowball glowbal2

//STREET LIGHT LOOP <--on "ElectricLampCenterBall" obj
schema strlight_lp
archetype AMB_MISC
mono_loop 0 0
no_repeat
volume -1300  //was -1700
stlight1 stlight2 stlight3

//VIK GLOW GAS	<--on "VicGlowGas" obj
schema vikglow_lp
archetype AMB_MISC
no_repeat
mono_loop 0 0
volume -2400 //was -2800
paglit1 paglit2 paglit3

//PURPLE CRYSTALS	<--on "MawCrystals" obj
schema purple_lp
archetype AMB_MISC
no_repeat
mono_loop 0 0
volume -1600 //was -2000
vikglow1 vikglow2 vikglow3 vikglow4 vikglow5


//WILL 'O WISP	<--on "Will 'O Wisp" obj
schema paglight_lp
archetype AMB_MISC
no_repeat
mono_loop 0 0
volume -1000
paglit1 paglit2 paglit3

//CAULDRON FIRE	<--on "CaudronFire" obj
schema cauldron_lp
archetype AMB_MISC
mono_loop 0 0
volume -800 //was-1200
lavalp1

//SEWER LITE	<--on "SewerLite" obj
schema sewerlite_lp
archetype AMB_MISC
mono_loop 0 0
volume -2000   //was -1500
litelp1 litelp2 litelp3

//PORTAL LOOP	<--on "MawPortal" obj
schema portal_lp
archetype AMB_MISC
mono_loop 0 0
volume -1100
portal

//PARTICAL BRIDGE	<--on "ParticleBridge" obj
schema pbridge_lp
archetype AMB_MISC
mono_loop 0 0
volume -500
pbridge

////////////
//MACHINES//
////////////

//TRANSFORMERS 	<--on "Transformers" obj
schema transf_lp
archetype AMB_MISC
mono_loop 0 0
volume -2000 //was -2400
transf1 transf2 transf3

//COILS	<--on "Coils" obj
schema coil_lp
archetype AMB_MISC
mono_loop 0 0
volume -900 //was -1200
coil1 coil2 coil3


///////////////
//WATER LOOPS//
///////////////

//UNDERWATER
schema underwater
archetype AMB_MISC
mono_loop 0 0
volume -1
underwat

//WATER POOL [ie: stillwater]
schema waterpool
archetype AMB_MISC
mono_loop 0 0
volume -1600 //was -2000
wpool1 wpool2 wpool3

//WATER POOL UNDERGROUND [w/reverb]
schema waterpool_rvb
archetype AMB_MISC
mono_loop 0 0
volume -1400 //was -1800
wpoolrv1 wpoolrv2

//WATER FLOWING SLOW
schema waterslow
archetype AMB_MISC
mono_loop 0 0
volume -1100 //was -1500
wslow1 wslow2 wslow3

//WATER FLOWING SLOW UNDERGROUND {w/reverb]
schema waterslow_rvb
archetype AMB_MISC
mono_loop 0 0
volume -1100 //was -1500
wslowrv1 wslowrv2

//WATER FLOWING FAST
schema waterfast
archetype AMB_MISC
mono_loop 0 0
volume -1100 //was -1500
wfast1 wfast2 wfast3

//WATER FLOWING FAST UNDERGROUND (w/reverb)
schema waterfast_rvb
archetype AMB_MISC
mono_loop 0 0
volume -1100 //was -1500
wfastrv1 wfastrv2

//WATER WAVES SM [like at edge of a pool]
schema waterwave_sm
archetype AMB_MISC
mono_loop 0 0
volume -1700 //was -2200
wwavesm1 wwavesm2

//WATER WAVES LG 
schema waterwave_lg
archetype AMB_MISC
mono_loop 0 0
volume -1200 //was -1800
wwavelg1 wwavelg2 wwavelg3

//WATER FAUCET
schema waterfaucet
archetype AMB_MISC
mono_loop 0 0
volume -1800 //was -2200
wfaucet1 wfaucet2

//WATER FOUNTAIN SM
schema waterfount_sm
archetype AMB_MISC
mono_loop 0 0
volume -1800 //was -2500
wfounts1 wfounts1

//WATER FOUNTAIN LG
schema waterfount_lg
archetype AMB_MISC
mono_loop 0 0
volume -1400 //was -2000
wfount1 wfount1 wfount3

//WATERFALL SM
schema waterfall_sm
archetype AMB_MISC
mono_loop 0 0
volume -900 //was -1200
wfallsm1 wfallsm2

//WATERFALL MED
schema waterfall_med
archetype AMB_MISC
mono_loop 0 0
volume -700 //was -900
wfallme1 wfallme2 wfallme3

//WATERFALL LG
schema waterfall_lg
archetype AMB_MISC
mono_loop 0 0
volume -400 //was -500
wfalllg1 wfalllg2


///////////////
//PROJECTILES//
///////////////

//BUG CLOUDS	<--on "BugCloud" obj
schema bugcloud_lp
archetype AMB_MISC
mono_loop 0 0
volume -1500
bugclou1 bugclou2 bugclou3

//BUG HALO AROUND ZOMBIES	<--on "BugHalo" obj
schema bughalo_lp
archetype AMB_MISC
mono_loop 0 0
volume -1550
bughalo