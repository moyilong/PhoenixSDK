@echo off
echo Init Web Page 
if not exist %www%\sha_tbl\%%f.shtab goto copy
cd /d %appdir%\%1\www
sha1sum * > %temp%\shatmp.ttt
fc %temp%\shatmp.ttt %www%\sha_tbl\%%f.shtab
if not "%errorlevel%"=="0"(
if not exist %appdir%\%1\data\www_get_mklink  goto copy
if exist %appdir%\%1\data\www_get_mklink  goto mklink

)
goto end




:copy
echo Y | copy %temp%\shatmp.ttt %www%\sha_tbl\%%f.shtab
echo Y | echo D | xcopy /e %appdir%\%1\www %www%
goto end

:mklink
echo Y | copy %temp%\shatmp.ttt %www%\sha_tbl\%%f.shtab
call %kernel%\include.bat %appdir%\%1\data\www_get_mklink






goto end
:end