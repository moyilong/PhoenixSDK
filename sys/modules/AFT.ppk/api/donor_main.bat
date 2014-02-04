echo Android Builder Main Feature
echo Donor ROM Replace 4.x
echo Useage:
echo call %apidir%\donor_main.bat {donor_files} {update_folders}
if not exist %1 goto error_not_donor
if not exist %2 goto error_not_update
echo 正在进行包的移植
cd /d %1
if not exist %1\debug.list if not exist %1\release.list goto mode_normally
if not exist %1\debug.list if exist %1\release.list goto mode_release
if exist %1\debug.list if not exist %1\release.list goto mode_debug
if exist %1\debug.list if exist %1\release.list if "%donor_mode%"=="release" goto mode_release
if exist %1\debug.list if exist %1\release.list if "%donor_mode%"=="debug" goto mode_debug

:mode_normally
for /d %%f in (*) do xcopy /Y /e %1\%%f %2\system
goto next

:mode_debug
for /f %%f in (debug.list) do xcopy /Y /e %1\%%f %2\system
goto next

:mode_release
for /f %%f in (release.list) do xcopy /Y /e %1\%%f %2\system

:next
echo 正在处理其他项目
cd /d %initdir%

if exist %1\build.prop echo y | copy %1\build.prop %2\system\build.prop
if exist %1\updater-script echo y | copy %1\updater-script %2\META-INF\com\google\android\updater-script



if not exist %1\del.list goto skip_del
echo 正在处理需要删除的项目
for /f %%f in (%1\del.list) do del %2\%%f && echo RM:%2\%%f>>%app_log%

:skip_del


if not exist %1\ren.list goto skip_ren
echo 正在处理重命名项目
for /f %%f in (%1\ren.list) do ren %2\%%f %%g &&  echo 重命名:%%f %%g

:skip_ren

echo 合并结束
goto end

:error_not_donor
echo %1 not exist
goto end

:error_not_update
echo Update File not exist
echo %2
goto end


:end