# GDScript Development Setup for Project Protean

This document outlines the complete development environment setup for GDScript development in VS Code with Project Protean.

## 🛠️ Installed Extensions

The following VS Code extensions have been installed and configured for optimal GDScript development:

### Core Extensions
- **Godot Tools** (`geequlim.godot-tools`) - Primary GDScript language support, LSP, and debugging
- **Godot Files** (`alfish.godot-files`) - Enhanced file support for Godot assets and resources
- **GDScript Formatter & Linter** (`eddiedover.gdscript-formatter-linter`) - Code formatting and linting

### Enhancement Extensions
- **Better Comments Next** (`edwinhuish.better-comments-next`) - Improved code commenting
- **GDScript Theme** (`jamessauer.gdscript-theme`) - Godot-like color theme

## 📁 VS Code Configuration

### Settings (`.vscode/settings.json`)
Pre-configured with:
- Godot Editor path: `E:\Godot\Godot_v4.4-stable_win64.exe`
- LSP server configuration (host: 127.0.0.1, port: 6005)
- GDScript-specific formatting rules
- File associations for Godot file types
- Optimized editor settings for GDScript development

### Tasks (`.vscode/tasks.json`)
Available tasks:
- **Open Godot Editor** - Launch Godot with current project
- **Run Godot Project** - Run the game directly
- **Validate Godot Project** - Validate project integrity
- **Export Windows Build** - Create Windows executable
- **Run Configuration Tool** - Launch project configuration utility

### Debug Configuration (`.vscode/launch.json`)
Debug configurations:
- **Launch Godot Project** - Start debugging session
- **Attach to Godot** - Attach debugger to running Godot instance

## 🚀 Getting Started

### 1. Language Server Setup
The Godot Language Server must be enabled in Godot for full IDE features:

1. Open Godot Editor:
   ```
   Ctrl+Shift+P → "Tasks: Run Task" → "Open Godot Editor"
   ```

2. In Godot, go to:
   ```
   Editor → Editor Settings → Network → Language Server
   ```

3. Enable:
   - ✅ Enable Language Server
   - ✅ Use Thread
   - Set Port: `6005` (default)

### 2. Development Workflow

#### Starting Development
1. **Open VS Code** in the project directory
2. **Start Language Server**: Run "Open Godot Editor" task
3. **Begin Coding**: VS Code will connect to Godot's LSP automatically

#### Running/Testing
- **Run Project**: `Ctrl+Shift+P` → "Tasks: Run Task" → "Run Godot Project"
- **Debug**: `F5` or use Debug panel → "Launch Godot Project"
- **Validate**: Use "Validate Godot Project" task

#### Building
- **Export Build**: Use "Export Windows Build" task
- **CI/CD**: Automatic builds via GitHub Actions (see `.github/workflows/`)

## 🎯 IDE Features Available

### Code Intelligence
- ✅ **Syntax Highlighting** - Full GDScript syntax support
- ✅ **Auto-completion** - Context-aware suggestions
- ✅ **Error Detection** - Real-time syntax and semantic errors
- ✅ **Code Navigation** - Go to definition, find references
- ✅ **Hover Information** - Documentation on hover

### Code Quality
- ✅ **Formatting** - Automatic code formatting on save
- ✅ **Linting** - Style and best practice suggestions
- ✅ **Error Checking** - Real-time error detection
- ✅ **Code Folding** - Collapse code blocks

### Debugging
- ✅ **Breakpoints** - Set breakpoints in GDScript
- ✅ **Variable Inspection** - View variable values during debug
- ✅ **Call Stack** - Navigate execution flow
- ✅ **Watch Expressions** - Monitor specific values

### Project Management
- ✅ **File Explorer** - Godot-aware file filtering
- ✅ **Search** - Project-wide code search (excludes .godot)
- ✅ **Git Integration** - Version control with GitHub
- ✅ **Task Runner** - One-click Godot operations

## 🔧 Configuration Details

### File Associations
```json
{
    "*.gd": "gdscript",
    "*.tres": "tres", 
    "*.tscn": "tscn",
    "*.godot": "godot-project",
    "*.cfg": "ini",
    "*.gdshader": "gdshader"
}
```

### Excluded Files
- `.godot/` - Build artifacts
- `.import/` - Import cache
- `addons/` folders are visible

### Editor Settings for GDScript
- **Indentation**: Tabs (4 spaces width)
- **Format on Save**: Enabled
- **Word Wrap**: Enabled
- **Rulers**: 80, 100 characters
- **Auto-completion**: Enabled with call hints

## 🐛 Troubleshooting

### Language Server Not Working
1. Ensure Godot Editor is running with the project open
2. Check Godot's Language Server is enabled (Editor Settings → Network → Language Server)
3. Verify port 6005 is not blocked by firewall
4. Restart both VS Code and Godot

### Debugging Issues
1. Ensure Godot project is running when trying to attach
2. Check debug port (6007) is available
3. Verify Godot's remote debugging is enabled

### Formatting Problems
1. Check GDScript Formatter extension is enabled
2. Verify format on save is enabled in settings
3. Ensure file is saved as `.gd` extension

### Performance Issues
1. Exclude large asset folders from search
2. Close unnecessary Godot instances
3. Check VS Code extension host performance

## 📚 Additional Resources

- [Godot Documentation](https://docs.godotengine.org/)
- [GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- [VS Code Godot Tools Wiki](https://github.com/godotengine/godot-vscode-plugin/wiki)
- [Project Protean Repository](https://github.com/Pandai-Games/Project-Protean)

## 🎮 Development Commands

### Quick Commands (Ctrl+Shift+P)
- `Godot Tools: Open Project in Godot`
- `Godot Tools: Run Project`
- `Tasks: Run Task` → Select from available tasks
- `Debug: Start Debugging`

### Keyboard Shortcuts
- `F5` - Start Debugging
- `Ctrl+Shift+B` - Run Build Task (Run Godot Project)
- `Ctrl+K Ctrl+O` - Open Folder
- `Ctrl+Shift+E` - Focus on Explorer

---

**Happy Coding with Project Protean! 🚀**
