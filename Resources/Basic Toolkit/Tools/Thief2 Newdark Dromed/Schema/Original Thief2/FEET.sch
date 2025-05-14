//FEET

////////////////////
//PLAYER FOOTSTEPS//
////////////////////

schema foot_carpet_p   
archetype FOOT_PLAYER
no_repeat
volume -2800  
ftcar_p1 ftcar_p2 ftcar_p3 ftcar_p4 
env_tag (Event Footstep) (CreatureType Player) (Material Carpet) 

schema foot_dirt_p
archetype FOOT_PLAYER
no_repeat
volume -1500  
ftdir_p1 ftdir_p2 ftdir_p3 ftdir_p4 
env_tag (Event Footstep) (CreatureType Player) (Material Earth Vegetation) 

schema foot_gravel_p
archetype FOOT_PLAYER
no_repeat
volume -667  
ftgra_p1 ftgra_p2 ftgra_p3 ftgra_p4
env_tag (Event Footstep) (CreatureType Player) (Material Gravel) 

schema foot_rock_p
archetype FOOT_PLAYER
no_repeat
volume -1200 
ftroc_p1 ftroc_p2 ftroc_p3 ftroc_p4
env_tag (Event Footstep) (CreatureType Player) (Material Stone)

schema foot_wood_p
archetype FOOT_PLAYER
no_repeat
volume -600 
ftwoo_p1 freq 2
ftwoo_p2 freq 1
ftwoo_p3 freq 2
ftwoo_p4 freq 2
env_tag (Event Footstep) (CreatureType Player) (Material Wood)

schema foot_tile_p
archetype FOOT_PLAYER
no_repeat
volume -300  
fttil_p1 fttil_p2 fttil_p3 fttil_p4
env_tag (Event Footstep) (CreatureType Player) (Material Ceramic Glass Tile)

schema foot_metal_p
archetype FOOT_PLAYER
no_repeat
volume -500 
ftmet_p1 ftmet_p2 ftmet_p3 ftmet_p4
env_tag (Event Footstep) (CreatureType Player) (Material Metal MetGrate) 

schema foot_water_p
archetype FOOT_PLAYER
no_repeat
volume -1200
ftwat_1 ftwat_2 ftwat_3 ftwat_4
env_tag (Event Footstep) (MediaLevel Foot) (CreatureType Player) (Material Liquid)

schema foot_snow_p
archetype FOOT_PLAYER
no_repeat
volume -1500 
ftsnow1 ftsnow2 ftsnow3 ftsnow4
env_tag (Event Footstep) (CreatureType Player) (Material Ice Snow) 
env_tag (Event Footstep) (Landing True) (CreatureType Player) (Material Ice Snow)  

//////////////////////////////
//PLAYER LANDING FROM A JUMP//
//////////////////////////////

schema land_carpet_p
archetype LAND_PLAYER
volume -1600  
ftcar_j
env_tag (Event Footstep) (Landing True) (CreatureType Player) (Material Carpet)

schema land_dirt_p
archetype LAND_PLAYER
volume -500  
ftdir_j
env_tag (Event Footstep) (Landing True) (CreatureType Player) (Material Earth Vegetation) 

schema land_gravel_p
archetype LAND_PLAYER
volume -350  
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
env_tag (Event Footstep) (Landing True) (CreatureType Player) (Material Metal MetGrate) 

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
volume -1000  
ftcar_a1 ftcar_a2 ftcar_a3 ftcar_a4
env_tag (Event Footstep) (CreatureType Apparition Guard GuardNoKO Servant) (Material Carpet)

schema foot_dirt_a
archetype FOOT_AI
volume -800 
ftdir_a1 ftdir_a2 ftdir_a3 ftdir_a4
env_tag (Event Footstep) (CreatureType Apparition Guard GuardNoKO Servant) (Material Earth Vegetation) 

schema foot_gravel_a
archetype FOOT_AI
volume -500  
ftgra_a1 ftgra_a2 ftgra_a3 ftgra_a4
env_tag (Event Footstep) (CreatureType Apparition Guard GuardNoKO Servant) (Material Gravel) 

