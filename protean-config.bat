@echo off
REM Project Protean Configuration Tool Launcher
REM This script launches the PowerShell-based configuration GUI

echo Starting Project Protean Configuration Tool...
echo.

REM Check if PowerShell is available
powershell -Command "Get-Host" >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: PowerShell is not available or not working properly.
    echo Please ensure PowerShell is installed and working.
    pause
    exit /b 1
)

REM Run the PowerShell configuration script
powershell -ExecutionPolicy Bypass -File "%~dp0protean-config.ps1"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo The configuration tool encountered an error.
    echo Please check that all dependencies are available.
    pause
)

echo.
echo Configuration tool closed.
pause
