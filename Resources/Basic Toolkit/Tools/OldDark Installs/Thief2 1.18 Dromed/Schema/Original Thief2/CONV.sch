//THIEF 2 CONVERSATIONS

//-------------------------------------------------------

////////////////////////////
//MISSION 1 - INTERFERENCE//
////////////////////////////

//c0101 -"I've sprung the lock...
schema bas0101A
archetype AI_CONV
volume -700
bas0101A
schema_voice vbasso 1 c0101 (LineNo 1 1)

//c0102 - Jen & Basso meet.
schema jen0102A		//"Basso!"			
archetype AI_CONV
volume -200
jen0102A
schema_voice vjen 1 c0102 (LineNo 1 1)

schema bas0102B		
archetype AI_CONV
volume -700
bas0102B
schema_voice vbasso 1 c0102 (LineNo 2 2)

//-------------------------------------------------------

//c0103 - Guards talk about extinguishing torches. 
schema sg60103A		//"Damn torches, always sputtering out."			
archetype AI_CONV
delay 2000
sg60103A
schema_voice vguard6 1 c0103 (LineNo 1 1)

schema sg50103B
archetype AI_CONV
sg50103B
schema_voice vguard5 1 c0103 (LineNo 2 2)

schema sg60103C				
archetype AI_CONV
sg60103C
schema_voice vguard6 1 c0103 (LineNo 3 3)

schema sg50103D
archetype AI_CONV
sg50103D
schema_voice vguard5 1 c0103 (LineNo 4 4)

schema sg60103E
archetype AI_CONV
sg60103E
schema_voice vguard6 1 c0103 (LineNo 5 5)	

//-------------------------------------------------------

//c0104 Servant & Guard 	
schema sv20104A		//"Jax! Can I bother you..."			
archetype AI_CONV
sv20104A
schema_voice vserv2 1 c0104 (LineNo 1 1)

schema sv20104B
archetype AI_CONV
sv20104B
schema_voice vserv2 1 c0104 (LineNo 2 2)

schema sg40104C
archetype AI_CONV
sg40104C
schema_voice vguard4 1 c0104 (LineNo 3 3)

schema sv20104D
archetype AI_CONV
sv20104D
schema_voice vserv2 1 c0104 (LineNo 4 4)

schema sg40104E
archetype AI_CONV
sg40104E
schema_voice vguard4 1 c0104 (LineNo 5 5)

schema sv20104F
archetype AI_CONV
sv20104F
schema_voice vserv2 1 c0104 (LineNo 6 6)

schema sg40104G
archetype AI_CONV
sg40104G
schema_voice vguard4 1 c0104 (LineNo 7 7)

schema sv20104H
archetype AI_CONV
sv20104H
schema_voice vserv2 1 c0104 (LineNo 8 8)

schema sg40104I
archetype AI_CONV
sg40104I
schema_voice vguard4 1 c0104 (LineNo 9 9)

schema sv20104J
archetype AI_CONV
sv20104J
schema_voice vserv2 1 c0104 (LineNo 10 10)

//-------------------------------------------------------
	
/////////////////////////////////////
//MISSION 2 - -SHIPPING & RECEIVING//
/////////////////////////////////////

//c0201 Hammer & Worker
schema no10201A		//"You must be Uriel..."
archetype AI_CONV
no10201A
schema_voice vnoble1 1 c0201 (LineNo 1 1)

schema hm10201B
archetype AI_CONV
hm10201B
schema_voice vhammer1 1 c0201 (LineNo 2 2)

schema no10201C
archetype AI_CONV
no10201C
schema_voice vnoble1 1 c0201 (LineNo 3 3)

schema hm10201D
archetype AI_CONV
hm10201D
schema_voice vhammer1 1 c0201 (LineNo 4 4)

schema no10201E
archetype AI_CONV
no10201E
schema_voice vnoble1 1 c0201 (LineNo 5 5)

schema hm10201F
archetype AI_CONV
hm10201F
schema_voice vhammer1 1 c0201 (LineNo 6 6)

schema no10201G
archetype AI_CONV
no10201G
schema_voice vnoble1 1 c0201 (LineNo 7 7)

schema hm10201H
archetype AI_CONV
hm10201H
schema_voice vhammer1 1 c0201 (LineNo 8 8)
				
schema no10201I
archetype AI_CONV
no10201I
schema_voice vnoble1 1 c0201 (LineNo 9 9)

//-------------------------------------------------------	
			
//c0202 - Guard & Worker
schema sg50202A		//"Evening Dante, you look exhausted..."
archetype AI_CONV
sg50202A
schema_voice vguard5 1 c0202 (LineNo 1 1)

schema ex10202B
archetype AI_CONV
ex10202B
schema_voice vextra1 1 c0202 (LineNo 2 2)

schema sg50202C		
archetype AI_CONV
sg50202C
schema_voice vguard5 1 c0202 (LineNo 3 3)

schema ex10202D
archetype AI_CONV
ex10202D
schema_voice vextra1 1 c0202 (LineNo 4 4)

schema sg50202E	
archetype AI_CONV
sg50202E
schema_voice vguard5 1 c0202 (LineNo 5 5)

schema ex10202F
archetype AI_CONV
ex10202F
schema_voice vextra1 1 c0202 (LineNo 6 6)

schema sg50202G		
archetype AI_CONV
sg50202G
schema_voice vguard5 1 c0202 (LineNo 7 7)

//-------------------------------------------------------

//c0203 - Two workers
schema sv10203A		//"I hear Capt. Davidson..."
archetype AI_CONV
sv10203A
schema_voice vserv1 1 c0203 (LineNo 1 1)

schema ex20203B
archetype AI_CONV
ex20203B
schema_voice vextra2 1 c0203 (LineNo 2 2)

schema sv10203C
archetype AI_CONV
sv10203C
schema_voice vserv1 1 c0203 (LineNo 3 3)

schema ex20203D
archetype AI_CONV
ex20203D
schema_voice vextra2 1 c0203 (LineNo 4 4)
	
schema sv10203E
archetype AI_CONV
sv10203E
schema_voice vserv1 1 c0203 (LineNo 5 5)

//-------------------------------------------------------

//////////////////////
//MISSION 4 - FRAMED//
//////////////////////
			
//c0402 - Cop bring in a suspect to the holding cell.
schema th10402A		//"You guys can't treat me like this..."
archetype AI_CONV
th10402A
schema_voice vthief1 1 c0402 (LineNo 1 1)

schema sg60402B
archetype AI_CONV
sg60402B
schema_voice vcop6 1 c0402 (LineNo 2 2)
			
schema th10402C	
archetype AI_CONV
th10402C
schema_voice vthief1 1 c0402 (LineNo 3 3)

schema sg60402D
archetype AI_CONV
sg60402D
schema_voice vcop6 1 c0402 (LineNo 4 4)

//-------------------------------------------------------

//c0403 - Cop harasses a Pagan in his cell.
schema sg50403A		//"You think your beloved..."
archetype AI_CONV
sg50403A
schema_voice vcop5 1 c0403 (LineNo 1 1)

schema pg10403B
archetype AI_CONV
pg10403B
schema_voice vpaganman 1 c0403 (LineNo 2 2)

schema sg50403C	
archetype AI_CONV
sg50403C
schema_voice vcop5 1 c0403 (LineNo 3 3)

//-------------------------------------------------------
	
//c0404 - Lady Rumford filling a report with one of the officers.
schema sg40404A		//"Okay, let's take it from the top.."
archetype AI_CONV
sg40404A
schema_voice vcop4 1 c0404 (LineNo 1 1)

schema no20404B
archetype AI_CONV
no20404B
schema_voice vnoble2 1 c0404 (LineNo 2 2)

