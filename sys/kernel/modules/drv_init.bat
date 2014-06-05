@echo off
echo Kernel Driver Add : %1 >>%sys_log%
if exist %appdir%\%1\drv_inst\list.drv goto drv_list_load

::Direct Load
if exist %appdir%\%1\drv_inst\drv_64.zip if "%HOST_ARCH%"=="amd64" echo %appdir%\%1\drv_inst\drv_64.zip >>%drvlist%
if exist %appdir%\%1\drv_inst\drv.zip echo %appdir%\%1\drv_inst\drv.zip>>%drvlist%
if exist %appdir%\%1\drv_inst\drv_32.zip if "%HOST_ARCH%"=="x86" echo %appdir%\%1\drv_inst\drv_32.zip>>%drvlist%

goto end

:drv_list_load

for /f %%f in (%appdir%\%1\drv_inst\list.drv) do if exist %appdir%\%1\drv_inst\%%f (

if exist %appdir%\%1\drv_inst\%1\drv_64.zip if "%HOST_ARCH%"=="amd64" echo %appdir%\%1\drv_inst\%1\drv_64.zip>>%drvlist%
if exist %appdir%\%1\drv_inst\%1\drv.zip echo %appdir%\%1\drv_inst\%1\drv.zip>>%drvlist%
if exist %appdir%\%1\drv_inst\%1\drv_32.zip if "%HOST_ARCH%"=="x86" echo %%appdir%\%1\drv_inst\%1\drv_32.zip>>%drvlist%


)
:end