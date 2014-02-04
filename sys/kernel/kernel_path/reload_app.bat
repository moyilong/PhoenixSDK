@echo off
set feature=
call %kernel%\app_scan.bat

call %kernel%\app_loader.bat