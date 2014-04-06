sha1sum %2 >%temp%\tmp_hash
fc %temp%\tmp_hash %initdir%\dex2opt\hash_table\%2.hstab
if not "%error_level%"=="1" goto compile_load
set t=%2
copy %initdir%\dex2opt\cache\%t:~0,-4%.odex %cd%
zip d %2 classes.dex
set t=
goto end

:compile_load
call %apidir%\compile_odex_load.bat %1 %2
goto end



:end