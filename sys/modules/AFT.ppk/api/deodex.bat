@echo off
echo Android Firmware Tool Deodex Tool
echo Useage:call %apidir%\deodex.bat DIR api_level max_memory
echo ����ȷ���ļ��б����Ժ�...
set ddir=%1
set api_level=%2
cd /d %ddir%
if exist %temp%\odex.tmp del %temp%\odex.tmp
if exist %temp%\odex2.tmp del %temp%\odex2.tmp
for /r %%f in (*.apk;*.jar) do call %apidir%\deodex_1.bat %%f >>%temp%\odex.tmp
echo ���ڴ������Ժ�....
for /f %%f in (%temp%\odex.tmp) do call %apidir%\deodex_it.bat "%%f"
:skip_odex
echo Deodex���!