//COLLISIONS

////////////////////////////////
//GENERIC MATERIAL ON MATERIAL//
////////////////////////////////

//HIT Ceramic,Glass <--> Ceramic,Glass
schema hcercer
archetype HIT_MATERIAL
no_repeat
hcercer hcercer2
env_tag (Event Collision) (Material Ceramic) (Material2 Ceramic Glass)
env_tag (Event Collision) (Material Glass) (Material2 Glass)

//HIT Ceramic,Glass <--> Carpet,Earth
schema hcerear
archetype HIT_MATERIAL
hcerear
env_tag (Event Collision) (Material Carpet) (Material2 Ceramic Glass)
env_tag (Event Collision) (Material Ceramic) (Material2 Earth)
env_tag (Event Collision) (Material Earth) (Material2 Glass)

//HIT Ceramic,Glass <--> Stone,Tile 
schema hcersto
archetype HIT_MATERIAL
no_repeat
hcersto hcersto2 hcersto3
env_tag (Event Collision) (Material Ceramic Glass) (Material2 Stone Tile)

//HIT Ceramic,Glass <--> Metal 
schema hcermet
archetype HIT_MATERIAL
no_repeat
hcermet hcermet2 
env_tag (Event Collision) (Material Ceramic Glass) (Material2 Metal)

//HIT Ceramic,Glass <--> Wood
schema hcerwoo
archetype HIT_MATERIAL
hcerwoo hcerwoo2
env_tag (Event Collision) (Material Ceramic Glass) (Material2 Wood)

//HIT Gravel <--> ALL
schema hgravel
archetype HIT_MATERIAL
hgravel hgravel2
env_tag (Event Collision) (Material Carpet Ceramic Earth Glass Gravel) (Material2 Gravel)
env_tag (Event Collision) (Material Gravel) (Material2 Ice Metal Stone Tile Wood)

//HIT Metal <--> Carpet,Earth 
schema hmetear
archetype HIT_MATERIAL
no_repeat
hmetear hmetear2
env_tag (Event Collision) (Material Carpet Earth) (Material2 Metal)

//HIT Metal <--> Metal 
schema hmetmet
archetype HIT_MATERIAL
no_repeat
hmetmet hmetmet2 hmetmet3
env_tag (Event Collision) (Material Metal) (Material2 Metal)

//HIT Metal <--> Stone,Tile
schema hmetsto
archetype HIT_MATERIAL
no_repeat
hmetsto hmetsto2 hmetsto3
env_tag (Event Collision) (Material Metal) (Material2 Stone Tile)

//HIT Metal <--> Wood
schema hmetwoo
archetype HIT_MATERIAL
no_repeat
hmetwoo hmetwoo2
env_tag (Event Collision) (Material Metal) (Material2 Wood)

//HIT Stone,Tile <--> Carpet,Earth
schema hstoear
archetype HIT_MATERIAL
no_repeat
hstoear hstoear2 
env_tag (Event Collision) (Material Carpet Earth) (Material2 Stone 
Tile)

//HIT Stone <--> Stone
schema hstosto
archetype HIT_MATERIAL
no_repeat
hstosto hstosto2 hstosto3
env_tag (Event Collision) (Material Stone) (Material2 Stone Tile)
env_tag (Event Collision) (Material Tile) (Material2 Tile)

//HIT Wood <--> Carpet,Earth
schema hwooear
archetype HIT_MATERIAL
no_repeat
hwooear hwooear2
env_tag (Event Collision) (Material Carpet Earth) (Material2 Wood)

//HIT Wood <--> Stone,Tile
schema hwoosto
archetype HIT_MATERIAL
no_repeat
hwoosto hwoosto2 hwoosto3 hwoosto4
env_tag (Event Collision) (Material Stone Tile) (Material2 Wood)

//HIT Wood <--> Wood
schema hwoowoo
archetype HIT_MATERIAL
no_repeat
hwoowoo hwoowoo2 hwoowoo3
env_tag (Event Collision) (Material Wood) (Material2 Wood)

//HIT Vegetation <--> small
schema hvegsm
archetype HIT_MATERIAL
volume -500
hvegsm
env_tag (Event Collision) (Material Carpet Ceramic Earth Glass Vegetation) (Material2 Vegetation)

//HIT Vegetation <--> large
schema hveg
archetype HIT_MATERIAL
volume -1
hveg
env_tag (Event Collision) (Material Gravel Metal Stone Tile) (Material2 Vegetation)
env_tag (Event Collision) (Material Vegetation) (Material2 Wood)

