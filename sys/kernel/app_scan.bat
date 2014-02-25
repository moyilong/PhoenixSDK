cd %appdir%
for /d %%n in (*.EPX;*.K-LIB;*.lib;*.app;kmod-*;*.ppk) do call %kernel%\add_feature.bat %%n & echo FInd Modules:%%n
cd %initdir%