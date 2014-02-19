@echo off
:loop
title  %time%
adb devices
fastboot device
if exist %proc%\
goto loop