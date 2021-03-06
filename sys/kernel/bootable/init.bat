@echo off
set cmdline=%2;%3;%4;%5;%6;%7;%8
title ELONE DragonHert Kernel Family -- PhenomSDK Mixed Kernel
if "%bios_debug%"=="true" title ELONE DragonHert Kernel Family -- PhenomSDK Mixed Kernel Boot Loader BIOS-DEBUG!! && pint 127.0.0.1 -n 4>nul
echo Reset ErrorCode %error_code% to 0x00000000
set error_code=0x00000000



set pre_proc=false
for %%f in (%cmdline%) do if "%%f"=="spp" set pre_proc=true
echo.
echo.
echo.
echo.
echo            ___         ___                ___
echo          /      /     /   /   /\    /   /     
echo         /----  /     /   /   /  \  /   /----  
echo        /____  /___  /___/   /    \/   /____   
echo.                    
doskey #=call %kernel%\
set error_code=0x00000001
doskey wait=ping 127.0.0.1 -n 2 >nul
doskey cat=type
set error_code=0x00000002
if "%bios_loader%"=="" goto _error
echo Kernel Init By %bios_loader%
if "%bios_version%"=="" goto _error
echo                 Loading Enviroment Information
set error_code=0x0000000A
set initdir=%cd%
set sdkdir=%initdir%\%1
set kernel=%sdkdir%\kernel
set env_path=%windir%\system32;%windir%;%SYSTEMROOT%\System32\WindowsPowerShell\v1.0;%kernel%\FMA;%kernel%\utils
set path=%env_path%
set userdir=%initdir%\User
set user_dir=%userdir%
set cores=%NUMBER_OF_PROCESSORS%
set guid=%random%%random%%random%
set proc_common=%temp%\tmpfs_common
if "%pre_proc%"=="true" set proc=%pre_proc_dir%
if not "%pre_proc%"=="true" set proc=%temp%\tmpfs_%guid%
set temp=%proc%\temp

set api_dir=%proc%\common_modules_api
mkdir %proc%
mkdir %api_dir%
mkdir %proc%\temp
mkdir %proc%\ver_info
mkdir %proc%\shutdown_code
mkdir %proc%\service
mkdir %proc%\service\init
mkdir %proc%\service\work
mkdir %proc%\service\disable
set drvlist=%proc%\driver_list
if not exist %proc_common% mkdir %proc_common%
set log=%proc_common%\LogFiles_%guid%
mkdir %log%
echo STATUS_START>%proc%\proc.stat
set app_log=%log%\app.log
set sys_log=%log%\Kernel.log
set apidir=%api_dir%
set appdir=%sdkdir%\modules
set lib=%kernel%\lib
echo.
echo.
set error_code=0xE00003DA
doskey exit=call %kernel%\service\exit.bat
set error_code=0x000000BA
set klogo=%kernel%\kapi\display_logo.txt
if "%force_run_for_other%"=="true" goto otr_set
:otr_resume
echo   Checking Enviroment
echo     initdir=%initdir%
echo     sdkdir=%sdkdir%
echo     kernel=%kernel%
echo     userdir=%userdir%
echo Checking Kernel Configure Files
set reload_file=%sdkdir%\include\info.h;%kernel%\include\head.h

for %%f in (config.h;Default.conf;head.h;name_tbl) do if not exist %kernel%\include\%%f goto head_error
for /f %%f in (%kernel%\include\head.h;%kernel%\include\config.h) do set %%f&& echo Loading Configure: %%f
for %%f in (%sdkdir%\include\config.h;%sdkdir%\include\info.h;%sdkdir%\kernel_hash.dll) do if not exist %%f goto head_error
for /f %%f in (%sdkdir%\include\config.h;%sdkdir%\include\info.h) do set %%f&& echo Loading Configure: %%f


echo Load Kernel Name:%k_verison_n%

FileFileter "%kernel%\include\name_tbl" "%k_verison_n%">%temp%\kname
set /p k_version=<%temp%\kname


if not exist %userdir% mkdir %userdir%





