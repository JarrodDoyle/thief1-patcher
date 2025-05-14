//FEET

////////////////////
//PLAYER FOOTSTEPS//
////////////////////

schema foot_carpet_p   
archetype FOOT_PLAYER
volume -2800  //was -2400
ftcar_p1 ftcar_p2 ftcar_p3 ftcar_p4 
env_tag (Event Footstep) (CreatureType Player) (Material Carpet) 

schema foot_dirt_p
archetype FOOT_PLAYER
volume -1500  //was -2000
ftdir_p1 ftdir_p2 ftdir_p3 ftdir_p4 
env_tag (Event Footstep) (CreatureType Player) (Material Earth Vegetation) 

schema foot_gravel_p
archetype FOOT_PLAYER
volume -667  //was -1000
ftgra_p1 ftgra_p2 ftgra_p3 ftgra_p4
env_tag (Event Footstep) (CreatureType Player) (Material Gravel) 

schema foot_rock_p
archetype FOOT_PLAYER
volume -1200 //was -1800
ftroc_p1 ftroc_p2 ftroc_p3 ftroc_p4
env_tag (Event Footstep) (CreatureType Player) (Material Stone)

schema foot_wood_p
archetype FOOT_PLAYER
volume -600 //was -1000
ftwoo_p1 freq 2
ftwoo_p2 freq 1
ftwoo_p3 freq 2
ftwoo_p4 freq 2
env_tag (Event Footstep) (CreatureType Player) (Material Wood)

schema foot_tile_p
archetype FOOT_PLAYER
volume -300  //was -500
fttil_p1 fttil_p2 fttil_p3 fttil_p4
env_tag (Event Footstep) (CreatureType Player) (Material Ceramic Glass Tile)

schema foot_metal_p
archetype FOOT_PLAYER
volume -500  //was -750
ftmet_p1 ftmet_p2 ftmet_p3 ftmet_p4
env_tag (Event Footstep) (CreatureType Player) (Material Metal) 

schema foot_water_p
archetype FOOT_PLAYER
volume -1200
ftwat_1 ftwat_2 ftwat_3 ftwat_4
env_tag (Event Footstep) (MediaLevel Foot) (CreatureType Player) (Material Liquid)
 

//////////////////////////////
//PLAYER LANDING FROM A JUMP//
//////////////////////////////

schema land_carpet_p
archetype LAND_PLAYER
volume -1600  // was -1000
ftcar_j
env_tag (Event Footstep) (Landing True) (CreatureType Player) (Material Carpet)

schema land_dirt_p
archetype LAND_PLAYER
volume -500  //was -375
ftdir_j
env_tag (Event Footstep) (Landing True) (CreatureType Player) (Material Earth Vegetation) 

schema land_gravel_p
archetype LAND_PLAYER
volume -350  //was -500
ftgra_j
env_tag (Event Footstep) (Landing True) (CreatureType Player) (Material Gravel) 

schema land_rock_p
archetype LAND_PLAYER
volume -500
ftroc_j
env_tag (Event Footstep) (Landing True) (CreatureType Player) (Material Stone) 

schema land_tile_p
archetype LAND_PLAYER
volume -150
fttil_j
env_tag (Event Footstep) (Landing True) (CreatureType Player) (Material Ceramic Glass Tile) 

schema land_wood_p
archetype LAND_PLAYER
volume -250
ftwoo_j
env_tag (Event Footstep) (Landing True) (CreatureType Player) (Material Wood) 

schema land_metal_p
archetype LAND_PLAYER
volume -375
ftmet_j
env_tag (Event Footstep) (Landing True) (CreatureType Player) (Material Metal) 

schema land_water_p
archetype LAND_PLAYER
volume -500
ftwat_j
env_tag (Event Footstep) (Landing True) (CreatureType Player) (MediaLevel Foot) (Material Liquid)


////////////////
//AI FOOTSTEPS//
////////////////

schema foot_carpet_a
archetype FOOT_AI
volume -1000  //was -1325
ftcar_a1 ftcar_a2 ftcar_a3 ftcar_a4
env_tag (Event Footstep) (CreatureType Apparition Guard Servant) (Material Carpet)

schema foot_dirt_a
archetype FOOT_AI
volume -800 //was -1000
ftdir_a1 ftdir_a2 ftdir_a3 ftdir_a4
env_tag (Event Footstep) (CreatureType Apparition Guard Servant) (Material Earth Vegetation) 

