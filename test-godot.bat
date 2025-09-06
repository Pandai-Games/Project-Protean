@echo off
REM Quick test of Godot installation and project validation
echo Testing Godot at: "E:\Godot\Godot_v4.4-stable_win64.exe"
echo.

echo 1. Checking Godot version:
"E:\Godot\Godot_v4.4-stable_win64.exe" --version
echo.

echo 2. Checking if project.godot exists:
if exist "project.godot" (
    echo ✅ Found project.godot
) else (
    echo ❌ project.godot not found!
    pause
    exit /b 1
)

echo 3. Quick project validation:
"E:\Godot\Godot_v4.4-stable_win64.exe" --headless --editor --quit --path "%CD%"
if %ERRORLEVEL% EQU 0 (
    echo ✅ Project validation successful!
) else (
    echo ❌ Project validation failed!
)

echo.
echo Test completed.
pause
