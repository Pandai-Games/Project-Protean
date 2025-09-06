# Load required assemblies for Windows Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Project Protean Configuration Tool
# A comprehensive GUI tool for managing Godot projects and repositories

class ConfigManager {
    [string]$ConfigPath
    [hashtable]$Settings
    
    ConfigManager([string]$configPath) {
        $this.ConfigPath = $configPath
        $this.LoadConfig()
    }
    
    [void]LoadConfig() {
        if (Test-Path $this.ConfigPath) {
            try {
                $content = Get-Content $this.ConfigPath -Raw | ConvertFrom-Json
                $this.Settings = @{}
                $content.PSObject.Properties | ForEach-Object {
                    $this.Settings[$_.Name] = $_.Value
                }
            }
            catch {
                Write-Host "Error loading config: $($_.Exception.Message)"
                $this.SetDefaults()
            }
        }
        else {
            $this.SetDefaults()
        }
    }
    
    [void]SetDefaults() {
        $this.Settings = @{
            GodotPath = "E:\Godot\Godot_v4.4-stable_win64.exe"
            DefaultClonePath = [Environment]::GetFolderPath("MyDocuments") + "\GameProjects"
            LastRepository = "https://github.com/Pandai-Games/Project-Protean.git"
            AutoValidate = $true
        }
    }
    
    [void]SaveConfig() {
        try {
            $this.Settings | ConvertTo-Json -Depth 10 | Set-Content $this.ConfigPath -Encoding UTF8
            Write-Host "Configuration saved to: $($this.ConfigPath)"
        }
        catch {
            Write-Host "Error saving config: $($_.Exception.Message)"
        }
    }
    
    [string]Get([string]$key) {
        return $this.Settings[$key]
    }
    
    [void]Set([string]$key, [string]$value) {
        $this.Settings[$key] = $value
    }
}

class RepositoryManager {
    [ConfigManager]$Config
    
    RepositoryManager([ConfigManager]$config) {
        $this.Config = $config
    }
    
