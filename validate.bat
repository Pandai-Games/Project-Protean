@echo off
REM Project validation script for local development on Windows
REM Requires Godot 4.4+ to be installed and in PATH

echo 🔍 Validating Project Protean...

REM Check if Godot is available
where godot >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Godot not found in PATH. Please install Godot 4.4+ first.
    echo    Download from: https://godotengine.org/download
    echo    Add Godot to your system PATH or place godot.exe in this folder.
    exit /b 1
)

REM Check Godot version
echo 📋 Godot version:
godot --version

REM Validate project
echo 🔧 Running project validation...
godot --headless --check-only --verbose --path .
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Project validation failed!
    exit /b 1
)

echo ✅ Project validation passed!

REM Check for GDScript files
echo 📝 Checking for GDScript files...
for /r %%i in (*.gd) do (
    echo    Found: %%i
)

echo 🎉 All checks completed!
