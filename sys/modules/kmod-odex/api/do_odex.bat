@echo off
if not exist %initdir%\dex2opt mkdir %initdir%\dex2opt
if not exist %initdir%\dex2opt\hash_table mkdir %initdir%\odex2opt\hash_table
if not exist %initdir%\dex2opt\cache mkdir %initdir%\odex2opt\cache
echo Android Odex Main Script
call %kernel%\line
echo Useage:
echo set odex_tree=[odex floders] 
call %kernel%\line
for %%f in (%odex_tree%) do call %apidir%\sub_odex.bat %%f