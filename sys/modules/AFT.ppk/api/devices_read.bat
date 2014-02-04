if not exist %devdir%\info.meta set vendor_exist=false && goto end
set vendor_exist=true
echo Importing Default Configure
call %kernel%\include.bat %appdir%\AFT.ppk\default_include.h
call %kernel%\include.bat %devdir%\info.meta
set /p mkbootimg=<%devdir%\dev_cmdline
set support=fild
if not exist %appdir%\AFT.ppk\DefConfigMake\%def_config_sysmode% set def_config_sysmode=zip\Normally
for %%f in (%vendor_ver%) do if "%vendor_version%"=="%%f" goto end

echo Vendor 文件兼容失败 !
echo HOST VERSION %vendor_ver%
echo Import Version %vendor_version%
sleep 6






:end

echo 后期处理中...
if "%sign_mode%"=="internal" set key=%cert_dir%\%sign_key%
if "%sign_mode%"=="vendor" set key=%devdir%\%sign_key%