@echo off

echo.
echo.
echo.
echo.
echo            ___         ___                ___
echo          /      /     /   /   /\    /   /          
echo         /----  /     /   /   /  \  /   /----  
echo        /____  /___  /___/   /    \/   /____   inside 2010 - 2014     
echo.     
echo	[�ں�]	�����˳�
doskey ec=call %kernel%\service\set_errorcode.bat
set error_code=0xE00005DB
echo ���ڽ�������
echo STATUS_STOP>%proc%\proc.stat
echo ���ڽ�������
cd /d %proc%\service
:service
echo �ȴ��������
cd init
dir /b >%proc%\srv_list
cd ..
cd WORK
for /f %%f in (%proc%\srv_list) do if exist %proc%\service\WORK\%%f echo Waitting for :%%f && set wait=true
if "%wait%"=="true" goto service
set error_code=0xa0000fff
for %%f in (%feature%) do if exist %appdir%\%%f\data\exit_code.bat call %appdir%\%%f\data\exit_code.bat
for /r %proc%\shutdown_code\ %%f in (*.bat) do call %%f
pause
set error_code=0xE1ff00ff
rmdir /q /s %apidir%
set error_code=0xE1000105
rmdir /q /s %proc%
set error_code=0xEfffffff
doskey exit=
echo Kernel Exit!
                                              

exit
exit
exit
exit
exit