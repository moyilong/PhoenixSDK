@echo off
if not exist %initdir%\recovery if not exist %initdir%\recovery.img goto error_rec
set automatic_script=install.tex
if "%1"=="cache" set automatic_script=install_wipe_cache.tex
if "%1"=="data" set automatic_script=install_wipe_data.tex
if "%1"=="dual" set automatic_script=install_wipe_dual.tex
echo Auto Installation ��װ�ű�
echo �Զ���װ: /sdcard/update.zip
echo [HOST]��ʼ��ADB 
call %apidir%\k_tadb.bat
call %apidir%\wait_dev.bat
echo [TARGET]��װRECOVERY�ű�
if exist %devdir%\%automatic_script% adb push %devdir%\%automatic_script% /cache/recovery/command
if not exist %devdir%\%automatic_script% adb push %appdir%\AFT.ppk\autoinstall\%automatic_script% /cache/recovery/command
echo [HOST]����update.zip
if not "%1"=="nm" call %appdir%\AFT.ppk\kernel_path_ex\make.bat zImage
echo [TARGET]����RECOVERY
if exist %initdir%\recovery if not exist %initdir%\recovery.img call %appdir%\AFT.ppk\kernel_path_ex\make.bat recimg
echo [TARGET]����update.zip
call %apidir%\send.bat update.zip
echo ��ʼ�Զ�ˢ�½ű�
adb reboot bootloader
if "%ro_format_system%"=="true" fastboot %ro_ai_erasemode% system
fastboot boot recovery.img
sleep 3
echo %bs%
echo �Զ���װ���!
goto end

:error_rec
echo ��ʧRecovery:(
goto end

:end