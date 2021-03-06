@echo off
if not exist %initdir%\recovery if not exist %initdir%\recovery.img goto error_rec
set automatic_script=install.tex
if "%1"=="cache" set automatic_script=install_wipe_cache.tex
if "%1"=="data" set automatic_script=install_wipe_data.tex
if "%1"=="dual" set automatic_script=install_wipe_dual.tex
echo Auto Installation 安装脚本
echo 自动安装: /sdcard/update.zip
echo [HOST]初始化ADB 
call %apidir%\k_tadb.bat
call %apidir%\wait_dev.bat
echo [TARGET]安装RECOVERY脚本
if exist %devdir%\%automatic_script% adb push %devdir%\%automatic_script% /cache/recovery/command
if not exist %devdir%\%automatic_script% adb push %appdir%\AFT.ppk\autoinstall\%automatic_script% /cache/recovery/command
echo [HOST]生成update.zip
if not "%1"=="nm" call %appdir%\AFT.ppk\kernel_path_ex\make.bat zImage
echo [TARGET]生成RECOVERY
if exist %initdir%\recovery if not exist %initdir%\recovery.img call %appdir%\AFT.ppk\kernel_path_ex\make.bat recimg
echo [TARGET]下载update.zip
call %apidir%\send.bat update.zip
echo 开始自动刷新脚本
adb reboot bootloader
if "%ro_format_system%"=="true" fastboot %ro_ai_erasemode% system
fastboot boot recovery.img
sleep 3
echo %bs%
echo 自动安装完成!
goto end

:error_rec
echo 丢失Recovery:(
goto end

:end