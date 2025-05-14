/////////////
//INVENTORY//
/////////////

//PICKUP LOOT CHIME
schema pickup_loot
archetype UI_META
volume -800
pickloot

//PICKUP KEY JINGLE
schema pickup_key
archetype UI_META
volume -1200
pickkey1 pickkey2 pickkey3  //was pickkey
env_tag (Event Acquire) (ObjType StdKey)

//PICKUP OTHER KEY
schema pickup_gem
archetype UI_META
volume -1500
pickgem1
env_tag (Event Acquire) (ObjType RubyEye ShipsWheelPeg Cuckoo)

//PICKUP POWERUP
schema pickup_power
archetype UI_META
volume -1500
pickpwr

//ACTIVATE HOLYWATER & FROB HOLYWATER FONT
schema pickup_holy
archetype UI_META
volume -750
frobholy
env_tag (Event Activate) (DeviceType HolyH20)

//NEW OBJECTIVE
schema new_obj
archetype UI_META
volume -1800
newobj2

//--------------------------------------------------

//READY BOW
schema bow_begin
archetype UI_META
volume -1500
bowbegin

//PUT AWAY BOW
schema bow_end
archetype UI_META
volume -1500
bowend

//READY SWORD
schema sword_begin
archetype UI_META
volume -1500
unsheath

//PUT AWAY SWORD
schema sword_end
archetype UI_META
volume -1500
sheath

//READY BLACKJACK
schema bjack_begin
archetype UI_META
volume -2500  //was -2000
bj_begin

//PUT AWAY BLACKJACK
schema bjack_end
archetype UI_META
volume -2500 //-2000
bj_end

//--------------------------------------------------

/////////////////
//WEAPONS USAGE//
/////////////////

//PULL BOWSTRING
schema bowpull
archetype PLYR_WEAPON
volume -1200  //was -1800
bowpull

//PULL BOWSTRING AI
schema bowpull_ai
archetype PLYR_WEAPON
no_repeat
delay 600
volume -1 
bow_ai1 bow_ai2 bow_ai3
env_tag (Event WeaponCharge) (CreatureType Guard GuardNoKO)

//RELAX BOWSTRING, DECIDED NOT TO SHOOT
schema bow_abort
archetype PLYR_WEAPON
volume -1200
bowabort

//AUTO RELAX BOWSTRING, HELD TAUNT TOO LONG.
schema bow_abort_auto
archetype PLYR_WEAPON
volume -800
bowabor2

//BOWTWANG
schema bowtwang_player 
archetype PLYR_WEAPON
volume -1200  
bowtwngp

//AI's BOWTWANG
schema bowtwang_ai 
archetype PLYR_WEAPON
volume -1
bowtwnga
env_tag (Event Launch) (LaunchVel 1 1) (CreatureType Guard GuardNoKO) (ArrowType Broadhead)

//EMITTER TRAP LAUNCH
schema emit_arrow
archetype OTHER_WEAPON
volume -1
emitter1 emitter2
env_tag (Event Launch) (LaunchVel 1 1) (WeaponType Emitter) (ArrowType Broadhead)

//LAUNCH MAGIC MISSILE
schema fire_magic
archetype OTHER_WEAPON
volume -1
fmagic1 fmagic2 fmagic3
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType MagicMissile)

//LAUNCH FIREBOLT
schema fire_firebolt
archetype OTHER_WEAPON
volume -1
ffbolt3
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType FireBolt)

//LAUNCH WEB
schema fire_web
archetype OTHER_WEAPON
volume -1
webshot1 webshot2
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType Web) (CreatureType Spider)

//GHOST SHOT LAUNCH
schema fire_gs
archetype OTHER_WEAPON
f_gs1
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType GhostShot)

//HAMMER SPEEL LAUNCH
schema fire_hs
archetype OTHER_WEAPON
f_hm1
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType HammerSpell)

//ROBOT CANNONBALL
schema fire_cannonball
archetype OTHER_WEAPON
f_robcan1 f_robcan2
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType CannonBall)



//MAGE FIRE BOLT
//schema fire_mgfire
//archetype OTHER_WEAPON
//mgfire
//env_tag (Event Launch) (LaunchVel 1 1) (MageShotType MageFire)

