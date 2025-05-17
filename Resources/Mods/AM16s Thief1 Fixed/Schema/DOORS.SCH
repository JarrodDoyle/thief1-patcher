//DOORS & LOCKS

////////////////////////////
//DOORS USED BY THE PLAYER//
////////////////////////////

//PLAYER OPENING WOODEN DOOR 1
schema doorwood1_op_p
archetype PLAYER_DOOR
volume -1500 //was -2000
doorw1o
env_tag (Event StateChange) (DoorType Wood1sm) (OpenState Opening) (OldOpenState Closed) (CreatureType Player)

//PLAYER CLOSING WOODEN DOORS 1 & 2 
schema doorwood_sq_p
archetype PLAYER_DOOR
volume -2500
doorws1 doorws2 doorws3
env_tag (Event StateChange) (DoorType Wood1sm Wood2lg)  (OpenState Closing) (OldOpenState Open Opening Closing) (CreatureType Player)

//PLAYER CLOSED WOODEN DOOR 1
schema doorwood1_cl_p
archetype PLAYER_DOOR
volume -2000  //was -2500
doorw1c
env_tag (Event StateChange) (DoorType Wood1sm)  (OpenState Closed) (OldOpenState Open Opening Closing) (CreatureType Player)


//PLAYER OPENING WOODEN DOOR 2
schema doorwood2_op_p
archetype PLAYER_DOOR
volume -1500 //was -2000
doorw2o
env_tag (Event StateChange) (DoorType Wood2lg)  (OpenState Opening) (OldOpenState Closed) (CreatureType Player)

//PLAYER CLOSED WOODEN DOOR 2
schema doorwood2_cl_p
archetype PLAYER_DOOR
volume -1800   //was -2500
doorw2c
env_tag (Event StateChange) (DoorType Wood2lg)  (OpenState Closed) (OldOpenState Open Opening Closing) (CreatureType Player)


//PLAYER OPENING METAL DOOR 1
schema doormet1_op_p
archetype PLAYER_DOOR
volume -1500
doorm1o
env_tag (Event StateChange) (DoorType Metal) (OpenState Opening) (OldOpenState Closed) (CreatureType Player)

//PLAYER CLOSING METAL DOOR 1
schema doormet_sq_p
archetype PLAYER_DOOR
volume -2000
doorws1 doorws2 doorws3
env_tag (Event StateChange) (DoorType Metal) (OpenState Opening Closing) (OldOpenState Open Opening Closing) (CreatureType Player)

//PLAYER CLOSED METAL DOOR 1
schema doormet1_cl_p
archetype PLAYER_DOOR
volume -1500
doorm1c
env_tag (Event StateChange) (DoorType Metal) (OpenState Closed) (OldOpenState Opening Closing) (CreatureType Player)


//PLAYER OPENING METAL DOOR 2 -HVY
schema doormet2_op_p
archetype PLAYER_DOOR
volume -500
doorm2o
env_tag (Event StateChange) (DoorType Metal2Hvy) (OpenState Opening Closing) (OldOpenState Open Opening Closed Closing) (CreatureType Player)

//PLAYER CLOSED METAL DOOR 2
schema doormet2_cl_p
archetype PLAYER_DOOR
volume -500
doorm2c
env_tag (Event StateChange) (DoorType Metal2Hvy) (OpenState Open Closed) (OldOpenState Opening Closing) (CreatureType Player)


//PLAYER OPENING/CLOSING SLIDING DOOR 1
schema doorsld1_op_p
archetype PLAYER_DOOR
volume -1
doors1o
env_tag (Event StateChange)  (DoorType Sliding) (OpenState Opening Closing) (OldOpenState Open Closed Opening Closing) (CreatureType Player)

//PLAYER OPEN/CLOSED SLIDING DOOR 1
schema doorsld1_cl_p
archetype PLAYER_DOOR
volume -1
doors1c
env_tag (Event StateChange) (DoorType Sliding)  (OpenState Open Closed) (OldOpenState Open Closed Opening Closing) (CreatureType Player)


//OBLONG MANHOLE OPENING
schema oblmanhole_op
archetype PLAYER_DOOR
volume -1000
oblmh_op
env_tag (Event StateChange) (DoorType OblManhole) (OpenState Opening) (OldOpenState Closing Closed) (CreatureType Player)

//OBLONG MANHOLE CLOSING
schema oblmanhole_sq
archetype PLAYER_DOOR
volume -1500
oblmh_sq
env_tag (Event StateChange) (DoorType OblManhole) (OpenState Closing) (OldOpenState Open Opening) (CreatureType Player)

