echo ZIPALIGN�Ż�API
echo ����ȷ���ļ��б�
set dir=%1
cd /d %dir%
dir *.apk /b > %temp%\flist
echo ��%1�Ż���%3   �Ż��ȼ�:%2
if exist %3 rmdir /q /s %3
mkdir %3
if "%global_zipalign_skip%"=="true" goto skip
for /f %%f in (%temp%\flist) do echo �����Ż�:%%f && start /b zipalign -f %2 %1\%%f %3\%%f
goto end
:skip
for /f %%f in (%temp%\flist) do copy %1\%%f %3\%%f
goto end
:end