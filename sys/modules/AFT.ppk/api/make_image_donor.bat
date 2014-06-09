@echo off
echo Donor Boot Image Maker
echo USEAGE:libc make_image_donor TARGET [BOOT/RECOVERY] [--unsed-donor-kernel]

echo Check WGET Kernel and Relace DonorKernel
if not exist %donor%\ftp_get_zimage goto direct_get
set /p url=<%donor%\ftp_get_zimage
if exist %donor%\zImage del %donor%\zImage
wget %url%
move zImage %donor%\zImage
echo SHA1SUM About %url%
sha1sum %donor%\zImage

:direct_get

if "%1"=="" goto _avg_error
if "%2"=="" goto _avg_error
if "%sign_compress_mode%"=="xz" set sign_compress_mode_late=.xz
if "%sign_compress_mode%"=="gzip" set sign_compress_mode_late=.gz
set origin=%intidir%\%2

if exist %initdir%\%2 goto direct_make

if exist %initdir%\update\update_cache(
if exist %temp%\bootimg rmdir /q /s %temp%\bootimg
mkdir %temp%\bootimg
cd /d %temp%\bootimg
zip e %initdir%\update\update_cache.zip boot.img
)
if exist %initdir%\update\boot.img copy %initdir%\update\boot.img .
call %apidir%\unpackbootimg.bat
set origin=%temp%\bootimg
goto make


:direct_make
echo D | xcopy /e %origin% %temp%\bootimg
set origin=%temp%\bootimg
goto make

:make

cd /d %origin%
if exist ramdisk.cpio.gz del ramdisk.cpio.gz
if exist ramdisk.cpio.xz del ramdisk.cpio.xz
if not exist initrd goto no_ramdisk
mkrootfs initrd >ramdisk.cpio
%sign_compress_mode% ramdisk.cpio 
if not "%3"=="--unused-donor-kernel" (
if exist %intidir%\Donor\kernel echo y | copy %intidir%\Donor\kernel .\boot.img-zImage
if exist %intidir%\Donor\zImage echo y | copy %intidir%\Donor\zImage .\boot.img-zImage
)
%makebootimg%
copy boot.img %1
echo 输出:%1
goto end



:_avg_error
echo [参数错误]
goto end

:end