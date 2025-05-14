//ZOMBIE SPEECH

//AT ALERT 0 
schema zm1a0
archetype AI_NONE
mono_loop 10 12000
volume -500
zm2a0__1 zm2a0__2 zm2a0__3 zm2a0__4 
schema_voice vzomb 3 atlevelzero
schema_voice vzomb 1 backtozero  

//TO ALERT 1, 2, & 3
schema zm1to1
archetype AI_NONE
volume -300
zm2att_2 zm2att_1 
schema_voice vzomb 1 tolevelone  
schema_voice vzomb 1 toleveltwo  
schema_voice vzomb 1 tolevelthree

//AT ALERT 1, 2, & 3
schema zm1a1
archetype AI_NONE
mono_loop 10 1000
volume -250
zm2a1__1 zm2a1__2 zm2a1__3 zm2a1__4
schema_voice vzomb 1 atlevelone  
schema_voice vzomb 1 atleveltwo  
schema_voice vzomb 1 atlevelthree  
schema_voice vzomb 1 lostcontact  

//TO ALERT 3
schema zm1to3
archetype AI_NONE
volume -100
zm2att_2 zm2att_4
schema_voice vzomb 1 spotplayer
schema_voice vzomb 1 reactcharge


//COMBAT

//ATTACKING 
schema zm1att
archetype AI_NONE
delay 500
volume -1
zm2atk_1 zm2akt_2 zm2atk_3 zm2atk_4
schema_voice vzomb 1 comattack 

//HIT BY THE PLAYER W/HI HIT PTS 
schema zm1hhi
archetype AI_NONE
volume -1
zm2att_7 zm2att_8 zm2att_9
schema_voice vzomb 1 comhithigh
schema_voice vzomb 1 comhitamb



//HIT BY THE PLAYER W/LO HIT PTS 
schema zm1hlo
archetype AI_NONE
volume -1
zm2att_6 zm2att_5 
schema_voice vzomb 1 comhitlow


//DEATH 
schema zm1die
archetype AI_NONE
volume -1
zm2die_1 zm2die_2
schema_voice vzomb 1 comdieloud

//ZOMBIE PART SPLATS
schema zombie_splat
archetype COLLISIONS
volume -1
stabbody splat1 splat2 splat3
env_tag (Event Collision) (Material2 ZombiePart)  

//ZOMBIE EXPLODES
schema exp_zombie
archetype COLLISIONS
volume -1
expzom1 expzom2
env_tag (Event Death) (CreatureType Zombie) (DamageType Fire Holy)




