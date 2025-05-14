//GARRETT SPEECH

//----------EFFORT GRUNTS----------//

//Starting to mantel, climb or jump
schema garclimb
archetype PLYR_EFFORT
garclim1 garclim2 garclim3

//End of mantelling
schema garclimbend
archetype PLYR_EFFORT
garbrea1 garbrea2

//STRAINING WHILE HOLDING BOW OR SWORD TOO LONG
schema garstrain
archetype PLYR_EFFORT
volume -1500
garstrn1 garstrn2

//SWORD AUTO PUT DOWN SIGH
schema garsigh
archetype PLYR_EFFORT
garsigh

//EFFORT GRUNT -OVERHEAD SWORD SWING
schema gargrunt
archetype PLYR_EFFORT
volume -1500
gargrun1 gargrun2 empty
env_tag (Event Motion) (CreatureType Player) (PlyrSword 1 1) (PlyrSwordSwing 2 2)

//WRONG WARD IN MISS11
schema garhmmm
archetype PLYR_EFFORT
garhmmm gar1103
env_tag (Event Reject) (Operation Keyfit) (WardType AirWard EarthWard FireWard WaterWard)

//PICKUP BODY
schema garlift
archetype PLYR_EFFORT
volume -1300
garpick1 garpick2

//DROP BODY
schema gardrop
archetype PLYR_EFFORT
volume -1300
gardrop1

//SWORD PULL BACK
schema garsword
archetype PLYR_EFFORT
volume -1500
garswrd1 garswrd2 garswrd3



//----------TAKING DAMAGE----------//

//SMALL BASH
schema ghbash_sm
archetype PLYR_DAMAGE
volume -1
no_repeat
garoof_1 garoof_2 garoof_3 garoof_4
env_tag (Event Damage) (DamageType Bash Knockout Poke) (Damage 1 19) (Health 51 100) (CreatureType Player)

//MED BASH 
schema ghbash_med
archetype PLYR_DAMAGE
volume -1
no_repeat
garhhi_1 garhhi_2 garhhi_3 garhhi_4
env_tag (Event Damage) (DamageType Bash Knockout Poke Holy) (Damage 20 39) (Health 51 100) (CreatureType Player)
env_tag (Event Damage) (DamageType Bash Knockout Poke Holy) (Damage 1 19) (Health 21 50) (CreatureType Player)

//LARGE BASH
schema ghbash_lg
archetype PLYR_DAMAGE
volume -1
no_repeat
garhlo_1 garhlo_2 garhlo_3
env_tag (Event Damage) (DamageType Bash Knockout Poke Holy) (Damage 40 100) (Health 1 100) (CreatureType Player)
env_tag (Event Damage) (DamageType Bash Knockout Poke Holy) (Damage 20 39) (Health 1 50) (CreatureType Player)
env_tag (Event Damage) (DamageType Bash Knockout Poke Holy) (Damage 1 19) (Health 1 20) (CreatureType Player)

//SMALL FIRE DAMAGE
schema garfire_sm
archetype PLYR_DAMAGE
volume -1
no_repeat
garfire3 garfire4 garfire5
env_tag (Event Damage) (DamageType Fire) (Damage 1 69) (Health 1 100) (CreatureType Player)

//LARGE FIRE DAMAGE
schema garfire
archetype PLYR_DAMAGE
volume -1
garfire
env_tag (Event Damage) (DamageType Fire) (Damage 70 100) (Health 1 100) (CreatureType Player)



//TAKING MACE DAMAGE
schema ghmace_sm
archetype PLYR_DAMAGE
volume -1
no_repeat
ghhammr1 ghhammr2 ghhammr3 ghhammr4
env_tag (Event Damage) (DamageType Bash Knockout) (Damage 1 39) (Health 51 100) (CreatureType Player) (WeaponType FakeTalisman Hammer)
env_tag (Event Damage) (DamageType Bash Knockout) (Damage 1 39) (Health 51 100) (CreatureType Player) (ArrowType Cannonball)
env_tag (Event Damage) (DamageType Bash Slash) (Damage 1 39) (Health 51 100) (CreatureType Player) (WeaponType Fist)

