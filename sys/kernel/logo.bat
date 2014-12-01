set kernel_mode_string=
if "%secure_mode%"=="enable" set kernel_mode_string=安全模式
if "%not_path_mode%"=="true" set kernel_mode_string=不允许运行命令 %kernel_mode_string%
if "%skip_kernelcheck%"=="true" set load_string=[警告]安全验证被禁用
echo            ___         ___                ___
echo          /      /     /   /   /\    /   /          %name%
echo         /----  /     /   /   /  \  /   /----       %load_string%
echo        /____  /___  /___/   /    \/   /____        %k_string% %string_later%
echo.                                                   %kernel_mode_string%
echo           tbHO0rHks8nO0tb3xsGx2ta9tcTKsbryo6zE48rHt/G7ubvh1Nq69c7S
echo               %version% Build %build_id% at %k_version%
call %kernel%\line.bat
