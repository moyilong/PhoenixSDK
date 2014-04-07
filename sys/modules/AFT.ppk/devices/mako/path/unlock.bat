@echo off
set r=%random%
echo 输入"%r%"锁定Bootloader!
set /p i=
if not "%r%"=="%i%" goto error
echo 操作中
fastboot oem unlock
echo 结束
goto end


:error
echo 确认失败!
goto end
:end