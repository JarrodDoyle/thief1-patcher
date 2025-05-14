//THIEF2 ARCHETYPES


//----------AMBIENTS----------//

schema AMBIENTS
audio_class ambient
volume -1

schema AMB_MISC	//Global or other ambients
archetype AMBIENTS
no_repeat

schema AMB_M01	//Interference
archetype AMBIENTS

schema AMB_M02	//Shipping & Receiving
archetype AMBIENTS
	
schema AMB_M03	//Museum -sadly, this is CUT!
archetype AMBIENTS

schema AMB_M04	//Framed
archetype AMBIENTS

schema AMB_M05	//Ambush
archetype AMBIENTS

schema AMB_M06	//Eavesdropping
archetype AMBIENTS

schema AMB_M07	//Bank
archetype AMBIENTS

schema AMB_M08	//Courier
archetype AMBIENTS

schema AMB_M09	//Blackmail
archetype AMBIENTS

schema AMB_M10	//Trail of Blood
archetype AMBIENTS

schema AMB_M11	//Unwelcome Guest
archetype AMBIENTS

schema AMB_M12	//Casing
archetype AMBIENTS

schema AMB_M13	//Masks
archetype AMBIENTS

schema AMB_M14	//Cargo
archetype AMBIENTS

schema AMB_M15	//Kidnap
archetype AMBIENTS

schema AMB_M16	//Endgame
archetype AMBIENTS



//----------SPEECH----------//


schema PLYR_SPEECH
audio_class speech  
volume -500

schema PLYR_EFFORT
archetype PLYR_SPEECH

schema PLYR_DAMAGE
archetype PLYR_SPEECH
no_repeat
volume -1

schema PLYR_SCRIPTED
archetype PLYR_SPEECH
play_once
delay 1000


schema OTHER_SPEECH 	//other 2D speech like Keeper1 from Thief1
audio_class speech  
volume -500


schema AI_SPEECH
no_repeat
audio_class monsters 
volume -1

//SPEECH SOUND VALUE CATEGORIES
schema AI_NONE		//other AIs ignores this
archetype AI_SPEECH

schema AI_INFORM		//AI tells another AI	
archetype AI_SPEECH

schema AI_MINOR		//other AIs go to Alert1
archetype AI_SPEECH

schema AI_MAJOR		//other AIs go to Alert2
archetype AI_SPEECH

schema AI_MORE_MAJOR	//other AIs go to Alert3
archetype AI_SPEECH

schema AI_COMBAT		//other AIs go into Combat mode
archetype AI_SPEECH	

//CONVERSATIONS & MISC SCRIPTED SPEECH
schema AI_CONV		//all conversations
archetype AI_SPEECH


schema AI_SCRIPTED	//mission specific speech
archetype AI_SPEECH
stream


schema KARRAS_SCRIPTED	//KARRAS SPEECH
archetype AI_SPEECH
stream

schema MURUS_SPEECH
archetype AI_SCRIPTED
priority 255

/////////////
//FOOTSTEPS//
/////////////

schema FEET
no_repeat
volume -1

schema FOOT_PLAYER
audio_class player_feet 
archetype FEET

schema LAND_PLAYER
audio_class player_feet 
archetype FEET

schema FOOT_AI
audio_class other_feet
archetype FEET

schema LAND_AI
audio_class other_feet
archetype FEET



schema WEAPONS
audio_class weapons
volume -1

schema PLYR_WEAPON
archetype WEAPONS

schema OTHER_WEAPON
archetype WEAPONS

schema UI_META		//UI, Inventory & Metagame snds
audio_class metaui

//////////////
//COLLISIONS//
//////////////

schema COLLISIONS
no_repeat
audio_class collisions
volume -1

schema HIT_MATERIAL  	//material on material
archetype COLLISIONS

schema HIT_BODY		//bodies on ground/water
archetype COLLISIONS

schema HIT_MELEE		//swords, bjack & hammers
archetype COLLISIONS

schema HIT_PROJECTILE	//arrows
archetype COLLISIONS

schema HIT_EXPLOSION
archetype COLLISIONS


/////////
//DOORS//
/////////

schema DOORS
audio_class noise
volume -1

schema PLYR_DOOR
archetype DOORS

schema PLYR_BOX
archetype DOORS

schema AI_DOOR
archetype DOORS



schema DEVICES
audio_class noise 
volume -1

schema DEVICE_LIFT
archetype DEVICES

schema DEVICE_SWITCH
archetype DEVICES

schema DEVICE_MISC
archetype DEVICES

schema DEVICE_ALARM
audio_class music 
archetype DEVICES