//OBLONG MANHOLE CLOSED
schema oblmanhole_cl
archetype PLAYER_DOOR
volume -1000
doorm1c
env_tag (Event StateChange) (DoorType OblManhole) (OpenState Closed) (OldOpenState Opening Closing) (CreatureType Player)


//PLAYER OPENING CHAIN/BAR DOORS
schema doorbars_op_p
archetype PLAYER_DOOR
mono_loop 0 0
volume -300
doorb1o
env_tag (Event StateChange)  (DoorType Chain) (OpenState Opening Closing) (OldOpenState Open Closed Opening Closing) (CreatureType Player)

//CLOSED CHAIN/BAR DOORS
schema doorbars_cl_p
archetype PLAYER_DOOR
volume -1
doorb1c
env_tag (Event StateChange)  (DoorType Chain) (OpenState Open Closed) (OldOpenState Opening Closing) (CreatureType Player)


/////////////////////
//DOORS USED BY AIS//
/////////////////////

//AI OPENING WOODEN DOOR 1
schema doorwood1_op_ai
archetype AI_DOOR
volume -300
doorw1o
env_tag (Event StateChange) (DoorType Wood1sm) (OpenState Opening) (OldOpenState Closed)

//AI CLOSING WOODEN DOORS 1 & 2
schema doorwood_sq_ai
archetype AI_DOOR
volume -1000
doorws1 doorws2 doorws3
env_tag (Event StateChange) (DoorType Wood1sm Wood2lg)  (OpenState Closing) (OldOpenState Open Opening Closing) 

//AI CLOSED WOODEN DOOR 1
schema doorwood1_cl_ai
archetype AI_DOOR
volume -300
doorw1c
env_tag (Event StateChange) (DoorType Wood1sm)  (OpenState Closed) (OldOpenState Open Opening Closing)


//AI OPENING WOODEN DOOR 2
schema doorwood2_op_ai
archetype AI_DOOR
volume -300
doorw2o
env_tag (Event StateChange) (DoorType Wood2lg)  (OpenState Opening) (OldOpenState Closed)

//AI CLOSED WOODEN DOOR 2
schema doorwood2_cl_ai
archetype AI_DOOR
volume -300
doorw2c
env_tag (Event StateChange) (DoorType Wood2lg)  (OpenState Closed) (OldOpenState Open Opening Closing)


//AI OPENING METAL DOOR 1
schema doormet1_op_ai
archetype AI_DOOR
volume -300
doorm1o
env_tag (Event StateChange) (DoorType Metal) (OpenState Opening) (OldOpenState Closed) 

//AI CLOSING METAL DOOR 1
schema doormet_sq_ai
archetype AI_DOOR
volume -1000
doorws1 doorws2 doorws3
env_tag (Event StateChange) (DoorType Metal) (OpenState Opening Closing) (OldOpenState Open Opening Closing) 

//AI CLOSED METAL DOOR 1
schema doormet1_cl_ai
archetype AI_DOOR
volume -300
doorm1c
env_tag (Event StateChange) (DoorType Metal) (OpenState Closed) (OldOpenState Opening Closing) 


//AI OPENING METAL DOOR 2 -HVY
schema doormet2_op_ai
archetype AI_DOOR
volume -1
doorm2o
env_tag (Event StateChange) (DoorType Metal2Hvy) (OpenState Opening Closing) (OldOpenState Open Opening Closed Closing)

//AI CLOSED METAL DOOR 2 HVY
schema doormet2_cl_ai
archetype AI_DOOR
volume -1
doorm2c
env_tag (Event StateChange) (DoorType Metal2Hvy) (OpenState Open Closed) (OldOpenState Opening Closing) 

//AI OPENING SLIDING DOOR 1
schema doorsld1_op_ai
archetype AI_DOOR
volume -1
doors1o
env_tag (Event StateChange)  (DoorType Sliding) (OpenState Opening Closing) (OldOpenState Open Closed Opening Closing)

//AI CLOSED SLIDING DOOR 1
schema doorsld1_cl
archetype AI_DOOR
volume -1
doors1c
env_tag (Event StateChange) (DoorType Sliding)  (OpenState Open Closed) (OldOpenState Open Closed Opening Closing)

//AI OPENING CHAIN/BAR DOORS
schema doorbars_op
archetype AI_DOOR
mono_loop 0 0
volume -300
doorb1o
env_tag (Event StateChange)  (DoorType Chain) (OpenState Opening Closing) (OldOpenState Open Closed Opening Closing)

//AI CLOSED CHAIN/BAR DOORS
schema doorbars_cl
archetype AI_DOOR
volume -1
doorb1c
env_tag (Event StateChange)  (DoorType Chain) (OpenState Open Closed) (OldOpenState Opening Closing)