schema ghmace_lg
archetype PLYR_DAMAGE
volume -1
no_repeat
ghhammr5 ghhammr6 ghhammr7 ghhammr8
env_tag (Event Damage) (DamageType Bash Knockout)  (Damage 1 39) (Health 1 50) (CreatureType Player) (WeaponType FakeTalisman Hammer)
env_tag (Event Damage) (DamageType Bash Knockout)  (Damage 40 100) (Health 1 100) (CreatureType Player) (WeaponType FakeTalisman Hammer)
env_tag (Event Damage) (DamageType Bash Knockout)  (Damage 1 39) (Health 1 50) (CreatureType Player) (ArrowType Cannonball)
env_tag (Event Damage) (DamageType Bash Knockout)  (Damage 40 100) (Health 1 100) (CreatureType Player) (ArrowType Cannonball)
env_tag (Event Damage) (DamageType Bash Slash)  (Damage 1 39) (Health 1 50) (CreatureType Player) (WeaponType Fist)
env_tag (Event Damage) (DamageType Bash Slash)  (Damage 40 100) (Health 1 100) (CreatureType Player) (WeaponType Fist)


//TAKING SWORD DAMAGE
schema ghsword_sm
archetype PLYR_DAMAGE
volume -1
no_repeat
ghsword1 ghsword2 ghsword3 ghsword4
env_tag (Event Damage) (DamageType Slash) (Damage 1 39) (Health 51 100) (CreatureType Player) (WeaponType Sword)
env_tag (Event Damage) (DamageType Bash Slash) (Damage 1 39) (Health 51 100) (CreatureType Player) (WeaponType Claw)

schema ghsword_lg
archetype PLYR_DAMAGE
volume -1
no_repeat
ghsword5 ghsword6 ghsword7 ghsword8
env_tag (Event Damage) (DamageType Slash) (Damage 1 39) (Health 1 50) (CreatureType Player) (WeaponType Sword)
env_tag (Event Damage) (DamageType Slash) (Damage 40 100) (Health 1 100) (CreatureType Player) (WeaponType Sword)
env_tag (Event Damage) (DamageType Bash Slash) (Damage 40 100) (Health 1 100) (CreatureType Player) (WeaponType Claw)

//TAKING ARROW DAMAGE
schema gharrow
archetype PLYR_DAMAGE
volume -1
no_repeat
gharrow1 gharrow2 gharrow3
env_tag (Event Damage) (DamageType Poke) (Damage 1 100) (Health 1 100) (CreatureType Player) (ArrowType BlowDart Broadhead)
env_tag (Event Damage) (DamageType Slash) (Damage 1 100) (Health 1 100) (CreatureType Player) (ArrowType SawBlade)



//TAKING BUGPOKE DAMAGE
schema ghbugpoke
archetype PLYR_DAMAGE
volume -1
no_repeat
ghbugpk1 ghbugpk2 ghbugpk3
env_tag (Event Damage) (DamageType Poke) (Damage 1 100) (Health 1 100) (CreatureType Player) (ArrowType BugShot)

//TAKING ZAP DAMAGE
schema ghmagic
archetype PLYR_DAMAGE
volume -1
no_repeat
ghmagic1 ghmagic2 ghmagic3
env_tag (Event Damage) (DamageType Zap) (Damage 1 100) (Health 1 100) (CreatureType Player) (ArrowType MagicMissile)

//TAKING FIREBOLT DAMAGE
schema ghfirebolt
archetype PLYR_DAMAGE
volume -1
no_repeat
ghhammr5 ghhammr6 ghhammr7 ghhammr8
env_tag (Event Damage) (DamageType Fire) (Damage 1 100) (Health 1 100) (CreatureType Player) (ArrowType Firebolt)

//TAKING MISC PROJECTILE DAMAGE
schema ghprojectile
archetype PLYR_DAMAGE
volume -1
no_repeat
garhhi_1 garhhi_2 garhhi_3 garhhi_4
env_tag (Event Damage) (DamageType Bash Knockout Poke Holy) (Damage 1 100) (Health 1 100) (CreatureType Player) (ArrowType GhostShot HammerSpell Web)

//TAKING MAGE WATER & AIR DAMAGE
//schema ghmagebolt
//archetype PLYR_DAMAGE
//volume -1
//ghhammr2 Ghhammr7
//env_tag (Event Damage) (DamageType Slash) (Damage 1 100) (Health 1 100) (CreatureType Player) (MageShotType MageExp)
//env_tag (Event Damage) (DamageType Concussion) (Damage 1 100) (Health 1 100) (CreatureType Player) 

