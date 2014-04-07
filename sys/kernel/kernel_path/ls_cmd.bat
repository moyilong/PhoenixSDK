@echo off
call %kernel%\line.bat
if exist %proc%\cmd_list del %proc%\cmd_list
for %%f in (%path%) do (
cd /d %%f 
for %%c in (%pathext%) do dir /b *%%c >>%proc%\cmd_list
)
cd /d %initdir%
notepad %proc%\cmd_list