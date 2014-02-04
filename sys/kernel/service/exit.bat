@echo off
echo.
echo.
echo.
echo.
echo            ___         ___                ___
echo          /      /     /   /   /\    /   /          
echo         /----  /     /   /   /  \  /   /----    Kernel Exit 
echo        /____  /___  /___/   /    \/   /____   inside 2010 - 2013     
echo.     
doskey ec=call %kernel%\service\set_errorcode.bat
set error_code=0xE00005DB
echo 正在结束进程
echo STATUS_STOP>%proc%\stop.stat
sleep 1
set error_code=0xa0000fff
for %%f in (%feature%) do if exist %appdir%\%%f\data\exit_code.bat call %appdir%\%%f\data\exit_code.bat
set error_code=0xE1ff00ff
rmdir /q /s %apidir%
set error_code=0xE1000105
rmdir /q /s %proc%
set error_code=0xEfffffff
doskey exit=
echo Kernel Exit!
                                              

exit
exit
exit
exit
exit