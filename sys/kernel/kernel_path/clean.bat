@echo off
cd /d %proc%
cd ..
for /d %%f in (PROC_*) do if not "%%f"=="%proc_name%" rmdir /q /s %%f && echo ɾ��:%%f
cd /d %initdir%