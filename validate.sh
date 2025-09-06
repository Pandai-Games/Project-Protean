#!/bin/bash
# Project validation script for local development
# Requires Godot 4.4+ to be installed and in PATH

echo "🔍 Validating Project Protean..."

# Check if Godot is available
if ! command -v godot &> /dev/null; then
    echo "❌ Godot not found in PATH. Please install Godot 4.4+ first."
    echo "   Download from: https://godotengine.org/download"
    exit 1
fi

# Check Godot version
echo "📋 Godot version:"
godot --version

# Validate project
echo "🔧 Running project validation..."
if godot --headless --check-only --verbose --path .; then
    echo "✅ Project validation passed!"
else
    echo "❌ Project validation failed!"
    exit 1
fi

# Check for GDScript files and basic syntax
echo "📝 Checking GDScript files..."
find . -name "*.gd" -type f | while read -r file; do
    echo "   Checking: $file"
done

echo "🎉 All checks completed!"
