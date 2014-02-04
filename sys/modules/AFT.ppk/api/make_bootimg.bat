echo Bootimg Builder
set b_uuid=%random%%random%%random%
mkdir %temp%\boot_%b_uuid%
if not exist %initdir%\boot copy %initdir%\update\boot.img %1 & goto end
cd /d %initdir%\boot
if exist initrd (
mkrootfs initrd >ramdisk.cpio
if exist ramdisk.cpio.gz del ramdisk.cpio.gz
gzip ramdisk.cpio
)
if not exist initrd goto no_ramdisk

copy ramdisk.cpio.gz %temp%\boot_%b_uuid%\
:skip_ramdisk
copy boot.img-zImage %temp%\boot_%b_uuid%
if exist %initdir%\Donor\kernel echo y | copy %initdir%\Donor\kernel %temp%\boot_%b_uuid%\boot.img-zImage
if exist %initdir%\Donor\zImage echo y | copy %initdir%\Donor\zImage %temp%\boot_%b_uuid%\boot.img-zImage
cd /d %temp%\boot_%b_uuid%
%mkbootimg%
copy /y boot.img %1
cd /d %initdir%
rmdir /q /s %temp%\boot_%b_uuid%
echo Êä³ö:%1\boot.img
goto end

:no_ramdisk
cd /d %initdir%\boot
copy boot.img-ramdisk.gz %temp%\boot_%b_uuid%\ramdisk.cpio.gz
copy boot.img-zImage %temp%\boot_%b_uuid%\boot.img-zImage
if exist %initdir%\Donor\kernel echo y | copy %initdir%\Donor\kernel %temp%\boot_%b_uuid%\boot.img-zImage
if exist %initdir%\Donor\zImage echo y | copy %initdir%\Donor\zImage %temp%\boot_%b_uuid%\boot.img-zImage
cd /d %temp%\boot_%b_uuid%

if not "%global_bootimg_mkbootimg%"=="nwaosp" (
ren ramdisk.cpio.gz ramdisk.gz
ren boot.img-zImage kernel
)
%mkbootimg%

copy boot.img %1
cd /d %initdir%
echo Êä³ö:%1\boot.img
goto end



:end