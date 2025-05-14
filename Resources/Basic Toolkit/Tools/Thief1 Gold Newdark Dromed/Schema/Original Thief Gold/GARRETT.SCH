//GARRETT

/////////////////
//EFFORT GRUNTS//
/////////////////

//Starting to mantel, climb or jump
schema garclimb
archetype PLAYER_SPEECH
garclim1 garclim2 garclim3

//End of mantelling
schema garclimbend
archetype PLAYER_SPEECH
garbrea1 garbrea2

//STRAINING WHILE HOLDING BOW OR SWORD TOO LONG
schema garstrain
archetype PLAYER_SPEECH
volume -1500
garstrn1 garstrn2

//SWORD AUTO PUT DOWN SIGH
schema garsigh
archetype PLAYER_SPEECH
garsigh

//EFFORT GRUNT -OVERHEAD SWORD SWING
schema gargrunt
archetype PLAYER_SPEECH
volume -1500
gargrun1 gargrun2 empty
env_tag (Event Motion) (CreatureType Player) (PlyrSword 1 1) (PlyrSwordSwing 2 2)

//WRONG WARD IN MISS11
schema garhmmm
archetype PLAYER_SPEECH
garhmmm garm1103
env_tag (Event Reject) (Operation Keyfit) (WardType AirWard EarthWard FireWard WaterWard)

//PICKUP BODY
schema garlift
archetype PLAYER_SPEECH
volume -1300
garpick1 garpick2

//DROP BODY
schema gardrop
archetype PLAYER_SPEECH
volume -1300
gardrop1

//SWORD PULL BACK
schema garsword
archetype PLAYER_SPEECH
volume -1500
garswrd1 garswrd2 garswrd3

/////////////////
//TAKING DAMAGE//
/////////////////


//SMALL BASH
schema ghbash_sm
archetype PLAYER_HITS
volume -1
no_repeat
garoof_1 garoof_2 garoof_3 garoof_4
env_tag (Event Damage) (DamageType Bash Knockout Poke) (Damage 5 19) (Health 11 100) (CreatureType Player)

//MED BASH 
schema ghbash_med
archetype PLAYER_HITS
volume -1
no_repeat
garhhi_1 garhhi_2 garhhi_3 garhhi_4
env_tag (Event Damage) (DamageType Bash Knockout Poke Holy) (Damage 20 39) (Health 11 100) (CreatureType Player)
env_tag (Event Damage) (DamageType Bash Knockout Poke Holy) (Damage 5 19) (Health 21 50) (CreatureType Player)

//LARGE BASH
schema ghbash_lg
archetype PLAYER_HITS
volume -1
no_repeat
garhlo_1 garhlo_2 garhlo_3
env_tag (Event Damage) (DamageType Bash Knockout Poke Holy) (Damage 40 100) (Health 1 100) (CreatureType Player)
env_tag (Event Damage) (DamageType Bash Knockout Poke Holy) (Damage 20 39) (Health 1 50) (CreatureType Player)
env_tag (Event Damage) (DamageType Bash Knockout Poke Holy) (Damage 5 19) (Health 1 20) (CreatureType Player)

//SMALL FIRE DAMAGE
schema garfire_sm
archetype PLAYER_HITS
volume -1
no_repeat
garfire3 garfire4 garfire5
env_tag (Event Damage) (DamageType Fire) (Damage 5 69) (Health 30 100) (CreatureType Player)

//LARGE FIRE DAMAGE
schema garfire
archetype PLAYER_HITS
volume -1
no_repeat
garfire
env_tag (Event Damage) (DamageType Fire) (Damage 5 69) (Health 1 29) (CreatureType Player)
env_tag (Event Damage) (DamageType Fire) (Damage 70 100) (Health 1 100) (CreatureType Player)






//TAKING HAMMER DAMAGE
schema ghhammer_sm
archetype PLAYER_HITS
volume -1
no_repeat
ghhammr1 ghhammr2 ghhammr3 ghhammr4
env_tag (Event Damage) (DamageType Bash Knockout) (Damage 5 39) (Health 11 100) (CreatureType Player) (WeaponType FakeTalisman Hammer)