//MAGE WATER SHOT
//schema fire_mgwater
//archetype OTHER_WEAPON
//mgwater
//env_tag (Event Launch) (LaunchVel 1 1) (MageShotType MageWater) 

//MAGE EARTH SHOT
//schema fire_mgearth
//archetype OTHER_WEAPON
//mgearth
//env_tag (Event Launch) (LaunchVel 1 1) (MageShotType MageEarth)

//MAGE AIR SHOT
//schema fire_mgair
//archetype OTHER_WEAPON
//mgair
//env_tag (Event Launch) (LaunchVel 1 1) (MageShotType MageAir)



//PLAYER ARROW WHOOSHES [OUTGOING]
schema arrow_out_norm
archetype PLYR_WEAPON
volume -1500  //vol was -1000
ao_norm1 ao_norm2
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType Broadhead Rope Vine) (CreatureType Player)

schema arrow_out_water
archetype PLYR_WEAPON
volume -1500
ao_wat1 ao_wat2
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType HolyWater Water) (CreatureType Player)

schema arrow_out_fire
archetype PLYR_WEAPON
volume -500
ao_fire1 ao_fire2 ao_fire3
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType Fire) (CreatureType Player)

schema arrow_out_gas
archetype PLYR_WEAPON
volume -2000
ao_gas
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType Gas) (CreatureType Player)

schema arrow_out_noise
archetype PLYR_WEAPON
volume -1000
ao_noiz
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType Noisemaker) (CreatureType Player)

//ENEMY ARROWS WHOOSHES [INCOMING]
schema arrow_inc_norm
archetype OTHER_WEAPON
delay 200
volume -1500
ai_norm1 ai_norm2 ai_norm3

//SWING LEFT
schema sw_left
archetype PLYR_WEAPON
no_repeat
delay 350
sword1 //swordbh3 swordbh4
env_tag (Event Motion) (CreatureType Player) (PlyrSword 2 2) (PlyrSwordSwing 1 1) (Direction 1 1)

//SWING RIGHT
schema sw_right
archetype PLYR_WEAPON
no_repeat
delay 350
sword2 //swordfh3 swordfh4
env_tag (Event Motion) (CreatureType Player) (PlyrSword 2 2) (PlyrSwordSwing 1 1) (Direction 2 2)

//SWING OVER
schema sw_over
archetype PLYR_WEAPON
delay 200
swordoh1 swordoh2
env_tag (Event Motion) (CreatureType Player) (PlyrSword 2 2) (PlyrSwordSwing 2 2) 

//BLACKJACK WHOOSHES
schema sw_bjack
archetype PLYR_WEAPON
delay 400 //was 350
no_repeat
volume -500
bj_swng1 bj_swng2 bj_swng3
env_tag (Event Motion) (CreatureType Player) (PlyrSword 2 2) (PlyrSwordSwing 0 0)




//GRENADES

//Flashbomb exploding
schema flashbomb_exp
archetype HIT_EXPLOSION
volume -1
flashbmb
env_tag (Event Death) (WeaponType FlashBomb)

//Mine arming
schema mine_arming
archetype PLYR_WEAPON
volume -500
minearmg
env_tag (Event Activate) (WeaponType Mine GasMine)

//Mine proximity triggered
schema mine_prox
archetype PLYR_WEAPON
volume -500
mineprox
env_tag (Event Activate) (WeaponType ActiveMine ActiveGasMine)

//Mine exploding
schema mine_explode
archetype HIT_EXPLOSION
volume -1
expmine
env_tag (Event Death) (WeaponType ActiveMine)
env_tag (Event Death) (DeviceType PowderKeg)
env_tag (Event Death) (ArrowType Cannonball)

//GasMine exploding
schema gasmine_explode
archetype HIT_EXPLOSION
volume -1
expgas
env_tag (Event Death) (WeaponType ActiveGasMine)




//FAKE TALISMAN WHOOSH
//schema faktalis_whoosh
//archetype DEVICE_MISC
//whip
//env_tag (Event Activate) (WeaponType FakeTalisman)


/////////////////////
//LEVERS & SWITCHES//
/////////////////////

//FLOOR LEVER FAST
schema LvFloor1
archetype DEVICE_SWITCH
LvFloor1
env_tag (Event StateChange) (SwitchType LvFloor1)