schema foot_gravel_a
archetype FOOT_AI
volume -500  //was -667
ftgra_a1 ftgra_a2 ftgra_a3 ftgra_a4
env_tag (Event Footstep) (CreatureType Apparition Guard Servant) (Material Gravel) 

schema foot_rock_a
archetype FOOT_AI
volume -500   //was -667
ftroc_a1 ftroc_a2 ftroc_a3 ftroc_a4
env_tag (Event Footstep) (CreatureType Apparition Guard Servant) (Material Stone)
 
schema foot_wood_a
archetype FOOT_AI
volume -400  //was -667
ftwoo_a1 ftwoo_a2 ftwoo_a3 ftwoo_a4
env_tag (Event Footstep) (CreatureType Apparition Guard Servant) (Material Wood) 

schema foot_tile_a
archetype FOOT_AI
volume -1  //was -200
fttil_a1 fttil_a2 fttil_a3 fttil_a4 
env_tag (Event Footstep) (CreatureType Apparition Guard Servant) (Material Ceramic Glass Tile) 

schema foot_metal_a
archetype FOOT_AI
volume -100  //was -250
ftmet_a1 ftmet_a2 ftmet_a3 ftmet_a4
env_tag (Event Footstep) (CreatureType Apparition Guard Servant) (Material Metal)
 
schema foot_water_a
archetype FOOT_AI
volume -1000
ftwat_1 ftwat_2 ftwat_3 ftwat_4
env_tag (Event Footstep) (MediaLevel Foot) (CreatureType Apparition Guard Servant) (Material Liquid)

//////////////////////////
//AI LANDING FROM A JUMP//
//////////////////////////

schema land_carpet_a
archetype LAND_AI
volume -500  // was -1000
ftcar_j
env_tag (Event Footstep) (Landing True) (CreatureType Apparition Guard Servant) (Material Carpet)

schema land_dirt_a
archetype LAND_AI
volume -250  //was -500
ftdir_j
env_tag (Event Footstep) (Landing True) (CreatureType Apparition Guard Servant) (Material Earth Vegetation) 

schema land_gravel_a
archetype LAND_AI
volume -175  //was -375
ftgra_j
env_tag (Event Footstep) (Landing True) (CreatureType Apparition Guard Servant) (Material Gravel) 

schema land_rock_a
archetype LAND_AI
volume -500
ftroc_j
env_tag (Event Footstep) (Landing True) (CreatureType Apparition Guard Servant) (Material Stone) 

schema land_tile_a
archetype LAND_AI
volume -150
fttil_j
env_tag (Event Footstep) (Landing True) (CreatureType Apparition Guard Servant) (Material Ceramic Glass Tile) 

schema land_wood_a
archetype LAND_AI
volume -250
ftwoo_j
env_tag (Event Footstep) (Landing True) (CreatureType Apparition Guard Servant) (Material Wood) 

schema land_metal_a
archetype LAND_AI
volume -375
ftmet_j
env_tag (Event Footstep) (Landing True) (CreatureType Apparition Guard Servant) (Material Metal) 

schema land_water_a
archetype LAND_AI
volume -750  //was -1500
ftwat_j
env_tag (Event Footstep) (Landing True) (CreatureType Ape Apparition Burrick Crayman Frog Guard Haunt) (MediaLevel Foot) (Material Liquid)
env_tag (Event Footstep) (Landing True) (CreatureType Servant Spider Zombie) (MediaLevel Foot) (Material Liquid)


///////////////////////////////////
//CREATURES' FOOTSTEPS & LANDINGS//
///////////////////////////////////

//BURRICK
schema foot_burrick
archetype FOOT_AI
volume -1000  //was -1500
ft_bur1 ft_bur2 ft_bur3 ft_bur4
env_tag (Event Footstep) (CreatureType Burrick)
env_tag (Event Footstep) (CreatureType Burrick) (Landing True)

//HAUNT
schema foot_haunt
archetype FOOT_AI
volume -750  //was -2200
ft_hh1 ft_hh2 ft_hh3 ft_hh4
env_tag (Event Footstep) (CreatureType Haunt)
env_tag (Event Footstep) (CreatureType Haunt) (Landing True)

//ZOMBIE
schema foot_zombie
archetype FOOT_AI
volume -1500  //was -1800
ft_zomb1 ft_zomb2 ft_zomb3 ft_zomb4
env_tag (Event Footstep) (CreatureType Zombie)
env_tag (Event Footstep) (CreatureType Zombie) (Landing True)

