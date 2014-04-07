@echo off
setlocal
echo Set %1 Workmod:%2
if not exist "%proc%\service\init\%1"  goto end
for %%f in (%srv_workmod%) do if "%2"=="%%f" set work=true
if "%2"=="INIT" goto end
if not "%work%"=="true" goto end
 if exist %proc%\service\WORK\%1 del %proc%\service\WORK\%1
 if exist %proc%\service\DISABLE\%1 del %proc%\service\DISABLE\%1
 echo %1>%proc%\service\%2\%1
 goto end




:end
endlocal