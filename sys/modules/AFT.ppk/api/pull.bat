`@echo off
call %apidir%\path_reader.bat %1
if "%fil%"=="not_exist" goto end
:nxt
echo 初始化ADB中
call %api_dir%\k_tadb.bat
echo 等待设备
call %api_dir%\wait_dev.bat
echo 获取文件中
adb pull %fil%
:end