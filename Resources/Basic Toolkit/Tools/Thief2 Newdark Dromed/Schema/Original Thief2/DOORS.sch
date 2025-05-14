//DOORS, BOXES, LOCKS and ELEVATORS

/////////
//DOORS//
/////////

//PLAYER DOORS

//WOOD DOOR 1 -Standard Wood Door

//WOOD DOOR 1 -PLYR OPENING
schema doorwood1_op_p
archetype PLYR_DOOR
volume -1000  
d_wood1o
env_tag (Event StateChange) (DoorType Wood1sm) (OpenState Opening) (OldOpenState Closed) (CreatureType Player)

//WOOD DOOR 1,2 -PLYR SQUEAKS 
schema doorwood_sq_p
archetype PLYR_DOOR
volume -2500
no_repeat
d_woods1 d_woods2 d_woods3
env_tag (Event StateChange) (DoorType Wood1sm Wood2lg)  (OpenState Opening Closing) (OldOpenState Open Opening Closing) (CreatureType Player)

//WOOD DOOR 1 -PLYR CLOSE SLAM
schema doorwood1_cl_p
archetype PLYR_DOOR
volume -1000  
d_wood1c 
env_tag (Event StateChange) (DoorType Wood1sm)  (OpenState Closed) (OldOpenState Open Opening Closing) (CreatureType Player)


//WOOD DOOR 2 -Heavy Wood Door

//WOOD DOOR 2 -PLYR OPENING
schema doorwood2_op_p
archetype PLYR_DOOR
volume -750 
d_wood2o
env_tag (Event StateChange) (DoorType Wood2lg)  (OpenState Opening) (OldOpenState Closed) (CreatureType Player)

//WOOD DOOR 2 -PLYR CLOSE SLAM 
schema doorwood2_cl_p
archetype PLYR_DOOR
volume -750   
d_wood2c
env_tag (Event StateChange) (DoorType Wood2lg)  (OpenState Closed) (OldOpenState Open Opening Closing) (CreatureType Player)


//WOOD DOOR 3 -Victorian Doors

//WOOD DOOR 3 -PLYR OPENING
schema d_wood3_op_p
archetype PLYR_DOOR
volume -1000
d_wood3o
env_tag (Event StateChange) (DoorType Wood3Vic) (OpenState Opening) (OldOpenState Closed) (CreatureType Player)

//WOOD DOOR 3 -PLYR SQUEAKS 
schema d_wood3_sq_p
archetype PLYR_DOOR
volume -2500
no_repeat
d_woods4 d_woods5 d_woods6
env_tag (Event StateChange) (DoorType Wood3Vic)  (OpenState Opening Closing) (OldOpenState Open Opening Closing) (CreatureType Player)

//WOOD DOOR 3 -PLYR CLOSE SLAM
schema d_wood3_cl_p
archetype PLYR_DOOR
volume -1000  
d_wood3c
env_tag (Event StateChange) (DoorType Wood3Vic)  (OpenState Closed) (OldOpenState Open Opening Closing) (CreatureType Player)


//WOOD DOOR 4 -Office Doors

//WOOD DOOR 4 -PLYR OPENING
schema d_wood4_op_p
archetype PLYR_DOOR
volume -1000
d_wood4o
env_tag (Event StateChange) (DoorType Wood4Off) (OpenState Opening) (OldOpenState Closed) (CreatureType Player)

//WOOD DOOR 4 -PLYR SQUEAKS 
schema d_wood4_sq_p
archetype PLYR_DOOR
volume -2200
d_woods7 d_woods8
env_tag (Event StateChange) (DoorType Wood4Off)  (OpenState Closing) (OldOpenState Open Opening Closing) (CreatureType Player)

//WOOD DOOR 4 -PLYR CLOSE SLAM
schema d_wood4_cl_p
archetype PLYR_DOOR
volume -1000 
d_wood4c
env_tag (Event StateChange) (DoorType Wood4Off)  (OpenState Closed) (OldOpenState Open Opening Closing) (CreatureType Player)



//WOOD SHUTTERS & HALF-SIZE DOORS

//WOOD SHUTTER -PLYR OPENING
schema d_shutter_op_p
archetype PLYR_DOOR
volume -1500
d_shut1o
env_tag (Event StateChange) (DoorType Shutter) (OpenState Opening) (OldOpenState Closed) (CreatureType Player)

//WOOD SHUTTER -PLYR SQUEAKS
schema d_shutter_sq_p
archetype PLYR_DOOR
volume -2500
d_shut1s
env_tag (Event StateChange) (DoorType Shutter)  (OpenState Closing) (OldOpenState Open Opening Closing) (CreatureType Player)

//WOOD SHUTTER -PLYR CLOSE SLAM
schema d_shutter_cl_p
archetype PLYR_DOOR
volume -1500 
d_shut1c
env_tag (Event StateChange) (DoorType Shutter)  (OpenState Closed) (OldOpenState Open Opening Closing) (CreatureType Player)



//METAL DOOR 1 -Standard Metal Door

