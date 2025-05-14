
//////////
//SPEECH//
//////////

schema AI_SPEECH
no_repeat
audio_class speech
volume -1

schema PLAYER_SPEECH
volume -500

schema PLAYER_HITS
archetype PLAYER_SPEECH
volume -1

//SPEECH SOUND VALUE CATEGORIES
schema AI_NONE
archetype AI_SPEECH

schema AI_INFORM
archetype AI_SPEECH

schema AI_MINOR
archetype AI_SPEECH

schema AI_MAJOR
archetype AI_SPEECH

schema AI_MORE_MAJOR
archetype AI_SPEECH

schema AI_COMBAT
archetype AI_SPEECH

schema CON_SPEECH
archetype AI_SPEECH
no_cache
priority 255

//CONVERSATIONS & MISC SCRIPTED THINGS
schema SV_CONV
archetype AI_NONE

schema HM_CONV
archetype AI_NONE

schema SG_CONV
archetype AI_NONE

schema OTHER_CONV
archetype AI_NONE

schema MURUS_SPEECH
archetype AI_NONE
priority 255

////////////
//AMBIENTS//
////////////

schema AMB
audio_class ambient
volume -1

schema AMB_M01	//Training
archetype AMB

schema AMB_M02	//Bafford
archetype AMB
	
schema AMB_M03	//Prison
archetype AMB

schema AMB_M04	//Bonehoard
archetype AMB

schema AMB_M05	//Assassin
archetype AMB

schema AMB_M06	//Sword
archetype AMB

schema AMB_M07	//Haunted Cathedral
archetype AMB

schema AMB_M09	//Lost City
archetype AMB

schema AMB_M10	//Undercover
archetype AMB

schema AMB_M11	//Return to Cathedral
archetype AMB

schema AMB_M12	//Escape
archetype AMB

schema AMB_M13	//Strange Bedfellows
archetype AMB

schema AMB_M14	//Maw of Chaos
archetype AMB

schema AMB_M15	//Thieves' Guild
archetype AMB

schema AMB_M16	//Mages' Tower
archetype AMB

schema AMB_M17	//Opera House
archetype AMB

schema AMB_D15	//DEMO -Thieves' Guild
archetype AMB


/////////////
//FOOTSTEPS//
/////////////

schema FEET
no_repeat
volume -1

schema FOOT_PLAYER
archetype FEET

schema LAND_PLAYER
archetype FEET

schema FOOT_AI
audio_class noise
archetype FEET


schema LAND_AI
audio_class noise
archetype FEET

schema WEAPONS
audio_class noise
volume -1

//////////////
//COLLISIONS//
//////////////

schema COLLISIONS
audio_class noise
volume -1

schema HIT_MATERIAL  	//material on material
archetype COLLISIONS

schema HIT_BODY		//bodies on ground/water
archetype COLLISIONS

schema HIT_WEAPON		//swords, bjack & hammers
archetype COLLISIONS

schema HIT_PROJECTILE	//arrows
archetype COLLISIONS

/////////
//DOORS//
/////////

schema DOORS
audio_class noise
volume -1

schema PLAYER_DOOR
archetype DOORS

schema AI_DOOR
archetype DOORS

schema DEVICES
audio_class noise
volume -1

