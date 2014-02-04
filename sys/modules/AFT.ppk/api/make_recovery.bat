set b_uuid=%random%%random%%random%
cd /d %initdir%\recovery
if "%sign_mode%"=="internal" java -jar %java_dir%\dumpkey.jar %cert_dir%\%sign_key%.x509.pem >%initdir%\recovery\initrd\res\keys
if "%sign_mode%"=="vendor" java -jar %java_dir%\dumpkey.jar %initdir%\devices\%sign_key%.x509.pem >%initdir%\recovery\initrd\res\keys
set b_uuid=%random%%random%%random%
mkdir %temp%\boot_%b_uuid%
if not exist %initdir%\recovery copy %initdir%\update\recovery.img %1 & goto end
cd /d %initdir%\recovery
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
ren boot.img recovery.img
copy recovery.img %1
cd /d %initdir%
echo  Êä³ö:%1\recovery.img
goto end

:no_ramdisk
cd /d %initdir%\recovery
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
ren boot.img recovery.img
copy recovery.img %1
cd /d %initdir%
echo  Êä³ö:%1\recovery.img
goto end



:end