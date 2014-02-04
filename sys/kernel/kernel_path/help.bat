@echo off
type %kernel%\help.txt >%temp%\temp.txt
if exist %sdkdir%\help.txt type %sdkdir%\help.txt >>%temp%\temp.txt
start notepad %temp%\temp.txt
sleep 5
del %temp%\temp.txt