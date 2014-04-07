@echo off
if not exist %user%\black-list.conf echo --------------模块黑名单--------- >%user%\black-list.conf
if "%1"=="edit" goto 
if "%1"=="type" goto type
echo 对Modules黑名单进行编辑
echo 用法:
echo black [命令]
echo	type	浏览
echo    edit	编辑
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