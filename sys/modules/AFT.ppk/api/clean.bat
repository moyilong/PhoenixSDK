cd /d %initdir%
echo ��������豸����
echo 3���ڰ���Ctrl+C��ֹ
if not "%1"=="force" sleep 3
set delete_dir=boot;update;recovery;%devdir%
for %%f in (%delete_dir%) do echo ɾ��:%%f && rmdir /q /s %initdir%\%%f