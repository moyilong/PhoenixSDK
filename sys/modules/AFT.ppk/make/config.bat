@echo off
cd /d %intidir%
if exist %devdir%\info.meta goto pause_ferror
if exist %intidir%\devices rmdir /q /s %devdir%
if exist %temp%\work rmdir /q /s %temp%\work
:resume
cls
if not exist update goto workdir_error
cls
mkdir %temp%\work
copy update\boot.img %temp%\work\
cd /d %temp%\work
echo =====================================
unpackbootimg.exe -i boot.img
echo =====================================
echo 现在告诉程序刚才显示出来的数据:
set /p set_pagesize=BOARD_PAGE_SIZE:
set /p set_base=BOARD_KERNEL_BASE:
set /p set_cmdline=BOARD_KERNEL_CMDLNE:
set /p set_devname=设备名:
set /p set_dname=显示名称:
set /p set_developer=开发者:
set /p set_arch=芯片架构:
set /p set_cf=CPU指令集版本:
set /p set_pmem=物理内存大小:
set /p set_nc=网卡芯片:
set /p set_os=系统类型:
set /p set_providor=开发代号:
echo 请稍候
cd ..
if not exist %intidir%\devices mkdir %devdir%
echo "mkbootimg --kernel boot.img-zImage --ramdisk ramdisk.cpio.gz --cmdline '%set_cmdline%' --pagesize %set_pagesize% --base %set_base% -o boot.img" >%devdir%\info.meta
echo devices=%set_dname%>%devdir%\info.meta
echo vendor_version=5.2>>%devdir%\info.meta
echo sign_file=true>>%devdir%\info.meta
echo sign_key=testkey>>%devdir%\info.meta
echo skip_backup=false>>%devdir%\info.meta
echo provier=%set_provider%>>%devdir%\info.meta
echo developer=%set_developer%>>%devdir%\info.meta
echo m_arch=%set_arch%>>%devdir%\info.meta
echo m_cf=%set_cf%>>%devdir%\info.meta
echo m_peme=%set_peme%>>%devdir%\info.meta
echo m_nc=%set_nc%>>%devdir%\info.meta
echo m_os=%set_os%>>%devdir%\info.meta
echo out=%initdir%\out>>%devdir%\info.meta
echo 初级信息设置完毕!
set /p sdcard=请输入SD卡分区:
set /p system=请输入system分区位置:
set /p data=请输入data分区位置:
set /p cache=请输入cache分区位置:
set /p boot=请输入boot分区位置:
echo 正在写入中，请稍后
echo sdcard=%sdcard%>>%devdir%\info.meta
echo system=%system%>>%devdir%\info.meta
echo cache=%cache%>>%devdir%\info.meta
echo data=%data%>>%devdir%\info.meta
echo boot=%boot%>>%devdir%\info.meta
echo splash=not_define>>%devdir%\info.meta
cd ..
goto end



:pause_ferror
echo 继续，您原有的配置文件将被清除!
pause>nul
rmdir /q /s %devdir%
goto resume

:workdir_error
echo 找不到工作目录!

:end
rmdir work /q /s