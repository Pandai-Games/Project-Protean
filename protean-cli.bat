@echo off
echo Starting Project Protean CLI Configuration Tool...
powershell.exe -ExecutionPolicy Bypass -File "%~dp0protean-cli-simple.ps1"
if errorlevel 1 (
    echo.
    echo The configuration tool encountered an error.
    pause
)
