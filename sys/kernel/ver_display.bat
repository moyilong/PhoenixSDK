for %%f in (%ppk_pkg%) do if "%1"=="%%f" call %kernel%\include %appdir%\%1\data\META-INFO && goto ver_display
for %%f in (%ext_pkg%) do if "%1"=="%%f" call %kernel%\include %proc%\ver_info\%1.h && goto ver_display
goto end

:ver_display

echo  %1				%return_name%

:end