cd /d %initdir%
echo 即将清除设备数据
echo 3秒内按下Ctrl+C终止
if not "%1"=="force" sleep 3
set delete_dir=boot;update;recovery;%devdir%
for %%f in (%delete_dir%) do echo 删除:%%f && rmdir /q /s %initdir%\%%f