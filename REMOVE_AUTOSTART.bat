@echo off
echo Removing FRIDAI auto-start...

set SHORTCUT_PATH=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\FRIDAI.lnk

if exist "%SHORTCUT_PATH%" (
    del "%SHORTCUT_PATH%"
    echo FRIDAI auto-start removed.
) else (
    echo FRIDAI was not set to auto-start.
)

pause
