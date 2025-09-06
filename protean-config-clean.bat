@echo off
echo Starting Project Protean Configuration Tool...
powershell.exe -ExecutionPolicy Bypass -File "%~dp0protean-config-clean.ps1"
if errorlevel 1 (
    echo.
    echo The configuration tool encountered an error.
    echo Please check that all dependencies are available.
    pause
)
