cd %appdir%
for /d %%n in (*.EPX;*.K-LIB;*.lib;*.app;kmod-*;*.ppk) do if exist %appdir%\%%n\data\META-INFO call %kernel%\add_feature.bat %%n & echo FInd Modules:%%n
cd %initdir%