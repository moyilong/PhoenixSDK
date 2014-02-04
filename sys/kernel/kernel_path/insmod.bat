@echo off
if "%1"=="" goto select_installer
set file=%1
:installer_resume

if not exist %file% echo 找不到%1 &set error_code=0xf000A53F& goto select_installer
set uuid=%random%%random%%random%%random%
mkdir %temp%\%uuid%
copy %file% %temp%\%uuid%\APP.zip
cd /d %temp%\%uuid%
zip x APP.zip
if not exist checksum.hash echo 文件不正确! &set error_code=0xf000A540& goto end
zip -h application.zip >temp.hash
fc temp.hash checksum.hash >nul
if not "%errorlevel%"=="0" echo 签名文件不正确-_-! &set error_code=0xf000AA55& goto end













:select_installer
set /p file=请输入安装路径:


goto installer_resume

:end
if not "%uuid%"=="" (
rmdir /q /s %temp%\%uuid%
set uuid=
)
