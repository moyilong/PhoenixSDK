@echo off
adb rcall %api_dir%\wait_dev.bat
call %kernel%\make.bat bootimg | adb reboot bootloader