/* ------------------------------------------------------
/* 			Dark Animation Tools
/*		Custom attributes definitions
/* 			Motions Import/Export
/* ------------------------------------------------------
/* author: Juliusz Kaczmarek
/* ver. 0.01
/* Nov. 2012
/*
/* tools for importing and exporting
/* rigged characters and their motions
/* from and to dark engine games. 
/*
/* thanks for help on dark engine files structure
/* to Volca, Shadowspawn, Weyoun, Telliamed
/* ------------------------------------------------------
*/

CharManCA = attributes CharMan attribID:#(0x600436eb, 0xf355a80)  
(
	parameters main rollout:params
	(
		AIname type:#string default:""
		calibration type: #float ui:SP_cal default:1
 		creaType type:#integer
		bonesMap type: #intTab tabSizeVariable:true
 		rotationRef type: #maxObjectTab tabSizeVariable:true	
 		skinBones type: #maxObjectTab tabSizeVariable:true
		ikBones type:  #maxObjectTab tabSizeVariable:true
		fkctrls type: #maxObjectTab tabSizeVariable:true 
		ikctrls type: #maxObjectTab tabSizeVariable:true 
		otherctrls type: #maxObjectTab tabSizeVariable:true
		helpers type: #maxObjectTab tabSizeVariable:true
		buttHeight type: #float default:1.0
		rootctrl type: #maxObject
		geo type: #maxObject
		buttctrl type: #maxObject
	)
	
	rollout params "Character data:"
	(
		spinner SP_cal "Calibration:" fieldwidth:50 range:[0.001,999,1] align:#right enabled:false
		group "Rig components:"
		(
			listbox LB_skinBones "Skin bones:" height:8 
			listbox LB_rotationRef "Rotation reference:" height:8 
			listbox LB_ikBones "IK bones:" height:8
			listbox LB_fkctrls "FK CTRLS:" height:8
			listbox LB_ikctrls "IK CTRLS:" height:8
			listbox LB_otherctrls "Other CTRLS:" height:8
			listbox LB_helpers "Helpers:" height:8
		)
		
		on params open do
		(
			items=#()
			for i=1 to skinBones.count do
			(
				if skinBones[i]==undefined then items[i]="---"
					else	items[i] = (skinBones[i].node.name )
			)
			LB_skinBones.items = items
			
			items=#()
			for i=1 to rotationRef.count do
			(
				if rotationRef[i]==undefined then items[i]="---"
					else	items[i] = (rotationRef[i].node.name )
			)
			LB_rotationRef.items = items
			
			items=#()
			for i=1 to ikbones.count do
			(
				if ikbones[i]==undefined then items[i]="---"
					else	items[i] = (ikbones[i].node.name )
			)
			LB_ikbones.items = items
			
			items=#()
			for i=1 to fkctrls.count do
			(
				if fkctrls[i]==undefined then items[i]="---"
					else	items[i] = (fkctrls[i].node.name )
			)
			LB_fkctrls.items = items
			
			items=#()
			for i=1 to ikctrls.count do
			(
				if ikctrls[i]==undefined then items[i]="---"
					else	items[i] = (ikctrls[i].node.name )
			)
			LB_ikctrls.items = items
			
			items=#()
			for i=1 to otherctrls.count do
			(
				if otherctrls[i]==undefined then items[i]="---"
					else	items[i] = (otherctrls[i].node.name )
			)
			LB_otherctrls.items = items
			
			items=#()
			for i=1 to helpers.count do
			(
				if helpers[i]==undefined then items[i]="---"
					else	items[i] = (helpers[i].node.name )
			)
			LB_helpers.items = items
		)
	)
)

rollout showAnimInfo "Anim Information"
(
	editText et_text "Animation Info:" width:400 height:220 labelOnTop:true
	button bt_close "OK" width:100 height:30
	
	on showAnimInfo open do
	(
		info = "MIfilename: " + currentAnimInfo.MIfilename 
		append info ("\nMCfilename: " + currentAnimInfo.MCfilename)
		try (append info ("\nMotion Name: " + currentAnimInfo.name)); catch(append info ("\nMotion Name: ---"))
		append info ("\nFrame Count: " + currentAnimInfo.frameCount as string)
		append info ("\nCreature Type: " + currentAnimInfo.creatureType as string)
		append info ("\nChar. Manager: " + currentAnimInfo.charMan as string)
		append info ("\nTracks no.: " + currentAnimInfo.tracksNum as string)
		append info ("\nFlags no.: " + currentAnimInfo.flagsNum as string)
		append info ("\nunknown: " + currentAnimInfo.unknown as string)
		et_text.text = info
	)
)

