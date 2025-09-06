Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Load required assemblies for Windows Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Project Protean Configuration Tool
# Author: Pandai Games
# Description: Configure repository settings, Godot path, and clone/import repositories

class ConfigManager {
    [string]$ConfigFile = "protean-config.json"
    [hashtable]$Settings
    
    ConfigManager() {
        $this.LoadConfig()
    }
    
    [void]LoadConfig() {
        if (Test-Path $this.ConfigFile) {
            try {
                $json = Get-Content $this.ConfigFile -Raw | ConvertFrom-Json
                $this.Settings = @{
                    GodotPath = $json.GodotPath
                    DefaultClonePath = $json.DefaultClonePath
                    LastRepository = $json.LastRepository
                    AutoValidate = $json.AutoValidate
                }
            } catch {
                $this.Settings = $this.GetDefaultSettings()
            }
        } else {
            $this.Settings = $this.GetDefaultSettings()
        }
    }
    
    [hashtable]GetDefaultSettings() {
        return @{
            GodotPath = "E:\Godot\Godot_v4.4-stable_win64.exe"
            DefaultClonePath = "$env:USERPROFILE\Documents\GameProjects"
            LastRepository = "https://github.com/Pandai-Games/Project-Protean.git"
            AutoValidate = $true
        }
    }
    
    [void]SaveConfig() {
        $json = $this.Settings | ConvertTo-Json -Depth 3
        $json | Out-File -FilePath $this.ConfigFile -Encoding UTF8
    }
    
    [bool]ValidateGodotPath([string]$path) {
        return (Test-Path $path) -and ($path -like "*Godot*" -or $path -like "*godot*")
    }
}

class RepositoryManager {
    [string]$WorkingDirectory
    
    RepositoryManager([string]$workingDir) {
        $this.WorkingDirectory = $workingDir
    }
    
    [bool]CloneRepository([string]$repoUrl, [string]$targetPath) {
        try {
            if (Test-Path $targetPath) {
                $result = [System.Windows.Forms.MessageBox]::Show(
                    "Directory already exists. Do you want to continue anyway?", 
                    "Directory Exists", 
                    [System.Windows.Forms.MessageBoxButtons]::YesNo,
                    [System.Windows.Forms.MessageBoxIcon]::Question
                )
                if ($result -eq [System.Windows.Forms.DialogResult]::No) {
                    return $false
                }
            }
            
            $process = Start-Process -FilePath "git" -ArgumentList "clone", $repoUrl, $targetPath -Wait -PassThru -WindowStyle Hidden
            return $process.ExitCode -eq 0
        } catch {
            return $false
        }
    }
    
    [bool]ValidateRepository([string]$path, [string]$godotPath) {
        $projectFile = Join-Path $path "project.godot"
        if (-not (Test-Path $projectFile)) {
            return $false
        }
        
        try {
            $process = Start-Process -FilePath $godotPath -ArgumentList "--headless", "--editor", "--quit", "--path", $path -Wait -PassThru -WindowStyle Hidden
            return $process.ExitCode -eq 0
        } catch {
            return $false
        }
    }
}

# Create the main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Project Protean - Configuration Tool"
$form.Size = New-Object System.Drawing.Size(600, 500)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedSingle"
$form.MaximizeBox = $false

# Initialize managers
$configManager = [ConfigManager]::new()
$repoManager = [RepositoryManager]::new((Get-Location).Path)

# Title Label
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Text = "🎮 Project Protean Configuration"
$titleLabel.Size = New-Object System.Drawing.Size(550, 30)
$titleLabel.Location = New-Object System.Drawing.Point(25, 20)
$titleLabel.Font = New-Object System.Drawing.Font("Arial", 16, [System.Drawing.FontStyle]::Bold)
$titleLabel.ForeColor = [System.Drawing.Color]::DarkBlue
$form.Controls.Add($titleLabel)

# Godot Path Section
$godotLabel = New-Object System.Windows.Forms.Label
$godotLabel.Text = "Godot Engine Path:"
$godotLabel.Size = New-Object System.Drawing.Size(150, 20)
$godotLabel.Location = New-Object System.Drawing.Point(25, 70)
$form.Controls.Add($godotLabel)