schema foot_rock_a
archetype FOOT_AI
volume -500   
ftroc_a1 ftroc_a2 ftroc_a3 ftroc_a4
env_tag (Event Footstep) (CreatureType Apparition Guard GuardNoKO Servant) (Material Stone)
 
schema foot_wood_a
archetype FOOT_AI
volume -400  
ftwoo_a1 ftwoo_a2 ftwoo_a3 ftwoo_a4
env_tag (Event Footstep) (CreatureType Apparition Guard GuardNoKO Servant) (Material Wood) 

schema foot_tile_a
archetype FOOT_AI
volume -1  
fttil_a1 fttil_a2 fttil_a3 fttil_a4 
env_tag (Event Footstep) (CreatureType Apparition Guard GuardNoKO Servant) (Material Ceramic Glass Tile) 

schema foot_metal_a
archetype FOOT_AI
volume -100  
ftmet_a1 ftmet_a2 ftmet_a3 ftmet_a4
env_tag (Event Footstep) (CreatureType Apparition Guard GuardNoKO Servant) (Material Metal MetGrate)
 
schema foot_water_a
archetype FOOT_AI
volume -1000
ftwat_1 ftwat_2 ftwat_3 ftwat_4
env_tag (Event Footstep) (MediaLevel Foot) (CreatureType Ape Apparition Burrick Frog Guard GuardNoKO Haunt Servant) (Material Liquid)
env_tag (Event Footstep) (MediaLevel Foot) (CreatureType TreeBeast Zombie) (Material Liquid)

//////////////////////////
//AI LANDING FROM A JUMP//
//////////////////////////

schema land_carpet_a
archetype LAND_AI
volume -500  
ftcar_j
env_tag (Event Footstep) (Landing True) (CreatureType Apparition Guard GuardNoKO Servant) (Material Carpet)

schema land_dirt_a
archetype LAND_AI
volume -250  
ftdir_j
env_tag (Event Footstep) (Landing True) (CreatureType Apparition Guard GuardNoKO Servant) (Material Earth Vegetation) 

schema land_gravel_a
archetype LAND_AI
volume -175  
ftgra_j
env_tag (Event Footstep) (Landing True) (CreatureType Apparition Guard GuardNoKO Servant) (Material Gravel) 

schema land_rock_a
archetype LAND_AI
volume -500
ftroc_j
env_tag (Event Footstep) (Landing True) (CreatureType Apparition Guard GuardNoKO Servant) (Material Stone) 

schema land_tile_a
archetype LAND_AI
volume -150
fttil_j
env_tag (Event Footstep) (Landing True) (CreatureType Apparition Guard GuardNoKO Servant Zombie) (Material Ceramic Glass Tile) 

schema land_wood_a
archetype LAND_AI
volume -250
ftwoo_j
env_tag (Event Footstep) (Landing True) (CreatureType Apparition Guard GuardNoKO Servant) (Material Wood) 

schema land_metal_a
archetype LAND_AI
volume -375
ftmet_j
env_tag (Event Footstep) (Landing True) (CreatureType Apparition Guard GuardNoKO Servant) (Material Metal MetGrate) 

schema land_water_a
archetype LAND_AI
volume -750  //was -1500
ftwat_j
env_tag (Event Footstep) (Landing True) (CreatureType Ape Apparition Burrick Frog Guard GuardNoKO Haunt Servant) (MediaLevel Foot) (Material Liquid)
env_tag (Event Footstep) (Landing True) (CreatureType TreeBeast Zombie) (MediaLevel Foot) (Material Liquid)

schema foot_snow_a
archetype FOOT_AI
volume -500 
ftsnow1 ftsnow2 ftsnow3 ftsnow4
env_tag (Event Footstep) (CreatureType Ape Apparition Burrick Guard GuardNoKO Servant Zombie) (Material Ice Snow) 
env_tag (Event Footstep) (Landing True) (CreatureType Ape Apparition Burrick Guard GuardNoKO Servant Zombie) (Material Ice Snow)  



///////////////////////////////////
//CREATURES' FOOTSTEPS & LANDINGS//
///////////////////////////////////

//APE BEASTS
schema foot_ape
archetype FOOT_AI
volume -800  
no_repeat
ft_ape1 ft_ape2
env_tag (Event Footstep) (CreatureType Ape)

