mkdir %proc%\wim_maker
mkdir %proc%\wim_maker\boot
mkdir %proc%\wim_maker\recovery
mkdir %proc%\wim_maker\Donor
mkdir %proc%\wim_maker\update_origin
mkdir %proc%\wim_maker\compile_config
echo D | xcopy /e %initdir%\boot %proc%\wim_maker\boot
if exist %initdir%\recovery echo D | xcopy /e %initdir%\recovery %proc%\wim_maker\recovery
if exist %initdir%\Donor echo D | xcopy /e %initdir%\Donor %proc%\wim_maker\Donor
echo D | xcopy /e %devdir% %proc%\wim_maker\compile_config
if exist %initdir%\update\update_cache.zip (
copy %initdir%\update_cache.zip %proc%\wim_maker\update_origin
cd /d %proc%\wim_maker\update_origin
hzip x update_cache.zip
del %proc%\wim_maker\update_origin\update_cache.zip
)
if not exist %intidir%\update\update_cahce.zip if exist %initdir%\update echo D | xcopy /e %initdir%\update %proc%\wim_maker\update_origin
echo 正在生成WIM文件
move %proc%\AFT %proc%\wim_maker\update_final
cd /d %proc%
imagex /capture wim_maker %out%\image_build "AFT Backup Image %build%"