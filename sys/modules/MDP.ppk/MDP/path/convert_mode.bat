@echo off
echo convert_mode [pkgname]
echo Convert Package Data Info from ELA to ELX
set od_1=%1
set od_2=%2
if not exist %appdir%\%od_1% echo Not exist !! && goto end
if "%od_1%"=="" echo Unknow Error!! && goto end
if exist %temp%\convert rmdir /q /s %temp%\convert
mkdir %temp%\convert
if exist %appdir%\%od_1%\data\exist.lst type %appdir%\%od_1%\data\exist.lst>%temp%\convert\exist.h
if exist %appdir%\%od_1%\data\init.bat copy %appdir%\%od_1%\data\init.bat %temp%\convert\init.bat
if exist %appdir%\%od_1%\data\exit_code.bat copy %appdir%\%od_1%\data\exit_code.bat %temp%\convert\shutdown_code.bat
if exist %appdir%\%od_1%\data\cmd_list copy %appdir%\%od_1%\data\cmd_list %temp%\convert\cmdline.h
if exist %appdir%\%od_1%\data\default.h copy %appdir%\%od_1%\data\cmd_list %temp%\convert\default.h
call %kernel%\include.bat %appdir%\%od_1%\data\META-INFO
echo return_name=%return_name%>%temp%\convert\info.h
cd /d %temp%\convert
zip a %initdir%\%od_1% *
cd /d %initdir%
rmdir /q /s %temp%\convert
:end