$godotPathTextBox = New-Object System.Windows.Forms.TextBox
$godotPathTextBox.Size = New-Object System.Drawing.Size(350, 20)
$godotPathTextBox.Location = New-Object System.Drawing.Point(25, 95)
$godotPathTextBox.Text = $configManager.Settings.GodotPath
$form.Controls.Add($godotPathTextBox)

$browseDotButton = New-Object System.Windows.Forms.Button
$browseDotButton.Text = "Browse..."
$browseDotButton.Size = New-Object System.Drawing.Size(80, 25)
$browseDotButton.Location = New-Object System.Drawing.Point(385, 93)
$form.Controls.Add($browseDotButton)

$validateGodotButton = New-Object System.Windows.Forms.Button
$validateGodotButton.Text = "Test"
$validateGodotButton.Size = New-Object System.Drawing.Size(60, 25)
$validateGodotButton.Location = New-Object System.Drawing.Point(475, 93)
$form.Controls.Add($validateGodotButton)

# Default Clone Path Section
$cloneLabel = New-Object System.Windows.Forms.Label
$cloneLabel.Text = "Default Clone Directory:"
$cloneLabel.Size = New-Object System.Drawing.Size(150, 20)
$cloneLabel.Location = New-Object System.Drawing.Point(25, 135)
$form.Controls.Add($cloneLabel)

$clonePathTextBox = New-Object System.Windows.Forms.TextBox
$clonePathTextBox.Size = New-Object System.Drawing.Size(350, 20)
$clonePathTextBox.Location = New-Object System.Drawing.Point(25, 160)
$clonePathTextBox.Text = $configManager.Settings.DefaultClonePath
$form.Controls.Add($clonePathTextBox)

$browseCloneButton = New-Object System.Windows.Forms.Button
$browseCloneButton.Text = "Browse..."
$browseCloneButton.Size = New-Object System.Drawing.Size(80, 25)
$browseCloneButton.Location = New-Object System.Drawing.Point(385, 158)
$form.Controls.Add($browseCloneButton)

# Repository Section
$repoLabel = New-Object System.Windows.Forms.Label
$repoLabel.Text = "Repository URL:"
$repoLabel.Size = New-Object System.Drawing.Size(150, 20)
$repoLabel.Location = New-Object System.Drawing.Point(25, 200)
$form.Controls.Add($repoLabel)

$repoUrlTextBox = New-Object System.Windows.Forms.TextBox
$repoUrlTextBox.Size = New-Object System.Drawing.Size(430, 20)
$repoUrlTextBox.Location = New-Object System.Drawing.Point(25, 225)
$repoUrlTextBox.Text = $configManager.Settings.LastRepository
$form.Controls.Add($repoUrlTextBox)

# Project Name
$projectLabel = New-Object System.Windows.Forms.Label
$projectLabel.Text = "Project Name:"
$projectLabel.Size = New-Object System.Drawing.Size(150, 20)
$projectLabel.Location = New-Object System.Drawing.Point(25, 265)
$form.Controls.Add($projectLabel)

$projectNameTextBox = New-Object System.Windows.Forms.TextBox
$projectNameTextBox.Size = New-Object System.Drawing.Size(200, 20)
$projectNameTextBox.Location = New-Object System.Drawing.Point(25, 290)
$projectNameTextBox.Text = "Project-Protean"
$form.Controls.Add($projectNameTextBox)

# Auto-validate checkbox
$autoValidateCheckBox = New-Object System.Windows.Forms.CheckBox
$autoValidateCheckBox.Text = "Auto-validate after clone"
$autoValidateCheckBox.Size = New-Object System.Drawing.Size(200, 20)
$autoValidateCheckBox.Location = New-Object System.Drawing.Point(255, 290)
$autoValidateCheckBox.Checked = $configManager.Settings.AutoValidate
$form.Controls.Add($autoValidateCheckBox)

