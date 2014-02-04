 @echo off
echo zImage Maker V4.x
set make_stat=start
cd /d %initdir% 
if not "%build%"=="" goto continue
if not exist %out%\id echo 1000 >%out%\id
set /p build=<%out%\id
if "%build%"=="" set build=1000
set o_build=%build%-10
if exist %out%\%o_build% rmdir /q /s %out%\%o_build%
:continue
if exist %initdir%\update\update.zip del %initdir%\update\update.zip
if not exist "%key%.x509.pem" goto key_error
if not exist "%key%.pk8" goto key_error
call %api_dir%\check_devices.bat
if not exist %initdir%\update goto not_exist
if not exist %devdir% goto dev_error

cd /d %temp%
dir /b AFT_TMP_KRNL* >filelist
for /f %%f in (filelist) do rmdir %%f /q /s

set uuid=AFT_TMP_KRNL_%random%%random%
set tmp_out=%temp%\tmp_out_%uuid%

if not exist %temp%\AFP_TMP echo D| xcopy /e %initdir%\update  %temp%\%uuid%
if exist %temp%\AFP_TMP echo D| xcopy /e %temp%\AFP_TMP  %temp%\%uuid%
if "%1"=="ready" goto ready
if not exist %initdir%\Donor goto skip_donor



call %apidir%\donor_main.bat %initdir%\donor %temp%\%uuid%

:skip_donor


set /a build=%build%+1
echo 正在编译启动镜像
call %api_dir%\make_bootimg.bat %temp%\%uuid%\boot.img
echo 正在编译Recovery
if exist recovery call %api_dir%\make_recovery.bat %temp%\%uuid%\recovery.img

sleep 1

cd /d %temp%\%uuid%
echo 执行自定义代码
if exist %devdir%\custom.bat  call %devdir%\custom.bat
echo 执行自定义代码结束

echo %name%  >system\etc\automake.sse
echo Android Builder >>system\etc\automake.sse
echo Make for DragonOS >>system\etc\automake.sse
echo Build Name:%provider% >>system\etc\automake.sse
echo Build Time:%date% %time%>>system\etc\automake.sse
echo Devices:%devices% >>system\etc\automake.sse
echo Devices Version:%init_vendor_version% >>system\etc\automake.sse
echo Developer:%developer% >>system\etc\automake.sse
echo ARCH:%m_arch% >>system\etc\automake.sse
echo CPU Feature:%m_cf% >>system\etc\automake.sse
echo Physics Memory:%m_pmem% >>system\etc\automake.sse
echo System:%m_os% >>system\etc\automake.sse
echo SignFile:%sign_mode%-%sign_key% >>system\etc\automake.sse
echo NetWork:%m_nc% >>system\etc\automake.sse
echo BuildID:%build%>>system\etc\automake.sse
echo Build Scription:%bs%>>system\etc\automake.sse
cd system\etc
ren automake.sse FirmwareInfo.sse
zip -h FirmwareInfo.sse >FirmwareInfo.hash
:ext_1


echo 执行ZIPALIGN优化
call %api_dir%\exec_zipalign.bat %temp%\%uuid%\system\app 4 %temp%\app\
if exist %temp%\%uuid%\system\priv-app call %api_dir%\exec_zipalign.bat %temp%\%uuid%\system\priv-app 4 %temp%\priv-app\
sleep 1
cd /d %initdir%
if not "%sign_file%"=="true" echo y | copy  %temp%\app\* %temp%\%uuid%\system\app && goto skip
if not "%sign_file_globalapk%"=="true" echo y | copy  %temp%\app\* %temp%\%uuid%\system\app && goto skip


echo 正在执行全场签名
cd /d %temp%\app
dir *.apk /b > listfile
for /f %%f in (listfile) do echo %passwd% | java -jar %java_dir%\sign.jar %key%.x509.pem %key%.pk8 %%f %temp%\%uuid%\system\app\%%f && echo 使用:%key%签名:%%f 
sleep 3

