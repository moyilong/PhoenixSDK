@echo off
title Android Firmware Tools zImage Maker [Reading..]
echo zip Update Maker 2
echo [HOST] Read info
if not "%build%"=="" goto continue

if not exist %devdir%\compile set build=1000

for /l %%f in (1000,1,9999) do if exist %devdir%\compile\%%f.lzh set build=%%f

if "%build%"==""  set build=1000

:continue
title Android Firmware Tools zImage Maker [Preparing Origin Update]
set /a build=%build%+1


rmdir /q /s %devdir%\compile
mkdir %devdir%\compile
echo %build%>%devdir%\compile\%build%.lzh

echo [HOST] Checking for Source
for %%f in (%initdir%\update;%devdir%;%initdir%\boot) do if not exist %%f set ldir=%%f && goto __error_nosource
echo �ļ�������
if not exist %initdir%\Donor echo ���ϲ��̼� && echo ���ϲ��̼� >>%app_Log%
if not exist %initdir%\recovery echo ������Recovery &&echo ������Recovery >>%app_log%

if exist %proc%\AFT rmdir /q /s %proc%\AFT


echo ���Ժ�...............................
echo ���ڽ�������

if exist %initdir%\update\update_cache.zip goto __compress_update

echo [HOST]���ڽ������棬���Ժ�..........
echo D | xcopy /e %initdir%\update %proc%\AFT >>%app_log%

goto __donor_start



:__compress_update
title Android Firmware Tools zImage Maker [Perpar PreCompress]
echo [HOST]���ڽ�ѹ��Ԥ����̼�..........
zip x %initdir%\update\update_cache.zip -o%proc%\AFT >>%app_log%
if not exist %proc%\wim_maker mkdir %proc%\wim_maker
echo [HOST]���ڴ�������
echo D | xcopy /e %proc%\AFT %proc%\wim_maker\update_origin>>%app_log%



if not exist %initdir%\recovery goto __skip_recovery
title Android Firmware Tools zImage Maker [Building Recovery]
echo [TARGET]���ڱ���Recovery
cd /d %initdir%
call %apidir%\make_recovery.bat %proc%\recovery.img

:__skip_recovery
title Android Firmware Tools zImage Maker [Building Boot]
echo [TARGET]���ڱ���Boot
cd /d %initdir%
call %apidir%\make_bootimg.bat %proc%\boot.img


:__donor_start
title Android Firmware Tools zImage Maker [Donor Merge]
echo [TARGET] �ϳɹ̼�
echo y | copy %proc%\boot.img %proc%\AFT\boot.img
if exist %proc%\recovery.img echo y | copy %proc%\recovery.img %proc%\AFT\recovery.img
if not exist %initdir%\Donor goto __skip_donor
cd /d %initdir%\Donor
echo     ����ϲ���Ŀ
for /d %%f in (*) do if not exist %%f\.del echo D | xcopy /e /Y %%f %proc%\AFT\system
if not exist del.list goto __skip_file
title Android Firmware Tools zImage Maker [Donor Remove]
echo     ����ɾ����Ŀ/�ļ�
for /f %%f in (del.list) do echo ɾ��:%proc%\AFT\%%f && del %proc%\AFT\%%f
:__skip_file
if not exist rmdir.list goto __skip_dir
echo	����ɾ����Ŀ/Ŀ¼
for /f %%f in (rmdir.list) do rmdir /q /s %proc%\AFT\%%f
title Android Firmware Tools zImage Maker [Donor Other]
:__skip_dir
echo ���ڴ��������ļ�
if exist build.prop copy build.prop %proc%\AFT\system\build.prop
if exist build_extend.prop (
type build_extend.prop>%proc%\AFT\system\build.prop
type build.prop>>%proc%\AFT\system\build.prop
)
echo �ϳɽ���
:__skip_donor
title Android Firmware Tools zImage Maker [zipalig]
if "%global_zipalign_skip%"=="true" goto __skip_zipalig
echo ���ڽ���Zipalign�Ż�
cd /d %proc%
mkdir app
move AFT\system\app\*.apk app
cd app
dir /b >..\list
cd ..
for /f %%f in (list) do zipalign -f 4 app\%%f AFT\system\app\%%f && echo �����Ż�:%%f
rmdir /q /s app
if not exist %proc%\AFT\system\priv-app goto __skip_priv_1
mkdir priv-app
move AFT\system\priv-app\*.apk priv-app
cd priv-app
dir /b >..\list
cd ..
for /f %%f in (list) do zipalign -f 4 priv-app\%%f AFT\system\priv-app\%%f && echo �����Ż�:%%f
rmdir /q /s priv-app
:__skip_priv_1

mkdir framework
move AFT\system\framework\*.apk framework
cd framework
dir /b >..\list
cd ..
for /f %%f in (list) do zipalign -f 4 framework\%%f AFT\system\framework\%%f && echo �����Ż�:%%f
rmdir /q /s framework

:__skip_zipalig
if "%sign_file_globalapk%"=="false" goto __skip_signapk

if not exist "%key%.x509.pem" echo �Ҳ���"%key%.x509.pem" ����ǩ�� && goto __skip_sign
if not exist "%key%.pk8" echo �Ҳ���"%key%.pk8" ����ǩ�� && goto __skip_sign

cd /d %proc%
mkdir app
move AFT\system\app\*.apk app
cd app
dir /b >..\list
cd ..
for /f %%f in (list) do java -jar %java_dir%\sign.jar %key%.x509.pem %key%.pk8 app\%%f AFT\system\app\%%f && echo ����ǩ��:%%f
rmdir /q /s app

if not exist %proc%\AFT\system\priv-app goto __skip_priv_2
mkdir priv-app
move AFT\system\priv-app\*.apk priv-app
cd priv-app
dir /b >..\list
cd ..
for /f %%f in (list) do java -jar %java_dir%\sign.jar %key%.x509.pem %key%.pk8 priv-app\%%f AFT\system\priv-app\%%f && echo ����ǩ��:%%f
rmdir /q /s priv-app
:__skip_priv_2

mkdir framework
move AFT\system\framework\*.apk framework
cd framework
dir /b >..\list
cd ..
for /f %%f in (list) do java -jar %java_dir%\sign.jar %key%.x509.pem %key%.pk8 framework\%%f AFT\system\framework\%%f && echo ����ǩ��:%%f
rmdir /q /s framework
:__skip_signapk
title Android Firmware Tools zImage Maker [making]
echo �������ɹ̼�ѹ���������Ժ�..............
if exist %initdir%\update.zip del %initdir%\update.zip
cd /d %proc%\AFT
if "%sign_file_update%"=="true" (
if exist %proc%\update.zip del %proc%\update.zip
zip a -slp -r %proc%\update.zip *>>%app_log%
echo ����ǩ��update.zip..................
java -jar %java_dir%\sign.jar %key%.x509.pem %key%.pk8 %proc%\update.zip %initdir%\update.zip
)
if not "%sign_file_update%"=="true"  zip a -slp %initdir%\update.zip *
cd /d %initdir%
echo ������ջ���

echo ��·���д�������

if "%ro_skip_backup%"=="true" goto over

start /MIN %apidir%\make_mkp_wim.bat 
echo %build%>%devdir%\compile\%build%.lzh
:over
echo ���ɽ���
goto end






:__error_nosource
echo �Ҳ���%ldir%
sleep 5
goto end

:end
title %title%