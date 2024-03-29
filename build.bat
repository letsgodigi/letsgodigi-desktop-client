@echo off
if not exist "build" md build
robocopy "src" "build" /e /nfl /ndl /njh /njs /nc /ns /np >nul
if not exist "build\LetsGoDigimon.exe" call :nw
echo Build complete
exit /b 0

:nw
if not exist ".temp" md .temp
if not exist ".temp\nwjs-v0.43.6-win-x64.zip" (
    cd .temp
    echo Downloading nw.js binary:
    curl https://dl.nwjs.io/v0.43.6/nwjs-v0.43.6-win-x64.zip -o nwjs-v0.43.6-win-x64.zip
    cd ..
)
echo Extracting binary...
if not exist ".temp\nwjs-v0.43.6-win-x64" powershell -command "Expand-Archive -Force '%cd%\.temp\nwjs-v0.43.6-win-x64.zip' '%cd%\.temp'"
robocopy ".temp\nwjs-v0.43.6-win-x64" "build" /e /nfl /ndl /njh /njs /nc /ns /np >nul
resourcehacker -open build\nw.exe -save build\LetsGoDigimon.exe -action addoverwrite -res build\icons\digivice.ico -mask ICONGROUP,IDR_MAINFRAME,0
del /q build\nw.exe
exit /b 0