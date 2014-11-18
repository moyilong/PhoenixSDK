if not "%error_code%"=="0xB02F9D3A" goto end
echo.
echo.
echo.
echo            ELONE Extenison Firmware Interface
msleep 300
echo            ___         ___                ___
msleep 300
echo          /      /     /   /   /\    /   /     
msleep 300
echo         /----  /     /   /   /  \  /   /----  
msleep 300
echo        /____  /___  /___/   /    \/   /____   
msleep 300
echo.          
if not "%USE_EFI_LOADER%"=="true" echo Use Leagcy Loader! && goto end
echo %date% %time% EFI System Inited! >>%sys_log%

set USE_APX_COLLECT=true
set APX_COLLECT_DIR=%proc%\APX_COLLECT
set APX_DIR=%APX_COLLECT_DIR%
set APXDIR=%APX_COLLECT_DIR%
mkdir %APX_COLLECT_DIR%

echo ELONE EFI Loader
echo DragonHert Project Combined
echo Alloc dllSemphella / libSemphella
echo Semphella ArgProcess Support
vecho \v\n
cd /d %kernel% 
for /r %%f in (*.APX,*.apd) do  copy %%f %APX_COLLECT_DIR%\




echo %date% %time% EFI System Init Over! >>%sys_log%


:end
msleep 500
