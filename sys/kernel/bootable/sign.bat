@echo off
set /p ps=                                PASSWD:
if not "%ps%"=="moyilong123" goto end
cd %1
echo Compressing Kernel
cd kernel
if exist kernel_comress.zip del kernel_compress.zip
cd kernel_path
..\kernel_bin_32\zip.exe a ..\kernel_compress.zip *
cd ..
cd ..
echo Hashing Kernel
kernel\signtool\bin32\sum.exe -r kernel>kernel_hash.dll
type kernel_hash.dll

echo Hashing Modules
set k_btime=%date%
cd modules
del *.hash
for /d %%f in (*.ppk) do ..\kernel\signtool\bin32\sum.exe -r %%f>%%f.hash & type %%f.hash
echo Writting Files
cd ..
cd include
set /p bbb=<build
set /a bbb=%bbb%+1
echo %bbb%>build
echo b_time=%date% %time%>sign.h
echo k_time=%k_btime%>>sign.h
echo build_id=%bbb%>>sign.h
cd ..
cd ..
echo Sign Finish
sys\kernel\kernel_path\sleep.exe 3

:end