    [bool]ValidateGodotPath([string]$path) {
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
    
    [string]GetGodotVersion([string]$path) {
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
    
    [bool]CloneRepository([string]$repoUrl, [string]$targetPath) {
        try {
            if (Test-Path $targetPath) {
                $result = [System.Windows.Forms.MessageBox]::Show(
                    "Directory '$targetPath' already exists. Do you want to continue?",
                    "Directory Exists",
                    [System.Windows.Forms.MessageBoxButtons]::YesNo,
                    [System.Windows.Forms.MessageBoxIcon]::Question
                )
                if ($result -eq [System.Windows.Forms.DialogResult]::No) {
                    return $false
                }
            }
            
            $parentPath = Split-Path $targetPath -Parent
            if (-not (Test-Path $parentPath)) {
                New-Item -ItemType Directory -Path $parentPath -Force | Out-Null
            }
            
            $gitOutput = & git clone $repoUrl $targetPath 2>&1
            return $LASTEXITCODE -eq 0
        }
        catch {
            Write-Host "Error cloning repository: $($_.Exception.Message)"
            return $false
        }
    }
    
    [bool]ValidateProject([string]$projectPath, [string]$godotPath) {
        $projectFile = Join-Path $projectPath "project.godot"
        if (-not (Test-Path $projectFile)) {
            return $false
        }
        
        try {
            # Use Godot to validate the project
            $validateOutput = & $godotPath --path $projectPath --editor --quit 2>&1
            return $LASTEXITCODE -eq 0
        }
        catch {
            Write-Host "Error validating project: $($_.Exception.Message)"
            return $false
        }
    }
}

# Initialize managers
$configPath = Join-Path $PSScriptRoot "protean-config.json"
$configManager = [ConfigManager]::new($configPath)
$repoManager = [RepositoryManager]::new($configManager)

# Create main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Project Protean Configuration Tool"
$form.Size = New-Object System.Drawing.Size(600, 500)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

# Godot Path Section
$godotLabel = New-Object System.Windows.Forms.Label
$godotLabel.Text = "Godot Engine Path:"
$godotLabel.Location = New-Object System.Drawing.Point(20, 20)
$godotLabel.Size = New-Object System.Drawing.Size(150, 20)
$form.Controls.Add($godotLabel)

$godotPathTextBox = New-Object System.Windows.Forms.TextBox
$godotPathTextBox.Location = New-Object System.Drawing.Point(20, 45)
$godotPathTextBox.Size = New-Object System.Drawing.Size(400, 25)
$godotPathTextBox.Text = $configManager.Get("GodotPath")
$form.Controls.Add($godotPathTextBox)

$browseGodotButton = New-Object System.Windows.Forms.Button
$browseGodotButton.Text = "Browse"
$browseGodotButton.Location = New-Object System.Drawing.Point(430, 43)
$browseGodotButton.Size = New-Object System.Drawing.Size(80, 28)
$form.Controls.Add($browseGodotButton)

$testGodotButton = New-Object System.Windows.Forms.Button
$testGodotButton.Text = "Test"
$testGodotButton.Location = New-Object System.Drawing.Point(520, 43)
$testGodotButton.Size = New-Object System.Drawing.Size(50, 28)
$form.Controls.Add($testGodotButton)

# Clone Path Section
$cloneLabel = New-Object System.Windows.Forms.Label
$cloneLabel.Text = "Default Clone Directory:"
$cloneLabel.Location = New-Object System.Drawing.Point(20, 90)
$cloneLabel.Size = New-Object System.Drawing.Size(150, 20)
$form.Controls.Add($cloneLabel)

$clonePathTextBox = New-Object System.Windows.Forms.TextBox
$clonePathTextBox.Location = New-Object System.Drawing.Point(20, 115)
$clonePathTextBox.Size = New-Object System.Drawing.Size(400, 25)
$clonePathTextBox.Text = $configManager.Get("DefaultClonePath")
$form.Controls.Add($clonePathTextBox)

$browseCloneButton = New-Object System.Windows.Forms.Button
$browseCloneButton.Text = "Browse"
$browseCloneButton.Location = New-Object System.Drawing.Point(430, 113)
$browseCloneButton.Size = New-Object System.Drawing.Size(80, 28)
$form.Controls.Add($browseCloneButton)

# Repository Section
$repoLabel = New-Object System.Windows.Forms.Label
$repoLabel.Text = "Repository URL:"
$repoLabel.Location = New-Object System.Drawing.Point(20, 160)
$repoLabel.Size = New-Object System.Drawing.Size(150, 20)
$form.Controls.Add($repoLabel)

$repoUrlTextBox = New-Object System.Windows.Forms.TextBox
$repoUrlTextBox.Location = New-Object System.Drawing.Point(20, 185)
$repoUrlTextBox.Size = New-Object System.Drawing.Size(550, 25)
$repoUrlTextBox.Text = $configManager.Get("LastRepository")
$form.Controls.Add($repoUrlTextBox)

# Action Buttons
$cloneButton = New-Object System.Windows.Forms.Button
$cloneButton.Text = "Clone Repository"
$cloneButton.Location = New-Object System.Drawing.Point(20, 230)
$cloneButton.Size = New-Object System.Drawing.Size(120, 35)
$cloneButton.BackColor = [System.Drawing.Color]::LightGreen
$form.Controls.Add($cloneButton)

$validateButton = New-Object System.Windows.Forms.Button
$validateButton.Text = "Validate Project"
$validateButton.Location = New-Object System.Drawing.Point(150, 230)
$validateButton.Size = New-Object System.Drawing.Size(120, 35)
$form.Controls.Add($validateButton)

$openFolderButton = New-Object System.Windows.Forms.Button
$openFolderButton.Text = "Open Folder"
$openFolderButton.Location = New-Object System.Drawing.Point(280, 230)
$openFolderButton.Size = New-Object System.Drawing.Size(120, 35)
$form.Controls.Add($openFolderButton)

# Configuration Buttons
$saveConfigButton = New-Object System.Windows.Forms.Button
$saveConfigButton.Text = "Save Config"
$saveConfigButton.Location = New-Object System.Drawing.Point(450, 230)
$saveConfigButton.Size = New-Object System.Drawing.Size(120, 35)
$saveConfigButton.BackColor = [System.Drawing.Color]::LightBlue
$form.Controls.Add($saveConfigButton)

# Auto-validate checkbox
$autoValidateCheckBox = New-Object System.Windows.Forms.CheckBox
$autoValidateCheckBox.Text = "Auto-validate after clone"
$autoValidateCheckBox.Location = New-Object System.Drawing.Point(20, 280)
$autoValidateCheckBox.Size = New-Object System.Drawing.Size(200, 25)
$autoValidateCheckBox.Checked = [bool]$configManager.Get("AutoValidate")
$form.Controls.Add($autoValidateCheckBox)

# Status Label
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = "Ready - Configure your Godot project settings"
$statusLabel.Location = New-Object System.Drawing.Point(20, 320)
$statusLabel.Size = New-Object System.Drawing.Size(550, 40)
$statusLabel.BackColor = [System.Drawing.Color]::LightGray
$statusLabel.BorderStyle = "FixedSingle"
$statusLabel.TextAlign = "MiddleLeft"
$form.Controls.Add($statusLabel)

# Event Handlers
$browseGodotButton.Add_Click({
    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $openFileDialog.Filter = "Godot Engine (*.exe)|*.exe|All files (*.*)|*.*"
    $openFileDialog.Title = "Select Godot Engine Executable"
    $openFileDialog.InitialDirectory = "C:\"
    
    if ($openFileDialog.ShowDialog() -eq "OK") {
        $godotPathTextBox.Text = $openFileDialog.FileName
    }
})

$browseCloneButton.Add_Click({
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderBrowser.Description = "Select Default Clone Directory"
    $folderBrowser.SelectedPath = $clonePathTextBox.Text
    
    if ($folderBrowser.ShowDialog() -eq "OK") {
        $clonePathTextBox.Text = $folderBrowser.SelectedPath
    }
})

$testGodotButton.Add_Click({
    $godotPath = $godotPathTextBox.Text
    if ($repoManager.ValidateGodotPath($godotPath)) {
        $version = $repoManager.GetGodotVersion($godotPath)
        if ($version -ne "Unknown") {
            $statusLabel.Text = "Godot validated: $version"
            $statusLabel.BackColor = [System.Drawing.Color]::LightGreen
        } else {
            $statusLabel.Text = "Godot found but version unknown"
            $statusLabel.BackColor = [System.Drawing.Color]::LightYellow
        }
    } else {
        $statusLabel.Text = "Invalid Godot path"
        $statusLabel.BackColor = [System.Drawing.Color]::LightCoral
    }
})

$cloneButton.Add_Click({
    $repoUrl = $repoUrlTextBox.Text
    $clonePath = $clonePathTextBox.Text
    $repoName = Split-Path $repoUrl -Leaf
    $repoName = $repoName -replace "\.git$", ""
    $targetPath = Join-Path $clonePath $repoName
    
    $statusLabel.Text = "Cloning repository..."
    $statusLabel.BackColor = [System.Drawing.Color]::LightYellow
    $form.Refresh()
    
    if ($repoManager.CloneRepository($repoUrl, $targetPath)) {
        $statusLabel.Text = "Repository cloned successfully to: $targetPath"
        $statusLabel.BackColor = [System.Drawing.Color]::LightGreen
        
        # Auto-validate if enabled
        if ($autoValidateCheckBox.Checked) {
            $statusLabel.Text = "Validating cloned project..."
            $form.Refresh()
            
            if ($repoManager.ValidateProject($targetPath, $godotPathTextBox.Text)) {
                $statusLabel.Text = "Repository cloned and validated successfully!"
                $statusLabel.BackColor = [System.Drawing.Color]::LightGreen
            } else {
                $statusLabel.Text = "Repository cloned but validation failed"
                $statusLabel.BackColor = [System.Drawing.Color]::LightYellow
            }
        }
    } else {
        $statusLabel.Text = "Failed to clone repository"
        $statusLabel.BackColor = [System.Drawing.Color]::LightCoral
    }
})

$validateButton.Add_Click({
    $repoUrl = $repoUrlTextBox.Text
    $clonePath = $clonePathTextBox.Text
    $repoName = Split-Path $repoUrl -Leaf
    $repoName = $repoName -replace "\.git$", ""
    $targetPath = Join-Path $clonePath $repoName
    
    $statusLabel.Text = "Validating project..."
    $statusLabel.BackColor = [System.Drawing.Color]::LightYellow
    $form.Refresh()
    
    if ($repoManager.ValidateProject($targetPath, $godotPathTextBox.Text)) {
        $statusLabel.Text = "Project validation successful!"
        $statusLabel.BackColor = [System.Drawing.Color]::LightGreen
    } else {
        $statusLabel.Text = "Project validation failed"
        $statusLabel.BackColor = [System.Drawing.Color]::LightCoral
    }
})

$openFolderButton.Add_Click({
    $repoUrl = $repoUrlTextBox.Text
    $clonePath = $clonePathTextBox.Text
    $repoName = Split-Path $repoUrl -Leaf
    $repoName = $repoName -replace "\.git$", ""
    $targetPath = Join-Path $clonePath $repoName
    
    if (Test-Path $targetPath) {
        Start-Process "explorer.exe" -ArgumentList $targetPath
        $statusLabel.Text = "Opened folder: $targetPath"
        $statusLabel.BackColor = [System.Drawing.Color]::LightBlue
    } else {
        if (Test-Path $clonePath) {
            Start-Process "explorer.exe" -ArgumentList $clonePath
            $statusLabel.Text = "Opened parent folder: $($clonePathTextBox.Text)"
            $statusLabel.BackColor = [System.Drawing.Color]::LightBlue
        } else {
            $statusLabel.Text = "Folder not found"
            $statusLabel.BackColor = [System.Drawing.Color]::LightCoral
        }
    }
})

$saveConfigButton.Add_Click({
    $configManager.Set("GodotPath", $godotPathTextBox.Text)
    $configManager.Set("DefaultClonePath", $clonePathTextBox.Text)
    $configManager.Set("LastRepository", $repoUrlTextBox.Text)
    $configManager.Set("AutoValidate", $autoValidateCheckBox.Checked)
    $configManager.SaveConfig()
    
    $statusLabel.Text = "Configuration saved successfully!"
    $statusLabel.BackColor = [System.Drawing.Color]::LightGreen
})

# Show the form
Write-Host "Starting Project Protean Configuration Tool..."
$form.ShowDialog() | Out-Null
