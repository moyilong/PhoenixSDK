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
sum application.zip >temp.hash
fc temp.hash checksum.hash >nul
if not "%errorlevel%"=="0" echo 签名文件不正确-_-! &set error_code=0xf000AA55& goto end
echo 正在安装模块，请稍候............
call %kernel%\include info.h
echo Name=%return_name%
echo Version=%return_version%
for %%f in (%return_exist%) do if not exist %appdir%\%%f goto _exist_error
if exist %appdir%\%return_name%  goto _have_error
mkdir %appdir%\%return_name%
copy application.zip %appdir%\%return_name%\app.zip
cd /d %appdir%\%return_name%\app.zip
zip x app.zip
cd /d %initdir%
echo 加载模块中........
call %kernel%\init_app %return_name%
cd /d %appdir%
sum -r %return_name% > %return_name%.hash
cd /d %initdir%
echo 结束
goto end





:_have_error
echo 模块已经存在....
goto end






:_exist_error
echo 兼容检查失败......
goto end

:select_installer
set /p file=请输入安装路径:


goto installer_resume

:end
cd /d %initdir%
if not "%uuid%"=="" (
rmdir /q /s %temp%\%uuid%
set uuid=
)
