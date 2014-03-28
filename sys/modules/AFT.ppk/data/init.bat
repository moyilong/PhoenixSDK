set dev_dir=%userdir%\devices
set devdir=%dev_dir%
set out=%initdir%\out
set dev_lib=%appdir%\AFT.ppk\devices
set aft_log=%log%\AndroidFirmwareTool.log
set cert_dir=%appdir%\AFT.ppk\cert
set donor_api_ver=4.0;3.5;3.0
set vendor_ver=6.0;6.1;6.2

if exist %initdir%\devices\path set path=%path%;%initdir%\devices\path
call %appdir%\AFT.ppk\api\devices_read.bat
taskkill /f /t /im tadb.exe
set bs=%provider% for %device% with %m_os% at %m_cf% signed key %sign_key% buid with %k_version%

::start %appdir%\AFT.ppk\dialog\dev_list.bat %proc%
echo finding outdir
if not "%outmode%"=="id" goto end
if "%outmode%"=="id" if "%id%"=="" echo Error:Define ID Mode ,not Define ID!>>%app_log% && goto end
if "%outmode%"=="id" if "%id_name%"=="" echo Error:Define ID Mode ,not Define ID_Name!>>%app_log% && goto end
for %%f in (%englist%) do if exist %%f\%id_name%\%id%.idf set out=%%f\%id_name%