//HIT Water <--> All
schema hwater
archetype HIT_MATERIAL
splash02
env_tag (Event MediaTrans) (Material Carpet Ceramic Earth Glass Gravel Ice) (Material2 Liquid) 
env_tag (Event MediaTrans) (Material Liquid) (Material2 Metal Rope Stone Tile Vegetation Wood) 



////////////////////
//ARROW COLLISIONS//
////////////////////

//Hitting armored person
schema arrow_armor
archetype HIT_PROJECTILE
ar_armr1 ar_armr2
env_tag (Event Collision) (CreatureType Ape Crayman Guard Haunt) (ArrowType Broadhead Rope) 

//Hitting unarmored person
schema arrow_body
archetype HIT_PROJECTILE
ar_body1 ar_body2
env_tag (Event Collision) (CreatureType Apparition Burrick Frog Servant Spider Zombie) (ArrowType Broadhead Rope) 

schema arrow_rock
archetype HIT_PROJECTILE
no_repeat
volume -1
ar_rock1 ar_rock2 ar_rock3 ar_rock4 ar_rock5
env_tag (Event Collision) (ArrowType Broadhead Rope) (Material Gravel Stone Tile) 

schema arrow_wood
archetype HIT_PROJECTILE
volume -1
ar_wood1 ar_wood2 ar_wood3
env_tag (Event Collision) (ArrowType Broadhead) (Material Wood) 

schema ropearrow_wood
archetype HIT_PROJECTILE
volume -1
ar_rope1 ar_rope2
env_tag (Event Collision) (ArrowType Rope) (Material Wood)

schema arrow_metal
archetype HIT_PROJECTILE
volume -1
no_repeat
ar_met1 ar_met2 ar_met3 ar_met4 ar_met5
env_tag (Event Collision) (ArrowType Broadhead Rope) (Material Metal) 

schema arrow_soft
archetype HIT_PROJECTILE
volume -1
ar_soft
env_tag (Event Collision) (ArrowType Broadhead Rope) (Material Carpet Earth Vegetation) 

//ARROW HITS CERAMIC, GLASS  <--DOESN'T BREAK
schema arrow_ceramic
archetype HIT_PROJECTILE
ar_glas1 ar_glas2 ar_glas3
env_tag (Event Collision) (ArrowType Broadhead Rope) (Material Ceramic Glass) 

//ARROW HITS WATER
schema arrow_water
archetype HIT_PROJECTILE
splash03
env_tag (Event MediaTrans) (MedTransDir Enter) (ArrowType Broadhead Rope) (Material Liquid) (Material2 Wood)

//WaterArrow 'explodes'
schema waterarrow_hit
archetype HIT_PROJECTILE
douse1 douse2 waterar1 waterar2
env_tag (Event Death) (ArrowType Water) 

//FireArrow explodes
schema firearrow_hit
archetype HIT_PROJECTILE
treexpl1 treexpl2 hitfire
env_tag (Event Death) (ArrowType Fire) 
env_tag (Event Collision) (ArrowType Firebolt) (CreatureType Ape Apparition Burrick Crayman Frog Guard Haunt) 
env_tag (Event Collision) (ArrowType Firebolt) (CreatureType Player Servant Spider Zombie)

//GasArrow explodes
schema gasarrow_hitz
archetype HIT_PROJECTILE
gasarrow
env_tag (Event Death) (ArrowType Gas) 

//HolyWaterArrow explodes
schema holyarrow_hit
archetype HIT_PROJECTILE
holywat1 holywat2 holywat3
env_tag (Event Death) (ArrowType HolyWater) 

//NoisemakerArrow activates 
schema noisemaker
archetype HIT_PROJECTILE
volume -1
noisemk1
env_tag (Event Activate) (ArrowType Noisemaker)

//MAGIC MISSILE HITS TERRAIN
schema hit_magic
archetype HIT_PROJECTILE
hmagic1 hmagic2 hmagic3
env_tag (Event Collision) (ArrowType MagicMissile) (Material Carpet Ceramic Earth Glass Gravel Ice Liquid Ladder)
env_tag (Event Collision) (ArrowType MagicMissile) (Material Metal Rope Stone Tile Vegetation Wood) 

//FIREBOLT HITS THE WALL
schema hit_firebolt
archetype HIT_PROJECTILE
hstoear2
env_tag (Event Collision) (ArrowType Firebolt)

