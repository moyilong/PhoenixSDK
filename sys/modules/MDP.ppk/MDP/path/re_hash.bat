@echo off
set /p ps=                                PASSWD:
if not "%ps%"=="moyilong123" goto end
cd sys
echo Hashing Kernel
kernel\signtool\bin32\sum.exe -r kernel>kernel_hash.dll
echo Hashing Modules
set k_btime=%date%
cd modules
del *.hash
for /d %%f in (*.ppk) do ..\kernel\signtool\bin32\sum.exe -r %%f>%%f.hash
for /d %%f in (*.ppk) do ..\kernel\signtool\bin32\sum.exe -r %%f

sys\kernel\kernel_path\sleep.exe 3

:end