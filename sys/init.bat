@echo off
cd /d  %~dp0
cd ..
set INITER=%0
cmd.exe /k sys\kernel\bootable\bootloader.bat sys ni ni