if not exist %1.odex goto end
if exist %1.apk goto odex
if exist %1.jar goto odex

goto end

:odex
echo ��ȡ�ļ�:%1.odex
echo ��ȡ�ļ�:%1.apk
echo ������%1.odex
java  -jar %java_dir%\baksmali.jar -a %api_level% -d %initdir%\update\system\framework -x %1.odex
echo ����%1
java  -jar %java_dir%\smali.jar -a %api_level% -o classes.dex out
echo �ϲ��ļ���
if exist %1.apk zip a %1.apk  classes.dex -tzip
if exist %1.jar zip a %1.jar  classes.dex -tzip
echo ��������
rmdir /q /s out
del classes.dex
del %1.odex


:end