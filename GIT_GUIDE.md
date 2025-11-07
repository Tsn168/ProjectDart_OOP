# Git Setup & Commit Guide

## Initial Git Setup (if not already done)

```bash
# Check current status
git status

# Configure Git (if needed)
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

## Committing the Project

### Option 1: Single Commit (Recommended for initial setup)

```bash
# Add all files
git add .

# Commit everything
git commit -m "feat: Complete Mini Hospital Medication Manager implementation

- Implement 3-layer architecture (Domain, Data, UI)
- Add auto-incrementing IDs for Patient, Medication, Prescription
- Create allergy safety checking system
- Implement JSON data persistence
- Add comprehensive unit tests (20 tests passing)
- Create doctor and nurse user interfaces
- Add stock management for medications
- Include README and QUICKSTART documentation"

# Push to remote (if repository is set up)
git push origin main
```

### Option 2: Multiple Commits (Detailed history)

```bash
# Commit Domain Layer
git add lib/domain/
git commit -m "feat: Add domain entities and enums"

# Commit Data Layer
git add lib/data/
git commit -m "feat: Implement repositories and safety service"

# Commit UI Layer
git add lib/ui/
git commit -m "feat: Create console user interface"

# Commit Tests
git add test/
git commit -m "test: Add comprehensive unit tests"

# Commit Configuration
git add pubspec.yaml .gitignore
git commit -m "chore: Add project configuration"

# Commit Documentation
git add README.md QUICKSTART.md
git commit -m "docs: Add README and quick start guide"

# Push all commits
git push origin main
```

## Checking What Will Be Committed

```bash
# See what files are changed
git status

# See the differences
git diff

# See what will be committed
git diff --staged
```

## Creating a New Branch (for team collaboration)

```bash
# Create and switch to feature branch
git checkout -b feature/your-feature-name

# Make changes and commit
git add .
git commit -m "feat: Add your feature"

# Push branch
git push origin feature/your-feature-name
```

## Recommended .gitignore (already included)

```
.dart_tool/
.packages
.pub-cache/
.pub/
build/
.vscode/
.idea/
.DS_Store
```

Note: JSON data files in `data/` folder are NOT ignored because they contain important sample data that can be useful for team members.

## Viewing Commit History

```bash
# View commit log
git log --oneline

# View detailed log
git log

# View changes in last commit
git show
```

## Syncing with Remote Repository

```bash
# Pull latest changes
git pull origin main

# Push your changes
git push origin main
```

## Tagging a Release

```bash
# Create a tag for version 1.0.0
git tag -a v1.0.0 -m "Release version 1.0.0 - Initial medication manager"

# Push tag to remote
git push origin v1.0.0

# View all tags
git tag
```

## Team Collaboration Workflow

### For Team Members:

1. **Clone the repository**
   ```bash
   git clone https://github.com/Tsn168/ProjectDart_OOP.git
   cd ProjectDart_OOP
   ```

2. **Install dependencies**
   ```bash
   dart pub get
   ```

3. **Run tests to verify setup**
   ```bash
   dart test
   ```

4. **Create feature branch**
   ```bash
   git checkout -b feature/your-name-feature
   ```

5. **Make changes and commit**
   ```bash
   git add .
   git commit -m "feat: Your feature description"
   ```

6. **Push and create pull request**
   ```bash
   git push origin feature/your-name-feature
   ```

### Before Committing (Quality Checks):

```bash
# Format code
dart format .

# Analyze code
dart analyze

# Run tests
dart test

# If all pass, commit!
git add .
git commit -m "Your commit message"
```

## Useful Git Commands

```bash
# Undo last commit (keep changes)
git reset --soft HEAD~1

# Discard all local changes
git reset --hard HEAD

# View file history
git log --follow -- path/to/file.dart

# Show who changed what in a file
git blame path/to/file.dart

# Create a branch from specific commit
git checkout -b branch-name commit-hash
```

## Conventional Commit Messages

Use these prefixes for clear commit history:

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `test:` Adding or updating tests
- `refactor:` Code refactoring
- `style:` Code style changes (formatting)
- `chore:` Maintenance tasks

**Examples:**
```bash
git commit -m "feat: Add medication stock alert system"
git commit -m "fix: Correct auto-increment ID generation"
git commit -m "docs: Update README with API examples"
git commit -m "test: Add tests for allergy conflict detection"
```

---

**Ready to commit? Run the commands above! 🚀**
