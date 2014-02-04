@echo off
call %api_dir%\wait_dev.bat
adb pull /proc/config.gz