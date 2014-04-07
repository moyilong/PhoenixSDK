@echo off
cd /d %initdir%
set s_time=%time%
for %%f in (%feature%) do if exist %appdir%\%%f\make\%1.bat call %appdir%\%%f\make\%1.bat %2 %3 %4 %5
echo 从%s_time%开始，到%time%结束!