//METAL DOOR 1 -PLYR OPENING
schema doormet1_op_p
archetype PLYR_DOOR
volume -1000
d_met1o
env_tag (Event StateChange) (DoorType Metal) (OpenState Opening) (OldOpenState Closed) (CreatureType Player)

//METAL DOOR 1 -PLYR SQUEAKS  <--Yes, I know it's the wood squeak!
schema doormet_sq_p
archetype PLYR_DOOR
volume -2000
no_repeat
d_woods1 d_woods2 d_woods3  
env_tag (Event StateChange) (DoorType Metal) (OpenState Opening Closing) (OldOpenState Open Opening Closing) (CreatureType Player)

//METAL DOOR 1 -PLYR CLOSE SLAM
schema doormet1_cl_p
archetype PLYR_DOOR
volume -1000
d_met1c
env_tag (Event StateChange) (DoorType Metal) (OpenState Closed) (OldOpenState Opening Closing) (CreatureType Player)


//METAL DOOR 2 -Heavy Metal Door [like sewer hatch]

//METAL DOOR 2 -PLYR OPENING & CLOSING
schema doormet2_op_p
archetype PLYR_DOOR
volume -250
d_met2o
env_tag (Event StateChange) (DoorType Metal2Hvy) (OpenState Opening Closing) (OldOpenState Open Opening Closed Closing) (CreatureType Player)

//METAL DOOR 2 -PLYR OPEN SLAM
schema doormet2_o2_p
archetype PLYR_DOOR
volume -500
d_met2o2
env_tag (Event StateChange) (DoorType Metal2Hvy) (OpenState Open) (OldOpenState Opening) (CreatureType Player)

//METAL DOOR 2 -PLYR CLOSE SLAM
schema doormet2_cl_p
archetype PLYR_DOOR
volume -250
d_met2c
env_tag (Event StateChange) (DoorType Metal2Hvy) (OpenState Closed) (OldOpenState Closing) (CreatureType Player)


//METAL DOOR 3 -Warehouse Doors

//METAL DOOR 3 -PLYR OPENING
schema d_met3_op_p
archetype PLYR_DOOR
volume -1000
d_met3o
env_tag (Event StateChange) (DoorType Metal3Wh) (OpenState Opening) (OldOpenState Closed) (CreatureType Player)

//METAL DOOR 3 -PLYR SQUEAKS  
schema d_met3_sq_p
archetype PLYR_DOOR
volume -1200
d_mets3 d_mets4
env_tag (Event StateChange) (DoorType Metal3Wh) (OpenState Opening Closing) (OldOpenState Open Opening Closing) (CreatureType Player)

//METAL DOOR 3 -PLYR CLOSE SLAM
schema d_met3_cl_p
archetype PLYR_DOOR
volume -1000
d_met3c
env_tag (Event StateChange) (DoorType Metal3Wh) (OpenState Closed) (OldOpenState Opening Closing) (CreatureType Player)


//METAL DOOR 4 -Fancy Mechanist Doors

//METAL DOOR 4 -PLYR OPENING
schema d_met4_op_p
archetype PLYR_DOOR
volume -1000
d_met4o
env_tag (Event StateChange) (DoorType Metal4Mech) (OpenState Opening) (OldOpenState Closed) (CreatureType Player)

//METAL DOOR 4 -PLYR SQUEAKS  
schema d_met4_sq_p
archetype PLYR_DOOR
volume -2000
d_mets1 d_mets2
env_tag (Event StateChange) (DoorType Metal4Mech) (OpenState Opening Closing) (OldOpenState Open Opening Closing) (CreatureType Player)

//METAL DOOR 4 -PLYR CLOSE SLAM
schema d_met4_cl_p
archetype PLYR_DOOR
volume -1000
d_met4c
env_tag (Event StateChange) (DoorType Metal4Mech) (OpenState Closed) (OldOpenState Opening Closing) (CreatureType Player)


//PRESSURE DOOR -PLYR OPENING & CLOSING
schema d_press_op_p
archetype PLYR_DOOR
volume -1200
d_met2o
env_tag (Event StateChange) (DoorType Pressure) (OpenState Opening) (OldOpenState Open Opening Closed Closing) (CreatureType Player)

//PRESSURE DOOR -PLYR OPEN SLAM
schema d_press_sq_p
archetype PLYR_DOOR
volume -1200
d_met2o2
env_tag (Event StateChange) (DoorType Pressure) (OpenState Open) (OldOpenState Open Opening) (CreatureType Player)

//PRESSURE  DOOR 2 -PLYR CLOSE SLAM
schema d_press_cl_p
archetype PLYR_DOOR
volume -1200
d_met2c
env_tag (Event StateChange) (DoorType Pressure) (OpenState Closed) (OldOpenState Closing) (CreatureType Player)


//OBLONG MANHOLE

//OBLONG MANHOLE -PLYR OPENING
schema oblmanhole_op
archetype PLYR_DOOR
volume -1000
d_oblm1o
env_tag (Event StateChange) (DoorType OblManhole) (OpenState Opening) (OldOpenState Closing Closed) (CreatureType Player)

//OBLONG MANHOLE -PLYR SQUEAKS
schema oblmanhole_sq
archetype PLYR_DOOR
volume -1500
d_oblm1s
env_tag (Event StateChange) (DoorType OblManhole) (OpenState Closing) (OldOpenState Open Opening) (CreatureType Player)

