echo Kernel Add Command %1 %2>%sys_log%
echo Kernel Add Command %1 %2
set iname=%2
if not exist %appdir%\%1\%2\sub_version goto direct_load
set /p t=<%appdir%\%1\%2\sub_version
set iname=%2(%t%)
for %%f in (%t%) do (
if "%HOST_ARCH%"=="x86" if exist %appdir%\%1\%2\%%f\bin32 call %kernel%\add_path.bat %appdir%\%1\%2\%%f\bin32
if "%HOST_ARCH%"=="amd64" if exist %appdir%\%1\%2\%%f\bin64 call %kernel%\add_path.bat %appdir%\%1\%2\%%f\bin64
if exist %appdir%\%1\%2\%%f\path call %kernel%\add_path.bat %appdir%\%1\%2\%%f\path
if exist %appdir%\%1\%2\%%f\init.bat call %appdir%\%1\%2\%%f\init.bat 
)
goto end

:direct_load
if "%HOST_ARCH%"=="x86" if exist %appdir%\%1\%2\bin32 call %kernel%\add_path.bat %appdir%\%1\%2\bin32
if "%HOST_ARCH%"=="amd64" if exist %appdir%\%1\%2\bin64 call %kernel%\add_path.bat %appdir%\%1\%2\bin64
if exist %appdir%\%1\%2\path call %kernel%\add_path.bat %appdir%\%1\%2\path
if exist %appdir%\%1\%2\init.bat call %appdir%\%1\%2\init.bat 
:end
set command=%iname%;%command%
set t=
set iname=