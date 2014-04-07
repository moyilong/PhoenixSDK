@echo off
sha1sum %2>%initdir%\hash_table\%2.hstab
set t=%2
set t=%t:~0,-4%
dexopt-wrapper %t%.apk %initdir%\cache\%t%.odex
copy %initdir%\dex2opt\cache\%t:~0,-4%.odex %cd%
zip d %2 classes.dex
set t=

