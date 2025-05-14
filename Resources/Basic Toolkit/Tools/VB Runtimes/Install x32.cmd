#This file copies the *.ocx runtime files to c:\windows\Syswow64 and registers them
cd /d %~dp0
copy .\mscomctl.ocx c:\Windows\System32
copy .\Comdlg32.ocx c:\Windows\System32
copy .\Richtx32.ocx c:\Windows\System32
Echo Install Complete!

cd c:\windows\System32
regsvr32 mscomctl.ocx
Echo Mscomctl.ocx registered
regsvr32 Comdlg32.ocx
Echo Comdlg32.ocx registered
regsvr32 Richtx32.ocx
Echo Richtx32.ocx registered
