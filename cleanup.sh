#!/bin/bash
# Cleanup script - Remove unnecessary files and keep only NEW VERSION

echo "🧹 Cleaning up unnecessary files..."

# Remove OLD version files
rm -f lib/main.dart
rm -f lib/hospital_management.dart

# Remove OLD domain files (replaced by simpler versions)
rm -f lib/domain/prescription.dart
rm -f lib/domain/staff.dart
rm -f lib/domain/nurse.dart
rm -f lib/domain/patient.dart
rm -f lib/domain/injection.dart
rm -f lib/domain/medicine.dart
rm -f lib/domain/syrup.dart
rm -f lib/domain/tablet.dart

# Remove OLD data layer
rm -f lib/data/prescription_repository.dart

# Remove OLD UI
rm -f lib/ui/prescription_ui.dart

# Remove OLD tests
rm -f test/domain_test.dart

echo "✅ Cleanup complete!"
echo ""
echo "📁 FINAL PROJECT STRUCTURE:"
echo "lib/"
echo "├── main_new.dart (renamed to main.dart)"
echo "├── domain/"
echo "│   ├── person.dart"
echo "│   ├── doctor.dart"
echo "│   └── prescription_new.dart (renamed to prescription.dart)"
echo "├── data/"
echo "│   └── prescription_repository_new.dart (renamed to prescription_repository.dart)"
echo "└── ui/"
echo "    └── prescription_ui_new.dart (renamed to prescription_ui.dart)"
echo ""
echo "data/"
echo "└── prescriptions.json (auto-created)"