//OBLONG MANHOLE -PLYR CLOSE SLAM
schema oblmanhole_cl
archetype PLYR_DOOR
volume -1000
d_met1c
env_tag (Event StateChange) (DoorType OblManhole) (OpenState Closed) (OldOpenState Opening Closing) (CreatureType Player)


//SLIDING MANHOLE -Std Sliding Manhole

//SLIDING MANHOLE -PLYR OPENING SQUEAK
schema d_manhole_op
archetype PLYR_DOOR
volume -1000
d_manh1o
env_tag (Event StateChange) (DoorType Manhole) (OpenState Opening) (OldOpenState Closing Closed) (CreatureType Player)

//SLIDING MANHOLE  -PLYR CLOSING SQUEAKS
schema d_manhole_sq
archetype PLYR_DOOR
volume -1300
d_manh1s
env_tag (Event StateChange) (DoorType Manhole) (OpenState Closing) (OldOpenState Open Opening) (CreatureType Player)

//SLIDING MANHOLE  -PLYR CLOSE SLAM
schema d_manhole_cl
archetype PLYR_DOOR
volume -800 
d_manh1c
env_tag (Event StateChange) (DoorType Manhole) (OpenState Closed) (OldOpenState Opening Closing) (CreatureType Player)





//SLIDING DOOR 1 -Standard Sliding Door

//SLIDING DOOR 1 -PLYR OPENING & CLOSING
schema doorsld1_op_p
archetype PLYR_DOOR
volume -1
d_slid1o
env_tag (Event StateChange)  (DoorType Slide1) (OpenState Opening Closing) (OldOpenState Open Closed Opening Closing) (CreatureType Player)

//SLIDING DOOR 1 -PLYR OPEN & CLOSE SLAM
schema doorsld1_cl_p
archetype PLYR_DOOR
volume -1
d_slid1c
env_tag (Event StateChange) (DoorType Slide1)  (OpenState Open Closed) (OldOpenState Open Closed Opening Closing) (CreatureType Player)


//SLIDING DOOR 2 -Small sliding door

//SLIDING DOOR 2 -PLYR OPENING & CLOSING SQUEAKS
schema doorsld2_sq_p
archetype PLYR_DOOR
volume -1250 //was -700
d_slid2s
env_tag (Event StateChange)  (DoorType Slide2Sm) (OpenState Opening Closing) (OldOpenState Open Closed Opening Closing) (CreatureType Player)

//SLIDING DOOR 2 -PLYR OPEN SLAM
schema doorsld2_op_p
archetype PLYR_DOOR
volume -1250 //was -700
d_slid2o
env_tag (Event StateChange) (DoorType Slide2Sm)  (OpenState Open) (OldOpenState Opening)  (CreatureType Player)

//SLIDING DOOR 2 -PLYR CLOSE SLAM
schema doorsld2_cl_p
archetype PLYR_DOOR
volume -1250 //was -700
d_slid2c
env_tag (Event StateChange) (DoorType Slide2Sm)  (OpenState Closed) (OldOpenState Opening Closing)  (CreatureType Player)



//SLIDING DOOR 3 -Fast [MechBlastShield]

//SLIDING DOOR 3 -PLYR OPENING & CLOSING
schema doorsld3_sq_p
archetype PLYR_DOOR
volume -1250
d_slid3s
env_tag (Event StateChange)  (DoorType Slide3Fast) (OpenState Opening Closing) (OldOpenState Open Closed Opening Closing) (CreatureType Player)

//SLIDING DOOR 3 -PLYR OPEN SLAM
schema doorsld3_op_p
archetype PLYR_DOOR
volume -1250
d_slid3o
env_tag (Event StateChange) (DoorType Slide3Fast)  (OpenState Open) (OldOpenState Opening Closing) (CreatureType Player)

//SLIDING DOOR 3 -PLYR CLOSE SLAM
schema doorsld3_cl_p
archetype PLYR_DOOR
volume -1250
d_slid3c
env_tag (Event StateChange) (DoorType Slide3Fast)  (OpenState Closed) (OldOpenState Opening Closing) (CreatureType Player)


//BARS & CHAIN DOORS -Standard Chain or Bar Door

//BARS & CHAIN DOORS -PLYR OPENING & CLOSING
schema doorbars_op_p
archetype PLYR_DOOR
mono_loop 0 0
volume -1000
d_bars1o
env_tag (Event StateChange)  (DoorType Bars) (OpenState Opening Closing) (OldOpenState Open Closed Opening Closing) (CreatureType Player)

//BARS & CHAIN DOORS -PLYR OPEN & CLOSING SLAM
schema doorbars_cl_p
archetype PLYR_DOOR
volume -1000
d_bars1c
env_tag (Event StateChange)  (DoorType Bars) (OpenState Open Closed) (OldOpenState Opening Closing) (CreatureType Player)

//GIANT PORT DOORS -OPENING & CLOSING
schema d_giantport_op
archetype PLYR_DOOR
mono_loop 0 0
volume -500
d_bars1o
env_tag (Event StateChange)  (DoorType GiantPort) (OpenState Opening Closing) (OldOpenState Open Closed Opening Closing)

