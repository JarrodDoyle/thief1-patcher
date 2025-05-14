/* ------------------------------------------------------
/* 				  Dark Max Tools
/*				Menu Registration
/* 			
/* ------------------------------------------------------
/* author: Juliusz Kaczmarek
/* ver. 0.9
/* May. 2015
/*
/* ------------------------------------------------------
*/

-----------------------------------
-- Menu Items
-----------------------------------
macroscript DAT_ImportAI 	category:"DarkMaxTools" 	
(	
	PosX = getINISetting DATconfig.darkINIfile "ImportRollout" "PosX"
	PosY = getINISetting DATconfig.darkINIfile "ImportRollout" "PosY"
	if PosX!="" and PosY!="" then
	(	
		pos = [(PosX as integer), (PosY as integer)]	
		if DATImport.isDisplayed == false then createDialog DATImport width:240  pos:pos	
	)
	else
		if DATImport.isDisplayed == false then createDialog DATImport width:240 
)

macroScript DATabout category:"DarkMaxTools"
(	
	createDialog DATabout modal:true width:350
)

macroScript DATconfiguration category:"DarkMaxTools"
(
	createDialog PathConfiguration width:500 modal:true
)


---------------------------
-- Menu registration
---------------------------

(
	mainMenuBar = menuMan.getMainMenuBar()
	-- delete existing DarkMaxTools menu
	for i = mainMenuBar.numItems() to 1 by -1 do
	(
		mnuItem = (mainMenuBar.getItem i)
		if (mnuItem.getTitle()) == "DarkMaxTools" then
		mainMenuBar.removeItem mnuItem
	)
	menuMan.updateMenuBar()

	-- create a new DarkMaxTools menu
	DATmenu = menuMan.createMenu "DarkMaxTools"  
	
	itemImportAI = menuMan.createActionItem "DAT_ImportAI" "DarkMaxTools"
	itemImportAI.setTitle "Import AI..."
	itemImportAI.setUseCustomTitle True
	DATmenu.addItem itemImportAI -1
	
	sepItem = menuMan.createSeparatorItem()
	DATmenu.addItem sepItem -1
	
	itemConfig = menuMan.createActionItem "DATconfiguration" "DarkMaxTools"
	itemConfig.setTitle "Configuration..."
	itemConfig.setUseCustomTitle True
	DATmenu.addItem itemConfig -1
	
	sepItem = menuMan.createSeparatorItem()
	DATmenu.addItem sepItem -1
	
	aboutItem = menuMan.createActionItem "DATabout" "DarkMaxTools"
	aboutItem.setTitle "About..."
	aboutItem.setUseCustomTitle True
	DATmenu.addItem aboutItem -1
	
	DATmenuSubmenu = menuMan.createSubMenuItem "DarkMaxTools" DATmenu
	DATmenuIndex = mainMenuBar.numItems() 
	mainMenuBar.addItem DATmenuSubmenu DATmenuIndex 
-- redraw the menu bar with the new item
	menuMan.updateMenuBar()
)
-- else print "menu already registered"