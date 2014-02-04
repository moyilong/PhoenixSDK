cd /d %initdir%
if "%secure_mode%"=="enable" goto end
for %%h in (%feature_x%) do call %kernel%\init_app.bat %%h && echo Load:%%h >>%app_log% 
:end