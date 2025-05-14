
//AIR ELEMENTAL

schema EAat3
archetype AI_NONE
mono_loop 0 0
volume -2200
elemair1 elemair2 elemair3
schema_voice vair 1 atlevelzero
schema_voice vair 1 atlevelone
schema_voice vair 1 atleveltwo
schema_voice vair 1 atlevelthree



//FIRE ELEMENTAL

//Unaware -Alert Level 0 (and Back to 0)
schema EFa0
archetype AI_NONE
poly_loop 2 2000 4000
volume -1000
EFa01 EFa02 EFa03
schema_voice vfire 1 atlevelzero
schema_voice vfire 1 backtozero

//to Alert Level 1 
schema EFa1
archetype AI_NONE
poly_loop 2 3000 4500
volume -500
EFa11 EFa12 EFa13
schema_voice vfire 1 tolevelone
schema_voice vfire 1 atlevelone

schema EFa2
archetype AI_MINOR
poly_loop 2 3000 4500
volume -900
EFa11 EFa12 EFa13
schema_voice vfire 1 toleveltwo
schema_voice vfire 1 atleveltwo

//to Alert Level 3
schema EFa3
archetype AI_MAJOR
poly_loop 2 3000 4500
volume -300
EFa31 EFa32 EFa33
schema_voice vfire 1 spotplayer   
schema_voice vfire 1 tolevelthree  
schema_voice vfire 1 atlevelthree


//Hit with HI hit pts -hurts
schema EFhithi
archetype AI_COMBAT
volume -1
EFhithi1 EFhithi2
schema_voice vfire 1 comhithigh
schema_voice vfire 1 comhitamb

//Hit with LO hit pts -really hurts
schema EFhitlo
archetype AI_COMBAT
volume -1
EFhitlo1
schema_voice vfire 1 comhitlow

//Death
schema EFdie
archetype AI_COMBAT
volume -1
EFdie1
env_tag (Event Death) (CreatureType ElemFire) 


//Attacking -firing the fireball
schema EFatt
archetype WEAPONS
volume -1
EFatt1 EFatt2
env_tag (Event Launch) (LaunchVel 1 1) (CreatureType ElemFire) (ArrowType Firebolt)






