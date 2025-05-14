/* ------------------------------------------------------
/* 			Dark Animation Tools
/* 		motion schemas functions
/* ------------------------------------------------------
/* author: Juliusz Kaczmarek
/* ver. 0.01
/* Nov. 2013
/*
/* tools for importing and exporting
/* rigged characters and their motions
/* from and to dark engine games. 
/*
/* this script was possible thanks to the knowledge and experience 
/* of Volca, Shadowspawn, Weyoun, Telliamed
/* ------------------------------------------------------
*/
global schemas = #()		-- all schemas
global msch					--  motion schemas struct
global MfilePicked			-- motion file picked by schema

struct tag (
	name,
	value
)

struct motion (
	name,
	value1,
	value2
)

struct mosch (
	tags = #(),
	torso,
	type,
	timeScale,
	XYZScale,
	motionList = #()
)


struct moschemas (		
	Mschemas = #(),
	MSNames = #(),
	Mtags = #(),
	Mtorsos = #(),
	Mtypes = #("All"),
		
	-- read schemas from the .mos files
	fn readSchemas = 
	(
		local mosFiles = #()
		local mos
		local mosLine
		local token
		local globalTag, globalTorso
		local currSchema		
		
		schemas = #()
		Mschemas = #()
		MSNames = #()
		Mtags = #()
		Mtorsos = #()
		Mtypes = #("All")
		
		mosFiles = getFiles (DATconfig.paths[DATconfig.game].MSchema + "\\*.mos")
		if mosFiles.count > 0 then
		(
			for mosName in mosFiles do
			(
				level = #global -- can be global or schema
				globalTag = undefined
				globalTorso = ""
				currSchema = undefined
				mos = openFile mosName
				while (eof mos)==false do
				(
					mosLine = ReadLine mos
					mosLine = trimLeft mosLine
					mosLine = trimRight mosLine
					if mosLine!="" then
					(
						filtered = filterString mosLine ", "
						token = toLower filtered[1]	-- all tokens below are to be in lower case
						case token of (
							"global":
							(
								globalTag = tag name:filtered[2] value:filtered[3]
							)
							"torso":
							(
								TorsoName = filtered[2]
								TorsoName = case (toUpper TorsoName) of (
									"T0":"Biped"
									"T1":"PlayerArm"
									"T2":"PlayerBow"
									"T3":"Burrick"
									"T4":"Spider"
									"T5":"Constantine"
									"T6":"Sweel"
									"T7":"Available1"
									"T8":"Apparition"
									"T9":"Droid"
									default:TorsoName
								)
								case level of (
									#global:globalTorso = TorsoName
									#schema:currSchema.torso = TorsoName
								)
								appendIfUnique Mtorsos TorsoName								
							)
							"schema":
							(
								level = #schema
								if currSchema != undefined then append schemas currSchema 
								currSchema = mosch()	-- new schema
								-- global tags/torsos - if exist
								schemaName = ""
								if globalTag != undefined then 
								(
									schemaName = globalTag.name + " " + globalTag.value + ", "
									append currSchema.tags globalTag
									appendIfUnique Mtags (globalTag.name)
								)
								if globalTorso != "" then currSchema.torso = globalTorso
								
								
								tagsNo = (filtered.count-1) / 2
								for i = 1 to tagsNo do
								(
									currtag = tag name:(filtered[i*2]) value:(filtered[i*2+1])
									append currSchema.tags currtag
									appendIfUnique Mtags (currtag.name)
									if i<tagsNo then comma = ", " else comma =""
									schemaName = schemaName + currtag.name + " " + currtag.value + comma
								)
								
-- 								print schemaName
								append MSNames schemaName
							)
							"mtype":
							(
								currType = filtered[2]
								currSchema.type = currType
								appendIfUnique Mtypes currType
							)
							"timescale":currSchema.timescale = (filtered[2] as float)
							"scale2":currSchema.xyzscale = (filtered[2] as float)
							"xyzscale":currSchema.xyzscale = (filtered[2] as float)
							"motion":							
							(
								currMotion = motion name:(filtered[2]) value1:(filtered[3]) value2:(filtered[4])
								append currSchema.motionList currMotion
							)
							default:format "\\ERROR: Can't understand the line:%\n in file:%\n" mosLine mosName
						)
					)
				)
				close mos
				if currSchema != undefined then append schemas currSchema 
			)
		)
		else messagebox "No schemas found."
	)
)

