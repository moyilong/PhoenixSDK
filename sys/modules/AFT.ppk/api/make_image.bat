echo Bootimg Builder
echo Useage: libc make_bootimg [target] [recovery/boot] [--unused-donor-kernel]
if "%2"=="" goto _avg_error
set b_uuid=%random%%random%%random%
mkdir %temp%\boot_%b_uuid%

cd /d %initdir%\%2
if not exist initrd goto no_ramdisk
mkrootfs initrd >ramdisk.cpio
call %kernel%\ifdel.bat ramdisk.cpio.gz
call %kernel%\ifdel.bat ramdisk.cpio.xz
%sign_compress_mode% ramdisk.cpio 
if "%sign_compress_mode%"=="xz" set sign_compress_mode_late=xz
if "%sign_compress_mode%"=="gzip" set sign_compress_mode_late=gz


copy ramdisk.cpio.%sign_compress_mode_late% %temp%\boot_%b_uuid%\
:skip_ramdisk
:no_ramdisk
copy boot.img-zImage %temp%\boot_%b_uuid%
if not "%3"=="--unused-donor-kernel" (
if exist %initdir%\Donor\kernel echo y | copy %initdir%\Donor\kernel %temp%\boot_%b_uuid%\boot.img-zImage
if exist %initdir%\Donor\zImage echo y | copy %initdir%\Donor\zImage %temp%\boot_%b_uuid%\boot.img-zImage
)
cd /d %temp%\boot_%b_uuid%
%mkbootimg%
copy /y boot.img %1
cd /d %initdir%
rmdir /q /s %temp%\boot_%b_uuid%
echo 输出:%1\boot.img
goto end

:no_ramdisk
cd /d %initdir%\%2
copy boot.img-ramdisk%sign_compress_mode_late% %temp%\boot_%b_uuid%\ramdisk.cpio%sign_compress_mode_late%
copy boot.img-zImage %temp%\boot_%b_uuid%\boot.img-zImage
if not "%3"=="--unused-donor-kernel" (
if exist %initdir%\Donor\kernel echo y | copy %initdir%\Donor\kernel %temp%\boot_%b_uuid%\boot.img-zImage
if exist %initdir%\Donor\zImage echo y | copy %initdir%\Donor\zImage %temp%\boot_%b_uuid%\boot.img-zImage
)
cd /d %temp%\boot_%b_uuid%

if not "%global_bootimg_mkbootimg%"=="nwaosp" (
ren ramdisk.cpio%sign_compress_mode_late% ramdisk%sign_compress_mode_late%
ren boot.img-zImage kernel
)
%mkbootimg%

copy boot.img %1
cd /d %initdir%
echo 输出:%1\boot.img
goto end

:_avg_error
echo 参数错误:(
sleep 3
goto end

:end
cd /d %initdir%