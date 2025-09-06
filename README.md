# Project Protean

![Build Status](https://github.com/Pandai-Games/Project-Protean/workflows/Build%20and%20Deploy%20Godot%20Game/badge.svg)
![Code Quality](https://github.com/Pandai-Games/Project-Protean/workflows/Code%20Quality/badge.svg)

A Godot 4.4 game project with automated CI/CD pipeline for building and deploying across multiple platforms.

## 🎮 Features
- Cross-platform builds (Windows, Linux, Mac, Web)
- Automated GitHub Actions CI/CD pipeline
- Code quality checks and validation
- Automatic deployment to GitHub Pages for web builds

## 🚀 Getting Started

### Prerequisites
- Godot 4.4 or later
- Git

### Streamlined Development Setup
This project is pre-configured for seamless Godot + VS Code development:

1. **Clone this repository**:
   ```bash
   git clone https://github.com/Pandai-Games/Project-Protean.git
   cd Project-Protean
   ```

2. **Open in VS Code** and start coding:
   ```bash
   code .
   ```

3. **That's it!** - Language Server auto-connects, auto-save enabled, full IntelliSense ready

### Alternative: Configuration Tool Setup
For advanced configuration or repository management:

1. **Run the configuration tool**:
   - **GUI Version**: `protean-config.bat` (Windows Forms interface)
   - **CLI Version**: `protean-cli.bat` (Command-line interface)
2. **Configure settings**: Godot path, clone directory, repository URL
3. **Clone and validate** projects automatically

### Manual Development Setup
1. Clone this repository:
   ```bash
   git clone https://github.com/Pandai-Games/Project-Protean.git
   cd Project-Protean
   ```

2. Open Godot 4.4 and import the project by selecting the `project.godot` file.

3. Start building your game!

### Configuration Tools Documentation
For detailed information about the configuration tools, see [`CONFIG-TOOL-README.md`](CONFIG-TOOL-README.md).

## 📁 Project Structure
- `scenes/` — Godot scenes (.tscn files)
- `scripts/` — GDScript (.gd) and C# scripts
- `assets/` — Images, audio, and other game assets
- `.github/workflows/` — CI/CD pipeline configurations
- `export_presets.cfg` — Export settings for different platforms

## 🔄 CI/CD Pipeline

The project includes automated GitHub Actions workflows:

### Build and Deploy (`build-and-deploy.yml`)
- **Triggers**: Push to `main`/`develop` branches, PRs to `main`
- **Builds**: Windows, Linux, Mac, and Web versions
- **Artifacts**: Downloadable build files for each platform
- **Auto-deploy**: Web version automatically deploys to GitHub Pages

### Code Quality (`quality.yml`)
- **Triggers**: Push to `main`/`develop` branches, PRs to `main`
- **Checks**: GDScript linting and project validation
- **Validation**: Ensures project integrity before builds

## 🌐 Web Demo
Visit the live web demo: `https://Pandai-Games.github.io/Project-Protean`

## 📦 Downloads
Download the latest builds from the [Releases](https://github.com/Pandai-Games/Project-Protean/releases) page.

## 🛠️ Development Workflow

### Seamless Development
With the streamlined setup, development is simplified:

1. **Code in VS Code** - Full language support, auto-save, error detection
2. **Test in Godot** - Run scenes directly, instant feedback
3. **Debug easily** - F5 to attach debugger, breakpoints work seamlessly
4. **Auto-validation** - CI/CD pipeline validates all commits automatically

### Optional: Manual Validation
If you want to validate locally before committing:

**Configuration Tool:**
- Run `protean-cli.bat` → select "Validate Project"
- Or use `protean-config.bat` → click "Validate Project"

**Command Line:**

**Windows:**
```bash
./validate.bat
```
*Uses Godot installation at: `E:\Godot\Godot_v4.4-stable_win64.exe`*

**Linux/Mac:**
```bash
chmod +x validate.sh
./validate.sh
```
*Requires Godot to be in system PATH*

## 💻 Development Environment

### Streamlined GDScript Development
This project features a seamless Godot + VS Code integration:

- **Zero-Command Workflow** - No manual tasks or complex commands needed
- **Auto-Integration** - Language Server connects automatically
- **Auto-Save** - Changes saved automatically every second
- **One-Click Debugging** - F5 to start debugging
- **Full IntelliSense** - Auto-completion, error detection, navigation

For the complete streamlined workflow guide, see [`STREAMLINED-WORKFLOW.md`](STREAMLINED-WORKFLOW.md)

#### Instant Development Start
1. **Open VS Code** in the project directory
2. **Edit any .gd file** - full IDE support loads automatically
3. **Run in Godot** - test your changes directly in Godot
4. **Debug** - press F5 to attach debugger

No commands, no tasks, just pure development! 🚀

### Git Workflow
1. **Create a feature branch**: `git checkout -b feature/new-feature`
2. **Make your changes** and commit them
3. **Validate locally** using the validation script
4. **Push to your branch**: `git push origin feature/new-feature` 
5. **Create a Pull Request** to the `main` branch
6. **CI/CD pipeline** will automatically build and test your changes
7. **Merge** after review and successful builds

## 📋 Export Settings

The project is pre-configured with export presets for:
- **Windows Desktop** (.exe)
- **Linux/X11** (x86_64)
- **Web** (HTML5)
- **Mac OSX** (Universal binary)

## 🤝 Contributing
1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

---

**Note**: This is Project Protean by Pandai Games.
