@echo off
set net= 
echo ���ڼ�������
cd /d %proc% 
if exist sys_upd rmdir /q /s sys_upd
mkdir sys_upd
cd sys_upd
ftp  %net% pull "head.h"
if not exist head.h
goto server_error
call %kernel%\include.bat head.h
cls
echo ϵͳ���°�
echo ==========================
echo ��ǰ:%build%
echo Ŀ��:%u_build%
echo ��ǰ�ں�:%k_version%
echo Ŀ���ں�:%u_version%
echo ==========================
set /p yn=����[y/N]:
if not "%yn%"=="y" goto end
if not "%yn%"=="Y" goto end
echo ���ڸ��£����Ժ�.....
ftp %net% pull update.cab
ftp %net% pull update.cab.hash
zip32 h update.cab>1.hash
fc not "%error_level%"=="0" goto end
ren update.cab update.zip
zip x update.zip
if not exist kernel\.noupdate if not exist kernel\update.zip goto end
if not exist sdk\.noupdate if not exist sdk\update.zip goto end
if exist META-INFO\update-script.bat call META-INFO\update-script.bat && goto end
echo ʹ�����ø��½ű�������ϵͳ
echo ���ڸ����ں�
if exist %sdkdir%\kernel_backup rmdir /q /s %sdkdir%\kernel_Backup
ren %kernel% kernel_backup
mkdir %kernel%
copy kernel\update.zip %kernel%
cd /d %kernel%
zip x update.zip
del update.zip
cd /d %proc%\sys_upd



:server_error
echo ���·���������!
goto end

:end
cd /d %initdir%
rmdir /q /s %proc%\sys_upd
