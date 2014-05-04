echo ELONE eXtra Packge Kit Initer
set guid=%random%%random%%random%%random%%random%%random%%random%

:: pkg/%support_info%.lzh	信息文件打包
:: lzh/info.h			 名称标识
:: lzh/cmdline.h		指令集标签
:: lzh/exist.h			 需求
:: lzh/init.bat			启动执行
:: lzh/shutdown_code.bat	关闭代码
:: lzh/default.h		默认配置
::

echo UnCompress
mkdir %temp%\%guid%
copy %appdir%\%1\pkg\%2.lzh %temp%\%guid%\temp.zip
cd /d %temp%\%guid%
zip x temp.zip

call %kernel%\include.bat info.h
echo 读取包名称:
echo 	包名称=%return_name%

if not exist %proc%\ver_info mkdir %proc%\ver_info
copy info.h %proc%\ver_info\%1.h

echo 处理需求..................
if not exist exist.h goto proc_cmd
for /f %%f in (exist.h) do if not exist %appdir%\%%f set support=false echo [EXT]找不到模块:%%f>>%app_log%&& goto __un_support 
:proc_cmd
echo 处理指令集.
if not exist cmdline.h goto gen_proc
for /f %%f in (cmdline.h) do call %kernel%\modules\ins_process.bat %1 %%f

:gen_proc
echo 普通包事件处理.......
if exist %appdir%\%1\api_dir echo D | xcopy /Y /E %appdir%\%1\api %api_dir%
if exist init.bat call init.bat Kernel_Init
if not exist %proc%\shutdown_code mkdir %proc%\shutdown_code
if exist shutdown_code.bat copy shutdown_code.bat %proc%\shutdown_code\%1
if exist APPCFG.kcfg copy APPCFG.kcfg %proc%\kcfg\%return_name%.kcfg
if exist default.h call %kernel%\include.bat default.h
set feature=%feature%;%1
set ext_pkg=%1;%ext_pkg%
echo 加载结束!





:__un_support
echo 系统不兼容的包
echo 缺少组件 
goto end


:end
set support=
cd /d %initdir%
if exist %temp%\%guid% rmdir /r /q %temp%\%guid%
