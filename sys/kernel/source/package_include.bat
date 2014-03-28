@echo off
set pkgdir=%sdkdir%\package
if not exist %sdkdir%\package goto build_floder
if not exist %sdkdir%\package\list goto build_floder
if not exist %sdkdir%\package\source.list goto build_floder
:resume
if "%pkg_set%"=="true" goto end
set /p source_list=<%pkgdir%\source.list
set pkg_set=true
goto end




:build_floder
mkdir %sdkdir%\package
echo >%sdkdir%\package\list
echo >%sdkdir%\package\source.list
goto resume

:end