//GHOST SHOT HIT
schema gs_death
archetype COLLISIONS
h_gs2 h_gs3
env_tag (Event Death) (ArrowType GhostShot)


//SEE FIREARROW HITS FOR FIREBOLT HITTING PLAYER


//MAGE FIRE BOLT HIT
schema hit_mgfire
archetype HIT_PROJECTILE
hmgfire
env_tag (Event Death) (MageShotType MageFire)

//MAGE WATER SHOT HIT
schema hit_mgwater
archetype HIT_PROJECTILE
hmgwat1 hmgwat2
env_tag (Event Death) (MageShotType MageWater)

//MAGE EARTH SHOT HIT -see GARRETT:Damage

//MAGE AIR SHOT HIT
schema hit_mgair
archetype HIT_PROJECTILE
hmgair
env_tag (Event Death) (CreatureType ElemAir)

//SANDBAG HIT HARD GROUND
schema sandbag_ground
archetype HIT_PROJECTILE
sandbag1 sandbag2
env_tag (Event Collision) (MageShotType Sandbag) (Material Earth) (Material2 Metal Stone Tile Wood)

//SANDBAG ON SOFT GROUND
schema sandbag_soft
archetype HIT_PROJECTILE
sandbag3 sandbag4
env_tag (Event Collision) (MageShotType Sandbag) (Material Carpet Ceramic Earth) (Material2 Earth)
env_tag (Event Collision) (MageShotType Sandbag) (Material Earth) (Material2 Flesh Glass Gravel Ice Ladder Rope)

//SANDBAG HIT WATER
schema sandbag_water
archetype HIT_PROJECTILE
splash02
env_tag (Event MediaTrans) (MedTransDir Enter) (MageShotType Sandbag) (Material Liquid)



/////////////////////
//HAMMER COLLISIONS//
/////////////////////

//Hitting armored person
schema Hammer_armor
archetype HIT_WEAPON
volume -1
sw_armr1 sw_armr2 sw_armr3 sw_armr4
env_tag (Event Damage) (DamageType Bash) (Damage 1 100) (Health 0 100) (CreatureType Ape Crayman Guard Haunt) (WeaponType Hammer) 

//Hitting unarmored person
schema Hammer_body
archetype HIT_WEAPON
volume -1
sw_body1 sw_body2 sw_body3 sw_body4
env_tag (Event Damage) (DamageType Bash) (Damage 1 100) (Health 0 100) (CreatureType Apparition Burrick Frog Servant Spider Zombie) (WeaponType Hammer) 

schema hammer_rock
archetype HIT_WEAPON
volume -1
sw_rock1 sw_rock2
env_tag (Event Collision) (WeaponType Hammer) (Material Gravel Stone Tile) 

schema Hammer_wood
archetype HIT_WEAPON
volume -1
sw_wood1 sw_wood2
env_tag (Event Collision) (WeaponType Hammer) (Material Wood)

schema Hammer_metal
archetype HIT_WEAPON
sw_met1 sw_met2
env_tag (Event Collision) (WeaponType Hammer) (Material Metal) 

schema Hammer_soft
archetype HIT_WEAPON
ar_soft
env_tag (Event Collision) (WeaponType Hammer) (Material Carpet Earth Vegetation) 

schema Hammer_sword
archetype HIT_WEAPON
volume -1
sw_sw1 sw_sw2 sw_sw3 sw_swp1 sw_swp2
env_tag (Event Collision) (WeaponType Hammer) (WeaponType2 Sword)

////////////////////
//SWORD COLLISIONS//
////////////////////

//Hitting armored person
schema sword_armor
archetype HIT_WEAPON
volume -1
sw_armr1 sw_armr2 sw_armr3 sw_armr4
env_tag (Event Damage) (DamageType Slash) (Damage 1 100) (Health 0 100) (CreatureType Ape Crayman Guard Haunt) (WeaponType Sword)


//Hitting unarmored person
schema sword_body
archetype HIT_WEAPON
volume -1
sw_body1 sw_body2 sw_body3 sw_body4
env_tag (Event Damage) (DamageType Slash) (Damage 1 100) (Health 0 100) (CreatureType Apparition Burrick Frog Servant Spider Zombie) (WeaponType Sword)


schema sword_rock
archetype HIT_WEAPON
volume -1
sw_rock1 sw_rock2
env_tag (Event Collision) (WeaponType Blackjack Sword) (Material Gravel Stone Tile) 

schema sword_wood
archetype HIT_WEAPON
volume -1
sw_wood1 sw_wood2
env_tag (Event Collision) (WeaponType Blackjack Sword) (Material Wood) 

