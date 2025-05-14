//COLLISIONS

////////////////////////////////
//GENERIC MATERIAL ON MATERIAL//
////////////////////////////////

//HIT Ceramic,Glass <--> Ceramic,Glass
schema hcercer
archetype HIT_MATERIAL
no_repeat
hcercer hcercer2
env_tag (Event Collision) (Material Ceramic) (Material2 Ceramic Glass Ice)
env_tag (Event Collision) (Material Glass) (Material2 Glass Ice)

//HIT Ceramic,Glass <--> Carpet,Earth
schema hcerear
archetype HIT_MATERIAL
hcerear
env_tag (Event Collision) (Material Carpet) (Material2 Ceramic Glass Ice Snow)
env_tag (Event Collision) (Material Ceramic) (Material2 Earth Snow)
env_tag (Event Collision) (Material Earth) (Material2 Glass Ice Snow)

//HIT Ceramic,Glass <--> Stone,Tile 
schema hcersto
archetype HIT_MATERIAL
no_repeat
hcersto hcersto2 hcersto3
env_tag (Event Collision) (Material Ceramic Glass Ice) (Material2 Stone Tile)

//HIT Ceramic,Glass <--> Metal 
schema hcermet
archetype HIT_MATERIAL
no_repeat
hcermet hcermet2 
env_tag (Event Collision) (Material Ceramic Glass Ice) (Material2 Metal MetGrate)

//HIT Ceramic,Glass <--> Wood
schema hcerwoo
archetype HIT_MATERIAL
no_repeat
hcerwoo hcerwoo2
env_tag (Event Collision) (Material Ceramic Glass Ice) (Material2 Wood)

//HIT Gravel <--> ALL
schema hgravel
archetype HIT_MATERIAL
no_repeat
hgravel hgravel2
env_tag (Event Collision) (Material Carpet Ceramic Earth Glass Gravel) (Material2 Gravel)
env_tag (Event Collision) (Material Gravel) (Material2 Ice Metal MetGrate Stone Tile Wood)

//HIT Metal <--> Carpet,Earth 
schema hmetear
archetype HIT_MATERIAL
no_repeat
hmetear hmetear2
env_tag (Event Collision) (Material Carpet Earth) (Material2 Metal MetGrate)
env_tag (Event Collision) (Material Metal MetGrate) (Material2 Snow)

//HIT Metal <--> Metal 
schema hmetmet
archetype HIT_MATERIAL
no_repeat
hmetmet hmetmet2 hmetmet3
env_tag (Event Collision) (Material Metal MetGrate) (Material2 Metal MetGrate)

//HIT Metal <--> Stone,Tile
schema hmetsto
archetype HIT_MATERIAL
no_repeat
hmetsto hmetsto2 hmetsto3
env_tag (Event Collision) (Material Metal MetGrate) (Material2 Stone Tile)

//HIT Metal <--> Wood
schema hmetwoo
archetype HIT_MATERIAL
no_repeat
hmetwoo hmetwoo2
env_tag (Event Collision) (Material Metal MetGrate) (Material2 Wood)

//HIT Stone,Tile <--> Carpet,Earth
schema hstoear
archetype HIT_MATERIAL
no_repeat
hstoear hstoear2 
env_tag (Event Collision) (Material Carpet Earth) (Material2 Stone 
Tile)
env_tag (Event Collision) (Material Carpet) (Material2 Earth Snow)

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
env_tag (Event Collision) (Material Carpet Earth Snow) (Material2 Wood)

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
env_tag (Event Collision) (Material Gravel Metal MetGrate Stone Tile) (Material2 Vegetation)
env_tag (Event Collision) (Material Vegetation) (Material2 Wood)

//HIT Water <--> All
schema hwater
archetype HIT_MATERIAL
splash02
env_tag (Event MediaTrans) (Material Carpet Ceramic Earth Glass Gravel Ice) (Material2 Liquid) 
env_tag (Event MediaTrans) (Material Liquid) (Material2 Metal MetGrate Rope Stone Tile Vegetation Wood) 

//HIT Water <--> Small
schema hwatsm
archetype HIT_MATERIAL
hwatsm1 hwatsm2 hwatsm3
env_tag (Event MediaTrans) (Material GlassBits) (Material2 Liquid) 
env_tag (Event MediaTrans) (Material Liquid) (Material2 WoodBits) 

