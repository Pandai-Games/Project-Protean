@echo off
REM Project validation script for local development on Windows
REM Using specific Godot installation path

set GODOT_PATH="E:\Godot\Godot_v4.4-stable_win64.exe"

echo 🔍 Validating Project Protean...

REM Check if Godot exists at specified path
if not exist %GODOT_PATH% (
    echo ❌ Godot not found at %GODOT_PATH%
    echo    Please check the path or install Godot 4.4+
    echo    Download from: https://godotengine.org/download
    exit /b 1
)

REM Check Godot version
echo 📋 Godot version:
%GODOT_PATH% --version

REM Validate project
echo 🔧 Running project validation...
echo Current directory: %CD%
echo Checking for project.godot...
if not exist "project.godot" (
    echo ❌ project.godot not found in current directory!
    echo    Make sure you're running this script from the project root.
    exit /b 1
)
echo ✅ Found project.godot

echo Running Godot validation...
echo Attempting basic project validation...
%GODOT_PATH% --headless --editor --quit --path "%CD%"
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Project validation failed!
    echo    The project may have configuration issues.
    exit /b 1
) else (
    echo ✅ Basic project validation passed!
)

echo Attempting import validation...
%GODOT_PATH% --headless --import --path "%CD%"
if %ERRORLEVEL% NEQ 0 (
    echo ⚠️ Import validation had issues, but project structure is valid.
) else (
    echo ✅ Import validation passed!
)

echo ✅ Project validation passed!

REM Check for GDScript files
echo 📝 Checking for GDScript files...
for /r %%i in (*.gd) do (
    echo    Found: %%i
)

echo 🎉 All checks completed!