schema ghhammer_lg
archetype PLAYER_HITS
volume -1
no_repeat
ghhammr5 ghhammr6 ghhammr7 ghhammr8
env_tag (Event Damage) (DamageType Bash Knockout)  (Damage 5 39) (Health 1 50) (CreatureType Player) (WeaponType FakeTalisman Hammer)
env_tag (Event Damage) (DamageType Bash Knockout)  (Damage 40 100) (Health 1 100) (CreatureType Player) (WeaponType FakeTalisman Hammer)


//TAKING SWORD DAMAGE
schema ghsword_sm
archetype PLAYER_HITS
volume -1
no_repeat
ghsword1 ghsword2 ghsword3 ghsword4
env_tag (Event Damage) (DamageType Slash) (Damage 5 39) (Health 11 100) (CreatureType Player) (WeaponType Sword)

schema ghsword_lg
archetype PLAYER_HITS
volume -1
no_repeat
ghsword5 ghsword6 ghsword7 ghsword8
env_tag (Event Damage) (DamageType Slash) (Damage 5 39) (Health 1 50) (CreatureType Player) (WeaponType Sword)
env_tag (Event Damage) (DamageType Slash) (Damage 40 100) (Health 1 100) (CreatureType Player) (WeaponType Sword)


//TAKING ARROW DAMAGE
schema gharrow
archetype PLAYER_HITS
volume -1
no_repeat
gharrow1 gharrow2 gharrow3
env_tag (Event Damage) (DamageType Poke) (Damage 5 100) (Health 1 100) (CreatureType Player) (ArrowType Broadhead)


//TAKING BUGPOKE DAMAGE
schema ghbugpoke
archetype PLAYER_HITS
volume -1
no_repeat
ghbugpk1 ghbugpk2 ghbugpk3
env_tag (Event Damage) (DamageType Poke) (Damage 5 100) (Health 1 100) (CreatureType Player) (ArrowType BugShot)

//TAKING ZAP DAMAGE
schema ghmagic
archetype PLAYER_HITS
volume -1
no_repeat
ghmagic1 ghmagic2 ghmagic3
env_tag (Event Damage) (DamageType Zap) (Damage 5 100) (Health 1 100) (CreatureType Player) (ArrowType MagicMissile)

//TAKING FIREBOLT DAMAGE
schema ghfirebolt
archetype PLAYER_HITS
volume -1
no_repeat
ghhammr5 ghhammr6 ghhammr7 ghhammr8
env_tag (Event Damage) (DamageType Fire) (Damage 5 100) (Health 1 100) (CreatureType Player) (ArrowType Firebolt)

//TAKING MISC PROJECTILE DAMAGE
schema ghprojectile
archetype PLAYER_HITS
volume -1
no_repeat
garhhi_1 garhhi_2 garhhi_3 garhhi_4
env_tag (Event Damage) (DamageType Bash Knockout Poke Holy) (Damage 5 100) (Health 1 100) (CreatureType Player) (ArrowType GhostShot HammerSpell Web)

//TAKING MAGE WATER & AIR DAMAGE
schema ghmagebolt
archetype PLAYER_HITS
volume -1
ghhammr2 Ghhammr7
env_tag (Event Damage) (DamageType Slash) (Damage 5 100) (Health 1 100) (CreatureType Player) (MageShotType MageExp)
env_tag (Event Damage) (DamageType Concussion) (Damage 5 100) (Health 1 100) (CreatureType Player) 

//TAKING MAGE EARTH DAMAGE
schema ghmageearth
archetype PLAYER_HITS
ghmgear1 ghmgear2 ghmgear3 ghmgear4 ghmgear5 ghmgear6 ghmgear7 ghmgear8
env_tag (Event Damage) (DamageType Bash) (Damage 5 100) (Health 1 100) (CreatureType Player) (MageShotType MageEarth)


//TAKING STENCH DAMAGE
schema ghstench_sm
archetype PLAYER_SPEECH
garcoug1 garcoug2
env_tag (Event Damage) (DamageType Stench) (Health 70 100) (CreatureType Player)

schema ghstench_med
archetype PLAYER_SPEECH
gargag1 gargag2 gargag3 
env_tag (Event Damage) (DamageType Stench) (Health 40 69) (CreatureType Player)

