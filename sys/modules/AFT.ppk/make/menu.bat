cls
@echo off
cls
call %kernel%\line.bat
echo   Android Firmware Tool GUI Interface
sleep 1
:menu
cls
call %kernel%\line.bat
call %kernel%\logo.bat
call %kernel%\line.bat
echo 1������update.zipˢ����
echo 2����update.zipˢ�������
echo 3���趨�豸�ļ�
echo 4���༭�豸�ļ�
echo 5�����ɹ̼�����(�Ƽ�ʹ��RAMDISK��Ϊ����)
echo 6�����
echo 7�������ʱ�ļ�
echo 8������豸�ļ�
echo 9�����¶�ȡVendor
echo 10�������ⲿVendor�����ļ�
echo 11��Deodex����
call %kernel%\line.bat
set input=
set /p input=[1/2/3/4/5/6/7/8/9/10/E]:
if "%input%"=="e" goto end
if "%input%"=="E" goto end
if "%input%"=="1" call %kernel%\make.bat zImage
if "%input%"=="2" call %kernel%\make.bat unpack
if "%input%"=="3" call %kernel%\make.bat vendor_setup
if "%input%"=="4" call %apidir%\edit_devices.bat
if "%input%"=="5" call %kernel%\make.bat zImage ready
if "%input%"=="6" call %kernel%\make.bat clean
if "%input%"=="7" call %kernel%\make.bat clean_temp
if "%input%"=="8" call %kernel%\make.bat clean_devices
if "%input%"=="9" call %kernel%\make.bat read_vendor
if "%input%"=="10" call %kernel%\make.bat import_vendor
if "%input%"=="11" call %appdir%\AFT.ppk\api\deodex.bat %initdir%\update\system\app 15
sleep 3
goto menu

:end