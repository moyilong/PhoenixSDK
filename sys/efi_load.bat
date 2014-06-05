@echo off
cd /d %~dp0
if not exist EFI\ (
echo ====================
echo Warring EFI System
echo EFI not found
echo ====================
pause>nul
exit
)
for /f %%f in (EFI\config.efi) do set %%f
choice /C .1 /T 2
if "%errorlevel%"=="1" goto setting


