@echo off
echo KO Process Tool
call %kernel%\ifdel.bat %userdir%\ko make
call %kernel%\ifdel.bat %temp%\ko make
call %kernel%\ifdel.bat %temp%\tmp make

for %%f in (%path%) do call %kernel%\kernel_out.ko\path_proc.bat "%%f"