if not exist %userdir%\UserProfile.conf goto set_default_user_conf
echo	 Reloading Kernel Head 
call %kernel%\include.bat %kernel%\include\head.h
call %kernel%\include.bat %kernel%\include\reload_head.h nf
set support-pkgver=%ppk_label%;%ext_label%
mkdir %proc%\kernel
echo %k_version%>%proc%\kernel\version
echo %pkg_version%>%proc%\kernel\pkg
mkdir %proc%\sdk
echo %version%>%proc%\sdk\version
echo %name%>%proc%\sdk\name
echo 	Progress Configure Dependson
if "%debug%"=="true" (
set skip_appcheck=true
set skip_kernelcheck=true
)
echo                     Kernel Self Checking
cd /d %kernel%
cd ..
%kernel%\signtool\bin32\sum.exe -r kernel > %temp%\k_hash.dll
cd /d %initdir%
fc %sdkdir%\kernel_hash.dll %temp%\k_hash.dll>NUL
if not "%errorlevel%"=="0" if not "%skip_kernelcheck%"=="true" goto hash_error
del %temp%\k_hash.dll
echo	Reading Sign Information
for /f "delims=#" %%f in (%sdkdir%\include\sign.h) do set %%f
set k_string=unknow

if "%k_mode%"=="Pre-Alpha" set k_string=开发预览版
if "%k_mode%"=="Alpha" set k_string=内部测试版
if "%k_mode%"=="Beta" set k_string=测试版
if "%k_mode%"=="Release" set k_string=正式版
if "%k_mode%"=="RC" set k_string=发布预览版






set HOST_ARCH=x86

if exist %windir%\SysWOW64  set HOST_ARCH=amd64
if "%HOST_ARCH%"=="x86" (
echo  警告:对X86不再保证支持!
pause>nul
)
set title=%name% with %k_version%
:resume_user_conf
echo                     Reading User Profile
for /f "delims=#" %%f in (%userdir%\UserProfile.conf) do (
echo Loading User Configure: %%f
if "%1" =="user_conf_disable=true" goto skip_loadhead
set %%f
)
echo                     Decoding User PRofile
set PATHEXT=%PATHEXT%;%user_force_PATHEXT%
if "%user_force_cpu_core%"=="true" set cores=%user_force_cpu_conf%
set /a half_cores=%cores% / 2
if "%cores%"=="1" set half_cores=1 && set error_code=0xf0009D3B
set PATH=%path%;%user_force_PATH%
:skip_loadhead
echo                     Init Kernel %k_version% by %HOST_ARCH%
if "%sucure_mode%"=="true" goto resume
if not exist %kernel%\include\service.h goto resume
for /f %%f in (%kernel%\include\service.h) do call %%f
:resume
for /l %%f in (-%line_wide%,1,%line_wide%) do call %kernel%\lineadd.bat
if not "%host_arch%"=="amd64" call %kernel%\add_path.bat %kernel%\signtool\bin32
if "%host_arch%"=="amd64" call %kernel%\add_path.bat %kernel%\signtool\bin64
set error_code=0x09905aab
if not exist %log% mkdir %log%
mkdir %proc%\kernel_path
if "%ro_kernel_compressed%"=="false" if exist %kernel%\kernel_path goto not_compress
if  "%ro_kernel_compressed%"=="true" goto compress
:not_compress
if not exist %kernel%\kernel_path goto kpe
echo d | xcopy /e %kernel%\kernel_path %proc%\kernel_path
goto final
:compress
cd /d %proc%\kernel_path
if not exist %kernel%\kernel_compress.zip goto kpe
%kernel%\kernel_bin_32\zip.exe x %kernel%\kernel_compress.zip
cd /d %initdir%
goto final
:final
set path=%proc%\kernel_path;%path%



echo USE EFI Bootloader
echo Preinit EFI Bootcode
set error_code=0xB02F9D3A
call %sdkdir%\kernel\bootable\efi.bat



if "%debug%"=="true" set title=Debug[%title%]
echo                     Resume Settings
for %%f in (%cmdline%) do (
if "%%f"=="sm" set sm=true
if "%%f"=="cl" color %S_clr%
if "%%f"=="se" set secure_mode=enable && set error_code=0xffffffff
if "%%f"=="nkp" set not_path_mode=true
if "%%f"=="fr" set force_ARCH=true
if "%%f"=="tl" title %title%
if "%%f"=="ni" set not_init=true && set ni=true
)

