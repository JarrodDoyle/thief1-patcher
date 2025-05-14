//WEAPONS & INTERFACE



schema underwater
archetype AMB_M03
mono_loop 0 0
volume -1
underwat


/////////////
//INVENTORY//
/////////////

//PICKUP STUFF
schema pickup
volume -1500
pickup

//PICKUP LOOT
schema pickup_loot
volume -800
pickloot

//PICKUP KEY
schema pickup_key
volume -1500
pickkey

//PICKUP POWERUP
schema pickup_power
volume -1500
pickpwr

//FROB HOLYWATER FONT
schema pickup_holy
volume -750
frobholy
env_tag (Event Activate) (DeviceType HolyH20)

//NEW OBJECTIVE
schema new_obj
volume -1800
newobj2


//ARROW TO & FROM INVENTORY
schema bow_begin
archetype WEAPONS
volume -1500
bowbegin

schema bow_end
archetype WEAPONS
volume -1500
bowend

//SWORD TO & FROM INVENTORY
schema sword_begin
archetype WEAPONS
volume -1500
unsheath

schema sword_end
archetype WEAPONS
volume -1500
sheath

//BLACKJACK TO & FROM INVENTORY
schema bjack_begin
archetype WEAPONS
volume -2000
bj_begin

schema bjack_end
archetype WEAPONS
volume -2000
bj_end

//DROP COIN IN METAL PLATE -MISSION 7
schema coindrop
volume -1500
coindrop

/////////////////
//WEAPONS USAGE//
/////////////////

//BOW

schema bowpull
archetype WEAPONS
volume -1800
bowpull

schema bow_abort
archetype WEAPONS
volume -1200
bowabort

schema bow_abort_auto
archetype WEAPONS
volume -800
bowabor2

schema bowtwang_player 
archetype WEAPONS
volume -1200  //vol was -1000
bowtwngp

schema bowtwang_ai 
archetype WEAPONS
volume -1
bowtwnga
env_tag (Event Launch) (LaunchVel 1 1) (CreatureType Guard) (ArrowType Broadhead)

//EMITTER TRAP LAUNCH
schema emit_trap
archetype WEAPONS
volume -1
emitter1 emitter2
env_tag (Event Launch) (LaunchVel 1 1) (WeaponType Emitter) (ArrowType Broadhead)

//LAUNCH MAGIC MISSILE
schema fire_magic
archetype WEAPONS
volume -1
fmagic1 fmagic2 fmagic3
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType MagicMissile)

//LAUNCH FIREBOLT
schema fire_firebolt
archetype WEAPONS
volume -1
ffbolt3
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType FireBolt)

//LAUNCH WEB
schema fire_web
archetype WEAPONS
volume -1
webshot1 webshot2
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType Web) (CreatureType Spider)

//GHOST SHOT LAUNCH
schema fire_gs
archetype WEAPONS
f_gs1
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType GhostShot)

//HAMMER SPEEL LAUNCH
schema fire_hs
archetype WEAPONS
f_hm1
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType HammerSpell)


//MAGE FIRE BOLT
schema fire_mgfire
archetype WEAPONS
mgfire
env_tag (Event Launch) (LaunchVel 1 1) (MageShotType MageFire)

//MAGE WATER SHOT
schema fire_mgwater
archetype WEAPONS
mgwater
env_tag (Event Launch) (LaunchVel 1 1) (MageShotType MageWater) 

//MAGE EARTH SHOT
schema fire_mgearth
archetype WEAPONS
mgearth
env_tag (Event Launch) (LaunchVel 1 1) (MageShotType MageEarth)

//MAGE AIR SHOT
schema fire_mgair
archetype WEAPONS
mgair
env_tag (Event Launch) (LaunchVel 1 1) (MageShotType MageAir)