//TAKING MAGE EARTH DAMAGE
//schema ghmageearth
//archetype PLYR_DAMAGE
//ghmgear1 ghmgear2 ghmgear3 ghmgear4 ghmgear5 ghmgear6 ghmgear7 ghmgear8
//env_tag (Event Damage) (DamageType Bash) (Damage 1 100) (Health 1 100) (CreatureType Player) (MageShotType MageEarth)


//TAKING STENCH DAMAGE
schema ghstench_sm
archetype PLYR_DAMAGE
garcoug1 garcoug2
env_tag (Event Damage) (DamageType Stench Toxic) (Damage 1 100) (Health 70 100) (CreatureType Player)

schema ghstench_med
archetype PLYR_DAMAGE
gargag1 gargag2 gargag3 
env_tag (Event Damage) (DamageType Stench Toxic) (Damage 1 100) (Health 40 69) (CreatureType Player)

schema ghstench_lg
archetype PLYR_DAMAGE
garhack1 garhack2 garhack3 
env_tag (Event Damage) (DamageType Stench Toxic) (Damage 1 100) (Health 1 39) (CreatureType Player)

//Drowing
schema gar_drown
archetype PLYR_DAMAGE
gardrow1 gardrow2 gardrow3 gardrow4 gardrow5
env_tag (Event Damage) (DamageType Water) (Damage 1 100) (Health 1 100) (CreatureType Player)


//DEATH SOFT -DROWNING, GAGGING, MAGEEARTH 
schema gardeath1
archetype PLYR_DAMAGE
volume -1
gardie1 gardie2
env_tag (Event Damage) (CreatureType Player) (DamageType Water Knockout Stench Holy Toxic) (Damage 1 100) (Health 0 0)

//DEATH BY FIRE
schema gardeath2
archetype PLYR_DAMAGE
volume -1
garfire
env_tag (Event Damage) (CreatureType Player) (DamageType Fire) (Damage 1 100) (Health 0 0)

//DEATH LOUD -IMPACTS
schema gardeath3
archetype PLYR_DAMAGE
volume -1
garfire1 garfire2
env_tag (Event Damage) (CreatureType Player) (DamageType Bash Concussion Slash Poke Zap) (Damage 1 100) (Health 0 0)



//----------SCRIPTED SPEECH----------//

//MISSION 1 	"INTERFERENCE"

schema gar0100
archetype PLYR_SCRIPTED
gar0100

schema gar0101
archetype PLYR_SCRIPTED
gar0101

schema gar0102
archetype PLYR_SCRIPTED
gar0102

schema gar0103
archetype PLYR_SCRIPTED
gar0103

schema gar0104
archetype PLYR_SCRIPTED
gar0104

schema gar0105
archetype PLYR_SCRIPTED
delay 10
gar0105

schema gar0106
archetype PLYR_SCRIPTED
delay 10
gar0106

schema gar0107
archetype PLYR_SCRIPTED
gar0107

schema gar0108
archetype PLYR_SCRIPTED
delay 10
gar0108

schema gar0109
archetype PLYR_SCRIPTED
gar0109

schema gar0110
archetype PLYR_SCRIPTED
gar0110

schema gar0111
archetype PLYR_SCRIPTED
gar0111

schema gar0112
archetype PLYR_SCRIPTED
gar0112

schema gar0113
archetype PLYR_SCRIPTED
gar0113


//MISSION 2 	"SHIPPING & RECEIVING"

schema gar0201 
archetype PLYR_SCRIPTED
gar0201

schema gar0202
archetype PLYR_SCRIPTED
gar0202

schema gar0203
archetype PLYR_SCRIPTED
gar0203

schema gar0204
archetype PLYR_SCRIPTED
gar0204

schema gar0205
archetype PLYR_SCRIPTED
gar0205

schema gar0206
archetype PLYR_SCRIPTED
gar0206

schema gar0207
archetype PLYR_SCRIPTED
gar0207

schema gar0208
archetype PLYR_SCRIPTED
gar0208

schema gar0209
archetype PLYR_SCRIPTED
gar0209

schema gar0210
archetype PLYR_SCRIPTED
gar0210

