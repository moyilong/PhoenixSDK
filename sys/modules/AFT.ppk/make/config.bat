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
echo ���ڸ��߳���ղ���ʾ����������:
set /p set_pagesize=BOARD_PAGE_SIZE:
set /p set_base=BOARD_KERNEL_BASE:
set /p set_cmdline=BOARD_KERNEL_CMDLNE:
set /p set_devname=�豸��:
set /p set_dname=��ʾ����:
set /p set_developer=������:
set /p set_arch=оƬ�ܹ�:
set /p set_cf=CPUָ��汾:
set /p set_pmem=�����ڴ��С:
set /p set_nc=����оƬ:
set /p set_os=ϵͳ����:
set /p set_providor=��������:
echo ���Ժ�
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
echo ������Ϣ�������!
set /p sdcard=������SD������:
set /p system=������system����λ��:
set /p data=������data����λ��:
set /p cache=������cache����λ��:
set /p boot=������boot����λ��:
echo ����д���У����Ժ�
echo sdcard=%sdcard%>>%devdir%\info.meta
echo system=%system%>>%devdir%\info.meta
echo cache=%cache%>>%devdir%\info.meta
echo data=%data%>>%devdir%\info.meta
echo boot=%boot%>>%devdir%\info.meta
echo splash=not_define>>%devdir%\info.meta
cd ..
goto end



:pause_ferror
echo ��������ԭ�е������ļ��������!
pause>nul
rmdir /q /s %devdir%
goto resume

:workdir_error
echo �Ҳ�������Ŀ¼!

:end
rmdir work /q /s