//HIT GlassBits <--> All
schema hglassbits
archetype HIT_MATERIAL
glasbit1 glasbit2 glasbit3 glasbit4 glasbit5
env_tag (Event Collision) (Material Carpet Ceramic Earth Glass) (Material2 GlassBits)
env_tag (Event Collision) (Material GlassBits) (Material2 Gravel Ice Metal MetGrate Snow Stone Tile Vegetation)
env_tag (Event Collision) (Material GlassBits) (Material2 Wood)

//HIT WoodBits <--> All
schema hwoodbits
archetype HIT_MATERIAL
woodbit1 woodbit2 woodbit3 woodbit4 woodbit5
env_tag (Event Collision) (Material Carpet Ceramic Earth Glass Gravel Ice Metal MetGrate) (Material2 WoodBits)
env_tag (Event Collision) (Material Snow Stone Tile Vegetation Wood) (Material2 WoodBits)


////////////////////
//ARROW COLLISIONS//
////////////////////

//Hitting armored person
schema arrow_armor
archetype HIT_PROJECTILE
ar_armr1 ar_armr2
env_tag (Event Collision) (CreatureType Crayman Guard GuardNoKO Haunt) (ArrowType Broadhead Rope Vine) 

//Hitting unarmored person
schema arrow_body
archetype HIT_PROJECTILE
ar_body1 ar_body2
env_tag (Event Collision) (CreatureType Ape Apparition Burrick Frog Rat Servant Spider Zombie) (ArrowType Broadhead Rope Vine) 

schema arrow_rock
archetype HIT_PROJECTILE
no_repeat
volume -1
ar_rock1 ar_rock2 ar_rock3 ar_rock4 ar_rock5
env_tag (Event Collision) (ArrowType Broadhead Rope Vine) (Material Gravel Stone Tile) 

schema arrow_wood
archetype HIT_PROJECTILE
volume -1
ar_wood1 ar_wood2 ar_wood3
env_tag (Event Collision) (ArrowType Broadhead) (Material Wood) 

schema ropearrow_wood
archetype HIT_PROJECTILE
volume -1
ar_rope1 ar_rope2
env_tag (Event Collision) (ArrowType Rope Vine) (Material Wood)

schema arrow_metal
archetype HIT_PROJECTILE
volume -1
no_repeat
ar_met1 ar_met2 ar_met3 ar_met4 ar_met5
env_tag (Event Collision) (ArrowType Broadhead Rope) (Material Metal MetGrate) 
env_tag (Event Collision) (ArrowType Vine) (Material Metal) 

schema arrow_grate		//VINE ARROWS STICK TO METAL GRATES
archetype HIT_PROJECTILE
volume -500
no_repeat
ar_vine1 ar_vine2
env_tag (Event Collision) (ArrowType Vine) (Material MetGrate) 

schema arrow_soft
archetype HIT_PROJECTILE
volume -1
ar_soft
env_tag (Event Collision) (ArrowType Broadhead Rope Vine) (Material Carpet Earth Vegetation) 

//ARROW HITS CERAMIC, GLASS  <--DOESN'T BREAK
schema arrow_ceramic
archetype HIT_PROJECTILE
ar_glas1 ar_glas2 ar_glas3
env_tag (Event Collision) (ArrowType Broadhead Rope Vine) (Material Ceramic Glass) 

//ARROW HITS WATER
schema arrow_water
archetype HIT_PROJECTILE
splash03
env_tag (Event MediaTrans) (MedTransDir Enter) (ArrowType Blowdart Broadhead Rope Vine) (Material Liquid) 
env_tag (Event MediaTrans) (MedTransDir Enter) (CreatureType Rat) (Material Carpet) (Material2 Liquid) 


//---------------------------------------------------------------

//Hitting unarmored person
schema dart_body
archetype HIT_PROJECTILE
ar_body1 ar_body2
env_tag (Event Collision) (CreatureType Ape Crayman Apparition Burrick Frog Guard GuardNoKO Haunt Servant) (ArrowType Blowdart) 
env_tag (Event Collision) (CreatureType Spider Zombie) (ArrowType Blowdart) 

