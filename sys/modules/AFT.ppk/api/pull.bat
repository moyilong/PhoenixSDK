`@echo off
call %apidir%\path_reader.bat %1
if "%fil%"=="not_exist" goto end
:nxt
echo ��ʼ��ADB��
call %api_dir%\k_tadb.bat
echo �ȴ��豸
call %api_dir%\wait_dev.bat
echo ��ȡ�ļ���
adb pull %fil%
:end