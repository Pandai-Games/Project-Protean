# Project Protean Configuration Tool - CLI Version
# Simple command-line interface for managing Godot projects

param(
    [string]$GodotPath = "",
    [string]$ClonePath = "",
    [string]$RepoUrl = "https://github.com/Pandai-Games/Project-Protean.git",
    [switch]$GUI = $false
)

# Configuration file path
$configPath = Join-Path $PSScriptRoot "protean-config.json"

function Load-Config {
    if (Test-Path $configPath) {
        try {
            return Get-Content $configPath -Raw | ConvertFrom-Json
        }
        catch {
            Write-Host "Warning: Could not load config file. Using defaults." -ForegroundColor Yellow
        }
    }
    
    # Default configuration
    return @{
        GodotPath = "E:\Godot\Godot_v4.4-stable_win64.exe"
        DefaultClonePath = [Environment]::GetFolderPath("MyDocuments") + "\GameProjects"
        LastRepository = "https://github.com/Pandai-Games/Project-Protean.git"
        AutoValidate = $true
    }
}

function Save-Config {
    param($config)
    try {
        $config | ConvertTo-Json -Depth 10 | Set-Content $configPath -Encoding UTF8
        Write-Host "Configuration saved to: $configPath" -ForegroundColor Green
    }
    catch {
        Write-Host "Error saving configuration: $($_.Exception.Message)" -ForegroundColor Red
    }
}

function Test-GodotPath {
    param([string]$path)
    
    if (-not (Test-Path $path)) {
        return $false
    }
    
    try {
        $versionOutput = & $path --version 2>&1
        return $versionOutput -match "Godot Engine"
    }
    catch {
        return $false
    }
}

function Get-GodotVersion {
    param([string]$path)
    
    try {
        $versionOutput = & $path --version 2>&1
        if ($versionOutput -match "Godot Engine v(.+)") {
            return $matches[1]
        }
    }
    catch {
        return "Unknown"
    }
    return "Unknown"
}

