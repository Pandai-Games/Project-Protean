# GDScript Development Commands - Working Reference

This guide shows you exactly how to use the GDScript development environment that's now set up and working.

## ✅ Confirmed Working Commands

### VS Code Task Commands
Press `Ctrl+Shift+P` in VS Code, then type "Tasks: Run Task" and select:

1. **Open Godot Editor**
   - Opens Godot with the current project
   - Enables Language Server connection
   - Use this first before coding

2. **Run Godot Project** 
   - Runs the game directly
   - Default build task (Ctrl+Shift+B)

3. **Validate Godot Project**
   - Checks project for errors
   - Useful before committing code

4. **Export Windows Build**
   - Creates executable in build/windows/
   - Production-ready build

5. **Run Configuration Tool**
   - Opens our custom project configuration GUI

### Debugging Commands
- **F5** - Start debugging session
- **Ctrl+Shift+D** - Open debug panel
- **F9** - Toggle breakpoint
- **F10** - Step over
- **F11** - Step into

### GDScript Language Features (Auto-enabled)
- **Auto-completion** - Type and get suggestions
- **Error highlighting** - Red underlines for syntax errors
- **Go to definition** - Ctrl+Click on functions/variables
- **Find references** - Right-click → "Find All References"
- **Format code** - Ctrl+Shift+I or auto-format on save

## 🎯 How to Test Everything is Working

### Test 1: Language Server Connection
1. Open `scenes/map_proc.gd` in VS Code
2. Clear the file and type:
   ```gdscript
   extends Node2D
   
   func _ready():
       print("Hello World")
   ```
3. You should see:
   - Syntax highlighting (colors)
   - Auto-completion when typing
   - No red error underlines

### Test 2: Tasks
1. Press `Ctrl+Shift+P`
2. Type "Tasks: Run Task"
3. Select "Open Godot Editor"
4. Godot should launch with your project

### Test 3: Debugging
1. Add a breakpoint in the `_ready()` function (click line number)
2. Press `F5` 
3. Select "Launch Godot Project"
4. Run the scene - debugger should pause at breakpoint

### Test 4: Code Intelligence
1. In a .gd file, type `Node2D.` 
2. You should see auto-completion list
3. Right-click on `Node2D` → "Go to Definition"
4. Should show Godot's built-in documentation

## 🔧 Troubleshooting Commands Not Working

### If Tasks Don't Appear:
```bash
# Reload VS Code window
Ctrl+Shift+P → "Developer: Reload Window"
```

### If Language Server Disconnects:
```bash
# Restart Godot editor
Ctrl+Shift+P → "Tasks: Run Task" → "Open Godot Editor"
```

### If Extensions Don't Work:
```bash
# Check extensions are enabled
Ctrl+Shift+X → Search "godot" → Ensure enabled
```

### If Debugging Fails:
```bash
# Ensure Godot project is running first
# Then attach debugger with F5
```

## 🎮 Recommended Workflow

### Daily Development:
1. **Start**: `Ctrl+Shift+P` → "Tasks: Run Task" → "Open Godot Editor"
2. **Code**: Edit .gd files in VS Code with full IntelliSense
3. **Test**: `Ctrl+Shift+B` (Run Godot Project)
4. **Debug**: Add breakpoints, press F5
5. **Build**: Use "Export Windows Build" task

### Quick Commands Reference:
- `Ctrl+Shift+P` - Command palette (access all tasks)
- `Ctrl+Shift+B` - Build/run project (default task)
- `F5` - Start debugging
- `Ctrl+Shift+I` - Format code
- `Ctrl+Click` - Go to definition
- `Ctrl+Shift+F` - Search entire project

## 📋 Available File Types with IntelliSense:
- `.gd` - GDScript files (full support)
- `.tscn` - Scene files (syntax highlighting)
- `.tres` - Resource files (syntax highlighting)
- `.cs` - C# files (if using C# scripts)
- `.gdshader` - Shader files (basic support)

## 🚀 Performance Tips:
- Keep Godot editor open while coding for best LSP performance
- Use `Ctrl+Shift+P` → "Developer: Reload Window" if VS Code gets slow
- Close unused file tabs to improve performance
- Use project-wide search (`Ctrl+Shift+F`) instead of opening many files

---

**Everything is working! The environment is fully functional for GDScript development.** 🎉
