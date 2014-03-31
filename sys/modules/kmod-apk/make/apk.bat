@echo off
apktool b %1 temp.epk
if exist %1.apk del %1.apk
sign temp.epk %1.apk