//GIANT PORT DOORS -OPEN & CLOSING SLAM
schema d_giantport_cl
archetype PLYR_DOOR
volume -500
d_bars1c
env_tag (Event StateChange)  (DoorType GiantPort) (OpenState Open Closed) (OldOpenState Opening Closing) 



//JAILCELL DOOR

//JAILCELL DOOR -PLYR OPENING
schema doorcell_op
archetype PLYR_DOOR
volume -500
d_cell1o
env_tag (Event StateChange) (DoorType Cell)  (OpenState Opening) (OldOpenState Closed Opening Closing)

//JAILCELL DOOR -PLYR CLOSING
schema doorcell_cl
archetype PLYR_DOOR
volume -500
d_cell1c
env_tag (Event StateChange) (DoorType Cell)  (OpenState Closing) (OldOpenState Open Opening Closing)


//MECH BLAST DOOR

//MECH BLAST DOOR -PLYR OPENING
schema doorblast_op_p
archetype PLYR_DOOR
volume -1
mono_loop 0 0
d_blas1o
env_tag (Event StateChange) (DoorType Blast)  (OpenState Opening) (OldOpenState Closed Opening Closing) (CreatureType Player)

//MECH BLAST DOOR -PLYR CLOSING
schema doorblast_sq_p
archetype PLYR_DOOR
volume -1
mono_loop 0 0
d_blas1s
env_tag (Event StateChange) (DoorType Blast)  (OpenState Closing) (OldOpenState Open Opening Closing) (CreatureType Player)

//MECH BLAST DOOR -PLYR CLOSED
schema doorblast_cl_p
archetype PLYR_DOOR
volume -1
d_blas1c
env_tag (Event StateChange) (DoorType Blast)  (OpenState Open Closed) (OldOpenState Opening Closing) (CreatureType Player)



//AI DOORS

//WOOD DOOR 1 -Standard Wood Door

//WOOD DOOR 1 -AI OPENING
schema doorwood_op_ai
archetype AI_DOOR
volume -500
d_wood1o
env_tag (Event StateChange) (DoorType Wood1sm) (OpenState Opening) (OldOpenState Closed)

//WOOD DOOR 1,2 -AI SQUEAKS 
schema doorwood_sq_ai
archetype AI_DOOR
volume -1000
d_woods1 d_woods2 d_woods3
env_tag (Event StateChange) (DoorType Wood1sm Wood2lg)  (OpenState Closing) (OldOpenState Open Opening Closing) 

//WOOD DOOR 1 -AI CLOSE SLAM
schema doorwood1_cl_ai
archetype AI_DOOR
volume -500
d_wood1c
env_tag (Event StateChange) (DoorType Wood1sm)  (OpenState Closed) (OldOpenState Open Opening Closing)


//WOOD DOOR 2 -Heavy Wood Door

//WOOD DOOR 2 -AI OPENING
schema doorwood2_op_ai
archetype AI_DOOR
volume -500
d_wood2o
env_tag (Event StateChange) (DoorType Wood2lg)  (OpenState Opening) (OldOpenState Closed)

//WOOD DOOR 2 -AI CLOSE SLAM
schema doorwood2_cl_ai
archetype AI_DOOR
volume -500
d_wood2c
env_tag (Event StateChange) (DoorType Wood2lg)  (OpenState Closed) (OldOpenState Open Opening Closing)


//WOOD DOOR 3 -Victorian Doors

//WOOD DOOR 3 -AI OPENING
schema d_wood3_op_ai
archetype AI_DOOR
volume -500
d_wood3o
env_tag (Event StateChange) (DoorType Wood3Vic) (OpenState Opening) (OldOpenState Closed) 

//WOOD DOOR 3 -AI SQUEAKS 
schema d_wood3_sq_ai
archetype AI_DOOR
volume -1500
d_woods4 d_woods5 d_woods6
env_tag (Event StateChange) (DoorType Wood3Vic)  (OpenState Closing) (OldOpenState Open Opening Closing) 

//WOOD DOOR 3 -AI CLOSE SLAM
schema d_wood3_cl_ai
archetype AI_DOOR
volume -500 
d_wood3c
env_tag (Event StateChange) (DoorType Wood3Vic)  (OpenState Closed) (OldOpenState Open Opening Closing) 


//WOOD DOOR 4 -Office Doors

//WOOD DOOR 4 -AI OPENING
schema d_wood4_op_ai
archetype AI_DOOR
volume -500
d_wood4o
env_tag (Event StateChange) (DoorType Wood4Off) (OpenState Opening) (OldOpenState Closed) 

//WOOD DOOR 4 -AI SQUEAKS 
schema d_wood4_sq_ai
archetype AI_DOOR
volume -1000
d_woods7 d_woods8
env_tag (Event StateChange) (DoorType Wood4Off)  (OpenState Closing) (OldOpenState Open Opening Closing) 