schema gar0211
archetype PLYR_SCRIPTED
gar0211

schema gar0212
archetype PLYR_SCRIPTED
gar0212

schema gar0213
archetype PLYR_SCRIPTED
gar0213

schema gar0214
archetype PLYR_SCRIPTED
gar0214

schema gar0215
archetype PLYR_SCRIPTED
gar0215

schema gar0216
archetype PLYR_SCRIPTED
gar0216

schema gar0217
archetype PLYR_SCRIPTED
gar0217

schema gar0218
archetype PLYR_SCRIPTED
gar0218

schema gar0219
archetype PLYR_SCRIPTED
gar0219


//MISSION 4 	"FRAMED"

schema gar0401
archetype PLYR_SCRIPTED
gar0401

schema gar0402			//"Oh yeah, he's gone."
archetype PLYR_SCRIPTED
delay 4000
gar0402

schema gar0403
archetype PLYR_SCRIPTED
gar0403

schema gar0404
archetype PLYR_SCRIPTED
gar0404

schema gar0405
archetype PLYR_SCRIPTED
gar0405

schema gar0406
archetype PLYR_SCRIPTED
gar0406

schema gar0407
archetype PLYR_SCRIPTED
gar0407

schema gar0408
archetype PLYR_SCRIPTED
gar0408

schema gar0409
archetype PLYR_SCRIPTED
gar0409

schema gar0410
archetype PLYR_SCRIPTED
gar0410

schema gar0411
archetype PLYR_SCRIPTED
gar0411

schema gar0412
archetype PLYR_SCRIPTED
gar0412

schema gar0413
archetype PLYR_SCRIPTED
gar0413

schema gar0414
archetype PLYR_SCRIPTED
gar0414

schema gar0415
archetype PLYR_SCRIPTED
gar0415

schema gar0416
archetype PLYR_SCRIPTED
gar0416

schema gar0417
archetype PLYR_SCRIPTED
gar0417

schema gar0418
archetype PLYR_SCRIPTED
gar0418

schema gar0419
archetype PLYR_SCRIPTED
gar0419

schema gar0420
archetype PLYR_SCRIPTED
gar0420

schema gar0421
archetype PLYR_SCRIPTED
gar0421


//MISSION 5 	"AMBUSH"

schema gar0501
archetype PLYR_SCRIPTED
gar0501

schema gar0502
archetype PLYR_SCRIPTED
gar0502

schema gar0503
archetype PLYR_SCRIPTED
gar0503

schema gar0504
archetype PLYR_SCRIPTED
gar0504

schema gar0505
archetype PLYR_SCRIPTED
gar0505

schema gar0506
archetype PLYR_SCRIPTED
gar0506

schema gar0507
archetype PLYR_SCRIPTED
gar0507


//MISSION 6 	"EAVESDROPPING"

schema gar0601
archetype PLYR_SCRIPTED
gar0601

schema gar0602
archetype PLYR_SCRIPTED
gar0602

schema gar0603
archetype PLYR_SCRIPTED
gar0603

//there is no gar0604

schema gar0605
archetype PLYR_SCRIPTED
gar0605

schema gar0606
archetype PLYR_SCRIPTED
gar0606

schema gar0607
archetype PLYR_SCRIPTED
delay 5000
gar0607

schema gar0608
archetype PLYR_SCRIPTED
gar0608

schema gar0609
archetype PLYR_SCRIPTED
gar0609

schema gar0610
archetype PLYR_SCRIPTED
gar0610

schema gar0611
archetype PLYR_SCRIPTED
gar0611

schema gar0612
archetype PLYR_SCRIPTED
gar0612

schema gar0613
archetype PLYR_SCRIPTED
gar0613

schema gar0614
archetype PLYR_SCRIPTED
gar0614

schema gar0615
archetype PLYR_SCRIPTED
gar0615

schema gar0616
archetype PLYR_SCRIPTED
gar0616

schema gar0617
archetype PLYR_SCRIPTED
gar0617

schema gar0618
archetype PLYR_SCRIPTED
gar0618


//MISSION 7 	"BANK"

schema gar0701
archetype PLYR_SCRIPTED
gar0701

schema gar0702
archetype PLYR_SCRIPTED
gar0702

schema gar0703
archetype PLYR_SCRIPTED
gar0703

schema gar0704
archetype PLYR_SCRIPTED
gar0704