function Clone-Repository {
    param(
        [string]$repoUrl,
        [string]$targetPath
    )
    
    try {
        if (Test-Path $targetPath) {
            Write-Host "Directory '$targetPath' already exists." -ForegroundColor Yellow
            $response = Read-Host "Do you want to continue? (y/N)"
            if ($response -ne "y" -and $response -ne "Y") {
                return $false
            }
        }
        
        $parentPath = Split-Path $targetPath -Parent
        if (-not (Test-Path $parentPath)) {
            New-Item -ItemType Directory -Path $parentPath -Force | Out-Null
        }
        
        Write-Host "Cloning repository..." -ForegroundColor Yellow
        $gitOutput = & git clone $repoUrl $targetPath 2>&1
        return $LASTEXITCODE -eq 0
    }
    catch {
        Write-Host "Error cloning repository: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

function Test-Project {
    param(
        [string]$projectPath,
        [string]$godotPath
    )
    
    $projectFile = Join-Path $projectPath "project.godot"
    if (-not (Test-Path $projectFile)) {
        Write-Host "project.godot not found in: $projectPath" -ForegroundColor Red
        return $false
    }
    
    try {
        Write-Host "Validating project with Godot..." -ForegroundColor Yellow
        $validateOutput = & $godotPath --path $projectPath --editor --quit 2>&1
        return $LASTEXITCODE -eq 0
    }
    catch {
        Write-Host "Error validating project: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

function Show-Menu {
    Write-Host ""
    Write-Host "=== Project Protean Configuration Tool ===" -ForegroundColor Cyan
    Write-Host "1. Configure Godot Path"
    Write-Host "2. Set Clone Directory"
    Write-Host "3. Set Repository URL"
    Write-Host "4. Clone Repository"
    Write-Host "5. Validate Project"
    Write-Host "6. Open Project Folder"
    Write-Host "7. Save Configuration"
    Write-Host "8. Show Current Settings"
    Write-Host "9. Exit"
    Write-Host ""
}

# Load configuration
$config = Load-Config

# Override with command line parameters if provided
if ($GodotPath) { $config.GodotPath = $GodotPath }
if ($ClonePath) { $config.DefaultClonePath = $ClonePath }
if ($RepoUrl) { $config.LastRepository = $RepoUrl }

# Show current configuration
Write-Host ""
Write-Host "Project Protean Configuration Tool" -ForegroundColor Green
Write-Host "===================================" -ForegroundColor Green
Write-Host ""
Write-Host "Current Settings:" -ForegroundColor Yellow
Write-Host "  Godot Path: $($config.GodotPath)"
Write-Host "  Clone Path: $($config.DefaultClonePath)"
Write-Host "  Repository: $($config.LastRepository)"
Write-Host ""

# Test Godot path
if (Test-GodotPath $config.GodotPath) {
    $version = Get-GodotVersion $config.GodotPath
    Write-Host "  Godot Status: Valid ($version)" -ForegroundColor Green
} else {
    Write-Host "  Godot Status: Invalid or not found" -ForegroundColor Red
}

# Interactive menu (if not in GUI mode and no parameters provided)
if (-not $GUI -and -not $GodotPath -and -not $ClonePath) {
    do {
        Show-Menu
        $choice = Read-Host "Select an option (1-9)"
        
        switch ($choice) {
            "1" {
                $newPath = Read-Host "Enter Godot executable path"
                if ($newPath) {
                    $config.GodotPath = $newPath
                    if (Test-GodotPath $newPath) {
                        $version = Get-GodotVersion $newPath
                        Write-Host "Godot path updated and validated ($version)" -ForegroundColor Green
                    } else {
                        Write-Host "Warning: Godot path may be invalid" -ForegroundColor Yellow
                    }
                }
            }
            "2" {
                $newPath = Read-Host "Enter clone directory path"
                if ($newPath) {
                    $config.DefaultClonePath = $newPath
                    Write-Host "Clone path updated" -ForegroundColor Green
                }
            }
            "3" {
                $newUrl = Read-Host "Enter repository URL"
                if ($newUrl) {
                    $config.LastRepository = $newUrl
                    Write-Host "Repository URL updated" -ForegroundColor Green
                }
            }
            "4" {
                $repoName = Split-Path $config.LastRepository -Leaf
                $repoName = $repoName -replace "\.git$", ""
                $targetPath = Join-Path $config.DefaultClonePath $repoName
                
                if (Clone-Repository $config.LastRepository $targetPath) {
                    Write-Host "Repository cloned successfully to: $targetPath" -ForegroundColor Green
                    
                    if ($config.AutoValidate -and (Test-GodotPath $config.GodotPath)) {
                        if (Test-Project $targetPath $config.GodotPath) {
                            Write-Host "Project validation successful!" -ForegroundColor Green
                        } else {
                            Write-Host "Project validation failed" -ForegroundColor Yellow
                        }
                    }
                } else {
                    Write-Host "Failed to clone repository" -ForegroundColor Red
                }
            }
            "5" {
                $repoName = Split-Path $config.LastRepository -Leaf
                $repoName = $repoName -replace "\.git$", ""
                $targetPath = Join-Path $config.DefaultClonePath $repoName
                
                if (Test-Project $targetPath $config.GodotPath) {
                    Write-Host "Project validation successful!" -ForegroundColor Green
                } else {
                    Write-Host "Project validation failed" -ForegroundColor Red
                }
            }
            "6" {
                $repoName = Split-Path $config.LastRepository -Leaf
                $repoName = $repoName -replace "\.git$", ""
                $targetPath = Join-Path $config.DefaultClonePath $repoName
                
                if (Test-Path $targetPath) {
                    Start-Process "explorer.exe" -ArgumentList $targetPath
                    Write-Host "Opened folder: $targetPath" -ForegroundColor Green
                } else {
                    Write-Host "Project folder not found: $targetPath" -ForegroundColor Red
                }
            }
            "7" {
                Save-Config $config
            }
            "8" {
                Write-Host ""
                Write-Host "Current Settings:" -ForegroundColor Yellow
                Write-Host "  Godot Path: $($config.GodotPath)"
                Write-Host "  Clone Path: $($config.DefaultClonePath)"
                Write-Host "  Repository: $($config.LastRepository)"
                Write-Host "  Auto-validate: $($config.AutoValidate)"
                Write-Host ""
            }
            "9" {
                Write-Host "Saving configuration and exiting..." -ForegroundColor Green
                Save-Config $config
                break
            }
            default {
                Write-Host "Invalid option. Please select 1-9." -ForegroundColor Red
            }
        }
    } while ($choice -ne "9")
} else {
    # Save configuration if parameters were provided
    Save-Config $config
}

Write-Host ""
Write-Host "Configuration tool completed." -ForegroundColor Green
