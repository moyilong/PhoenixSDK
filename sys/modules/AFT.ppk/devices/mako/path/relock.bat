@echo off
set r=%random%
echo ����"%r%"����Bootloader!
set /p i=
if not "%r%"=="%i%" goto error
echo ������
fastboot oem lock
echo ����
goto end


:error
echo ȷ��ʧ��!
goto end
:end