schema gar0705
archetype PLYR_SCRIPTED
gar0705

schema gar0706
archetype PLYR_SCRIPTED
gar0706

schema gar0707
archetype PLYR_SCRIPTED
gar0707

schema gar0708
archetype PLYR_SCRIPTED
gar0708

schema gar0709
archetype PLYR_SCRIPTED
gar0709


//MISSION 8 	"COURIER"

schema gar0801
archetype PLYR_SCRIPTED
gar0801

schema gar0802
archetype PLYR_SCRIPTED
gar0802

schema gar0803
archetype PLYR_SCRIPTED
gar0803

schema gar0804
archetype PLYR_SCRIPTED
gar0804

schema gar0805
archetype PLYR_SCRIPTED
gar0805

schema gar0806
archetype PLYR_SCRIPTED
gar0806

schema gar0807
archetype PLYR_SCRIPTED
gar0807

schema gar0808
archetype PLYR_SCRIPTED
gar0808

schema gar0809
archetype PLYR_SCRIPTED
gar0809


//MISSION 9 	"BLACKMAIL"

schema gar0901
archetype PLYR_SCRIPTED
gar0901

schema gar0902
archetype PLYR_SCRIPTED
gar0902

schema gar0903
archetype PLYR_SCRIPTED
gar0903

schema gar0904
archetype PLYR_SCRIPTED
gar0904

schema gar0905
archetype PLYR_SCRIPTED
gar0905

schema gar0906
archetype PLYR_SCRIPTED
gar0906

//ADDED FOR THE PATCH
schema gar045		//"I have a bad feeling about this."
archetype PLYR_SCRIPTED
gar045

schema gar047		//"I wonder what happened here."
archetype PLYR_SCRIPTED
gar047

schema garm0326		//"Ah, this is what I'm looking for."
archetype PLYR_SCRIPTED
garm0326


//MISSION 10 	"TRAIL OF BLOOD"

schema gar1001
archetype PLYR_SCRIPTED
gar1001

schema gar1002
archetype PLYR_SCRIPTED
gar1002

schema gar1003
archetype PLYR_SCRIPTED
gar1003

schema gar1004
archetype PLYR_SCRIPTED
gar1004

schema gar1005
archetype PLYR_SCRIPTED
gar1005

schema gar1006
archetype PLYR_SCRIPTED
gar1006


//MISSION 11  	"UNWELCOME GUEST"

schema gar1101
archetype PLYR_SCRIPTED
gar1101

schema gar1102
archetype PLYR_SCRIPTED
gar1102

schema gar1103
archetype PLYR_SCRIPTED
gar1103

schema gar1104	
archetype PLYR_SCRIPTED
gar1104

schema gar1105	
archetype PLYR_SCRIPTED
gar1105

schema gar1106
archetype PLYR_SCRIPTED
gar1106

schema gar1107	
archetype PLYR_SCRIPTED
gar1107

schema gar1108
archetype PLYR_SCRIPTED
gar1108

schema gar1109
archetype PLYR_SCRIPTED
delay 50000
gar1109

schema gar1110
archetype PLYR_SCRIPTED
gar1110

schema gar1111
archetype PLYR_SCRIPTED
gar1111


//MISSION 12  	"CASING"

schema gar1201
archetype PLYR_SCRIPTED
gar1201

schema gar1202
archetype PLYR_SCRIPTED
gar1202

schema gar1203
archetype PLYR_SCRIPTED
gar1203

schema gar1204
archetype PLYR_SCRIPTED
gar1204

schema gar1205
archetype PLYR_SCRIPTED
gar1205

schema gar1206
archetype PLYR_SCRIPTED
gar1206

schema gar1207
archetype PLYR_SCRIPTED
gar1207


//MISSION 13  	"MASKS"

schema gar1301
archetype PLYR_SCRIPTED
gar1301

schema gar1302
archetype PLYR_SCRIPTED
gar1302

schema gar1303
archetype PLYR_SCRIPTED
gar1303

schema gar1304
archetype PLYR_SCRIPTED
gar1304

schema gar1305
archetype PLYR_SCRIPTED
gar1305

schema gar1306
archetype PLYR_SCRIPTED
gar1306

schema gar1307
archetype PLYR_SCRIPTED
gar1307

