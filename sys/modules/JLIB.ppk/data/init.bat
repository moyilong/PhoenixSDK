set java_dir=%appdir%\JLIB.ppk\jar
if not exist %sdkdir%\java_ext goto end
if exist %temp%\JEXT rmdir /q /s %temp%\JEXT
mkdir %temp%\JEXT
copy %sdkdir%\java_ext\*.jar %temp%\JEXT\
copy %java_dir%\*.jar %temp%\JEXT\
set java_dir=%temp%\JEXT
:end
echo Checking Java
for %%f in (%path%) do if exist %%f\java.exe echo Find Java:%%f\java.exe &set exist_java=1
if not "%exist_java%"=="1" echo 找不到java运行库! &sleep 3