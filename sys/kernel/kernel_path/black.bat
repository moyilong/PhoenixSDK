@echo off
if not exist %user%\black-list.conf echo --------------ģ�������--------- >%user%\black-list.conf
if "%1"=="edit" goto 
if "%1"=="type" goto type
echo ��Modules���������б༭
echo �÷�:
echo black [����]
echo	type	���
echo    edit	�༭
goto end


:type
cls
type %user%\black-list.conf
echo.
goto end

:edit
notepad %user%\black-list.conf
goto end


:end