schema ghstench_lg
archetype PLAYER_SPEECH
garhack1 garhack2 garhack3 
env_tag (Event Damage) (DamageType Stench) (Health 1 39) (CreatureType Player)

//Drowing
schema gar_drown
archetype PLAYER_SPEECH
gardrow1 gardrow2 gardrow3 gardrow4 gardrow5
env_tag (Event Damage) (DamageType Water) (Damage 5 100) (CreatureType Player)


//DEATH SOFT -DROWNING, GAGGING, MAGEEARTH 
schema gardeath1
archetype PLAYER_HITS
volume -1
gardie1 gardie2
env_tag (Event Damage) (CreatureType Player) (DamageType Water Knockout Stench Holy) (Damage 1 100) (Health 0 0)
env_tag (Event Damage) (CreatureType Player) (DamageType Bash) (Damage 1 100) (Health 0 0) (MageShotType MageEarth)


//DEATH BY FIRE
schema gardeath2
archetype PLAYER_HITS
volume -1
garfire
env_tag (Event Damage) (CreatureType Player) (DamageType Fire) (Damage 1 100) (Health 0 0)

//DEATH LOUD -IMPACTS
schema gardeath3
archetype PLAYER_HITS
volume -1
garfire1 garfire2
env_tag (Event Damage) (CreatureType Player) (DamageType Bash Concussion Slash Poke Zap) (Damage 1 100) (Health 0 0)





/////////////////
//GLOBAL SPEECH//
/////////////////

//Tries to open an impossible-to-open door inside
schema gar001
archetype PLAYER_SPEECH
gar001 gar100 gar101 gar102 gar103

//Tries to open a locked door that can only be opened with a key
schema gar002
archetype PLAYER_SPEECH
gar002
	
//Tries to open a locked door that could be opened with either a key or lockpick:  
schema gar003
archetype PLAYER_SPEECH
gar003

//Successfully picks a lock:  
schema gar004
archetype PLAYER_SPEECH
gar004

//First time you focus on a container:
schema gar005
archetype PLAYER_SPEECH
play_once
gar005

//If the player tries to jump up onto a ledge which is too high to mantle:
schema gar006
archetype PLAYER_SPEECH
gar006

//First time you find a crystal:
schema gar007
archetype PLAYER_SPEECH
play_once
gar007

//First time you find a non-crystal power-up:
schema gar008
archetype PLAYER_SPEECH
play_once
gar008

//Upon firing a rope-arrow into a non-wood surface: 
schema gar009
archetype PLAYER_SPEECH
play_once
gar009

//First time you find loot:  
schema gar010
archetype PLAYER_SPEECH
play_once
gar010

//First time you pick up loot worth over some amount:  
schema gar011
archetype PLAYER_SPEECH
play_once
gar011

//First time you select a fire arrow:  
schema gar012
archetype PLAYER_SPEECH
play_once
gar012

//First time you select a water arrow:
schema gar013
archetype PLAYER_SPEECH
play_once
gar013

//First time you select a moss arrow:  
schema gar014
archetype PLAYER_SPEECH
play_once
gar014

//Now the bow will shoot gas arrows.
schema gar015
archetype PLAYER_SPEECH
play_once
gar015

//Various lines about stealth:
schema gar016
archetype PLAYER_SPEECH
gar016

schema gar017
archetype PLAYER_SPEECH
gar017

schema gar018
archetype PLAYER_SPEECH
gar018

schema gar019
archetype PLAYER_SPEECH
gar019

schema gar020
archetype PLAYER_SPEECH
gar020

schema gar021
archetype PLAYER_SPEECH
gar021

schema gar022
archetype PLAYER_SPEECH
gar022

schema gar023
archetype PLAYER_SPEECH
gar023

schema gar024
archetype PLAYER_SPEECH
gar024

schema gar025
archetype PLAYER_SPEECH
gar025

//At an early closed door
schema gar026
archetype PLAYER_SPEECH
play_once
gar026

//Combat -using the blackjack
schema gar027
archetype PLAYER_SPEECH
play_once
gar027

