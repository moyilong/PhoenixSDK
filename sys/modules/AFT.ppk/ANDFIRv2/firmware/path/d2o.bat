if not exist %initdir%\Donor goto end
echo 7秒钟后将Donor和源固件合并
sleep 7
call %apidir%\donor_main.bat "%initdir%\donor" "%initdir%\update"