@echo off
:init
cls
call %kernel%\line.bat
echo AFT核心模式切换
call %kernel%\line.bat
echo 1、默认的update.zip/Recovery
echo 2、适用于Allwinner的模式(只能打包成update.zip格式)
echo 3、适用于Allwinner的模式(只能打包成Livesuit格式)
echo 4、适用于RK28xx的模式
echo 5、适用于RK29xx的模式(Cramfs)
echo 6、适用于RK29xx的模式(Ext4FS)
call %kernel%\line.bat
set /p mode=[1/2/3//5/6/E]
if not "%mode%"=="1" if not "%mode%"=="2" if not "%mode%"=="3" if not "%mode%"=="4" if not "%mode%"=="5" if not "%mode%"=="6" goto init
if "%mode%"=="E" goto end
if "%mode%"=="e" goto end