//Combat -removing the body
schema gar028
archetype PLAYER_SPEECH
gar028

//When Garrett is in melee combat with more than two enemies at once, and his health goes below 25%: 
schema gar029
archetype PLAYER_SPEECH
gar029

//Using an arrow
schema gar030
archetype PLAYER_SPEECH
play_once
gar030

//After your first fire arrow shot:  
schema gar031
archetype PLAYER_SPEECH
play_once
gar031

//After your first water arrow shot:  
schema gar032
archetype PLAYER_SPEECH
play_once
gar032

//After your first moss arrow shot:  
schema gar033
archetype PLAYER_SPEECH
play_once
gar033

//Upon firing a rope-arrow into a floor:
schema gar034
archetype PLAYER_SPEECH
play_once
gar034

//After the first splash that makes a certain amount of noise:  
schema gar035
archetype PLAYER_SPEECH
gar035

//When the air-meter first gets below 50%: 
schema gar036
archetype PLAYER_SPEECH
play_once
gar036

//When the air-meter first gets below 90%:  
schema gar037
archetype PLAYER_SPEECH
play_once
gar037

//I'll never make any headway against this current.
schema gar038
archetype PLAYER_SPEECH
play_once
gar038

//Barrels like these can provide good cover in a pinch.
schema gar039
archetype PLAYER_SPEECH
play_once
gar039

//Crates like these are useful for concealment.
schema gar040
archetype PLAYER_SPEECH
play_once
gar040

//First time a key is centered: 
schema gar041
archetype PLAYER_SPEECH
play_once
gar041

//Hm.  Not so secret anymore, is it?
schema gar042
archetype PLAYER_SPEECH
gar042

//Walking on tile
schema gar043
archetype PLAYER_SPEECH
play_once
gar043

//Walking on metal
schema gar044
archetype PLAYER_SPEECH
play_once
gar044

//I have a bad feeling about this
schema gar045
archetype PLAYER_SPEECH
play_once
gar045

//Hmmm…this looks interesting.
schema gar046
archetype PLAYER_SPEECH
gar046

//I wonder what happened here.
schema gar047
archetype PLAYER_SPEECH
gar047

//Looks like this hasn't worked in years.
schema gar048
archetype PLAYER_SPEECH
gar048

//I wonder how I can get up there?
schema gar049
archetype PLAYER_SPEECH
gar049

/Hm.  There must be a way down there.
schema gar050
archetype PLAYER_SPEECH
gar050

//Tries to open an impossible door outside (like a house)
schema gar104
archetype PLAYER_SPEECH
gar104

//Non-functional device
schema gar110
archetype PLAYER_SPEECH
gar110 gar111

//Crate or barrel that isn't a container
schema gar120
archetype PLAYER_SPEECH
gar120 gar121


///////////////////////////
//MISSION SPECIFIC SPEECH//
///////////////////////////


//MISSION 1 -TRAINING

//GARRETT-FINAL: 
schema GARTR001
archetype PLAYER_SPEECH
delay 1000
play_once
GARM0101

//MISSION 2 -BAFFORD

//AT ENTRANCE
schema garm0201
archetype PLAYER_SPEECH
play_once
garm0201

//AT THE WELL HOUSE
schema garm0202
archetype PLAYER_SPEECH
play_once
garm0202

//BASEMENT ENTRANCE
schema garm0203
archetype PLAYER_SPEECH
play_once
garm0203

//GUY FACING AWAY AT DOCKS
schema garm0204
archetype PLAYER_SPEECH
play_once
garm0204

//AFTER TAKING SOMEONE OUT INSIDE
schema garm0205
archetype PLAYER_SPEECH
play_once
garm0205

//LIBRARY
schema garm0206
archetype PLAYER_SPEECH
delay 1500
play_once
garm0206

//GETTING LOOT
schema garm0207
archetype PLAYER_SPEECH
delay 1000
play_once
garm0207

//THORNE ROOM
schema garm0208
archetype PLAYER_SPEECH
play_once
delay 1200
garm0208

//SCEPTRE
schema garm0209
archetype PLAYER_SPEECH
play_once
garm0209


//MISSION 3 -HAMMER PRISON

