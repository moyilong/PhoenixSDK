@echo off
echo ELSUM Creater 
echo libc [-r] origin output
if "%1"=="-r"(
 set r=y
 set origin=%2
 set output=%3
 ) else (
 set origin=%1
 set output=%2
 set r=n
 )

