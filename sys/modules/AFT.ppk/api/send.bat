@echo off
call %apidir%\path_reader.bat %1
if "%fil%"=="not_exist" goto end
echo 初始化ADB中
call %api_dir%\k_tadb.bat
echo 等待设备
call %api_dir%\wait_dev.bat
echo 发送文件 %1
adb push %1 %fil%
:end