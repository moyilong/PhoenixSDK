echo Android Firmware Tools
echo Firmware Donor Replace
echo Useage:
echo libc donor_main [target]
cd /d %initdir%\Donor
echo     ����ϲ���Ŀ
for /d %%f in (*) do if not exist %%f\__skip echo D | xcopy /e /Y %%f %1\system >>%app_log%
if not exist del.list goto __skip_file
title Android Firmware Tools zImage Maker [Donor Remove]
echo     ����ɾ����Ŀ/�ļ�
for /f %%f in (del.list) do echo ɾ��:%1\%%f && call %kernel%\ifdel.bat %1\%%f
:__skip_file
if not exist rmdir.list goto __skip_dir
echo	����ɾ����Ŀ/Ŀ¼
for /f %%f in (rmdir.list) do rmdir /q /s %1\%%f
title Android Firmware Tools zImage Maker [Donor Other]
:__skip_dir
echo ���ڴ��������ļ�
if exist build.prop copy build.prop %1\system\build.prop >>%app_log%
if exist build_extend.prop (
type build_extend.prop>%1\system\build.prop
type build.prop>>%1\system\build.prop
)
echo �ϳɽ���
cd /d %initdir%