@echo off
call %appdir%\AFT.ppk\api\deodex.bat %initdir%\update\system\app %1
call %appdir%\AFT.ppk\api\deodex.bat %initdir%\update\system\framework %1
if exist %initdir%\update\system\priv-app call %appdir%\AFT.ppk\api\deodex.bat %initdir%\update\system\priv-app %1