//CONVERSATION WITH CUTTY
schema garc0101
archetype PLAYER_SPEECH
garc0101

schema garc0103
archetype PLAYER_SPEECH
garc0103

//OLD MISSION 3 STUFF
schema GA1V0301
archetype PLAYER_SPEECH
play_once
GARM0301

schema GA1V0302 
archetype PLAYER_SPEECH
play_once
GARM0302

schema GA1V0303 
archetype PLAYER_SPEECH
delay 1000
play_once
GARM0303

schema GA1V0304
archetype PLAYER_SPEECH
play_once
GARM0304  

schema GA1V0305 
archetype PLAYER_SPEECH
play_once
GARM0305 

schema GA1V0306
archetype PLAYER_SPEECH
play_once
GARM0306

schema GA1V0307
archetype PLAYER_SPEECH
play_once
GARM0307

schema GA1V0308
archetype PLAYER_SPEECH
play_once
GARM0308

schema GA1V0309
archetype PLAYER_SPEECH
play_once
GARM0309

schema GA1V0310
archetype PLAYER_SPEECH
play_once
GARM0310

schema GA1V0311
archetype PLAYER_SPEECH
play_once
GARM0311

schema GA1V0312
archetype PLAYER_SPEECH
play_once
GARM0312

schema GA1V0313
archetype PLAYER_SPEECH
play_once
GARM0313

schema GA1V0314
archetype PLAYER_SPEECH
play_once
GARM0314

schema GA1V0315
archetype PLAYER_SPEECH
play_once
GARM0315

schema GA1V0316
archetype PLAYER_SPEECH
play_once
GARM0316

schema GA1V0317
archetype PLAYER_SPEECH
play_once
GARM0317

schema GA1V0318
archetype PLAYER_SPEECH
play_once
GARM0318

schema GA1V0319
archetype PLAYER_SPEECH
play_once
GARM0319

schema GA1V0320
archetype PLAYER_SPEECH
play_once
GARM0320

schema GA1V0321 
archetype PLAYER_SPEECH
play_once
GARM0321

schema GA1V0322
archetype PLAYER_SPEECH
play_once
GARM0322

schema GA1V0323
archetype PLAYER_SPEECH
play_once
GARM0323

schema GA1V0324
archetype PLAYER_SPEECH
play_once
GARM0324

schema GA1V0325
archetype PLAYER_SPEECH
play_once
GARM0325

schema GA1V0326
archetype PLAYER_SPEECH
play_once
GARM0326

schema GA1V0327
archetype PLAYER_SPEECH
play_once
GARM0327

schema GA1V0328
archetype PLAYER_SPEECH
play_once
GARM0328

schema GA1V0329
archetype PLAYER_SPEECH
play_once
GARM0329

//BASSO
schema GARM0330
archetype PLAYER_SPEECH
play_once
GARM0330


//MISSION 4 -CATACOMBS
		
schema garm0401
archetype PLAYER_SPEECH
play_once
GARM0401	

schema garm0402
archetype PLAYER_SPEECH
play_once
GARM0402

schema garm0403
archetype PLAYER_SPEECH
play_once
GARM0403
	
schema garm0404
archetype PLAYER_SPEECH
play_once
GARM0404

schema garm0405
archetype PLAYER_SPEECH
play_once
GARM0405

schema garm0406
archetype PLAYER_SPEECH
play_once
GARM0406

schema garm0407
archetype PLAYER_SPEECH
play_once
GARM0407

schema garm0408
archetype PLAYER_SPEECH
play_once
garm0408

schema garm0409
archetype PLAYER_SPEECH
play_once
garm0409

schema garm0410
archetype PLAYER_SPEECH
play_once
garm0410

schema garm0411
archetype PLAYER_SPEECH
delay 5000
play_once
garm0411

schema garm0412
archetype PLAYER_SPEECH
play_once
garm0412

schema garm0413
archetype PLAYER_SPEECH
play_once
garm0413

schema garm0414
archetype PLAYER_SPEECH
play_once
garm0414

schema garm0415
archetype PLAYER_SPEECH
play_once
garm0415


//MISSION 5 -ASSASSIN