schema sword_metal
archetype HIT_WEAPON
sw_met1 sw_met2
env_tag (Event Collision) (WeaponType Blackjack Sword) (Material Metal) 

schema sword_soft
archetype HIT_WEAPON
ar_soft
env_tag (Event Collision) (WeaponType Blackjack Sword) (Material Carpet Earth Vegetation) 

//SWORD & HAMMER HITS CERAMIC, GLASS  <--DOESN'T BREAK
schema sword_ceramic
archetype HIT_PROJECTILE
sw_glas1 sw_glas2
env_tag (Event Collision) (WeaponType Sword Hammer) (Material Ceramic Glass) 

schema sword_sword
archetype HIT_WEAPON
volume -1
sw_sw1 sw_sw2 sw_sw3 sw_swp1 sw_swp2
env_tag (Event Collision) (WeaponType Sword) (WeaponType2 Sword)

//SWORD HITS HARP
schema sword_harp
archetype HIT_PROJECTILE
sw_harp
env_tag (Event Collision) (WeaponType Blackjack Sword Hammer) (MachType Harp) (Material Wood)


//BLACKJACK COLLISIONS

//Hitting person
schema bjack_flesh
archetype HIT_WEAPON
volume -1
bj_body1
env_tag (Event Collision) (CreatureType Ape Apparition Burrick Crayman ElemFire Frog Guard) (WeaponType Blackjack) 
env_tag (Event Collision) (CreatureType Haunt Servant Spider Zombie) (WeaponType Blackjack) 

/////////////////////
//THINGS THAT BREAK//
/////////////////////

//CERAMIC BREAKS
schema break_ceramic
archetype HIT_PROJECTILE
message gotonoise
brkvase1 ar_vase
env_tag (Event Death) (DamageType Bash Slash Poke) (Material Ceramic) 
env_tag (Event Collision) (ArrowType Assassin) (Material Glass)

//WINDOW BREAKS
schema break_glass
archetype HIT_PROJECTILE
message gotonoise
brkglass
env_tag (Event Death) (DamageType Bash Slash Poke) (Material Glass) 

//DOOR DAMAGE
schema doorwood_dam1
archetype HIT_WEAPON
volume -500
doordam1 doordam2 doordam3 empty
env_tag (Event Damage) (DamageType Bash Slash) (Health 50 79) (DoorType Wood1sm Wood2lg BoxWood Barricade) 

schema doorwood_dam2
archetype HIT_WEAPON
doordam4 doordam5 doordam6
env_tag (Event Damage) (DamageType Bash Slash) (Health 1 49) (DoorType Wood1Sm Wood2Lg BoxWood Barricade)

schema doorwood_break
archetype HIT_PROJECTILE
volume -500
doorbrk1
env_tag (Event Damage) (DamageType Bash Slash) (Health 0 0) (DoorType Wood1Sm Wood2Lg BoxWood Barricade)

//BODY HITS

//head enter the water
schema submerge_head
archetype HIT_BODY
volume -100
dive
env_tag (Event MediaTrans) (MedTransDir Enter) (MediaLevel Head) (Material Liquid)

//Head exit the water
schema surface_head
archetype HIT_BODY
volume -100
surfaceh
env_tag (Event MediaTrans) (MedTransDir Exit) (MediaLevel Head) (Material Liquid)

//Body enter the water
schema splash_player
archetype HIT_BODY
volume -600
splash01
env_tag (Event MediaTrans) (MedTransDir Enter) (MediaLevel Body) (Material Liquid)

//Body exit the water
schema surface_body
archetype HIT_BODY
volume -1
surfaceb
env_tag (Event MediaTrans) (MedTransDir Exit) (MediaLevel Body) (Material Liquid)

schema bodythud
archetype HIT_BODY
thud1

schema douse_far
douse2

schema collapse_player
archetype HIT_BODY
volume -500
collaps1

schema collapse_guards
archetype HIT_BODY
volume -500
collaps2

//BODY COLLAPSING -UNARMORED
schema collapse_soft
archetype HIT_BODY
volume -1000
collaps3

//BODY DROPPED TO GROUND
schema body_drop
archetype HIT_BODY
volume -1000
collaps5 collaps6
env_tag (Event Collision) (CreatureType Ape Guard Haunt Servant) (Material Carpet Earth Gravel Ice Metal Stone Tile Wood)


schema collapse_water
archetype HIT_BODY
collaps4