schema dart_rock
archetype HIT_PROJECTILE
no_repeat
volume -1
hdarsto1 hdarsto2 hdarsto3 hdarsto4 hdarsto5 hdarsto6
env_tag (Event Collision) (ArrowType Blowdart) (Material Ceramic Glass Gravel Ice Metal MetGrate Stone Tile) 

schema dart_wood
archetype HIT_PROJECTILE
volume -1
hdarwoo1 hdarwoo2 hdarwoo3 hdarwoo4
env_tag (Event Collision) (ArrowType Blowdart) (Material Wood) 

schema dart_earth
archetype HIT_PROJECTILE
volume -1
hdarear1 hdarear2 hdarear3
env_tag (Event Collision) (ArrowType Blowdart) (Material Carpet Earth Snow) 

//---------------------------------------------------------------

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
env_tag (Event Collision) (ArrowType Firebolt) (CreatureType Ape Apparition Burrick Camera Cherub CombatBot Crayman Frog Guard) 
env_tag (Event Collision) (ArrowType Firebolt) (CreatureType GuardNoKO Haunt Player ScurryBot Servant Spider SpiderBot TreeBeast) 
env_tag (Event Collision) (ArrowType Firebolt) (CreatureType Turret WorkerBot Zombie)

//GasArrow explodes
schema gasarrow_hit
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
delay 1000
volume -1
noisemk4
//FEET: noisemk3 
//ORIG: noisemk1
env_tag (Event Activate) (ArrowType Noisemaker)

//MAGIC MISSILE HITS TERRAIN
schema HIT_magic
archetype HIT_PROJECTILE
hmagic1 hmagic2 hmagic3
env_tag (Event Collision) (ArrowType MagicMissile) (Material Carpet Ceramic Earth Glass Gravel Ice Liquid Metal)
env_tag (Event Collision) (ArrowType MagicMissile) (Material MetGrate MetLadder Rope Stone Tile Vegetation Wood WoodLadder) 

//FIREBOLT HITS THE WALL
schema HIT_firebolt
archetype HIT_PROJECTILE
hstoear2
env_tag (Event Collision) (ArrowType Firebolt)

//GHOST SHOT HIT
schema gs_death
archetype HIT_PROJECTILE
h_gs2 h_gs3
env_tag (Event Death) (ArrowType GhostShot HammerSpell)


//SAWBLADE HIT WALL
schema hit_sawblade
archetype HIT_PROJECTILE
hsawbla1 hsawbla2 hsawbla3 hsawbla4
env_tag (Event Collision) (ArrowType Sawblade) (Material Ceramic Glass Gravel Metal) (Material2 Metal) 
env_tag (Event Collision) (ArrowType Sawblade) (Material Metal) (Material2 MetGrate MetLadder Stone Tile Wood WoodLadder) 





//SEE FIREARROW HITS FOR FIREBOLT HITTING PLAYER


//MAGE FIRE BOLT HIT
//schema HIT_mgfire
//archetype HIT_PROJECTILE
//hmgfire
//env_tag (Event Death) (MageShotType MageFire)

//MAGE WATER SHOT HIT
//schema HIT_mgwater
//archetype HIT_PROJECTILE
//hmgwat1 hmgwat2
//env_tag (Event Death) (MageShotType MageWater)

//MAGE EARTH SHOT HIT -see GARRETT:Damage



//SANDBAG HIT HARD GROUND
//schema sandbag_ground
//archetype HIT_PROJECTILE
//sandbag1 sandbag2
//env_tag (Event Collision) (MageShotType Sandbag) (Material Earth) (Material2 Metal MetGrate Stone Tile Wood)

//SANDBAG ON SOFT GROUND
//schema sandbag_soft
//archetype HIT_PROJECTILE
//sandbag3 sandbag4
//env_tag (Event Collision) (MageShotType Sandbag) (Material Carpet Ceramic Earth) (Material2 Earth)
//env_tag (Event Collision) (MageShotType Sandbag) (Material Earth) (Material2 Flesh Glass Gravel Ice MetLadder WoodLadder Rope)

//SANDBAG HIT WATER
//schema sandbag_water
//archetype HIT_PROJECTILE
//splash02
//env_tag (Event MediaTrans) (MedTransDir Enter) (MageShotType Sandbag) (Material Liquid)



