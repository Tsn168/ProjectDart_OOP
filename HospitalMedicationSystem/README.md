# Hospital Medication Management System

A simple, safety-focused hospital medication management system built with Dart.

## Features

- ✅ Staff authentication (Doctor/Nurse roles)
- ✅ Patient allergy tracking
- ✅ Prescription creation with safety checks
- ✅ Medication administration tracking
- ✅ Automatic stock management
- ✅ JSON file storage
- ✅ Extensive enum usage for type safety

## Setup

```bash
# Get dependencies
dart pub get

# Run the application
dart run lib/main.dart

# Run tests
dart test
```

## Project Structure

```
/lib
  /domain/       # Entities, enums, value objects
  /data/         # JSON repositories
  /services/     # Business logic & safety checks
  /ui/           # Console interface
/data/           # JSON data files (Git tracked)
/test/           # Unit tests
```

## Usage

1. Start the application
2. Login with staff ID (D001 for doctor, N001 for nurse)
3. Follow the menu prompts

## Safety Features

- Allergy conflict detection
- Stock availability validation
- Prescription status management
- Administration history logging
