//ZOMBIE SPEECH

//ZOMBIE 1 -DAN THRON

//AT ALERT 0 
schema zm1a0
archetype AI_NONE
mono_loop 10 12000
volume -500
zm2a0__1 zm2a0__2 zm2a0__3 zm2a0__4 
schema_voice vzombie 3 atlevelzero
schema_voice vzombie 1 atlevelone

//TO ALERT 1, 2, & 3
schema zm1to1
archetype AI_NONE
volume -300
zm2att_2 zm2att_1 
schema_voice vzombie 1 tolevelone  
schema_voice vzombie 1 toleveltwo  
schema_voice vzombie 1 tolevelthree


//AT ALERT 1, 2, & 3
schema zm1a1
archetype AI_NONE
mono_loop 10 1000
volume -250
zm2a1__1 zm2a1__2 zm2a1__3 zm2a1__4
schema_voice vzombie 1 atleveltwo  
schema_voice vzombie 1 atlevelthree  

//BACK TO ZERO
schema zm1bak
archetype AI_NONE
volume -250
zm2atk_1 zm2atk_2 zm2atk_3 zm2atk_4
schema_voice vzombie 1 lostcontact  
schema_voice vzombie 1 backtozero  


//TO ALERT 3
schema zm1to3
archetype AI_NONE
volume -100
zm2att_2 zm2att_4
schema_voice vzombie 1 spotplayer
schema_voice vzombie 1 reactcharge


//COMBAT

//ATTACKING 
schema zm1att
archetype AI_NONE
delay 500
volume -1
zm2atk_1 zm2akt_2 zm2atk_3 zm2atk_4
schema_voice vzombie 1 comattack 

//HIT BY THE PLAYER W/HI HIT PTS 
schema zm1hhi
archetype AI_NONE
volume -1
zm2att_7 zm2att_8 zm2att_9
schema_voice vzombie 1 comhithigh
schema_voice vzombie 1 comhitamb



//HIT BY THE PLAYER W/LO HIT PTS 
schema zm1hlo
archetype AI_NONE
volume -1
zm2att_6 zm2att_5 
schema_voice vzombie 1 comhitlow


//DEATH 
schema zm1die
archetype AI_NONE
volume -1
zm2die_1 zm2die_2
schema_voice vzombie 1 comdieloud
schema_voice vzombiegirl 1 comdieloud

//-----------------------------------------------


//ZOMBIE 2 -CAROLE SIMMS

//AT ALERT 0 
schema zm3a0
archetype AI_NONE
mono_loop 10 12000
volume -500
zm3a0__1 zm3a0__2 zm3a0__3 zm3a0__4 zm3a0__5 zm3a0__6 zm3a0__7 zm3a1__1 zm3a1__2 zm3a1__3
schema_voice vzombiegirl 3 atlevelzero
schema_voice vzombiegirl 1 atlevelone  

//TO ALERT 1, 2, & 3
schema zm3to1
archetype AI_NONE
volume -300
zm3see_1 zm3see_2 zm3see_3 zm3see_4
schema_voice vzombiegirl 1 tolevelone
schema_voice vzombiegirl 1 toleveltwo  
schema_voice vzombiegirl 1 tolevelthree

//AT ALERT 1, 2, & 3
schema zm3a1
archetype AI_NONE
mono_loop 10 1000
volume -250
zm3a3__1 zm3a3__2 zm3a3__3 zm3a3__4 zm3a3__5 zm3a3__6
schema_voice vzombiegirl 1 atleveltwo  
schema_voice vzombiegirl 1 atlevelthree  


schema zm3bak
archetype AI_NONE
volume -250
zm3a1__1 zm3a1__2 zm3a1__3
schema_voice vzombiegirl 1 lostcontact  
schema_voice vzombiegirl 1 backtozero  

//TO ALERT 3
schema zm3to3
archetype AI_NONE
volume -100
zm3atk_1 zm3atk_2 zm3atk_3 zm3see_1 zm3see_2 zm3see_3 zm3see_4
schema_voice vzombiegirl 1 spotplayer
schema_voice vzombiegirl 1 reactcharge


//COMBAT

//ATTACKING 
schema zm3att
archetype AI_NONE
delay 500
volume -1
zm3atk_1 zm3atk_2 zm3atk_3
schema_voice vzombiegirl 1 comattack 

//HIT BY THE PLAYER W/HI HIT PTS 
schema zm3hhi
archetype AI_NONE
volume -1
zm3atk_1 zm3atk_2 zm3atk_3 zm3hhi_1 zm3hhi_2 zm3hhi_3
schema_voice vzombiegirl 1 comhithigh
schema_voice vzombiegirl 1 comhitamb


//HIT BY THE PLAYER W/LO HIT PTS 
schema zm3hlo
archetype AI_NONE
volume -1
zm3see_1 zm3see_2 zm3see_3 zm3see_4
schema_voice vzombiegirl 1 comhitlow





