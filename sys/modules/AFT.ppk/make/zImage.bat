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
for %%f in (%initdir%\update;%devdir%;%initdir%\boot;%initdir%\recovery) do if not exist %%f set ldir=%%f && goto __error_nosource
echo 文件树完整
if not exist %initdir%\Donor echo 不合并固件 && echo 不合并固件 >>%app_Log%
if not exist %initdir%\recovery echo 不编译Recovery &&echo 不编译Recovery >>%app_log%

if exist %proc%\AFT rmdir /q /s %proc%\AFT


echo 请稍候...............................
echo 正在建立缓存

if exist %initdir%\update\update_cache.zip goto __compress_update

echo [HOST]正在建立缓存，请稍候..........
echo D | xcopy /e %initdir%\update %proc%\AFT >>%app_log%

goto __donor_start



:__compress_update
title Android Firmware Tools zImage Maker [Perpar PreCompress]
echo [HOST]正在解压缩预编译固件..........
if not exist %proc_common%\AFT goto not_cache
cd %intidir%\update
sha1sum update_cache.zip %temp%\temp.sha1
fc %temp%\temp.sha1 %proc_common%\AFT\sha1.sum 
if not "%error_level%"=="0" goto not_cache

echo 使用缓存的文件...............
zip x %proc_common%\AFT\cache.zip -o%proc%\AFT >>%app_log%
goto _cache_over

:not_cache
zip x %initdir%\update\update_cache.zip -o%proc%\AFT >>%app_log%
if not exist %proc%\wim_maker mkdir %proc%\wim_maker
echo [TOOL_BOX]正在创建交换文件...........
if exist %proc_common%\AFT rmdir /q /s %proc_common%\AFT
mkdir %proc_common%\AFT
copy %update%\update\update_cache.zip %proc_common%\AFT\cache.zip
cd /d %proc_common%\AFT
sha1sum cache.zip > sha1.sum
cd /d %initdir%

:_cache_over
:over
echo [HOST]正在创建镜像
echo D | xcopy /e %proc%\AFT %proc%\wim_maker\update_origin>>%app_log%



if not exist %initdir%\recovery goto __skip_recovery
title Android Firmware Tools zImage Maker [Building Recovery]
echo [TARGET]Compile Recovery
cd /d %initdir%
call %apidir%\make_recovery.bat %proc%\recovery.img

:__skip_recovery
title Android Firmware Tools zImage Maker [Building Boot]
echo [TARGET]Compile Boot
cd /d %initdir%
call %apidir%\make_bootimg.bat %proc%\boot.img
echo y | copy %proc%\boot.img %proc%\AFT\boot.img  >>%app_log%
if exist %proc%\recovery.img echo y | copy %proc%\recovery.img %proc%\AFT\recovery.img >>%app_log%
:__donor_start
title Android Firmware Tools zImage Maker [Donor Merge]
echo [TARGET] 合成固件


if not exist %initdir%\Donor goto __skip_donor
call %apidir%\donor_main %proc%\AFT

:__skip_donor
title Android Firmware Tools zImage Maker [zipalig]
if "%global_zipalign_skip%"=="true" goto __skip_zipalig
echo 正在进行Zipalign优化
cd /d %proc%
mkdir app
move AFT\system\app\*.apk app
cd app
dir /b >..\list
cd ..
for /f %%f in (list) do zipalign -f 4 app\%%f AFT\system\app\%%f && echo 正在优化:%%f
rmdir /q /s app
if not exist %proc%\AFT\system\priv-app goto __skip_priv_1
mkdir priv-app
move AFT\system\priv-app\*.apk priv-app
cd priv-app
dir /b >..\list
cd ..
for /f %%f in (list) do zipalign -f 4 priv-app\%%f AFT\system\priv-app\%%f && echo 正在优化:%%f
rmdir /q /s priv-app
:__skip_priv_1

mkdir framework
move AFT\system\framework\*.apk framework
cd framework
dir /b >..\list
cd ..
for /f %%f in (list) do zipalign -f 4 framework\%%f AFT\system\framework\%%f && echo 正在优化:%%f
rmdir /q /s framework

:__skip_zipalig
if "%sign_file_globalapk%"=="false" goto __skip_signapk

if not exist "%key%.x509.pem" echo 找不到"%key%.x509.pem" 跳过签名 && goto __skip_sign
if not exist "%key%.pk8" echo 找不到"%key%.pk8" 跳过签名 && goto __skip_sign

cd /d %proc%
mkdir app
move AFT\system\app\*.apk app
cd app
dir /b >..\list
cd ..
for /f %%f in (list) do java -jar %java_dir%\sign.jar %key%.x509.pem %key%.pk8 app\%%f AFT\system\app\%%f && echo 正在签名:%%f
rmdir /q /s app

if not exist %proc%\AFT\system\priv-app goto __skip_priv_2
mkdir priv-app
move AFT\system\priv-app\*.apk priv-app
cd priv-app
dir /b >..\list
cd ..
for /f %%f in (list) do java -jar %java_dir%\sign.jar %key%.x509.pem %key%.pk8 priv-app\%%f AFT\system\priv-app\%%f && echo 正在签名:%%f
rmdir /q /s priv-app
:__skip_priv_2

mkdir framework
move AFT\system\framework\*.apk framework
cd framework
dir /b >..\list
cd ..
for /f %%f in (list) do java -jar %java_dir%\sign.jar %key%.x509.pem %key%.pk8 framework\%%f AFT\system\framework\%%f && echo 正在签名:%%f
rmdir /q /s framework
:__skip_signapk
title Android Firmware Tools zImage Maker [making]
echo 正在生成固件压缩包，请稍候..............
if exist %initdir%\update.zip del %initdir%\update.zip
cd /d %proc%\AFT
echo %bs% %date% %time% >system\etc\build_subinfo.s
sha1sum -r . >system\etc\build_subinfo.s.sha1sum
if "%sign_file_update%"=="true" (
if exist %proc%\update.zip del %proc%\update.zip
zip a -slp -r %proc%\update.zip *>>%app_log%
echo 正在签名update.zip..................
java -jar %java_dir%\sign.jar %key%.x509.pem %key%.pk8 %proc%\update.zip %initdir%\update.zip
)
if not "%sign_file_update%"=="true"  zip a -slp %initdir%\update.zip *>>%app_log%
cd /d %initdir%
echo 正在清空缓存
if "%skip_backup%"=="true" goto over

start /MIN %apidir%\make_mkp_wim.bat 
echo %build%>%devdir%\compile\%build%.lzh
:over
echo 生成结束
goto end






:__error_nosource
echo 找不到%ldir%
sleep 5
goto end

:end
title %title%