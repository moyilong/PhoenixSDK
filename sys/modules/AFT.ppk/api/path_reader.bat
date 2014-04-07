set fil=not_exist
if exist %appdir%\AFT.ppk\send\%1.snd set /p fil=<%appdir%\AFT.ppk\send\%1.snd

if exist %devdir%\send\%1.snd set /p fil=<%devdir%\send\%1.snd





if exist %initdir%\update\system\priv-app if exist %appdir%\AFT.ppk\send\%1.snd##kitkat set /p fil=<%appdir%\AFT.ppk\send\%1.snd##kitkat
if exist %initdir%\update\system\priv-app if exist %devdir%\send\%1.snd set /p fil=<%devdir%\send\%1.snd

