//HERMIT under the Opera House

//AT ALERT 0
schema hmtat0
archetype AI_NONE
no_repeat
mono_loop 100 2000
hmt12100 hmt12101 hmt12102 hmt12103 hmt12104 hmta0co1 hmta0co2 hmta0co3 hmta0co4 hmta0co5 hmta0hu1 hmta0hu2 hmta0hu3 hmta0si1 hmta0si2 hmta0si3 
schema_voice vhermit 1 atlevelzero
schema_voice vhermit 1 atlevelone
schema_voice vhermit 1 atleveltwo
schema_voice vhermit 1 atlevelthree

//TO ALERT 1
schema hmtto1
archetype AI_NONE
hmta1__1 hmtbak_1
schema_voice vhermit 1 tolevelone  

//TO ALERT 1 +Sense Sound
schema hmtto1h
archetype AI_NONE
hmta1h_1 
schema_voice vhermit 1 tolevelone (Sense Sound)

//TO ALERT 1 +Sense Sight
schema hmtto1v
archetype AI_NONE
hmta1v_1
schema_voice vhermit 1 tolevelone (Sense Sight)

//BACK TO ZERO
schema hmtbak
archetype AI_NONE
hmta0co3
schema_voice vhermit 1 backtozero

//TO ALERT 2
schema hmtto2
archetype AI_MINOR
hmta2__1
schema_voice vhermit 1 toleveltwo

//TO ALERT 3
schema hmtto3
archetype AI_MAJOR
hmta3__1
schema_voice vhermit 1 tolevelthree
schema_voice vhermit 1 spotplayer


//HIT BY THE PLAYER -SOFT
schema hmthhi
archetype AI_MINOR
hmthhi_1 hmthhi_2
schema_voice vhermit 1 comhithigh

//HIT BY THE PLAYER -HARD
schema hmthlo
archetype AI_MAJOR
hmthlo_1 hmthlo_2 hmthlo_3 hmthlo_4
schema_voice vhermit 1 comhitlow

//DEATH
schema hmtdie
archetype AI_NONE
hmtdie
schema_voice vhermit 1 comdieloud
schema_voice vhermit 1 comdiesoft


//SPECIAL SPEECH -all one long .wav file
schema hmt12200
archetype AI_NONE
play_once
hmt12200
schema_voice vhermit 1 hmt12200

//SPECIAL SPEECH -cut up into shorter files
schema hmt12201
archetype OTHER_CONV
hmt12201
schema_voice vhermit 1 hmt122 (LineNo 1 1)

schema hmt12202
archetype OTHER_CONV
hmt12202
schema_voice vhermit 1 hmt122 (LineNo 2 2)

schema hmt12203
archetype OTHER_CONV
hmt12203
schema_voice vhermit 1 hmt122 (LineNo 3 3)

schema hmt12204
archetype OTHER_CONV
hmt12204
schema_voice vhermit 1 hmt122 (LineNo 4 4)

schema hmt12205
archetype OTHER_CONV
hmt12205
schema_voice vhermit 1 hmt122 (LineNo 5 5)