schema garm0501
archetype PLAYER_SPEECH
play_once
garm0501

schema garm0502
archetype PLAYER_SPEECH
play_once
garm0502

schema garm0503
archetype PLAYER_SPEECH
play_once
garm0503

schema garm0504
archetype PLAYER_SPEECH
play_once
garm0504

schema garm0505
archetype PLAYER_SPEECH
play_once
garm0505

schema garm0506
archetype PLAYER_SPEECH
play_once
garm0506

schema garm0507
archetype PLAYER_SPEECH
play_once
garm0507

//MISSION 6

schema garm0601
archetype PLAYER_SPEECH
play_once
garm0601

schema garm0602
archetype PLAYER_SPEECH
play_once
garm0602

schema garm0603
archetype PLAYER_SPEECH
play_once
garm0603

schema garm0604
archetype PLAYER_SPEECH
play_once
garm0604

schema garm0605
archetype PLAYER_SPEECH
play_once
garm0605


//MISSION 7 

schema garm0701
archetype PLAYER_SPEECH
play_once
garm0701

//MISSION 9

schema garm0901
archetype PLAYER_SPEECH
play_once
garm0901

schema garm0902
archetype PLAYER_SPEECH
play_once
garm0902

schema garm0903
archetype PLAYER_SPEECH
play_once
garm0903

schema garm0904
archetype PLAYER_SPEECH
play_once
garm0904

schema garm0905
archetype PLAYER_SPEECH
play_once
garm0905

schema garm0906
archetype PLAYER_SPEECH
play_once
garm0906

schema garm0907
archetype PLAYER_SPEECH
play_once
garm0907

schema garm0908
archetype PLAYER_SPEECH
play_once
garm0908

schema garm0909
archetype PLAYER_SPEECH
play_once
garm0909

schema garm0910
archetype PLAYER_SPEECH
play_once
garm0910

schema garm0911
archetype PLAYER_SPEECH
play_once
garm0911

schema garm0912
archetype PLAYER_SPEECH
play_once
garm0912

schema garm0913
archetype PLAYER_SPEECH
play_once
garm0913


//MISSION 10

schema garm1001
archetype PLAYER_SPEECH
play_once
garm1001

schema garm1002
archetype PLAYER_SPEECH
play_once
garm1002

schema garm1003
archetype PLAYER_SPEECH
play_once
garm1003

//MISSION 11

schema garm1101
archetype PLAYER_SPEECH
play_once
garm1101

schema garm1102
archetype PLAYER_SPEECH
play_once
garm1102

schema garm1103
archetype PLAYER_SPEECH
play_once
garm1103

schema garm1104
archetype PLAYER_SPEECH
play_once
garm1104

schema garm1105
archetype PLAYER_SPEECH
play_once
garm1105

schema garm1106
archetype PLAYER_SPEECH
play_once
garm1106

schema garm1107
archetype PLAYER_SPEECH
play_once
garm1107

schema garm1108
archetype PLAYER_SPEECH
play_once
garm1108

schema garm1109
archetype PLAYER_SPEECH
play_once
garm1109

schema garm1110
archetype PLAYER_SPEECH
play_once
garm1110

//MISSION 12

schema garm1202
archetype PLAYER_SPEECH
play_once
garm1202

schema garm1203
archetype PLAYER_SPEECH
play_once
garm1203

//MISSION 13

schema garm1301
archetype PLAYER_SPEECH
play_once
garm1301

schema garm1302
archetype PLAYER_SPEECH
delay 1000
play_once
garm1302

schema garm1303
archetype PLAYER_SPEECH
play_once
garm1303

//MISSION 14 -ENDGAME

schema garm1401
archetype PLAYER_SPEECH
play_once
garm1401

schema garm1402
archetype PLAYER_SPEECH
play_once
garm1402

schema garm1403
archetype PLAYER_SPEECH
play_once
garm1403

schema garm1404
archetype PLAYER_SPEECH
delay 1500
play_once
garm1404

schema garm1405
archetype PLAYER_SPEECH
play_once
garm1405

schema garm1406
archetype PLAYER_SPEECH
play_once
garm1406

schema garm1407
archetype PLAYER_SPEECH
play_once
garm1407