schema sg40404C		
archetype AI_CONV
sg40404C
schema_voice vcop4 1 c0404 (LineNo 3 3)

schema no20404D
archetype AI_CONV
no20404D
schema_voice vnoble2 1 c0404 (LineNo 4 4)

schema sg40404E		
archetype AI_CONV
sg40404E
schema_voice vcop4 1 c0404 (LineNo 5 5)

schema no20404F
archetype AI_CONV
no20404F
schema_voice vnoble2 1 c0404 (LineNo 6 6)

//-------------------------------------------------------

//c0405 - A couple of cops talkin shop.
schema sg50405A		//"Did you hear about the raid..."	
archetype AI_CONV
sg50405A
schema_voice vcop5 1 c0405 (LineNo 1 1)

schema sg60405B
archetype AI_CONV
sg60405B
schema_voice vcop6 1 c0405 (LineNo 2 2)	

schema sg50405C
archetype AI_CONV
sg50405C
schema_voice vcop5 1 c0405 (LineNo 3 3)

schema sg60405D
archetype AI_CONV
sg60405D
schema_voice vcop6 1 c0405 (LineNo 4 4)

schema sg50405E	
archetype AI_CONV
sg50405E
schema_voice vcop5 1 c0405 (LineNo 5 5)

schema sg60405F
archetype AI_CONV
sg60405F
schema_voice vcop6 1 c0405 (LineNo 6 6)

schema sg50405G	
archetype AI_CONV
sg50405G
schema_voice vcop5 1 c0405 (LineNo 7 7)

schema sg60405H
archetype AI_CONV
sg60405H
schema_voice vcop6 1 c0405 (LineNo 8 8)

//-------------------------------------------------------

//c0406 - Cops talk more about shop.
schema sg30406A		//"How come we gotta pull guard duty?..."
archetype AI_CONV
sg30406A
schema_voice vcop3 1 c0406 (LineNo 1 1)

schema sg10406B
archetype AI_CONV
sg10406B
schema_voice vcop1 1 c0406 (LineNo 2 2)	

schema sg30406C
archetype AI_CONV
sg30406C
schema_voice vcop3 1 c0406 (LineNo 3 3)

schema sg10406D
archetype AI_CONV
sg10406D
schema_voice vcop1 1 c0406 (LineNo 4 4)

schema sg30406E
archetype AI_CONV
sg30406E
schema_voice vcop3 1 c0406 (LineNo 5 5)

schema sg10406F
archetype AI_CONV
sg10406F
schema_voice vcop1 1 c0406 (LineNo 6 6)

//-------------------------------------------------------

//c0407 - A Mechanists talks to a Cop about the security systems.
schema mc10407A		//"The Watcher is ready and operational..."
archetype AI_CONV
mc10407A
schema_voice vmech1 1 c0407 (LineNo 1 1)

schema sg50407B
archetype AI_CONV
sg50407B
schema_voice vcop5 1 c0407 (LineNo 2 2)	

schema mc10407C		
archetype AI_CONV
mc10407C
schema_voice vmech1 1 c0407 (LineNo 3 3)

schema sg50407D
archetype AI_CONV
sg50407D
schema_voice vcop5 1 c0407 (LineNo 4 4)	

schema mc10407E		
archetype AI_CONV
mc10407E
schema_voice vmech1 1 c0407 (LineNo 5 5)

schema sg50407F
archetype AI_CONV
sg50407F
schema_voice vcop5 1 c0407 (LineNo 6 6)	

schema mc10407G		
archetype AI_CONV
mc10407G
schema_voice vmech1 1 c0407 (LineNo 7 7)


//-------------------------------------------------------

//c0408 - Random prisoner mutterings.
schema th20408          //"I like the dark..."
archetype AI_CONV
th20408
schema_voice vthief2 1 c0408 (LineNo 1 1)

schema ex20408		//"There's no law in The City anymore.."
archetype AI_CONV
ex20408
schema_voice vextra2 1 c0409 (LineNo 1 1)

schema no10408		//"They put me here because I was urinating..."
archetype AI_CONV
no10408
schema_voice vprisoners 1 c0410 (LineNo 1 1)

schema ex10408		//"Life stinks and then you die..."
archetype AI_CONV
ex10408
schema_voice vextra1 1 c0411 (LineNo 1 1)


//-------------------------------------------------------

//////////////////////
//MISSION 5 - AMBUSH//
//////////////////////
	
//c0501 -Two Cops talk about finding Garrett.
schema sg60501A	  //"Remember men, his name is Garrett.."
archetype AI_CONV
sg60501A
schema_voice vcop6 1 c0501 (LineNo 1 1)

schema sg50501B
archetype AI_CONV
sg50501B
schema_voice vcop5 1 c0501 (LineNo 2 2)

schema sg60501C
archetype AI_CONV
sg60501C
schema_voice vcop6 1 c0501 (LineNo 3 3)

schema sg50501D
archetype AI_CONV
sg50501D
schema_voice vcop5 1 c0501 (LineNo 4 4)

schema sg60501E	  
archetype AI_CONV
sg60501E
schema_voice vcop6 1 c0501 (LineNo 5 5)

schema sg50501F
archetype AI_CONV
sg50501F
schema_voice vcop5 1 c0501 (LineNo 6 6)	

//-------------------------------------------------------

//c0502 -Two men talk about the war.
schema ex10502A	  //"What's the latest on the war, Rolley?.."
archetype AI_CONV
ex10502A
schema_voice vextra1 1 c0502 (LineNo 1 1)

schema no10502B
archetype AI_CONV
no10502B
schema_voice vnoble1 1 c0502 (LineNo 2 2)

schema ex10502C
archetype AI_CONV
ex10502C
schema_voice vextra1 1 c0502 (LineNo 3 3)

schema no10502D
archetype AI_CONV
no10502D
schema_voice vnoble1 1 c0502 (LineNo 4 4)

schema ex10502E	  
archetype AI_CONV
ex10502E
schema_voice vextra1 1 c0502 (LineNo 5 5)

//-------------------------------------------------------

//c0503 -Two women talk about Garretts ambush.
schema sv20503A		//"What's going on? The City Watch..."
archetype AI_CONV
sv20503A
schema_voice vserv2 1 c0503 (LineNo 1 1)

schema ex20503B	  
archetype AI_CONV
ex20503B
schema_voice vextra2 1 c0503 (LineNo 2 2)

schema sv20503C
archetype AI_CONV
sv20503C
schema_voice vserv2 1 c0503 (LineNo 3 3)

schema ex20503D	  
archetype AI_CONV
ex20503D
schema_voice vextra2 1 c0503 (LineNo 4 4)

schema sv20503E
archetype AI_CONV
sv20503E
schema_voice vserv2 1 c0503 (LineNo 5 5)

schema ex20503F	  
archetype AI_CONV
ex20503F
schema_voice vextra2 1 c0503 (LineNo 6 6)

schema sv20503G
archetype AI_CONV
sv20503G
schema_voice vserv2 1 c0503 (LineNo 7 7)
	
//-------------------------------------------------------

//c0504 -Prostitute talks to one of the patrolling watch guards.
schema no20504A		//"What's a big fella like you..." 
archetype AI_CONV
no20504A
schema_voice vnoble2 1 c0504 (LineNo 1 1)

schema sg30504B	  
archetype AI_CONV
sg30504B
schema_voice vguard3 1 c0504 (LineNo 2 2)

schema no20504C	
archetype AI_CONV
no20504C
schema_voice vnoble2 1 c0504 (LineNo 3 3)

schema sg30504D	  
archetype AI_CONV
sg30504D
schema_voice vguard3 1 c0504 (LineNo 4 4)

schema no20504E	
archetype AI_CONV
no20504E
schema_voice vnoble2 1 c0504 (LineNo 5 5)
	
