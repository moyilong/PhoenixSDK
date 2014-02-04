echo ZIPALIGN优化API
echo 正在确定文件列表
set dir=%1
cd /d %dir%
dir *.apk /b > %temp%\flist
echo 将%1优化到%3   优化等级:%2
if exist %3 rmdir /q /s %3
mkdir %3
if "%global_zipalign_skip%"=="true" goto skip
for /f %%f in (%temp%\flist) do echo 正在优化:%%f && start /b zipalign -f %2 %1\%%f %3\%%f
goto end
:skip
for /f %%f in (%temp%\flist) do copy %1\%%f %3\%%f
goto end
:end