mkdir %proc%\wim_maker
mkdir %proc%\wim_maker\boot
mkdir %proc%\wim_maker\recovery
mkdir %proc%\wim_maker\Donor
mkdir %proc%\wim_maker\compile_config
echo D | xcopy /e %initdir%\boot %proc%\wim_maker\boot
if exist %initdir%\recovery echo D | xcopy /e %initdir%\recovery %proc%\wim_maker\recovery
if exist %initdir%\Donor echo D | xcopy /e %initdir%\Donor %proc%\wim_maker\Donor
echo D | xcopy /e %devdir% %proc%\wim_maker\compile_config
echo ��������WIM�ļ�
move %proc%\AFT %proc%\wim_maker\update_final
cd /d %proc%
imagex /capture wim_maker temp.wim "AFT Backup Image %build%"
imagex /export temp.wim 1 %out%\image_build.wim "AFT Backup Image %build%"
del temp.wim
rmdir /q /s wim_maker
exit