/////////////////////////
//DOORS USED BY ANYBODY//
/////////////////////////

//OPENING JAIL CELL DOOR
schema doorcell_op
archetype DOORS
volume -1
doorc1o
env_tag (Event StateChange) (DoorType Cell)  (OpenState Opening) (OldOpenState Closed Opening Closing)

//CLOSED JAIL CELL DOOR
schema doorcell_cl
archetype DOORS
volume -1
doorc1c
env_tag (Event StateChange) (DoorType Cell)  (OpenState Closing) (OldOpenState Open Opening Closing)



//FOOTLOCKER OPEN
schema boxwood_op
archetype DOORS
volume -800
boxw_op
env_tag (Event StateChange)  (DoorType BoxWood) (OpenState Opening) (OldOpenState Closed)

//FOOTLOCKER SQUEAK
schema boxwood_sq
archetype DOORS
volume -2100
boxw_sq
env_tag (Event StateChange)  (DoorType BoxWood) (OpenState Closing) (OldOpenState Open Opening Closing)

//FOOTLOCKER CLOSED
schema boxwood_cl
archetype DOORS
volume -800
boxw_cl
env_tag (Event StateChange)  (DoorType BoxWood) (OpenState Closed) (OldOpenState Opening Closing)

//MONEY BOX OPEN
schema boxmoney_op
archetype DOORS
volume -800
boxm_op
env_tag (Event StateChange)  (DoorType BoxMoney) (OpenState Opening) (OldOpenState Closed)

//MONEY BOX SQUEAK
schema boxmoney_sq
archetype DOORS
volume -1500
boxm_sq
env_tag (Event StateChange)  (DoorType BoxMoney) (OpenState Closing) (OldOpenState Open Opening Closing)

//MONEY BOX CLOSED
schema boxmoney_cl
archetype DOORS
volume -800
boxm_cl
env_tag (Event StateChange)  (DoorType BoxMoney) (OpenState Closed) (OldOpenState Opening Closing)

//CHEST BOX OPEN
schema boxchest_op
archetype DOORS
volume -800
boxc_op
env_tag (Event StateChange)  (DoorType BoxChest) (OpenState Open) (OldOpenState Opening)

//CHEST BOX SQUEAK
schema boxchest_sq
archetype DOORS
volume -800
boxc_sq
env_tag (Event StateChange)  (DoorType BoxChest) (OpenState Opening) (OldOpenState Opening Closing Closed)

//CHEST BOX CLOSED
schema boxchest_cl
archetype DOORS
volume -800
boxc_cl
env_tag (Event StateChange)  (DoorType BoxChest) (OpenState Closed) (OldOpenState Opening Closing)

//SARCOFAGUS 
schema doorsarcof
archetype DOORS
volume -500
pplate
env_tag (Event StateChange)  (DoorType Sarcof) (OpenState Opening Closing) (OldOpenState Open Opening Closed Closing)



//SKYLIGHT
schema skylight_op
archetype PLAYER_DOOR
volume -400
mono_loop 0 0
elev1lp
env_tag (Event StateChange) (DoorType Skylight) (OpenState Opening Closing) (OldOpenState Open Closed) 

schema skylight_cl
archetype PLAYER_DOOR
volume -1
elev2st
env_tag (Event StateChange) (DoorType Skylight) (OpenState Open Closed) (OldOpenState Opening Closing) 


/////////
//LOCKS//
/////////

//DOOR UNLOCKS
schema unlocked
archetype DEVICES
unlocked
env_tag (Event StateChange) (LockState Unlocked)

//DOOR UNLOCKS
schema unlocked_sky
archetype DEVICES
volume -1
pplate
env_tag (Event StateChange) (LockState Unlocked) (DoorType Skylight)


//DOOR LOCKS OR IS LOCKED
schema locked
archetype DEVICES
locked
env_tag (Event StateChange) (LockState Locked)
env_tag (Event Reject) (Operation OpenDoor)

//YOU GOT THE WRONG KEY
schema wrongkey
archetype DEVICES
wrongkey
env_tag (Event Reject) (Operation KeyFit)

//LOCKPICKING
schema lockpik
archetype DEVICES
mono_loop 0 0
lockpik2

//LOCKPICKING STARTING TO WORK
schema pinset
archetype DEVICES
pinset

//LOCKPICKING REALLY WORKING
schema tumblerset
archetype DEVICES
pinset1 pinset2

//LOCKPICKING NOT WORKING
schema noluck
archetype DEVICES
noluck1 noluck2


