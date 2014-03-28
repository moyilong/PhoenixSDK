@echo off
call %api_dir%\wait_dev.bat
call %kernel%\make.bat bootimg | adb reboot bootloader
fastboot boot %initdir%\boot.img
