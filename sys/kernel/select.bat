set /p yn=[%1][Y/N]///
set return=true
if "%yn%"=="n" set return=false
if "%yn%"=="N" set return=false