//FLOOR LEVER SLOW PUSH
schema LvFloor2_push
archetype DEVICE_SWITCH
LvCauld1
env_tag (Event StateChange) (SwitchType LvFloor2) (DirectionState Forward)

//FLOOR LEVER SLOW RESET
schema LvFloor2_reset
archetype DEVICE_SWITCH
LvCauld2
env_tag (Event StateChange) (SwitchType LvFloor2) (DirectionState Reverse)

//MECH ANTENNAE LEVER to A
schema LvMechAnt_A
archetype DEVICE_SWITCH
LvMechA
env_tag (Event StateChange) (SwitchType LvMechAnt) (DirectionState Reverse)

//MECH ANTENNAE LEVER to B
schema LvMechAnt_B
archetype DEVICE_SWITCH
LvMechB
env_tag (Event StateChange) (SwitchType LvMechAnt) (DirectionState Forward)

//WALL LEVER
schema LvWall
archetype DEVICE_SWITCH
volume -1000
LvWall
env_tag (Event StateChange) (SwitchType LvWall) (DirectionState Forward Reverse)

//PANEL LEVER
schema LvPanel
archetype DEVICE_SWITCH
volume -1000
LvPanel
env_tag (Event StateChange) (SwitchType LvPanel) (DirectionState Forward Reverse)


//SLIDE LEVER
schema LvSlide
archetype DEVICE_SWITCH
volume -1000
LvSlide
env_tag (Event StateChange) (SwitchType LvSlide) (DirectionState Forward Reverse)


//TELESCOPE TILE
schema LvScope
archetype DEVICE_SWITCH
volume -300
LvScope
env_tag (Event StateChange) (SwitchType LvScope) (DirectionState Forward Reverse)


//THROW SWITCH ON
schema LvThrow_on
archetype DEVICE_SWITCH
LvThrow1
env_tag (Event StateChange) (SwitchType LvThrow) (DirectionState Reverse)

//THROW SWITCH OFF
schema LvThrow_off
archetype DEVICE_SWITCH
LvThrow2
env_tag (Event StateChange) (SwitchType LvThrow) (DirectionState Forward)

//Lever pull snd that tips cauldron
schema lvr_cauld_pour
archetype DEVICE_SWITCH
lvcauld1
env_tag (Event StateChange) (DeviceType CauldLvr) (DirectionState Forward)

//Lever push snd that resets cauldron
schema lvr_cauld_reset
archetype DEVICE_SWITCH
lvcauld2
env_tag (Event StateChange) (DeviceType CauldLvr) (DirectionState Reverse)

//Lever that opens/closes hammer mold
schema lvr_mold
archetype DEVICE_SWITCH
lvmold1
env_tag (Event StateChange) (DeviceType MoldLvr)

//ROTATING VALVE
schema LvRotate_fwd
archetype DEVICE_SWITCH
volume -400
LvRotat1
env_tag (Event StateChange) (SwitchType LvRotate) (DirectionState Forward)

//FLOOR LEVER SLOW RESET
schema LvRotate_rvs
archetype DEVICE_SWITCH
volume -400
LvRotat2
env_tag (Event StateChange) (SwitchType LvRotate) (DirectionState Reverse)

//Cauldron pivoting snd
schema cauldron_pivot
archetype DEVICE_SWITCH
cauldron



//Lava pouring into mold
schema lava_pour
archetype DEVICE_SWITCH
mono_loop 0 0
lavapour

//Steam blasts when mold opens with newly forged hammer inside.
schema steam_blast
archetype DEVICE_SWITCH
volume -1000
steambla

//Steampuff spout
schema steam_puff
archetype DEVICE_MISC
audio_class ambient
volume -1000
puff1 puff2
env_tag (Event Launch) (LaunchVel 1 1) (MiscProjType Steampuff)

//Factory error buzzer
schema buzzer_error
archetype DEVICE_MISC
buzzer

//////////
//ALARMS//
//////////

//Mech Red Alarm ramp up
schema alarm_begin
archetype DEVICE_ALARM
alarm1be
env_tag (Event Activate) (AlarmType Alarm MechRedAlarm MechTowerAlarm)

