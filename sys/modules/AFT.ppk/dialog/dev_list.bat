@echo off
goto end
call %kernel%\service\regsrv.bat AFT.dialaog.devlist
call %kernel%\service\set_workmod.bat AFT.dialog.devlist WORK
mode 36,9
:loop
cls
title  %time%
echo %date% %time%
adb devices
fastboot devices

set /p stat=<%proc%\proc.stat
if "%stat%"=="STATUS_STOP" goto end
sleep 1
goto loop

call %kernel%\service\set_workmod.bat AFT.dialog.devlist DISABLE
:end
exit