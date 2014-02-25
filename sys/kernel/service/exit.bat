@echo off
echo.
echo.
echo.
echo.
echo            ___         ___                ___
echo          /      /     /   /   /\    /   /          
echo         /----  /     /   /   /  \  /   /----  
echo        /____  /___  /___/   /    \/   /____   inside 2010 - 2014     
echo.     
echo	[内核]	正在退出
doskey ec=call %kernel%\service\set_errorcode.bat
set error_code=0xE00005DB
echo 正在结束进程
echo STATUS_STOP>%proc%\stop.stat
set error_code=0xa0000fff
for %%f in (%feature%) do if exist %appdir%\%%f\data\exit_code.bat call %appdir%\%%f\data\exit_code.bat
for /r %proc%\shutdown_code\ %%f in (*.bat) do call %%f
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