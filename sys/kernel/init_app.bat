echo Kernel Init Modules:%1
if exist %appdir%\%1\data\exist.lst for /f %%f in (%appdir%\%1\data\exist.lst) do if not exist %appdir%\%%f echo APP:%1 找不到需求的:%%f>>%app_log% && goto end
if not exist %user%\black-list.conf goto load
set load=true
for /f %%f in (%user%\black-list.conf) do if "%1"=="%%f" set load=false
if "%load%"=="false" echo APP:%1 在黑名单中>>%app_log% &set error_code=0xa00002A5E& goto end

:load
if "%skip_appcheck%"=="true" goto __skip_appcheck
echo Checking Modules:%1
if not exist %appdir%\%1\data\META-INFO echo 错误的包:%1>>%sys_log% & set error_code=0xa000ffff& goto end
if not exist %appdir%\%1.hash echo 签名失败:%1>>%app_log% &set error_code=0xa000028F5& goto end
cd /d %appdir%
sum -r %1 >%temp%\hash.temp
fc %temp%\hash.temp %appdir%\%1.hash >nul
if not "%errorlevel%"=="0" echo 签名检测失败:%1>>%app_log% &set error_code=0xa00002A5D& goto end

:__skip_appcheck
for %%f in (%support_pkgver%) do if exist %appdir%\%1\data\support\%%f goto load2
echo %1 兼容失败
set error_code=0xaff0669a 
goto end


:load2
echo Starting Modules
if not exist %appdir%\%1\data\cmd_list goto skip_load
for /f %%f in (%appdir%\%1\data\cmd_list) do call %kernel%\ins_process.bat %1 %%f



:skip_load
if exist %appdir%\%1\kernel_path_ex copy %appdir%\%1\kernel_path_ex\* %proc%\kernel_path\
if exist %appdir%\%1\data\init.bat call %appdir%\%1\data\init.bat Kernel_init
if exist %appdir%\%1\api echo D | xcopy /Y /E %appdir%\%1\api %api_dir%
set feature=%feature%;%1
echo Add Modules:%1 >>%app_log%

:end
echo Modules Loader End >>%sys_log%
echo End with Errorcode:%error_code%>>%sys_log%