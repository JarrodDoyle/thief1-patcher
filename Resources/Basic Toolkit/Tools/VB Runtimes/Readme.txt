3ds to bin requires:
Mscomctl.ocx
Comdlg32.ocx

monolog viewer requires:
Richtx32.ocx

ThiefObjectiveWizard requires
Comdlg32.ocx
Richtx32.ocx

You can attempt to install these by right clicking on "install x32.cmd" for 32 bit windows,
or "install x64.cmd" for 64 bit windows, and selecting "Run as administrator".
Or you could do this manually, as described below:

If running 32 bit windows, copy these *.ocx files to C:\Windows\System32\
Start an elevated commant prompt (that is, run the command prompt in administrator mode)
Change the working directory to C:\Windows\system32 by typing:
cd c:\windows\system32

Use regsvr32 to register each of the *.ocx files by entering regsvr32 <filename.ext>
into the command prompt. E.g.:
regsvr32 Mscomctl.ocx
regsvr32 Comdlg32.ocx
regsvr32 Richtx32.ocx

If running 64 bit windows, copy these *.ocx files to C:\Windows\SysWOW64\
Start an elevated commant prompt (that is, run the command prompt in administrator mode)
Change the working directory to C:\Windows\SysWOW64 by typing:
cd c:\windows\syswow64

Use regsvr32 to register each of the *.ocx files by entering regsvr32 <filename.ext>
into the command prompt. E.g.:
regsvr32 Mscomctl.ocx
regsvr32 Comdlg32.ocx
regsvr32 Richtx32.ocx