schema garm1408
archetype PLAYER_SPEECH
play_once
garm1408

schema garm1409
archetype PLAYER_SPEECH
delay 3500
play_once
garm1409


////////////////////
//THIEFGOLD SPEECH//
////////////////////

//RANDOM SPEECH

schema gar99100
archetype PLAYER_SPEECH
play_once
gar99100

schema gar99102
archetype PLAYER_SPEECH
play_once
gar99102

schema gar99103
archetype PLAYER_SPEECH
play_once
gar99103

schema gar99104
archetype PLAYER_SPEECH
play_once
gar99104

schema gar99105
archetype PLAYER_SPEECH
play_once
gar99105

schema gar99106
archetype PLAYER_SPEECH
play_once
gar99106

schema gar99107
archetype PLAYER_SPEECH
play_once
gar99107

schema gar99108
archetype PLAYER_SPEECH
play_once
gar99108

schema gar99109
archetype PLAYER_SPEECH
play_once
gar99109

schema gar99110
archetype PLAYER_SPEECH
play_once
gar99110

//MISSION 15 -THIEVE'S GUILD

schema gar06100
archetype PLAYER_SPEECH
play_once
gar06100

schema gar06101
archetype PLAYER_SPEECH
play_once
gar06101

schema gar06102
archetype PLAYER_SPEECH
play_once
gar06102

schema gar06103
archetype PLAYER_SPEECH
play_once
gar06103

schema gar06104
archetype PLAYER_SPEECH
play_once
gar06104

schema gar06105
archetype PLAYER_SPEECH
play_once
gar06105

schema gar06106
archetype PLAYER_SPEECH
play_once
gar06106

schema gar06107
archetype PLAYER_SPEECH
play_once
gar06107

schema gar06108
archetype PLAYER_SPEECH
play_once
gar06108

//MISSION 16 -MAGE'S TOWER

schema gar10100
archetype PLAYER_SPEECH
play_once
gar10100

schema gar10101
archetype PLAYER_SPEECH
play_once
gar10101

schema gar10102
archetype PLAYER_SPEECH
play_once
gar10102

schema gar10103
archetype PLAYER_SPEECH
play_once
gar10103

schema gar10104
archetype PLAYER_SPEECH
play_once
gar10104


//MISSION 17 -OPERA

schema gar12100
archetype PLAYER_SPEECH
delay 2000
play_once
gar12100

schema gar12101
archetype PLAYER_SPEECH
delay 1000
play_once
gar12101

schema gar12102
archetype PLAYER_SPEECH
play_once
gar12102

schema gar12103
archetype PLAYER_SPEECH
play_once
gar12103

schema gar12104
archetype PLAYER_SPEECH
play_once
gar12104

schema gar12105
archetype PLAYER_SPEECH
play_once
gar12105

schema gar12106
archetype PLAYER_SPEECH
play_once
gar12106

schema gar12107
archetype PLAYER_SPEECH
play_once
gar12107

schema gar12108
archetype PLAYER_SPEECH
play_once
gar12108


//OUTTAKES

//upon seeing something odd:  "I'm not even gonna comment."
schema garOT01
archetype PLAYER_SPEECH
garOT01

//after a program error:  "I'd call that a bug."
schema garOT02
archetype PLAYER_SPEECH
garOT02

//after an object dissappears: "Hey, get back here."
schema garOT03
archetype PLAYER_SPEECH
garOT03

//seeing the drunk guard:  "Oh yeah...he's gone."
schema garOT04
archetype PLAYER_SPEECH
play_once
garOT04

//when a Burrick farts:  "Somebody light a match."
schema garOT05
archetype PLAYER_SPEECH
play_once
garOT05

//asking the obvious question:  "What the hell is a 'taffer' anyway?"
schema garOT06
archetype PLAYER_SPEECH
play_once
garOT06

//comments on dancing zombies:  "I hate modern trends."
schema garOT07
archetype PLAYER_SPEECH
play_once
garOT07

//about Lord Bafford:  "I think Bafford's got too many bats in his bellfry."
schema garOT08
archetype PLAYER_SPEECH
play_once
garOT08
