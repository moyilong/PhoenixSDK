@echo off
echo Android Firmware Unpacker
if not "%1"=="" (
copy %1 update.zip
)
cd /d %initdir%
if not exist update.zip goto error_update
if exist update goto exist
:resume
mkdir update
mkdir boot
zip x -y -o%initdir%\update update.zip
copy %initdir%\update\boot.img %initdir%\boot\
cd /d %initdir%\boot
call %apidir%\unpackbootimg.bat

cd %initdir%

cd update
cd META-INF
del CERT.RSA
del CERT.SF
del MANIFEST.MF
cd com
rmdir /q /s android

cd /d %initdir%
echo ������!
goto end





:exist
echo �Ѿ�����update�������������Щ�ļ�!
set /p yn=[y/N]:
if "%yn%"=="y"  goto continue
if "%yn%"=="Y"  goto continue
if "%yn%"=="n" goto continue
if "%yn%"=="N" goto continue
goto exist
:continue
if "%yn%"=="n" goto end
if "%yn%"=="N" goto end
echo ��������ļ�...
call %api_dir%\clean.bat force
cd /d %initdir%
goto resume






:error_update
echo �Ҳ��� Update.zip
goto end


:end