///////////////////
//MACE COLLISIONS//
///////////////////

//Hitting armored person
schema Mace_armor
archetype HIT_MELEE
volume -1
sw_armr1 sw_armr2 sw_armr3 sw_armr4
env_tag (Event Damage) (DamageType Bash) (Damage 1 100) (Health 0 100) (CreatureType Crayman Guard GuardNoKO Haunt) (WeaponType Hammer) 

//Hitting unarmored person
schema Mace_body
archetype HIT_MELEE
volume -1
sw_body1 sw_body2 sw_body3 sw_body4
env_tag (Event Damage) (DamageType Bash) (Damage 1 100) (Health 0 100) (CreatureType Ape Apparition Burrick Frog Servant Spider Zombie) (WeaponType Hammer) 

schema Mace_rock
archetype HIT_MELEE
volume -1
sw_rock1 sw_rock2
env_tag (Event Collision) (WeaponType Hammer) (Material Gravel Stone Tile) 

schema Mace_wood
archetype HIT_MELEE
volume -1
sw_wood1 sw_wood2
env_tag (Event Collision) (WeaponType Hammer) (Material Wood)

schema Mace_metal
archetype HIT_MELEE
sw_met1 sw_met2
env_tag (Event Collision) (WeaponType Hammer) (Material Metal MetGrate) 

schema Mace_soft
archetype HIT_MELEE
sw_soft1 sw_soft2
env_tag (Event Collision) (WeaponType Hammer) (Material Carpet Earth Vegetation) 

schema Mace_sword
archetype HIT_MELEE
volume -1
sw_sw1 sw_sw2 sw_sw3 sw_swp1 sw_swp2
env_tag (Event Collision) (WeaponType Hammer) (WeaponType2 Sword)



////////////////////
//SWORD COLLISIONS//
////////////////////

//Hitting armored person
schema sword_armor
archetype HIT_MELEE
volume -1
sw_armr1 sw_armr2 sw_armr3 sw_armr4
env_tag (Event Damage) (DamageType Slash) (Damage 1 100) (Health 0 100) (CreatureType Crayman Guard GuardNoKO Haunt) (WeaponType Sword)


//Hitting unarmored person
schema sword_body
archetype HIT_MELEE
volume -1
sw_body1 sw_body2 sw_body3 sw_body4
env_tag (Event Damage) (DamageType Slash) (Damage 1 100) (Health 0 100) (CreatureType Ape Apparition Burrick Frog Rat Servant Spider Zombie) (WeaponType Sword)

//Hitting treebeast
schema sword_tree
archetype HIT_MELEE
volume -1
sw_tree1 sw_tree2 sw_tree3
env_tag (Event Damage) (DamageType Slash) (Damage 1 100) (Health 0 100) (CreatureType TreeBeast) (WeaponType Sword)


schema sword_rock
archetype HIT_MELEE
volume -1
sw_rock1 sw_rock2
env_tag (Event Collision) (WeaponType Blackjack Sword) (Material Gravel Stone Tile) 

schema sword_wood
archetype HIT_MELEE
volume -1
sw_wood1 sw_wood2
env_tag (Event Collision) (WeaponType Blackjack Sword) (Material Wood) 

schema sword_metal
archetype HIT_MELEE
sw_met1 sw_met2
env_tag (Event Collision) (WeaponType Blackjack Sword) (Material Metal MetGrate) 

schema sword_soft
archetype HIT_MELEE
sw_soft1 sw_soft2
env_tag (Event Collision) (WeaponType Blackjack Sword) (Material Carpet Earth Vegetation) 

//SWORD & HAMMER HITS CERAMIC, GLASS  <--DOESN'T BREAK
schema sword_ceramic
archetype HIT_PROJECTILE
sw_glas1 sw_glas2
env_tag (Event Collision) (WeaponType Blackjack Sword Hammer) (Material Ceramic Glass) 

//SWORD & HAMMER HITS CERAMIC, ICE  <--DOESN'T BREAK
schema sword_ice
archetype HIT_PROJECTILE
sw_ice1 sw_ice2 sw_ice3
env_tag (Event Collision) (WeaponType Blackjack Sword Hammer) (Material Ice Snow) 
env_tag (Event Collision) (ArrowType Broadhead Rope Vine) (Material Ice Snow) 

