if not "%debug_info%"=="true" if not "%debug%"=="true" cls
echo.
call %kernel%\logo.bat
::cls
call %kernel%\line.bat
call %kernel%\get_version.bat 
call %kernel%\line.bat
::if not "%ni%"=="true" echo set PATH=%PATH% | %def_console%