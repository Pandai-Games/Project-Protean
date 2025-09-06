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

### Quick Setup with Configuration Tool
We provide a comprehensive configuration tool to help you get started quickly:

1. **Download/Clone the repository** and navigate to the project directory
2. **Run the configuration tool**:
   - **GUI Version**: `protean-config-clean.bat` (Windows Forms interface)
   - **CLI Version**: `protean-cli.bat` (Command-line interface)
3. **Configure your settings**:
   - Set your Godot 4.4 installation path
   - Choose where to clone repositories
   - Configure the repository URL
4. **Clone and validate** the project automatically

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

### Local Validation
Before committing changes, validate your project locally:

**Using Configuration Tool:**
- Run `protean-cli.bat` and select option 5 (Validate Project)
- Or use the GUI tool `protean-config-clean.bat` and click "Validate Project"

**Manual Validation:**

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