//WOOD DOOR 4 -AI CLOSE SLAM
schema d_wood4_cl_ai
archetype AI_DOOR
volume -500
d_wood4c
env_tag (Event StateChange) (DoorType Wood4Off)  (OpenState Closed) (OldOpenState Open Opening Closing) 


//METAL DOOR 1 -Standard Metal Door

//METAL DOOR 1 -AI OPENING
schema doormet1_op_ai
archetype AI_DOOR
volume -500
d_met1o
env_tag (Event StateChange) (DoorType Metal) (OpenState Opening) (OldOpenState Closed) 

//METAL DOOR 1 -AI SQUEAKS <--Yes, I know it's the wood squeak!
schema doormet_sq_ai
archetype AI_DOOR
volume -1000
d_woods1 d_woods2 d_woods3
env_tag (Event StateChange) (DoorType Metal) (OpenState Opening Closing) (OldOpenState Open Opening Closing) 

//METAL DOOR 1 -AI CLOSE SLAM
schema doormet1_cl_ai
archetype AI_DOOR
volume -500
d_met1c
env_tag (Event StateChange) (DoorType Metal) (OpenState Closed) (OldOpenState Opening Closing) 


//METAL DOOR 2 -Heavy Metal Door [like sewer hatch]

//METAL DOOR 2 -AI OPENING & CLOSING
schema doormet2_op_ai
archetype AI_DOOR
volume -500
d_met2o
env_tag (Event StateChange) (DoorType Metal2Hvy) (OpenState Opening Closing) (OldOpenState Open Opening Closed Closing)

//METAL DOOR 2 -AI OPEN SLAM
schema doormet2_o2_ai
archetype AI_DOOR
volume -750
d_met2o2
env_tag (Event StateChange) (DoorType Metal2Hvy) (OpenState Open) (OldOpenState Opening) 

//METAL DOOR 2 -AI CLOSE SLAM
schema doormet2_cl_ai
archetype AI_DOOR
volume -500
d_met2c
env_tag (Event StateChange) (DoorType Metal2Hvy) (OpenState Closed) (OldOpenState Closing) 


//METAL DOOR 3 -Warehouse Doors

//METAL DOOR 3 -AI OPENING
schema d_met3_op_ai
archetype AI_DOOR
volume -500
d_met3o
env_tag (Event StateChange) (DoorType Metal3Wh) (OpenState Opening) (OldOpenState Closed) 

//METAL DOOR 3 -AI SQUEAKS  <--Yes, I know it's the wood squeak!
schema d_met3_sq_ai
archetype AI_DOOR
volume -750
d_mets3 d_mets4
env_tag (Event StateChange) (DoorType Metal3Wh) (OpenState Opening Closing) (OldOpenState Open Opening Closing) 

//METAL DOOR 3 -AI CLOSE SLAM
schema d_met3_cl_ai
archetype AI_DOOR
volume -500
d_met3c
env_tag (Event StateChange) (DoorType Metal3Wh) (OpenState Closed) (OldOpenState Opening Closing) 


//METAL DOOR 4 -Fancy Mechanist Doors

//METAL DOOR 4 -AI OPENING
schema d_met4_op_ai
archetype AI_DOOR
volume -500
d_met4o
env_tag (Event StateChange) (DoorType Metal4Mech) (OpenState Opening) (OldOpenState Closed) 

//METAL DOOR 4 -AI SQUEAKS  
schema d_met4_sq_ai
archetype AI_DOOR
volume -750
d_mets1 d_mets2
env_tag (Event StateChange) (DoorType Metal4Mech) (OpenState Opening Closing) (OldOpenState Open Opening Closing) 

//METAL DOOR 4 -AI CLOSE SLAM
schema d_met4_cl_ai
archetype AI_DOOR
volume -500
d_met4c
env_tag (Event StateChange) (DoorType Metal4Mech) (OpenState Closed) (OldOpenState Opening Closing) 


//PRESSURE DOOR 1 -AI OPENING & CLOSING
schema d_press_op_a
archetype AI_DOOR
volume -500
d_met2o
env_tag (Event StateChange) (DoorType Pressure) (OpenState Opening Closing) (OldOpenState Open Opening Closed Closing) 

//PRESSURE DOOR 2 -AI OPEN SLAM
schema d_press_sq_a
archetype AI_DOOR
volume -500
d_met2o2
env_tag (Event StateChange) (DoorType Pressure) (OpenState Open) (OldOpenState  Opening)

//PRESSURE DOOR 2 -AI CLOSE SLAM
schema d_press_cl_a
archetype AI_DOOR
volume -500
d_met2c
env_tag (Event StateChange) (DoorType Pressure) (OpenState Closed) (OldOpenState Closing)



//OBLONG MANHOLE

//OBLONG MANHOLE -AI OPENING
schema oblmanhole_op_ai
archetype AI_DOOR
volume -500
d_oblm1o
env_tag (Event StateChange) (DoorType OblManhole) (OpenState Opening) (OldOpenState Closing Closed)

//OBLONG MANHOLE -AI SQUEAKS
schema oblmanhole_sq_ai
archetype AI_DOOR
volume -750
d_oblm1s
env_tag (Event StateChange) (DoorType OblManhole) (OpenState Closing) (OldOpenState Open Opening)

