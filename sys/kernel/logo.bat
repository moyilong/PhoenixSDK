set kernel_mode_string=
if "%secure_mode%"=="enable" set kernel_mode_string=��ȫģʽ
if "%not_path_mode%"=="true" set kernel_mode_string=�������������� %kernel_mode_string%
if "%skip_kernelcheck%"=="true" set load_string=[����]��ȫģ�鱻����
echo            ___         ___                ___
echo          /      /     /   /   /\    /   /          %name% %version% Build %build_id%
echo         /----  /     /   /   /  \  /   /----       %load_string%
echo        /____  /___  /___/   /    \/   /____        %k_string% %string_later%
echo.                                                   %kernel_mode_string%
