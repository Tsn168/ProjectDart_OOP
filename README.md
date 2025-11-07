# Mini Hospital Medication Manager

A simple, complete medication safety system built with Dart following clean 3-layer architecture principles.

## 📋 Project Overview

This is a console-based medication management system designed for small hospitals. It helps doctors create prescriptions with allergy safety checks and allows nurses to record medication administration with automatic stock management.

## 🏗️ Architecture (3 Layers)

```
/lib
  /domain/     # Entities & Enums only
    /entities/   # Core business entities
    /enums/      # Enumeration types
  /data/       # Repositories & Services (business logic + JSON storage)
  /ui/         # Console interface
/test/         # Unit tests
```

### Domain Layer
- **Entities**: Patient, Medication, Prescription, MedicalStaff, Allergy
- **Enums**: StaffRole, MedicationForm, AllergySeverity

### Data Layer
- **Repositories**: Handle CRUD operations, auto-incrementing IDs, and JSON persistence
- **Services**: SafetyService for allergy conflict detection

### UI Layer
- **Console Interface**: Interactive menus for doctors and nurses

## ✨ Features

### Core Functionality
1. **Login System** - Select doctor or nurse role
2. **Doctor Features**:
   - View patients and medications
   - Create prescriptions with allergy safety checks
   - Automatic ID generation (RX001, RX002, etc.)
3. **Nurse Features**:
   - View active prescriptions
   - Record medication administration
   - Automatic stock reduction

### Safety Features
- 🛡️ Allergy conflict detection
- ⚠️ Severity level warnings (Low, Medium, High)
- 📊 Real-time stock tracking

## 🚀 Getting Started

### Prerequisites
- Dart SDK 3.0.0 or higher

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Tsn168/ProjectDart_OOP.git
cd ProjectDart_OOP
```

2. Install dependencies:
```bash
dart pub get
```

### Running the Application

```bash
dart run lib/ui/main.dart
```

### Running Tests

Run all tests:
```bash
dart test
```

Run specific test file:
```bash
dart test test/domain/patient_test.dart
dart test test/domain/medication_test.dart
dart test test/domain/safety_test.dart
dart test test/domain/prescription_test.dart
```

## 📊 Data Management

### Auto-Incrementing IDs
- **Patients**: P001, P002, P003...
- **Medications**: M001, M002, M003...
- **Prescriptions**: RX001, RX002, RX003...
- **Staff**: Pre-defined (D001, D002, N001, N002)

### JSON Storage
Data is automatically persisted in JSON files:
- `data/patients.json`
- `data/medications.json`
- `data/prescriptions.json`
- `data/staff.json`

JSON files are created automatically on first run with sample data.

## 🎮 Usage Examples

### Main Menu
```
════════════════════════════════════════
    MEDICATION MANAGER SYSTEM
════════════════════════════════════════
1. Login as Doctor
2. Login as Nurse
3. Exit
════════════════════════════════════════
Choice: 1
```

### Doctor Workflow
```
--- Available Doctors ---
[D001] Dr. Smith (doctor)
[D002] Dr. Johnson (doctor)

Enter Doctor ID: D001

👨‍⚕️ Welcome Dr. Smith!
════════════════════════════════════════
1. View Patients & Medications
2. Create Prescription
3. Logout
════════════════════════════════════════
Choice: 2

--- PATIENTS ---
[P001] John Doe (Allergies: Penicillin-high)
[P002] Jane Smith (Allergies: No allergies)

--- MEDICATIONS ---
[M001] Paracetamol 500mg (tablet) - Stock: 100
[M002] Amoxicillin 250mg (tablet) - Stock: 50

Select Patient ID: P001
Select Medication ID: M002

🛑 SAFETY ALERT: Patient allergic to Penicillin (HIGH)!
Create prescription anyway? (y/n): n

❌ Prescription cancelled.
```

### Nurse Workflow
```
--- Available Nurses ---
[N001] Nurse Wilson (nurse)
[N002] Nurse Brown (nurse)

Enter Nurse ID: N001

👩‍⚕️ Welcome Nurse Wilson!
════════════════════════════════════════
1. View Active Prescriptions
2. Record Medication Given
3. Logout
════════════════════════════════════════
Choice: 2