//Mech Red Alarm loop
schema alarm
archetype DEVICE_ALARM
mono_loop 0 0
alarm1lp
env_tag (Event ActiveLoop) (AlarmType Alarm MechRedAlarm)

//Mech Red Alarm ramp down
schema alarm_end
archetype DEVICE_ALARM
alarm1en
env_tag (Event Deactivate) (AlarmType Alarm MechRedAlarm MechTowerAlarm)

//Mech Tower Alarm loop
schema TowerAlarm_lp
archetype DEVICE_ALARM
mono_loop 0 0
alarm2lp
env_tag (Event ActiveLoop) (AlarmType MechTowerAlarm)

//Rameriz's house alarm
schema rmz_alarm
archetype DEVICE_ALARM
mono_loop 0 0
alarm3lp
env_tag (Event Activate) (AlarmType RmzAlarm)

//Talisman alarm
schema alarm_talisman
archetype DEVICE_ALARM
mono_loop 0 0
volume -1000
alarm3

//Bang the Gong
schema gong_ring
archetype DEVICE_ALARM
gong01
env_tag (Event Activate) (AlarmType Gong)

//Button Push
schema Button_push
archetype DEVICE_SWITCH
b_push
env_tag (Event Activate) (SwitchType BPush)

//Button Pull
schema Button_Pull
archetype DEVICE_SWITCH
b_pull
env_tag (Event Activate) (SwitchType BPull)

//Button Elevator
schema Button_elev
archetype DEVICE_SWITCH
b_elev
env_tag (Event Activate) (SwitchType BElev)

//Button Ramirez
schema Button_rmz
archetype DEVICE_SWITCH
B_rmz
env_tag (Event Activate) (SwitchType BRmz)

//Button Book
schema Button_book
archetype DEVICE_SWITCH
volume -2000
B_book
env_tag (Event Activate) (SwitchType BBook)
env_tag (Event StateChange) (DirectionState Forward Reverse) (SwitchType BBook)

//Pressure Plate
schema pplate1
archetype DEVICE_SWITCH
volume -1
pplate
env_tag (Event Activate) (SwitchType PPlate)

//Number Button
schema Button_Number
archetype DEVICE_SWITCH
volume -1000
digiclk
env_tag (Event Activate) (SwitchType BNumber)

//Number Button
schema LvShipWheel
archetype DEVICE_SWITCH
volume -1
d_woods7
env_tag (Event StateChange) (DirectionState Forward Reverse) (SwitchType LvShipWheel)

//VicLight On
schema LvVicLight_On
archetype DEVICE_SWITCH
volume -1000
delay 500
b_rmz
env_tag (Event StateChange) (DirectionState Reverse) (SwitchType BVicLight)

//VicLight Off
schema LvVicLight_off
archetype DEVICE_SWITCH
volume -1000
delay 500
b_push
env_tag (Event StateChange) (DirectionState Forward) (SwitchType BVicLight)



////////////
//MACHINES//
////////////

//TURBINE LOOP
schema turbine_lp
archetype DEVICE_MISC
mono_loop 0 0
volume -1000
turb2lp
env_tag (Event Activate) (MachType Turbine)

//TURBINE STOP
schema turbine_st
archetype DEVICE_MISC
volume -1000
turb2st
env_tag (Event Deactivate) (MachType Turbine)

//SWING ARM PUMP LOOP
schema swarmpump_lp
archetype DEVICE_MISC
mono_loop 0 0
volume -1000
saplp
env_tag (Event Activate) (MachType SwingArmPump)

//SWING ARM PUMP STOP
schema swarmpump_st
archetype DEVICE_MISC
volume -1000
sapst
env_tag (Event Deactivate) (MachType SwingArmPump)

//Dinner Bell
schema dinner_bell
archetype DEVICE_ALARM
volume -1000
belldinn
env_tag (Event Activate) (AlarmType DinnerBell)

//GAMBLING WHEEL SPIN
schema wheel_spin
archetype DEVICE_MISC
volume -800
wheelspn
env_tag (Event Activate) (MachType GWheel)

//GAMBLING WHEEL STOP
schema wheel_stop
archetype DEVICE_MISC
volume -800
wheelstp
env_tag (Event Deactivate) (MachType GWheel)

