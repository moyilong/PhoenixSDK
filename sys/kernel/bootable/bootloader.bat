@echo off
start /b %1\kernel\bootable\initrd.bat %1 %2 %3 %4 %5 %6 %7 %8 %9
if not "%kernel_stat%"=="exit" call %kernel%\service\exit.bat