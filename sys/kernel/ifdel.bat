if exist %1 del %1
if "%debug_info%"=="true" echo [%time%] IFDEL %1 >>%sys_log%
if "%2"=="make" mkdir %1 && echo [%time%] Remake DIR %1>>%sys_log%