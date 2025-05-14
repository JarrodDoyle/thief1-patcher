ParchEd 1.2 -- DarkUtils 0.7
Copyright (c) 2004-2005 Tom N Harris <telliamed@whoopdedo.cjb.net>

Recent additions are Win9x support and anti-aliased fonts.

You need to have extracted the book art and font files (BOOK.PCX, TEXTR.BIN, 
TEXTFONT.FON). Only 256-color PCX files are recognized, which should be fine 
since nearly all the PCX files used in Thief are that format. Fonts use the 
same colors as the background image. Don't look for the page corners, they're
ignored. You can put default art files in the program directory.

The one inconsistency I've discovered so far is that Thief will strip any 
whitespace from the beginning of strings. So if you want the first line of 
a book to be indented, you have to insert some other character that won't 
be printed.

