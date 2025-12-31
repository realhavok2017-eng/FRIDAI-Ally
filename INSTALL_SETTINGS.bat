@echo off
echo Installing FRIDAI settings for ROG Ally...

set SETTINGS_DIR=%APPDATA%\FRIDAI
if not exist "%SETTINGS_DIR%" mkdir "%SETTINGS_DIR%"

copy /Y "%~dp0ally_settings.json" "%SETTINGS_DIR%\settings.json"

echo.
echo Settings installed to: %SETTINGS_DIR%\settings.json
echo Backend URL: http://192.168.0.230:5000
echo.
echo Now run FRIDAI.exe to connect!
pause
