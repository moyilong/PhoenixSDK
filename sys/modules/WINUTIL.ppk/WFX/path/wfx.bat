@echo off
call %kernel%\line.bat
cd /d %initdir%
echo 请将下载的Windows ISO镜像挂载...
pause
echo 正在搜寻....
for %%f in (%english%) do if exist %%f:\sources\install.wim echo 发现%%f && set ISO=%%f:&& goto __exit
:__exit
echo 发现目标:%ISO%
echo 是否使用?
set /p YN=[Y/N]
if "%YN%"=="y" goto continue
if "%YN%"=="Y" goto continue
:handle
set /p ISO=请手动指定路径:
if not exist %ISO%\sources\install.wim echo 找不到%ISO%\sources\install.wim!&& goto handle
if not exist %ISO%\sources\sxs echo 找不到%ISO%\sources\sxs!&& goto handle
:continue
if exist install.wim del install.wim
echo 正在导出镜像...
dism /export-image /sourceimagefile:%ISO%\sources\install.wim /sourceindex:1 /destinationimagefile:install.wim
::pause>nul
mkdir %temp%\install
::pause>nul
echo 正在准备修改...
dism /mount-wim /wimfile:install.wim /index:1 /mountdir:%temp%\install
::pause>nul
echo 正在添加驱动...
dism /image:%temp%\install /Add-Driver /Driver:drv /forceunsigned /recurse
::pause>nul
echo 启动NetFX3
dism /image:%temp%\install /Enable-Feature /Featurename:NetFX3 /source:%ISO%\sources\sxs
echo 应用镜像
cd /d %HOT_FIX%
dism /image:%temp%\install /Add-Package /PackagePath:hot_fix
::pause>nul
echo 保存...
dism /unmount-wim /mountdir:%temp%\install /commit
::pause>nul
echo 准备WIMBoot
dism /export-image /sourceimagefile:install.wim /sourceindex:1 /destinationimagefile:install_wimboot.wim
::pause>nul
echo 
del install.wim
ren install_wimboot.wim install.wim
echo 输出:install.wim
echo 操作结束!
pause>nul