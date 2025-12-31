@echo off
echo Setting up FRIDAI to auto-start on login...

:: Get the directory where this script is located
set SCRIPT_DIR=%~dp0

:: Create a shortcut in the Startup folder
set STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
set SHORTCUT_PATH=%STARTUP_FOLDER%\FRIDAI.lnk

:: Use PowerShell to create the shortcut
powershell -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%SHORTCUT_PATH%'); $s.TargetPath = '%SCRIPT_DIR%FRIDAI.exe'; $s.WorkingDirectory = '%SCRIPT_DIR%'; $s.Description = 'FRIDAI - AI Assistant'; $s.Save()"

echo.
echo FRIDAI will now start automatically when you log in!
echo Shortcut created at: %SHORTCUT_PATH%
echo.
echo NOTE: Make sure your Main PC (192.168.0.230) is running the backend.
echo.
pause
