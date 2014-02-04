call %kernel%\make.bat zImage
call %apidir%\send.bat update.zip
adb reboot recovery
