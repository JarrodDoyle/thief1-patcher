

///////////
//TURRETS//
///////////

//Turret open
schema turopen
archetype DEVICE_MISC
volume -1
turopen 
env_tag (Event Activate) (CreatureType Turret)

//Turret close
schema turclose
archetype DEVICE_MISC
volume -1
turclose
env_tag (Event Deactivate) (CreatureType Turret)

//Turret rotate loop 
schema turloop
archetype DEVICE_MISC
volume -1500
mono_loop 0 0
turloop
env_tag (Event Rotate) (LoopState loop) (CreatureType Turret)




//Turret fire cannonball
schema fire_turcan
archetype OTHER_WEAPON
volume -1
f_turcan
env_tag (Event Shoot) (CritterGunType CanLauncher)

//Turret fire sawblade
schema fire_tursaw
archetype OTHER_WEAPON
volume -1
f_tursaw
env_tag (Event Shoot) (CritterGunType SawLauncher)
env_tag (Event Launch) (LaunchVel 0 99) (ArrowType SawBlade)

//Turret fire bolt
schema fire_turbolt
archetype OTHER_WEAPON
volume -1
f_turbol
env_tag (Event Shoot) (CritterGunType BoltLauncher)

//Turret sawblade whizz
schema sawblade_whiz
archetype OTHER_WEAPON
delay 350
volume -1000
sawwhiz1 sawwhiz2 sawwhiz3


//Turret Death
schema turDeath
archetype DEVICE_MISC
volume -1
exptur1 exptur2
env_tag (Event Death) (CreatureType Turret)




///////////
//CAMERAS//
///////////

//CAMERA LOOP
schema camera_lp
archetype DEVICE_MISC
volume -1500 //was -2000
mono_loop 0 0
Camloop
env_tag (event Rotate) (CreatureType Camera) (LoopState loop)

//CAMERA STOP
schema camera_st
archetype DEVICE_MISC
volume -1500 //was -2000
Camstop
env_tag (event Rotate) (CreatureType Camera) (LoopState Stop)


//CAMERA SPEECH

//TO ALERT 1
schema camto1
archetype AI_NONE
volume -500 //was -1000
camto1
schema_voice vcamera 1 tolevelone

//TO ALERT 2
schema camto2
archetype AI_MINOR
volume -350 //was -750
camto2
schema_voice vcamera 1 toleveltwo
 
//TO ALERT 3
schema camto3
archetype AI_MAJOR
volume -250 //was -500
camto3
schema_voice vcamera 1 tolevelthree

//BACK TO ZERO
schema cambak
archetype AI_NONE
volume -500 //was -1000
cambak
schema_voice vcamera 1 backtozero

//LOST CONTACT
schema camlos
archetype AI_NONE
volume -250 //was -500
camlos
schema_voice vcamera 1 lostcontact

//AT LEVEL 3
schema camat3
archetype AI_MAJOR
volume -750 //was -1000
mono_loop 0 0
camat3
schema_voice vcamera 1 atlevelthree



/////////////////
//EYEBALL PLANT//
/////////////////

//EYEBALL STOP
schema eye_st
archetype DEVICE_MISC
volume -800 //was -1500
eyeball1 eyeball2 eyeball3 eyeball4 eyeball5
env_tag (event Rotate) (CreatureType EyeBall) (LoopState Stop)

schema eyedie
archetype AI_NONE
delay 80
volume -1
eyedie1 eyedie2 eyedie3
env_tag (Event Death) (CreatureType Eyeball)





