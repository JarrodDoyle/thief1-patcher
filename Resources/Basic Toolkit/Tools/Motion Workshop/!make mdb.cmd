@echo off
//copy "New Motions\*.*" .\Motions
//copy "New Motions\*.*" ..\..\Motions

makmdb.exe

if exist nmotiondb.bin move nmotiondb.bin ..\..\motiondb.bin
pause