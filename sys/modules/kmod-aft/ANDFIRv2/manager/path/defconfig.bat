@echo off
echo ANDFIRE 1.2ָ�
sleep 0.5
:menu
call %kernel%\line.bat
echo Android Firmware Configure Tool
echo ��׿�̼���������ʱ���ù���

call %kernel%\line.bat
echo [10] ����   [11]����  ȫ��ǩ��
echo [20] ����   [21]����  Update.zipǩ��
echo [3]  ����ǩ���ļ�
call %kernel%\line.bat
set /p sss=[10/11/20/21/3/E]:
if "%sss%"=="e" goto end
if "%sss%"=="E" goto end
if "%sss%"=="10" set sign_file_globalapk=true
if "%sss%"=="11" set sign_file_globalapk=false
if "%sss%"=="20" set sign_file_update=true
if "%sss%"=="21" set sign_file_update=false
if "%sss%"=="3" goto platform
goto menu

:platform
set /p sign_mode=[internal(����KEY)/devices(devices�ṩ��key)]:
set /p sign_key=[ǩ���ļ�����:]
goto end