//PLAYER ARROW WHOOSHES [OUTGOING]
schema arrow_out_norm
archetype WEAPONS
//delay 80
volume -1500  //vol was -1000
ao_norm1 ao_norm2
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType Broadhead Rope) (CreatureType Player)

schema arrow_out_water
archetype WEAPONS
//delay 80
volume -1500
ao_wat1 ao_wat2
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType HolyWater Water) (CreatureType Player)

schema arrow_out_fire
archetype WEAPONS
//delay 80
volume -500
ao_fire1 ao_fire2 missfire
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType Fire) (CreatureType Player)

schema arrow_out_gas
archetype WEAPONS
//delay 80
volume -2000
ao_gas
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType Gas) (CreatureType Player)

schema arrow_out_noise
archetype WEAPONS
//delay 80
volume -1000
ao_noiz
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType Noisemaker) (CreatureType Player)

//ENEMY ARROWS WHOOSHES [INCOMING]
schema arrow_inc_norm
archetype WEAPONS
volume -1000
ai_norm1 ai_norm2 ai_norm3

//SWING LEFT
schema sw_left
archetype WEAPONS
delay 350
sword2
env_tag (Event Motion) (CreatureType Player) (PlyrSword 2 2) (PlyrSwordSwing 1 1) (Direction 1 1)

//SWING RIGHT
schema sw_right
archetype WEAPONS
delay 350
sword4
env_tag (Event Motion) (CreatureType Player) (PlyrSword 2 2) (PlyrSwordSwing 1 1) (Direction 2 2)

//SWING OVER
schema sw_over
archetype WEAPONS
delay 200
sword1 sword3
env_tag (Event Motion) (CreatureType Player) (PlyrSword 2 2) (PlyrSwordSwing 2 2) 

//BLACKJACK WHOOSHES
schema sw_bjack
archetype WEAPONS
delay 350
volume -500
bj_swng1 bj_swng2
env_tag (Event Motion) (CreatureType Player) (PlyrSword 2 2) (PlyrSwordSwing 0 0)




//GRENADES

//Flashbomb exploding
schema flashbomb_exp
archetype COLLISIONS
volume -1
flashbmb
env_tag (Event Death) (WeaponType FlashBomb)

//Mine arming
schema mine_arming
archetype WEAPONS
volume -500
minearmg
env_tag (Event Activate) (WeaponType Mine GasMine)

//Mine proximity triggered
schema mine_prox
archetype WEAPONS
volume -500
mineprox
env_tag (Event Activate) (WeaponType ActiveMine ActiveGasMine)

//Mine exploding
schema mine_explode
archetype COLLISIONS
volume -1
expmine
env_tag (Event Death) (WeaponType ActiveMine)

//GasMine exploding
schema gasmine_explode
archetype COLLISIONS
volume -1
expgas
env_tag (Event Death) (WeaponType ActiveGasMine)


//Bang the Gong
schema gong_ring
archetype DEVICES
gong01
env_tag (Event Activate) (DeviceType Gong)

//FAKE TALISMAN WHOOSH
schema faktalis_whoosh
archetype DEVICES
whip
env_tag (Event Activate) (WeaponType FakeTalisman)


/////////////////////
//LEVERS & SWITCHES//
/////////////////////

//FLOOR LEVER FAST
schema LvFloor1
archetype DEVICES
LvFloor1
env_tag (Event StateChange) (SwitchType LvFloor1)

//FLOOR LEVER SLOW PUSH
schema LvFloor2_push
archetype DEVICES
LvCauld1
env_tag (Event StateChange) (SwitchType LvFloor2) (DirectionState Forward)

//FLOOR LEVER SLOW RESET
schema LvFloor2_reset
archetype DEVICES
LvCauld2
env_tag (Event StateChange) (SwitchType LvFloor2) (DirectionState Reverse)

//WALL LEVER
schema LvWall
archetype DEVICES
volume -1000
LvWall
env_tag (Event StateChange) (SwitchType LvWall) (DirectionState Forward Reverse)

