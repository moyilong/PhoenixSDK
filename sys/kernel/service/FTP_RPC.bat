@echo off
echo USEAGE:
echo libc <FTP_ROOT_DIR> ACCESS_MODE
echo Access Mode:
echo   __ROOT_ONLY__		Only Root
echo   __GUEST_MODE_		Alway Access for Guest Only Execute Script for Root
echo   __NO_ACCESS__		Any Account Can Do Any Thing
echo =============================================================
if "%1"=="" goto _avg_error
if "%2"=="" goto _avg_error
set FTPDIR=%1
set ftpdir=%FTPDIR%
echo Creating FTP Dir
mkdir %ftpdir%
mkdir %ftpdir%\User
mkdir %ftpdir%\Log
mkdir %ftpdir%\Info

if not exist %ftpdir% goto dir_error
cd /d %userdir%
if not exist UserAccount (
mkdir UserAccount 
mkdir UserAccount\ROOT
cd UserAccount
cd ROOT
mkdir Permission
cd Permission
echo Enable Script Exec >script.per
echo Enable Encrypt Data Get >dataget.per
)
cd /d %userdir%
dir /b >%proc%\user_list
cd /d %ftpdir%
for /f %%f in (%proc%\user_list) do mkdir %%f





:loop








if not exist %proc%\stop.stat goto loop




:dir_error
echo %ftpdir%
echo 目录错误
goto end

:_avg_error
echo 参数错误 :(
goto end


:end