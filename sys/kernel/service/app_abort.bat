@echo off
color 4f
echo Application Abort
echo Unknow Error :(
echo =====================================
echo App:%1
echo Why:%2
echo =====================================
echo Exit..
pause>nul

if not "%bios_debug%"=="true" exit
if not "%bios_debug%"=="true" cmd