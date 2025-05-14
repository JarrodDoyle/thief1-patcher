/* ------------------------------------------------------
/* 			Dark Animation Tools
/* 			Common Functions
/* ------------------------------------------------------
/* author: Juliusz Kaczmarek
/* ver. 0.01
/* Nov. 2013
/*
/* tools for importing and exporting
/* rigged characters and their motions
/* from and to dark engine games. 
/*
/* this scripted toolset was possible thanks to the knowledge and experience 
/* of Volca, Shadowspawn, Weyoun, Telliamed
/* ------------------------------------------------------
*/



fn bigger x1 x2 =
(
	if x1>x2 then x1 else x2
)

fn smaller x1 x2 =
(
	if x1<x2 then x1 else x2
)

fn average a b =
(
	result = case (classof x1) of (
		#Point3:[(a.x + b.x) / 2, (a.y + b.y) / 2, (a.z + b.z) /2]
		#Point2:[(a.x + b.x) / 2, (a.y + b.y) / 2]
		default:((a + b) / 2)
	)
	result
)

fn averageArray arr =
(
	local sum = case (classof arr[1]) of (
		#Point3:[0,0,0]
		#Point2:[0,0]
		default:0
	)
	for i = 1 to arr.count do sum += arr[i]
	sum = sum / arr.count
	return sum	
)

fn clamp what mini maxi = 
(
	if what < mini then what = mini
	if what > maxi then what = maxi
	what
)

-- Reads string from a binary file ---
fn ReadBString File size = 				 
(
	Fstring = ""		
	zero = false
	for j=1 to size do
	(
		charCode = (ReadByte File)
		charCode = case of
		(
		(charCode<32):0
		(charcode>127):0
		default:charCode
		)
		if ((charCode!=0) and (zero==false)) then Fstring = Fstring + (bit.intAsChar charCode)
		else zero = true
	)
	Fstring
)
	
fn WriteBString File Fstring size = 
(
	for j = 1 to size do
	(
		if j > Fstring.count then
		(
			WriteByte File 0 #unsigned
		)
		else
			WriteByte File (bit.CharAsInt Fstring[j]) #unsigned
	)
)
	
-- INI file related
fn getString &what key =
(	
	keyValue = getINIsetting INIfilePath sectionName key
	if keyValue != "" then what = keyValue
-- 	format "Reading from INI, %: %\n" key keyValue
)

fn getInteger &what key =
(	
	keyValue = getINIsetting INIfilePath sectionName key
	if keyValue != "" then what = (keyValue as integer)
-- 	format "Reading from INI, %: %\n" key keyValue
)

fn invertArray arr =
(
	local inverted = #()
	inverted = for i = arr.count to 1 by -1 collect arr[i]
)

--- CSV file parsing
-- similar in result to filterString, but retains empty CSV file fields as 'undefined' values in array
-- so no field is skipped.
fn filterStringCSV str chrs =
(
	arr = #()
	val = ""
	while str.count>0 do
	(
		chr = str[1]
		case chr of (
			",":
			(
				append arr val
				val = ""
			)
			"'":()	-- skip single quote
			default:append val chr
		)
		if str.count>1 then str = substring str 2 str.count
			else str = ""
	)
	append arr val
	arr
)

fn skipToNextLine2 &file =
(
	skipToNextLine file
	rememberPos = filePos file
	ln = readLine file
	if ln=="" then
		seek file (rememberPos+1)	
	else
		seek file rememberPos	
)

-- returns a row of data as an array
fn getDataRowLabel &file label skipFirst =
(
	local ln, fln
	seek file 0
	skipToString file label
	--skipToNextLine2 file
	readLine file  -- skips to next line
	ln = readLine file
	fln = filterStringCSV ln ",'\""	-- comma and single quote here!
	if skipFirst == true then deleteItem fln 1
	fln
)

fn getDataRowNext &file skipFirst =
(
	local ln, fln
	ln = readLine file
	fln = filterStringCSV ln ",'"	-- comma and single quote here!
	if skipFirst == true then deleteItem fln 1
	fln
)

fn interpolate A B num steps =
(
	result = A
	if steps > 1 then
	(
		range = B - A
		percent = 0.01 * (num - 1) * (100.0 / (steps - 1) )
		result = A + percent * range
	)
	else
	result = A
	
)

fn bool2int bool =
(
	if bool == True then return 1
		else return 0
)