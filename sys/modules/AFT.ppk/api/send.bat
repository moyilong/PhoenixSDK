@echo off
call %apidir%\path_reader.bat %1
if "%fil%"=="not_exist" goto end
echo ��ʼ��ADB��
call %api_dir%\k_tadb.bat
echo �ȴ��豸
call %api_dir%\wait_dev.bat
echo �����ļ� %1
adb push %1 %fil%
:end