# Action Buttons
$cloneButton = New-Object System.Windows.Forms.Button
$cloneButton.Text = "🔄 Clone Repository"
$cloneButton.Size = New-Object System.Drawing.Size(120, 35)
$cloneButton.Location = New-Object System.Drawing.Point(25, 330)
$cloneButton.BackColor = [System.Drawing.Color]::LightGreen
$form.Controls.Add($cloneButton)

$validateButton = New-Object System.Windows.Forms.Button
$validateButton.Text = "✅ Validate Project"
$validateButton.Size = New-Object System.Drawing.Size(120, 35)
$validateButton.Location = New-Object System.Drawing.Point(155, 330)
$validateButton.BackColor = [System.Drawing.Color]::LightBlue
$form.Controls.Add($validateButton)

$openFolderButton = New-Object System.Windows.Forms.Button
        $openFolderButton.Text = "Open Folder"
$openFolderButton.Size = New-Object System.Drawing.Size(120, 35)
$openFolderButton.Location = New-Object System.Drawing.Point(285, 330)
$openFolderButton.BackColor = [System.Drawing.Color]::LightYellow
$form.Controls.Add($openFolderButton)

$saveConfigButton = New-Object System.Windows.Forms.Button
$saveConfigButton.Text = "💾 Save Config"
$saveConfigButton.Size = New-Object System.Drawing.Size(120, 35)
$saveConfigButton.Location = New-Object System.Drawing.Point(415, 330)
$saveConfigButton.BackColor = [System.Drawing.Color]::LightCoral
$form.Controls.Add($saveConfigButton)

# Status Label
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = "Ready"
$statusLabel.Size = New-Object System.Drawing.Size(550, 20)
$statusLabel.Location = New-Object System.Drawing.Point(25, 380)
$statusLabel.ForeColor = [System.Drawing.Color]::DarkGreen
$form.Controls.Add($statusLabel)

# Progress Bar
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Size = New-Object System.Drawing.Size(550, 20)
$progressBar.Location = New-Object System.Drawing.Point(25, 405)
$progressBar.Style = "Continuous"
$form.Controls.Add($progressBar)

# Event Handlers
$browseDotButton.Add_Click({
    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $openFileDialog.Filter = "Godot Executable (*.exe)|*.exe|All Files (*.*)|*.*"
    $openFileDialog.Title = "Select Godot Executable"
    $openFileDialog.InitialDirectory = Split-Path $godotPathTextBox.Text -Parent
    
    if ($openFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $godotPathTextBox.Text = $openFileDialog.FileName
    }
})

$browseCloneButton.Add_Click({
    $folderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderBrowserDialog.Description = "Select Default Clone Directory"
    $folderBrowserDialog.SelectedPath = $clonePathTextBox.Text
    
    if ($folderBrowserDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $clonePathTextBox.Text = $folderBrowserDialog.SelectedPath
    }
})

$validateGodotButton.Add_Click({
    $statusLabel.Text = "Testing Godot installation..."
    $statusLabel.ForeColor = [System.Drawing.Color]::Orange
    $form.Refresh()
    
    if ($configManager.ValidateGodotPath($godotPathTextBox.Text)) {
        try {
            $process = Start-Process -FilePath $godotPathTextBox.Text -ArgumentList "--version" -Wait -PassThru -WindowStyle Hidden -RedirectStandardOutput "temp_version.txt"
            $version = Get-Content "temp_version.txt" -ErrorAction SilentlyContinue
            Remove-Item "temp_version.txt" -ErrorAction SilentlyContinue
            
            $statusLabel.Text = "✅ Godot validated: $version"
            $statusLabel.ForeColor = [System.Drawing.Color]::DarkGreen
        } catch {
            $statusLabel.Text = "⚠️ Godot path exists but version check failed"
            $statusLabel.ForeColor = [System.Drawing.Color]::Orange
        }
    } else {
        $statusLabel.Text = "❌ Invalid Godot path"
        $statusLabel.ForeColor = [System.Drawing.Color]::Red
    }
})

