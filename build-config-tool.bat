@echo off
REM Build script for Project Protean Configuration Tool
REM Creates a standalone executable using PS2EXE (if available)

echo Building Project Protean Configuration Tool...
echo.

REM Check if PS2EXE is available
powershell -Command "Get-Module -ListAvailable -Name PS2EXE" >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo PS2EXE module not found. Attempting to install...
    powershell -Command "Install-Module -Name PS2EXE -Scope CurrentUser -Force" >nul 2>&1
    if %ERRORLEVEL% NEQ 0 (
        echo.
        echo ❌ Failed to install PS2EXE module.
        echo.
        echo Manual installation:
        echo 1. Open PowerShell as Administrator
        echo 2. Run: Install-Module -Name PS2EXE
        echo 3. Run this build script again
        echo.
        echo Alternatively, use the .bat file to run the PowerShell script directly.
        pause
        exit /b 1
    )
)

echo ✅ PS2EXE module available
echo.

REM Create the executable
echo Building protean-config.exe...
powershell -Command "Import-Module PS2EXE; Invoke-PS2EXE -inputFile 'protean-config.ps1' -outputFile 'protean-config.exe' -title 'Project Protean Config' -description 'Project Protean Configuration Tool' -company 'Pandai Games' -version '1.0.0.0' -iconFile '' -noConsole"

if %ERRORLEVEL% EQU 0 (
    echo ✅ protean-config.exe created successfully!
) else (
    echo ❌ Failed to create protean-config.exe
)

echo.

REM Create CLI executable
echo Building protean-cli.exe...
powershell -Command "Import-Module PS2EXE; Invoke-PS2EXE -inputFile 'protean-cli.ps1' -outputFile 'protean-cli.exe' -title 'Project Protean CLI' -description 'Project Protean Command Line Tool' -company 'Pandai Games' -version '1.0.0.0'"

if %ERRORLEVEL% EQU 0 (
    echo ✅ protean-cli.exe created successfully!
) else (
    echo ❌ Failed to create protean-cli.exe
)

echo.
echo Build process completed!
echo.

if exist "protean-config.exe" (
    echo 🎮 GUI Tool: protean-config.exe
)
if exist "protean-cli.exe" (
    echo 💻 CLI Tool: protean-cli.exe
)
echo 📜 Script Version: protean-config.bat

echo.
pause
