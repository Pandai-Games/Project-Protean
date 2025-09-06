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

### Local Development
1. Clone this repository:
   ```bash
   git clone https://github.com/Pandai-Games/Project-Protean.git
   cd Project-Protean
   ```

2. Open Godot 4.4 and import the project by selecting the `project.godot` file.

3. Start building your game!

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

1. **Create a feature branch**: `git checkout -b feature/new-feature`
2. **Make your changes** and commit them
3. **Push to your branch**: `git push origin feature/new-feature` 
4. **Create a Pull Request** to the `main` branch
5. **CI/CD pipeline** will automatically build and test your changes
6. **Merge** after review and successful builds

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
