echo [date][time][built-in-shell][process command] %1>>%sys_log%
for %%f in (%path%) do for %%g in (%pathext%) do (
echo [date][time][built-in-shell][search] %%f\%1%%g
set ffffffff=%%f\%1%%g
if exist %%f\%1 goto process
if exist %%f\%1%%g goto process
)


for %%f in (exit;quite) do (
set return_mode=exit
set return_mode_value=abort
if "%2"=="kernel" set return_mode_value=kernel
goto end
)
for %%f in (dir;cd;) do set ffffffff=%1 && goto process


echo Unknow Command : (

goto end



:process
echo [date][time][built-in-shell][struct value] %ffffffff%>>%sys_log%
%ffffffff% %2 %3 %4 %5 %6 %7 %8 %9
set reuturn_mode_value=normally
set reuturn_mode=normally
goto end

:end