//OBLONG MANHOLE -AI CLOSE SLAM
schema oblmanhole_cl_ai
archetype AI_DOOR
volume -500
d_met1c
env_tag (Event StateChange) (DoorType OblManhole) (OpenState Closed) (OldOpenState Opening Closing)


//SLIDING MANHOLE -Std Sliding Manhole

//SLIDING MANHOLE -AI OPENING SQUEAK
schema d_manhole_op_ai
archetype AI_DOOR
volume -500
d_manh1o
env_tag (Event StateChange) (DoorType Manhole) (OpenState Opening) (OldOpenState Closing Closed)

//SLIDING MANHOLE  -AI CLOSING SQUEAKS
schema d_manhole_sq_ai
archetype AI_DOOR
volume -500
d_manh1s
env_tag (Event StateChange) (DoorType Manhole) (OpenState Closing) (OldOpenState Open Opening)

//SLIDING MANHOLE  -AI CLOSE SLAM
schema d_manhole_cl_ai
archetype AI_DOOR
volume -500 
d_manh1c
env_tag (Event StateChange) (DoorType Manhole) (OpenState Closed) (OldOpenState Opening Closing)



//SLIDING DOOR 1 -Standard Sliding Door

//SLIDING DOOR 1 -AI OPENING & CLOSING
schema doorsld1_op_ai
archetype AI_DOOR
volume -500
d_slid1o
env_tag (Event StateChange)  (DoorType Slide1) (OpenState Opening Closing) (OldOpenState Open Closed Opening Closing)

//SLIDING DOOR 1 -AI OPEN & CLOSE SLAM
schema doorsld1_cl_ai
archetype AI_DOOR
volume -500
d_slid1c
env_tag (Event StateChange) (DoorType Slide1)  (OpenState Open Closed) (OldOpenState Open Closed Opening Closing)


//SLIDING DOOR 2 -Small sliding door

//SLIDING DOOR 2 -PLYR OPENING & CLOSING SQUEAKS
schema doorsld2_sq_ai
archetype AI_DOOR
volume -500
d_slid2s
env_tag (Event StateChange)  (DoorType Slide2Sm) (OpenState Opening Closing) (OldOpenState Open Closed Opening Closing) 

//SLIDING DOOR 2 -PLYR OPEN SLAM
schema doorsld2_op_ai
archetype AI_DOOR
volume -500
d_slid2o
env_tag (Event StateChange) (DoorType Slide2Sm)  (OpenState Open) (OldOpenState Opening) 

//SLIDING DOOR 2 -PLYR CLOSE SLAM
schema doorsld2_cl_ai
archetype AI_DOOR
volume -500
d_slid2c
env_tag (Event StateChange) (DoorType Slide2Sm)  (OpenState Closed) (OldOpenState Opening Closing) 



//SLIDING DOOR 3 -Fast [MechBlastShield]

//SLIDING DOOR 3 -AI OPENING & CLOSING
schema doorsld3_sq_ai
archetype AI_DOOR
volume -500
d_slid3s
env_tag (Event StateChange)  (DoorType Slide3Fast) (OpenState Opening Closing) (OldOpenState Open Closed Opening Closing)

//SLIDING DOOR 3 -AI OPEN SLAM
schema doorsld3_op_ai
archetype AI_DOOR
volume -500
d_slid3o
env_tag (Event StateChange) (DoorType Slide3Fast)  (OpenState Open) (OldOpenState Opening Closing)

//SLIDING DOOR 3 -AI CLOSE SLAM
schema doorsld3_cl_ai
archetype AI_DOOR
volume -500
d_slid3c
env_tag (Event StateChange) (DoorType Slide3Fast)  (OpenState Closed) (OldOpenState Opening Closing)





//BARS DOORS -Standard Bar Door

//BARS DOORS -AI OPENING & CLOSING
schema doorbars_op_ai
archetype AI_DOOR
mono_loop 0 0
volume -500
d_bars1o
env_tag (Event StateChange)  (DoorType Bars) (OpenState Opening Closing) (OldOpenState Open Closed Opening Closing)

//AI CLOSED CHAIN/BAR DOORS
schema doorbars_cl_ai
archetype AI_DOOR
volume -500
d_bars1c
env_tag (Event StateChange)  (DoorType Bars) (OpenState Open Closed) (OldOpenState Opening Closing)


//MECH BLAST DOOR

//MECH BLAST DOOR -AI OPENING
schema doorblast_op_ai
archetype AI_DOOR
volume -1
mono_loop 0 0
d_blas1o
env_tag (Event StateChange) (DoorType Blast)  (OpenState Opening) (OldOpenState Closed Opening Closing)

//MECH BLAST DOOR -AI SQUEAKS
schema doorblast_sq_ai
archetype AI_DOOR
volume -1
mono_loop 0 0
d_blas1s
env_tag (Event StateChange) (DoorType Blast)  (OpenState Closing) (OldOpenState Open Opening Closing)

//MECH BLAST DOOR -AI CLOSED
schema doorblast_cl_ai
archetype AI_DOOR
volume -1
d_blas1c
env_tag (Event StateChange) (DoorType Blast)  (OpenState Open Closed) (OldOpenState Opening Closing)



