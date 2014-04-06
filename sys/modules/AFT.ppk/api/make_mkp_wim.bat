mkdir %proc%\wim_maker
mkdir %proc%\wim_maker\boot
mkdir %proc%\wim_maker\recovery
mkdir %proc%\wim_maker\Donor
mkdir %proc%\wim_maker\compile_config
if exist %initdir%\Dex2Opt (
mkdir %proc%\wim_maker\Dex2Opt
echo D | xcopy /e %initdir%\dex2opt %proc%\wim_maker\Dex2Opt
)
echo D | xcopy /e %initdir%\boot %proc%\wim_maker\boot
if exist %initdir%\recovery echo D | xcopy /e %initdir%\recovery %proc%\wim_maker\recovery
if exist %initdir%\Donor echo D | xcopy /e %initdir%\Donor %proc%\wim_maker\Donor
echo D | xcopy /e %devdir% %proc%\wim_maker\compile_config
echo 正在生成WIM文件
move %proc%\AFT %proc%\wim_maker\update_final
cd /d %proc%
imagex /capture wim_maker temp.wim "AFT Backup Image %build%" /COMPRESS %wim_compress%
imagex /export temp.wim 1 %out%\image_build.wim "AFT Backup Image %build%"
echo =================Android Firmware Tool %build%===========>>%out%\hash_table.sha1
echo Build ID %build% at %date% %time%>>%out%\hash_table.sha1
echo Build Script=%bs%
sha1sum -r wim_maker >>%out%\hash_table.sha1
echo =================Android Firmware Tool %build%===========>>%out%\hash_table.sha1
del temp.wim
rmdir /q /s wim_maker
cd /d %out%
sha1sum hash_table.sha1 >hash_table_check_hash.sha1
exit