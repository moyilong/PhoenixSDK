@echo off
cd /d %initdir%
if exist devices goto exist
:resume 
cls
echo =============================
cd /d %dev_lib%
dir /b
echo =============================
set /p name=
if not exist %name% goto resume
echo D | xcopy /e %name% %devdir%
goto end




:exist
echo 已经存在devices继续将会清空这些文件!
set /p yn=[y/N]:
if "%yn%"=="y"  goto continue
if "%yn%"=="Y"  goto continue
if "%yn%"=="n" goto continue
if "%yn%"=="N" goto continue
goto exist
:continue
if "%yn%"=="n" goto end
if "%yn%"=="N" goto end
echo 正在清除文件...
rmdir /q /s %devdir%
cd /d %initdir%
goto resume

:end
cd %initdir%