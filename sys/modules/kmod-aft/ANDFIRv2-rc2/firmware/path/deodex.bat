@echo off
if "%1"=="" goto arg_error

call %appdir%\AFT.ppk\api\deodex.bat %initdir%\update\system\app %1
call %appdir%\AFT.ppk\api\deodex.bat %initdir%\update\system\framework %1
if exist %initdir%\update\system\priv-app call %appdir%\AFT.ppk\api\deodex.bat %initdir%\update\system\priv-app %1
goto end

:arg_error
echo Unknow Arg
echo Useage:
echo deodex API_LEVEL
goto end
:end