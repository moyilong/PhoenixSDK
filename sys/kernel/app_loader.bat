cd /d %initdir%
if "%secure_mode%"=="enable" goto end
for %%h in (%feature_x%) do call %kernel%\init_app.bat %%h && echo Load:%%h >>%app_log% 
echo Initing App Configure
cd /d %proc%\kcfg
for %%f in (%feature%) do echo source "%%f.kcfg">>kernel.kcfg
:end