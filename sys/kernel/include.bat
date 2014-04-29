if not exist %1 goto error
for /f "delims=#" %%f in (%1) do set %%f
goto end
:error
if "%2"=="nf" goto end
set error_code=0xf000153B
echo  ÕÒ²»µ½%1
pause>nul
:end