//PANEL LEVER
schema LvPanel
archetype DEVICES
volume -1000
LvPanel
env_tag (Event StateChange) (SwitchType LvPanel) (DirectionState Forward Reverse)


//SLIDE LEVER
schema LvSlide
archetype DEVICES
volume -1000
LvSlide
env_tag (Event StateChange) (SwitchType LvSlide) (DirectionState Forward Reverse)


//TELESCOPE TILE
schema LvScope
archetype DEVICES
volume -300
LvScope
env_tag (Event StateChange) (SwitchType LvScope) (DirectionState Forward Reverse)


//THROW SWITCH ON
schema LvThrow_on
archetype DEVICES
LvThrow1
env_tag (Event StateChange) (SwitchType LvThrow) (DirectionState Reverse)

//THROW SWITCH OFF
schema LvThrow_off
archetype DEVICES
LvThrow2
env_tag (Event StateChange) (SwitchType LvThrow) (DirectionState Forward)

//Lever pull snd that tips cauldron
schema lvr_cauld_pour
archetype DEVICES
lvcauld1
env_tag (Event StateChange) (DeviceType CauldLvr) (DirectionState Forward)

//Lever push snd that resets cauldron
schema lvr_cauld_reset
archetype DEVICES
lvcauld2
env_tag (Event StateChange) (DeviceType CauldLvr) (DirectionState Reverse)

//Lever that opens/closes hammer mold
schema lvr_mold
archetype DEVICES
lvmold1
env_tag (Event StateChange) (DeviceType MoldLvr)

//Cauldron pivoting snd
schema cauldron_pivot
archetype DEVICES
cauldron

//Lava bubbling in cauldron
schema lava_loop1
archetype DEVICES
mono_loop 0 0
volume -1500
lavalp1

//Lava pouring into mold
schema lava_pour
archetype DEVICES
mono_loop 0 0
lavapour

//Steam blasts when mold opens with newly forged hammer inside.
schema steam_blast
archetype DEVICES
volume -1000
steambla

//Steampuff spout
schema steam_puff
archetype DEVICES
audio_class ambient
volume -1000
puff1 puff2
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType Steampuff)

//Factory error buzzer
schema buzzer_error
archetype DEVICES
buzzer

//Prison alarm
schema alarm
archetype DEVICES
mono_loop 0 0
alarm
env_tag (Event ActiveLoop) (DeviceType Alarm)

//Prison alarm ramp up
schema alarm_begin
archetype DEVICES
alarmbeg
env_tag (Event Activate) (DeviceType Alarm)

//Prison alarm ramp down
schema alarm_end
archetype DEVICES
alarmend
env_tag (Event Deactivate) (DeviceType Alarm)

//Rameriz's house alarm
schema rmz_alarm
archetype DEVICES
mono_loop 0 0
alarm
env_tag (Event Activate) (DeviceType RmzAlarm)

//Button Push
schema Button_push
archetype DEVICES
b_push
env_tag (Event Activate) (SwitchType BPush)

//Button Pull
schema Button_Pull
archetype DEVICES
b_pull
env_tag (Event Activate) (SwitchType BPull)

//Button Elevator
schema Button_elev
archetype DEVICES
b_elev
env_tag (Event Activate) (SwitchType BElev)

//Button Ramirez
schema Button_rmz
archetype DEVICES
B_rmz
env_tag (Event Activate) (SwitchType BRmz)

//Button Book
schema Button_book
archetype DEVICES
volume -2000
B_book
env_tag (Event Activate) (SwitchType BBook)

//Pressure Plate
schema pplate1
archetype DEVICES
volume -1
pplate
env_tag (Event Activate) (SwitchType PPlate)

/////////
//LIFTS//
/////////

//ELEVATOR1 
schema elev1_loop
archetype DEVICES
mono_loop 0 0
volume -500
elev1lp
env_tag (Event ActiveLoop) (DeviceType ElevPlat)

