@echo off
call %kernel%\line.bat
cd /d %initdir%
echo �뽫���ص�Windows ISO�������...
pause
echo ������Ѱ....
for %%f in (%english%) do if exist %%f:\sources\install.wim echo ����%%f && set ISO=%%f:&& goto __exit
:__exit
echo ����Ŀ��:%ISO%
echo �Ƿ�ʹ��?
set /p YN=[Y/N]
if "%YN%"=="y" goto continue
if "%YN%"=="Y" goto continue
:handle
set /p ISO=���ֶ�ָ��·��:
if not exist %ISO%\sources\install.wim echo �Ҳ���%ISO%\sources\install.wim!&& goto handle
if not exist %ISO%\sources\sxs echo �Ҳ���%ISO%\sources\sxs!&& goto handle
:continue
if exist install.wim del install.wim
echo ���ڵ�������...
dism /export-image /sourceimagefile:%ISO%\sources\install.wim /sourceindex:1 /destinationimagefile:install.wim
::pause>nul
mkdir %temp%\install
::pause>nul
echo ����׼���޸�...
dism /mount-wim /wimfile:install.wim /index:1 /mountdir:%temp%\install
::pause>nul
echo �����������...
dism /image:%temp%\install /Add-Driver /Driver:drv /forceunsigned /recurse
::pause>nul
echo ����NetFX3
dism /image:%temp%\install /Enable-Feature /Featurename:NetFX3 /source:%ISO%\sources\sxs
echo Ӧ�þ���
cd /d %HOT_FIX%
dism /image:%temp%\install /Add-Package /PackagePath:hot_fix
::pause>nul
echo ����...
dism /unmount-wim /mountdir:%temp%\install /commit
::pause>nul
echo ׼��WIMBoot
dism /export-image /sourceimagefile:install.wim /sourceindex:1 /destinationimagefile:install_wimboot.wim
::pause>nul
echo 
del install.wim
ren install_wimboot.wim install.wim
echo ���:install.wim
echo ��������!
pause>nul