@echo off
set automatic_script=install.tex
if "%1"=="cache" set automatic_script=install_wipe_cache.tex
if "%1"=="data" set automatic_script=install_wipe_data.tex
if "%1"=="dual" set automatic_script=install_wipe_dual.tex
echo Automatic Installation
echo Auto Install Script
echo Auto Install /sdcard/update.zip
call %apidir%\k_tadb.bat
call %apidir%\wait_dev.bat
if exist %devdir%\%automatic_script% adb push %devdir%\%automatic_script% /cache/recovery/command
if not exist %devdir%\%automatic_script% adb push %appdir%\AFT.ppk\autoinstall\%automatic_script% /cache/recovery/command
echo Making Firmware
if not "%1"=="nm" call %appdir%\AFT.ppk\kernel_path_ex\make.bat zImage
if not "%1"=="nm" call %appdir%\AFT.ppk\kernel_path_ex\make.bat recimg
echo 复制文件中
call %apidir%\send.bat update.zip
echo 开始自动刷新脚本
adb reboot bootloader
if "%ro_erase_system%"=="true" fastboot erase system
if "%ro_format_system%"=="true" fastboot format system
fastboot boot recovery.img
sleep 3
echo %bs%
echo 自动安装完成!