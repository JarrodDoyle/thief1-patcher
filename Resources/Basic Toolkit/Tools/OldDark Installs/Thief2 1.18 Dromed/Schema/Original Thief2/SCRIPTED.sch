//THIEF 2 SCRIPTED SPEECH [not AI broadcasts nor conversations]

//-------------------------------------------------------

////////////////////////////
//MISSION 1 - INTERFERENCE//
////////////////////////////



//BASSO: SEEING HER
//"Jenni, it's me!  Basso!"
schema bas0101B
archetype AI_SCRIPTED	
bas0101B

//-------------------------------------------------------

//JENIVERE: IF YOU TRY THE LOCK ON HER DOOR [ONLY ONE OF THESE MIGHT BE USED]
//"Who... who is it?"
schema jen0101C
archetype AI_SCRIPTED
jen0101C

//"Basso, is that you?"
schema jen0101D		
archetype AI_SCRIPTED
jen0101D

//-------------------------------------------------------

/////////////////////////////
//MISSION 6 - EAVESDROPPING//
/////////////////////////////

//c0609 - KARRAS & TRUART's BIG PRE-MIXED 'CONVERSATION'.
schema kar0609A		//"Behold, Sheriff Truart, from the lowly...."
archetype KARRAS_SCRIPTED
priority 255
kar0609A

schema kar0609B		//"..It's not that the money's not right..."
archetype KARRAS_SCRIPTED
priority 255
kar0609B

schema kar0609C		//"...Come now, what's the crux...."
archetype KARRAS_SCRIPTED
priority 255
kar0609C

schema kar0609D		//"...Come, come gentle beggar...."
archetype KARRAS_SCRIPTED
priority 255
kar0609D

schema kar0609E		//"...[activate beacon]...."
archetype KARRAS_SCRIPTED
priority 255
kar0609E

schema kar0609F		//"...They are gone!...."
archetype KARRAS_SCRIPTED
priority 255
kar0609F

schema kar0609G		//"...You need subjects...."
archetype KARRAS_SCRIPTED
priority 255
kar0609G

schema kar0609H		//"...Well our business here is finished...."
archetype KARRAS_SCRIPTED
priority 255
kar0609H

//KARRAS:  MONOLOG AFTER TRUART LEAVES, WITH ALTERNATE ENDINGS
//"Now see, Friends, with efficiency I have completed two tasks..."
schema kar0610A
archetype KARRAS_SCRIPTED
priority 255
kar0610A

//"...Now behold my wax cylinder machine..."
schema kar0610S
archetype KARRAS_SCRIPTED
priority 255
kar0610S


//"...in the acolyte's quarters..."
schema kar0610B
archetype KARRAS_SCRIPTED
priority 255
kar0610B

//"...in the guard's quarters..."
schema kar0610C
archetype KARRAS_SCRIPTED
priority 255
kar0610C

//"...in the office on the second floor of the church..."
schema kar0610D
archetype KARRAS_SCRIPTED
priority 255
kar0610D

//"...in the factory area..."
schema kar0610E
archetype KARRAS_SCRIPTED
priority 255
kar0610E

//"...in the east tower..."
schema kar0610F
archetype KARRAS_SCRIPTED
priority 255
kar0610F

//"...in the west tower..."
schema kar0610I
archetype KARRAS_SCRIPTED
priority 255
kar0610I

//"...in the catacombs..."
schema kar0610J
archetype KARRAS_SCRIPTED
priority 255
kar0610J

//"...at the pulpit in the church..."
schema kar0610K
archetype KARRAS_SCRIPTED
priority 255
kar0610K

//"...in a closet near the pulpit..."
schema kar0610L
archetype KARRAS_SCRIPTED
priority 255
kar0610L

//"...in the shed atop the acolyte's quarters..."
schema kar0610M
archetype KARRAS_SCRIPTED
priority 255
kar0610M

//"...in the storage shed..."
schema kar0610N
archetype KARRAS_SCRIPTED
priority 255
kar0610N

//"...in the kitchen..."
schema kar0610P
archetype KARRAS_SCRIPTED
priority 255
kar0610P

//"...in the gallery..."
schema kar0610Q
archetype KARRAS_SCRIPTED
priority 255
kar0610Q

