echo ����%name%
if "%skip_kernelcheck%"=="false" echo ��������:%b_time% 
echo �������:%build_id%
echo �汾��:%version%
echo �ں˰汾:%k_version%
if "%skip_kernelcheck%"=="false" echo �ں�����ʱ��:%k_time%
echo ���������:%pkg_Version%
call %kernel%\line.bat
if "%debug_info%"=="false" goto __skip
echo ��ǰ���ú�����:%cores%
echo ��ǰϵͳ�ܹ�:%HOST_ARCH%
echo ��ʼ����:%bios_loader% %bios_version%
echo ָ�:%command%
echo �ں˲���:%cmdline%
echo ��ʱ�ļ�Ŀ¼:%temp%
:__skip
for %%f in (%feature%) do if exist %appdir%\%%f\data\ver_display.bat call %appdir%\%%f\data\ver_display.bat