schema land_ape
archetype LAND_AI
volume -800  
ft_ape1
env_tag (Event Footstep) (CreatureType Ape) (Landing True)

//BURRICK
schema foot_cherub
archetype FOOT_AI
no_repeat
volume -1800
ft_chrb1 ft_chrb2 ft_chrb3 ft_chrb4
env_tag (Event Footstep) (CreatureType Cherub)
env_tag (Event Footstep) (CreatureType Cherub) (Landing True)

//BURRICK
schema foot_burrick
archetype FOOT_AI
volume -1000  //was -1500
ft_bur1 ft_bur2 ft_bur3 ft_bur4
env_tag (Event Footstep) (CreatureType Burrick)
env_tag (Event Footstep) (CreatureType Burrick) (Landing True)


//COMBATBOT FOOT
schema foot_combot
archetype FOOT_AI
volume -400
ft_cb1 ft_cb2 ft_cb3 ft_cb4
env_tag (Event Footstep) (CreatureType CombatBot)
env_tag (Event Footstep) (CreatureType CombatBot) (Landing True)

//COMBATBOT FOOT METAL
schema foot_combotmet
archetype FOOT_AI
volume -300
ft_cb1m ft_cb2m ft_cb3m ft_cb4m
env_tag (Event Footstep) (CreatureType CombatBot) (Material Metal MetGrate)
env_tag (Event Footstep) (CreatureType CombatBot) (Landing True) (Material Metal MetGrate)

//FROG BEASTS HOPPING
schema foot_frog
archetype FOOT_AI
volume -1500
ft_frog1 ft_frog2 ft_frog3 ft_frog4
env_tag (Event Footstep) (CreatureType Frog)
env_tag (Event Footstep) (CreatureType Frog) (Landing True)

//HAMMER HAUNT FEET [chains rattling]
schema foot_haunt
archetype FOOT_AI
volume -750  //was -2200
ft_hh1 ft_hh2 ft_hh3 ft_hh4
env_tag (Event Footstep) (CreatureType Haunt)
env_tag (Event Footstep) (CreatureType Haunt) (Landing True)

//SPIDERS
schema foot_spider
archetype FOOT_AI
volume -800  
ft_spid1 ft_spid2 ft_spid3 ft_spid4
env_tag (Event Footstep) (CreatureType Spider)
env_tag (Event Footstep) (CreatureType Spider) (Landing True)

//SPIDERBOT FOOT
schema foot_spidbot
archetype FOOT_AI
volume -400
ft_sb1 ft_sb2 ft_sb3 ft_sb4
env_tag (Event Footstep) (CreatureType SpiderBot)
env_tag (Event Footstep) (CreatureType SpiderBot) (Landing True)

//TREEBEAST FOOT
schema foot_tree
archetype FOOT_AI
no_repeat
volume -1
ft_tree1 ft_tree2 ft_tree3 ft_tree4 ft_tree5 ft_tree6 ft_tree7 ft_tree8
env_tag (Event Footstep) (CreatureType TreeBeast)
env_tag (Event Footstep) (CreatureType TreeBeast) (Landing True)

//WORKERBOT FOOT
schema foot_workbot
archetype FOOT_AI
volume -550
ft_wb1 ft_wb2 ft_wb3 ft_wb4
env_tag (Event Footstep) (CreatureType WorkerBot)
env_tag (Event Footstep) (CreatureType WorkerBot) (Landing True)

//WORKERBOT FOOT METAL
schema foot_workbotmet
archetype FOOT_AI
volume -450
ft_wb1m ft_wb2m ft_wb3m ft_wb4m
env_tag (Event Footstep) (CreatureType WorkerBot) (Material Metal MetGrate)
env_tag (Event Footstep) (CreatureType WorkerBot) (Landing True) (Material Metal MetGrate)

//ZOMBIE
schema foot_zombie
archetype FOOT_AI
volume -1500  
ft_zomb1 ft_zomb2 ft_zomb3 ft_zomb4
env_tag (Event Footstep) (CreatureType Zombie)
env_tag (Event Footstep) (CreatureType Zombie) (Landing True)


//-------------------------------------------------------------


