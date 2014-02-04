@echo off
cd /d %appdir%
if not exist %1 goto end
sum -r %1 >%1.hash
sum -r %1
:end