//-------------------------------------------------------

/////////////////////////////
//MISSION 6 - EAVESDROPPING//
/////////////////////////////	

//c0601 -Missionaries	
schema mc10601A		//"Hail, Friend!"
archetype AI_CONV
mc10601A
schema_voice vmech1 1 c0601 (LineNo 1 1)

schema mc20601B	  
archetype AI_CONV
mc20601B
schema_voice vmech2 1 c0601 (LineNo 2 2)
	
schema mc10601C
archetype AI_CONV
mc10601C
schema_voice vmech1 1 c0601 (LineNo 3 3)

schema mc20601D	  
archetype AI_CONV
mc20601D
schema_voice vmech2 1 c0601 (LineNo 4 4)

//-------------------------------------------------------

//c0602 -Sleepy Karras
schema mc30602A		//"Hast thou seen our Father today?..."
archetype AI_CONV
mc30602A
schema_voice vmech3 1 c0602 (LineNo 1 1)

schema mc20602B	  
archetype AI_CONV
mc20602B
schema_voice vmech2 1 c0602 (LineNo 2 2)

schema mc30602C		
archetype AI_CONV
mc30602C
schema_voice vmech3 1 c0602 (LineNo 3 3)

schema mc20602D	  
archetype AI_CONV
mc20602D
schema_voice vmech2 1 c0602 (LineNo 4 4)

//-------------------------------------------------------

//c0603 - Inventors Collaborating	
schema mc10603A		//"A pox upon it!..."
archetype AI_CONV
mc10603A
schema_voice vmech1 1 c0603 (LineNo 1 1)

schema mc40603B	  
archetype AI_CONV
mc40603B
schema_voice vmech4 1 c0603 (LineNo 2 2)

schema mc10603C
archetype AI_CONV
mc10603C
schema_voice vmech1 1 c0603 (LineNo 3 3)

schema mc40603D	  
archetype AI_CONV
mc40603D
schema_voice vmech4 1 c0603 (LineNo 4 4)

schema mc10603E
archetype AI_CONV
mc10603E
schema_voice vmech1 1 c0603 (LineNo 5 5)

schema mc40603F
archetype AI_CONV
mc40603F
schema_voice vmech4 1 c0603 (LineNo 6 6)

schema mc10603G
archetype AI_CONV
mc10603G
schema_voice vmech1 1 c0603 (LineNo 7 7)

//-------------------------------------------------------

//c0604 - Used to be a Hammer		
schema mc20604A		//"Thou'rt new to the Movement, Friend."
archetype AI_CONV
mc20604A
schema_voice vmech2 1 c0604 (LineNo 1 1)

schema mc10604B	  
archetype AI_CONV
mc10604B
schema_voice vmech1 1 c0604 (LineNo 2 2)

schema mc20604C		
archetype AI_CONV
mc20604C
schema_voice vmech2 1 c0604 (LineNo 3 3)

schema mc10604D	  
archetype AI_CONV
mc10604D
schema_voice vmech1 1 c0604 (LineNo 4 4)

schema mc20604E		
archetype AI_CONV
mc20604E
schema_voice vmech2 1 c0604 (LineNo 5 5)

schema mc10604F
archetype AI_CONV
mc10604F
schema_voice vmech1 1 c0604 (LineNo 6 6)

//-------------------------------------------------------

//c0605 - Hammers are Shabby	
schema mc40605A		//"Hast thou been back to our old haunts."
archetype AI_CONV
mc40605A
schema_voice vmech4 1 c0605 (LineNo 1 1)

schema mc20605B		
archetype AI_CONV
mc20605B
schema_voice vmech2 1 c0605 (LineNo 2 2)

schema mc40605C
archetype AI_CONV
mc40605C
schema_voice vmech4 1 c0605 (LineNo 3 3)

schema mc20605D		
archetype AI_CONV
mc20605D
schema_voice vmech2 1 c0605 (LineNo 4 4)

schema mc40605E
archetype AI_CONV
mc40605E
schema_voice vmech4 1 c0605 (LineNo 5 5)

schema mc20605F
archetype AI_CONV
mc20605F
schema_voice vmech2 1 c0605 (LineNo 6 6)

//-------------------------------------------------------

//c0606 - Scared of Robots
schema mc30606A		//"I tell thee, for thou art my friend..."
archetype AI_CONV
mc30606A
schema_voice vmech3 1 c0606 (LineNo 1 1)

schema mc10606B		
archetype AI_CONV
mc10606B
schema_voice vmech1 1 c0606 (LineNo 2 2)

schema mc30606C
archetype AI_CONV
mc30606C
schema_voice vmech3 1 c0606 (LineNo 3 3)

schema mc10606D
archetype AI_CONV
mc10606D
schema_voice vmech1 1 c0606 (LineNo 4 4)

schema mc30606E
archetype AI_CONV
mc30606E
schema_voice vmech3 1 c0606 (LineNo 5 5)

schema mc10606F
archetype AI_CONV
delay 2000
mc10606F
schema_voice vmech1 1 c0606 (LineNo 6 6)

//-------------------------------------------------------

//c0607 - Big Meeting Happening Today
schema mc10607A		//"Dost thou know whether the Sheriff hath arrived?"
archetype AI_CONV
mc10607A
schema_voice vmech1 1 c0607 (LineNo 1 1)

schema mc20607B		
archetype AI_CONV
mc20607B
schema_voice vmech2 1 c0607 (LineNo 2 2)

schema mc10607C	
archetype AI_CONV
mc10607C
schema_voice vmech1 1 c0607 (LineNo 3 3)

schema mc20607D		
archetype AI_CONV
mc20607D
schema_voice vmech2 1 c0607 (LineNo 4 4)

schema mc10607E	
archetype AI_CONV
mc10607E
schema_voice vmech1 1 c0607 (LineNo 5 5)

//-------------------------------------------------------

//c0608 - Screw The Builder
schema mc30608A		//"My friend!  Where wert thou last night?"
archetype AI_CONV
mc30608A
schema_voice vmech3 1 c0608 (LineNo 1 1)

schema mc40608B		
archetype AI_CONV
mc40608B
schema_voice vmech4 1 c0608 (LineNo 2 2)

schema mc30608C
archetype AI_CONV
mc30608C
schema_voice vmech3 1 c0608 (LineNo 3 3)

schema mc40608D		
archetype AI_CONV
mc40608D
schema_voice vmech4 1 c0608 (LineNo 4 4)

schema mc30608E
archetype AI_CONV
mc30608E
schema_voice vmech3 1 c0608 (LineNo 5 5)


//-------------------------------------------------------

////////////////////
//MISSION 7 - BANK//
////////////////////	
	
//c0701 - Picking on customers	
schema sg10701A		//"Night shift again, Mart?..."
archetype AI_CONV
sg10701A
schema_voice vguard1 1 c0701 (LineNo 1 1)

schema sg50701B		
archetype AI_CONV
sg50701B
schema_voice vguard5 1 c0701 (LineNo 2 2)

schema sg10701C
archetype AI_CONV
sg10701C
schema_voice vguard1 1 c0701 (LineNo 3 3)

schema sg50701D		
archetype AI_CONV
sg50701D
schema_voice vguard5 1 c0701 (LineNo 4 4)

//-------------------------------------------------------

//c0702 - Where does the bank get money
schema sg30702A		//"You ever wonder, looking at all this?"
archetype AI_CONV
sg30702A
schema_voice vguard3 1 c0702 (LineNo 1 1)

schema sg50702B		
archetype AI_CONV
sg50702B
schema_voice vguard5 1 c0702 (LineNo 2 2)

schema sg30702C		
archetype AI_CONV
sg30702C
schema_voice vguard3 1 c0702 (LineNo 3 3)

