echo ELONE eXtra Packge Kit Initer
set guid=%random%%random%%random%%random%%random%%random%%random%

:: pkg/%support_info%.lzh	��Ϣ�ļ����
:: lzh/info.h			 ���Ʊ�ʶ
:: lzh/cmdline.h		ָ���ǩ
:: lzh/exist.h			 ����
:: lzh/init.bat			����ִ��
:: lzh/shutdown_code.bat	�رմ���
:: lzh/default.h		Ĭ������
::

echo UnCompress
mkdir %temp%\%guid%
copy %appdir%\%1\pkg\%2.lzh %temp%\%guid%\temp.zip
cd /d %temp%\%guid%
zip x temp.zip

call %kernel%\include.bat info.h
echo ��ȡ������:
echo 	������=%return_name%

if not exist %proc%\ver_info mkdir %proc%\ver_info
copy info.h %proc%\ver_info\%1.h

echo ��������..................
if not exist exist.h goto proc_cmd
for /f %%f in (exist.h) do if not exist %appdir%\%%f set support=false echo [EXT]�Ҳ���ģ��:%%f>>%app_log%&& goto __un_support 
:proc_cmd
echo ����ָ�.
if not exist cmdline.h goto gen_proc
for /f %%f in (cmdline.h) do call %kernel%\modules\ins_process.bat %1 %%f

:gen_proc
echo ��ͨ���¼�����.......
if exist %appdir%\%1\api_dir echo D | xcopy /Y /E %appdir%\%1\api %api_dir%
if exist init.bat call init.bat Kernel_Init
if not exist %proc%\shutdown_code mkdir %proc%\shutdown_code
if exist shutdown_code.bat copy shutdown_code.bat %proc%\shutdown_code\%1
if exist APPCFG.kcfg copy APPCFG.kcfg %proc%\kcfg\%return_name%.kcfg
if exist default.h call %kernel%\include.bat default.h
set feature=%feature%;%1
set ext_pkg=%1;%ext_pkg%
echo ���ؽ���!





:__un_support
echo ϵͳ�����ݵİ�
echo ȱ����� 
goto end


:end
set support=
cd /d %initdir%
if exist %temp%\%guid% rmdir /r /q %temp%\%guid%
