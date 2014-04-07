echo Kernel Phenom Package Kit Util

if not exist %appdir%\%1\data\META-INFO echo ´íÎóµÄ°ü:%1>>%sys_log% & set error_code=0xa000ffff& goto end

:load2
echo Starting Modules
if not exist %appdir%\%1\data\cmd_list goto skip_load
for /f %%f in (%appdir%\%1\data\cmd_list) do call %kernel%\ins_process.bat %1 %%f

if exist %appdir%\%1\data\app_config.kcfg %proc%\kcfg\%1.kcfg

:skip_load
if exist %appdir%\%1\kernel_path_ex copy %appdir%\%1\kernel_path_ex\* %proc%\kernel_path\
if exist %appdir%\%1\data\init.bat call %appdir%\%1\data\init.bat Kernel_init
if exist %appdir%\%1\api echo D | xcopy /Y /E %appdir%\%1\api %api_dir%
set feature=%feature%;%1
set ppk_pkg=%1;%ppk_pkg%
echo Add Modules:%1 >>%app_log%

:end
echo Modules Loader End >>%sys_log%
echo End with Errorcode:%error_code%>>%sys_log%