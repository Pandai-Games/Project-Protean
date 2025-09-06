# Streamlined Godot + VS Code Workflow

This project is now configured for seamless Godot development in VS Code without manual commands.

## 🚀 How It Works

### Automatic Integration
- **Open VS Code** in this project directory
- **Godot will auto-connect** via Language Server when you edit .gd files
- **Auto-save** is enabled (saves every 1 second)
- **Language features** work automatically (completion, errors, navigation)

### Simple Workflow
1. **Open VS Code** in the project folder
2. **Start coding** - edit any .gd file
3. **Run in Godot** - press F6 in Godot or use Run button
4. **Debug** - press F5 in VS Code (attaches to running Godot)

### Optional: Auto-start Godot
If you want Godot to automatically open when you start working:
```powershell
# Run this once to start Godot automatically
.\.vscode\auto-start-godot.ps1
```

## 🎯 What Changed

### Removed Manual Commands
- ❌ No more Ctrl+Shift+P → Tasks
- ❌ No more manual "Open Godot Editor" commands
- ❌ No more complex task runners

### Simplified Setup
- ✅ Direct Godot integration
- ✅ Auto-save enabled
- ✅ One-click debugging (F5)
- ✅ Seamless language support

## 🎮 Development Flow

### Daily Workflow:
1. **Open VS Code** in project directory
2. **Edit .gd files** with full IntelliSense
3. **Test in Godot** - run scenes directly in Godot
4. **Debug** - F5 in VS Code to attach debugger

### Key Shortcuts:
- **F5** - Start debugging (attaches to Godot)
- **Ctrl+S** - Save (auto-save also enabled)
- **Ctrl+Shift+I** - Format code
- **Ctrl+Click** - Go to definition

No complex commands needed - just code and run! 🎉
