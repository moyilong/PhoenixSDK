@echo off
echo Warring!!!!!!!
call %kernel%\select.bat "����:�˲����������!!"
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
echo �������!
echo ����fastboot����ģʽ!
goto end



:end