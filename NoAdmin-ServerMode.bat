@echo off
set bios_loader=EPSDK-SRVMGMT
set bios_version=R1
cd /d  %~dp0
call sys\kernel\bootable\init.bat sys sm cl tl 
echo Starting Server
set debug_info=true
set clean_www=false
set server_initdir=%initdir%
set www=%server_initdir%\www
call %kernel%\include.bat %sdkdir%\include\server_configure.h
for %%f in (%server_initdir%;%server_initdir%\task;%server_initdir%\task\tm;%www%;%www%\sha_tbl) do if not exist %%f mkdir %%f
for %%f in (%feature%) do if exist %appdir%\%%f\www call %kernel%\init_www.bat %%f
for %%f in (%feature%) do if exist %appdir%\%%f\server_init.bat start /MIN %appdir%\%%f\server_init.bat __SERVER_INIT__


start cmd.exe
:loop

set tm=%time::=_%
set tm=%tm:~0,-3%
set dt=%date:/=_%
set dt=%dt:~0,-3%
echo Local Time:%dt%  %tm%
if exist %server_dir%\task\%dt%\%tm%.bat call %server_dir%\task\%dt%\%tm%.bat
if exist %server_dir%\task\tm\%tm%.bat call %server_dir%\task\tm\%tm%.bat





sleep 1

goto loop