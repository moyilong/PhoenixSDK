set java_dir=%appdir%\JLIB.ppk\jar
if not exist %sdkdir%\java_ext goto end
if exist %temp%\JEXT rmdir /q /s %temp%\JEXT
mkdir %temp%\JEXT
copy %sdkdir%\java_ext\*.jar %temp%\JEXT\
copy %java_dir%\*.jar %temp%\JEXT\
set java_dir=%temp%\JEXT
:end
echo Checking Java
echo Checking JavaEnv:%JAVA_HOME%
if not "%JAVA_HOME%"=="" set path=%PATH%;%JAVA_HOME%\bin && echo ʹ��JAVA_HOME�趨:%JAVA_HOME%