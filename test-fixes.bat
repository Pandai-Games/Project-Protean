@echo off
echo === Testing Project Protean Fixes ===
echo.

echo 1. Testing main scene configuration...
findstr "main_scene" project.godot
if %errorlevel%==0 (
    echo    [OK] Main scene is configured
) else (
    echo    [ERROR] Main scene not configured
)

echo.
echo 2. Testing project structure...
if exist "scenes\main.tscn" (
    echo    [OK] Main scene file exists
) else (
    echo    [ERROR] Main scene file missing
)

echo.
echo 3. Testing Godot project (quick validation)...
"E:\Godot\Godot_v4.4-stable_win64.exe" --path . --check-only --headless
if %errorlevel%==0 (
    echo    [OK] Project validates successfully
) else (
    echo    [WARNING] Project validation had issues
)

echo.
echo 4. VS Code Command Palette Fix
echo    Created .vscode\keybindings.json to fix Ctrl+Shift+P
if exist ".vscode\keybindings.json" (
    echo    [OK] Keybindings file created
) else (
    echo    [ERROR] Keybindings file missing
)

echo.
echo === Instructions ===
echo 1. Restart VS Code to apply keybinding fixes
echo 2. Try Ctrl+Shift+P again (should open Command Palette)
echo 3. Try Ctrl+Shift+B (should run project without main scene error)
echo 4. If still having issues, try F1 instead of Ctrl+Shift+P
echo.
pause
