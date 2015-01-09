@echo off
if exist %temp%\path_tmp rmdir /q /s %temp%\path_tmp
mkdir %temp%\path_tmp
copy %1 %temp%\path_tmp\path.msu
cd /d %temp%\path_tmp\
zip x  path.msu