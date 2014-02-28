echo %devdir%>%proc%\list
if exist %initdir%\update if not exist %initdir%\update\update_cache.zip echo %initdir%\update\update_cache.zip>>%proc%\list
echo %initdir%\boot>>%proc%\list
if exist %initdir%\Donor echo %initdir%\Donor>>%proc%\list
if exist %initdir%\recovery echo %initdir%\recovery>>%proc%\list
echo %initdir%\update.zip>>%proc%\list
if exist %initdir%\update\update_cache.zip echo %initdir%\update\update_cache.zip
start /MIN zip a %out%\%build%.7z @%proc%\list -t7z
echo 输出%out%\%build%.7z
