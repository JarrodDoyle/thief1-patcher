/* ------------------------------------------------------
/* 			Dark Animation Tools
/*					Rollouts
/* ------------------------------------------------------
/* author: Juliusz Kaczmarek
/* March 2015
/*
/* tools for importing and exporting
/* rigged characters and their motions
/* from and to dark engine games. 
/*
/* this script was possible thanks to the knowledge and experience 
/* of Volca, Shadowspawn, Weyoun, Telliamed
/* ------------------------------------------------------
*/
-------------------------------------------------------------------------------------------
-------- R O L L O U T    D E F I N I T I O N S -----------------------------------
-------------------------------------------------------------------------------------------



rollout DATImport "Import"
(
	local RawAIName, AInumber

	group "Import AI"
	(
		dropDownList ddl_game "Game:" width:150 
		button bt_config "Config" width:50 height:25 offset:[2,-30] align:#right
		button bt_browse "Browse" width:120 height:30 offset:[0,10]	
	)
	group "Import options:"
	(
		checkbox ch_autoRig "auto load .rig file if exists" checked:true
		checkbox ch_fixKnees "Fix legs joints for IK" checked:true
-- 		checkbox ch_fixSymmetry "Make rig symmetrical" checked:false enabled:False
		checkbox ch_LGSrig "LGS style joint markers" checked:false
-- 		button bt_fixJoints "Fix Joints" width:120 height:30
	)
	
	fn datcfg =
	(
		createDialog PathConfiguration width:500 modal:true
	)
	
	on bt_browse pressed do
	(
		local AIfile = getOpenFileName caption:"Select a character to import:" \
		filename:(DATconfig.paths[DATconfig.game].Mesh+"\\") \
		types:"AI Mesh (*.bin)|*.bin|AI Joint Structure (*.cal)|*.cal|" \
		historyCategory:"AI Meshes"

		if AIfile!=undefined then
		(			
			RawAIName = (getFileNameFile AIfile)			
			BIN.fileName =  RawAIName + ".bin"
			CAL.FileName = RawAIName + ".cal"	
			
			if doesFileExist CAL.FileName then 
			(		
				DAT.createCharacter RawAIName true (ch_LGSrig.checked)
			)
			else format "\\\\ERROR: Couldn't find %.CAL file.\n" AI.name
			
		)
	)
	
	fn RefreshRollout =
	(
		items = for game in DATconfig.paths collect game.name
		ddl_game.items = items	
	)
	
	on ddl_game selected val do
	(
		DATconfig.game = val
	)
	
	on bt_config pressed do
	(
		datcfg()
		RefreshRollout()z
	)
	
	on DATImport open do
	(		
-- 		try (DestroyDialog DATImport); catch()
		RefreshRollout()		
		for i = 1 to DATconfig.paths.count do
			if DATconfig.paths[i].isDefault == true then DATconfig.game = i
		ddl_game.selection = DATconfig.game
		
	)
	
	on DATImport close do
	(
-- 		setINISetting DATconfig.darkINIfile "ImportRollout" "PosX" (DATMain.pos.x as string)
-- 		setINISetting DATconfig.darkINIfile "ImportRollout" "PosY" (DATMain.pos.y as string)
		local pos = GetDialogPos DATImport
		setINISetting DATconfig.darkINIfile "ImportRollout" "PosX" (pos.x as string)
		setINISetting DATconfig.darkINIfile "ImportRollout" "PosY" (pos.y as string)
	)
)

/* -------------------------------------------------------------------------------------------------------------------*/

