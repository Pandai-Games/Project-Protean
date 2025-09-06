# GDScript Development Environment Troubleshooting Script
# Run this to diagnose and fix common issues

Write-Host "=== Project Protean GDScript Development Environment Diagnostics ===" -ForegroundColor Cyan
Write-Host ""

# Test 1: Check Godot Installation
Write-Host "1. Testing Godot Installation..." -ForegroundColor Yellow
$godotPath = "E:\Godot\Godot_v4.4-stable_win64.exe"

if (Test-Path $godotPath) {
	Write-Host "   ✓ Godot found at: $godotPath" -ForegroundColor Green
    
	try {
		$version = & $godotPath --version 2>&1
		if ($version -match "Godot Engine") {
			Write-Host "   ✓ Godot version: $version" -ForegroundColor Green
		}
		else {
			Write-Host "   ⚠ Godot version check failed" -ForegroundColor Yellow
		}
	}
	catch {
		Write-Host "   ✗ Error running Godot: $($_.Exception.Message)" -ForegroundColor Red
	}
}
else {
	Write-Host "   ✗ Godot not found at: $godotPath" -ForegroundColor Red
	Write-Host "     Please update the path in .vscode/settings.json" -ForegroundColor Yellow
}

# Test 2: Check Project Structure
Write-Host ""
Write-Host "2. Testing Project Structure..." -ForegroundColor Yellow

$projectFile = "project.godot"
if (Test-Path $projectFile) {
	Write-Host "   ✓ project.godot found" -ForegroundColor Green
}
else {
	Write-Host "   ✗ project.godot missing" -ForegroundColor Red
}

$vscodeDir = ".vscode"
if (Test-Path $vscodeDir) {
	Write-Host "   ✓ .vscode directory found" -ForegroundColor Green
    
	$configFiles = @("settings.json", "tasks.json", "launch.json", "extensions.json")
	foreach ($file in $configFiles) {
		$filePath = Join-Path $vscodeDir $file
		if (Test-Path $filePath) {
			Write-Host "   ✓ $file found" -ForegroundColor Green
		}
		else {
			Write-Host "   ⚠ $file missing" -ForegroundColor Yellow
		}
	}
}
else {
	Write-Host "   ✗ .vscode directory missing" -ForegroundColor Red
}

# Test 3: Check VS Code Extensions
Write-Host ""
Write-Host "3. Testing VS Code Extensions..." -ForegroundColor Yellow

$extensions = @(
	"geequlim.godot-tools",
	"alfish.godot-files", 
	"eddiedover.gdscript-formatter-linter"
)

try {
	$installedExtensions = & code --list-extensions 2>&1
	foreach ($ext in $extensions) {
		if ($installedExtensions -contains $ext) {
			Write-Host "   ✓ $ext installed" -ForegroundColor Green
		}
		else {
			Write-Host "   ⚠ $ext not installed" -ForegroundColor Yellow
			Write-Host "     Install with: code --install-extension $ext" -ForegroundColor Gray
		}
	}
}
catch {
	Write-Host "   ⚠ Could not check extensions (VS Code may not be in PATH)" -ForegroundColor Yellow
}

# Test 4: Test Network Connectivity for LSP
Write-Host ""
Write-Host "4. Testing Language Server Port..." -ForegroundColor Yellow

try {
	$tcpClient = New-Object System.Net.Sockets.TcpClient
	$connection = $tcpClient.BeginConnect("127.0.0.1", 6005, $null, $null)
	$success = $connection.AsyncWaitHandle.WaitOne(1000, $false)
    
	if ($success -and $tcpClient.Connected) {
		Write-Host "   ✓ LSP port 6005 is accessible" -ForegroundColor Green
		$tcpClient.Close()
	}
 else {
		Write-Host "   ⚠ LSP port 6005 not accessible (Godot may not be running)" -ForegroundColor Yellow
		Write-Host "     Start Godot editor to enable Language Server" -ForegroundColor Gray
	}
}
catch {
	Write-Host "   ⚠ Could not test LSP port: $($_.Exception.Message)" -ForegroundColor Yellow
}

# Test 5: Check File Permissions
Write-Host ""
Write-Host "5. Testing File Permissions..." -ForegroundColor Yellow

$testFiles = @("project.godot", ".vscode\settings.json", ".vscode\tasks.json")
foreach ($file in $testFiles) {
	if (Test-Path $file) {
		try {
			$null = Get-Content $file -Raw -ErrorAction Stop
			Write-Host "   ✓ Can read $file" -ForegroundColor Green
		}
		catch {
			Write-Host "   ✗ Cannot read $file`: $($_.Exception.Message)" -ForegroundColor Red
		}
	}
}

# Test 6: PowerShell Execution Policy
Write-Host ""
Write-Host "6. Testing PowerShell Environment..." -ForegroundColor Yellow

$executionPolicy = Get-ExecutionPolicy
Write-Host "   Execution Policy: $executionPolicy" -ForegroundColor Gray

if ($executionPolicy -in @("Restricted", "AllSigned")) {
	Write-Host "   ⚠ Restrictive execution policy may cause issues" -ForegroundColor Yellow
	Write-Host "     Consider: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser" -ForegroundColor Gray
}
else {
	Write-Host "   ✓ Execution policy allows script execution" -ForegroundColor Green
}

# Summary and Recommendations
Write-Host ""
Write-Host "=== Troubleshooting Recommendations ===" -ForegroundColor Cyan

Write-Host ""
Write-Host "To fix common issues:" -ForegroundColor White
Write-Host "1. Install missing VS Code extensions:" -ForegroundColor Gray
Write-Host "   code --install-extension geequlim.godot-tools" -ForegroundColor Gray
Write-Host "   code --install-extension alfish.godot-files" -ForegroundColor Gray
Write-Host "   code --install-extension eddiedover.gdscript-formatter-linter" -ForegroundColor Gray

Write-Host ""
Write-Host "2. Enable Language Server in Godot:" -ForegroundColor Gray
Write-Host "   - Open Godot Editor" -ForegroundColor Gray
Write-Host "   - Go to Editor → Editor Settings → Network → Language Server" -ForegroundColor Gray
Write-Host "   - Enable 'Enable Language Server' and 'Use Thread'" -ForegroundColor Gray
Write-Host "   - Set Port to 6005" -ForegroundColor Gray

Write-Host ""
Write-Host "3. Test VS Code integration:" -ForegroundColor Gray
Write-Host "   - Open VS Code in project directory" -ForegroundColor Gray
Write-Host "   - Press Ctrl+Shift+P → 'Tasks: Run Task' → 'Open Godot Editor'" -ForegroundColor Gray
Write-Host "   - Open a .gd file and test auto-completion" -ForegroundColor Gray

Write-Host ""
Write-Host "4. For debugging issues:" -ForegroundColor Gray
Write-Host "   - Ensure Godot project is running" -ForegroundColor Gray
Write-Host "   - Press F5 in VS Code to start debugging" -ForegroundColor Gray
Write-Host "   - Check debug console for error messages" -ForegroundColor Gray

Write-Host ""
Write-Host "=== Diagnostics Complete ===" -ForegroundColor Cyan