--- ACTIVE PRESCRIPTIONS ---
[RX001] John Doe - Paracetamol 500mg (1 tablet) - Prescribed by Dr. Smith

Select Prescription ID: RX001

✅ Medication administered successfully!
Paracetamol stock updated: 100 → 99
```

## 🧪 Testing

The project includes comprehensive unit tests covering:

### Patient Tests
- Auto-incrementing ID generation
- Allergy storage and retrieval
- JSON serialization/deserialization

### Medication Tests
- Auto-incrementing ID generation
- Stock quantity management
- Medication form validation
- Repository operations

### Safety Tests
- High severity allergy detection
- Medium severity allergy detection
- No conflict scenarios
- Allergy detail retrieval

### Prescription Tests
- Auto-incrementing ID generation
- Active/inactive status management
- Prescription filtering
- JSON serialization/deserialization

## 📁 Project Structure

```
ProjectDart_OOP/
├── lib/
│   ├── domain/
│   │   ├── entities/
│   │   │   ├── allergy.dart
│   │   │   ├── medical_staff.dart
│   │   │   ├── medication.dart
│   │   │   ├── patient.dart
│   │   │   └── prescription.dart
│   │   └── enums/
│   │       ├── allergy_severity.dart
│   │       ├── medication_form.dart
│   │       └── staff_role.dart
│   ├── data/
│   │   ├── medication_repository.dart
│   │   ├── patient_repository.dart
│   │   ├── prescription_repository.dart
│   │   ├── safety_service.dart
│   │   └── staff_repository.dart
│   └── ui/
│       └── main.dart
├── test/
│   └── domain/
│       ├── medication_test.dart
│       ├── patient_test.dart
│       ├── prescription_test.dart
│       └── safety_test.dart
├── data/                    # Auto-generated JSON files
├── .gitignore
├── pubspec.yaml
└── README.md
```

## 👥 Team Collaboration

### Git Workflow
The project is configured for team collaboration:
- All source code is tracked in Git
- JSON data files can be recreated automatically
- Clean `.gitignore` prevents unnecessary files from being committed

### Recommended Workflow
1. Create feature branches for new features
2. Run tests before committing
3. Use meaningful commit messages
4. Merge to main after code review

## 🔧 Default Data

The system comes with pre-configured sample data:

### Staff
- **D001**: Dr. Smith (Doctor)
- **D002**: Dr. Johnson (Doctor)
- **N001**: Nurse Wilson (Nurse)
- **N002**: Nurse Brown (Nurse)

### Patients
- **P001**: John Doe (Allergic to Penicillin - High)
- **P002**: Jane Smith (No allergies)
- **P003**: Bob Wilson (Allergic to Aspirin - Medium)

### Medications
- **M001**: Paracetamol 500mg (Tablet) - Stock: 100
- **M002**: Amoxicillin 250mg (Tablet) - Stock: 50
- **M003**: Ibuprofen 200mg (Tablet) - Stock: 75
- **M004**: Cough Syrup 100ml (Liquid) - Stock: 30

## 🛠️ Technology Stack

- **Language**: Dart 3.0+
- **Testing**: package:test
- **Data Storage**: JSON files
- **Architecture**: 3-Layer (Domain, Data, UI)

## 📝 Design Decisions

1. **3-Layer Architecture**: Clean separation of concerns
2. **Auto-Incrementing IDs**: No manual ID input required
3. **JSON Storage**: Simple file-based persistence in data layer
4. **Repository Pattern**: Centralized data management
5. **Service Layer**: Business logic separation
6. **Console UI**: Simple, interactive interface

## 🚦 Future Enhancements

Potential improvements for future versions:
- Database integration (SQLite, PostgreSQL)
- GUI interface (Flutter)
- Advanced medication interactions
- Patient medical history
- Reporting and analytics
- Multi-user authentication
- Audit trail logging

## 📄 License

This is an educational project created for learning purposes.

## 👨‍💻 Authors

- **Project Team**: CADT Y3T1 Students
- **Repository**: [github.com/Tsn168/ProjectDart_OOP](https://github.com/Tsn168/ProjectDart_OOP)

## 🙏 Acknowledgments

- Cambodia Academy of Digital Technology (CADT)
- Flutter & Dart Community

---

**Built with ❤️ using Dart**
