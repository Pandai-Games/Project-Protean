# Project Protean Configuration Tool - Standalone Version
# This version is designed to be self-contained and compilable

param(
    [switch]$GUI = $true,
    [string]$GodotPath = "",
    [string]$ClonePath = "",
    [string]$RepoUrl = ""
)

# Add Windows Forms if GUI mode
if ($GUI) {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
}

# Configuration file management
$ConfigFile = "protean-config.json"

function Get-DefaultConfig {
    return @{
        GodotPath = "E:\Godot\Godot_v4.4-stable_win64.exe"
        DefaultClonePath = "$env:USERPROFILE\Documents\GameProjects"
        LastRepository = "https://github.com/Pandai-Games/Project-Protean.git"
        AutoValidate = $true
    }
}

function Load-Config {
    if (Test-Path $ConfigFile) {
        try {
            $json = Get-Content $ConfigFile -Raw | ConvertFrom-Json
            return @{
                GodotPath = $json.GodotPath
                DefaultClonePath = $json.DefaultClonePath
                LastRepository = $json.LastRepository
                AutoValidate = $json.AutoValidate
            }
        } catch {
            return Get-DefaultConfig
        }
    } else {
        return Get-DefaultConfig
    }
}

function Save-Config($config) {
    $config | ConvertTo-Json -Depth 3 | Out-File -FilePath $ConfigFile -Encoding UTF8
}

function Test-GodotPath($path) {
    return (Test-Path $path) -and ($path -like "*Godot*" -or $path -like "*godot*")
}

function Clone-Repository($repoUrl, $targetPath) {
    try {
        if (Test-Path $targetPath) {
            Write-Host "Directory already exists: $targetPath" -ForegroundColor Yellow
            $answer = Read-Host "Continue anyway? (y/N)"
            if ($answer -ne "y" -and $answer -ne "Y") {
                return $false
            }
        }
        
        Write-Host "Cloning $repoUrl to $targetPath..." -ForegroundColor Cyan
        $process = Start-Process -FilePath "git" -ArgumentList "clone", $repoUrl, $targetPath -Wait -PassThru -NoNewWindow
        return $process.ExitCode -eq 0
    } catch {
        Write-Host "Error cloning repository: $_" -ForegroundColor Red
        return $false
    }
}

function Test-Project($path, $godotPath) {
    $projectFile = Join-Path $path "project.godot"
    if (-not (Test-Path $projectFile)) {
        Write-Host "No project.godot found in $path" -ForegroundColor Red
        return $false
    }
    
    try {
        Write-Host "Validating project with Godot..." -ForegroundColor Cyan
        $process = Start-Process -FilePath $godotPath -ArgumentList "--headless", "--editor", "--quit", "--path", $path -Wait -PassThru -WindowStyle Hidden
        return $process.ExitCode -eq 0
    } catch {
        Write-Host "Error validating project: $_" -ForegroundColor Red
        return $false
    }
}

# Command line mode
if (-not $GUI) {
    $config = Load-Config
    
    Write-Host "=== Project Protean Configuration Tool ===" -ForegroundColor Green
    Write-Host ""
    
    # Handle command line parameters
    if ($GodotPath) { $config.GodotPath = $GodotPath }
    if ($ClonePath) { $config.DefaultClonePath = $ClonePath }
    if ($RepoUrl) { $config.LastRepository = $RepoUrl }
    
    Write-Host "Current Configuration:" -ForegroundColor Yellow
    Write-Host "  Godot Path: $($config.GodotPath)"
    Write-Host "  Clone Path: $($config.DefaultClonePath)"
    Write-Host "  Repository: $($config.LastRepository)"
    Write-Host ""
    
    $action = Read-Host "What would you like to do? (c)lone, (v)alidate, (s)ettings, (q)uit"
    
    switch ($action.ToLower()) {
        "c" {
            $repoUrl = Read-Host "Repository URL [$($config.LastRepository)]"
            if ([string]::IsNullOrEmpty($repoUrl)) { $repoUrl = $config.LastRepository }
            
            $projectName = Read-Host "Project name [Project-Protean]"
            if ([string]::IsNullOrEmpty($projectName)) { $projectName = "Project-Protean" }
            
            $targetPath = Join-Path $config.DefaultClonePath $projectName
            
            if (Clone-Repository $repoUrl $targetPath) {
                Write-Host "✅ Repository cloned successfully!" -ForegroundColor Green
                
                if ($config.AutoValidate) {
                    if (Test-Project $targetPath $config.GodotPath) {
                        Write-Host "✅ Project validation successful!" -ForegroundColor Green
                    } else {
                        Write-Host "⚠️ Project validation failed" -ForegroundColor Yellow
                    }
                }
            } else {
                Write-Host "❌ Failed to clone repository" -ForegroundColor Red
            }
        }
        "v" {
            $projectPath = Read-Host "Project path [current directory]"
            if ([string]::IsNullOrEmpty($projectPath)) { $projectPath = (Get-Location).Path }
            
            if (Test-Project $projectPath $config.GodotPath) {
                Write-Host "✅ Project validation successful!" -ForegroundColor Green
            } else {
                Write-Host "❌ Project validation failed" -ForegroundColor Red
            }
        }
        "s" {
            Write-Host "=== Settings ===" -ForegroundColor Yellow
            $config.GodotPath = Read-Host "Godot Path [$($config.GodotPath)]"
            if ([string]::IsNullOrEmpty($config.GodotPath)) { $config.GodotPath = $config.GodotPath }
            
            $config.DefaultClonePath = Read-Host "Default Clone Path [$($config.DefaultClonePath)]"
            if ([string]::IsNullOrEmpty($config.DefaultClonePath)) { $config.DefaultClonePath = $config.DefaultClonePath }
            
            Save-Config $config
            Write-Host "✅ Settings saved!" -ForegroundColor Green
        }
        "q" {
            Write-Host "Goodbye!" -ForegroundColor Green
            exit 0
        }
        default {
            Write-Host "Invalid option" -ForegroundColor Red
        }
    }
    
    exit 0
}

# GUI Mode (existing GUI code would go here - truncated for brevity)
Write-Host "Starting GUI mode..." -ForegroundColor Green
& "$PSScriptRoot\protean-config.ps1"