rollout DATRig "Rig building in progress..."
(
	local ctrlOffset = 80
-- 	local layerTemp

	group "Global"		
	(
		spinner sp_rootSize "Root Size:" type:#float range:[0.01, 10.0, Rig.rootSize] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0]
		spinner sp_ctrlThickness "Controls thickness:" type:#float range:[0.001, 0.5, Rig.ctrlThickness] fieldwidth:60 align:#right scale:0.001 offset:[-ctrlOffset ,0]
	)
	group "Torsos" 
	(
		spinner sp_torsoStartSize "First torso size:" type:#float range:[0.01, 10.0, Rig.torsoStartSize] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0]
		spinner sp_torsoEndSize "Last torso size:" type:#float range:[0.01, 10.0, Rig.torsoEndSize] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0]
	)
	group "Arms" 
	(
		spinner sp_armFKStartSize "Arm FK Start size:" type:#float range:[0.01, 10.0, Rig.armFKStartSize] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0]
		spinner sp_armFKEndSize "Arm FK End size:" type:#float range:[0.01, 10.0, Rig.armFKEndSize] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0]
		spinner sp_handIKsize "Hand IK size:" type:#float range:[0.01, 10.0, Rig.handIKsize] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,10]
		
-- 			spinner sp_ ":" type:#float range:[0.01, 10.0, Rig.] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0]
	)	
	group "Legs" 
	(
		spinner sp_legFKStartSize "Leg FK Start size:" type:#float range:[0.01, 10.0, Rig.legFKStartSize] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0]
		spinner sp_legFKEndSize "Leg FK End size:" type:#float range:[0.01, 10.0, Rig.legFKEndSize] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0]
		spinner sp_footIKwidth "Foot IK width:" type:#float range:[0.01, 10.0, Rig.footIKwidth] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,10]
		spinner sp_footIKlength "Foot IK length:" type:#float range:[0.01, 10.0, Rig.footIKlength] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0]
		spinner sp_footIKoffsetX "Foot CTRL offset:" type:#float range:[-10.00, 10.0, Rig.footIKoffsetX] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0]
		spinner sp_footIKoffsetY "" type:#float range:[-10.00, 10.0, Rig.footIKoffsetY] fieldwidth:60 align:#right scale:0.01 offset:[0,-21]
		
		dropDownList ddl_legSide "" width:120 items:#("Left foot", "Right foot") selection:1 align:#left offset:[125,10]
		-- Left Leg
		spinner Lsp_h2offsetX "Heel helper offset:" type:#float range:[-10.00, 10.0, 0] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0] visible:True
		spinner Lsp_h2offsetY "" type:#float range:[-10.00, 10.0, 0] fieldwidth:60 align:#right scale:0.01 offset:[0,-21] visible:True
		spinner Lsp_h3offsetX "Toes helper offset:" type:#float range:[-10.00, 10.0, 0] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0] visible:True
		spinner Lsp_h3offsetY "" type:#float range:[-10.00, 10.0, 0] fieldwidth:60 align:#right scale:0.01 offset:[0,-21] visible:True
		spinner Lsp_h4offsetX "Foot Out helper offset:" type:#float range:[-10.00, 10.0, 0] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0] visible:True
		spinner Lsp_h4offsetY "" type:#float range:[-10.00, 10.0, 0] fieldwidth:60 align:#right scale:0.01 offset:[0,-21] visible:True
		spinner Lsp_h4angle "angle:" type:#float range:[-45.00, 45.0, 0] fieldwidth:60 align:#right scale:0.1 offset:[-ctrlOffset ,0] visible:True
		spinner Lsp_h5offsetX "Foot In helper offset:" type:#float range:[-10.00, 10.0, 0] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0] visible:True
		spinner Lsp_h5offsetY "" type:#float range:[-10.00, 10.0, 0] fieldwidth:60 align:#right scale:0.01 offset:[0,-21] visible:True
		spinner Lsp_h5angle "angle:" type:#float range:[-45.00, 45.0, 0] fieldwidth:60 align:#right scale:0.1 offset:[-ctrlOffset ,0] visible:True
		--Right Leg
		spinner Rsp_h2offsetX "Heel helper offset:" type:#float range:[-10.00, 10.0, 0] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,-126] visible:False
		spinner Rsp_h2offsetY "" type:#float range:[-10.00, 10.0, 0] fieldwidth:60 align:#right scale:0.01 offset:[0,-21] visible:False
		spinner Rsp_h3offsetX "Toes helper offset:" type:#float range:[-10.00, 10.0, 0] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0] visible:False
		spinner Rsp_h3offsetY "" type:#float range:[-10.00, 10.0, 0] fieldwidth:60 align:#right scale:0.01 offset:[0,-21] visible:False
		spinner Rsp_h4offsetX "Foot Out helper offset:" type:#float range:[-10.00, 10.0, 0] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0] visible:False
		spinner Rsp_h4offsetY "" type:#float range:[-10.00, 10.0, 0] fieldwidth:60 align:#right scale:0.01 offset:[0,-21] visible:False
		spinner Rsp_h4angle "angle:" type:#float range:[-45.00, 45.0, 0] fieldwidth:60 align:#right scale:0.1 offset:[-ctrlOffset ,0] visible:False
		spinner Rsp_h5offsetX "Foot In helper offset:" type:#float range:[-10.00, 10.0, 0] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0] visible:False
		spinner Rsp_h5offsetY "" type:#float range:[-10.00, 10.0, 0] fieldwidth:60 align:#right scale:0.01 offset:[0,-21] visible:False
		spinner Rsp_h5angle "angle:" type:#float range:[-45.00, 45.0, 0] fieldwidth:60 align:#right scale:0.1 offset:[-ctrlOffset ,0] visible:False
	)
-- 		spinner sp_ ":" type:#float range:[0.01, 10.0, Rig.] fieldwidth:60 align:#right scale:0.01 offset:[-ctrlOffset ,0]
		
	group "Rig presets:"
	(
		button bt_saveRig "SAVE" width:120 height:50 across:2
		button bt_loadRig "LOAD" width:120 height:50
		button bt_saveAsDefault "Save as Default" width:260 height:30
		button bt_reset "Reset preset" width:260 height:30
	)
	group "Finalize building rig:"
	(		
		button bt_buildRig "Done!" width:260 height:50
	)
	
-- 	fn UpdateControlsValues triggerEvents = ()	-- predeclaration
	
	fn UpdateOneControl ctrlName propValue triggerEvents =
	(
		if (isProperty DATRig ctrlName) then 
		(
			-- this updates the rollout fields values:
			ctrls = getProperty DATRig ctrlName 
			oldCtrlValue = ctrls.value
			ctrls.value = propValue
			-- this updates the rig, if values are different				
			if (oldCtrlValue != propValue) and (triggerEvents == true) then
			(
				try 
				(
					ctrls.changed ctrls.value
-- 					format "Envoking %\n" ctrls
				)
				catch(format "\\\\ERR: Couldn't invoke a 'changed' event on % control.\n\\\\ERR: Rig is not up-to-date.\n" ctrls.name)
			)
		)									
		else (format "\\\\WARN: Cannot find a rollout control called %.\n" ctrlName)	
	)
	
	fn UpdateControlsValues triggerEvents =
	(
		propNames = sort (getPropNames Rig)
		currentleg = ddl_legSide.selection	
		for i = 1 to propNames.count do 
		(			
			propName = propNames[i]
			
			ctrlName = "sp_" + propName as string 
			propValue = getProperty rig propName		
-- 			format "propName: %, propValue: %, class: %\n" propName propValue (classof propValue)
			case (classof propValue) of 
			(
				Point2:()
				MAXScriptFunction:()
				Array:
				(		
					for leg = 1 to 2 do
					(
						itemNames = getPropNames propValue[leg]
	-- 					print itemNames
						for j = 1 to itemNames.count do
						(						
							itemName = itemNames[j]
	-- 						prefix = (Name as string) + "[" + (leg as string) + "]."
							itemValue = getProperty propValue[leg] itemName
							sidePrefix = case leg of (
								(1):"L"
								(2):"R"
							)								
							ctrlName = sidePrefix + "sp_" + itemName as string
-- 	 						format "Leg no %. Updating Control %, its value %.\n" leg ctrlName itemValue
							UpdateOneControl ctrlName itemValue triggerEvents
						)
					)
					prefix = ""	
					
				)
				default:
				(
					UpdateOneControl ctrlName propValue triggerEvents
				)
			)			
		)
		--registerHelpersChangeHandlers()
	)
	
	fn helpersHaveBeenMoved = 
	(
		for i = 1 to AI.limbs.count do
		(
			limb = AI.limbs[i]
			if limb.type == #leg then 
			(
				limb.updateRigOffsetsForHelpers()
-- 				print "Executing UpdateControlsValues from within the callback"
				UpdateControlsValues false
			)			
		)		
	)
	
	fn registerHelpersChangeHandlers =
	(
		for i = 1 to AI.limbs.count do
		(
			limb = AI.limbs[i]
			if limb.type == #leg then 
			(
				footHelperChangeHandler = when transform limb.footHelpers changes id:#footHelpers do
				(
					helpersHaveBeenMoved()
				)
			)			
		)		
	)
	
	fn unRegisterHelpersChangeHandlers =
	(
		deleteAllChangeHandlers id:#footHelpers
	)
	
	
	
	on sp_rootSize changed val do
	(
		Rig.rootSize = val
		AI.RootCTRL.node.modifiers[2].gizmo.scale = [val, val, 1]
	)
	
	on sp_ctrlThickness changed val do
	(
		Rig.ctrlThickness = val
		DAT.changeRigControlsThickness val
	)
	
	on sp_torsoStartSize changed val do
	(
		Rig.torsoStartSize = val
		for t = 1 to AI.torsos.count do
		(
			torso = AI.torsos[t]
			CTRLsize = (1 * AI.charman.calibration * (interpolate Rig.torsoStartSize Rig.torsoEndSize t AI.torsos.count ))
			torso.ctrl.node.radius = CTRLsize
			torso.auxctrl.node.radius1 = 0.95 * CTRLsize * 0.8
			torso.auxctrl.node.radius2 = 0.95 * CTRLsize
		)
	)
	
	on sp_torsoEndSize changed val do
	(
		Rig.torsoEndSize = val
		for t = 1 to AI.torsos.count do
		(
			torso = AI.torsos[t]
			CTRLsize = (1 * AI.charman.calibration * (interpolate Rig.torsoStartSize Rig.torsoEndSize t AI.torsos.count ))
			torso.ctrl.node.radius = CTRLsize
			torso.auxctrl.node.radius1 = 0.95 * CTRLsize * 0.8
			torso.auxctrl.node.radius2 = 0.95 * CTRLsize
		)
	)
	
	fn updateArmFKsize =
	(
		for l = 1 to AI.limbs.count do
		(
			limb = AI.limbs[l]
			if limb.type == #hand then 
			(
				segs = limb.segmentsCount				
				for i = 1 to segs do
				(
					xf = limb.fkctrls[i].modifiers[2]
					CTRLscale = interpolate Rig.armFKStartSize Rig.armFKEndSize i segs
					xf.gizmo.scale = [CTRLscale, CTRLscale, CTRLscale]
				)
			)
		)	
	)
	
	fn updateHandIKsize =
	(
		for l = 1 to AI.limbs.count do
		(
			limb = AI.limbs[l]
			if limb.type == #hand then 
			(
				xf = limb.ikctrl.modifiers[2]
				xf.gizmo.scale = [Rig.handIKsize, Rig.handIKsize, Rig.handIKsize]
			)
		)	
	)
	
	on sp_armFKStartSize changed val do
	(
		Rig.armFKStartSize = val
		updateArmFKsize()
	)
		
	on sp_armFKEndSize changed val do
	(
		Rig.armFKEndSize = val
		updateArmFKsize()
	)
	
	on sp_handIKsize changed val do
	(
		Rig.handIKsize = val
		updateHandIKsize()
	)
	
	fn updateLegFKsize =
	(
		for l = 1 to AI.limbs.count do
		(
			limb = AI.limbs[l]
			if limb.type == #leg then 
			(
				segs = limb.segmentsCount				
				for i = 1 to segs do
				(
					xf = limb.fkctrls[i].modifiers[2]
					CTRLscale = interpolate Rig.LegFKStartSize Rig.LegFKEndSize i segs
					xf.gizmo.scale = [CTRLscale, CTRLscale, CTRLscale]
				)
			)
		)	
	)	
	
		
	fn updateLegIKHelpers =
	(
		unRegisterHelpersChangeHandlers()
		for i = 1 to AI.limbs.count do
		(
			limb = AI.limbs[i]
			if limb.type == #leg then limb.setHelpersPositions()
		)
		registerHelpersChangeHandlers()
	)
	
	on sp_LegFKStartSize changed val do
	(
		Rig.LegFKStartSize = val
		updateLegFKsize()
	)
	
	on sp_LegFKEndSize changed val do
	(
		Rig.LegFKEndSize = val
		updateLegFKsize()
	)
	
	
	on sp_footIKwidth changed val do
	(
		Rig.footIKwidth = val
		for i = 1 to AI.limbs.count do
		(
			limb = AI.limbs[i]
			if limb.type == #leg then DAT.setFootIKctrlSize limb				
		)
	)
	
	on sp_footIKlength changed val do
	(
		Rig.footIKlength = val
		for i = 1 to AI.limbs.count do
		(
			limb = AI.limbs[i]
			if limb.type == #leg then DAT.setFootIKctrlSize limb				
		)
	)
	
	on sp_footIKoffsetX changed val do
	(
		Rig.footIKoffsetX = val
		for i = 1 to AI.limbs.count do
		(
			local limb = AI.limbs[i]
			if limb.type == #leg then
			(
				xf = limb.ikctrl.modifiers[2]
				xf.gizmo.position.x = val				
			)
		)
	)
	
	on sp_footIKoffsetY changed val do
	(
		Rig.footIKoffsetY = val
		for i = 1 to AI.limbs.count do
		(
			local limb = AI.limbs[i]
			if limb.type == #leg then
			(
				xf = limb.ikctrl.modifiers[2]
				xf.gizmo.position.y = val * limb.side				
			)
		)
	)
	
	on ddl_legSide selected val do
	(		
		for i = 2 to DATRig.controls.count do
		(
			ctrl = DATRig.controls[i]
			try (nameElements = filterString ctrl.name "_"); catch (nameElements = #())
			if nameElements.count > 0 then
			(
				if nameElements[1] == "Lsp" then
				(
					ctrl.visible = case val of (
						(1):True
						(2):False
						)
				)
				if nameElements[1] == "Rsp" then
				(
					ctrl.visible = case val of (
						(1):False
						(2):True
						)
					)
			)
		)
		UpdateControlsValues true
	)
	
	on Lsp_h2offsetX changed val do
	(
		Rig.footHelpers[1].h2offsetX = val
		updateLegIKHelpers()
	)
	
	on Lsp_h2offsetY changed val do
	(
		Rig.footHelpers[1].h2offsetY = val
		updateLegIKHelpers()
	)
	
	on Lsp_h3offsetX changed val do
	(
		Rig.footHelpers[1].h3offsetX = val
		updateLegIKHelpers()
	)
	
	on Lsp_h3offsetY changed val do
	(
		Rig.footHelpers[1].h3offsetY = val
		updateLegIKHelpers()
	)
	
	on Lsp_h4offsetX changed val do
	(
		Rig.footHelpers[1].h4offsetX = val
		updateLegIKHelpers()
	)
	
	on Lsp_h4offsetY changed val do
	(
		Rig.footHelpers[1].h4offsetY = val
		updateLegIKHelpers()
	)
	
	on Lsp_h4angle changed val do
	(
		Rig.footHelpers[1].h4angle = val
		updateLegIKHelpers()
	)
	
	on Lsp_h5offsetX changed val do
	(
		Rig.footHelpers[1].h5offsetX = val
		updateLegIKHelpers()
	)
	
	on Lsp_h5offsetY changed val do
	(
		Rig.footHelpers[1].h5offsetY = val
		updateLegIKHelpers()
	)
	
	on Lsp_h5angle changed val do
	(
		Rig.footHelpers[1].h5angle = val
		updateLegIKHelpers()
	)
	
	on Rsp_h2offsetX changed val do
	(
		Rig.footHelpers[2].h2offsetX = val
		updateLegIKHelpers()
	)
	
	on Rsp_h2offsetY changed val do
	(
		Rig.footHelpers[2].h2offsetY = val
		updateLegIKHelpers()
	)
	
	on Rsp_h3offsetX changed val do
	(
		Rig.footHelpers[2].h3offsetX = val
		updateLegIKHelpers()
	)
	
	on Rsp_h3offsetY changed val do
	(
		Rig.footHelpers[2].h3offsetY = val
		updateLegIKHelpers()
	)
	
	on Rsp_h4offsetX changed val do
	(
		Rig.footHelpers[2].h4offsetX = val
		updateLegIKHelpers()
	)
	
	on Rsp_h4offsetY changed val do
	(
		Rig.footHelpers[2].h4offsetY = val
		updateLegIKHelpers()
	)
	
	on Rsp_h4angle changed val do
	(
		Rig.footHelpers[2].h4angle = val
		updateLegIKHelpers()
	)
	
	on Rsp_h5offsetX changed val do
	(
		Rig.footHelpers[2].h5offsetX = val
		updateLegIKHelpers()
	)
	
	on Rsp_h5offsetY changed val do
	(
		Rig.footHelpers[2].h5offsetY = val
		updateLegIKHelpers()
	)
	
	on Rsp_h5angle changed val do
	(
		Rig.footHelpers[2].h5angle = val
		updateLegIKHelpers()
	)
	
	on bt_buildRig pressed do
	(
		unRegisterHelpersChangeHandlers()	
		undo "Finalize building the rig." on
			DAT.createRigConstraints()
		destroydialog DATrig
	)
	
	on bt_saveRig pressed do
	(
		Rig.savePresets AI.rawname
	)
	
	on bt_loadRig pressed do
	(
		rigFileName = getOpenFileName caption:"Select a Rig Settings file:" \
		filename:(DATconfig.paths[DATconfig.game].Mesh + "\\")\
		types:"Rig Settings (*.rig)|*.rig" \
		historyCategory:"AI Meshes"
		if rigFileName != undefined then
		(						
			Rig.loadPresets (getFileNameFile rigFileName)
-- 			currentLeg = ddl_legSide.selection 
			UpdateControlsValues true	
-- 			ddl_legSide.selection = currentLeg
-- 			UpdateControlsValues false
		)		
	)
	
	on bt_saveAsDefault pressed do
	(		
		Rig.savePresets ("Default_" + AIstructure[AI.type].shortName)
	)
	
	on bt_reset pressed do
	(		
		Rig = customRig()
		UpdateControlsValues true
	)
	
	on DATRig open do
	(				
		with redraw off
		(			
			UpdateControlsValues false
			
			DAT.createRig()
			
			LM = layerManager
			DATlayer.Temp = LM.newLayerFromName "RIG_Temporary"
			if DATlayer.Temp == undefined then DATlayer.Temp = LM.getLayerFromName "RIG_Temporary"
			DATlayer.Temp.current = true
			for l = 1 to AI.limbs.count do
				if AI.limbs[l].type == #leg then
					for o = 2 to AI.limbs[l].footHelpers.count do DATlayer.Temp.addNode AI.limbs[l].footHelpers[o]
			DATlayer.CTRL.isFrozen = true
			DATlayer.Rig.isFrozen = true
			DATlayer.Rig.isHidden = true
			DATlayer.Mesh.isFrozen = true
			
			registerHelpersChangeHandlers()
			
		)
	)
	
	on DATRig close do
	(
		unRegisterHelpersChangeHandlers()		
		DATlayer.Temp.select true
		for footHelper in $selection do DATlayer.Rig.addNode footHelper
		deselect $*
		DATlayer.CTRL.current = true
		LayerManager.deleteLayerByName "RIG_Temporary"
	)
)

-------------------------------------------------------------------------------------------------------------------------------------------------------

rollout PathConfiguration "Configuration:"
(	
	group "Presets:"
	(
		dropDownList ddl_game "Game:" width:150 
		button bt_new "New" width:100 height:30 align:#left offset:[160,-30]
		button bt_delete "Delete" width:100 height:30 align:#left offset:[268,-35]
		button bt_default "Make Default" width:100 height:30 align:#left offset:[376,-35]
		editText et_name "Name:" fieldwidth:150 align:#right offset:[-230,10]
		editText et_pathMesh "AI meshes:" fieldwidth:350 align:#right offset:[-30,10]
		button bt_browseMesh "..." width:25 align:#right offset:[0,-24]
		checkbutton ch_txtLock "L" align:#left width:20 height:18 
		editText et_pathTxt16 "AI textures:" fieldwidth:350 align:#right offset:[-30,-22]
		button bt_browseTxt16 "..." width:25 align:#right offset:[0,-24]
		editText et_pathMotions "Motions:" fieldwidth:350 align:#right offset:[-30,0]
		button bt_browseMotions "..." width:25 align:#right offset:[0,-24]
		editText et_pathMSchema "Motion Schemas:" fieldwidth:350 align:#right offset:[-30,0]
		button bt_browseMSchema "..." width:25 align:#right offset:[0,-24]
	)
	group "Other paths:"
	(
		editText et_pathTools "LGS tools:" fieldwidth:350 align:#right offset:[-30,5]	
		button bt_browseTools "..." width:25 align:#right offset:[0,-24]
	)
	--group "Advanced:"
	--(
		checkbox ch_advmode "Advanced mode" checked:DAT.advmode visible:DAT.devmode
	--)
	button bt_close "Save & Close" width:100 height:30 offset:[0,10] align:#right
	

	
	fn updatePresetFields =
	(
		game = DATconfig.game
		ddl_game.selection = game
		items = for each in DATconfig.paths collect each.name
		ddl_game.items = items
		et_name.text = items[game]
		et_pathMesh.text = DATConfig.paths[game].mesh
		ch_txtLock.checked = DATconfig.paths[game].txtLock
		if ch_txtLock.checked == true then 
		(
			DATconfig.paths[game].txt16 = DATConfig.paths[game].mesh + "\\txt16\\"
		)
		et_pathTxt16.text = DATConfig.paths[game].txt16
		et_pathMotions.text = DATConfig.paths[game].motions
		et_pathMSchema.text = DATConfig.paths[game].mschema
		et_pathTxt16.enabled = not DATconfig.paths[game].txtLock
		bt_browseTxt16.enabled = not DATconfig.paths[game].txtLock
	)
	
	fn RefreshRollout =
	(
		updatePresetFields()		
		bt_default.enabled = not DATConfig.paths[DATConfig.game].isDefault
		if DATconfig.paths.count < 2 then bt_delete.enabled = false
			else bt_delete.enabled = true
	)
	
	on ch_advmode changed state do
	(
		DAT.advmode = state
		setINISetting DATconfig.DarkINIfile "Configuration" "advmode" (state as string)
	)
	
	on ddl_game selected val do
	(
		DATconfig.game = val
		RefreshRollout()
	)
	
	on bt_new pressed do
	(
		preset = pathPreset()
		append DATconfig.paths preset
		gameCount = DATconfig.paths.count
		DATconfig.game = gameCount
		RefreshRollout()
	)
	
	on bt_delete pressed do
	(		
		game = DATconfig.game
		if DATConfig.paths[game].isDefault == false then
		(
			deleteItem DATconfig.paths game 
			if game > DATconfig.paths.count then game = DATconfig.paths.count
			DATconfig.game = game
			RefreshRollout()
		)
		else messageBox "Can't delete the default Preset.\nMake another Preset default before deleting this one."
	)
	
	on bt_default pressed do
	(
		game = DATconfig.game
		for i = 1 to DATconfig.paths.count do
		(
			if i == game then 
			(
				DATconfig.paths[i].isDefault = true
			)
			else 
			(
				DATconfig.paths[i].isDefault = false
			)
		)
		RefreshRollout()
	)
	
	on et_name changed val do
	(
		game = DATconfig.game
		DATconfig.paths[game].name = val
		RefreshRollout()
	)
	
	on et_pathMesh entered val do
	(
		game = DATconfig.game
		DATconfig.paths[game].mesh = val
		RefreshRollout()
	)
	
	on bt_browseMesh pressed do
	(
		game = DATconfig.game		
		newPath = getSavePath caption:"Browse for AI meshes folder:" initialDir:DATconfig.paths[game].mesh
		if newPath != undefined then
		(
			et_pathMesh.text = newPath			
			DATconfig.paths[game].mesh = newPath
			RefreshRollout()
		)		
	)
	
	on et_pathtxt16 entered val do
	(
		game = DATconfig.game
		DATconfig.paths[game].Txt16 = val
		RefreshRollout()
	)
	
	on bt_browseTxt16 pressed do
	(
		game = DATconfig.game		
		newPath = getSavePath caption:"Browse for AI textures folder:" initialDir:DATconfig.paths[game].Txt16
		if newPath != undefined then
		(
			et_pathTxt16.text = newPath			
			DATconfig.paths[game].Txt16 = newPath
			RefreshRollout()
		)		
	)
	
	on et_pathMotions entered val do
	(
		game = DATconfig.game
		DATconfig.paths[game].motions = val
		RefreshRollout()
	)
	
	on bt_browseMotions pressed do
	(
		game = DATconfig.game		
		newPath = getSavePath caption:"Browse for motion files folder:" initialDir:DATconfig.paths[game].Motions
		if newPath != undefined then
		(
			et_pathMotions.text = newPath			
			DATconfig.paths[game].Motions = newPath
			RefreshRollout()
		)		
	)
	
	on et_pathMSchema entered val do
	(
		game = DATconfig.game
		DATconfig.paths[game].mschema = val
		RefreshRollout()
	)
	
	on bt_browseMSchema pressed do
	(
		game = DATconfig.game		
		newPath = getSavePath caption:"Browse for motion schemas folder:" initialDir:DATconfig.paths[game].MSchema
		if newPath != undefined then
		(
			et_pathMSchema.text = newPath			
			DATconfig.paths[game].MSchema = newPath
			RefreshRollout()
		)		
	)
	
	on et_pathTools entered val do
	(
		game = DATconfig.game
		DATconfig.pathTools = val
		RefreshRollout()
	)
	
	on bt_browseTools pressed do
	(		
		newPath = getSavePath caption:"Browse for LGS tools folder:" initialDir:DATconfig.pathTools
		if newPath != undefined then
		(
			et_pathTools.text = newPath			
			DATconfig.pathTools = newPath
			RefreshRollout()
		)		
	)
	
	on ch_txtLock changed val do
	(
		game = DATconfig.game
		DATconfig.paths[game].txtLock = val		
		updatePresetFields()
	)
	
	on bt_close pressed do
	(
		DATconfig.savePresets()
		destroydialog PathConfiguration
	)
	
	on PathConfiguration open do
	(	
		DATconfig.configureDefPaths()

		et_pathTools.text = DATconfig.pathTools		
		RefreshRollout()
		
		PathConfiguration.height = PathConfiguration.height + 10
	)
) 


rollout DATabout "About..."
(
	label lb1 " * Dark Max Tools *\n" align:#center offset:[0,5]
	label lb1a "" align:#center 
	label lb2 "A toolset for importing, creating and modifying assets\n" align:#left offset:[0,10]
	label lb3 "for Dark Engine based games.\n\n" align:#left
	label lb4 "Juliusz Kaczmarek, a.k.a 'PinkDot'  on TTLG Forums,  (C) 2015\n" align:#left offset:[0,10]
	label lb5 "contact: juliusz_kaczmarek@yahoo.co.uk" align:#left
	button btOK "OK" width:100 height:30 align:#right offset:[0,20]	
	
	on btOK pressed do
		destroyDialog DATabout
	
	on DATabout open do
	(
		versionText = "version " + (DAT.version as string)
		lb1a.text = versionText
	)
		
)