schema sg50702D		
archetype AI_CONV
sg50702D
schema_voice vguard5 1 c0702 (LineNo 4 4)

schema sg30702E	
archetype AI_CONV
sg30702E
schema_voice vguard3 1 c0702 (LineNo 5 5)

schema sg50702F		
archetype AI_CONV
sg50702F
schema_voice vguard5 1 c0702 (LineNo 6 6)

schema sg30702G
archetype AI_CONV
sg30702G
schema_voice vguard3 1 c0702 (LineNo 7 7)

//-------------------------------------------------------

//c0703 - Why the uniforms?	
schema sg40703A		//"You know, I been wondering."
archetype AI_CONV
sg40703A
schema_voice vguard4 1 c0703 (LineNo 1 1)

schema sg60703B		
archetype AI_CONV
sg60703B
schema_voice vguard6 1 c0703 (LineNo 2 2)

schema sg40703C	
archetype AI_CONV
sg40703C
schema_voice vguard4 1 c0703 (LineNo 3 3)

schema sg60703D		
archetype AI_CONV
sg60703D
schema_voice vguard6 1 c0703 (LineNo 4 4)

//-------------------------------------------------------

//c0704 - New Boots
schema sg20704A		//"Mud and blast and bother!"
archetype AI_CONV
sg20704A
schema_voice vguard2 1 c0704 (LineNo 1 1)

schema sg10704B		
archetype AI_CONV
sg10704B
schema_voice vguard1 1 c0704 (LineNo 2 2)

schema sg20704C
archetype AI_CONV
sg20704C
schema_voice vguard2 1 c0704 (LineNo 3 3)

schema sg10704D		
archetype AI_CONV
sg10704D
schema_voice vguard1 1 c0704 (LineNo 4 4)	

schema sg20704E	
archetype AI_CONV
sg20704E
schema_voice vguard2 1 c0704 (LineNo 5 5)

//-------------------------------------------------------

//c0705 - Guard and Banker
schema no10705A		//"[frightened]  Ahh!"
archetype AI_CONV
no10705A
schema_voice vnoble1 1 c0705 (LineNo 1 1)

schema sg30705B		
archetype AI_CONV
sg30705B
schema_voice vguard3 1 c0705 (LineNo 2 2)

schema no10705C
archetype AI_CONV
no10705C
schema_voice vnoble1 1 c0705 (LineNo 3 3)

schema sg30705D		
archetype AI_CONV
sg30705D
schema_voice vguard3 1 c0705 (LineNo 4 4)
	
schema no10705E		
archetype AI_CONV
no10705E
schema_voice vnoble1 1 c0705 (LineNo 5 5)

schema sg30705F		
archetype AI_CONV
sg30705F
schema_voice vguard3 1 c0705 (LineNo 6 6)

schema no10705G	
archetype AI_CONV
no10705G
schema_voice vnoble1 1 c0705 (LineNo 7 7)

schema sg30705H		
archetype AI_CONV
sg30705H
schema_voice vguard3 1 c0705 (LineNo 8 8)

schema no10705I	
archetype AI_CONV
no10705I
schema_voice vnoble1 1 c0705 (LineNo 9 9)

//-------------------------------------------------------	

//c0706 -Robots looping conversation	
schema rb10706A		//"I do not know...Be it true that..."
archetype AI_CONV
rb10706A
schema_voice vworkerbot 1 c0706 (LineNo 1 1)

schema rb10706B		
archetype AI_CONV
rb10706B
schema_voice vworkerbot 1 c0706 (LineNo 2 2)

schema rb10706C	
archetype AI_CONV
rb10706C
schema_voice vworkerbot 1 c0706 (LineNo 3 3)

schema rb10706D		
archetype AI_CONV
rb10706D
schema_voice vworkerbot 1 c0706 (LineNo 4 4)

schema rb10706E	
archetype AI_CONV
rb10706E
schema_voice vworkerbot 1 c0706 (LineNo 5 5)

schema rb10706F		
archetype AI_CONV
rb10706F
schema_voice vworkerbot 1 c0706 (LineNo 6 6)

schema rb10706G	
archetype AI_CONV
rb10706G
schema_voice vworkerbot 1 c0706 (LineNo 7 7)

schema rb10706H		
archetype AI_CONV
rb10706H
schema_voice vworkerbot 1 c0706 (LineNo 8 8)

//-------------------------------------------------------

///////////////////////
//MISSION 8 - COURIER//
///////////////////////	

//c0801 -Cemeteries	
schema mc40801A		//"We dare'st not venture in there.."
archetype AI_CONV
mc40801A
schema_voice vmech4 1 c0801 (LineNo 1 1)

schema mc20801B	
archetype AI_CONV
mc20801B
schema_voice vmech2 1 c0801 (LineNo 2 2)

schema mc40801C	
archetype AI_CONV
mc40801C
schema_voice vmech4 1 c0801 (LineNo 3 3)

schema mc20801D	
archetype AI_CONV
mc20801D
schema_voice vmech2 1 c0801 (LineNo 4 4)

//-------------------------------------------------------
	
//c0802 - Street Walker is brought in	
schema no20802A		//"Well well.  If it ain't Officer Coranth..."
archetype AI_CONV
no20802A
schema_voice vnoble2 1 c0802 (LineNo 1 1)

schema sg40802B	
archetype AI_CONV
sg40802B
schema_voice vcop4 1 c0802 (LineNo 2 2)

schema no20802C
archetype AI_CONV
no20802C
schema_voice vnoble2 1 c0802 (LineNo 3 3)

schema sg40802D	
archetype AI_CONV
sg40802D
schema_voice vcop4 1 c0802 (LineNo 4 4)

schema no20802E	
archetype AI_CONV
no20802E
schema_voice vnoble2 1 c0802 (LineNo 5 5)

schema sg40802F	
archetype AI_CONV
sg40802F
schema_voice vcop4  1 c0802 (LineNo 6 6)

schema no20802G
archetype AI_CONV
no20802G
schema_voice vnoble2 1 c0802 (LineNo 7 7)

//-------------------------------------------------------

/////////////////////////
//MISSION 9 - BLACKMAIL//
/////////////////////////
			
//c0901 - Investigation	
schema sg50901A		//"How could the killer make his way..?"
archetype AI_CONV
sg50901A
schema_voice vcop5 1 c0901 (LineNo 1 1)

schema sg60901B	
archetype AI_CONV
sg60901B
schema_voice vcop6 1 c0901 (LineNo 2 2)

schema sg50901C		
archetype AI_CONV
sg50901C
schema_voice vcop5 1 c0901 (LineNo 3 3)

schema sg60901D	
archetype AI_CONV
sg60901D
schema_voice vcop6 1 c0901 (LineNo 4 4)

schema sg50901E
archetype AI_CONV
sg50901E
schema_voice vcop5 1 c0901 (LineNo 5 5)

schema sg60901F	
archetype AI_CONV
sg60901F
schema_voice vcop6 1 c0901 (LineNo 6 6)

schema sg50901G		
archetype AI_CONV
sg50901G
schema_voice vcop5 1 c0901 (LineNo 7 7)

schema sg60901H	
archetype AI_CONV
sg60901H
schema_voice vcop6 1 c0901 (LineNo 8 8)

//-------------------------------------------------------

//c0902 - Guards talk food
schema sg20902A		//"[drunk] Hey, did you try any of that..."
archetype AI_CONV
sg20902A
schema_voice vguard2 1 c0902 (LineNo 1 1)

schema sg40902B	
archetype AI_CONV
sg40902B
schema_voice vguard4 1 c0902 (LineNo 2 2)
	