//"...in the loft..."
schema kar0610R
archetype KARRAS_SCRIPTED
priority 255
kar0610R

//END OF BIG CONVERSATION 
//"Friends we are adjourned..."
schema kar0611
archetype KARRAS_SCRIPTED
priority 255
kar0611A kar0611B kar0611C




//-------------------------------------------------------

//TRUART: In case 0609 is interrupted by them noticing Garrett
//"I think there's something odd going on..."
schema tru0611A	
archetype AI_SCRIPTED
xxTRU //tru0611A

//-------------------------------------------------------

//////////////////////////////////
//MISSION 11 - LIFE OF THE PARTY//
//////////////////////////////////

//MECH1:  ALARM HEARD OVER THE LOUDSPEAKER	
//"Hearken, Mechanists.  Tower security has been breached...."
//schema mc11106A 
//archetype AI_SCRIPTED
//mc11106A

//KARRAS: VICTROLA MESSAGES
//INTRO: "Greetings, Garrett.   Thou art expected..."
schema karvic00
archetype KARRAS_SCRIPTED
karvic00

//MSG 1 "Tis this functioning?..."  
schema karvic01
archetype KARRAS_SCRIPTED
karvic01

//MSG 2 "Greetings again, guests..."
schema karvic02
archetype KARRAS_SCRIPTED
karvic02

//MSG 3 "Lords and ladies, behold the Builder's Chapel..."
schema karvic03
archetype KARRAS_SCRIPTED
karvic03

//MSG 4 "Privileged guests!  I trust thee will enjoy.."
schema karvic04
archetype KARRAS_SCRIPTED
karvic04

//MSG 5 "The Builder created beauty to bring us joy..."
schema karvic05
archetype KARRAS_SCRIPTED
karvic05

//MSG 6 "It is here that our evening ends..."
schema karvic06
archetype KARRAS_SCRIPTED
karvic06

//-------------------------------------------------------

///////////////////////
//MISSION 12 - CASING//
///////////////////////

//-------------------------------------------------------

//RANDOM AMB GHOST SNDS NEAR BOOKS...WILL BE TURNED OFF AS BOOKES ARE READ.
schema haunted_books
archetype AI_SCRIPTED
poly_loop 2 1500 2500
vfeedus vhearme vhungry vneedyou vplease vwestarv //gho1204F gho1204G gho1204H

//-------------------------------------------------------

///////////////////////////////
//MISSION 14 - PRECIOUS CARGO//
///////////////////////////////

//DESTROYED ROBOT
schema robothead
archetype AI_SCRIPTED
no_repeat
volume -100
rb2die_1 rb2die_2 rb2die_3 rb2atn_3 rb2hhi_3 rb2hlow1 rb2hlo_1 rb2hitw1

//****THIS IS HALF-SCRIPTED & HALF-CONVERSATION****

//c1401 - Garrett & PaganLotus Conversation
//GARRETT: "Lotus?"
schema gar1401A
archetype AI_SCRIPTED
gar1401A

//PAGANMAN: "Still I breathes, Mechanist."
//schema pg11401B
//archetype AI_SCRIPTED
//pg11401B

//GARRETT: "I'm no Mechanist.  I'm Garrett."
schema gar1401C
archetype AI_SCRIPTED
gar1401C

//PAGANMAN: "Garrett.  Yes, the lady knows me you would come."	
//schema pg11401D
//archetype AI_SCRIPTED
//pg11401D

//GARRETT: "Knew I would come? But...."
schema gar1401E
archetype AI_SCRIPTED
gar1401E

//PAGANMAN: "Hush, sneaksie friend..."
//schema pg11401F
//archetype AI_SCRIPTED
//pg11401F

//GARRETT: "Don't worry. I'll find Cavador..."
schema gar1401G
archetype AI_SCRIPTED
gar1401G

//PAGANMAN: "You'll need... takes you the key..."
//schema pg11401H
//archetype AI_SCRIPTED
//pg11401H

//GARRETT: "Yes...my friend.  What can I do?"
schema gar1401I
archetype AI_SCRIPTED
gar1401I

