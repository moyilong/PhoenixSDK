@echo off
echo �����������...
if "%otr%"=="true" set error_code=0xf000AAAA &&goto error
if exist %initdir%\%name%_%version%_%build%_%k_version%.exe del %initdir%\%name%_%version%_%build%_%k_version%.exe
zip a -mx9 -md64m -mfb273 -ssw -slp -sfx%kernel%\Sfx\7z.sfx "%initdir%\%name%_%version%_%build%_%k_version%.exe"   %initdir% 
echo ����CRC32
cd /d %initdir%
crc32sum "%name%_%version%_%build%_%k_version%.exe" >"%initdir%\%name%_%version%_%build%_%k_version%.crc32.txt"
echo  ���:%initdir%\%name%_%version%_%build%_%k_version%.exe
echo  ���:%initdir%\%name%_%version%_%build%_%k_version%.checksum.txt
goto end

:error
echo �ڷ���ģʽ�²�����ʹ�ô�����!
:end