//FROG BEAST

//FROG EXPLOSION
schema exp_frog
archetype COLLISIONS
volume -1
expfrog2 expfrog
env_tag (Event Death) (CreatureType Frog)


//AT STEADY STATE LEVELS
schema fb1a0
archetype AI_NONE
mono_loop 1000 20000
volume -500
fb1a0__1 fb1a0__2 fb1a0__3
schema_voice vfrog 1 atlevelzero
schema_voice vfrog 1 atlevelone
schema_voice vfrog 1 atleveltwo
schema_voice vfrog 1 atlevelthree

//TRANS TO OTHER LEVELS
schema fb1to1
archetype AI_NONE
fb1to1_1
schema_voice vfrog 1 tolevelone
schema_voice vfrog 1 toleveltwo
schema_voice vfrog 1 tolevelthree
schema_voice vfrog 1 spotplayer

//ATTACKING
schema fb1att
archetype AI_MINOR
fb1att_1 fb1att_2
schema_voice vfrog 1 comattack

//HURT
schema fb1hhi
archetype AI_MINOR
fb1hhi_1 fb1hhi_2
schema_voice vfrog 1 comhithigh
schema_voice vfrog 1 comhitlow
schema_voice vfrog 1 comhitamb





