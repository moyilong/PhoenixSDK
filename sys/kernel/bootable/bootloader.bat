@echo off
set bios_loader=EPSDK-BUILT-LDR
set bios_version=R2
if "%start%"=="1" goto end1
set start=1

:menu1
echo %bios_loader%
echo 1、启动标准模式的SDK[默认]
echo 2、启动带菜单的SDK
echo 3、启动安全模式
echo 4、启动不带扩展指令的安全模式
echo 5、启动不带参数的模式
echo 6、签名
echo 7、清空Proc
echo ==================================
::echo [1/2/3/4/5/6/E]
::set /p io=

choice /C 1234567 /D 1 /T 3
if "%errorlevel%"=="2" goto menu
if "%errorlevel%"=="3" goto secure
if "%errorlevel%"=="4" goto nkp
if "%errorlevel%"=="6" goto sign
if "%errorlevel%"=="5" goto none
if "%errorlevel%"=="1" goto normally
if "%errorlevel%"=="7" goto clean_proc
echo Unknow:%errorlevel%
timeout /t 3
goto menu1


:sign


call %1\kernel\bootable\sign.bat %1

goto end


:normally
set cmdline=sm cl tl
if "%2"=="ppc" set cmdline=%cmdline% spp && set pre_proc_dir=%3

goto end

:none
set cmdline=

goto end

:menu
call %1\kernel\bootable\init.bat %1 sm cl tl nl
call %kernel%\make.bat menu
goto end1

:secure
call %1\kernel\bootable\init.bat %1 se
cmd.exe
goro end

:gae
call %1\kernel\bootable\init.bat %1 sm cl tl nl
start_server
goto end1
:nkp
set cmdline=se nkp

goto end

:end

call %1\kernel\bootable\init.bat %1 %cmdline%
%def_console%
goto end1

:clean_proc
echo Cleaning Proc......
cd /d %temp%
for /d %%f in (PROC_*;tmpfs*) do rmdir /q /s %%f &&echo Clean:%%f
ping 127.0.0.1 -n 2>nul
goto endl


:end1