echo BOOTIMG解包工具
unpackbootimg -i boot.img
mkdir initrd
move boot.img-ramdisk.gz initrd
cd initrd 
gzip -d -c boot.img-ramdisk.gz | cpio -i
sleep 2
del boot.img-ramdisk.gz