set dev_dir=%userdir%\devices
set devdir=%dev_dir%
set out=%initdir%\out
set dev_lib=%appdir%\AFT.ppk\devices
set aft_log=%log%\AndroidFirmwareTool.log
set cert_dir=%appdir%\AFT.ppk\cert
set donor_api_ver=4.0;3.5;3.0
set vendor_ver=6.0

if exist %initdir%\devices\path set path=%path%;%initdir%\devices\path
call %appdir%\AFT.ppk\api\devices_read.bat
taskkill /f /t /im tadb.exe
set bs=%provider% for %device% with %m_os% at %m_cf% signed key %sign_key% buid with %k_version%
