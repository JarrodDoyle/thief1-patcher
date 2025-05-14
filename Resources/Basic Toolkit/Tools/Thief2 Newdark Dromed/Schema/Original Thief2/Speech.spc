//-------BROADCAST SPEECH CONCEPTS----------//

//concept <name> <priority>
concept sleeping 1
concept atlevelzero 1		//steady state loop
concept atlevelone 3		//steady state loop
concept atleveltwo 2		//steady state loop
concept atlevelthree 1		//steady state loop
concept tolevelone 5		//transition
concept toleveltwo 5		//transition
concept tolevelthree 5		//transition to 3 by any means
concept spotplayer 6		//transition to 3 by seeing the player
concept reactcharge 2		
concept reactshoot 2		
concept reactrun 2	
concept getbowman 2		//NonRanged AIs run to get bowman.	
concept reactwarn 5		
concept reactwarn2 5		
concept reactalarm 2		
concept reacttellrev 2		
concept reacttellconf 2
concept outofreach 4		
concept backtozero 5			
concept lostcontact 4
concept notice 4			//notice something suspicious
concept foundbody	5
concept foundrobot 5		
concept foundmissing 5		//was 3  	
concept foundbreach 5		//was 3	
concept foundsmall 5		//was 3
concept foundlarge 5		//was 3	
concept recentintruder 5	//was 3
concept recentbody 5		//was 3
concept recentrobot 5
concept recentmissing 5		//was 3
concept recentother 5		//was 3
concept comattack	8
concept comsucchit 8	
concept comsuccblock 8	
concept comdetblock 8	
concept comblocked 8	
concept comhitnodam 8
concept comhithigh 9
concept comhitlow	9
concept comhitamb	9
concept comdieloud 10
concept comdiesoft 10


//-------CONVERSATION CONCEPTS----------//

//THIEF2 DEMO CONVERSATIONS -DELETE AFTER FIXING MISS11
concept T2_c01 4 //Squabbling guards
concept T2_c02 4 //The Rothchilds
concept T2_c03 4 //Mech Priest & the Officer
concept T2_c04 4 //Whispering Thieves

concept c0101 4   //"I've sprung the lock..."
concept c0102 4 	//Jen & Basso meet
concept c0103 4	//"Damn torches, always sputtering out."			
concept c0104 4	//"Jax! Can I bother you..."

concept c0201 4	//"You must be Uriel..."
concept c0202 4	//"Evening Dante, you look exhausted..."
concept c0203 4	//"I hear Capt. Davidson..."

concept c0402 4	//"You guys can't treat me like this..."
concept c0403 4	//"You think your beloved..."
concept c0404 4	//"Okay, let's take it from the top.."
concept c0405 4	//"Did you hear about the raid..."
concept c0406 4	//"How come we gotta pull guard duty?..."
concept c0407 4	//"The Watcher is ready and operational..."
concept c0408 4	//"I like the dark..."
concept c0409 4	//"There's no law in The City anymore.."
concept c0410 4	//"They put me here because I was urinating..."
concept c0411 4	//"Life stinks and then you die..."

concept c0501 4	//"Remember men, his name is Garrett.."
concept c0502 4	//"What's the latest on the war, Rolley?.."
concept c0503 4	//"What's going on? The City Watch..."
concept c0504 4	//"What's a big fella like you..." 

concept c0601 4	//"Hail, Friend!"
concept c0602 4	//"Hast thou seen our Father today?..."
concept c0603 4	//"A pox upon it!..."
concept c0604 4	//"Thou'rt new to the Movement, Friend."
concept c0605 4	//"Hast thou been back to our old haunts."
concept c0606 4	//"I tell thee, for thou art my friend..."
concept c0607 4	//"Dost thou know whether the Sheriff hath arrived?"
concept c0608 4	//"My friend!  Where wert thou last night?"
concept c0609 4	//BIG KARRAS & TRUART CONVERSATION

concept c0701 4	//"Night shift again, Mart?..."
concept c0702 4	//"You ever wonder, looking at all this?"
concept c0703 4	//"You know, I been wondering."
concept c0704 4	//"Mud and blast and bother!"
concept c0705 4	//"[frightened]  Ahh!"
concept c0706 4	//"I do not know...Be it true that..."

concept c0801 4	//"We dare'st not venture in there.."
concept c0802 4	//"Well well.  If it ain't Officer Coranth..."

concept c0901 4	//"How could the killer make his way..?"
concept c0902 4	//"[drunk] Hey, did you try any of that..."
concept c0903 4	//"Hurry! Sound the alarms! Seal off the area! "
concept c0904 4	//"Can you believe this mess..." 	
concept c0905 4	//"[drunk] I can't believe that..." 
concept c0906 4	//"I heard a commotion coming from Truart's.."

concept c1001 4	//"You cans have this, I don't needs it any more.."
concept c1002 4	//"What?! You! Gets the childrens..."
concept c1003 4	//"He ams the honeymaker." 
concept c1004 4	//"Check thy map, several have escaped ..."
concept c1005 4	//"I knows it was here. I knows it.."
concept c1006 4	//"Comes now, Birch.  We've lit the lights.."
concept c1007 4	//"Seesy you…mines plumsees?"
concept c1008 4	//"Guardsies you winters, eh, eh?"

concept c1101 4	//"And I'm telling you.."
concept c1102 4	//"But it's just not fair..."
concept c1103 4	//"That's the point, Margaret...." 
concept c1104 4	//"Hmph. These are strange times indeed.."
concept c1105 4	//"Quiet, you lumbering ox!..."

