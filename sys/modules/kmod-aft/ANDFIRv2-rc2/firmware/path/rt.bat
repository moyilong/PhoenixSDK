@echo off
call %kernel%\make.bat recimg | adb reboot bootloader
fastboot boot %initdir%\recovery.img
