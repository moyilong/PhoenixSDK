@echo off
echo Driver Install Tool
if exist %proc%\drvtmp rmdir /q /s %proc%\drvtmp
mkdir %proc%\drvtmp
for /f %%f in (%drvlist%) do echo Extracting %%f && zip x %%f -O%proc%\drvtmp
copy %kernel%\drv_tool\%HOST_ARCH% %proc%\drvtmp\DPInst.exe
cd /d %proc%\drvtmp
DPInst.exe /SE /C
cd /d %initdir%