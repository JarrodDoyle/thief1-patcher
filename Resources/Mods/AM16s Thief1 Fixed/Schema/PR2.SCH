//PRISONER 2

//ALERT 0 
schema pr2a0co
archetype AI_NONE
mono_loop 3000 15000
pr2a0co1 pr2a0co2 pr2a0co3 pr2a0co4
pr2a0mu1 pr2a0mu2 pr2a0mu3
schema_voice pris2 1 atlevelzero

schema pr2a0mo
archetype AI_NONE
mono_loop 3000 15000
pr2a0mo1 pr2a0mo2 pr2a0mo3
pr2a0so1 pr2a0so2 pr2a0so3
schema_voice pris2 1 atlevelzero

//to Alert Level 1
schema PR2a1
archetype AI_NONE
pr2a1__1 pr2a1__2
schema_voice pris2 1 tolevelone

//to Alert Level 2
schema PR2a2
archetype AI_MINOR
pr2a2__1 pr2a2__2
schema_voice pris2 1 toleveltwo

//to Alert Level 3
schema PR2a3
archetype AI_MAJOR
pr2a3__1 pr2a3__2 pr2a3__3
schema_voice pris2 1 tolevelthree
schema_voice pris2 1 spotplayer

//Back to Alert Level 1
schema PR2bak
archetype AI_NONE
pr2bak_1 pr2bak_2
schema_voice pris2 1 backtozero

//Death cries
schema PR2die
archetype AI_MAJOR
pr2diea1 pr2diec1
schema_voice pris2 1 comdieloud
schema_voice pris2 1 comdiesoft

//Injured yelps
schema PR2hhi
archetype AI_MAJOR
pr2hhi_1 pr2hhi_2
schema_voice pris2 1 comhithigh
schema_voice pris2 1 comhitamb

//Injured yelps
schema PR2hlo
archetype AI_MAJOR
pr2hlo_1 pr2hlo_2
schema_voice pris2 1 comhitlow