schema sg20902C
archetype AI_CONV
sg20902C
schema_voice vguard2 1 c0902 (LineNo 3 3)

schema sg40902D
archetype AI_CONV
sg40902D
schema_voice vguard4 1 c0902 (LineNo 4 4)

schema sg20902E
archetype AI_CONV
sg20902E
schema_voice vguard2 1 c0902 (LineNo 5 5)

//-------------------------------------------------------

//c0903 -Sheriff is dead!	
schema sg50903A		//"Hurry! Sound the alarms! Seal off the area! "	
archetype AI_CONV
sg50903A
schema_voice vcop5 1 c0903 (LineNo 1 1)

schema sg60903B
archetype AI_CONV
sg60903B
schema_voice vcop6 1 c0903 (LineNo 2 2)

schema sg50903C			
archetype AI_CONV
sg50903C
schema_voice vcop5 1 c0903 (LineNo 3 3)

schema sg60903D
archetype AI_CONV
sg60903D
schema_voice vcop6 1 c0903 (LineNo 4 4)

schema sg50903E			
archetype AI_CONV
sg50903E
schema_voice vcop5 1 c0903 (LineNo 5 5)

schema sg60903F
archetype AI_CONV
sg60903F
schema_voice vcop6 1 c0903 (LineNo 6 6)

//-------------------------------------------------------
		
//c0904 - Servants 	
schema sv20904A		//"Can you believe this mess..." 	
archetype AI_CONV
sv20904A
schema_voice vserv2 1 c0904 (LineNo 1 1)

schema sv10904B
archetype AI_CONV
sv10904B
schema_voice vserv1 1 c0904 (LineNo 2 2)

schema sv20904C		
archetype AI_CONV
sv20904C
schema_voice vserv2 1 c0904 (LineNo 3 3)

schema sv10904D
archetype AI_CONV
sv10904D
schema_voice vserv1 1 c0904 (LineNo 4 4)

schema sv20904E	
archetype AI_CONV
sv20904E
schema_voice vserv2 1 c0904 (LineNo 5 5)

schema sv10904F
archetype AI_CONV
sv10904F
schema_voice vserv1 1 c0904 (LineNo 6 6)

//-------------------------------------------------------

//c0905 -Spilt mead
schema sg30905A		//"[drunk] I can't believe that..." 
archetype AI_CONV
sg30905A
schema_voice vdrunk1 1 c0905 (LineNo 1 1)

schema sv20905B
archetype AI_CONV
sv20905B
schema_voice vserv2 1 c0905 (LineNo 2 2)

schema sg30905C		
archetype AI_CONV
sg30905C
schema_voice vdrunk1 1 c0905 (LineNo 3 3)

schema sv20905D
archetype AI_CONV
sv20905D
schema_voice vserv2 1 c0905 (LineNo 4 4)

schema sg30905E		
archetype AI_CONV
sg30905E
schema_voice vdrunk1 1 c0905 (LineNo 5 5)

schema sv20905F
archetype AI_CONV
sv20905F
schema_voice vserv2 1 c0905 (LineNo 6 6)	

//-------------------------------------------------------

//c0906 -Guards	
schema sg60906A		//"I heard a commotion coming from Truart's.."
archetype AI_CONV
sg60906A
schema_voice vguard6 1 c0906 (LineNo 1 1)

schema sg40906B
archetype AI_CONV
sg40906B
schema_voice vguard4 1 c0906 (LineNo 2 2)

schema sg60906C		
archetype AI_CONV
sg60906C
schema_voice vguard6 1 c0906 (LineNo 3 3)

schema sg40906D
archetype AI_CONV
sg40906D
schema_voice vguard4 1 c0906 (LineNo 4 4)

schema sg60906E
archetype AI_CONV
sg60906E
schema_voice vguard6 1 c0906 (LineNo 5 5)

//-------------------------------------------------------

///////////////////////////////
//MISSION 10 - TRAIL OF BLOOD//
///////////////////////////////
			

//c1001 -[ghosts] A little girl and Mother appear...
schema pg31001A		//"You cans have this, I don't needs it any more.."
archetype AI_CONV
volume -750
pg31001A
schema_voice vpagangirl 1 c1001 (LineNo 1 1)

schema pg21001B
archetype AI_CONV
volume -500
pg21001B
schema_voice vpaganwom  1 c1001 (LineNo 2 2)

schema pg31001C	
archetype AI_CONV
volume -750
pg31001C
schema_voice vpagangirl 1 c1001 (LineNo 3 3)

schema pg21001D
archetype AI_CONV
volume -500
pg21001D
schema_voice vpaganwom  1 c1001 (LineNo 4 4)

schema pg31001E		
archetype AI_CONV
volume -750
pg31001E
schema_voice vpagangirl 1 c1001 (LineNo 5 5)

//-------------------------------------------------------

//c1002 -[ghost] A man is working in the garden.
schema pg11002A		//"What?! You! Gets the childrens..."
archetype AI_CONV
volume -500
pg11002A
schema_voice vpaganman  1 c1002 (LineNo 1 1)

//-------------------------------------------------------

//c1003 -[ghosts] A man and a woman stand before their fireplace, praying to the woodsie lord, they get more and more agitated, until finally their death blows come from an unseen [or a mechanist] assailant.	

schema pg21003A		//"He ams the honeymaker." 
archetype AI_CONV
volume -500
pg21003A
schema_voice vpaganwom  1 c1003 (LineNo 1 1)

schema pg11003B		
archetype AI_CONV
volume -500
pg11003B
schema_voice vpaganman 1 c1003 (LineNo 2 2)

schema pg21003C
archetype AI_CONV
volume -500
pg21003C
schema_voice vpaganwom  1 c1003 (LineNo 3 3)

schema pg11003D		
archetype AI_CONV
volume -500
pg11003D
schema_voice vpaganman 1 c1003 (LineNo 4 4)

schema pg21003E
archetype AI_CONV
volume -500
pg21003E
schema_voice vpaganwom  1 c1003 (LineNo 5 5)

schema pg11003F		
archetype AI_CONV
volume -500
pg11003F
schema_voice vpaganman 1 c1003 (LineNo 6 6)

//-------------------------------------------------------

//c1004 -[ghosts] Two mechanist apparitions talk about pagans.
schema mc11004A		//"Check thy map, several have escaped ..."
archetype AI_CONV
volume -500
mc11004A
schema_voice vmech1  1 c1004 (LineNo 1 1)

schema mc21004B		
archetype AI_CONV
volume -500
mc21004B
schema_voice vmech2 1 c1004 (LineNo 2 2)

schema mc11004C
archetype AI_CONV
volume -500
mc11004C
schema_voice vmech1  1 c1004 (LineNo 3 3)

schema mc21004D		
archetype AI_CONV
volume -500
mc21004D
schema_voice vmech2 1 c1004 (LineNo 4 4)

//-------------------------------------------------------

//c1005 [ghosts] A pagan man searches a chest...
schema pg11005A		//"I knows it was here. I knows it.."
archetype AI_CONV
volume -500
pg11005A
schema_voice vpaganman  1 c1005 (LineNo 1 1)

schema mc31005B		
archetype AI_CONV
volume -500
mc31005B
schema_voice vmech3 1 c1005 (LineNo 2 2)

schema pg11005C	
archetype AI_CONV
volume -500
pg11005C
schema_voice vpaganman  1 c1005 (LineNo 3 3)

schema mc31005D		
archetype AI_CONV
volume -500
mc31005D
schema_voice vmech3 1 c1005 (LineNo 4 4)

//-------------------------------------------------------

//c1006 [ghosts] A pagan family at the Gathering Place puzzle
schema pg21006A		//"Comes now, Birch.  We’ve lit the lights.."
archetype AI_CONV
volume -500
pg21006A
schema_voice vpaganwom  1 c1006  (LineNo 1 1)

