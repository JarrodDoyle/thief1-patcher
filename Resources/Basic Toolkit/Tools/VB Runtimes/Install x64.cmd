#This file copies the *.ocx runtime files to c:\windows\Syswow64 and registers them
cd /d %~dp0
copy .\mscomctl.ocx c:\Windows\SysWOW64
copy .\Comdlg32.ocx c:\Windows\SysWOW64
copy .\Richtx32.ocx c:\Windows\SysWOW64
Echo Install Complete!

cd c:\windows\syswow64
regsvr32 mscomctl.ocx
Echo Mscomctl.ocx registered
regsvr32 Comdlg32.ocx
Echo Comdlg32.ocx registered
regsvr32 Richtx32.ocx
Echo Richtx32.ocx registered
