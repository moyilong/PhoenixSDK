
if not exist %user%\black-list.conf goto load
for /f %%f in (%user%\black-list.conf) do if "%1"=="%%f" echo APP:%1 在黑名单中>>%app_log% &set error_code=0xa00002A5E& goto over

:load

echo Checking Modules:%1
if not exist %appdir%\%1.hash echo 签名失败:%1>>%app_log% &set error_code=0xa000028F5& if not "%skip_appcheck%"=="true" goto over
cd /d %appdir%
sum -r %1 >%temp%\hash.temp
fc %temp%\hash.temp %appdir%\%1.hash >nul
if not "%errorlevel%"=="0" echo 签名检测失败:%1>>%app_log% &set error_code=0xa00002A5D & if not "%skip_appcheck%"=="true" goto over




for %%f in (%ppk_label%) do if exist %appdir%\%1\data\support\%%f set ppk=true
if "%ppk%"=="true" set error_code=0xaff221f9 && call %kernel%\modules\init_ppk.bat %1
if "%ppk%"=="true" goto over


for %%f in (%ext_label%) do  set error_code=0xaff221fa && if exist %appdir%\%1\pkg\%%f.lzh call %kernel%\modules\init_ext.bat %1 %%f






:over

cd /d %appdir%\%1
for /r %%f in (*.apx) do copy %%f %APX_DIR%\
cd /d %initdir%

set ppk=
set ext=