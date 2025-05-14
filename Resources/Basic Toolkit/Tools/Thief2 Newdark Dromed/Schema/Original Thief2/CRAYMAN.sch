//CRAYMAN SPEECH

//AT ALERT LEVEL ZERO
schema CR1a0
archetype AI_NONE
mono_loop 10 3000
volume -1000
cr1a0__1 cr1a0__2 cr1a0__3 cr1a0__4
cr1a0__5 cr1a0__6 cr1a0__7
silenc3s
schema_voice vcray 1 atlevelzero
schema_voice vcray 1 backtozero

//TO ALERT LEVEL ONE & TWO
schema CR1to1
archetype AI_MINOR
volume -500
cr1to1_1 cr1to1_2
schema_voice vcray 1 tolevelone
schema_voice vcray 1 toleveltwo
schema_voice vcray 1 lostcontact
schema_voice vcray 1 noticetorch


//AT ALERT LEVEL ONE & TWO
schema CR1a1
archetype AI_MINOR
poly_loop 1 3000 3500
volume -750
cr1a1__1 cr1a1__2 cr1a1__3 cr1a1__4
schema_voice vcray 1 atlevelone
schema_voice vcray 1 atleveltwo

//TO ALERT LEVEL THREE
schema CR1to3
archetype AI_MAJOR
volume -100
cr1to3_1
schema_voice vcray 1 spotplayer
schema_voice vcray 1 tolevelthree
schema_voice vcray 1 foundbody


//REACT CHARGE
schema CR1chg
archetype AI_MORE_MAJOR
volume -100
cr1hlo_1 cr1hlo_2
schema_voice vcray 1 reactcharge
schema_voice vcray 1 outofreach

//AT LEVEL 3
schema CR1a3
archetype AI_MORE_MAJOR
poly_loop 2 2500 2800
volume -100
cr1a3__1 cr1a3__2 cr1a3__3
schema_voice vcray 1 atlevelthree


//ATTACKING
schema CR1att
archetype AI_COMBAT
volume -100
cr1to3_1
schema_voice vcray 1 comattack


//HIT BY PLAYER w/LO PTS
schema cr1hlo
archetype AI_COMBAT
volume -1
cr1hlo_1 cr1hlo_2
schema_voice vcray 1 comhitlow
schema_voice vcray 1 comhithigh
schema_voice vcray 1 comhitamb


//DEATH
schema cr1die
archetype AI_COMBAT
volume -1
cr1die_1
schema_voice vcray 1 comdieloud
schema_voice vcray 1 comdiesoft









