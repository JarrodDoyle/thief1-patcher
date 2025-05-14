
// $Header: r:/prj/cam/art/src/schema/rcs/envsound.spc 1.55 1999/09/25 23:08:33 EBROSIUS Exp $

/////////////////////////////////////////////////////////
// tags generated from code--often these amount to verbs describing
// the action making the sound (any tag can be used anywhere; these
// rough catagories are meant to lend this file a little structure)

// Generic "event" tag specifying which event is being handled
tag Event Launch Collision Footstep Damage StateChange Activate ActiveLoop Deactivate Death Select Reject MediaTrans Climbstep Motion Create
env_tag_required Event


//
// Collision/Footstep tags
//

// Am I "fungusy"  
tag Fungus true false

// Am I landing after a jump
tag Landing true false

//
// Launch event special tags
//

// in feet per second
tag_int LaunchVel

//
// Damage event special tags
//

// what kind of damage did we take 
tag DamageType Bash Concussion Slash Poke Fire Water Knockout Stench Holy Zap

// in % of max hit points
tag_int Damage

// how much health we have left, also as a percentage 
tag_int Health 

//
// StateChange event special tags
//


//DOORS & SUCH

//Door Types
tag DoorType Wood1Sm Wood2Lg Metal Metal2Hvy Sliding Cell Chain BoxWood BoxMoney BoxChest OblManhole Sarcof SkyLight Barricade

//Door states 
tag OpenState Open Closed Opening Closing
tag OldOpenState Open Closed Opening Closing

///////////////////////////////////////////////////////// 
// Tags for various objects for when they "Activate"
// what is the type of device which has activated?

tag DeviceType Gong BellSm HealPot AirPot HolyH20 BlueLight CauldLvr MoldLvr CrunchyFood RmzAlarm DinnerBell Alarm FlickerLight ElevPlat ElevHmr Keys Loot SoftFood

tag SwitchType BPush BPull BElev BRmz BBook LvWall LvThrow LvFloor1 LvFloor2 LvSlide LvPanel PPlate LvScope 

tag MachType SwingArmPump Turbine Gear1 Gear2 GWheel Harp Toilet

tag WardType AirWard FireWard EarthWard WaterWard StatueMgE StatueMgA StatueMgW StatueMgF 

/////////////////////////////////////////////////////////
// For locking/unlocking sound effects: what is the lock's
// state change?

tag LockState Locked Unlocked

/////////////////////////////////////////////////////////
// For state changes in levers: the thing we want to know
// is: from what endpoint are we going into motion?

tag DirectionState Forward Reverse

/////////////////////////////////////////////////////////
// For "Reject" events, what sort of state change just
// failed to occur?

tag Operation KeyFit OpenDoor

/////////////////////////////////////////////////////////
// tags intended for the ClassTags property

// in pounds
tag_int Weight

tag ArrowType Broadhead Earth Fire Gas HolyWater Noisemaker Rope Water Steampuff Burp Firebolt MagicMissile Spear HammerSpell GhostShot Web FrogShot BugShot Assassin

tag MageShotType MageFire MageEarth MageWater MageAir MageExp Sandbag

tag WeaponType Sword Hammer Blackjack Flashbomb Mine ActiveMine GasMine ActiveGasMine Emitter DKaboom FakeTalisman

tag WeaponType2 Sword Hammer Blackjack Flashbomb Mine ActiveMine GasMine ActiveGasMine Emitter DKaboom FakeTalisman


/////////////////
//Material tags//
/////////////////

tag Material Carpet Ceramic Earth Flesh Glass Gravel Ice Liquid Ladder Metal Rope Stone Tile Vegetation Wood ZombiePart

tag Material2 Carpet Ceramic Earth Flesh Glass Gravel Ice Liquid Ladder Metal Rope Stone Tile Vegetation Wood ZombiePart

///////////////////////////
//Tags for Creature types//
///////////////////////////

tag CreatureType Ape Apparition Burrick ConTrick Crayman ElemAir ElemFire Frog Guard Haunt Player Servant Spider Sweel Zombie 

/////////////////////////
//Media Transition Tags//
/////////////////////////

//Direction
tag MedTransDir Enter Exit

//What part of body
tag MediaLevel Foot Body Head

//////////////////////
//Player Motion Tags//
//////////////////////

//SWORD SWINGING MOTION

tag_int PlyrSword

tag_int PlyrSwordSwing

tag_int Direction

