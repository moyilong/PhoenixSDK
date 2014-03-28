@echo off
echo API UseAGE:
echo exec_zipalign.bat app_dir level out_dir
echo 如果level为空，则设置为默认
set rd=%random%%random%%ranom%
if exist %temp%\%rd% rmdir /q /s %temp%\%rd%
mkdir %temp%\%rd%
call %api_dir%\exec_zipalign.bat %initdir%\update\system\app 4 %temp%\%rd%