/////////
//BOXES//
/////////

//WOOD BOX  -Standard Footlocker

//WOOD BOX  -OPEN
schema boxwood_op
archetype PLYR_BOX
volume -800
bxwood1o
env_tag (Event StateChange)  (BoxType BoxWood) (OpenState Opening) (OldOpenState Closed)

//WOOD BOX  -SQUEAK
schema boxwood_sq
archetype PLYR_BOX
volume -2100
bxwood1s
env_tag (Event StateChange)  (BoxType BoxWood) (OpenState Closing) (OldOpenState Open Opening Closing)

//WOOD BOX  -CLOSE SLAM
schema boxwood_cl
archetype PLYR_BOX
volume -800
bxwood1c
env_tag (Event StateChange)  (BoxType BoxWood) (OpenState Closed) (OldOpenState Opening Closing)


//MONEY BOX -Small Purple Box

//MONEY BOX -OPEN
schema boxmoney_op
archetype PLYR_BOX
volume -800
bxmony1o
env_tag (Event StateChange)  (BoxType BoxMoney) (OpenState Opening) (OldOpenState Opening Closing Closed)

//MONEY BOX -SQUEAK
schema boxmoney_sq
archetype PLYR_BOX
volume -1500
bxmony1s
env_tag (Event StateChange)  (BoxType BoxMoney) (OpenState Closing) (OldOpenState Open Opening Closing)

//MONEY BOX -CLOSE SLAM
schema boxmoney_cl
archetype PLYR_BOX
volume -800
bxmony1c
env_tag (Event StateChange)  (BoxType BoxMoney) (OpenState Closed) (OldOpenState Opening Closing)


//CHEST -FANCY BLUE CHEST

//CHEST -OPEN
schema boxchest_op
archetype PLYR_BOX
volume -800
bxches1o
env_tag (Event StateChange)  (BoxType BoxChest) (OpenState Open) (OldOpenState Opening)

//CHEST -SQUEAK
schema boxchest_sq
archetype PLYR_BOX
volume -800
bxches1s
env_tag (Event StateChange)  (BoxType BoxChest) (OpenState Opening) (OldOpenState Opening Closing Closed)

//CHEST -CLOSED
schema boxchest_cl
archetype PLYR_BOX
volume -800
bxches1c
env_tag (Event StateChange)  (BoxType BoxChest) (OpenState Closed) (OldOpenState Opening Closing)


//GYM LOCKER

//GYM LOCKER -PLYR OPENING SQUEAKS
schema bxlocker_os_p
archetype PLYR_BOX
volume -1000
bxlock1s
env_tag (Event StateChange) (BoxType GymLocker) (OpenState Opening) (OldOpenState Closed)

//GYM LOCKER -PLYR OPEN SLAM
schema bxlocker_op_p
archetype PLYR_BOX
volume -1000
bxlock1o
env_tag (Event StateChange) (BoxType GymLocker) (OpenState Open) (OldOpenState Opening Closing)

//GYM LOCKER -PLYR CLOSING SQUEAKS
schema bxlocker_cs_p
archetype PLYR_BOX
volume -2500
d_shut1s
env_tag (Event StateChange) (BoxType GymLocker)  (OpenState Closing) (OldOpenState Open Opening Closing)

//GYM LOCKER -PLYR CLOSE SLAM
schema bxlocker_cl_p
archetype PLYR_BOX
volume -1000
bxlock1c
env_tag (Event StateChange) (BoxType GymLocker) (OpenState Closed) (OldOpenState Opening Closing)


//SAFE

//SAFE -PLYR OPENING
schema bxsafe_op_p
archetype PLYR_BOX
volume -750
bxsafe1o
env_tag (Event StateChange) (BoxType Safe) (OpenState Opening) (OldOpenState Opening Closing Closed)

//SAFE -PLYR SQUEAKS  <--Yes it's the shutter squeak!
schema bxsafe_sq_p
archetype PLYR_BOX
volume -2000
d_shut1s
env_tag (Event StateChange) (BoxType Safe)  (OpenState Closing) (OldOpenState Open Opening Closing)

//SAFE -PLYR CLOSE SLAM
schema bxsafe_cl_p
archetype PLYR_BOX
volume -250
bxsafe1c
env_tag (Event StateChange) (BoxType Safe) (OpenState Closed) (OldOpenState Opening Closing) 



//SARCOFAGUS -OPENING & CLOSING
schema sarcof_op
archetype PLYR_BOX
volume -500
pplate
env_tag (Event StateChange)  (BoxType Sarcof) (OpenState Opening Closing) (OldOpenState Open Opening Closed Closing)










/////////
//LOCKS//
/////////

//DOOR UNLOCKS
schema unlocked
archetype DEVICE_MISC
unlocked
env_tag (Event StateChange) (LockState Unlocked)

//DOOR UNLOCKS
schema unlocked_sky
archetype DEVICE_MISC
volume -1
pplate
env_tag (Event StateChange) (LockState Unlocked) (DoorType Skylight)


