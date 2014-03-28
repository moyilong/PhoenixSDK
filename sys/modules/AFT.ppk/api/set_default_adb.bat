@echo off
call %kernel%\line.bat
echo ADB默认设备设定:
adb devices
set /p ANDROID_SERIAL=