if "%force_ARCH%"=="true" set HOST_ARCH=%force_HOST_ARCH%
if  "%HOST_ARCH%"=="amd64" set PATH=%kernel%\kernel_bin_64;%PATH%
if  "%HOST_ARCH%"=="x86" set PATH=%kernel%\kernel_bin_32;%PATH%
echo INITING Modules>>%sys_log%
set error_code=0xf000000A
echo 			Scanning Kernel Modules
if "%secure_mode%"=="enable" goto skip_appload2
if not exist %appdir% if exist %sdkdir%\modules_comress.zip (
mkdir %proc%\modules
copy %sdkdir%\modules_compress.zip %proc%\modules\modules_compress.zip
cd /d %proc%\modules
zip x modules_compress.zip
set appdir=%proc%\modules
)

:skip_appload
echo 			Loading Kernel Modules
if "%secure_mode%"=="enable" goto skip_appload2
cd /d %appdir%
for /d %%n in (*.EPX;*.K-LIB;*.lib;*.app;kmod-*;*.ppk) do call %kernel%\add_feature.bat %%n
for %%h in (%feature_x%) do call %kernel%\init_app.bat %%h && echo Load:%%h >>%sys_log% 

:skip_appload2

cd /d %initdir%
if exist %sdkdir%\bin set PATH=%sdkdir%\bin;%PATH%
if "%HOST_ARCH%"=="x86" if exist %sdkdir%\bin32 set PATH=%sdkdir%\bin32;%PATH%
if "%HOST_ARCH%"=="amd64" if exist %sdkdir%\bin64 set PATH=%sdkdir%\bin64;%PATH%
echo InitSystem Shell >>%sys_log%
set error_code=0xf00000FF
cd /d %initdir%
if not exist %userdir%\init.rc echo ::添加默认命令到这边来!>%userdir%\init.rc
copy %userdir%\init.rc %temp%\temp.bat
call %temp%\temp.bat
del %temp%\temp.bat
if "%not_path_mode%"=="true" set path= & set command=
echo %error_code% 
echo System will Into User Interface
sleep 2
for %%f in (%feature%) do if exist %appdir%\%1\data\path_code.bat call %appdir%\%1\data\path_code.bat
if not "%debug%"=="true" cls
set error_code=0xf0000000
echo ==============Begin of Enviroment Info================>>%sys_log%
set >>%sys_log%
echo ===============End of Enviroment Info=================>>%sys_log%
if "%sm%"=="true" if not "%debug%"=="true" mode %windo_height%,%line_wide%



call %kernel%\bootable\sys.bat
echo STATUS_NORMALLY>%proc%\proc.stat
goto end
:kpe
set error_code=0xC000000AA
echo Warring!!!
set error=true
echo      不能加载内核默认命令行
echo      这一般都是由于内核不支持此种启动方式引起的
echo      请更换启动方式，并且检查内核完整性!
goto end
:head_error
set error=true
set error_code=0xf00000ff
echo 内核头文件丢失
goto end
:set_default_user_conf
set error_code=0xf0007FAE
echo user_conf_version=1.0>%userdir%\UserProfile.conf
if not exist %sdkdir%\include\default.conf echo user_conf_disable=false>>%userdir%\UserProfile.conf && goto resume_user_conf
echo user_conf_disable=true>>%userdir%\UserProfile.conf
echo   Importing SDK Default Configure
for /f %%f in (%sdkdir%\include\default.conf) do echo %%f>>%userdir%\UserProfile.conf
echo #模块设定>>%userdir%\UserProfile.conf
set modules_defconfig_load=true
goto resume_user_conf
:_error
set error=true
set error_code=0xf000ffff
echo 内核初始化失败!
echo 访问启动器接口失败
pause>nul
goto end
:hash_error
set error=true
set error_code=0xfffff000
echo 内核自检失败
goto end
:sign_error
set error=true
set error_code=0xfDDD69EF
echo  操作签名文件失败
goto end
:otr_set
set error_code=0xffDf005A
echo      Run for Other Floders
set initdir=%system_enviroment_default_workdir%
set sdkdir=%system_runtime%\sdk
set kernel=%system_runtime%\kernel
set otr=true
goto otr_resume
:end
echo End Init Program >>%sys_log%
echo End with ErrorCode:%error_code%>>%sys_log%
if "%error%"=="true" start notepad %sys_log%
