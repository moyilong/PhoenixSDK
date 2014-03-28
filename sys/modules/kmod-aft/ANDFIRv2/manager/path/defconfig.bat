@echo off
echo ANDFIRE 1.2指令集
sleep 0.5
:menu
call %kernel%\line.bat
echo Android Firmware Configure Tool
echo 安卓固件开发包临时配置工具

call %kernel%\line.bat
echo [10] 启动   [11]禁用  全场签名
echo [20] 启动   [21]禁用  Update.zip签名
echo [3]  设置签名文件
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
set /p sign_mode=[internal(内置KEY)/devices(devices提供的key)]:
set /p sign_key=[签名文件名称:]
goto end