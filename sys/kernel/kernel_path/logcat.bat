@echo off
if "%1"=="" set t=%sys_log%
if "%1"=="app" set t=%app_log%
if "%1"=="kernel" set t=%sys_log%
start notepad %t%
set t=