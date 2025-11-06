# 🚀 Project Setup Guide

## For Team Members

This project uses a `.gitignore` file to prevent machine-specific files from being tracked in Git.

### 📦 First-Time Setup

When you clone this repository for the first time:

```bash
# 1. Clone the repository
git clone <your-repo-url>
cd ProjectDart_OOP

# 2. Install dependencies
dart pub get

# 3. Run tests to verify everything works
dart test

# 4. Run the application
dart run lib/main.dart
```

### 🔄 After Pulling Changes

Every time you pull changes from Git:

```bash
# Pull latest changes
git pull

# Update dependencies (important!)
dart pub get

# Verify everything works
dart test
```

### ⚠️ Important: Machine-Specific Files

The following files/directories are **automatically generated** and should **NOT** be committed:

- `.dart_tool/` - Dart build cache (contains machine-specific paths)
- `.vscode/` - VS Code settings (optional, user-specific)
- `.idea/` - IntelliJ/Android Studio settings (optional)
- `build/` - Build output
- `coverage/` - Test coverage reports

These are already in `.gitignore` and will be ignored by Git.

### ✅ What SHOULD Be Committed

Only commit:
- Source code (`lib/`, `test/`)
- Configuration files (`pubspec.yaml`)
- Documentation (`README.md`, `SETUP.md`)
- Data files (`data/prescriptions.json` - if you want to share sample data)

### 🐛 Troubleshooting

**Problem**: Seeing conflicts in `.dart_tool/package_config.json`

**Solution**: 
```bash
# Delete your local .dart_tool folder
rm -rf .dart_tool/

# Pull latest changes
git pull

# Regenerate the cache
dart pub get
```

**Problem**: Tests failing after pulling

**Solution**:
```bash
# Clean and reinstall
dart pub get
dart test
```

### 📝 Quick Commands

| Command | Purpose |
|---------|---------|
| `dart pub get` | Install/update dependencies |
| `dart test` | Run all tests |
| `dart run lib/main.dart` | Run the application |
| `git status` | Check what files changed |
| `git pull` | Get latest changes |
| `git add .` | Stage all changes |
| `git commit -m "message"` | Commit changes |
| `git push` | Push to repository |

### 🤝 Workflow for Collaboration

1. **Before starting work**:
   ```bash
   git pull
   dart pub get
   ```

2. **After making changes**:
   ```bash
   dart test  # Make sure tests pass
   git add .
   git commit -m "Your descriptive message"
   git push
   ```

3. **If you get conflicts**:
   ```bash
   # Resolve conflicts in files
   # Then:
   git add .
   git commit -m "Resolve merge conflicts"
   git push
   ```

### 💡 Pro Tips

- Always run `dart pub get` after pulling changes
- Run tests before pushing (`dart test`)
- Write clear commit messages
- Pull before you start working
- Commit frequently with small, logical changes

---

**Need Help?** Contact your team member! 👋
