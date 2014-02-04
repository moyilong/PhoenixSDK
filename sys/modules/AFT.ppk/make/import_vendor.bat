@echo off
cd /d %intidir%
if exist %devdir%\info.meta goto pause_ferror
:resume
set /p meta=请拖入info.meta文件:
set /p cmd=请拖入dev_cmdline文件:
if not exist %devdir%\ mkdir %devdir%
copy %meta% %devdir%\info.meta
copy %cmd% %devdir%\dev_cmdline
call %api_dir%\devices_read.bat
goto end



:pause_ferror
echo 继续，您原有的配置文件将被清除!
pause>nul
rmdir /q /s %devdir%
goto resume


:end
rmdir work /q /s