rollout importMotion "Import Motion"
(
	local MIfileName
	local GFScaption = "Get Motion from Schema"
	local GFFcaption = "Load Motion file from folder"
	local tracksNum = 0
	
	local offset
	
	button getFromSchema "Get Motion from Schema" width:200 height:30 pos:[20,22]
	button getFromFile "Load Motion file from folder" width:200 height:30 pos:[20,60]
	dropdownList getRecent "Recent motions:" width:200 height:10 pos:[20,95]
	groupbox gb_select "Select motion file:" pos:[7,5] width:225 height:140
	
	label lb_frameCount "Frame count:" pos:[10,155]  align:#left
	button bt_moreInfo "more info..." pos:[130,152] width:100 height:20 visible:DAT.advmode
	button bt_curFrame "Get Current" pos:[10,178] height:20
	spinner setStartFrame "Start Frame:" fieldwidth:60 type:#integer range:[1,99999,1] pos:[100,180]
	spinner setRepeat       "       Repeat:" fieldwidth:60 type:#integer range:[1,999,1] pos:[100,200]
	checkbox setRelative "Relative position" checked:false pos:[10,220]
	checkbox setRelativeRot "Relative orientation" checked:true pos:[120,220]
	button accept "Apply" width:100 height:30 across:2 align:#left pos:[20,250] enabled:false
	button cancel "Close" width:100 height:30 align:#right pos:[130,250]
	
	checkbutton bt_extend ">" width:15 height:270 pos:[240,10] enabled:false visible:DAT.advmode-- change to 'false' when done with testing
	---- Extended controls: ----
	groupBox gb_edit "Edit Motion data:" pos:[260,5] width:410 height:380 
	spinner sp_frame "Frame:" type:#integer pos:[265,30] fieldwidth:50
	slider sl_frame "" type:#integer pos:[370,20] width:300 ticks:10
	label lb_axes "X                               Y                               Z" pos:[405,55]
	button bt_clearAll "Clear All" pos:[300,52]
	-- quasi table --
	label lb_trackName1 
	spinner sp_X1 type:#float fieldwidth:70 range:[-9999,9999,0] scale:0.00001
	spinner sp_Y1 type:#float fieldwidth:70 range:[-9999,9999,0] scale:0.00001 
	spinner sp_Z1 type:#float fieldwidth:70 range:[-9999,9999,0] scale:0.00001
	label lb_trackName2 
	spinner sp_X2 type:#float fieldwidth:70 range:[-9999,9999,180] scale:0.00001
	spinner sp_Y2 type:#float fieldwidth:70 range:[-9999,9999,0] scale:0.00001
	spinner sp_Z2 type:#float fieldwidth:70 range:[-9999,9999,0] scale:0.00001
	label lb_trackName3 
	spinner sp_X3 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y3 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z3 type:#float fieldwidth:70 range:[-9999,9999,0] 	
	label lb_trackName4 
	spinner sp_X4 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y4 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z4 type:#float fieldwidth:70 range:[-9999,9999,0] 
	label lb_trackName5 
	spinner sp_X5 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y5 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z5 type:#float fieldwidth:70 range:[-9999,9999,0] 
	label lb_trackName6 
	spinner sp_X6 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y6 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z6 type:#float fieldwidth:70 range:[-9999,9999,0] 
	label lb_trackName7 
	spinner sp_X7 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y7 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z7 type:#float fieldwidth:70 range:[-9999,9999,0] 
	label lb_trackName8 
	spinner sp_X8 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y8 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z8 type:#float fieldwidth:70 range:[-9999,9999,0] 
	label lb_trackName9 
	spinner sp_X9 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y9 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z9 type:#float fieldwidth:70 range:[-9999,9999,0] 
	label lb_trackName10 
	spinner sp_X10 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y10 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z10 type:#float fieldwidth:70 range:[-9999,9999,0] 
	label lb_trackName11 
	spinner sp_X11 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y11 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z11 type:#float fieldwidth:70 range:[-9999,9999,0] 
	label lb_trackName12 
	spinner sp_X12 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y12 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z12 type:#float fieldwidth:70 range:[-9999,9999,0] 
	label lb_trackName13 
	spinner sp_X13 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y13 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z13 type:#float fieldwidth:70 range:[-9999,9999,0] 
	label lb_trackName14 
	spinner sp_X14 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y14 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z14 type:#float fieldwidth:70 range:[-9999,9999,0] 
	label lb_trackName15 
	spinner sp_X15 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y15 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z15 type:#float fieldwidth:70 range:[-9999,9999,0] 
	label lb_trackName16 
	spinner sp_X16 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y16 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z16 type:#float fieldwidth:70 range:[-9999,9999,0] 
	label lb_trackName17 
	spinner sp_X17 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y17 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z17 type:#float fieldwidth:70 range:[-9999,9999,0] 
	label lb_trackName18 
	spinner sp_X18 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y18 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z18 type:#float fieldwidth:70 range:[-9999,9999,0] 
	label lb_trackName19 
	spinner sp_X19 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y19 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z19 type:#float fieldwidth:70 range:[-9999,9999,0] 
	label lb_trackName20 
	spinner sp_X20 type:#float fieldwidth:70 range:[-9999,9999,180] 
	spinner sp_Y20 type:#float fieldwidth:70 range:[-9999,9999,0] 
	spinner sp_Z20 type:#float fieldwidth:70 range:[-9999,9999,0] 
	
	local first = 20 	-- first 'table' controls - update it when adding controls before the table
	
	fn MatchCreature MCcode =
	(
		local ct = 0 -- resulting creature type
		for i = 1 to MCmatch.count do
		(
			if MCcode == MCmatch[i][2] then ct = MCmatch[i][1]
		)
		ct
	)
	
	fn refreshRolloutExt = 
	(		
		
		local fr = sp_frame.value
		gb_edit.height = 80 + (tracksNum*20)
		
		--- Updating the quasi table values: --
		for i = 1 to 20 do
		(
			ctl_name = importMotion.controls[first+(i-1)*4]			
			ctl_x = importMotion.controls[first+(i-1)*4+1]
			ctl_y = importMotion.controls[first+(i-1)*4+2]
			ctl_z = importMotion.controls[first+(i-1)*4+3]
			if tracksNum >= i then
			(				
				ct = matchCreature currentAnimInfo.creatureType
				jt = currentAnimInfo.trackMapping[i].JointNumber
				tt = case currentAnimInfo.trackMapping[i].trackType of (
					Translational:"T"
					Rotational:"R"
				)
				labelText = AIstructure[ct].jointNames[jt]
				space = 80 - (GetTextExtent labelText ).x 
				if space>2 then 
					for j = 1 to space/3 do labelText=labelText + " "
				
				labelText = labelText + tt
				
				ctl_name.text = labelText
				ctl_name.pos = [270, 80+(i-1)*20]
				ctl_name.visible = true
							
				ctl_x.value = currentAnimInfo.channels[i][fr].x
				ctl_x.pos = [430, 80+(i-1)*20]
				ctl_x.visible = true
								
				ctl_y.value = currentAnimInfo.channels[i][fr].y
				ctl_y.pos = [530, 80+(i-1)*20]
				ctl_y.visible = true
				
				ctl_z.value = currentAnimInfo.channels[i][fr].z
				ctl_z.pos = [630, 80+(i-1)*20]
				ctl_z.visible = true
			)
			else
			(
				ctl_name.visible = false
				ctl_x.visible = false
				ctl_y.visible = false
				ctl_z.visible = false				
			)
		)		
	)
	
	fn refreshRollout =
	(		
		case bt_extend.checked of (
			true:
			(
				importMotion.width = 680
				importMotion.height = bigger 290 ((tracksNum*20)+100)
				bt_extend.caption = "<"
			)
			false:
			(
				importMotion.width = 260
				importMotion.height = 290
				bt_extend.caption = ">"
			)
		)
		labelText = "Frame count: "+((currentAnimInfo.frameCount as integer) as string)	
		lb_frameCount.caption = labelText
		if setRelative.state == false then
			setRelativeRot.enabled = false
		else
			setRelativeRot.enabled = true
	)
	
	fn importMotionFile currentAnimInfo =
	(
		animInfo = currentAnimInfo
		local MIfilename = animInfo.MIfilename
		local MCfilename = animInfo.MCfilename
		
		MIfile = fOpen MIfilename "rb"
	
		FSeek MIfile 4 #seek_cur	-- 0 value
		animInfo.creatureType = ReadLong MIfile #unsigned		
		animInfo.frameCount = ReadFloat MIfile
		animInfo.frameRate = ReadLong MIfile #unsigned
		animInfo.unknown = ReadLong MIfile #unsigned
		--FSeek MIfile 4 #seek_cur	-- unknown
		animInfo.name = ReadBString MIfile 16
		Fseek MIfile 60 #seek_cur	-- 15 zeros
		animInfo.tracksNum = ReadLong MIfile #unsigned
		FSeek MIfile 4 #seek_cur	-- unknown
		animInfo.flagsNum = ReadLong MIfile #unsigned
		FSeek MIfile 4 #seek_cur	-- unknown
		animInfo.trackMapping = #()
		for i = 1 to animInfo.tracksNum do
		(
			TrackType = ReadLong MIfile #unsigned				
			JointNumber = (ReadLong MIfile #signed) + 1		-- Maxscript array index start with 1 (not 0)
			if JointNumber == 0 then JointNumber = 1	-- this is to cover an exception where the root joint is referenced as -1 sometimes...
			TrackNumber = ReadLong MIfile #unsigned			
			animInfo.trackMapping[i] = TrackMappingStruct TrackType:TrackType  JointNumber:JointNumber TrackNumber:TrackNumber					
		)
		animInfo.flags = #()
		if animInfo.flagsNum > 0 then
		(			
			for i = 1 to animInfo.flagsNum do
			(				
				FrameNumber = ReadLong MIfile #unsigned
				FlagType = ReadLong MIfile #unsigned
				animInfo.flags[i] = FlagStruct FrameNumber:FrameNumber FlagType:FlagType
			)
		)
		fClose MIfile
		
		--
		-- Loading animation data now
		--
		if (doesFileExist MCfilename) == true then
		(			
			MCfile = fOpen MCfilename "rb"
			local tracksNum = ReadLong MCfile #unsigned
			local dataStart = #()
			for i=1 to tracksNum do
				dataStart[i] = ReadLong MCfile #unsigned
			local eulerRot
			
			animInfo.channels = #()
			for track = 1 to tracksNum do
			(			
				local channelData = #()
				fSeek MCfile dataStart[track] #seek_set
				local trackInfo = animInfo.trackMapping[track]
				local trackType = trackInfo.TrackType
							
				if trackType == rotational then
				(				
					for frame = 1 to animInfo.frameCount do
					(
						try (quatRot = (quat (ReadFloat MCfile) (ReadFloat MCfile) (ReadFloat MCfile) (ReadFloat MCfile))
	 					eulerRot = quatToEuler quatRot order:xyz
						append channelData (eulerRot)); catch (format "\\\\ERROR: Error reading motion data file: %\n" MCfilename) 
					)
				)
				else 	--transitional
				(				
					for frame = 1 to animInfo.frameCount do
					(
						pos = [(ReadFloat MCfile), (ReadFloat MCfile), (ReadFloat MCfile)]
						append channelData pos					
					)
				)				
				append animInfo.channels channelData				
			)
			fClose MCfile				
			result = true
		)
		else 
		(
			format "\\\\ERR: Motion loading failed.\n\\\\ERR: File % does not exist.\n" MCfilename
			result = false
		)		
		result		
	)
	
	fn loadAnimation currentAnimInfo fileSource MotionName =
	(
		format "\\\\INFO: Loading motion % to memory.\n"	MotionName		
		
		importMotionFile currentAnimInfo --- currentAnimInfo.MIfilename currentAnimInfo.MCfilename 
		
		-- UI update --		
		accept.enabled = true
		bt_extend.enabled = true
		tracksNum = currentAnimInfo.tracksNum
		sp_frame.range = [1,currentAnimInfo.frameCount,1]
		sl_frame.range = [1,currentAnimInfo.frameCount,1]
		
		-- recent items
		items = getRecent.items
		try (deleteItem items (findItem items MotionName)); catch()
		insertItem MotionName items 2			
		getRecent.items = items
		delINIsetting DATconfig.DarkINIfile "Recent motions" MotionName	-- these two lines are supposed to change the order.
		setINIsetting DATconfig.DarkINIfile "Recent motions" MotionName ""		
		
		-- labels / motion names
		getFromFile.caption = GFFcaption
		getFromSchema.caption = GFScaption
		getRecent.selection = 1
		case fileSource of (
			#file:getFromFile.caption = (getFileNameFile currentAnimInfo.MIfileName)
			#schema:getFromSchema.caption = (getFileNameFile currentAnimInfo.MIfileName)			
			#recent:getRecent.selection = 2
		)	
		
		refreshRolloutExt()		
	)
	
	fn resetFKPose CharMan =
	(		
		local jointObjs = CharMan.fkctrls as array
		for obj = 1 to jointObjs.count do
		(				
			if jointObjs[obj] != undefined then
			(				
				local curObj = jointObjs[obj].node
				--rotController = CurObj.rotation.controller[2]				
				CurObj.rotation.controller[2].x_rotation = 0
				CurObj.rotation.controller[2].y_rotation = 0
				CurObj.rotation.controller[2].z_rotation = 0				
				
				--posController = CurObj.position.controller[2]
				CurObj.Position.controller[2].x_Position = 0
				CurObj.Position.controller[2].y_Position = 0
				CurObj.Position.controller[2].z_Position = 0
			)
		)
	)
	
	fn applyFrame animInfo frame animOffset =
	(				
		--local creatureType = animInfo.CharMan.creaType
		local charMan = animInfo.Charman
		local calibration = CharMan.calibration
		resetFKPose CharMan	-- the pose is set "from scratch" for every frame
		
		for track = 1 to animInfo.tracksNum do
		(			
			local ct = charMan.creaType
			local actualtrack = AIstructure[ct].trackOrder[track]
			local trackInfo = animInfo.trackMapping[actualtrack]			
			local jointNo = trackInfo.jointNumber
			local curObj = charMan.fkctrls[jointNo].node
			local trackType = trackInfo.TrackType		
			local rotAxisNode
			
			rotAxisNode = CharMan.helpers[2].node -- AIorient helper
			
			if trackType == rotational then
			(                							
				fileEulerRot = animInfo.channels[actualtrack][frame]
				-- dark engine to 3dsmax convertion				
				eulerRot = eulerAngles -fileEulerRot.z fileEulerRot.y -(fileEulerRot.x-180)				
								
				in coordsys rotAxisNode rotate CurObj eulerRot				
				if (curObj == charMan.buttCtrl.node) then
					if (setRelative.state == true) and (setRelativeRot.state == true) then
					(					
						eulerOffsetRot = eulerAngles 0 0 -(animOffset.rotation as eulerAngles).z
-- 						format "Adding a relative rotation of %\n" eulerOffsetRot
						in coordsys rotAxisNode rotate CurObj eulerOffsetRot
					)
			)	 			
			else 	--transitional track
			(
				position = animInfo.channels[actualtrack][frame] * calibration
				if (setRelative.state == true) and (setRelativeRot.state == true) then
				(
					offsetPosition = position * animOffset.transform
					CurObj.position.controller[2].position = offsetPosition 
				)
				else					
-- 				CurObj.position.controller[2].position = (offset + (position * calibration))
					CurObj.position.controller[2].position = (animOffset.pos + (position * calibration))
			)
		)
		-- Flags
		local root = CharMan.rootctrl.node
		flagsNumber = animInfo.flags.count 
		if flagsNumber > 0 then
		(
			flags = animInfo.flags
			for j = 1 to flagsNumber do
				if flags[j].frameNumber == frame then
				(
					root.modifiers[1].flags = flags[j].flagType					-- a key with flags set
					format "\\\\INFO:setting up a flag at frame %\n" frame
				)
		)
		
	)
	
	fn createOffsetHelper animInfo atFrame =
	(
		animOffset = point name:("animOffsetTemp_f." + (atFrame as string))
		at time (atFrame - 1)
		(
			if setRelative.state == true then
			(
				butt_CTRL = animInfo.charman.buttctrl.node	
				rootT = animInfo.charMan.rootctrl.node.transform
				buttRelT = butt_CTRL.transform * inverse rootT
				buttRelTX = buttRelT.row1
				offTZ = [0,0,1]
				offTY = 	normalize (cross offTZ buttRelTX)
				offTX = normalize (cross offTY offTZ)
				offT = Matrix3 offTX offTY offTZ butt_CTRL.position.controller[2].position
				animOffset.transform = offT
			)			
		)
		format "\\\\INFO: Relative position and rotation are: % and %\n" animOffset.pos (animOffset.rotation as eulerAngles)
		animOffset	
	)
	
	fn getCreatureTypeByMotions animInfo = 
	(
		creatureNames = ""
		for i = 1 to DC_number do
			if animInfo.tracksNum == AIstructure[i].motionTracks then
				if creatureNames == "" then creatureNames = AIstructure[i].longName
					else creatureNames += " or " + AIstructure[i].longName	
		creatureNames
	)		
	
	fn applyAnimation animInfo startFrame repeats =
	(
		local ct 
		local currFrame
		-- creature type check - to be done later
		ct = animInfo.charMan.creaType
		
		if animInfo.tracksNum == AIstructure[ct].motionTracks then
		(
			-- Frame rate check and correction
			if frameRate!=animInfo.frameRate then
			(
				query = "Current frame rate ("+(frameRate as string)+") does not match the file frame rate ("+(animInfo.frameRate as string)+"). \nDo you want to change it? (recommended)"
				if querybox query == true then frameRate = animInfo.frameRate
			)
			fullMotionCount = animInfo.frameCount * repeats + (startFrame - 1)
			if (AnimationRange.end )< fullMotionCount then animationRange = interval animationRange.start fullMotionCount
			
			
			for j = 1 to repeats do
			(					
				animOffset = createOffsetHelper animInfo startFrame
				with animate on
				(
					for frame = 1 to animInfo.frameCount do
					(
						currFrame = frame + (startFrame - 1)
						at time currFrame
							applyFrame animInfo frame animOffset
					)
					startFrame = currFrame + 1
					delete animOffset
				)
			)
			
			-- Switch to FK mode
			for ikctrl in animInfo.charMan.ikctrls do
			(
				try (
					keys = ikctrl.node.modifiers[1].fkikblend.keys
					if keys.count == 0 then
						ikctrl.node.modifiers[1].fkikblend = 0
					else 
						with animate on
							at time startFrame
								ikctrl.node.modifiers[1].fkikblend = 0							
					)
				catch()
			)
		)
		else 
		(
			cNames = getCreatureTypeByMotions animInfo
			message = "Number of motion tracks does not match the creature type.\n\nThis motion is designed for " + cNames + "."
			messageBox message title:"Motion Import Error"
			format ("\\\\ERROR: " + message)
		)
	)
	
	

	
	on getFromSchema pressed do
	(
		createDialog MotionSelector 660 460 modal:true
		
		if MfilePicked != undefined then
		(
			MIfileName = DATconfig.paths[DATconfig.game].Motions + "\\" + MfilePicked + ".mi"	
			MotionName = MfilePicked-- (getFileNameFile currentAnimInfo.MIfileName)										
			MotionPath = getFileNamePath MIfileName
			MCfileName =  MotionPath + MotionName + "_.mc"
			MIfileName = MotionPath + MotionName + ".mi"
			currentAnimInfo.MCfilename = MCfileName
			currentAnimInfo.MIfileName = MIfileName
			
			if doesFileExist MCfileName then 
			(					
				loadAnimation currentAnimInfo #schema  MotionName			
			)
			else format "\\\\ERROR: .MC file is missing for this motion. %\n" MIfileName				
		)
		RefreshRollout()
	)
	
	on getFromFile pressed do
	(
		MIfileName = getOpenFileName caption:"Select a motion file to load:" \
		filename:(DATconfig.paths[DATconfig.game].Motions + "\\") \
		types:"MotionInfo files (*.mi)|*.mi" \
		historyCategory:"MotionFiles"		

		if MIfileName!=undefined then
		(
			currentAnimInfo.MIfileName = MIfilename
			MotionName = (getFileNameFile currentAnimInfo.MIfileName)										
			MotionPath = getFileNamePath currentAnimInfo.MIfileName
			MCfileName =  MotionPath + MotionName + "_.mc"			
			if doesFileExist MCfileName then 
			(						
				currentAnimInfo.MCfilename = MCfileName 
				loadAnimation currentAnimInfo #file MotionName
			)
			else format "\\\\ERROR: .MC file is missing for this motion. %\n" MIfileName				
		)		
		RefreshRollout()
	)
	
	on bt_moreInfo pressed do
	(
		try (destroyDialog showAnimInfo); catch()
		createDialog showAnimInfo 420 300
	)
	
	on getRecent selected val do
	(
		if val>1 then
		(
			MotionName = getRecent.items[val]
			MIfileName = DATconfig.paths[DATconfig.game].Motions + "\\" + MotionName + ".mi"	
			MCfileName = DATconfig.paths[DATconfig.game].Motions + "\\" + MotionName + "_.mc"
			
			if doesFileExist MCfileName then
			(
				currentAnimInfo.MCfilename = MCfileName
				currentAnimInfo.MIfileName = MIfileName

				loadAnimation currentAnimInfo #recent MotionName
			)
			else format "\\\\ERROR: .MC file is missing for this motion. %\n" MIfileName				
		)
		RefreshRollout()
	)
	
	on bt_CurFrame pressed do
	(
		setStartFrame.value = SliderTime.frame
-- 		offset = getOffset()
	)
		
-- 	on setStartFrame changed do
-- 		offset = getOffset()
		
	on setRelative changed val do
		RefreshRollout()
		
	
	on bt_extend changed val do refreshRollout()
	
	on sp_frame changed val do
	(
		sl_frame.value = val
		currFrame = sp_frame.value + (setStartFrame.value - 1) 
		sliderTime = currFrame
		RefreshRolloutExt()
	)
	
	on sl_frame changed val do
	(
		sp_frame.value = val
		currFrame = sl_frame.value + (setStartFrame.value - 1) 
		sliderTime = currFrame
		RefreshRolloutExt()
	)		
		
	
	
	
	on bt_clearAll pressed do
	(
		local anyChanges = false
		for i = 1 to 20 do
		(			
			ctl_x = loadMotion.controls[first+(i-1)*4+1]
			ctl_y = loadMotion.controls[first+(i-1)*4+2]
			ctl_z = loadMotion.controls[first+(i-1)*4+3]
			if ctl_x.visible == true then
			(					
				ctl_x.value = case currentAnimInfo.trackMapping[i].trackType of (
					Translational:0
					Rotational:180
				)
				ctl_y.value = 0
				ctl_z.value = 0
				
				currentAnimInfo.channels[i][sp_frame.value] = case currentAnimInfo.trackMapping[i].trackType of (
					Translational:[0,0,0]
					Rotational:[180,0,0]
				)
				anyChanges = true
			)
		)
		if anyChanges then
		(
			UpdatePose() 
		)
	)
	
-- 	on setRelative changed val do
-- 		offset = getOffset()
-- 	
	on accept pressed do
	(
		startFrame = setStartFrame.value
		repetitions = setRepeat.value
		applyAnimation currentAnimInfo startFrame repetitions
		destroyDialog importMotion	
	)
	
	on cancel pressed do destroyDialog importMotion
		
	on importMotion open do 
	(
		local recent, items = #()
		recent = getINIsetting DATconfig.DarkINIfile "Recent motions"
		if recent.count>0 then
		(
			items = invertArray recent
		)
		insertItem "Select from the list:" items 1
		getRecent.items = items
		
-- 		offset = getOffset()
		
		refreshRollout()
		refreshRolloutExt()
	)
	
	fn UpdatePose =
	(
		currFrame = sp_frame.value + (setStartFrame.value - 1) 
		sliderTime = currFrame
		--offset = getOffset()
		with animate on applyFrame currentAnimInfo sp_frame.value offset
	)
	
	on sp_x1 changed val do 
	(			
		currentAnimInfo.channels[1][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y1 changed val do 
	(			
		currentAnimInfo.channels[1][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z1 changed val do 
	(			
		currentAnimInfo.channels[1][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x2 changed val do 
	(			
		currentAnimInfo.channels[2][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y2 changed val do 
	(			
		currentAnimInfo.channels[2][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z2 changed val do 
	(			
		currentAnimInfo.channels[2][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x3 changed val do 
	(			
		currentAnimInfo.channels[3][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y3 changed val do 
	(			
		currentAnimInfo.channels[3][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z3 changed val do 
	(			
		currentAnimInfo.channels[3][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x4 changed val do 
	(			
		currentAnimInfo.channels[4][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y4 changed val do 
	(			
		currentAnimInfo.channels[4][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z4 changed val do 
	(			
		currentAnimInfo.channels[4][sp_frame.value].z = val		
		UpdatePose()
	)	
	
	on sp_x5 changed val do 
	(			
		currentAnimInfo.channels[5][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y5 changed val do 
	(			
		currentAnimInfo.channels[5][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z5 changed val do 
	(			
		currentAnimInfo.channels[5][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x6 changed val do 
	(			
		currentAnimInfo.channels[6][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y6 changed val do 
	(			
		currentAnimInfo.channels[6][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z6 changed val do 
	(			
		currentAnimInfo.channels[6][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x7 changed val do 
	(			
		currentAnimInfo.channels[7][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y7 changed val do 
	(			
		currentAnimInfo.channels[7][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z7 changed val do 
	(			
		currentAnimInfo.channels[7][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x8 changed val do 
	(			
		currentAnimInfo.channels[8][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y8 changed val do 
	(			
		currentAnimInfo.channels[8][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z8 changed val do 
	(			
		currentAnimInfo.channels[8][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x9 changed val do 
	(			
		currentAnimInfo.channels[9][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y9 changed val do 
	(			
		currentAnimInfo.channels[9][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z9 changed val do 
	(			
		currentAnimInfo.channels[9][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x10 changed val do 
	(			
		currentAnimInfo.channels[10][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y10 changed val do 
	(			
		currentAnimInfo.channels[10][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z10 changed val do 
	(			
		currentAnimInfo.channels[10][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x11 changed val do 
	(			
		currentAnimInfo.channels[11][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y11 changed val do 
	(			
		currentAnimInfo.channels[11][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z11 changed val do 
	(			
		currentAnimInfo.channels[11][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x12 changed val do 
	(			
		currentAnimInfo.channels[12][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y12 changed val do 
	(			
		currentAnimInfo.channels[12][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z12 changed val do 
	(			
		currentAnimInfo.channels[12][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x13 changed val do 
	(			
		currentAnimInfo.channels[13][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y13 changed val do 
	(			
		currentAnimInfo.channels[13][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z13 changed val do 
	(			
		currentAnimInfo.channels[13][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x14 changed val do 
	(			
		currentAnimInfo.channels[14][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y14 changed val do 
	(			
		currentAnimInfo.channels[14][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z14 changed val do 
	(			
		currentAnimInfo.channels[14][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x15 changed val do 
	(			
		currentAnimInfo.channels[15][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y15 changed val do 
	(			
		currentAnimInfo.channels[15][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z15 changed val do 
	(			
		currentAnimInfo.channels[15][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x16 changed val do 
	(			
		currentAnimInfo.channels[16][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y16 changed val do 
	(			
		currentAnimInfo.channels[16][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z16 changed val do 
	(			
		currentAnimInfo.channels[16][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x17 changed val do 
	(			
		currentAnimInfo.channels[17][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y17 changed val do 
	(			
		currentAnimInfo.channels[17][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z17 changed val do 
	(			
		currentAnimInfo.channels[17][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x18 changed val do 
	(			
		currentAnimInfo.channels[18][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y18 changed val do 
	(			
		currentAnimInfo.channels[18][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z18 changed val do 
	(			
		currentAnimInfo.channels[18][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x19 changed val do 
	(			
		currentAnimInfo.channels[19][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y19 changed val do 
	(			
		currentAnimInfo.channels[19][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z19 changed val do 
	(			
		currentAnimInfo.channels[19][sp_frame.value].z = val		
		UpdatePose()
	)
	
	on sp_x20 changed val do 
	(			
		currentAnimInfo.channels[20][sp_frame.value].x = val		
		UpdatePose()
	)
	
	on sp_y20 changed val do 
	(			
		currentAnimInfo.channels[20][sp_frame.value].y = val		
		UpdatePose()
	)
	
	on sp_z20 changed val do 
	(			
		currentAnimInfo.channels[20][sp_frame.value].z = val		
		UpdatePose()
	)
)

-- rollout renameAI "Rename Character"
-- (
-- 	editText name "Name:" fieldwidth:100 align:#left
-- )

rollout exportMotion "Export Motion"
(
	group "Frame Range:" 
	(
		spinner firstFrame "First Frame:" type:#integer range:[-99999,99999,1] align:#right fieldwidth:60 
		spinner lastFrame "Last Frame:" type:#integer range:[-99999,99999,1] align:#right fieldwidth:60 
	)
	group "Motion Name (inside .mi file):"
	(
		radiobuttons motnameSource "" labels:#("Same as file name (default)", "Custom") align:#left columns:1
		edittext motname "max. 16 char.:" fieldwidth:140
	)
	button bt_exportMotion "Export Motion" width:160 height:40 offset:[0,30]
	
	fn exportMotionFile currentAnimInfo start end =
	(		
		local frameCount 
		local creatureType = currentAnimInfo.charMan.creaType
		local unknown
		local charMan = currentAnimInfo.charMan

 		-- Exporting motion info to .MI file

		MIfile = fOpen currentAnimInfo.MIfilename "wb"
	
		WriteLong MIfile 0		-- first value always 0		
		-------------------------------------------------------------------------------------------------------------------------------------------------
		WriteLong MIfile 524287 	-- TEMP: Humanoid type of motions. Will depend on the creature	type later on
		-------------------------------------------------------------------------------------------------------------------------------------------------
		frameCount = End - Start + 1							-- frame count of the motion
		currentAnimInfo.frameCount = frameCount
		WriteFloat  MIfile (frameCount as float)
		WriteLong MIfile 30 											-- frame rate always 30
		if currentAnimInfo.unknown == undefined then unknown = 0
			else unknown = currentAnimInfo.unknown
		WriteLong MIfile unknown 									-- another unknown. Let's make it 0
		WriteBString MIfile currentAnimInfo.name 16			-- motion name
		for i = 1 to 15 do WriteLong MIfile 0 #unsigned 	-- 15 zeros
		
		currentAnimInfo.tracksNum = AIstructure[creatureType].motionTracks
		WriteLong MIfile currentAnimInfo.tracksNum
		
		WriteLong MIfile 0												-- unknown
		
		currentAnimInfo.flagsNum = $.modifiers[1].flags.keys.count	-- numbers of flags set
		WriteLong MIfile currentAnimInfo.flagsNum 
		
		WriteLong MIfile 0												-- unknown
				
		currentAnimInfo.trackMapping = #()
		for i = 1 to currentAnimInfo.tracksNum do
		(
			if i == 1 then TrackType = 1 else TrackType = 0
			JointNumber = AIstructure[creatureType].motionTracksMap[i]
			--if JointNumber == 0 then JointNumber = 1	-- this is to cover an exception where the root joint is referenced as -1 sometimes...
			TrackNumber = i			
			currentAnimInfo.trackMapping[i] = TrackMappingStruct TrackType:TrackType  JointNumber:JointNumber TrackNumber:TrackNumber
			WriteLong MIfile TrackType #signed
			WriteLong MIfile (JointNumber-1) #signed
			WriteLong MIfile (TrackNumber-1) #signed
		)
		currentAnimInfo.flags = #()
		if currentAnimInfo.flagsNum > 0 then
		(			
			flagskeys = $.modifiers[1].flags.keys
			for i = 1 to currentAnimInfo.flagsNum do
			(				
				FrameNumber = flagsKeys[i].time.frame
				FlagType = flagsKeys[i].value
				currentAnimInfo.flags[i] = FlagStruct FrameNumber:FrameNumber FlagType:FlagType
				WriteLong MIfile FrameNumber #signed
				WriteLong MIfile FlagType 
			)
		)
		fClose MIfile
		format "\\\\INFO: Succesfully exported .MI file: %\n" currentAnimInfo.MIfilename
		--
		--  Exporting motion channels info - ._MC files
		--
		MCfile = fOpen currentAnimInfo.MCfilename "wb"
		WriteLong MCfile currentAnimInfo.tracksNum #unsigned		-- number of channell tracks
		-- offsets for channel data. 
		-- There are a few fields spare, filled with zeroes. A gap between this chunk and the next one, sort of...
		-- it shouldn't really matter, as long as the offsets point into the right place in the files.
		
		local spareFields = 5 							-- this might change per creature (or not be used at all, if it doesn't break anything)
		
		local dataStart = #()
		dataStart[1] = (1 + currentAnimInfo.tracksNum + sparefields) * 4 	
		WriteLong MCfile dataStart[1] #unsigned						-- start of the first track
		dataStart[2] = dataStart[1] + frameCount * 3 * 4		-- transitional channell length
		WriteLong MCfile dataStart[2] #unsigned 						-- start of the second track
				
		for i=3 to currentAnimInfo.tracksNum do
		(
			dataStart[i] = dataStart[i-1] + frameCount * 4 * 4	-- rotational channell length
			--print dataStart[i]
			WriteLong MCfile dataStart[i] #unsigned
		)		
		
		for i = 1 to spareFields do WriteLong MCfile 0	-- just zeroes
		
		-- motion channels data:
		local channelData = #()
		local trackInfo, trackType
		local actualTrack
		local root, joint, ref, rotMatrix, eulerRot, fileEulerRot, quatRot
		
		-- Calculate channels data first: 
		-- Going backwards - from Parent to Child
		currentAnimInfo.channels = #()
		--for track = currentAnimInfo.tracksNum to 1 by -1 do
		for track = 1 to currentAnimInfo.tracksNum do
		(			
			trackInfo = currentAnimInfo.trackMapping[track]
			trackType = trackInfo.TrackType
			channelData = #()
						
			if trackType == rotational then
			(		
				--joint = charMan.skinBones[trackInfo.JointNumber].node
				ref = charMan.rotationRef[trackInfo.JointNumber].node				
				for frame = 1 to currentAnimInfo.frameCount do
				(	
					at time frame
					(
						rotMatrix = ref.transform * inverse ref.parent.transform		-- relative joint rotation as matrix
						eulerRot = rotMatrix as eulerAngles							-- relative joint rotation in euler angles
						-- 3dsmax to Dark Engine conversion:
						fileEulerRot = eulerAngles -eulerRot.z eulerRot.y -(eulerRot.x-180)
						quatRot = fileEulerRot as quat
					---
						channelData[frame-start+1] = quat quatRot.x quatRot.y quatRot.z quatRot.w
					)
				)
			)
			else 	--transitional
			(				
				root = charMan.rootctrl.node
				joint = charMan.skinbones[trackInfo.JointNumber].node				
				/* at time start 
				(
					rootTrans = root.transform
					jointTrans = joint.transform											
					exportTransMat = jointTrans * inverse rootTrans	
					zOffset = exportTransMat.row4.z 					
				) */
-- 				zOffset = 3.35236 -- hardcoded only for this Test character! -- needs to be a custom attribute on charman
				zOffset = charman.buttHeight
				for frame = start to end do
				(
					at time frame 
					(
						rootTrans = root.transform
						jointTrans = joint.transform											
						exportTransMat = jointTrans * inverse rootTrans			-- translation relative to RootCTRL position and orientation						
						exportTrans = exportTransMat.row4
						exportTrans.z = exportTrans.z - zOffset							-- taking out the Z offset from the actual movement data
						exportTrans = exportTrans / charMan.calibration			-- take out the calibration factor (AI size)
					
						channelData[frame-start+1] = exportTrans
					)
				)
			)	
			currentAnimInfo.channels[track] = channelData
		) -- end for track
		
		-- Export channels data to file
		for track = 1 to currentAnimInfo.tracksNum do
		(				
			fSeek MCfile dataStart[track] #seek_set
			trackInfo = currentAnimInfo.trackMapping[track]
			trackType = trackInfo.TrackType
			channelData = currentAnimInfo.channels[track]
			--print channelData
						
			if trackType == rotational then
			(				
				for frame = 1 to currentAnimInfo.frameCount do
				(					
					quatRot = channelData[frame]
					WriteFloat MCfile quatRot.z
					WriteFloat MCfile quatRot.w
					WriteFloat MCfile quatRot.x					
					WriteFloat MCfile quatRot.y
				)
			)
			else 	--transitional
			(	
				for frame = 1 to currentAnimInfo.frameCount do
				(
					exportTrans = channelData[frame]
					WriteFloat MCfile exportTrans.x
					WriteFloat MCfile exportTrans.y
					WriteFloat MCfile exportTrans.z
				)
			)			
		) -- end for track
		
		fClose MCfile		
		format "\\\\INFO: Succesfully exported .MC file: %\n" currentAnimInfo.MCfilename
		
	
	) -- end fn exportMotionFile
	
	fn updateCurrentAnimInfo = 
	(
		
	)
	
	on bt_exportMotion pressed do
	(
		MIfileName = getSaveFileName caption:"Export motion to a file:" \
		filename:(DATconfig.paths[DATconfig.game].Motions + "\\") \
		types:"MotionInfo files (*.mi)|*.mi" \
		historyCategory:"MotionFiles"
		if  MIfilename != undefined then
		(
			currentAnimInfo.MIfileName = MIfilename
			MotionFileNoExt = (getFileNameFile currentAnimInfo.MIfileName)										
			MotionPath = getFileNamePath currentAnimInfo.MIfileName
			MCfileName =  MotionPath + MotionFileNoExt + "_.mc"
			currentAnimInfo.MCfilename = MCfileName 
			format "MC filename: %\n" MCfilename
			
			currentAnimInfo.name = case motNameSource.state of
			(
				(1):MotionFileNoExt
				(2):motName.text
			)
			
			
			exportMotionFile currentAnimInfo firstframe.value lastframe.value
			---
-- 			copyfile 
			---
			destroyDialog exportMotion
		)
	)  -- end exportMotion pressed
	
	on motNameSource changed state do
	(
		motName.enabled = case state of
		(
			(1):false
			(2):true
			default:false
		)
	)
	
	on motName changed val do
	(
		if val.count>16 then motName.text = substring val 1 16
	)
	
	on exportMotion open do
	(
		firstframe.value = animationRange.start.frame
		lastFrame.value = animationRange.end.frame
		try (motname.text = currentAnimInfo.name); catch (motname.text = "")
		motname.enabled = false
	)
		
) -- end exportMotion rollout



AIRootCA = attributes AIRoot attribID:#(0x281c9c92, 0x33ddf1b6)
(
-- 	struct channelData = #()  -- ? what was this meant to be?
		
	parameters main rollout:controls
	(
		charMan type:#maxobject
	)
	
	parameters flags rollout:flagcontrols
	(
		flags type:#integer default:1
	)

	fn resetAnimation CharMan =
	(		
		undo  "Reset Animation" on
		(
			-- reset controls transforms
			local animCTRLS = (CharMan.fkctrls as array) + (CharMan.ikctrls as array) + (CharMan.otherctrls as array)
-- 			local otherCTRLS = (CharMan.otherctrls as array)
-- 			deleteItem allOtherButRoot 1
-- 			animCTRLS = animCTRLS + allOtherButRoot
			
			for obj = 1 to animCTRLS.count do
			(				
				if animCTRLS[obj] != undefined then
				(				
					local curObj = animCTRLS[obj].node
					rotController = CurObj.rotation.controller[2]				
					deleteKeys rotController #allKeys
					CurObj.rotation.controller[2].x_rotation = 0
					CurObj.rotation.controller[2].y_rotation = 0
					CurObj.rotation.controller[2].z_rotation = 0				
					
					posController = CurObj.position.controller[2]
					
					deleteKeys posController #allKeys
					CurObj.Position.controller[2].x_Position = 0
					CurObj.Position.controller[2].y_Position = 0
					CurObj.Position.controller[2].z_Position = 0
				)
			)
			-- reset custom attributes
			animCTRLS = (CharMan.ikctrls as array) 
			append animCTRLS CharMan.rootctrl
			for obj in animCTRLS do
			(
				ca = undefined
				try (
					ca = custAttributes.get obj.node.modifiers[1] 1				
				); catch()
-- 				print ca
				if ca != undefined then
				(
					for i = 1 to ca.numSubs do
					(
						try (deleteKeys ca[i].keys #allKeys); catch()
						ca[i].value = 0
					)
				)			
			)
			--
			currentAnimInfo = AnimInfoStruct()
			currentAnimInfo.charMan = charMan
		) -- end undo
	) -- end fn ResetAnimation

--	
-- 	Rollout definition
--	
	rollout controls "Character Controls"
	(
 		editText AIname "Name:" fieldwidth:105 align:#left 
 		button rename "Rename character" width:120 height:30
		
		group "Animation"
		(
			button animImport "Import Motion" width:120 height:30
			button animExport "Export Motion" width:120 height:30
			button reset "Reset" width:120 offset:[0,10]
		)
		group "Rig elements selection"
		(
			button selectCM "Character Manager" width:120 height:20 visible:DAT.advmode
			button selectSkin "Skin bones" width:120 height:20 visible:DAT.advmode
			button selectIKbones "IK bones" width:120 height:20 visible:DAT.advmode
			button selecthelpers "Helpers" width:120 height:20 visible:DAT.advmode
			button selectfkctrls "FK CTRLs" width:120 height:20 offset:[0, -96 * (bool2int (not DAT.advmode))]
			button selectikctrls "IK CTRLs" width:120 height:20
		)
		group "Delete AI"
		(
			button deleteMe "Delete Me" width:120 height:25
		)
		
		fn getAllAIObjects chM =
		(
			allObjects = #()
			for ntm in (chM.rotationRef as array) where ntm!=undefined do
				append allObjects ntm.node
			for ntm in (chM.skinBones as array)  where ntm!=undefined do
				append allObjects ntm.node
			for ntm in (chM.ikBones as array)  where ntm!=undefined do
				append allObjects ntm.node
			for ntm in (chM.fkctrls as array)  where ntm!=undefined do
				append allObjects ntm.node
			for ntm in (chM.ikctrls as array)  where ntm!=undefined do
				append allObjects ntm.node
			for ntm in (chM.otherctrls as array)  where ntm!=undefined do
				append allObjects ntm.node
			for ntm in (chM.helpers as array)  where ntm!=undefined do
				append allObjects ntm.node
			append allObjects chM.rootctrl.node
			append allObjects chM.geo.node
			allObjects
		)
		
		on rename pressed do
		(	
			undo "Rename Character" on
			(
				oldName = charMan.node.AIname			
-- 				print oldName
				toBeRenamed = getAllAIObjects charMan.node
				for obj in toBeRenamed do
				(				
					newName = replace obj.name 1 oldName.count AIname.text				
					obj.name = newName				
				)
				charMan.node.AIname = AIname.text
				LM = LayerManager
				for l = 0 to LM.count-1 do
				(
					lyr = LM.getLayer l	
					LayerName = lyr.name
					if (findString LayerName oldName) != undefined then
					(						
						newName = replace LayerName 1 oldName.count AIname.text
						lyr.setName newName
					)
				)
			)
		)

		
		on animImport pressed do
		(	
			currentAnimInfo = AnimInfoStruct()
-- 			print charMan.node
			currentAnimInfo.charMan = charMan.node
			importMotionDialog = createDialog importMotion 250 230  lockwidth:false lockheight:false --modal:true
		)
		
		on animExport pressed do
		(	
			if currentAnimInfo == undefined then currentAnimInfo = AnimInfoStruct()
-- 			print charMan.node
			currentAnimInfo.charMan = charMan.node
			exportMotionDialog = createDialog exportMotion 250 250 lockwidth:false lockheight:false modal:true
		)
		
		on reset pressed do
		(
 			if (queryBox "Are you sure you want to delete all the animation?" title:"Reset Animation") == true then
			(
				resetAnimation CharMan.node
			)
		)
		
		on selectSkin pressed do
		(
			local objs = #()
			local skinBones = CharMan.node.skinBones as array
			for i = 1 to skinBones.count do 
				skinBones[i] = skinBones[i].node
			for o in skinBones where (isValidNode o == true) do append objs o 
			select objs
		)
		
		on selectIKbones pressed do
		(
			local objs = #()
			local ikBones = CharMan.node.ikBones as array
			for o in ikBones where o!=undefined do 
				append objs o.node
			select objs
		)
		
		on selectfkctrls pressed do
		(
			local objs = #()
			local fkctrls = CharMan.node.fkctrls as array
			for i = 1 to fkctrls.count do 
				if fkctrls[i] != undefined then
					fkctrls[i] = fkctrls[i].node
			for o in fkctrls where (isValidNode o == true) do append objs o 
			select objs
		)
		
		on selectikctrls pressed do
		(
			local objs = #()
			local ikctrls = CharMan.node.ikctrls as array
			for i = 1 to ikctrls.count do 
				if ikctrls[i] != undefined then
					ikctrls[i] = ikctrls[i].node
			for o in ikctrls where (isValidNode o == true) do append objs o 
			select objs
		)
		
		on selectHelpers pressed do
		(
			local objs = #()
			local hlprs = CharMan.node.helpers as array
			for i = 1 to hlprs.count do 
				hlprs[i] = hlprs[i].node
			for o in hlprs where (isValidNode o == true) do append objs o 
			select objs
		)		
			
		on selectCM pressed do
			select CharMan.node
		
		on deleteMe pressed do
		(
			undo "Delete Character" on
			(
				chM = charMan.node
				toBeDeleted = #()
				toBeDeleted = getAllAIObjects chM
				-- delete them all! --
				delete toBeDeleted
			)
		)
		
		on controls open do
		(
			AIname.text = charMan.node.AIname
			--gfdg
		)
	)
	
	rollout flagControls "Flags"
	(	
		checkbox flag01 "Standing" 
		checkbox flag02 "LeftFootfall" 
		checkbox flag03 "RightFootfall" 
		checkbox flag04 "LeftFootUp" 
		checkbox flag05 "RightFootUp" 
		checkbox flag06 "FireRelease" 
		checkbox flag07 "CanInterrupt" 
		checkbox flag08 "StartMotionHere" 
		checkbox flag09 "EndMotionHere" 
		checkbox flag10 "BlankTag1" 
		checkbox flag11 "BlankTag2" 
		checkbox flag12 "BlankTag3" 
		checkbox flag13 "Trigger1" 
		checkbox flag14 "Trigger2" 
		checkbox flag15 "Trigger3" 
		checkbox flag16 "Trigger4" 
		checkbox flag17 "Trigger5" 
		checkbox flag18 "Trigger6" 
		checkbox flag19 "Trigger7" 
		checkbox flag20 "Trigger8" 
		--button refresh "Refresh" width:120
		button clearAll "Clear All" width:140 height:25
		
		
		fn RefreshRollout =
		(			
			local ctrls = flagcontrols.controls
			local keys 			
			keys = for k in flags.keys collect k.time
			if (findItem keys currentTime) > 0 then 
			(
				local flagTemp = flags				
				for i = 20 to 1 by -1 do
				(
					flagValue  = 2 ^ (i-1)
					if flagTemp >= flagValue then 
					(
						ctrls[i].state= true 
						flagTemp = flagTemp - flagValue 
					)
					else ctrls[i].state = false				
				)
				--print "Just updated the flags...\n"
			)
			else 
			for i = 1 to 20 do ctrls[i].state = false
		)
		
		fn setFlag flagNo state =
		(
			local keys 
			keys = for k in flags.keys collect k.time
			if state == true then
			(
				with animate on
				(
					if (findItem keys currentTime) == 0 then flags = 0
					
					flags = flags + 2 ^ (flagNo - 1)
				)
			)
			--keys = for k in flags.keys collect k.time	
			if state == false then
			(
				with animate on
					flags = flags - 2 ^ (flagNo - 1)
				
				if flags == 0 then 
				(
					deleteKey flags.keys (findItem keys currentTime)
				)
			)
			RefreshRollout()
		)
		
		fn clearAllFlags =
		(
			local keys 
			
			with animate on flags = 0
				
			keys = for k in flags.keys collect k.time
			deleteKey flags.keys (findItem keys currentTime)
			RefreshRollout()
		)
		
		fn registerFlagsCallback =
		(
			registerTimeCallback RefreshRollout
		)
		
		fn unregisterFlagsCallback =
		(
			unRegisterTimeCallback RefreshRollout
		)
		
		--on refresh pressed do RefreshRollout()
		
		on flag01 changed state do setFlag 1 state
		
		on flag02 changed state do setFlag 2 state
			
		on flag03 changed state do setFlag 3 state
			
		on flag04 changed state do setFlag 4 state
			
		on flag05 changed state do setFlag 5 state
			
		on flag06 changed state do setFlag 6 state
			
		on flag07 changed state do setFlag 7 state
		
		on flag08 changed state do setFlag 8 state
		
		on flag09 changed state do setFlag 9 state
		
		on flag10 changed state do setFlag 10 state
		
		on flag11 changed state do setFlag 11 state
		
		on flag12 changed state do setFlag 12 state
			
		on flag13 changed state do setFlag 13 state
			
		on flag14 changed state do setFlag 14 state
			
		on flag15 changed state do setFlag 15 state
			
		on flag16 changed state do setFlag 16 state
			
		on flag17 changed state do setFlag 17 state
		
		on flag18 changed state do setFlag 18 state
		
		on flag19 changed state do setFlag 19 state
		
		on flag20 changed state do setFlag 20 state
			
		on clearAll pressed do 
			undo "Clear All Flags" on
				clearAllFlags()
		
		on flagcontrols open do 
		(
			registerFlagsCallback()
			RefreshRollout()
		)
		
		on flagcontrols close do 
		(
			unregisterFlagsCallback()
		)
	)
)

FootCA = attributes FootCTRL attribID:#(0xb85c128, 0x3d677201) -- was #(0xb85c128, 0x3d677201) 
(
	Parameters main rollout:params
	(
		fkikblend Type:#float UI:ui_FKIKblend Default:1.0
		swivel Type:#float UI:ui_swivel Default:0.0
		footLift Type:#float UI:ui_footLift Default:0.0
		footBanking Type:#float UI:ui_footBanking Default:0.0
		heelPivot Type:#float UI:ui_heelPivot Default:0.0
		toesPivot Type:#float UI:ui_toesPivot Default:0.0
		---
-- 		charMan type:#node 
-- 		type type:#integer	animatable:false
		/* 
		1 - human leg ctrl
		2 - human arm ctrl
		 */
-- 		side type:#integer Default:0 animatable:false -- 0 left   1 right  
		fk1 type:#maxObject
		fk2 type:#maxObject
		fk3 type:#maxObject
		ik1 type:#maxObject
		ik2 type:#maxObject
		ik3 type:#maxObject
		ikctrl type:#maxObject
-- 		swivelctrl type:#maxObject
-- 		swivel Type:#float UI:ui_swivel Default:0.0
	)

	Rollout Params "Foot Controls"
	(
		spinner ui_FKIKblend "FK / IK blend:" fieldwidth:40 Height:16 Align:#Right Offset:[0,0] Type:#float Range:[0,1,0] scale:0.01
		slider sl_fkikblend "" ticks:1 range:[0,1,0] type:#float scale:0.01
		group "FK / IK snap" 
		(
			button ui_FKtoIK "FK --> IK" width:100 height:30 
			button ui_IKtoFK "IK --> FK" width:100 height:30
		)		
		spinner ui_swivel "Swivel:" fieldWidth:40 Height:16 Align:#Right Offset:[0,10] Type:#float Range:[-1,1,0] scale:0.01
		spinner ui_footLift "Foot Lift:" fieldWidth:40 Height:16 Align:#Right Offset:[0,10] Type:#float Range:[-1,1,0] scale:0.01	
		spinner ui_footBanking "Foot Banking:" fieldWidth:40 Height:16 Align:#Right Offset:[0,0] Type:#float Range:[-1,1,0]
		spinner ui_heelPivot "Heel Pivot:" fieldWidth:40 Height:16 Align:#Right Offset:[0,0] Type:#float Range:[-1,1,0]
		spinner ui_toesPivot "Toes Pivot:" fieldWidth:40 Height:16 Align:#Right Offset:[0,0] Type:#float Range:[-1,1,0]		
		group "Reset"
		(
			button ui_reset "Reset Leg Pose" width:120 height:30
		)
		
		on ui_FKIKblend changed val do
			sl_fkikblend.value = val

		on sl_fkikblend changed val do
			ui_fkikblend.value = val

		on ui_FKtoIK pressed do
		(		
  			undo "Snap FK to IK" on
 			(
				fk1.node.transform = ik1.node.transform
				fk2.node.transform = ik2.node.transform
				fk3.node.transform = ik3.node.transform
 			)
		)
		
		on ui_IKtoFK pressed do
		(
  			undo "Snap IK to FK" on
				IKCtrl.node.transform = fk3.node.transform
		)
		
		on ui_reset pressed do
		(				
  			undo "Reset Leg Pose" on
			(
				fk1.node.rotation.controller[2].rotation = eulerAngles 0 0 0
				fk2.node.rotation.controller[2].rotation = eulerAngles 0 0 0
				fk3.node.rotation.controller[2].rotation = eulerAngles 0 0 0
				IKCtrl.node.rotation.controller[2].rotation = eulerAngles 0 0 0			
				IKCtrl.node.position.controller[2].position = [0,0,0]
-- 				swivelCtrl.node.position.controller[2].position = [0,0,0]
				swivel = 0
				footLift = 0
				footBanking = 0
				heelPivot = 0
				toesPivot = 0
			)
		)		
		
		on Params open do
			sl_fkIKblend.value = ui_fkIKblend.value
	)
)

HandCA = attributes HandCTRL attribID:#(0x3c294aa7, 0x20ff16f2) -- was #(0x3c294aa6, 0x20ff16f2)
(
	Parameters main rollout:params
	(
		fkikblend Type:#float UI:ui_FKIKblend Default:0.0 
		swivel Type:#float UI:ui_Swivel Default:0.0
		---
-- 		charMan type:#node 
		--side type:#integer Default:0  -- 0 left   1 right
		fk1 type:#maxObject  
		fk2 type:#maxObject  
		fk3 type:#maxObject  
		ik1 type:#maxObject  
		ik2 type:#maxObject  
		ik3 type:#maxObject  
		IKCtrl type:#maxObject 
	)
	
	Rollout Params "Hand Controls"
	(
		spinner ui_Swivel "Swivel:" fieldwidth:40 height:16 Align:#Right Type:#float Range:[-1,1,0] scale:0.01
		spinner ui_FKIKblend "FK / IK blend:" fieldwidth:40 Height:16 Align:#Right Offset:[0,10] Type:#float Range:[0,1,0] scale:0.01
		slider sl_fkikblend "" ticks:1 range:[0,1,0] type:#float scale:0.01
		group "FK / IK snap" 
		(
			button ui_FKtoIK "FK --> IK" width:100 height:30 
			button ui_IKtoFK "IK --> FK" width:100 height:30
		)	
		group "Reset"
		(
			button ui_resetPose "Reset Arm Pose" width:120 height:30
			button ui_reset "Reset Arm Animation" width:120 height:30
		)
		
		fn resetPose =
		(				
			fk1.node.rotation.controller[2].rotation = eulerAngles 0 0 0
			fk2.node.rotation.controller[2].rotation = eulerAngles 0 0 0
			fk3.node.rotation.controller[2].rotation = eulerAngles 0 0 0
			IKCtrl.node.rotation.controller[2].rotation = eulerAngles 0 0 0			
			IKCtrl.node.position.controller[2].position = [0,0,0]
			swivel = 0
		)	
		
		on ui_FKIKblend changed val do
			sl_fkikblend.value = val

		on sl_fkikblend changed val do
			ui_fkikblend.value = val


		on ui_FKtoIK pressed do
		(		
 			undo "Snap FK to IK" on
			(
				fk1.node.transform = ik1.node.transform
				fk2.node.transform = ik2.node.transform
				fk3.node.transform = ik3.node.transform
			)
		)
		
		on ui_IKtoFK pressed do
		(
 			undo "Snap IK to FK" on
				IKCtrl.node.transform = fk3.node.transform
		)
		
		on ui_resetPose pressed do
		(				
			undo "Reset Arm Pose" on resetPose()
		)
		
		on ui_reset pressed do
		(
			undo "Reset Arm Animation" on
			(
				deleteKeys fk1.node #allKeys
				deleteKeys fk2.node #allKeys
				deleteKeys fk3.node #allKeys
				deleteKeys IKCtrl.node #allKeys
 				deleteKeys 	fkikblend.controller #allKeys
				deleteKeys 	swivel.controller  #allKeys
			)
		)
		
		on Params open do
		(
			sl_fkIKblend.value = ui_fkIKblend.value
		)
	)
)

