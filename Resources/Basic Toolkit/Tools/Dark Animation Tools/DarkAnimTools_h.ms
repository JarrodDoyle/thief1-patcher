/* -------------------------------------------
/* 			Dark Animation Tools
/* 					Header
/* -------------------------------------------
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
/* ------------------------------------------
*/

-- axis order
xyz = 1
xzy = 2
yzx = 3
yxz = 4
zxy = 5
zyx = 6

-- Path configuration
struct pathPreset (
	name = "newPreset",
	isDefault = false,
	Mesh = "",
	Txt16 = "",
	TxtLock = true,
	Motions = "",
	MSchema = ""
)

struct DATconfig (
	game = 1,
	paths = #(),
	fn getDMTPath =
	(
		sysEn = dotNetClass "System.Environment"
		speFo = dotNetClass "System.Environment+specialFolder"
		myDocuments = sysEn.getfolderPath speFo.MyDocuments		
		DMTpath = myDocuments + "\\DarkMaxTools"
		if not doesFileExist DMTpath then
			makeDir DMTpath
		DMTpath
	),	
	DMTpath = getDMTPath(),
	--DarkINIfile = getdir #maxroot + "DarkAnimTools_Settings.ini",
	DarkINIfile = DMTpath + "\\DarkAnimTools_Settings.ini",
	DATscriptsFolder = (getDir #startupScripts) + "\\DarkMaxTools" ,
	pathTools = "",
	CSVFileName = "\\Data\\JointStructure_Data.csv",	
	
	
	fn loadPresets =
	(
		if not (doesFileExist DarkINIfile) then
		(
			format "\\\\WARN: Couldn't find the configuration file at:\n"
			format "\\\\WARN: %\n" DarkINIfile
		)
		DATconfig.paths = #()
		INIsections = getINIsetting DarkINIfile
		for sec in INIsections do
		(
			if (filterstring sec "_")[1] == "ConfigPreset" then
			(				
				preset = pathPreset()				
				propNames = getPropNames preset
				for propName in propNames do
				(					
					keyValue = getINIsetting DarkINIfile sec propName 
					prop = getProperty preset propName
					propValue = case (classof prop) of
					(
						BooleanClass:keyValue as booleanClass
						default:keyValue
					)
					setProperty preset propName propValue
				)
				append DATconfig.paths preset
			)
		)
		DATconfig.pathTools = getINIsetting DarkINIfile "Configuration" "pathTools" 
	),
	
	fn savePresets =
	(		
		if not (doesFileExist DMTPath) then getDMTPath
		
		INIsections = getINIsetting DarkINIfile
		for sec in INIsections do
		(
			if (filterstring sec "_")[1] == "ConfigPreset" then delINIsetting DarkINIfile sec 
		)
		for i = 1 to DATconfig.paths.count do
		(			
			preset = DATconfig.paths[i]
			sec = "ConfigPreset_" + (i as string)
			propNames = getPropNames preset
			for propName in propNames do
			(
				prop = getProperty preset propName				
				keyValue = case (classof prop) of
				(
					BooleanClass:prop as string
					String:prop
				)
				setINIsetting DarkINIfile sec propName keyValue
			)
		)
		setINIsetting DarkINIfile "Configuration" "pathTools" DATconfig.pathTools

		if not (doesFileExist DarkINIfile) then
		(
			format "\\\\ERROR: The configuration was not created.\n"
			format "\\\\ERROR: %\n" DarkINIfile
		)
		else
		(
			format "\\\\INFO: Succesfully created/updated configuration file.\n"
			format "\\\\INFO: %\n" DarkINIfile
		)
	),
	
	fn configureDefPaths =
	(	
		loadPresets()
		if paths.count == 0 then
		(	--  no presets found			
			preset = pathPreset()
			preset.name = "Thief 2"
			preset.isDefault = true	
			preset.Mesh = ""
			preset.Txt16 = ""
			preset.Motions = ""
			preset.MSchema = ""
			paths[1] = preset
			game = 1
		)
	)

)
global DATconfig = DATconfig()				-- paths to games resource files
DATconfig.configureDefPaths()


-- Joint structure data structs

struct torsoStruct (
	root, 						-- joint number
	parent, 					-- another torso number or 0 for the root torso (butt)
	fixedCount, 			-- number of limbs
	fixedJoints,				-- list of first joints for the limbs 
	fixedJoints_coord, 	-- offset for the fixed joints
	hub, 						-- node - a helper object (used for skinning)
	ctrl,						-- main control object for the torso
	auxctrl,					-- auxiliary control 
	rotRef
	)
	
struct limbStruct (
	-- read from CAL file 
	torso, 					-- number of torso the limb belongs to
	segmentsCount, 		-- how many segments
	segments, 				-- joint numbers
	segments_coord, 	-- offsets from parent
	lengths, 				-- segments lengths
	-- rig related
	SKbones, 				-- skin bones list
	FKctrls, 					-- FK bones/controls list
	IKbones, 				-- IK bones/controls list
	footHelpers = #(),
	locator,
	ikctrl,
	footIK,
	legIK,
	handIK,
	type,
	side,
	swivelTarget,
	
	
	fn getDefaultHelpersPositions =
	(		
		defaultPos = #()
		defaultPos[2] = [(footHelpers[1].pos.x - 0.045), (footHelpers[1].pos.y + 0.016 * side), 0]
		defaultPos[3] = [(footHelpers[1].pos.x + 0.945), (footHelpers[1].pos.y + 0.016 * side), 0]
		defaultPos[4] = [(footHelpers[1].pos.x + 0.525), (footHelpers[1].pos.y + 0.203 * side), 0]
		defaultPos[5] = [(footHelpers[1].pos.x + 0.525), (footHelpers[1].pos.y - 0.193 * side), 0]		
		defaultPos
	),
	
	fn LegNumber =
	(
		case side of (
			(1):1
			(-1):2
		)		
	),	
	
	fn setHelpersPositions =
	(	
		leg = LegNumber()		
		footHelpers[1].pos = ikbones[3].pos
		defPositions = getDefaultHelpersPositions()
		footHelpers[2].pos = (defPositions[2] + [Rig.footHelpers[leg].h2offsetX, Rig.footHelpers[leg].h2offsetY * side, 0])
		footHelpers[3].pos = (defPositions[3] + [Rig.footHelpers[leg].h3offsetX, Rig.footHelpers[leg].h3offsetY * side, 0])
		footHelpers[4].pos = (defPositions[4] + [Rig.footHelpers[leg].h4offsetX, Rig.footHelpers[leg].h4offsetY * side, 0])
		footHelpers[5].pos = (defPositions[5] + [Rig.footHelpers[leg].h5offsetX, Rig.footHelpers[leg].h5offsetY * side, 0])
		try
			footHelpers[4].rotation.controller[2].z_rotation =  (Rig.footHelpers[leg].h4angle)
		catch
			footHelpers[4].rotation.controller.z_rotation =  (Rig.footHelpers[leg].h4angle)
		try
			footHelpers[5].rotation.controller[2].z_rotation =  (Rig.footHelpers[leg].h5angle)
		catch
			footHelpers[5].rotation.controller.z_rotation =  (Rig.footHelpers[leg].h5angle)
	),
	
	fn updateRigOffsetsForHelpers =
	(
		leg = LegNumber()
		defPositions = getDefaultHelpersPositions()
		h2offset = footHelpers[2].pos - defPositions[2]
		h3offset = footHelpers[3].pos - defPositions[3]
		h4offset = footHelpers[4].pos - defPositions[4]
		h5offset = footHelpers[5].pos - defPositions[5]
		Rig.footHelpers[leg].h2offsetX = h2offset.x
		Rig.footHelpers[leg].h2offsetY = h2offset.y * side 
		Rig.footHelpers[leg].h3offsetX = h3offset.x
		Rig.footHelpers[leg].h3offsetY = h3offset.y * side
		Rig.footHelpers[leg].h4offsetX = h4offset.x
		Rig.footHelpers[leg].h4offsetY = h4offset.y * side
		Rig.footHelpers[leg].h5offsetX = h5offset.x
		Rig.footHelpers[leg].h5offsetY = h5offset.y * side
		
		Rig.footHelpers[leg].h4angle = case classof(footHelpers[4].rotation.controller) of (
			rotation_list:(clamp footHelpers[4].rotation.controller[2].z_rotation -45.0 45.0)
			Euler_XYZ:(clamp footHelpers[4].rotation.controller.z_rotation -45.0 45.0)
			default:9.999
		)
		Rig.footHelpers[leg].h5angle = case classof(footHelpers[5].rotation.controller) of (
			rotation_list:(clamp footHelpers[5].rotation.controller[2].z_rotation -45.0 45.0)
			Euler_XYZ:(clamp footHelpers[5].rotation.controller.z_rotation -45.0 45.0)
			default:9.999
		)
	)
	
)
	
-- CAL file plus some auxiliary info
struct CALstruct (
	filename,
	version,
	numCALTorsos, 
	numTorsos, 
	numLimbs, 
	numJoints,
	CALtorsos = #(),	
	mapTorsos = #(),	
	calibration
)




-- BIN AI mesh file structs
-- mesh volume struct
struct VolumeStruct (
	numPolys, 
	startPoly, 
	numVerts, 
	startVert, 
	startblend, 
	mapperID, 
	joint, 
	type, 
	polys, 
	verts, 
	blends
	)

-- joint mappin struct
struct MapperStruct (
	joint, 
	type
	)

	-- Material struct
struct MatStruct (
	textureName, 
	Trans, 
	Illum 
	)

struct BINfileStruct (
	filename,
	version,
	numMappers,
	numMats,
	numVolumes,
	numPolys,
	numVertices,
	numStretchy,
	offset_joint_remap , 	-- volumes map? num_volumes elements
	offset_mappers, 			-- volumes to skeleton joints mapping
	offset_mats, 				-- material offset
	offset_volumes, 			-- per-volume Polygon info. Volumes are parts of mesh belonging to one joint and sharing one material. Volume can be rigid or stretchy.
	offset_poly,				-- polygons
	offset_norm,				-- Normals
	offset_vert,				-- Vertices (munged) - num_vertices ? ? 
	offset_uvmap,				-- UV maps. Z is junk (count - the same as vertex count)
	offset_blends,				-- Floats (num_stretchy). Blending factors. All in the range 0-1. Probably blend factors between two joints. Count - the same as num_stretchy
	offset_U9  					-- zeros...?
)

-- BIN Material chunk size (in bytes)
global MatChunkSize = #()
MatChunkSize[1] = 40		-- BIN version 1
MatChunkSize[2] = 56		-- BIN version 2

--- MC and MI files:
struct TrackMappingStruct (
	TrackType, 
	JointNumber, 
	TrackNumber
	)

struct FlagStruct (
	FrameNumber, 
	FlagType
	)

struct AnimInfoStruct (
	charMan, 
	MIfileName = "newMot.mi", 
	MCfilename = "newMot_.mc", 
	name, 
	creatureType, 
	frameCount = 0, 
	frameRate = 30, 
	unknown,
	tracksNum, 
	flagsNum, 
	trackMapping, 
	Flags = #(), 
	channels = #() 
	)
	
-- Animation Track Type
Translational = 1
Rotational = 0


-- Structure of currently built character
struct CharacterStruct (
	-- rig related
	rawName,
	name,
	type,
	orient,
	Zoffset,
	charMan,
	RootCTRL,
	jointsNumber,
	torsos = #(),
	limbs = #(),
	jointPos = #(),		-- joint positions used in rig (may be different due to adjustments)
	jointPosCAL = #(),	-- original joint positions, used for mesh calculations
	jointParent = #(),
-- 	jointHelpers = #(),
-- 	skinBones = #(),
	-- mesh related
	mesh,
	Volumes = #(),
	Mappers = #(),
	Mats,						-- AI materials
	
	fn createLGSjoints =
	(
		LM=layerManager
		DATlayer.LGS = LM.newLayerFromName (name + "_LGSrig")
		if DATlayer.LGS==undefined then DATlayer.LGS = LM.getLayerFromName "LGS rig"
		DATlayer.LGS.current = true
		for i = 1 to jointPosCAL.count do
		(			
			jname = "J" + AIstructure[type].jointNames[i]
			jnt = box name:jname width:0.1 length:0.1 height:0.1
			jnt.pos = jointPosCAL[i]
			jnt.objectOffsetPos = [0,0, -(jnt.height/2)]			
			jnt.parent = RootCTRL.node
		)
	)
)

------------- Creature skeleton data ------------------

-- 'Dark' CreatureTypes:
DC_appa = 1
DC_arach = 2
DC_biped = 3
DC_bugbeast = 4
DC_burrick = 5
DC_droid = 6
DC_flexbow = 7
DC_playarm = 8
DC_rope = 9
DC_spidey = 10
DC_sweel = 11
DC_simple = 12
DC_crayman = 13

global DC_number = 12

global creaTypeNames = #()						-- longer creature Type names

-- structure elements --
-- this is for - among others - automatic identifying the creature type on file load
struct creatureStructure (
	longName = "",
	shortName = "",
	jointNames = #(),
	jointsNo, 
	torsosNo, 
	limbsNo, 
	limbType = #(),
	trackOrder = #(),
	motionTracks,
	motionTracksMap = #()	
)

global AIstructure= #()

-- let's read the stuff from the CSV text file
CSVfile = openFile (DATconfig.DATscriptsFolder + DATconfig.CSVfileName)
creaTypeNames = getDataRowLabel &CSVfile "creaTypeNames"	true -- nice long names of creature types
CSVrow0 = getDataRowNext &CSVfile true

CSVrow1 = getDataRowLabel &CSVfile "Aistructure" true	-- number of joints per AI
CSVrow2 = getDataRowNext &CSVfile true	-- number of torsos
CSVrow3 = getDataRowNext &CSVfile true	-- number of limbs

for j = 1 to DC_number do
(
	AIstructure[j] = creatureStructure longName:(creaTypeNames[j]) shortName:(CSVrow0[j]) jointsNo:(CSVrow1[j] as integer) torsosNo:(CSVrow2[j] as integer) limbsNo:(CSVrow3[j] as integer)
)

skipToString CSVfile "LimbType"
--skipToNextLine2 CSVfile
readLine CSVfile  -- skips to next line

for i = 1 to 10 do
(
	CSVrow1 = getDataRowNext &CSVfile true	-- types of limbs
	for j = 1 to DC_number do
	(
		if CSVrow1[j] != "" then AIstructure[j].limbType[i] = (CSVrow1[j] as name)
	)
)

skipToString CSVfile "JointMaps"
skipToNextLine2 CSVfile
for j = 1 to DC_number do
	AIstructure[j].jointNames=#()

for i = 1 to 40 do
(
	CSVrow1 = getDataRowNext &CSVfile true	-- joint names	
	for j = 1 to DC_number do
	(
		if CSVrow1[j] != "" then AIstructure[j].jointNames[i] = CSVrow1[j]
	)
)
	
-- we need to swap left side with right side joints, in order to get motions applied to the rig correctly...
/*global jointSwap = #()
skipToString CSVfile "jointSwap"
skipToNextLine2 CSVfile
for j = 1 to DC_number do
	jointSwap[j]=#()


for i = 1 to 40 do
(
	CSVrow1 = getDataRowNext &CSVfile true	-- joint names
	for j = 1 to DC_number do
	(
		if CSVrow1[j] != "" then JointSwap[j][i] = (CSVrow1[j] as integer)
	)
)
*/
-- global trackOrder = #()
skipToString CSVfile "trackOrder"
--skipToNextLine2 CSVfile
readLine CSVfile  -- skips to next line
for j = 1 to DC_number do
	AIstructure[j].trackOrder = #()

for i = 1 to 40 do
(
	CSVrow1 = getDataRowNext &CSVfile true	-- order of joints's tracks to be applied to the rig
	for j = 1 to DC_number do
	(
		if CSVrow1[j] != "" then AIstructure[j].trackOrder[i] = (CSVrow1[j] as integer)
	)
)

-- global motionTracks = #()
CSVrow1 = getDataRowLabel &CSVfile "motionTracks" true		-- number of tracks in motion file
for j = 1 to DC_number do
	AIstructure[j].motionTracks = CSVrow1[j] as integer


-- global motionTracksMap = #()
skipToString CSVfile "motionTracksMap"
readLine CSVfile  -- skips to next line
--skipToNextLine2 CSVfile
for j = 1 to DC_number do
	AIstructure[j].motionTracksMap = #()	

for i = 1 to 40 do
(
	CSVrow1 = getDataRowNext &CSVfile true	-- tracks mapped to joints
	for j = 1 to DC_number do
	(
		AIstructure[j].motionTracksMap[i] = (CSVrow1[j] as integer)
	)
)


close CSVfile
---------------------------------------------------------------
-- end of .CSV file reading
---------------------------------------------------------------


-- .MC creature code matched with the Creature Type
MCmatch = #()
MCmatch[1]=#(DC_appa, 0)			--???
MCmatch[2]=#(DC_arach, 536870911)
MCmatch[3]=#(DC_biped, 524287)
MCmatch[4]=#(DC_biped, 1048575)
MCmatch[5]=#(DC_bugbeast, 4194303)
MCmatch[6]=#(DC_burrick, 0)			---???
MCmatch[7]=#(DC_droid, 262143)
MCmatch[8]=#(DC_flexbow, 14)		---???
MCmatch[9]=#(DC_playarm, 14)
MCmatch[10]=#(DC_rope, 0)
MCmatch[11]=#(DC_spidey, 255) -- spider bot?
MCmatch[12]=#(DC_sweel, 127)
MCmatch[13]=#(DC_crayman, 2097151)



-----------------------
--- RIG PRESETS
-----------------------
-- bones  - this needs to change... 
global StandardFKcontrolWidth = 0.5
global StandardIKboneWidth = 0.12
global StandardSkinboneWidth= 0.2

-- size multiplier for bones (to accomodate for different size creatures)
global boneSizeMult = #()
boneSizeMult[DC_appa] = 1
boneSizeMult[DC_arach] = 0.2
boneSizeMult[DC_biped] = 1
boneSizeMult[DC_bugbeast] = 1
boneSizeMult[DC_burrick] = 0.5
boneSizeMult[DC_droid] = 0.7
boneSizeMult[DC_flexbow] = 1
boneSizeMult[DC_playarm] = 1
boneSizeMult[DC_rope] = 0.8
boneSizeMult[DC_spidey] = 0.2
boneSizeMult[DC_sweel] = 0.3

-- Animation controls colors
struct RigMat (
	name,	
	color,
	mat
)

colorSpine = 1
colorFK = 2
colorIK = 3
colorAux = 4
colorRoot = 5
colorIKbone = 6

rigMats = #()
rigMats[colorSpine] = RigMat name:"Rig_Spine" color:(color 214 189 18)
rigMats[colorFK] = RigMat name:"Rig_FK" color:(color 33 19 115)
rigMats[colorIK] = RigMat name:"Rig_IK" color:(color 159 17 17)
rigMats[colorAux] = RigMat name:"Rig_Hip" color:(color 192 142 64)
rigMats[colorRoot] = RigMat name:"Rig_Root" color:(color 160 14 165)
rigMats[colorIKbone] = RigMat name:"Rig_IKbone" color:(color 108 8 136)

for i = 1 to rigMats.count do
(
	rm = Standard name:rigMats[i].name diffuse:rigMats[i].color selfIllumAmount:100
	rigMats[i].mat = rm
)

-- customizable elements


struct customHelpers (
	h2offsetX = 0,
	h2offsetY = 0,
	h3offsetX = 0,
	h3offsetY = 0,
	h4offsetX = 0,
	h4offsetY = 0,
	h4angle = 0,
	h5offsetX = 0,
	h5offsetY = 0,
	h5angle = 0
)

struct customRig (
	rootSize = 1,
	torsoStartSize = 1,
	torsoEndSize = 0.8,
	footIKwidth = 1,
	footIKlength = 1,
	footIKoffsetX = 0,
	footIKoffsetY = 0,
	footHelpers = #(),
	legFkStartSize =1,
	legFkEndSize =1,
	handIKsize = 1,
	armFKStartSize = 1,
	armFKEndSize = 1,
	ctrlThickness = 0.01,
	
	fn loadStruct rigINIfile &structName prefix =
	(		
		propNames = getPropNames structName
		for i = 1 to propNames.count do 
		(
			propName = propNames[i]
			case (classof (getProperty structName propName)) of 
			(
			(Point2):
				(
					keyName1 = prefix + (propName as string) + ".x"
					keyValue1 = getINIsetting rigINIfile "Settings" keyName1
					keyName2 = prefix + (propName as string) + ".y"
					keyValue2 = getINIsetting rigINIfile "Settings" keyName2
					try 
					(
						propValue = [(keyValue1 as float), (keyValue2 as float)]
						setProperty structName propName propValue
					)									
					catch (format "\\\\WARN: Cannot find property % in the % file.\n" propName rigINIfile)
				)
			(Array):
				(
					nestedArray = getProperty structName propName 
					for j = 1 to nestedArray.count do
					(
						prefix = (propName as string) + "[" + (j as string) + "]."	
-- 						print nestedArray[j]
						loadStruct rigINIfile &nestedArray[j] prefix						
					)
					prefix = ""
				)
			(MAXScriptFunction):()	-- don't load in functions...
			default:
				(
					keyName = prefix + (propName as string)
					keyValue = getINIsetting rigINIfile "Settings" keyName
					try 
					(
						propValue = keyValue as float
						setProperty structName propName propValue
-- 						format "Loaded property %.% - %\n" structName propName propValue
					)									
					catch (format "\\\\WARN: Cannot find property % in the % file.\n" propName rigINIfile)
				)
			)
		)		
	),
	
	fn loadPresets rigName =
	(
		result = #failed
		rigINIfile = DATconfig.paths[DATconfig.game].Mesh + "\\" + rigName + ".rig"
		
		if doesFileExist rigINIfile then
		(
-- 			print Rig
			loadStruct rigINIfile &Rig ""			
			pushPrompt ("Loaded rig settings from file: " + rigINIfile)
			result = #OK
		)
		else 
		(
			format "\\\\INFO: Couldn't find the file %\n" rigINIfile
			format "\\\\INFO: Using default values.\n"
		)
		result
	),
	
	fn saveStruct rigINIfile &structName prefix =
	(
		propNames = getPropNames structName
		sort propNames
		for i = 1 to propNames.count do 
		(
			propName = propNames[i]			
			propClass = classof (getProperty structName propName)
			case propClass of
			(
				(Point2):
				(
					keyValue = getProperty rig propName
					keyName1 = prefix + (propName as string) + ".x"
					keyValue1 = keyValue.x as string 
					setINIsetting rigINIfile "Settings" keyName1 keyValue1
					keyName2 = prefix + (propName as string) + ".y"
					keyValue2 = keyValue.x as string
					setINIsetting rigINIfile "Settings" keyName2 keyValue2
				)
				(Array):
				(
					for j = 1 to (getProperty structName propName).count do
					(
						prefix = (propName as string) + "[" + (j as string) + "]."						
						nestedArray = getProperty structName propName 
						saveStruct rigINIfile &nestedArray[j] prefix
					)
					prefix = ""
				)
				(MAXScriptFunction):()	-- don't save out functions...
				default:
				(
					keyName = prefix + (propName as string )
					keyValue = (getProperty structName propName) as string
					setINIsetting rigINIfile "Settings" keyName keyValue
	-- 				format "% =  %\n" keyname keyvalue
				)	
			)		
		)
	),
	
	fn savePresets rigName  =
	(
		rigINIfile = DATconfig.paths[DATconfig.game].Mesh + "\\" + rigName + ".rig"
		delINIsetting rigINIfile "Settings"
		
		saveStruct rigINIfile &Rig ""
		
		messageBox ("Rig settings saved to " + rigINIfile + " file.")
	),
	
	fn Init = for i = 1 to 2 do	footHelpers[i] = customHelpers(),
	
	on create do Init()
)

global Rig = customRig()