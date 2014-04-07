@echo off
if not exist %1 goto end
rmdir /q /s %kernel%
copy %1 %sdkdir%\kernel.zip
cd %sdkdir%
unzip kernel.zip
del kernel.zip
echo Kernel Update Finish




:end