//CRAYMAN
schema foot_crayman
archetype FOOT_AI
volume -1500 //was -2000
ft_cray1 ft_cray2 ft_cray3 ft_cray4
env_tag (Event Footstep) (CreatureType Crayman)
env_tag (Event Footstep) (CreatureType Crayman) (Landing True)

//SPIDERS
schema foot_spider
archetype FOOT_AI
volume -800  //was -1200
ft_spid1 ft_spid2 ft_spid3 ft_spid4
env_tag (Event Footstep) (CreatureType Spider)
env_tag (Event Footstep) (CreatureType Spider) (Landing True)

//APE BEASTS
schema foot_ape
archetype FOOT_AI
volume -800  //was -1200
no_repeat
ft_ape1 ft_ape2
env_tag (Event Footstep) (CreatureType Ape)

schema land_ape
archetype LAND_AI
volume -800  //was -1200
ft_ape1
env_tag (Event Footstep) (CreatureType Ape) (Landing True)

//FROG BEASTS
schema foot_frog
archetype FOOT_AI
volume -1500
ft_frog1 ft_frog2 ft_frog3 ft_frog4
env_tag (Event Footstep) (CreatureType Frog)
env_tag (Event Footstep) (CreatureType Frog) (Landing True)

//CON TRICKSTER
schema foot_con
archetype FOOT_AI
volume -500
ft_con1 ft_con2 ft_con3 ft_con4
env_tag (Event Footstep) (CreatureType Contrick)
env_tag (Event Footstep) (CreatureType ConTrick) (Landing True)

///////////////////
//OTHER FOOTSTEPS//
///////////////////

//SLIDING ON ICE
schema foot_ice
archetype FEET
volume -2000
ft_ice1 ft_ice2 ft_ice3 ft_ice4
env_tag (Event Footstep) (CreatureType Apparition Guard Servant Player) (Material Ice)
env_tag (Event Footstep) (Landing True) (CreatureType Apparition Guard Servant Player) (Material Ice) 

//SWIMMING (TECHNICALLY A FOOTSTEP)
schema swim_surface
archetype FEET
volume -1500
swimtop1 swimtop2 swimtop3
env_tag (Event Footstep) (MediaLevel Body) (Material Liquid)

schema swim_underwater
archetype FEET
volume -1500
stroke1 stroke2 stroke3
env_tag (Event Footstep) (MediaLevel Head) (Material Liquid)

//MOSS ARROW FUNGUS
schema foot_fungus
archetype FEET
volume -2000  //was -2600
ft_fung1 ft_fung2 ft_fung3 ft_fung4
env_tag (Event Footstep) (Fungus True) (CreatureType Apparition Ape Burrick Crayman Frog) (Material Carpet Ceramic Earth Glass Gravel Metal Stone Tile)
env_tag (Event Footstep) (Fungus True) (CreatureType Guard Haunt Player Servant Spider Zombie) (Material Carpet Ceramic Earth Glass Gravel Metal Stone Tile)
env_tag (Event Footstep) (Fungus True) (CreatureType Apparition Ape Burrick Crayman Frog) (Material Wood Vegetation)
env_tag (Event Footstep) (Fungus True) (CreatureType Guard Haunt Player Servant Spider Zombie) (Material Wood Vegetation)
env_tag (Event Footstep) (Fungus True) (Landing True) (CreatureType Apparition Ape Burrick Crayman Frog) (Material Carpet Ceramic Earth Glass Gravel Metal Stone Tile)
env_tag (Event Footstep) (Fungus True) (Landing True) (CreatureType Guard Haunt Player Servant Spider Zombie) (Material Carpet Ceramic Earth Glass Gravel Metal Stone Tile)
env_tag (Event Footstep) (Fungus True) (Landing True) (CreatureType Apparition Ape Burrick Crayman Frog) (Material Wood Vegetation)
env_tag (Event Footstep) (Fungus True) (Landing True) (CreatureType Guard Haunt Player Servant Spider Zombie) (Material Wood Vegetation)

//CLIMBING A ROPE
schema climb_rope
archetype WEAPONS
volume -700
ropecrk1 ropecrk2 ropecrk3 ropecrk4
env_tag (Event Climbstep) (CreatureType Player) (Material Rope)

//CLIMBING A LADDER
schema climb_ladder
volume -400
no_repeat
ladder1 ladder2 ladder3 ladder4 ladder5
env_tag (Event Climbstep) (CreatureType Player) (Material Ladder)