//PAGANMAN: "The cold... feels nothing now..."
//schema pg11401J
//archetype AI_SCRIPTED
//pg11401J
	
//-------------------------------------------------------

////////////////////////
//MISSION 16 - ENDGAME//
////////////////////////
	
//KARRAS INTRO:  [Heard over a loudspeaker]
//"Thou art Garrett, are you not? ..."
schema kar1601A
archetype KARRAS_SCRIPTED
kar1601A

//"...but lo, how easily evil is ..."
schema kar1601B
archetype KARRAS_SCRIPTED
kar1601B

//"...my chamber resists..."
schema kar1601C
archetype KARRAS_SCRIPTED
kar1601C

//"..maybe I've waited over much..."
schema kar1601D
archetype KARRAS_SCRIPTED
kar1601D

//-------------------------------------------------------

//KARRAS BLATHERINGS: [Loudspeaker]  ***WILL THESE BE PLAYED AT RANDOM LIKE AMBS? OR IS THERE A SCRIPTED EVENT FOR EACH --ASK RANDY***
schema kar1602A
archetype KARRAS_SCRIPTED
kar1602A

schema kar1602B
archetype KARRAS_SCRIPTED
kar1602B

schema kar1602C
archetype KARRAS_SCRIPTED
kar1602C

schema kar1602D
archetype KARRAS_SCRIPTED
kar1602D

schema kar1602E
archetype KARRAS_SCRIPTED
kar1602E

schema kar1602F
archetype KARRAS_SCRIPTED
kar1602F

schema kar1602G
archetype KARRAS_SCRIPTED
kar1602G

schema kar1602H
archetype KARRAS_SCRIPTED
kar1602H

schema kar1602I
archetype KARRAS_SCRIPTED
kar1602I

schema kar1602J
archetype KARRAS_SCRIPTED
kar1602J

schema kar1602K
archetype KARRAS_SCRIPTED
kar1602K

schema kar1602L
archetype KARRAS_SCRIPTED
kar1602L

schema kar1602M
archetype KARRAS_SCRIPTED
kar1602M

schema kar1602N
archetype KARRAS_SCRIPTED
kar1602N

schema kar1602P
archetype KARRAS_SCRIPTED
kar1602P

schema kar1602Q
archetype KARRAS_SCRIPTED
kar1602Q

schema kar1602R
archetype KARRAS_SCRIPTED
kar1602R

schema kar1602S
archetype KARRAS_SCRIPTED
kar1602S

schema kar1602T
archetype KARRAS_SCRIPTED
kar1602T


//-------------------------------------------------------	
//KARRAS SEEING GARRETT THRU CAMERA: [Loudspeaker]  ***WILL THESE BE PLAYED AT RANDOM LIKE AMBS? OR IS THERE A SCRIPTED EVENT FOR EACH --ASK RANDY***

schema kar1603A		//"What?  Thou lives still?..." 
archetype KARRAS_SCRIPTED	
kar1603A

schema kar1603B		//"Garrett!  In truth, I thought thou had perished.."
archetype KARRAS_SCRIPTED	
kar1603B

schema kar1603C		//"By the Builder!  Garrett, thou wilt be crushed.."
archetype KARRAS_SCRIPTED	
kar1603C

schema kar1603D		//"Garrett, thine end is near..."
archetype KARRAS_SCRIPTED	
kar1603D

schema kar1603E		//"I see thee!! And the one..."
archetype KARRAS_SCRIPTED	
kar1603E

schema kar1603F		//"Nay, nay!  Stop thy distractions, Garrett..."
archetype KARRAS_SCRIPTED	
kar1603F

schema kar1603G		//"Again I see thee, thief!..."
archetype KARRAS_SCRIPTED	
kar1603G

schema kar1603H		//"I am thankful that Karras was chosen..."
archetype KARRAS_SCRIPTED	
kar1603H

schema kar1603I		//"Art thou not a thief?..."
archetype KARRAS_SCRIPTED	
kar1603I

schema kar1603J		//"Seeks thee to stop me..."
archetype KARRAS_SCRIPTED	
kar1603J

schema kar1603K		//"Seest thou my children? ..."
archetype KARRAS_SCRIPTED	
kar1603K

//-------------------------------------------------------

	
