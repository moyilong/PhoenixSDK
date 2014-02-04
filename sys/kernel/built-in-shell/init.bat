@echo off
echo Buildin Shell for Phenom Kernel
echo 			Ver 1.0
call %kernel%\line.bat
cd /d %initdir%

:loop_start
set /p input=/[%k_version%]//[%cd%]//
if not "%return_mode%"=="exit" goto end_loop
call %kernel%\built-in-shell\progress.bat %input%
set input=
goto loop_start


:end_loop

if "%return_mode_value%"=="kernel" call %kernel%\service\exit.bat
if "%return_mode_value%"=="abort" goto end

:end
