@echo off
echo Exporting Kernel
cd /d %initdir%
zip a kernel.zip %kernel%
