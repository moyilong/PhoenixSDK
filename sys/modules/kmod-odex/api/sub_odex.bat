@echo off
echo Odex:%1 Mode:%odex_mode%>>%app_log%
cd /d %1
dir /b >%temp%\temp_list
for /f %%f in (%temp%\temp_list) do (
if exist %initdir%\dex2opt\hash_table\%%f.hstab call %apidir%\cache_odex_load.bat %1 %%f
if not exist %initdir%\dex2opt\hash_table\%%f.hstab call %apidir%\compile_odex_load.bat %1 %%f




)