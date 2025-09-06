@echo off
echo === GDScript Development Environment Diagnostics ===
echo.

echo 1. Testing Godot Installation...
if exist "E:\Godot\Godot_v4.4-stable_win64.exe" (
    echo    [OK] Godot found at E:\Godot\Godot_v4.4-stable_win64.exe
) else (
    echo    [ERROR] Godot not found
)

echo.
echo 2. Testing Project Structure...
if exist "project.godot" (
    echo    [OK] project.godot found
) else (
    echo    [ERROR] project.godot missing
)

if exist ".vscode\settings.json" (
    echo    [OK] VS Code settings configured
) else (
    echo    [ERROR] VS Code settings missing
)

if exist ".vscode\tasks.json" (
    echo    [OK] VS Code tasks configured
) else (
    echo    [ERROR] VS Code tasks missing
)

echo.
echo 3. Testing VS Code Extensions...
code --list-extensions | findstr "godot" >nul
if %errorlevel%==0 (
    echo    [OK] Godot extensions found
    code --list-extensions | findstr "godot"
) else (
    echo    [ERROR] No Godot extensions found
)

echo.
echo 4. Testing Language Server...
netstat -an | findstr "127.0.0.1:6005" >nul
if %errorlevel%==0 (
    echo    [OK] Language Server is running
) else (
    echo    [WARNING] Language Server not detected (Godot may not be running)
)

echo.
echo === Manual Test Instructions ===
echo 1. Open VS Code in this directory
echo 2. Open scenes/map_proc.gd
echo 3. Try typing "extends Node2D" and check for syntax highlighting
echo 4. Press Ctrl+Shift+P and type "Tasks: Run Task"
echo 5. Select "Open Godot Editor" and see if it works
echo 6. Press F5 to test debugging
echo.
pause