:skip


call %api_dir%\exec_zipalign.bat %temp%\%uuid%\system\framework 4 %temp%\framework\
sleep 1
cd /d %initdir%
if not "%sign_file%"=="true" echo y | copy %temp%\framework\*.apk %temp%\%uuid%\system\framework && goto skip_2


cd /d %temp%\framework
dir *.apk /b > listfile
for /f %%f in (listfile) do  java -jar %java_dir%\sign.jar %key%.x509.pem %key%.pk8 %%f %temp%\%uuid%\system\framework\%%f && echo 使用:%key%签名:%%f

:skip_2
rmdir /q /s %temp%\framework;%temp%\app

echo 正在处理非签名文件
copy %temp%\%uuid%\system\napp\* %temp%\%uuid%\system\app\*
rmdir /q /s %temp%\%uuid%\system\napp


echo 正在创建ZIP二进制文件
cd /d %temp%\%uuid%
echo 工作目录:%cd%
if exist update.zip del update.zip
if exist %initdir%\update\update.zip del %initdir%\update\update.zip
if exist %initdir%\update.zip del %intidir%\update.zip
if not exist %out%\%build% mkdir %out%\%build%
zip h * > system\etc\Firmware_Hash.Hash
zip a -slp update.zip * -mmt%cores%
if exist %intidir%\update.zip del %initdir%\update.zip
cd /d %initdir%
if not "%skip_backup%"=="true" (
start /MIN %zip% a %out%\%build%\compile_tool.lzh %devdir% 
start /MIN %zip% a %out%\%build%\update_original.zip %initdir%\update  
if exist %initdir%\Donor start /MIN %zip% a %out%\%build%\Donor.zip %initdir%\Donor  
)
echo 正在签名文件，请稍候
if not "%sign_file%"=="true" copy %temp%\%uuid%\update.zip %initdir%\ & goto no_sign
if not "%sign_update_file%"=="true" copy %temp%\%uuid%\update.zip %initdir%\ & goto no_sign
java -jar -Xmx%mem%M %java_dir%\sign.jar %key%.x509.pem %key%.pk8 %temp%\%uuid%\update.zip %initdir%\update.zip
:no_sign


mkdir %tmp_out%\%build%
copy update.zip %tmp_out%\%build%\
echo 正在计算ChekSUM
cd /d %tmp_out%\%build%
echo  %name% %build% >>%out%\%build%\META-INFO.txt
echo  Android Builder %version% >>%out%\%build%\META-INFO.txt
echo CheckSUM of update.zip  >>%out%\%build%\META-INFO.txt
sum update.zip  >>%out%\%build%\META-INFO.txt
call %kernel%\line.bat >> %out%\%build%\META-INFO.txt

if exist %devdir%\cplist for /f %%f in (%devdir%\cplist) do  copy -Y update.zip %%f\info.txt && copy -Y info.txt %%f\info.txt
cd /d %initdir%
echo %build%>%out%\id
copy %initdir%\update.zip %out%\%build%\
if "%debug%"=="false" cls
echo 输出:%initdir%\update.zip
if not "%skip_backup%"=="true" if exist %initdir%\Donor echo 输出:%out%\%build%\Donor.zip
if not "%skip_backup%"=="true" echo 输出:%out%\%build%\update_original.zip
if not "%skip_backup%"=="true" echo 输出:%out%\%build%\compile_tool.lzh
sleep 1
type %out%\%build%\META-INFO.txt
set make_stat=1


goto end


:ready
echo d | xcopy /Y /e update %temp%\AFP_TMP 
goto end

:not_exist
echo 找不到固件文件
goto end


:dev_error
echo 找不到设备配置文件!
goto end

:key_error
echo 找不到签名文件:%key%.x509.pem和%key%.pk8

:end
set remove_list=%temp%\%uuid%;%tmp_out%
for %%f in (%remove_list%) do if exist %%f rmdir /q /s %%f
cd /d %initdir%
goto end1
:end1