@echo off
set net= 
echo 正在检查服务器
cd /d %proc% 
if exist sys_upd rmdir /q /s sys_upd
mkdir sys_upd
cd sys_upd
ftp  %net% pull "head.h"
if not exist head.h
goto server_error
call %kernel%\include.bat head.h
cls
echo 系统更新包
echo ==========================
echo 当前:%build%
echo 目标:%u_build%
echo 当前内核:%k_version%
echo 目标内核:%u_version%
echo ==========================
set /p yn=更新[y/N]:
if not "%yn%"=="y" goto end
if not "%yn%"=="Y" goto end
echo 正在更新，请稍后.....
ftp %net% pull update.cab
ftp %net% pull update.cab.hash
zip32 h update.cab>1.hash
fc not "%error_level%"=="0" goto end
ren update.cab update.zip
zip x update.zip
if not exist kernel\.noupdate if not exist kernel\update.zip goto end
if not exist sdk\.noupdate if not exist sdk\update.zip goto end
if exist META-INFO\update-script.bat call META-INFO\update-script.bat && goto end
echo 使用内置更新脚本，更新系统
echo 正在更新内核
if exist %sdkdir%\kernel_backup rmdir /q /s %sdkdir%\kernel_Backup
ren %kernel% kernel_backup
mkdir %kernel%
copy kernel\update.zip %kernel%
cd /d %kernel%
zip x update.zip
del update.zip
cd /d %proc%\sys_upd



:server_error
echo 更新服务器错误!
goto end

:end
cd /d %initdir%
rmdir /q /s %proc%\sys_upd
