@echo off
echo zip Update Maker 2
if not "%build%"=="" goto continue
if not exist %out%\id echo 1000 >%out%\id
set /p build=<%out%\id
if "%build%"=="" set build=1000
set o_build=%build%-10
if exist %out%\%o_build% rmdir /q /s %out%\%o_build%
:continue
mkdir %out%\%build%
echo Checking for Source
for %%f in (%initdir%\update;%devdir%;%initdir%\boot) if not exist %%f set ldir=%%f && goto __error_nosource
echo 文件树完整
if not exist %initdir%\Donor echo 不合并固件
if not exist %initdir%\recovery echo 不编译Recovery

if exist %proc%\AFT rmdir /q /s %proc%\AFT

if not exist %initdir%\recovery goto __skip_recovery
echo 正在编译Recovery
cd /d %initdir%
call %apidir%\make_recovery.bat %proc%\recovery.img

:__skip_recovery
echo 正在编译Boot
cd /d %initdir%
call %apidir%\make_bootimg.bat %proc%\boot.img

echo 请稍候...............................
echo 正在建立缓存

if exist %initdir%\update\update_cache.zip goto __compress_update

echo 正在建立缓存，请稍候..........
echo D | xcopy /e %initdir%\update %proc%\AFT

goto __donor_start




:__compress_update
echo 正在解压缩预编译固件..........
cd /d %proc%\AFT
zip x %initdir%\update\update_cache.zip

:__donor_start
sha1sum -r %proc%\AFT >>%temp%\sha1_1
echo 合并固件中...........
cd /d %initdir%\Donor
echo     处理合并项目
for /d %%f in (*) do echo D | xcopy /e %%f %proc%\AFT
if not exist del.list goto __skip_file
echo     处理删除项目/文件
for /f %%f in (del.list) do del %proc%\AFT\%%f
:__skip_file
if not exist rmdir.list goto __skip_dir
echo	处理删除项目/目录
for /f %%f in (rmdir.list) do rmdir /q /s %proc%\AFT\%%f
:__skip_dir
echo 正在处理其他文件
if exist build.prop copy build.prop %proc%\AFT\system\build.prop
if exist build_extend.prop (
type build_extend.prop>%proc%\AFT\system\build.prop
type build.prop>>%proc%\AFT\system\build.prop
)
echo 合成结束
sha1sum -r %proc%\AFT >>%temp%\sha1_2
fc %temp%\sha1_2 %temp%\sha1_1 >%log%\%build%.diff

if not "%gloal_zuoakugb_skip%"=="true" goto __skip_zipalig
echo 正在进行Zipalign优化
cd /d %proc%
mkdir app
move AFT\system\app\*.apk app
cd app
dir /b >..\list
cd ..
for /f %%f in (list) do zipalign -f 4 app\%%f AFT\system\app\%%f
rmdir /q /s app
if not exist %proc%\AFT\system\priv-app goto __skip_priv_1
mkdir priv-app
move AFT\system\priv-app\*.apk priv-app
cd priv-app
dir /b >..\list
cd ..
for /f %%f in (list) do zipalign -f 4 priv-app\%%f AFT\system\priv-app\%%f
rmdir /q /s priv-app
:__skip_priv_1

mkdir framework
move AFT\system\framework\*.apk framework
cd framework
dir /b >..\list
cd ..
for /f %%f in (list) do zipalign -f 4 framework\%%f AFT\system\framework\%%f
rmdir /q /s framework

:__skip_zipalig
if not "%sign_file_globalapk%"="true" goto __skip_signapk

if not exist "%key%.x509.pem" echo 找不到"%key%.x509.pem" 跳过签名 && goto __skip_sign
if not exist "%key%.pk8" echo 找不到"%key%.pk8" 跳过签名 && goto __skip_sign

cd /d %proc%
mkdir app
move AFT\system\app\*.apk app
cd app
dir /b >..\list
cd ..
for /f %%f in (list) do java -jar %java_dir%\sign.jar %key%.x509.pem %key%.pk8 app\%%f AFT\system\app\%%f
rmdir /q /s app

if not exist %proc%\AFT\system\priv-app goto __skip_priv_2
mkdir priv-app
move AFT\system\priv-app\*.apk priv-app
cd priv-app
dir /b >..\list
cd ..
for /f %%f in (list) do java -jar %java_dir%\sign.jar %key%.x509.pem %key%.pk8 priv-app\%%f AFT\system\priv-app\%%f
rmdir /q /s priv-app
:__skip_priv_2

mkdir framework
move AFT\system\framework\*.apk framework
cd framework
dir /b >..\list
cd ..
for /f %%f in (list) do java -jar %java_dir%\sign.jar %key%.x509.pem %key%.pk8 framework\%%f AFT\system\framework\%%f
rmdir /q /s framework
:__skip_signapk
echo 正在生成固件压缩包，请稍候..............
if exist %initdir%\update.zip
cd /d %proc%\AFT
if not "%sign_file_update%"=="true" (
zip a -slp update.zip *
java -jar %java_dir%\sign.jar %key%.x509.pem %key%.pk8 update.zip %intidir%\update.zip
)
zip a -slp %initdir%\update.zip *
echo 正在清空缓存
rmdir /q /s %proc%\AFT
echo 三路并行创建备份
if not "%skip_backup%"=="true" (
echo 创建:%out%\%build%\compile_tool.lzh		设备配置文档
start /MIN %zip% a %out%\%build%\compile_tool.lzh %devdir%  -t LZH
echo 创建:%out%\%build%\update_original.zip		固件镜像源
start /MIN %zip% a %out%\%build%\update_original.zip %initdir%\update  
echo 创建:%out%\%build%\boot_image.lzh			设备Boot.img压缩镜像
start /MIN %zip% a %out%\%build%\boot_image.lzh %initdir%\boot  -t LZH
echo 创建:%out%\%build%\Donor.zip				合成工程项目文件
if exist %initdir%\Donor start /MIN %zip% a %out%\%build%\Donor.zip %initdir%\Donor  
echo 创建:%out%\%build%\reocovery.lzh			设备Recovery.img压缩镜像
if exist %initdir%\recovery start /MIN %zip% a %out%\%build%\recovery.lzh %initdir%\recovery
echo 创建:%out%\%build%\update.zip				输出文件
copy %initdir%\update.zip %out%\%build%\update.zip
)
echo 生成结束
goto end




:__error_nosource
echo 找不到%ldir%
sleep 5
goto end

:end