schema pg11006B		
archetype AI_CONV
volume -500
pg11006B
schema_voice vpaganman 1 c1006  (LineNo 2 2)

schema pg21006C	
archetype AI_CONV
volume -500
pg21006C
schema_voice vpaganwom  1 c1006  (LineNo 3 3)

schema pg11006D
archetype AI_CONV
volume -500
pg11006D
schema_voice vpaganman 1 c1006  (LineNo 4 4)

schema pg21006E
archetype AI_CONV
volume -500
pg21006E
schema_voice vpaganwom  1 c1006  (LineNo 5 5)

//-------------------------------------------------------

//c1007 Apebeast conversation in the tree village.
schema ab11007A			//"Seesy you…mines plumsees?"
archetype AI_CONV
ab11007A
schema_voice vape1 1 c1007  (LineNo 1 1)

schema ab21007B	
archetype AI_CONV
ab21007B
schema_voice vape2  1 c1007  (LineNo 2 2)	

schema ab11007C			
archetype AI_CONV
ab11007C
schema_voice vape1 1 c1007  (LineNo 3 3)

schema ab21007D	
archetype AI_CONV
ab21007D
schema_voice vape2  1 c1007  (LineNo 4 4)

schema ab11007E
archetype AI_CONV
ab11007E
schema_voice vape1 1 c1007  (LineNo 5 5)

//-------------------------------------------------------

//c1008 -Apebeast conversation in the tree village.
schema ab21008A		//"Guardsies you winters, eh, eh?"
archetype AI_CONV
ab21008A
schema_voice vape2  1 c1008  (LineNo 1 1)

schema ab11008B
archetype AI_CONV
ab11008B
schema_voice vape1 1 c1008  (LineNo 2 2)

schema ab21008C
archetype AI_CONV
ab21008C
schema_voice vape2  1 c1008  (LineNo 3 3)

schema ab11008D
archetype AI_CONV
ab11008D
schema_voice vape1 1 c1008  (LineNo 4 4)

schema ab21008E
archetype AI_CONV
ab21008E
schema_voice vape2  1 c1008  (LineNo 5 5)

schema ab11008F
archetype AI_CONV
ab11008F
schema_voice vape1 1 c1008  (LineNo 6 6)

//-------------------------------------------------------

//////////////////////////////////
//MISSION 11 - LIFE OF THE PARTY//
//////////////////////////////////
			
//c1101 -Stand off
schema sg11101A		//"...And I'm telling you.."
archetype AI_CONV
sg11101A
schema_voice vguard1  1 c1101  (LineNo 1 1)

schema sg51101B
archetype AI_CONV
sg51101B
schema_voice vguard5 1 c1101  (LineNo 2 2)

schema sg11101C		
archetype AI_CONV
sg11101C
schema_voice vguard1  1 c1101  (LineNo 3 3)

schema sg51101D
archetype AI_CONV
sg51101D
schema_voice vguard5 1 c1101  (LineNo 4 4)

schema sg11101E		
archetype AI_CONV
sg11101E
schema_voice vguard1  1 c1101  (LineNo 5 5)

schema sg51101F
archetype AI_CONV
sg51101F
schema_voice vguard5 1 c1101  (LineNo 6 6)

schema sg11101G		
archetype AI_CONV
sg11101G
schema_voice vguard1  1 c1101  (LineNo 7 7)

schema sg51101H
archetype AI_CONV
sg51101H
schema_voice vguard5 1 c1101  (LineNo 8 8)	

//-------------------------------------------------------

//c1102 -Snookums	
schema no11102A		//"But it's just not fair..."
archetype AI_CONV
no11102A
schema_voice vnoble1 1 c1102 (LineNo 1 1)	

schema no21102B
archetype AI_CONV
no21102B
schema_voice vnoble2 1 c1102 (LineNo 2 2)	

schema no11102C		
archetype AI_CONV
no11102C
schema_voice vnoble1 1 c1102 (LineNo 3 3)	

schema no21102D
archetype AI_CONV
no21102D
schema_voice vnoble2 1 c1102 (LineNo 4 4)	

schema no11102E	
archetype AI_CONV
no11102E
schema_voice vnoble1 1 c1102 (LineNo 5 5)	

schema no21102F
archetype AI_CONV
no21102F
schema_voice vnoble2 1 c1102 (LineNo 6 6)

schema no11102G		
archetype AI_CONV
no11102G
schema_voice vnoble1 1 c1102 (LineNo 7 7)	

schema no21102H
archetype AI_CONV
no21102H
schema_voice vnoble2 1 c1102 (LineNo 8 8)	

schema no11102I
archetype AI_CONV
no11102I
schema_voice vnoble1 1 c1102 (LineNo 9 9)	

//-------------------------------------------------------

//c1103 -Not slaves…servants.	
schema no11103A		//"That's the point, Margaret...." 
archetype AI_CONV
no11103A
schema_voice vnoble1 1 c1103 (LineNo 1 1)	

schema no21103B
archetype AI_CONV
no21103B
schema_voice vnoble2 1 c1103 (LineNo 2 2)

schema no11103C		
archetype AI_CONV
no11103C
schema_voice vnoble1 1 c1103 (LineNo 3 3)	

schema no21103D
archetype AI_CONV
no21103D
schema_voice vnoble2 1 c1103 (LineNo 4 4)

schema no11103E		
archetype AI_CONV
no11103E
schema_voice vnoble1 1 c1103 (LineNo 5 5)	

schema no21103F
archetype AI_CONV
no21103F
schema_voice vnoble2 1 c1103 (LineNo 6 6)

//-------------------------------------------------------

//c1104 -Strange times	
schema mc11104A		//"Hmph. These are strange times indeed.."
archetype AI_CONV
mc11104A
schema_voice vmech1 1 c1104 (LineNo 1 1)	

schema mc41104B
archetype AI_CONV
mc41104B
schema_voice vmech4 1 c1104 (LineNo 2 2)

schema mc11104C		
archetype AI_CONV
mc11104C
schema_voice vmech1 1 c1104 (LineNo 3 3)	

schema mc41104D
archetype AI_CONV
mc41104D
schema_voice vmech4 1 c1104 (LineNo 4 4)

schema mc11104E
archetype AI_CONV
mc11104E
schema_voice vmech1 1 c1104 (LineNo 5 5)	

schema mc41104F
archetype AI_CONV
mc41104F
schema_voice vmech4 1 c1104 (LineNo 6 6)

//-------------------------------------------------------

//c1105 - Thieves Break in
schema th11105A		//"Quiet, you lumbering ox!..."
archetype AI_CONV
th11105A
schema_voice vthief1 1 c1105 (LineNo 1 1)	

schema th21105B
archetype AI_CONV
th21105B
schema_voice vthief2 1 c1105 (LineNo 2 2)

schema th11105C		
archetype AI_CONV
th11105C
schema_voice vthief1 1 c1105 (LineNo 3 3)	

schema th21105D
archetype AI_CONV
th21105D
schema_voice vthief2 1 c1105 (LineNo 4 4)

schema th11105E		
archetype AI_CONV
th11105E
schema_voice vthief1 1 c1105 (LineNo 5 5)	

schema th21105F
archetype AI_CONV
th21105F
schema_voice vthief2 1 c1105 (LineNo 6 6)

schema th11105G		
archetype AI_CONV
th11105G
schema_voice vthief1 1 c1105 (LineNo 7 7)	

//-------------------------------------------------------

///////////////////////
//MISSION 12 - CASING//
///////////////////////

//c1201 -Smart & Dumb guards' last stand.
schema sg31201A		//"Hello up there. How goes your watch?"
archetype AI_CONV
sg31201A
schema_voice vguard3 1 c1201 (LineNo 1 1)