concept c1201 4	//"Hello up there. How goes your watch?"
concept c1202 4	//"Sgt Porter, it would'st appear..."
concept c1203 4	//"Aah, child.  Did'st not hear thee..."
concept c1204 4	//"Nobody knows. Nobody sees.."
concept c1205 4	//"You mean you lost a whole stack of books?"
concept c1206 4	//"Love. To think it was all for love!"
concept c1207 4	//"Nobody reads books these days."
concept c1208 4	//"Terrible secrets..."
concept c1209 4	//"How long?  How long???"

concept c1301 4	//"Father Norrell, what's wrong?"
concept c1302 4	//"You find your stack of books yet?"

concept c1401 4	//Garret-Lotus conversation
concept c1402 4	//"Construction is proceeding as planned..."
concept c1403 4	//"I have seen...I do not know..."

concept c1501 4	//"An attack!  To safety!"
concept c1502 4	//"No, my friend, I fear this cannot wait till evening."
concept c1503 4	//"Name of the Master Builder, what can Lord .."
concept c1504 4	//"With mine own eyes, I saw it!..."
concept c1505 4	//"Any luck on thy hunting, friend?"


//-----------TAGS----------//

//INTEGER TAGS
tag_int Mission
tag_int NearbyFriends
tag_int Reiterate
tag_int LineNo

//ARGUMENT TAGS
tag Sense Sight Sound			//how does the AI sense the player
tag ComBal Winning Even Losing  	//how is AI doing in combat
tag CarryBody True False		//does AI see player carrying a a body
tag Reacquire True False   		//does the AI see for the 2nd+ time?
tag Investigate True False  		//is the AI looking for the player?

//Suspicious items -goes with concept NOTICE
tag Item Door Gaslight Generic MissingLoot Torch  		



//-----------VOICES----------//

voice vnull 	//DUMMY VOICE TO SILENCE AN AI

voice vtest		//TEST VOICE TO TEST SCHEMA CONCEPTS

//GUARDS
voice vguardmen		//RANDOM MALE GUARDS [#1-5]

voice vguard1 		//sg1 -male
archetype vguardmen

voice vguard2 		//sg2 -male
archetype vguardmen

voice vguard3		//sg3 -male
archetype vguardmen

voice vguard4		//sg4 -male
archetype vguardmen

voice vguard5		//sg5 -male
archetype vguardmen

voice vguard6		//sg6 -female

voice vdrunk1		//drunk version of sg2


//COPS <--THESE SHARE THE SAME ACTORS AS GUARDS
voice vcopmen		//RANDOM MALE COPS [#1-5]

voice vcop1 		//sg1 -male
archetype vcopmen

voice vcop2			//sg2 -male
archetype vcopmen

voice vcop3			//sg3 -male
archetype vcopmen

voice vcop4			//sg4 -male
archetype vcopmen

voice vcop5			//sg5 -male
archetype vcopmen

voice vcop6			//sg6 -female


//MECHANISTS 
voice vmechmen		//RANDOM MALE MECHS [#1-2]

voice vmech1		//mc1 -male
archetype vmechmen

voice vmech2		//mc2 -male
archetype vmechmen

voice vmechfems		//RANDOM FEMALE MECHS [#3-4]

voice vmech3		//mc3 -female
archetype vmechfems

voice vmech4		//mc4 -female
archetype vmechfems


//THIEVES
voice vthiefmen		//RANDOM MALE THIEVES [#1-2]

voice vthief1		//th1 -male
archetype vthiefmen

voice vthief2		//th2 -male
archetype vthiefmen


//NON-COMBATANTS
voice vserv1		//sv1 -male servant

voice vserv2		//sv2 -female servant

voice vnoble1		//no1 -male noble

voice vnoble2		//no2 -female noble

voice vextra1		//ex1 -male generic

voice vextra2		//ex2 -female generic		


//OTHERS
voice vslave		//ms1 androgenous masked slave

voice vbasso		//bas Basso the Boxman -male

voice vjen			//jen Jenivere -female

voice vhammer1		//hm1 Hammer1 from THIEF1 -male

voice vpaganman		//pg1 Pagan agent & apparition -male

voice vpaganwom		//pg2 Pagan apparition -female
	
voice vpagangirl		//pg3 Pagan appariton -little girl

voice vkarras		//kar Karras  <--DELETE THIS VOICE IF NEVER USED IN CONV.

voice vtruart		//tru Sheriff Truart

voice vghost		//gho ghost that appears in m12 haunted library

voice vprisoners

voice vpris1
archetype vprisoners
		
voice vpris2
archetype vprisoners

 


//CRITTERS
voice vappar		//app Apparitions -male

voice vfrog			//fb1	FrogBeasts

voice vhaunt		//hh1	Hammer Haunts

voice vzombie		//zm2	Zombies -male

voice vzombiegirl		//zm3	Zombies -female

voice vspider		//sp1	All spiders

voice vburrick		//bu1	Burricks

voice vapes			//ALL APEBEASTS

voice vape1			//ab1
archetype vapes

voice vape2			//ab2
archetype vapes

voice vcombatbot		//rb1	Combat Robot

voice vworkerbot		//rb2	Worker Robot

voice vspiderbot		//rb3 Spider Robot

voice vcamera		//cam	Security Camera

voice vtree			//tb1 TreeBeast

voice vrat			//rat Rats

voice vcherub		//mch Mechanical Cherub

voice vbug              //BugBeast

voice vcray             //Crayman

voice vfire             //Fire Elemental

voice vmurus