//PLUCK HARP
schema pluck_harp
archetype DEVICE_MISC
volume -800
harp1 harp2 harp3
env_tag (Event Activate) (MachType Harp)

//MAGE STATUES
//schema statue_mgearth
//archetype DEVICE_MISC
//volume -100
//statueme
//env_tag (Event Activate) (WardType StatueMgE)

//schema statue_mgair
//archetype DEVICE_MISC
//volume -100
//statuema
//env_tag (Event Activate) (WardType StatueMgA)

//schema statue_mgwater
//archetype DEVICE_MISC
//volume -100
//statuemw
//env_tag (Event Activate) (WardType StatueMgW)

//schema statue_mgfire
//archetype DEVICE_MISC
//volume -100
//statuemf
//env_tag (Event Activate) (WardType StatueMgF)





//POTIONS////////////////////////////////

// drink healing potion
schema potion_gen
archetype DEVICE_MISC
potion1
env_tag (Event Activate) (DeviceType GenPotion TimedPotion)

schema potion_deact
archetype DEVICE_MISC
potion2
env_tag (Event DeActivate) (DeviceType TimedPotion)



//eating crunchy food
schema eat_crunchy
archetype DEVICE_MISC
eatcrnch
env_tag (Event Activate) (DeviceType CrunchyFood)

//eating soft food
schema eat_soft
archetype DEVICE_MISC
eatsoft
env_tag (Event Activate) (DeviceType SoftFood)






//FROM VARIOUS CREATURE .SCHs

//LAUNCH BUGSHOT
//schema fly_launch
//archetype OTHER_WEAPON
//volume -1
//bb1attsh
//env_tag (Event Launch) (LaunchVel 1 1) (ArrowType BugShot)

//BUGSHOT IMPACT
//schema fly_death
//archetype HIT_EXPLOSION
//volume -1
//flydeth1 flydeth2 flydeth3
//env_tag (Event Death) (ArrowType BugShot)

//BURPING ATTACK
schema bur_burp
archetype OTHER_WEAPON
volume -500
burp5 burp2
env_tag (Event Launch) (LaunchVel 1 1) (CreatureType Burrick) (ArrowType Burp)

//BLOW DART FIRING
schema fire_dart
archetype OTHER_WEAPON
volume -500
darblow1 darblow2 darblow3
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType BlowDart)

//BLOW DART WHIZ  <--on "BlowDart" obj
schema dart_whiz
archetype OTHER_WEAPON
delay 500
volume -500
darwhiz1 darwhiz2 darwhiz3 darwhiz4 darwhiz5

//FROG EXPLOSION
schema exp_frog
archetype HIT_EXPLOSION
volume -1
expfrog2 expfrog
env_tag (Event Death) (CreatureType Frog)

//ZOMBIE PART SPLATS
schema zombie_splat
archetype HIT_MATERIAL
volume -1
stabbody splat1 splat2 splat3
env_tag (Event Collision) (Material2 ZombiePart)  

//ZOMBIE EXPLODES
schema exp_zombie
archetype HIT_EXPLOSION
volume -1
expzom1 expzom2
env_tag (Event Death) (CreatureType Zombie) (DamageType Fire Holy)

//blue lights on
schema blue_light_on
archetype DEVICE_MISC
volume -1200
blueon1 blueon2
env_tag (Event Activate) (DeviceType BlueLight)

//blue lights off
schema blue_light_off
archetype DEVICE_MISC
volume -1700
blueoff1 blueoff2
env_tag (Event Deactivate) (DeviceType BlueLight)


//FROB PIANO in miss1
schema play_piano
archetype DEVICE_MISC
volume -800
piano1 piano2 piano3 piano4 piano5 piano6 piano7
env_tag (Event Activate) (DeviceType Piano)

//USE BIRDCALL [signalwhistle] in miss1
schema use_birdcall
archetype DEVICE_MISC
volume -2000  //was -2500
brdcall1 brdcall2 brdcall3
env_tag (Event Activate) (DeviceType Whistle)


//WAX CYLINDER TUNE IN M02
schema musicalwax
archetype DEVICE_MISC
stream
volume -500
waxytune




//BANNER CUT
schema banner_death
archetype DEVICE_MISC
volume -1500
banndie1 banndie2 banndie3
env_tag (Event Death) (DeviceType Banner)
