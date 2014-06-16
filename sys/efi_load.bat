@echo off
cd /d %~dp0
set loaddir=kernel
set EFI_VERSION=1.0.0-Prebuilt
:init
if not exist EFI\ (
echo ====================
echo Warring EFI System
echo EFI not found
echo ====================
pause>nul
exit
)
if not exist EFI\config.efi goto setting
for /f %%f in (EFI\config.efi) do set %%f
choice /C .1 /T 2
if "%errorlevel%"=="." goto setting


:setting
copy EFI\setting.efi %temp%\efi_load.bat
call %temp%\efi_load.bat
if "%return%"=="__reset_init" goto init
if "%return%"=="__exit" exit
if "%return%"=="__init_load" goto init_load
echo Warring EFI Return:%return%
pause>nul
exit


:init_load
for /f %loaddir% %%f in (*.efi) do echo %%f>>%temp%\load_list.list && echo Find EFI:%%f
if "%%"



