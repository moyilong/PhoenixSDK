@echo off
if exist %initdir%\devices\make\%1.bat call %initdir%\devices\make\%1.bat %2 %3 %4 %5 %6 && goto end
 if exist %appdir%\AFT.ppk\DefConfigMake\%def_config_sysmode%\%1.bat call %appdir%\AFT.ppk\DefConfigMake\%def_config_sysmode%\%1.bat && goto end
call %kernel%\make.bat %1 %2 %3 %4 %5 %6
:end