schema gar1308
archetype PLYR_SCRIPTED
gar1308

schema gar1309
archetype PLYR_SCRIPTED
gar1309


//MISSION 14  	"PRECIOUS CARGO"

schema gar1401
archetype PLYR_SCRIPTED
gar1401
delay 2000

schema gar1402
archetype PLYR_SCRIPTED
gar1402

schema gar1403
archetype PLYR_SCRIPTED
gar1403

schema gar1404
archetype PLYR_SCRIPTED
gar1404

schema gar1405
archetype PLYR_SCRIPTED
gar1405

schema gar1406
archetype PLYR_SCRIPTED
gar1406

schema gar1407
archetype PLYR_SCRIPTED
gar1407

schema gar1408
archetype PLYR_SCRIPTED
gar1408

schema gar1409
archetype PLYR_SCRIPTED
gar1409


//MISSION 15  	"KIDNAP"

schema gar1501
archetype PLYR_SCRIPTED
gar1501

schema gar1502
archetype PLYR_SCRIPTED
gar1502

schema gar1503
archetype PLYR_SCRIPTED
gar1503

schema gar1504
archetype PLYR_SCRIPTED
gar1504

schema gar1505
archetype PLYR_SCRIPTED
gar1505

schema gar1506
archetype PLYR_SCRIPTED
gar1506

schema gar1507
archetype PLYR_SCRIPTED
gar1507

schema gar1508
archetype PLYR_SCRIPTED
gar1508


//MISSION 16  	"ENDGAME"

schema gar1601
archetype PLYR_SCRIPTED
gar1601

schema gar1602
archetype PLYR_SCRIPTED
gar1602

schema gar1603
archetype PLYR_SCRIPTED
gar1603

schema gar1604
archetype PLYR_SCRIPTED
gar1604

schema gar1605
archetype PLYR_SCRIPTED
gar1605

schema gar1606
archetype PLYR_SCRIPTED
gar1606

schema gar1607
archetype PLYR_SCRIPTED
gar1607

schema gar1608
archetype PLYR_SCRIPTED
gar1608


//MISSION 17	"TRAINING"

schema GARTR001
archetype PLYR_SCRIPTED
delay 1000
gar1701


//GENERIC

schema gar9901
archetype PLYR_SCRIPTED
gar9901

schema gar9902
archetype PLYR_SCRIPTED
gar9902

schema gar9903
archetype PLYR_SCRIPTED
gar9903

schema gar9904
archetype PLYR_SCRIPTED
gar9904

schema gar9905
archetype PLYR_SCRIPTED
gar9905

schema gar9906
archetype PLYR_SCRIPTED
gar9906

schema gar9907
archetype PLYR_SCRIPTED
gar9907

schema gar9908
archetype PLYR_SCRIPTED
gar9908

schema gar9909
archetype PLYR_SCRIPTED
gar9909

schema gar9910
archetype PLYR_SCRIPTED
gar9910

schema gar9911
archetype PLYR_SCRIPTED
gar9911

schema gar9912
archetype PLYR_SCRIPTED
gar9912

schema gar9913
archetype PLYR_SCRIPTED
gar9913

schema gar9914
archetype PLYR_SCRIPTED
gar9914

schema gar9915
archetype PLYR_SCRIPTED
gar9915

schema gar9916
archetype PLYR_SCRIPTED
gar9916

schema gar9917
archetype PLYR_SCRIPTED
gar9917

schema gar9918
archetype PLYR_SCRIPTED
gar9918

schema gar9919
archetype PLYR_SCRIPTED
gar9919

schema gar9920
archetype PLYR_SCRIPTED
gar9920

schema gar9921
archetype PLYR_SCRIPTED
gar9912

schema gar9922
archetype PLYR_SCRIPTED
gar9922

schema gar9923
archetype PLYR_SCRIPTED
gar9923

schema gar9924
archetype PLYR_SCRIPTED
gar9924

schema gar9925
archetype PLYR_SCRIPTED
gar9925

schema gar9926
archetype PLYR_SCRIPTED
gar9926

schema gar9927
archetype PLYR_SCRIPTED
gar9927

schema gar9928
archetype PLYR_SCRIPTED
gar9928

schema gar9929
archetype PLYR_SCRIPTED
gar9929

schema gar9930
archetype PLYR_SCRIPTED
gar9930