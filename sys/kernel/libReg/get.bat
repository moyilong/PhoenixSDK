@echo off
echo Registry Operation
echo Useage:  libc get.bat "address" "keyname"
if "%1"=="" goto __error
if "%2"=="" goto __error
reg query %1 | find /i "%2"  >%temp%\reg_temp
set /p return_value=<%temp%\reg_temp




:_error
echo ²ÎÊı´íÎó:(
goto end