//BUG BEAST

//LAUNCH BUGSHOT
schema fly_launch
volume -1
bb1attsh
env_tag (Event Launch) (LaunchVel 1 1) (ArrowType BugShot)

//BUGSHOT IMPACT
schema fly_death
volume -1
flydeth1 flydeth2 flydeth3
env_tag (Event Death) (ArrowType BugShot)

//AT ALERT 0
schema bb1a0
archetype AI_NONE
volume -1000
mono_loop 500 15000
bb1a0__1 bb1a0__2 bb1a0__3
schema_voice vbug 1 atlevelzero

//BACK TO ZERO
schema bb1bak
archetype AI_MINOR
bb1bak_1 bb1bak_2 bb1bak_3
schema_voice vbug 1 backtozero
schema_voice vbug 1 lostcontact
schema_voice vbug 1 outofreach
schema_voice vbug 1 foundbody
schema_voice vbug 1 noticetorch 

//TO ALERT 1
schema bb1to1
archetype AI_NONE
volume -500
bb1a1__1 bb1a1__2 bb1a1__3 bb1a1__4 bb1a1__5
schema_voice vbug 1 tolevelone


//AT ALERT 1 & 2
schema bb1a1
archetype AI_NONE
mono_loop 500 10000
volume -1000
bb1a1__1 bb1a1__2 bb1a1__3 bb1a1__4 bb1a1__5
schema_voice vbug 1 atlevelone
schema_voice vbug 1 atleveltwo
schema_voice vbug 1 atlevelthree 

//TO ALERT 2 & 3
schema bb1to3
archetype AI_MAJOR
bb1to3_1 bb1to3_2 bb1to3_3 bb1to3_4 bb1to3_5 bb1to3_6
schema_voice vbug 1 toleveltwo
schema_voice vbug 1 spotplayer
schema_voice vbug 1 tolevelthree
schema_voice vbug 1 reactcharge
schema_voice vbug 1 comattack

//AT ALERT 3
schema bb1a3
archetype AI_MINOR
delay 5000
mono_loop 100 3000
bb1a3__1 bb1a3__2 bb1a3__3 bb1a3__4
schema_voice vbug 99 atleveltwo (investigate true)
schema_voice vbug 99 atlevelthree (investigate true)

//HIT WITH HIGH HIT PTS
schema bb1hhi
archetype AI_MINOR
bb1hhi_1 bb1hhi_2 bb1hhi_3
schema_voice vbug 1 comhithigh
schema_voice vbug 1 comhitamb
 
//HIT WITH LOW HIT PTS
schema bb1hlo
archetype AI_MAJOR
bb1hlo_1 bb1hlo_2 bb1hlo_3
schema_voice vbug 1 comhitlow

//DEATH by COMBAT
schema bb1die
archetype AI_MAJOR
bb1die_1 bb1die_2
schema_voice vbug 1 comdieloud

//DEATH by STEALTH
schema bb1die_s
archetype AI_NONE
volume -1000
bb1hhi_1
schema_voice vbug 1 comdiesoft

