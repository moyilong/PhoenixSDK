if exist %1 if "%debug_info%"=="true" echo [%time%] Copy %1 to %2 >>%sys_log%
if not exist %1 if "%debug_info%"=="true" echo [%time%] Copy %1 to %2 But NOT EXIST >>%sys_log%
if exist %1 copy %1 %2