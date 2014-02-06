@echo off
echo zip Update Maker 2
if not "%build%"=="" goto continue
for /l %%f in (1000,1,9999) do if exist %out%\%%f set build=%%f
if "%build%"=="" set build=1000
set o_build=%build%-10
if exist %out%\%o_build% rmdir /q /s %out%\%o_build%
:continue
set /a build=%build%+1
mkdir %out%\%build%
echo Checking for Source
for %%f in (%initdir%\update;%devdir%;%initdir%\boot) do if not exist %%f set ldir=%%f && goto __error_nosource
echo �ļ�������
if not exist %initdir%\Donor echo ���ϲ��̼�
if not exist %initdir%\recovery echo ������Recovery

if exist %proc%\AFT rmdir /q /s %proc%\AFT


echo ���Ժ�...............................
echo ���ڽ�������

if exist %initdir%\update\update_cache.zip goto __compress_update

echo ���ڽ������棬���Ժ�..........
echo D | xcopy /e %initdir%\update %proc%\AFT

goto __donor_start



:__compress_update
echo ���ڽ�ѹ��Ԥ����̼�..........
zip x %initdir%\update\update_cache.zip -o%proc%\AFT


if not exist %initdir%\recovery goto __skip_recovery
echo ���ڱ���Recovery
cd /d %initdir%
call %apidir%\make_recovery.bat %proc%\recovery.img

:__skip_recovery
echo ���ڱ���Boot
cd /d %initdir%
call %apidir%\make_bootimg.bat %proc%\boot.img


:__donor_start
echo y | copy %proc%\boot.img %proc%\AFT\boot.img
if exist %proc%\recovery.img echo y | copy %proc%\recovery.img %proc%\AFT\recovery.img
if not exist %initdir%\Donor goto __skip_donor
sha1sum -r %proc%\AFT >>%temp%\sha1_1
echo �ϲ��̼���...........
cd /d %initdir%\Donor
echo     ����ϲ���Ŀ
for /d %%f in (*) do echo D | xcopy /e /Y %%f %proc%\AFT\system
if not exist del.list goto __skip_file
echo     ����ɾ����Ŀ/�ļ�
for /f %%f in (del.list) do del %proc%\AFT\%%f
:__skip_file
if not exist rmdir.list goto __skip_dir
echo	����ɾ����Ŀ/Ŀ¼
for /f %%f in (rmdir.list) do rmdir /q /s %proc%\AFT\%%f
:__skip_dir
echo ���ڴ��������ļ�
if exist build.prop copy build.prop %proc%\AFT\system\build.prop
if exist build_extend.prop (
type build_extend.prop>%proc%\AFT\system\build.prop
type build.prop>>%proc%\AFT\system\build.prop
)
echo �ϳɽ���
sha1sum -r %proc%\AFT >>%temp%\sha1_2
fc %temp%\sha1_2 %temp%\sha1_1 >%log%\%build%.diff
:__skip_donor
if "%gloal_zipalign_skip%"=="true" goto __skip_zipalig
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
echo �������ɹ̼�ѹ���������Ժ�..............
if exist %initdir%\update.zip del %initdir%\update.zip
cd /d %proc%\AFT
if "%sign_file_update%"=="true" (
if exist %proc%\update.zip del %proc%\update.zip
zip a -slp %proc%\update.zip *
echo ����ǩ��update.zip..................
java -jar %java_dir%\sign.jar %key%.x509.pem %key%.pk8 %proc%\update.zip %initdir%\update.zip
)
if not "%sign_file_update%"=="true"  zip a -slp %initdir%\update.zip *
cd /d %initdir%
echo ������ջ���
rmdir /q /s %proc%\AFT
echo ��·���д�������
if not "%skip_backup%"=="true" (
echo ����:%out%\%build%\compile_tool.7z			�豸�����ĵ�
start /MIN zip a %out%\%build%\compile_tool.7z %devdir%  -t7z
echo ����:%out%\%build%\update_original.zip		�̼�����Դ
if not exist %initdir%\update\update_cache.zip start /MIN zip a %out%\%build%\update_original.zip %initdir%\update  
echo ����:%out%\%build%\boot_image.7z			�豸Boot.imgѹ������
start /MIN zip a %out%\%build%\boot_image.7z %initdir%\boot  -t7z
echo ����:%out%\%build%\Donor.zip			�ϳɹ�����Ŀ�ļ�
if exist %initdir%\Donor start /MIN zip a %out%\%build%\Donor.zip %initdir%\Donor  
echo ����:%out%\%build%\reocovery.7z			�豸Recovery.imgѹ������
if exist %initdir%\recovery start /MIN zip a %out%\%build%\recovery.7z %initdir%\recovery
echo ����:%out%\%build%\update.zip			����ļ�
copy %initdir%\update.zip %out%\%build%\update.zip
if exist %initdir%\update\update_cache.zip copy %initdir%\update\update_cache.zip %out%\%build%\update_original.zip
)
echo ���ɽ���
goto end




:__error_nosource
echo �Ҳ���%ldir%
sleep 5
goto end

:end