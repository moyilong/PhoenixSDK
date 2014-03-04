@echo off
echo Kernel Configure of Linux mconf and old conf
if not exist %proc%\kcfg goto __not_support
cd /d %proc%\kcfg
echo y | copy %user%\user_config.cfg %proc%\kcfg\.config
%kernel%\kconfig\mconf kernel.kcfg
copy .config %user%\config.cfg
goto end





:__not_support
echo ²»¼æÈÝµÄÄÚºË
goto end


:end