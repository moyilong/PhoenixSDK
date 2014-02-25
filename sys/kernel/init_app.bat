echo Kernel Scanning 

if not exist %user%\black-list.conf goto load
for /f %%f in (%user%\black-list.conf) do if "%1"=="%%f" set load=false
if "%load%"=="false" echo APP:%1 在黑名单中>>%app_log% &set error_code=0xa00002A5E& goto over

:load
if "%skip_appcheck%"=="true" goto __skip_appcheck
echo Checking Modules:%1
if not exist %appdir%\%1.hash echo 签名失败:%1>>%app_log% &set error_code=0xa000028F5& goto over
cd /d %appdir%
sum -r %1 >%temp%\hash.temp
fc %temp%\hash.temp %appdir%\%1.hash >nul
if not "%errorlevel%"=="0" echo 签名检测失败:%1>>%app_log% &set error_code=0xa00002A5D& goto over

:__skip_appcheck



for %%f in (%ppk_label%) do if exist %appdir%\%1\data\support\%%f set ppk=true
if "%ppk%"=="true" call %kernel%\modules\ppk\init_ppk.bat %1 %%f
if "%ppk%"=="true" goto over


for %%f in (%ext_label%) do  if exist %appdir%\%1\pkg\%%f.lzh set ext=true

if "%ext%"=="true" call %kernel%\modules\ppk\init_ext.bat %1 %%f




:over
if "%ppk%"=="true" echo Kernel Load a PPK Modules:%1
if "%ext%"=="true" echo Kernel Load a EXT Modules:%1




set ppk=
set ext=