rollout MotionSelector "Choose motion from schema:"
(	
	local gap = 10
	local filteredSchemas = #()
	local filteredMSNames = #()
	
	
	dropdownlist Mtorso "Torsos:" width:150 items:msch.Mtorsos pos:[gap,gap]
	checkbutton torsoLock "L" width:25 height:25 pos:[170,gap+16] checked:true
	dropdownlist types "Motion type:" items:msch.Mtypes width:150 height:(15) pos:[250,gap]
	button getTags ">>>" width:60 height:25 pos:[430,gap+16]
	multilistbox tags "Motion tags:" items:msch.Mtags width:140 pos:[510,gap] height:27
	listbox	schemaList "Schemas:" items:msch.MSNames width:480 height:10 pos:[gap,60]
	listbox motionList "Motions:" width:180 height:12 pos:[gap,230]
	radiobuttons tagsLogic "" labels:#("Any","All","Exclude") default:1 colums:2 align:#left  pos:[510, 392]
	button accept "OK" width:80 height:30 pos:[gap,415] -- was 260
	button cancel "Cancel" width:80 height:30 pos:[100,415] -- was 370
	button tagAll "All" width:40 height:30 pos:[510,415]
	button tagNone "None" width:40 height:30 pos:[555,415]
	button tagInv "Invert" width:40 height:30 pos:[600,415]	
	groupBox gb1 "Info:" pos:[200,240] width:290 height:165	
	label FilterInfo pos:[210,260] align:#left
	label schemaInfo "Selected schema:" pos:[210,290] align:#left
	label info1 pos:[210,310] align:#left
	label info2 pos:[210,325] align:#left
	label info3 pos:[210,340] align:#left
	label motInfo1 pos:[210,380] align:#left
	button dumpInfo	"Dump Info" width:80 height:30 pos:[200,415]
	
	fn dumpMotInfo =
	(
		allMotfiles = #()
		allMotfiles = getFiles (DATconfig.paths[DATconfig.game].Motions + "\\*.mi")
		if allMotFiles.count >0 then
		(
			format "\\\\INFO: Outputting motion info to a .CSV file"
			testAnimInfo = AnimInfoStruct()
			CSVfileName = DATconfig.paths[DATconfig.game].Motions + "\\MotionInfoDumpExt.csv"
			CSVfile = openFile CSVfileName mode:"wt"
			row = "File name,Motion name,Creature Code,Creature Name,Frame Count,Frame Rate,Unknown,Tracks Num,Flags Num"
			for i = 1 to 40 do
				row = row + ",Track " + (i as string)
			for i = 1 to 20 do
				row = row + ",Flag" + (i as string)
			format "%\n" row to:CSVfile
			
			for m =1 to allMotFiles.count do
			(
				testAnimInfo.MIfilename = allMotFiles[m]
				MotionName = (getFileNameFile testAnimInfo.MIfileName)										
				MotionPath = getFileNamePath testAnimInfo.MIfileName
				MCfileName =  MotionPath + MotionName + "_.mc"		
				testAnimInfo.MCfilename = MCfilename
				
				importResult = importMotion.importMotionFile testAnimInfo
				if importResult == true then
				(
					--format "%.   Imported %\n" m MotionName
					creatureName = creaTypeNames[importMotion.matchCreature testAnimInfo.creatureType]
					format "%,%,%,%,%,%,%,%,%" MotionName testAnimInfo.name testAnimInfo.creatureType creatureName (testAnimInfo.frameCount as integer) testAnimInfo.frameRate testAnimInfo.unknown testAnimInfo.tracksNum testAnimInfo.flagsNum to:CSVfile
					for i = 1 to testAnimInfo.tracksNum do
						format ",%" testAnimInfo.trackMapping[i].JointNumber to:CSVfile
					for i = 1 to (40-testAnimInfo.tracksNum) do
						format "," to:CSVfile
					for i = 1 to testAnimInfo.flagsNum do
						format ",%" testAnimInfo.flags[i].FlagType to:CSVfile
					format "\n" to:CSVfile
				)
				else 
				(
					format "\\\\ERROR: %. % importing failed.\n" m MotionName
					format "\\\\ERROR: %,%\n" MotionName "Failed"
				)
			)
			
			close CSVfile
			message = "Motion files info saved out into a file:\n" + CSVfileName
			messagebox message title:"Motion Info Dump"
		)
	)
	
	fn updateMotions val = 
	(
		motList = #()		
		if val>0 then
		(
			schMotList = schemas[filteredSchemas[val]].motionList
			if schMotList.count >0 then
			(
				for i = 1 to schMotList.count do
					append motList schMotList[i].name
			)
		)
		motionList.items = motList		
	)
	
	fn filterSchemas =
	(
		filteredMSnames = #()
		filteredSchemas = #()
		-- prepare active tags list
		tagsActive = #()
			for k = 1 to tags.items.count do
				if tags.selection[k]==true then append tagsActive tags.items[k]
					
		for i = 1 to schemas.count do
		(
			-- torso filter
			if Mtorso.selected == schemas[i].torso then
			(
				-- motion type filter
				if ((types.selected=="All" ) or (types.selected==schemas[i].type)) then
				(
					-- tag filter
					if tagsActive.count > 0 then
					(
						schema = schemas[i]
						stags = schema.tags
						j = 1
						tagsMatch = false
						tagsFound = 0
						do
						(
							if (findItem tagsActive stags[j].name) >0 then 							
							(
								tagsFound = tagsFound + 1
								if tagsLogic.state == 1 then tagsMatch = true  -- Any selected tags
								else 	
									if tagsLogic.state == 2 then
									(										
										if tagsFound == tagsActive.count then tagsMatch = true	-- All selected tags
									)
									else tagsMatch = true
									
							)
							
							
							j=j+1
						)
						while j<=stags.count --and tagsMatch==false
						
						if (tagsMatch == true and tagsLogic.state < 3) or (tagsMatch == false and tagsLogic.state == 3)  then								
						(
							append filteredSchemas i
							append filteredMSnames msch.MSNames[i]									
						)
					)
					else
					(
						append filteredSchemas i
						append filteredMSnames msch.MSNames[i]
					)
				)
			)
		)
		schemaList.items = filteredMSnames
		updateMotions schemaList.selection
	)
	
	fn refreshRollout = 
	(		
		local caption, caption1
		if torsoLock.checked then Mtorso.enabled = false
			else Mtorso.enabled = true
		if tags.selection.numberSet==0 then tagNone.enabled = false
			else tagNone.enabled = true
		-- filter info
		if tags.selection.NumberSet == 0 then caption = "" else caption = " Tag filter active."
		caption1 = "Showing " + ((schemaList.items.count) as string) + " of " + ((schemas.count) as string) + " motion schemas." + caption
		FilterInfo.caption = caption1
		-- schema info
		if schemaList.selection > 0 then
		(
			schema = schemas[filteredSchemas[schemaList.selection]]
			caption = "Motion Type: " + schema.type
			info1.caption = caption
			caption = "Time scale: " + schema.timescale as string
			info2.caption = caption
			caption = "XYZ scale: " + schema.xyzScale as string
			info3.caption = caption
		)
		else 
		(
			caption = ""
			Info1.caption = caption
			Info2.caption = caption
			Info3.caption = caption
		)
		-- motion info				
		if motionList.selection > 0 then
		(
			mot = schema.motionList[motionList.selection]
			caption = "Motion parameters: " + mot.value1 + "    " + mot.value2
			motInfo1.caption = caption
		)
		else 
		(
			caption = ""
			motInfo1.caption = caption
		)
	)
	
	on torsoLock changed state do	RefreshRollout()
	
	on Mtorso selected val do
	(
		filterSchemas()
		refreshRollout()
	)
	
	on types selected val do
	(		
		filterSchemas()
		refreshRollout()
	)
	
 	on tags selected val do
	(
		filterSchemas()
		refreshRollout()
	)
	
	on SchemaList selected val do
	(
		updateMotions val
		refreshRollout()
	)
	
	on motionList selected val do
	(
		refreshRollout()
	)
	
	on motionList rightclick val do
	(
		setclipboardText motionList.items[val]
	)
	
	on tagsLogic changed state do
	(		
		filterSchemas()
		refreshRollout()
	)
	
	on tagAll pressed do 
	(
		tags.selection = #All
		filterSchemas()
		refreshRollout()
	)
	
	on tagNone pressed do 
	(
		tags.selection = #{}
		filterSchemas()
		refreshRollout()
	)
		
	on tagInv pressed do 
	(
		tags.selection = -tags.selection
		filterSchemas()
		refreshRollout()
	)
	
	on getTags pressed do
	(
		newTags = #{}
		newTagNames = #()
		if filteredSchemas.count > 0 then
		(
			for i = 1 to filteredSchemas.count do
			(
				schema = schemas[filteredSchemas[i]]
				stags = schema.tags
				for j = 1 to stags.count do 
				(
					appendIfUnique newTagNames stags[j].name
				)
			)
			for i = 1 to tags.items.count do
			(
				tagName = tags.items[i]
				if (findItem NewTagNames tagName) > 0  then newTags[i] = true
			)		
		)
		tags.selection = newTags
		filterSchemas()
		refreshRollout()
	)
	
	on MotionSelector open do 
	(		
		msch.readSchemas()
		Mtorso.items = msch.Mtorsos
		types.items = msch.Mtypes
		tags.items = sort msch.Mtags
		filterSchemas()
		refreshRollout()
	)
	
	on accept pressed do
	(
		if motionList.selected != undefined then
			MfilePicked = motionList.selected 
		
		destroyDialog MotionSelector
	)
	
	on cancel pressed do 
	(
		MfilePicked = undefined
		destroyDialog MotionSelector
	)
	
	on MotionSelector close do
	(
		if MfilePicked == undefined then format "\\\\WARNING: No motion file selected.\n"
			else	format "\\\\INFO: motion file chosen: %\n" MfilePicked
	)
	
	on dumpInfo pressed do
		dumpMotInfo()
)	


----
msch = moschemas()
--  createDialog MotionSelector 660 460

