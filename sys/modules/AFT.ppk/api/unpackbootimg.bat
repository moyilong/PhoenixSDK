echo BOOTIMG解包工具
unpackbootimg -i boot.img
mkdir initrd
move boot.img-ramdisk.gz initrd
cd initrd 
if "%sign_decompress_mode%"=="gzip" gzip -d -c boot.img-ramdisk.gz | cpio -i
if "%sign_decompress_mode%"=="xz" (
ren boot.img-ramdisk.gz boot.img-ramdisk.xz
xz -d -c boot.img-ramdisk.gz | cpio -i
)

sleep 2
del boot.img-ramdisk.gz
cd ..