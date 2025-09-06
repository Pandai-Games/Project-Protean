# Simple GDScript Diagnostics
Write-Host "=== GDScript Development Environment Status ===" -ForegroundColor Cyan

# Check Godot
$godotPath = "E:\Godot\Godot_v4.4-stable_win64.exe"
if (Test-Path $godotPath) {
    Write-Host "✓ Godot found at: $godotPath" -ForegroundColor Green
} else {
    Write-Host "✗ Godot not found" -ForegroundColor Red
}

# Check extensions
Write-Host "`n=== VS Code Extensions ===" -ForegroundColor Cyan
$extensions = & code --list-extensions 2>$null
if ($extensions -contains "geequlim.godot-tools") {
    Write-Host "✓ Godot Tools extension installed" -ForegroundColor Green
} else {
    Write-Host "✗ Godot Tools extension missing" -ForegroundColor Red
}

# Check LSP connection
Write-Host "`n=== Language Server ===" -ForegroundColor Cyan
$lspPort = netstat -an | findstr "127.0.0.1:6005"
if ($lspPort) {
    Write-Host "✓ Language Server running on port 6005" -ForegroundColor Green
    Write-Host "  $lspPort" -ForegroundColor Gray
} else {
    Write-Host "✗ Language Server not running" -ForegroundColor Red
}

# Check project structure
Write-Host "`n=== Project Structure ===" -ForegroundColor Cyan
if (Test-Path "project.godot") {
    Write-Host "✓ project.godot found" -ForegroundColor Green
}
if (Test-Path ".vscode\settings.json") {
    Write-Host "✓ VS Code settings configured" -ForegroundColor Green
}
if (Test-Path ".vscode\tasks.json") {
    Write-Host "✓ VS Code tasks configured" -ForegroundColor Green
}

Write-Host "`n=== Quick Tests ===" -ForegroundColor Cyan
Write-Host "To test functionality:" -ForegroundColor White
Write-Host "1. Open a .gd file in VS Code" -ForegroundColor Gray
Write-Host "2. Type 'extends Node' and check for syntax highlighting" -ForegroundColor Gray
Write-Host "3. Press Ctrl+Shift+P → 'Tasks: Run Task' → 'Open Godot Editor'" -ForegroundColor Gray
Write-Host "4. Press F5 to test debugging" -ForegroundColor Gray
