//BURRICK SPEECH

//AT ALERT LEVEL ZERO
schema BK1a0
archetype AI_NONE
mono_loop 5 150
volume -1000
BK1a0br1 BK1a0br2 BK1a0br3 BK1a0br4
BK1a0sn1 BK1a0ch1 bk1a0ch2
silenc9s silenc3s
schema_voice vburr 1 atlevelzero
schema_voice vburr 1 atlevelone 
schema_voice vburr 1 atleveltwo 
schema_voice vburr 1 atlevelthree

//TO ALERT LEVEL ONE & TWO
schema BK1to1
archetype AI_MINOR
volume -500
BK1to1_1 BK1to1_2 BK1to1_3
schema_voice vburr 1 tolevelone
schema_voice vburr 1 toleveltwo


//AT ALERT LEVEL ONE & TWO
schema BK1a1
archetype AI_MINOR
mono_loop 10 10
volume -750
BK1a1__1 freq 3
BK1a1__2 freq 3
BK1a1__3 freq 3
BK1a1__4 freq 2
BK1a1__5 freq 2
BK1a1br1 freq 4
BK1to1_1 freq 1
BK1to1_2 freq 1
BK1to1_3 freq 1
schema_voice vburr 9 atlevelone (Investigate True)
schema_voice vburr 9 atleveltwo (Investigate True)

//TO ALERT LEVEL THREE
schema BK1to3
archetype AI_MAJOR
volume -1
BK1to3_1 BK1to3_2
schema_voice vburr 1 spotplayer
schema_voice vburr 1 tolevelthree 



//AT ALERT LEVEL THREE
schema BK1a3
archetype AI_MAJOR
mono_loop 10 10
volume -1
BK1a3__1 BK1a3__2 bk1a3__3
schema_voice vburr 1 atlevelthree 
schema_voice vburr 1 reactcharge

//REACT RUN
schema BK1run
archetype AI_MINOR
volume -500
BK1run_1
schema_voice vburr 1 reactrun
schema_voice vburr 1 outofreach

//BACK TO LEVEL ZERO
schema bk1bak
archetype AI_NONE
volume -500
bk1bak_1
schema_voice vburr 1 backtozero

//LOST CONTACT
schema BK1startled
archetype AI_NONE
volume -500
bk1start
schema_voice vburr 1 lostcontact
schema_voice vburr 1 noticetorch

//FOUND BODY
schema BK1bod
archetype AI_MINOR
volume -800
bk1bod_1
schema_voice vburr 1 foundbody

//COMBAT

//ATTACKING
schema bk1att
archetype AI_COMBAT
volume -1
bk1att_1 bk1att_2 bk1att_3
schema_voice vburr 1 comattack

//HIT BY PLAYER W/HI PTS
schema bk1hhi
archetype AI_COMBAT
volume -1
bk1hhi_1 bk1hhi_2
schema_voice vburr 1 comhithigh
schema_voice vburr 1 comhitamb

//HIT BY PLAYER w/LO PTS
schema bk1hlo
archetype AI_COMBAT
volume -1
bk1hlo_1 bk1hlo_2
schema_voice vburr 1 comhitlow

//DEATH
schema bk1die
archetype AI_COMBAT
volume -1
bk1die_1 bk1die_2 bk1die_3
schema_voice vburr 1 comdieloud
schema_voice vburr 1 comdiesoft

//BURPING ATTACK
schema bur_burp
archetype WEAPONS
volume -500
burp5 burp2
env_tag (Event Launch) (LaunchVel 1 1) (CreatureType Burrick) (ArrowType Burp)







