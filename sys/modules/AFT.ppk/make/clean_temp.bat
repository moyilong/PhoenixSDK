@echo off
echo ɾ����ʱ�ļ�
rmdir /q /s temp
cd /d %temp%
for /d %%f in (ELCC_AFT_TEMP_*) do rmdir /q /s %%f