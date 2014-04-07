echo 关于%name%
if "%skip_kernelcheck%"=="false" echo 生成日期:%b_time% 
echo 开发编号:%build_id%
echo 版本号:%version%
echo 内核版本:%k_version%
if "%skip_kernelcheck%"=="false" echo 内核生成时间:%k_time%
echo 程序包调度:%pkg_Version%
call %kernel%\line.bat
if "%debug_info%"=="false" goto __skip
echo 当前调用核心数:%cores%
echo 当前系统架构:%HOST_ARCH%
echo 初始程序:%bios_loader% %bios_version%
echo 指令集:%command%
echo 内核参数:%cmdline%
echo 临时文件目录:%temp%
:__skip
for %%f in (%feature%) do if exist %appdir%\%%f\data\ver_display.bat call %appdir%\%%f\data\ver_display.bat