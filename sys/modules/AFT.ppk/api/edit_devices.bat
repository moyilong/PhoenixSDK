if not exist %devdir% goto not_exist
start explorer %devdir%
start notepad %devdir%\info.meta
start notepad %devdir%\dev_cmdline
goto end

:not_exist
echo ’“≤ªµΩdevices
:end