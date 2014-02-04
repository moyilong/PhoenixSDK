@echo off
:init
cls
call %kernel%\line.bat
echo AFTｺﾋﾐﾄﾄ｣ﾊｽﾇﾐｻｻ
call %kernel%\line.bat
echo 1｡｢ﾄｬﾈﾏｵﾄupdate.zip/Recovery
echo 2｡｢ﾊﾊﾓﾃﾓﾚAllwinnerｵﾄﾄ｣ﾊｽ(ﾖｻﾄﾜｴ�ｳﾉupdate.zipｸｽ)
echo 3｡｢ﾊﾊﾓﾃﾓﾚAllwinnerｵﾄﾄ｣ﾊｽ(ﾖｻﾄﾜｴ�ｳﾉLivesuitｸｽ)
echo 4｡｢ﾊﾊﾓﾃﾓﾚRK28xxｵﾄﾄ｣ﾊｽ
echo 5｡｢ﾊﾊﾓﾃﾓﾚRK29xxｵﾄﾄ｣ﾊｽ(Cramfs)
echo 6｡｢ﾊﾊﾓﾃﾓﾚRK29xxｵﾄﾄ｣ﾊｽ(Ext4FS)
call %kernel%\line.bat
set /p mode=[1/2/3//5/6/E]
if not "%mode%"=="1" if not "%mode%"=="2" if not "%mode%"=="3" if not "%mode%"=="4" if not "%mode%"=="5" if not "%mode%"=="6" goto init
if "%mode%"=="E" goto end
if "%mode%"=="e" goto end