//DOOR LOCKS OR IS LOCKED
schema locked
archetype DEVICE_MISC
locked
env_tag (Event StateChange) (LockState Locked)
env_tag (Event Reject) (Operation OpenDoor)
env_tag (Event Reject) (Operation FrobLock) (DeviceType Lockbox)

//YOU GOT THE WRONG KEY
schema wrongkey
archetype DEVICE_MISC
volume -500
wrongkey
env_tag (Event Reject) (Operation KeyFit) //(ObjType StdKey)

//YOU GOT THE WRONG KEY -OTHER TYPES
schema wrongkey_other
archetype DEVICE_MISC
volume -350
garhmmm
env_tag (Event Reject) (Operation KeyFit) (ObjType RubyEye ShipsWheelPeg Cuckoo)

//LOCKPICKING
schema lockpik
archetype DEVICE_MISC
mono_loop 0 0
lockpik1 lockpik2 

//LOCKPICKING STARTING TO WORK
schema pinset
archetype DEVICE_MISC
pinset

//LOCKPICKING REALLY WORKING
schema tumblerset
archetype DEVICE_MISC
pinset1 pinset2

//LOCKPICKING NOT WORKING
schema noluck
archetype DEVICE_MISC
noluck1 noluck2

//LOCKING PICKING TEST

//LOCK IS GOOD
schema test_lockgood
archetype DEVICE_MISC
lockgood
env_tag (Event StateChange) (LockState Good)

//LOCK IS Bad
schema test_lockbad
archetype DEVICE_MISC
lockbad
env_tag (Event StateChange) (LockState Bad)

//LOCK IS Critical
schema test_lockcrit
archetype DEVICE_MISC
lockcrit
env_tag (Event StateChange) (LockState Critical)

//LOCK-PICKING THE MINE
schema mine_pick
archetype DEVICE_MISC
minepik1
env_tag (Event StateChange) (LockState Bland) (WeaponType ActiveMine Mine)

//DIGITAL COMBO LOCK -NUMBER CLICK
schema digiclk
archetype DEVICE_MISC
volume -1000
pinset

//DIGITAL COMBO LOCK -SUCCESS
schema digisuc
archetype DEVICE_MISC
digisuc



/////////////
//ELEVATORS//
/////////////

//ELEV1 -Standard elevator platform
schema elev1_loop
archetype DEVICE_LIFT
mono_loop 0 0
volume -750
elev1lp
env_tag (Event ActiveLoop) (ElevType Elev1Plat)

schema elev1_stop
archetype DEVICE_LIFT
volume -750
elev1st
env_tag (Event Deactivate) (ElevType Elev1Plat)

//ELEV2 -Smaller hammer elevator
schema elev2_loop
archetype DEVICE_LIFT
mono_loop 0 0
volume -750
elev2lp
env_tag (Event ActiveLoop) (ElevType Elev2Hmr)

schema elev2_stop
archetype DEVICE_LIFT
volume -750
elev2st
env_tag (Event Deactivate) (ElevType Elev2Hmr)


//ELEV3 -Big, green warehouse doors [no loop]
schema elev3_go
archetype DEVICE_LIFT
elev3go
env_tag (Event StateChange) (ElevType Elev3WHdoor)  (OpenState Opening Closing) (OldOpenState Open Opening Closed Closing) 

schema elev3_stop
archetype DEVICE_LIFT
elev3st
env_tag (Event StateChange) (ElevType Elev3WHdoor)  (OpenState Open Closed) (OldOpenState Opening Closing) 

//SKYLIGHT
schema skylight_op
archetype PLYR_DOOR
volume -400
mono_loop 0 0
elev1lp
env_tag (Event StateChange) (ElevType Skylight) (OpenState Opening Closing) (OldOpenState Open Closed) 

schema skylight_cl
archetype PLYR_DOOR
volume -1
elev2st
env_tag (Event StateChange) (ElevType Skylight) (OpenState Open Closed) (OldOpenState Opening Closing) 

//LIGHTHOUSE FLOOR 
schema LHFloor_loop
archetype DEVICE_LIFT
volume -1
no_repeat
mono_loop 0 0
d_blas1o d_blas1s
env_tag (Event ActiveLoop) (ElevType LightHseFloor)

schema LHFloor_stop
archetype DEVICE_LIFT
volume -1
d_blas1c
env_tag (Event Deactivate) (ElevType LightHseFloor)

//DUMBWAITER
schema elev4_go
archetype DEVICE_LIFT
no_repeat
mono_loop 0 0
volume -1000
machsm02
env_tag (Event ActiveLoop) (ElevType DumbWaiter)

schema elev4_stop
archetype DEVICE_LIFT
no_repeat
volume -800
d_slid2c
env_tag (Event Deactivate) (ElevType DumbWaiter)

//TUBELIFT & MOVING TARGET
schema elev5_go
archetype DEVICE_LIFT
no_repeat
mono_loop 0 0
volume -1000
machsm03
env_tag (Event ActiveLoop) (ElevType MovingTarget Tubelift)

schema elev5_stop
archetype DEVICE_LIFT
no_repeat
volume -800
d_slid3c
env_tag (Event Deactivate) (ElevType MovingTarget Tubelift)