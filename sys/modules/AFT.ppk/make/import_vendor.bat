@echo off
cd /d %intidir%
if exist %devdir%\info.meta goto pause_ferror
:resume
set /p meta=������info.meta�ļ�:
set /p cmd=������dev_cmdline�ļ�:
if not exist %devdir%\ mkdir %devdir%
copy %meta% %devdir%\info.meta
copy %cmd% %devdir%\dev_cmdline
call %api_dir%\devices_read.bat
goto end



:pause_ferror
echo ��������ԭ�е������ļ��������!
pause>nul
rmdir /q /s %devdir%
goto resume


:end
rmdir work /q /s