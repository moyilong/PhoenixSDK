@echo off
echo WIM Backup Maker
set t=%date:/=-%
set t=%t:~0,-3% %time::=_%
set t=%t:.=__%
echo Get Time ID=%t%
::mkdir %proc%\wim_maker
::mkdir %proc%\wim_maker\boot
::mkdir %proc%\wim_maker\recovery
::mkdir %proc%\wim_maker\Donor
::mkdir %proc%\wim_maker\compile_config
if exist %initdir%\Dex2Opt (
::mkdir %proc%\wim_maker\Dex2Opt
::echo D | xcopy /e %initdir%\dex2opt %proc%\wim_maker\Dex2Opt
set dir =%dir% /capturedir:%initdir%\dex2opt

)
set dir=%dir% /capturedir:%initdir%\boot
if exist %initdir%\recovery set dir=%dir% /capturedir:%initdir%\recovery
if exist %initdir%\Donor set dir=%dir% /capturedir:%initdir%\Donor
set dir=%dir% /capturedir:%devdir% /capturedir:%proc%\AFT /capturedir:%proc%\wim_maker\update_origin
::echo D | xcopy /e %initdir%\boot %proc%\wim_maker\boot
::if exist %initdir%\recovery echo D | xcopy /e %initdir%\recovery %proc%\wim_maker\recovery
::if exist %initdir%\Donor echo D | xcopy /e %initdir%\Donor %proc%\wim_maker\Donor
::echo D | xcopy /e %devdir% %proc%\wim_maker\compile_config
echo 正在生成WIM文件
::move %proc%\AFT %proc%\wim_maker\update_final

cd /d %proc%
::imagex /capture wim_maker %out%\temp.wim "AFT Backup Image %build%" /COMPRESS %wim_compress%
dism /Capture-Image %dir% /Compress:%wim_compress% /Image:%out%\temp.wim >>%sys_log%
imagex /export %out%\temp.wim 1 %out%\image_build.wim "AFT Backup Image %build%" "WIM Image Backup %build% at %date% %time%" >>%sys_log%
echo =================Android Firmware Tool %build%===========>%temp%\hash_table.%t%.sha1
echo Build ID %build% at %date% %time%>>%temp%\hash_table.%t%.sha1
echo Build Script=%bs%>>%temp%\hash_table.%t%.sha1
echo Time= %date% %time%>>%temp%\hash_table.%t%.sha1
sha1sum -r wim_maker >>%temp%\hash_table.%t%.sha1
echo =================Android Firmware Tool %build%===========>>%temp%\hash_table.%t%.sha1
zip a %out%\hash_table.hstab %temp%\hash_table.%t%.sha1 -t7z
echo [%t%]Add Compile Project >>%out%\hstab_chlog.log
sha1sum %out%\hash_table.hstab >>%out%\hstab_chlog.log

del %temp%\hash_table.%t%.sha1
del temp.wim
rmdir /q /s wim_maker
rmdir /q /s %proc%\aft
cd /d %out%
sha1sum hash_table.sha1 >hash_table_check_hash.sha1
exit