schema sword_sword
archetype HIT_MELEE
volume -1
sw_sw1 sw_sw2 sw_sw3 sw_swp1 sw_swp2
env_tag (Event Collision) (WeaponType Sword) (WeaponType2 Sword)

//SWORD HITS HARP
schema sword_harp
archetype HIT_PROJECTILE
sw_harp
env_tag (Event Collision) (WeaponType Blackjack Sword Hammer) (MachType Harp) (Material Wood)

////////////////////////
//BLACKJACK COLLISIONS//
////////////////////////

//Hitting person
schema bjack_flesh
archetype HIT_MELEE
volume -1
bj_body1
env_tag (Event Collision) (CreatureType Ape Crayman Apparition Burrick Frog Guard Haunt Servant Spider) (WeaponType Blackjack) 
env_tag (Event Collision) (CreatureType Zombie) (WeaponType Blackjack) 

//Hitting Non-blackjackble
schema bjack_armor
archetype HIT_MELEE
volume -1
bj_helm1 bj_helm2
env_tag (Event Collision) (CreatureType Camera Cherub CombatBot GuardNoKO Turret WorkerBot) (WeaponType Blackjack) 


//FIST ON ALL MATERIALS
schema Fist_all
archetype HIT_MELEE
volume -1
fist1 fist2 fist3
env_tag (Event Collision) (WeaponType Fist) (Material Carpet Ceramic Earth Glass Gravel Ice Metal MetGrate) 
env_tag (Event Collision) (WeaponType Fist) (Material Snow Stone Tile Vegetation Wood) 

//SWORD ON FIST
schema sw_fist
archetype HIT_MELEE
volume -1
sw_fist1 sw_fist2
env_tag (Event Collision) (WeaponType Fist) (WeaponType2 Sword)

//SWORD ON CLAW
schema sw_claw
archetype HIT_MELEE
volume -1
sw_claw1 sw_claw2
env_tag (Event Collision) (WeaponType Claw) (WeaponType2 Sword)



/////////////////////
//THINGS THAT BREAK//
/////////////////////

//CERAMIC BREAKS
schema break_ceramic
archetype HIT_EXPLOSION
message gotonoise
brkvase1 ar_vase
env_tag (Event Death) (DamageType Bash Slash Poke Fire) (Material Ceramic) 

//WINDOW BREAKS
schema break_glass
archetype HIT_EXPLOSION
message gotonoise
brkglas1 brkglas2 brkglas3 brkglas4
env_tag (Event Death) (Material Glass) 

//ICICLE BREAKS
schema break_ice
archetype HIT_EXPLOSION
volume -500
brkice1 brkice2 brkice3
env_tag (Event Death) (Material Ice) 

//DOOR DAMAGE
schema doorwood_dam1
archetype HIT_MELEE
volume -500
doordam1 doordam2 doordam3 empty
env_tag (Event Damage) (DamageType Bash Slash) (Damage 5 100) (Health 50 79) (DoorType Wood1sm Wood2lg BoxWood Barricade) 

schema doorwood_dam2
archetype HIT_MELEE
doordam4 doordam5 doordam6
env_tag (Event Damage) (DamageType Bash Slash) (Damage 5 100) (Health 1 49) (DoorType Wood1Sm Wood2Lg BoxWood Barricade)

schema doorwood_break
archetype HIT_EXPLOSION
volume -500
doorbrk1
env_tag (Event Damage) (DamageType Bash Slash) (Damage 1 100) (Health 0 0) (DoorType Wood1Sm Wood2Lg BoxWood Barricade)

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
env_tag (Event Collision) (CreatureType Ape Guard GuardNoKO Haunt Servant) (Material Carpet Earth Gravel Ice Metal Stone Tile Wood)
env_tag (Event Collision) (CreatureType Ape Guard GuardNoKO Haunt Servant) (Material Vegetation)

//BODY DROPPED INTO WATER
schema collapse_water
archetype HIT_BODY
collaps4
env_tag (Event MediaTrans) (MedTransDir Enter) (CreatureType Ape Guard GuardNoKO Haunt Servant) (Material Liquid) 

