//RATS SPEECH


//AT ALERT 0, 1 & 2
schema ratat0
archetype AI_NONE
no_repeat
mono_loop 100 5000
volume -2000
rata0_1 rata0_2 rata0_3 rata0_4 rata0_5 rata0_6 rata0_7
schema_voice vrat 1 atlevelzero
schema_voice vrat 1 atlevelone
schema_voice vrat 1 atleveltwo


//TO ALERT 1 & 2
schema ratto1
archetype AI_NONE
no_repeat
volume -2000
rata0_1 rata0_2 rata0_3 rata0_4 rata0_5 rata0_6 rata0_7
schema_voice vrat 1 tolevelone  
schema_voice vrat 1 toleveltwo 
schema_voice vrat 1 lostcontact  
schema_voice vrat 1 backtozero  

//TO ALERT 3
schema ratto3
archetype AI_NONE
no_repeat
volume -1400
rata3_1 rata3_2 rata3_3 rata3_4 rata3_5
schema_voice vrat 1 tolevelthree
schema_voice vrat 1 spotplayer
schema_voice vrat 1 reactrun  
schema_voice vrat 1 atleveltwo  
schema_voice vrat 1 atlevelthree 

//DEATH 
schema ratdie
archetype AI_NONE
no_repeat
volume -1000
ratdie_1 ratdie_2 ratdie_3 ratdie_4 ratdie_5
env_tag (Event Death) (CreatureType Rat)

//-----------------------------------------------