schema elev1_stop
archetype DEVICES
elev1st
env_tag (Event Deactivate) (DeviceType ElevPlat)

//ELEVATOR2
schema elev2_loop
archetype DEVICES
mono_loop 0 0
volume -500
elev2lp
env_tag (Event ActiveLoop) (DeviceType ElevHmr)

schema elev2_stop
archetype DEVICES
elev2st
env_tag (Event Deactivate) (DeviceType ElevHmr)

////////////
//MACHINES//
////////////

//TURBINE LOOP
schema turbine_lp
archetype DEVICES
mono_loop 0 0
volume -1000
turb2lp
env_tag (Event Activate) (MachType Turbine)

//TURBINE STOP
schema turbine_st
archetype DEVICES
volume -1000
turb2st
env_tag (Event Deactivate) (MachType Turbine)

//SWING ARM PUMP LOOP
schema swarmpump_lp
archetype DEVICES
mono_loop 0 0
volume -1000
saplp
env_tag (Event Activate) (MachType SwingArmPump)

//SWING ARM PUMP STOP
schema swarmpump_st
archetype DEVICES
volume -1000
sapst
env_tag (Event Deactivate) (MachType SwingArmPump)

//Dinner Bell
schema dinner_bell
archetype DEVICES
volume -1000
belldinn
env_tag (Event Activate) (DeviceType DinnerBell)

//GAMBLING WHEEL SPIN
schema wheel_spin
archetype DEVICES
volume -800
wheelspn
env_tag (Event Activate) (MachType GWheel)

//GAMBLING WHEEL STOP
schema wheel_stop
archetype DEVICES
volume -800
wheelstp
env_tag (Event Deactivate) (MachType GWheel)

//PLUCK HARP
schema pluck_harp
archetype DEVICES
volume -1000
harp1 harp2 harp3
env_tag (Event Activate) (MachType Harp)

//MAGE STATUES
schema statue_mgearth
archetype DEVICES
volume -1000
statueme
env_tag (Event Activate) (WardType StatueMgE)

schema statue_mgair
archetype DEVICES
volume -1000
statuema
env_tag (Event Activate) (WardType StatueMgA)

schema statue_mgwater
archetype DEVICES
volume -1000
statuemw
env_tag (Event Activate) (WardType StatueMgW)

schema statue_mgfire
archetype DEVICES
volume -1000
statuemf
env_tag (Event Activate) (WardType StatueMgF)





//POTIONS////////////////////////////////

// drink healing potion
schema potion_heal
archetype DEVICES
tstheal
env_tag (Event Activate) (DeviceType HealPot)

schema potion_air
archetype DEVICES
tstairp
env_tag (Event Activate) (DeviceType AirPot)

//eating crunchy food
schema eat_crunchy
archetype DEVICES
eatcrnch
env_tag (Event Activate) (DeviceType CrunchyFood)

//eating soft food
schema eat_soft
archetype DEVICES
eatsoft
env_tag (Event Activate) (DeviceType SoftFood)

//Talisman alarm
schema alarm_talisman
archetype DEVICES
mono_loop 0 0
volume -1000
alarm3


//AMBIENT LOOPS ON OBJECTS

//TORCHES
schema torch_flame
archetype DEVICES
mono_loop 0 0
volume -1700
firelp1 firelp8 firelp9

//Fireplace snd
schema fire_flame
archetype DEVICES
mono_loop 0 0
volume -1000
firelp1 firelp8 firelp9

//BUG CLOUDS
schema bugcloud_lp
archetype DEVICES
mono_loop 0 0
volume -1500
bugclou1 bugclou2 bugclou3

//BUG HALO AROUND ZOMBIES
schema bughalo_lp
archetype DEVICES
mono_loop 0 0
volume -1550
bughalo

//GLOW BALL
schema glowball_lp
archetype DEVICES
mono_loop 0 0
volume -100
glowball glowbal2