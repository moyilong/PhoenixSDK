set kernel_mode_string=
if "%secure_mode%"=="enable" set kernel_mode_string=��ȫģʽ
if "%not_path_mode%"=="true" set kernel_mode_string=�������������� %kernel_mode_string%
if "%skip_kernelcheck%"=="true" set load_string=[����]��ȫ��֤������
echo            ___         ___                ___
echo          /      /     /   /   /\    /   /          %name%
echo         /----  /     /   /   /  \  /   /----       %load_string%
echo        /____  /___  /___/   /    \/   /____        %k_string% %string_later%
echo.                                                   %kernel_mode_string%
echo               %version% Build %build_id% at %k_version%