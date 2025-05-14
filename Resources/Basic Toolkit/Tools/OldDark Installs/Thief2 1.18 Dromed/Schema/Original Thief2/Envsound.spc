
// $Header: r:/prj/thief2/art/src/schema/rcs/envsound.spc 1.88 1970/01/01 00:00:00 EBROSIUS Exp $

/////////////////////////////////////////////////////////
// tags generated from code--often these amount to verbs describing
// the action making the sound (any tag can be used anywhere; these
// rough catagories are meant to lend this file a little structure)

//-------------------------------------------------------
//EVENTS -what action just took place
tag Event Acquire Launch Collision Footstep Damage StateChange Activate ActiveLoop Deactivate Death Select Reject MediaTrans Climbstep Motion Create Rotate Shoot WeaponCharge WeaponSwing Search
env_tag_required Event


//-------------------------------------------------------
//FOOTSTEP & COLLISION EVENT TAGS
tag Fungus true false 		//on fungus? like from a Moss Arrow?  
tag Landing true false		//Landing from a jump?

//-------------------------------------------------------
//LAUNCH EVENT TAGS 
tag_int LaunchVel		//Velocity in Feet/Sec

//-------------------------------------------------------
//DAMAGE EVENT TAGS -what kind of damage did I take
tag DamageType Bash Concussion Slash Poke Fire Water Toxic Knockout Stench Holy Zap

tag_int Damage	//% of MaxHitPoints taken
tag_int Health 	//% of Health leftover

//-------------------------------------------------------
//STATECHANGE EVENT TAGS -Doors & Levers

//DOOR TYPES
tag DoorType Wood1Sm Wood2Lg Wood3Vic Wood4Off Shutter Barricade Metal Metal2Hvy Metal3Wh Metal4Mech Cell Bars OblManhole Manhole Slide1 Slide2Sm Slide3Fast Blast Pressure SubHatch GiantPort

tag BoxType BoxWood BoxMoney BoxChest Sarcof GymLocker Safe

//DOOR STATES
tag OpenState Open Closed Opening Closing
tag OldOpenState Open Closed Opening Closing

//LEVER & SWITCH DIRECTIONS
tag DirectionState Forward Reverse

//-------------------------------------------------------
//ACTIVATE EVENT TAGS	


//DEVICES
tag DeviceType GenPotion TimedPotion HolyH20 BlueLight CauldLvr MoldLvr CrunchyFood  SoftFood Piano Whistle LitFlare PowderKeg Lockbox Banner

tag AlarmType Gong BellSm RmzAlarm DinnerBell Alarm MechRedAlarm MechTowerAlarm FlickerLight

tag ElevType Elev1Plat Elev2Hmr Elev3WHdoor TubeLift SkyLight LightHseFloor DumbWaiter MovingTarget

tag SwitchType BPush BPull BElev BRmz BBook LvWall LvThrow LvFloor1 LvFloor2 LvSlide LvPanel PPlate LvScope LvRotate LvMechAnt BNumber BVicLight LvShipWheel

//CHECK & DELETE IF NOT USED
tag MachType SwingArmPump Turbine Gear1 Gear2 GWheel Harp Toilet

//CHECK & DELETE IF NOT USED
tag WardType AirWard FireWard EarthWard WaterWard StatueMgE StatueMgA StatueMgW StatueMgF 



/////////////////////////////////////////////////////////
// For locking/unlocking sound effects: what is the lock's
// state change?

tag LockState Locked Unlocked Good Bad Critical Bland



/////////////////////////////////////////////////////////
// For "Reject" events, what sort of state change just
// failed to occur?

tag Operation KeyFit OpenDoor FrobLock

tag ObjType StdKey RubyEye ShipsWheelPeg Cuckoo

/////////////////////////////////////////////////////////
// tags intended for the ClassTags property

// in pounds
tag_int Weight

tag ArrowType Broadhead Earth Fire Gas HolyWater Noisemaker Rope Vine Water Burp Firebolt MagicMissile HammerSpell GhostShot Web FrogShot BugShot Cannonball Sawblade BlowDart 

tag MiscProjType Steampuff 

//CHECK & DELETE IF NOT USED
//tag MageShotType MageFire MageEarth MageWater MageAir MageExp Sandbag

tag WeaponType Sword Hammer Blackjack Flashbomb Mine ActiveMine GasMine ActiveGasMine Emitter DKaboom FakeTalisman Claw Fist

tag WeaponType2 Sword Hammer Blackjack Flashbomb Mine ActiveMine GasMine ActiveGasMine Emitter DKaboom FakeTalisman Claw Fist

tag CritterGunType CanLauncher SawLauncher BoltLauncher


/////////////////
//Material tags//
/////////////////

tag Material Carpet Ceramic Earth Flesh Glass GlassBits Gravel Ice Liquid Metal MetGrate MetLadder Rope Snow Stone Tile Vegetation Wood WoodBits WoodLadder ZombiePart 

tag Material2 Carpet Ceramic Earth Flesh Glass GlassBits Gravel Ice Liquid Metal MetGrate MetLadder Rope Snow Stone Tile Vegetation Wood WoodBits WoodLadder ZombiePart 



///////////////////////////
//Tags for Creature types//
///////////////////////////

tag CreatureType Ape Apparition Burrick Camera Cherub CombatBot Crayman ElemFire EyeBall Frog Guard GuardNoKO Haunt Player Rat ScurryBot Servant Spider SpiderBot TreeBeast Turret WorkerBot Zombie 


/////////////////////////
//Media Transition Tags//
/////////////////////////

//Direction
tag MedTransDir Enter Exit

//What part of body
tag MediaLevel Foot Body Head

//////////////////////
//Rotate & Loop tags//
//////////////////////

tag LoopState Start Loop Stop


//////////////////////
//Player Motion Tags//
//////////////////////

//SWORD SWINGING MOTION

tag_int PlyrSword

tag_int PlyrSwordSwing

tag_int Direction



