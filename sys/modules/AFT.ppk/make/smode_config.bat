@echo off
:init
cls
call %kernel%\line.bat
echo AFT����ģʽ�л�
call %kernel%\line.bat
echo 1��Ĭ�ϵ�update.zip/Recovery
echo 2��������Allwinner��ģʽ(ֻ�ܴ����update.zip��ʽ)
echo 3��������Allwinner��ģʽ(ֻ�ܴ����Livesuit��ʽ)
echo 4��������RK28xx��ģʽ
echo 5��������RK29xx��ģʽ(Cramfs)
echo 6��������RK29xx��ģʽ(Ext4FS)
call %kernel%\line.bat
set /p mode=[1/2/3//5/6/E]
if not "%mode%"=="1" if not "%mode%"=="2" if not "%mode%"=="3" if not "%mode%"=="4" if not "%mode%"=="5" if not "%mode%"=="6" goto init
if "%mode%"=="E" goto end
if "%mode%"=="e" goto end