schema sg11201B		
archetype AI_CONV
sg11201B
schema_voice vguard1 1 c1201 (LineNo 2 2)	

schema sg31201C	
archetype AI_CONV
sg31201C
schema_voice vguard3 1 c1201 (LineNo 3 3)

schema sg11201D		
archetype AI_CONV
sg11201D
schema_voice vguard1 1 c1201 (LineNo 4 4)	

schema sg31201E	
archetype AI_CONV
sg31201E
schema_voice vguard3 1 c1201 (LineNo 5 5)

schema sg11201F		
archetype AI_CONV
sg11201F
schema_voice vguard1 1 c1201 (LineNo 6 6)	

schema sg31201G	
archetype AI_CONV
sg31201G
schema_voice vguard3 1 c1201 (LineNo 7 7)

schema sg11201H		
archetype AI_CONV
sg11201H
schema_voice vguard1 1 c1201 (LineNo 8 8)	

//-------------------------------------------------------

//c1202 -Error in judgement
schema mc41202A		//"Sgt Porter, it would'st appear..."
archetype AI_CONV
mc41202A
schema_voice vmech4 1 c1202 (LineNo 1 1)

schema sg21202B		
archetype AI_CONV
sg21202B
schema_voice vguard2 1 c1202 (LineNo 2 2)	

schema mc41202C	
archetype AI_CONV
mc41202C
schema_voice vmech4 1 c1202 (LineNo 3 3)

schema sg21202D		
archetype AI_CONV
sg21202D
schema_voice vguard2 1 c1202 (LineNo 4 4)	

schema mc41202E	
archetype AI_CONV
mc41202E
schema_voice vmech4 1 c1202 (LineNo 5 5)

schema sg21202F		
archetype AI_CONV
sg21202F
schema_voice vguard2 1 c1202 (LineNo 6 6)	

//-------------------------------------------------------

//c1203 -PRIEST & MASKED SLAVE
schema mc21203A		//"Aah, child.  Did'st not hear thee..."	
archetype AI_CONV
mc21203A
schema_voice vmech2 1 c1203 (LineNo 1 1)	

schema ms11203B		
archetype AI_CONV
ms1a0wh5 ms1a0wh7
schema_voice vslave 1 c1203 (LineNo 2 2)

schema mc21203C		
archetype AI_CONV
mc21203C
schema_voice vmech2 1 c1203 (LineNo 3 3)	

schema ms11203D		
archetype AI_CONV
ms1a0wh1 ms1a0wh2
schema_voice vslave 1 c1203 (LineNo 4 4)	

schema mc21203E		
archetype AI_CONV
mc21203E
schema_voice vmech2 1 c1203 (LineNo 5 5)	

schema ms11203F		
archetype AI_CONV
ms1a0whA ms1a0whC
schema_voice vslave 1 c1203 (LineNo 6 6)	

schema mc21203G		
archetype AI_CONV
mc21203G
schema_voice vmech2 1 c1203 (LineNo 7 7)	

schema ms11203H		
archetype AI_CONV
ms1a0whB
schema_voice vslave 1 c1203 (LineNo 8 8)	

schema mc21203I		
archetype AI_CONV
mc21203I
schema_voice vmech2 1 c1203 (LineNo 9 9)	

//-------------------------------------------------------

//FEMALE APPARITION APPEARS 5 TIMES IN HAUNTED LIBRARY
//"Nobody knows. Nobody sees.."
schema gho1204A
archetype AI_CONV
gho1204A
schema_voice vghost 1 c1204 (LineNo 1 1)

//"Love. To think it was all for love!"
schema gho1204B
archetype AI_CONV
gho1204B
schema_voice vghost 1 c1206 (LineNo 1 1)

//"Nobody reads books these days."
schema gho1204C
archetype AI_CONV
gho1204C
schema_voice vghost 1 c1207 (LineNo 1 1)

//"Terrible secrets..."
schema gho1204D
archetype AI_CONV
gho1204D
schema_voice vghost 1 c1208 (LineNo 1 1)

//"How long?  How long???"
schema gho1204E
archetype AI_CONV
gho1204E
schema_voice vghost 1 c1209 (LineNo 1 1)

//-------------------------------------------------------

//c1205 - Guard & Librarian	
schema sg41205A		//"You mean you lost a whole stack of books?"
archetype AI_CONV
sg41205A
schema_voice vguard4 1 c1205 (LineNo 1 1)	

schema ex11205B		
archetype AI_CONV
ex11205B
schema_voice vextra1 1 c1205 (LineNo 2 2)	

schema sg41205C	
archetype AI_CONV
sg41205C
schema_voice vguard4 1 c1205 (LineNo 3 3)	

schema ex11205D		
archetype AI_CONV
ex11205D
schema_voice vextra1 1 c1205 (LineNo 4 4)	

schema sg41205E
archetype AI_CONV
sg41205E
schema_voice vguard4 1 c1205 (LineNo 5 5)	

schema ex11205F		
archetype AI_CONV
ex11205F
schema_voice vextra1 1 c1205 (LineNo 6 6)	

schema sg41205G		
archetype AI_CONV
sg41205G
schema_voice vguard4 1 c1205 (LineNo 7 7)	

schema ex11205H
archetype AI_CONV
ex11205H
schema_voice vextra1 1 c1205 (LineNo 8 8)	

//-------------------------------------------------------

//////////////////////
//MISSION 13 - MASKS//
//////////////////////

//c1301 -Complaining about the mechanists moving in.
schema sv11301A		//"Father Norrell, what's wrong?"
archetype AI_CONV
sv11301A
schema_voice vserv1 1 c1301 (LineNo 1 1)	

schema hm11301B
archetype AI_CONV
hm11301B
schema_voice vhammer1 1 c1301 (LineNo 2 2)	

schema sv11301C
archetype AI_CONV
sv11301C
schema_voice vserv1 1 c1301 (LineNo 3 3)	

schema hm11301D
archetype AI_CONV
hm11301D
schema_voice vhammer1 1 c1301 (LineNo 4 4)

schema sv11301E
archetype AI_CONV
sv11301E
schema_voice vserv1 1 c1301 (LineNo 5 5)	

schema hm11301F
archetype AI_CONV
hm11301F
schema_voice vhammer1 1 c1301 (LineNo 6 6)

schema sv11301G
archetype AI_CONV
sv11301G
schema_voice vserv1 1 c1301 (LineNo 7 7)	

schema hm11301H
archetype AI_CONV
hm11301H
schema_voice vhammer1 1 c1301 (LineNo 8 8)

//-------------------------------------------------------
			
//c1302 -Guard & Librarian Cont.	
schema sg41302A		//"You find your stack of books yet?"
archetype AI_CONV
sg41302A
schema_voice vguard4 1 c1302 (LineNo 1 1)	

schema ex11302B		
archetype AI_CONV
ex11302B
schema_voice vextra1 1 c1302 (LineNo 2 2)	

schema sg41302C
archetype AI_CONV
sg41302C
schema_voice vguard4 1 c1302 (LineNo 3 3)	

schema ex11302D		
archetype AI_CONV
ex11302D
schema_voice vextra1 1 c1302 (LineNo 4 4)	

schema sg41302E
archetype AI_CONV
sg41302E
schema_voice vguard4 1 c1302 (LineNo 5 5)

//-------------------------------------------------------

///////////////////////////////
//MISSION 14 - PRECIOUS CARGO//
///////////////////////////////

//c1401 - Garrett & PaganLotus Conversation
schema gar1401A_Fake		//"Lotus?"
archetype AI_CONV
volume -3000
gar1401A
schema_voice vnull 1 c1401 (LineNo 1 1)

