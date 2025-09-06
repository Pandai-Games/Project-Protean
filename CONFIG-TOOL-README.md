# Project Protean Configuration Tool

A comprehensive GUI and CLI tool for managing Project Protean repository settings, Godot engine configuration, and repository cloning/importing.

## 🚀 Features

### GUI Version (`protean-config.exe` / `protean-config.bat`)
- **Visual Interface** - Easy-to-use Windows Forms GUI
- **Godot Path Configuration** - Browse and test Godot engine installation
- **Repository Management** - Clone repositories with validation
- **Settings Persistence** - Automatically saves configuration to JSON
- **Project Validation** - Test Godot projects for compatibility
- **Folder Management** - Quick access to project directories

### CLI Version (`protean-cli.exe` / `protean-cli.ps1`)
- **Command Line Interface** - Script-friendly automation
- **Batch Operations** - Suitable for CI/CD integration
- **Parameter Support** - Pass settings via command line
- **Non-interactive Mode** - Perfect for automated workflows

## 📋 Requirements

- **Windows 10/11** with PowerShell 5.1+
- **Git** installed and available in PATH
- **Godot 4.4+** (path configurable via tool)
- **.NET Framework 4.7.2+** (for GUI components)

## 🛠️ Installation & Usage

### Quick Start (No Installation Required)
```bash
# Run the GUI configuration tool
.\protean-config.bat

# Run the CLI version
.\protean-cli.bat
```

### Build Standalone Executables
```bash
# Build both GUI and CLI executables
.\build-config-tool.bat
```

This will create:
- `protean-config.exe` - Standalone GUI application
- `protean-cli.exe` - Standalone CLI application

## 📖 Usage Guide

### GUI Mode
1. **Launch** the tool: `.\protean-config.bat` or `protean-config.exe`
2. **Configure Godot Path** - Browse to your Godot installation
3. **Set Clone Directory** - Choose where to clone repositories
4. **Enter Repository URL** - Default is Project Protean repository
5. **Clone & Validate** - One-click clone with automatic validation

### CLI Mode
```powershell
# Interactive mode
.\protean-cli.ps1

# Clone repository
.\protean-cli.ps1 -RepoUrl "https://github.com/Pandai-Games/Project-Protean.git"

# Set custom paths
.\protean-cli.ps1 -GodotPath "C:\Godot\godot.exe" -ClonePath "C:\Projects"

# Non-GUI mode
.\protean-cli.ps1 -GUI:$false
```

## 🔧 Configuration

The tool automatically creates `protean-config.json` with your settings:

```json
{
  "GodotPath": "E:\\Godot\\Godot_v4.4-stable_win64.exe",
  "DefaultClonePath": "C:\\Users\\Username\\Documents\\GameProjects",
  "LastRepository": "https://github.com/Pandai-Games/Project-Protean.git",
  "AutoValidate": true
}
```

## 🎯 Key Functions

### Repository Operations
- **Clone** - Git clone with directory checking
- **Validate** - Godot project validation
- **Browse** - Open project folders in Explorer

### Godot Integration
- **Path Detection** - Automatic Godot executable validation
- **Version Check** - Display Godot version information
- **Project Testing** - Headless project validation

### Settings Management
- **Persistent Storage** - JSON-based configuration
- **Path Browsing** - File/folder picker dialogs
- **Auto-validation** - Optional post-clone validation

## 🐛 Troubleshooting

### Common Issues

**"PS2EXE module not found"**
- Run PowerShell as Administrator
- Execute: `Install-Module -Name PS2EXE -Force`

**"Git not found"**
- Install Git from [git-scm.com](https://git-scm.com/)
- Ensure Git is in your system PATH

**"Godot validation failed"**
- Verify Godot path is correct
- Ensure Godot 4.4+ is installed
- Check project.godot file exists

**"PowerShell execution policy"**
- Run: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

## 📁 File Structure

```
├── protean-config.ps1        # Main GUI PowerShell script
├── protean-config.bat        # GUI launcher batch file
├── protean-cli.ps1           # CLI PowerShell script
├── protean-cli.bat           # CLI launcher batch file
├── build-config-tool.bat     # Build script for executables
├── protean-config.json       # Auto-generated configuration
├── protean-config.exe        # Compiled GUI executable (after build)
└── protean-cli.exe           # Compiled CLI executable (after build)
```

## 🤝 Contributing

This tool is part of Project Protean. To contribute:
1. Fork the repository
2. Create a feature branch
3. Make your changes to the configuration tools
4. Test with both GUI and CLI modes
5. Submit a pull request

## 📄 License

Part of Project Protean - Licensed under MIT License.

---

**🎮 Project Protean Configuration Tool v1.0**  
*Made with ❤️ by Pandai Games*