///////////////////
//OTHER FOOTSTEPS//
///////////////////

//SLIDING ON ICE
schema foot_ice
archetype FOOT_PLAYER
no_repeat
volume -2000
ft_ice1 ft_ice2 ft_ice3 ft_ice4
env_tag (Event Footstep) (CreatureType Apparition Guard Servant Player) (Material Ice)
env_tag (Event Footstep) (Landing True) (CreatureType Apparition Guard Servant Player) (Material Ice) 

//SWIMMING (TECHNICALLY A FOOTSTEP)
schema swim_surface
archetype FOOT_PLAYER
no_repeat
pan_range 1000
volume -1500
swimtop1 swimtop2 swimtop3
env_tag (Event Footstep) (MediaLevel Body) (Material Liquid)

schema swim_underwater
archetype FOOT_PLAYER
pan_range 3000
no_repeat
volume -2500
stroke1 stroke2 stroke3
env_tag (Event Footstep) (MediaLevel Head) (Material Liquid)

//MOSS ARROW FUNGUS
schema foot_fungus
archetype FOOT_PLAYER
volume -2000  //was -2600
ft_fung1 ft_fung2 ft_fung3 ft_fung4
env_tag (Event Footstep) (Fungus True) (CreatureType Apparition Ape Burrick Frog) (Material Carpet Ceramic Earth Glass Gravel Metal MetGrate Stone)
env_tag (Event Footstep) (Fungus True) (CreatureType Guard Haunt Player Servant Spider Zombie) (Material Carpet Ceramic Earth Glass Gravel Metal MetGrate Stone)
env_tag (Event Footstep) (Fungus True) (CreatureType Apparition Ape Burrick Frog) (Material Tile Wood Vegetation)
env_tag (Event Footstep) (Fungus True) (CreatureType Guard Haunt Player Servant Spider Zombie) (Material Tile Wood Vegetation)
env_tag (Event Footstep) (Fungus True) (Landing True) (CreatureType Apparition Ape Burrick Frog) (Material Carpet Ceramic Earth Glass Gravel Metal MetGrate Stone)
env_tag (Event Footstep) (Fungus True) (Landing True) (CreatureType Guard Haunt Player Servant Spider Zombie) (Material Carpet Ceramic Earth Glass Gravel Metal MetGrate Stone)
env_tag (Event Footstep) (Fungus True) (Landing True) (CreatureType Apparition Ape Burrick Frog) (Material Tile Wood Vegetation)
env_tag (Event Footstep) (Fungus True) (Landing True) (CreatureType Guard Haunt Player Servant Spider Zombie) (Material Tile Wood Vegetation)
env_tag (Event Collision) (Fungus True) (Material Carpet Ceramic Earth Flesh Glass Gravel Ice Metal) (Material2 Carpet Ceramic Earth Flesh Glass Gravel Ice Metal)
env_tag (Event Collision) (Fungus True) (Material Carpet Ceramic Earth Flesh Glass Gravel Ice Metal) (Material2 MetGrate MetLadder Rope Stone Tile Vegetation Wood WoodLadder)
env_tag (Event Collision) (Fungus True) (Material MetGrate MetLadder Rope Stone Tile Vegetation Wood WoodLadder) (Material2 MetGrate MetLadder Rope Stone Tile Vegetation Wood WoodLadder ZombiePart)



//CLIMBING A ROPE
schema climb_rope
archetype FOOT_PLAYER
volume -700
ropecrk1 ropecrk2 ropecrk3 ropecrk4
env_tag (Event Climbstep) (CreatureType Player) (Material Rope)

//CLIMBING A METAL LADDER
schema climb_ladder
archetype FOOT_PLAYER
volume -100
no_repeat
ladderm1 ladderm2 ladderm3 ladderm4 ladderm5
env_tag (Event Climbstep) (CreatureType Player) (Material MetLadder)

//CLIMBING A WOOD LADDER
schema climb_wdladder
archetype FOOT_PLAYER
volume -100
no_repeat
ladderw1 ladderw2 ladderw3 ladderw4 ladderw5 ladderw6 ladderw7 ladderw8
env_tag (Event Climbstep) (CreatureType Player) (Material WoodLadder)