schema pg11401B		//"Still I breathes, Mechanist."
archetype AI_CONV
pg11401B
schema_voice vpaganman 1 c1401 (LineNo 2 2)

schema gar1401C_Fake		//"I'm no Mechanist.  I'm Garrett."
archetype AI_CONV
volume -3000
gar1401C
schema_voice vnull 1 c1401 (LineNo 3 3)
			
schema pg11401D		//"Garrett. Yes, the lady knows me you would come."	
archetype AI_CONV
pg11401D
schema_voice vpaganman 1 c1401 (LineNo 4 4)

schema gar1401E_Fake		//"Knew I would come? But...."
archetype AI_CONV
volume -3000
gar1401E
schema_voice vnull 1 c1401 (LineNo 5 5)

schema pg11401F		//"Hush, sneaksie friend..."
archetype AI_CONV
pg11401F
schema_voice vpaganman 1 c1401 (LineNo 6 6)

schema gar1401G_Fake		//"Don't worry. I'll find Cavador..."
archetype AI_CONV
volume -3000
gar1401G
schema_voice vnull 1 c1401 (LineNo 7 7)

schema pg11401H		//"You'll need... takes you the key..."
archetype AI_CONV
pg11401H
schema_voice vpaganman 1 c1401 (LineNo 8 8)

schema gar1401I_Fake	//"Yes...my friend.  What can I do?"
archetype AI_CONV
volume -3000
gar1401I
schema_voice vnull 1 c1401 (LineNo 9 9)

schema pg11401J		//"The cold... feels nothing now..."
archetype AI_CONV
pg11401J
schema_voice vpaganman 1 c1401 (LineNo 10 10)

//-------------------------------------------------------

//c1402 - Mechanist Conversation – Lighthouse
schema mc11402A		//"Construction is proceeding as planned..."
archetype AI_CONV
mc11402A
schema_voice vmech1 1 c1402 (LineNo 1 1)	

schema mc21402B
archetype AI_CONV
mc21402B
schema_voice vmech2 1 c1402 (LineNo 2 2)

schema mc11402C
archetype AI_CONV
mc11402C
schema_voice vmech1 1 c1402 (LineNo 3 3)	

schema mc21402D
archetype AI_CONV
mc21402D
schema_voice vmech2 1 c1402 (LineNo 4 4)

schema mc11402E
archetype AI_CONV
mc11402E
schema_voice vmech1 1 c1402 (LineNo 5 5)	

schema mc21402F
archetype AI_CONV
mc21402F
schema_voice vmech2 1 c1402 (LineNo 6 6)

//-------------------------------------------------------
	
//***THIS IS NOW JUST A FROB THING, NOT A CONVERSATION***
//c1403 - Destroyed Robot Recording	
//schema rb11403A		//"I have seen...I do not know..."
//archetype AI_CONV
//rb2die_1 rb2die_2 rb2die_3 rb2hlow1 rb2hhi_3 rb2hhi_2 rb2atn_3
//schema_voice vcombatbot 1 c1403 (LineNo 1 1)

//-------------------------------------------------------

///////////////////////////////
//MISSION 15 - PRECIOUS CARGO//
///////////////////////////////

//c1501 - Cavador Broadcasts	
schema mc21501A		//"An attack!  To safety!"
archetype AI_CONV
mc21501A
schema_voice vmech2 1 c1501 (LineNo 1 1)

//-------------------------------------------------------

//c1502 - Disclose existence of Itinerary.
schema mc31502A		//"No, my friend, I fear this cannot wait till evening."
archetype AI_CONV
mc31502A
schema_voice vmech3 1 c1502 (LineNo 1 1)

schema mc41502B	
archetype AI_CONV
mc41502B
schema_voice vmech4 1 c1502 (LineNo 2 2)

schema mc31502C	
archetype AI_CONV
mc31502C
schema_voice vmech3 1 c1502 (LineNo 3 3)

schema mc41502D	
archetype AI_CONV
mc41502D
schema_voice vmech4 1 c1502 (LineNo 4 4)

schema mc31502E	
archetype AI_CONV
mc31502E
schema_voice vmech3 1 c1502 (LineNo 5 5)

schema mc41502F	
archetype AI_CONV
mc41502F
schema_voice vmech4 1 c1502 (LineNo 6 6)

schema mc31502G	
archetype AI_CONV
mc31502G
schema_voice vmech3 1 c1502 (LineNo 7 7)

schema mc41502H	
archetype AI_CONV
delay 1000
mc41502H
schema_voice vmech4 1 c1502 (LineNo 8 8)

//-------------------------------------------------------
	
//c1503 -A pair of Archs complaining about the schedule.
schema mc11503A		//"Name of the Master Builder, what can Lord .."
archetype AI_CONV
mc11503A
schema_voice vmech1 1 c1503  (LineNo 1 1)

schema mc21503B	
archetype AI_CONV
mc21503B
schema_voice vmech2 1 c1503  (LineNo 2 2)

schema mc11503C		
archetype AI_CONV
mc11503C
schema_voice vmech1 1 c1503  (LineNo 3 3)

schema mc21503D	
archetype AI_CONV
mc21503D
schema_voice vmech2 1 c1503  (LineNo 4 4)

schema mc11503E		
archetype AI_CONV
mc11503E
schema_voice vmech1 1 c1503  (LineNo 5 5)

schema mc21503F	
archetype AI_CONV
mc21503F
schema_voice vmech2 1 c1503  (LineNo 6 6)

schema mc11503G		
archetype AI_CONV
mc11503G
schema_voice vmech1 1 c1503  (LineNo 7 7)

schema mc21503H	
archetype AI_CONV
mc21503H
schema_voice vmech2 1 c1503  (LineNo 8 8)

schema mc11503I		
archetype AI_CONV
mc11503I
schema_voice vmech1 1 c1503  (LineNo 9 9)

//-------------------------------------------------------

//c1504 -Argument between 2 about previous people discovering Karath Din. 
schema mc31504A		//"With mine own eyes, I saw it!..."	
archetype AI_CONV
mc31504A
schema_voice vmech3 1 c1504  (LineNo 1 1)

schema mc21504B	
archetype AI_CONV
mc21504B
schema_voice vmech2 1 c1504  (LineNo 2 2)

schema mc31504C			
archetype AI_CONV
mc31504C
schema_voice vmech3 1 c1504  (LineNo 3 3)

schema mc21504D	
archetype AI_CONV
mc21504D
schema_voice vmech2 1 c1504  (LineNo 4 4)

schema mc31504E			
archetype AI_CONV
mc31504E
schema_voice vmech3 1 c1504  (LineNo 5 5)

schema mc21504F
archetype AI_CONV
mc21504F
schema_voice vmech2 1 c1504  (LineNo 6 6)

//-------------------------------------------------------
			
//c1505 -About ‘burrick bounty’ for C’s safety of mind.
schema mc11505A		//"Any luck on thy hunting, friend?"
archetype AI_CONV
mc11505A
schema_voice vmech1 1 c1505  (LineNo 1 1)

schema mc21505B
archetype AI_CONV
mc21505B
schema_voice vmech2 1 c1505  (LineNo 2 2)

schema mc11505C
archetype AI_CONV
mc11505C
schema_voice vmech1 1 c1505  (LineNo 3 3)

schema mc21505D
archetype AI_CONV
mc21505D
schema_voice vmech2 1 c1505  (LineNo 4 4)

schema mc11505E
archetype AI_CONV
mc11505E
schema_voice vmech1 1 c1505  (LineNo 5 5)

schema mc21505F
archetype AI_CONV
mc21505F
schema_voice vmech2 1 c1505  (LineNo 6 6)

//-------------------------------------------------------
//-------------------------------------------------------	
