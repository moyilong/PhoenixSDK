if not exist %appdir%\%1\data\META-INFO echo ´íÎóµÄ°ü:%1>>%sys_log% & set error_code=0xa000ffff& goto end

:load2
if not exist %appdir%\%1\data\default.h goto load_cmd
call %kernel%\include.bat %appdir%\%1\data\default.h

:load_cmd
if not exist %appdir%\%1\data\cmd_list goto skip_load
for /f %%f in (%appdir%\%1\data\cmd_list) do call %kernel%\modules\ins_process.bat %1 %%f


:skip_load
set return_abort_init=false
if exist %appdir%\%1\data\init.bat call %appdir%\%1\data\init.bat Kernel_init
if "%return_abort_init%"=="true" call %kernel%\service\app_abort.bat %1 APPLICATION_REPORT_ABORT
if exist %appdir%\%1\kernel_path_ex copy %appdir%\%1\kernel_path_ex\* %proc%\kernel_path\
if not exist %appdir%\%1\api goto __skip_api
cd /d %appdir%\%1\api
dir /b >%temp%\flist
for /f %%f in (%temp%\flist) do (
echo [%1]Add API:%%f>>%sys_log%
copy %appdir%\%1\api\%%f %api_dir%\
)
cd /d %initdir%
:__skip_api
set feature=%feature%;%1
set ppk_pkg=%1;%ppk_pkg%
echo Add Modules:%1 >>%app_log%

:end
echo End Module Load with Errorcode:%error_code%>>%sys_log%