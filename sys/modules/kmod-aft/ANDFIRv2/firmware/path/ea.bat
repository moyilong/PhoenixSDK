@echo off
echo Warring!!!!!!!
call %kernel%\select.bat "警告:此操作不可挽回!!"
if "%return%"=="false" goto end
call %apidir%\wait_dev.bat
adb reboot bootloader
echo Formatting Data....
fastboot format userdata
echo Formatting Boot.....
fastboot erase boot
echo Formatting Recovery.....
fastboot erase recovery
echo Formatting Cache.....
fastboot format cache
echo Formatting System.....
fastboot format system
echo 操作完成!
echo 保留fastboot操作模式!
goto end



:end