$cloneButton.Add_Click({
    $repoUrl = $repoUrlTextBox.Text.Trim()
    $projectName = $projectNameTextBox.Text.Trim()
    $targetPath = Join-Path $clonePathTextBox.Text $projectName
    
    if ([string]::IsNullOrEmpty($repoUrl) -or [string]::IsNullOrEmpty($projectName)) {
        [System.Windows.Forms.MessageBox]::Show("Please fill in repository URL and project name.", "Missing Information", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        return
    }
    
    $statusLabel.Text = "Cloning repository..."
    $statusLabel.ForeColor = [System.Drawing.Color]::Orange
    $progressBar.Style = "Marquee"
    $form.Refresh()
    
    if ($repoManager.CloneRepository($repoUrl, $targetPath)) {
        $statusLabel.Text = "✅ Repository cloned successfully to: $targetPath"
        $statusLabel.ForeColor = [System.Drawing.Color]::DarkGreen
        
        if ($autoValidateCheckBox.Checked) {
            $statusLabel.Text += " | Validating..."
            $form.Refresh()
            
            if ($repoManager.ValidateRepository($targetPath, $godotPathTextBox.Text)) {
                $statusLabel.Text = "✅ Repository cloned and validated successfully!"
            } else {
                $statusLabel.Text += " | ⚠️ Validation failed"
                $statusLabel.ForeColor = [System.Drawing.Color]::Orange
            }
        }
    } else {
        $statusLabel.Text = "❌ Failed to clone repository"
        $statusLabel.ForeColor = [System.Drawing.Color]::Red
    }
    
    $progressBar.Style = "Continuous"
})

$validateButton.Add_Click({
    $currentPath = Join-Path $clonePathTextBox.Text $projectNameTextBox.Text
    
    if (-not (Test-Path $currentPath)) {
        $currentPath = (Get-Location).Path
    }
    
    $statusLabel.Text = "Validating project at: $currentPath"
    $statusLabel.ForeColor = [System.Drawing.Color]::Orange
    $form.Refresh()
    
    if ($repoManager.ValidateRepository($currentPath, $godotPathTextBox.Text)) {
        $statusLabel.Text = "✅ Project validation successful!"
        $statusLabel.ForeColor = [System.Drawing.Color]::DarkGreen
    } else {
        $statusLabel.Text = "❌ Project validation failed"
        $statusLabel.ForeColor = [System.Drawing.Color]::Red
    }
})

$openFolderButton.Add_Click({
    $targetPath = Join-Path $clonePathTextBox.Text $projectNameTextBox.Text
    
    if (Test-Path $targetPath) {
        Start-Process -FilePath "explorer.exe" -ArgumentList $targetPath
        $statusLabel.Text = "📁 Opened folder: $targetPath"
        $statusLabel.ForeColor = [System.Drawing.Color]::DarkBlue
    } else {
        if (Test-Path $clonePathTextBox.Text) {
            Start-Process -FilePath "explorer.exe" -ArgumentList $clonePathTextBox.Text
            $statusLabel.Text = "📁 Opened parent folder: $($clonePathTextBox.Text)"
            $statusLabel.ForeColor = [System.Drawing.Color]::DarkBlue
        } else {
            $statusLabel.Text = "❌ Folder not found"
            $statusLabel.ForeColor = [System.Drawing.Color]::Red
        }
    }
})

$saveConfigButton.Add_Click({
    $configManager.Settings.GodotPath = $godotPathTextBox.Text
    $configManager.Settings.DefaultClonePath = $clonePathTextBox.Text
    $configManager.Settings.LastRepository = $repoUrlTextBox.Text
    $configManager.Settings.AutoValidate = $autoValidateCheckBox.Checked
    
    $configManager.SaveConfig()
    
    $statusLabel.Text = "Configuration saved successfully!"
    $statusLabel.ForeColor = [System.Drawing.Color]::DarkGreen
})

# Show the form
[System.Windows.Forms.Application]::EnableVisualStyles()
$form.ShowDialog() | Out-Null
