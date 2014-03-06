@echo off
exit
mode 36,9
:loop
cls
title  %time%
echo %date% %time%
adb devices
fastboot devices
sleep 1
if exist %1\stop.stat exit
goto loop