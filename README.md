# 🏥 Mini Hospital Medication Manager# 🏥 Mini Hospital Medication Manager# 🏥 Mini Hospital Medication Manager# Mini Hospital Medication Manager



A Dart console application for hospital medication management with **Clean Architecture** and **OOP** principles.



## 🚀 Quick StartA professional Dart application demonstrating **Clean Architecture** and **Object-Oriented Programming** principles for hospital medication management.



```bash

dart pub get              # Install dependencies

dart run lib/ui/main.dart # Run application---A professional-grade Dart application demonstrating clean architecture principles and Object-Oriented Programming (OOP) design patterns.A simple, complete medication safety system built with Dart following clean 3-layer architecture principles.

dart test                 # Run tests

```



## 📋 Features## 🚀 Quick Start



- ✅ Patient management with allergy tracking

- ✅ Medication inventory with stock management

- ✅ Prescription creation and tracking```bash## ✨ Features## 📋 Project Overview

- ✅ Role-based access (Doctors & Nurses)

- ✅ Automatic allergy conflict detection# Install dependencies

- ✅ Auto-incrementing IDs (P001, M001, RX001...)

- ✅ JSON persistencedart pub get



## 🏗️ Architecture



**3-Layer Clean Architecture:**# Run the application### 🎯 Core FunctionalityThis is a console-based medication management system designed for small hospitals. It helps doctors create prescriptions with allergy safety checks and allows nurses to record medication administration with automatic stock management.



```dart run lib/ui/main.dart

lib/

├── domain/     # Entities & Enums (business logic)- ✅ **Patient Management** - Create and manage patient records with allergy tracking

├── data/       # Repositories & Services (persistence)

└── ui/         # Console interface (presentation)# Run tests

```

dart test- ✅ **Medication Inventory** - Track medications with stock management and auto-decrement## 🏗️ Architecture (3 Layers)

## 🎓 OOP Implementation

```

### Encapsulation

Private fields with validated getters/setters:- ✅ **Prescriptions** - Create and manage active prescriptions

```dart

class Medication {---

  int _stockQuantity;  // Private

  set stockQuantity(int value) {- ✅ **Medical Staff** - Manage doctors and nurses with role-based permissions```

    if (value < 0) throw ArgumentError('Cannot be negative');

    _stockQuantity = value;## 📋 Overview

  }

}- ✅ **Safety System** - Automatic allergy conflict detection before medication administration/lib

```

A console-based medication management system for small hospitals. Enables doctors to create prescriptions with allergy safety checks and nurses to administer medications with automatic stock management.

### Inheritance

Entity base class and staff hierarchy:  /domain/     # Entities & Enums only

```dart

abstract class Entity {### Core Features

  String get id;

  Map<String, dynamic> toJson();- ✅ Patient management with allergy tracking### 🏗️ Architecture    /entities/   # Core business entities

}

- ✅ Medication inventory with stock management

class Patient extends Entity { ... }

class Medication extends Entity { ... }- ✅ Prescription creation and tracking- **3-Layer Architecture** - Domain (Business Logic) → Data (Persistence) → UI (Presentation)    /enums/      # Enumeration types



abstract class BaseMedicalStaff extends Entity { ... }- ✅ Role-based access (Doctors & Nurses)

class Doctor extends BaseMedicalStaff { ... }

class Nurse extends BaseMedicalStaff { ... }- ✅ Automatic allergy conflict detection- **Repository Pattern** - Polymorphic data access with generic `Repository<T>` interface  /data/       # Repositories & Services (business logic + JSON storage)

```

- ✅ Auto-incrementing IDs (P001, M001, RX001...)

### Polymorphism

Generic repository interface:- ✅ JSON persistence with auto-save/load- **OOP Principles** - Encapsulation, Inheritance, Polymorphism implemented throughout  /ui/         # Console interface

```dart

abstract class Repository<T extends Entity> {

  List<T> getAll();

  T? getById(String id);---- **Design Patterns** - Factory Pattern, Strategy Pattern, Template Method Pattern/test/         # Unit tests

}



class PatientRepository implements Repository<Patient> { ... }

class MedicationRepository implements Repository<Medication> { ... }## 🏗️ Architecture```

```



## 🎯 Entities

### 3-Layer Clean Architecture### 💾 Data Persistence

| Entity | ID Format | Key Features |

|--------|-----------|--------------|

| Patient | P001, P002... | Allergy tracking |

| Medication | M001, M002... | Stock management, auto-decrement |```- JSON-based storage with auto-save### Domain Layer

| Prescription | RX001, RX002... | Active status, deactivation |

| Doctor/Nurse | D001, N001... | Role-based permissions |lib/



## 🛡️ Safety Features├── domain/          # 🏛️ Pure Business Logic (no dependencies)- Auto-incrementing IDs (P001, M001, RX001, etc.)- **Entities**: Patient, Medication, Prescription, MedicalStaff, Allergy



**Allergy Detection:**│   ├── entities/    #    Core domain models

```dart

if (SafetyService.hasAllergyConflict(patient, medication)) {│   └── enums/       #    Enumeration types- Automatic data loading on startup- **Enums**: StaffRole, MedicationForm, AllergySeverity

  print('⚠️ Allergy detected!');

}│

```

├── data/            # 💾 Persistence & Business Rules

**Stock Management:**

- Validates availability│   ├── repositories #    Data access with JSON storage

- Prevents negative stock

- Auto-decrements on administration│   └── services     #    Business logic (safety checks)### 🧪 Testing### Data Layer



## 🧪 Testing│



```bash└── ui/              # 🖥️ Presentation Layer- 20 comprehensive unit tests- **Repositories**: Handle CRUD operations, auto-incrementing IDs, and JSON persistence

dart test  # 20 tests - All passing ✅

```    └── main.dart    #    Console interface



## 📝 Requirements Met```- 100% test pass rate- **Services**: SafetyService for allergy conflict detection



✅ 3-Layer Architecture (Domain/Data/UI)  

✅ Auto-Incrementing IDs  

✅ JSON Persistence  ### Layer Responsibilities- Coverage for all major features

✅ Allergy Safety Checks  

✅ Encapsulation (private fields + validation)  

✅ Inheritance (Entity base + Staff hierarchy)  

✅ Polymorphism (Repository<T> interface)  | Layer | Responsibility | Examples |### UI Layer

✅ Unit Tests (20 passing)

|-------|---------------|----------|

## 📄 Project Structure

| **Domain** | Core entities, business rules | Patient, Medication, Prescription |---- **Console Interface**: Interactive menus for doctors and nurses

```

lib/| **Data** | Persistence, data access | Repositories, SafetyService, JSON I/O |

├── domain/entities/      # Patient, Medication, Prescription, Staff, Allergy

├── domain/enums/         # All enums (StaffRole, MedicationForm, AllergySeverity)| **UI** | User interaction, presentation | Console menus, input/output |

├── data/                 # Repositories + SafetyService

└── ui/main.dart          # Console interface



test/domain/              # Unit tests---## 📁 Project Structure## ✨ Features

data/                     # JSON storage (auto-generated)

```



---## 📁 Project Structure



**Last Updated:** November 7, 2025  

**Status:** Production-ready ✅

``````### Core Functionality

ProjectDart_OOP/

│ProjectDart_OOP/1. **Login System** - Select doctor or nurse role

├── lib/

│   ├── domain/│2. **Doctor Features**:

│   │   ├── entities/

│   │   │   ├── entity.dart              # Abstract base class├── lib/   - View patients and medications

│   │   │   ├── patient.dart             # Patient entity

│   │   │   ├── medication.dart          # Medication entity│   ├── domain/                          # 🏛️ Pure Business Logic   - Create prescriptions with allergy safety checks

│   │   │   ├── prescription.dart        # Prescription entity

│   │   │   ├── medical_staff.dart       # Staff hierarchy (Doctor, Nurse)│   │   ├── entities/   - Automatic ID generation (RX001, RX002, etc.)

│   │   │   └── allergy.dart             # Allergy entity

│   │   └── enums/│   │   │   ├── entity.dart              # Abstract base class3. **Nurse Features**:

│   │       └── enums.dart               # All enums in one file

│   ││   │   │   ├── patient.dart             # Patient entity   - View active prescriptions

│   ├── data/

│   │   ├── repository.dart              # Abstract Repository<T> interface│   │   │   ├── medication.dart          # Medication entity   - Record medication administration

│   │   ├── patient_repository.dart      # Patient data access

│   │   ├── medication_repository.dart   # Medication data access│   │   │   ├── prescription.dart        # Prescription entity   - Automatic stock reduction

│   │   ├── prescription_repository.dart # Prescription data access

│   │   ├── staff_repository.dart        # Staff data access│   │   │   ├── medical_staff.dart       # Staff hierarchy

│   │   └── safety_service.dart          # Allergy safety checking

│   ││   │   │   └── allergy.dart             # Allergy entity### Safety Features

│   └── ui/

│       └── main.dart                    # Console interface│   │   └── enums/- 🛡️ Allergy conflict detection

│

├── test/                                # Unit tests (20 tests)│   │       └── enums.dart               # All enums (StaffRole, MedicationForm, AllergySeverity)- ⚠️ Severity level warnings (Low, Medium, High)

├── data/                                # JSON storage (auto-generated)

├── pubspec.yaml│   │- 📊 Real-time stock tracking

└── README.md

```│   ├── data/                            # 💾 Persistence + Repositories



---│   │   ├── repository.dart              # Abstract Repository interface## 🚀 Getting Started



## 🎓 OOP Implementation│   │   ├── patient_repository.dart      # Patient data access



### 1. Encapsulation ✅│   │   ├── medication_repository.dart   # Medication data access### Prerequisites

Private fields with controlled access and validation:

│   │   ├── prescription_repository.dart # Prescription data access- Dart SDK 3.0.0 or higher

```dart

class Medication extends Entity {│   │   ├── staff_repository.dart        # Staff data access

  int _stockQuantity;  // Private field

  │   │   └── safety_service.dart          # Allergy safety checking### Installation

  int get stockQuantity => _stockQuantity;  // Public getter

  │   │

  set stockQuantity(int value) {            // Validated setter

    if (value < 0) throw ArgumentError('Stock cannot be negative');│   └── ui/1. Clone the repository:

    _stockQuantity = value;

  }│       └── main.dart                    # 🖥️ Console interface```bash

  

  bool administrate() {                     // Business logic│git clone https://github.com/Tsn168/ProjectDart_OOP.git

    if (_stockQuantity > 0) {

      _stockQuantity--;├── test/cd ProjectDart_OOP

      return true;

    }│   └── domain/```

    return false;

  }│       ├── patient_test.dart            # Patient entity tests

}

```│       ├── medication_test.dart         # Medication entity tests2. Install dependencies:



### 2. Inheritance ✅│       ├── prescription_test.dart       # Prescription entity tests```bash

Base classes and class hierarchies:

│       └── safety_test.dart             # Safety service testsdart pub get

```dart

// Base entity for all domain objects│```

abstract class Entity {

  String get id;├── data/                                # 📄 JSON Storage (auto-generated)

  Map<String, dynamic> toJson();

}│   ├── patients.json### Running the Application



// All entities inherit from Entity│   ├── medications.json

class Patient extends Entity { ... }

class Medication extends Entity { ... }│   ├── prescriptions.json```bash

class Prescription extends Entity { ... }

│   └── staff.jsondart run lib/ui/main.dart

// Staff hierarchy demonstrates inheritance

abstract class BaseMedicalStaff extends Entity {│```

  String getPermission();  // Abstract method

}├── pubspec.yaml                         # Dependencies



class Doctor extends BaseMedicalStaff {└── README.md                            # This file### Running Tests

  @override

  String getPermission() => 'Can create prescriptions';```

}

Run all tests:

class Nurse extends BaseMedicalStaff {

  @override---```bash

  String getPermission() => 'Can administer medications';

}dart test

```

## 🚀 Getting Started```

### 3. Polymorphism ✅

Generic interfaces and method overriding:



```dart### PrerequisitesRun specific test file:

// Generic repository interface

abstract class Repository<T extends Entity> {- Dart SDK 3.0+```bash

  List<T> getAll();

  T? getById(String id);- Gitdart test test/domain/patient_test.dart

  T create(T entity);

  void update(T entity);dart test test/domain/medication_test.dart

  void delete(String id);

}### Installationdart test test/domain/safety_test.dart



// Different implementations for different entitiesdart test test/domain/prescription_test.dart

class PatientRepository implements Repository<Patient> { ... }

class MedicationRepository implements Repository<Medication> { ... }```bash```



// Can be used polymorphically# Clone the repository

Repository<Patient> patientRepo = PatientRepository();

Repository<Medication> medRepo = MedicationRepository();git clone <repository-url>## 📊 Data Management

```

cd ProjectDart_OOP

---

### Auto-Incrementing IDs

## 🎯 Domain Entities

# Get dependencies- **Patients**: P001, P002, P003...

### Patient

- **ID Format**: P001, P002, P003...dart pub get- **Medications**: M001, M002, M003...

- **Properties**: id, name, allergies

- **Methods**: `hasAllergies()`, `getAllergyInfo()`- **Prescriptions**: RX001, RX002, RX003...



### Medication# Run the application- **Staff**: Pre-defined (D001, D002, N001, N002)

- **ID Format**: M001, M002, M003...

- **Properties**: id, name, strength, form, stockQuantitydart run lib/ui/main.dart

- **Methods**: `administrate()`, `isInStock()`, `isLowStock()`

### JSON Storage

### Prescription

- **ID Format**: RX001, RX002, RX003...# Run testsData is automatically persisted in JSON files:

- **Properties**: id, patientId, doctorId, medicationId, dosage, isActive

- **Methods**: `deactivate()`, `isValid()`dart test- `data/patients.json`



### Medical Staff```- `data/medications.json`

- **ID Format**: D001 (Doctor), N001 (Nurse)

- **Types**: Doctor, Nurse- `data/prescriptions.json`

- **Methods**: `getPermission()`

---- `data/staff.json`

### Allergy

- **Properties**: substance, severity

- **Severity Levels**: Low, Medium, High

## 📚 OOP ImplementationJSON files are created automatically on first run with sample data.

---



## 🛡️ Safety Features

### Encapsulation ✅## 🎮 Usage Examples

### Allergy Conflict Detection

The system automatically checks for allergy conflicts before medication administration:Private members with controlled access through getters/setters:



```dart```dart### Main Menu

// Check if patient allergic to medication

if (SafetyService.hasAllergyConflict(patient, medication)) {class Medication extends Entity {```

  print('⚠️ DANGER: Patient allergic to this medication!');

  return;  int _stockQuantity;  // Private════════════════════════════════════════

}

      MEDICATION MANAGER SYSTEM

// Safe to administer

medication.administrate();  int get stockQuantity => _stockQuantity;  // Getter════════════════════════════════════════

```

  1. Login as Doctor

### Stock Management

- Validates stock availability before administration  set stockQuantity(int value) {  // Setter with validation2. Login as Nurse

- Prevents negative stock levels

- Tracks low stock warnings (< 20 units)    if (value < 0) throw ArgumentError('Cannot be negative');3. Exit

- Auto-decrements on successful administration

    _stockQuantity = value;════════════════════════════════════════

---

  }Choice: 1

## 💻 Usage Examples

}```

### Create Patient with Allergies

```dart```

final patient = patientRepo.createPatient(

  'John Doe',### Doctor Workflow

  [

    Allergy(substance: 'Penicillin', severity: AllergySeverity.high),### Inheritance ✅```

    Allergy(substance: 'Aspirin', severity: AllergySeverity.medium),

  ]Base classes and hierarchies:--- Available Doctors ---

);

// Output: Patient created with ID: P001```dart[D001] Dr. Smith (doctor)

```

abstract class Entity {[D002] Dr. Johnson (doctor)

### Add Medication to Inventory

```dart  String get id;

final medication = medRepo.createMedication(

  'Ibuprofen',  Map<String, dynamic> toJson();Enter Doctor ID: D001

  '200mg',

  MedicationForm.tablet,}

  100,  // Initial stock

);👨‍⚕️ Welcome Dr. Smith!

// Output: Medication created with ID: M001

```class Patient extends Entity { ... }════════════════════════════════════════



### Create Prescription (Doctor)class Medication extends Entity { ... }1. View Patients & Medications

```dart

final prescription = prescriptionRepo.createPrescription(2. Create Prescription

  'P001',  // Patient ID

  'D001',  // Doctor IDabstract class BaseMedicalStaff extends Entity {3. Logout

  'M001',  // Medication ID

  '1 tablet twice daily',  String getPermission();════════════════════════════════════════

);

// Output: Prescription created with ID: RX001}Choice: 2

```



### Administer Medication (Nurse)

```dartclass Doctor extends BaseMedicalStaff { ... }--- PATIENTS ---

// 1. Safety check

if (SafetyService.hasAllergyConflict(patient, medication)) {class Nurse extends BaseMedicalStaff { ... }[P001] John Doe (Allergies: Penicillin-high)

  print('⚠️ Cannot administer - allergy detected!');

  return;```[P002] Jane Smith (Allergies: No allergies)

}



// 2. Check stock

if (!medication.isInStock()) {### Polymorphism ✅--- MEDICATIONS ---

  print('❌ Out of stock!');

  return;Interface implementation and method overriding:[M001] Paracetamol 500mg (tablet) - Stock: 100

}

```dart[M002] Amoxicillin 250mg (tablet) - Stock: 50

// 3. Administer

if (medication.administrate()) {abstract class Repository<T extends Entity> {

  print('✅ Medication administered');

  print('📦 Remaining stock: ${medication.stockQuantity}');  List<T> getAll();Select Patient ID: P001

}

```  T? getById(String id);Select Medication ID: M002



---  T create(T entity);



## 🧪 Testing  void update(T entity);🛑 SAFETY ALERT: Patient allergic to Penicillin (HIGH)!



### Run All Tests  void delete(String id);Create prescription anyway? (y/n): n

```bash

dart test}

```

❌ Prescription cancelled.

### Test Coverage (20 Tests)

- ✅ Auto-incrementing ID generationclass PatientRepository implements Repository<Patient> {```

- ✅ Patient allergy management

- ✅ Medication stock validation and administration  @override

- ✅ Prescription status management

- ✅ Allergy conflict detection  List<Patient> getAll() { ... }### Nurse Workflow

- ✅ JSON serialization/deserialization

- ✅ Repository CRUD operations  // ... other implementations```

- ✅ Encapsulation and data validation

}--- Available Nurses ---

### Sample Test Output

``````[N001] Nurse Wilson (nurse)

00:00 +20: All tests passed!

```[N002] Nurse Brown (nurse)



------



## 🎨 Design PatternsEnter Nurse ID: N001



| Pattern | Implementation | Purpose |## 🎯 Entity Models

|---------|---------------|---------|

| **Repository** | `Repository<T>` interface | Polymorphic data access |👩‍⚕️ Welcome Nurse Wilson!

| **Factory** | `fromJson()` constructors | Create objects from JSON |

| **Template Method** | `Entity` base class | Common interface for entities |### Patient════════════════════════════════════════

| **Strategy** | `SafetyService` | Pluggable safety algorithms |

- **ID**: Auto-generated (P001, P002, ...)1. View Active Prescriptions

---

- **Properties**: name, allergies2. Record Medication Given

## ✅ SOLID Principles

- **Features**: Allergy tracking, immutable allergy list3. Logout

- **Single Responsibility**: Each class has one clear purpose

- **Open/Closed**: Open for extension (inheritance), closed for modification════════════════════════════════════════

- **Liskov Substitution**: Subclasses can replace base classes

- **Interface Segregation**: Focused interfaces (Repository<T>)### MedicationChoice: 2

- **Dependency Inversion**: Depend on abstractions (Repository interface)

- **ID**: Auto-generated (M001, M002, ...)

---

- **Properties**: name, strength, form, stockQuantity--- ACTIVE PRESCRIPTIONS ---

## 🔄 User Workflows

- **Features**: Stock validation, auto-decrement on administration[RX001] John Doe - Paracetamol 500mg (1 tablet) - Prescribed by Dr. Smith

### Doctor Workflow

1. Login as Doctor (D001 or D002)

2. View all patients with their allergies

3. View available medications### PrescriptionSelect Prescription ID: RX001

4. Create prescription (with automatic ID)

5. System saves to JSON automatically- **ID**: Auto-generated (RX001, RX002, ...)



### Nurse Workflow- **Properties**: patientId, doctorId, medicationId, dosage✅ Medication administered successfully!

1. Login as Nurse (N001 or N002)

2. View active prescriptions- **Features**: Active status management, deactivation methodParacetamol stock updated: 100 → 99

3. Select prescription to fulfill

4. System checks:```

   - ✅ Patient allergies

   - ✅ Medication stock### Medical Staff

5. Administer medication

6. Stock auto-decrements- **ID**: Pre-defined (D001, N001, etc.)## 🧪 Testing

7. System saves to JSON automatically

- **Types**: Doctor, Nurse

---

- **Features**: Role-based permissions, polymorphic behaviorThe project includes comprehensive unit tests covering:

## 💾 Data Persistence



### JSON Storage

All data automatically saved to:### Allergy### Patient Tests

- `data/patients.json`

- `data/medications.json`- **Properties**: substance, severity- Auto-incrementing ID generation

- `data/prescriptions.json`

- `data/staff.json`- **Severity Levels**: Low, Medium, High- Allergy storage and retrieval



### Auto-Loading- JSON serialization/deserialization

Data automatically loads on application startup.

---

### Auto-Saving

Any changes immediately saved to JSON files.### Medication Tests



---## 🛡️ Safety Features- Auto-incrementing ID generation



## 📊 System Status- Stock quantity management



- ✅ All features implemented### Allergy Conflict Detection- Medication form validation

- ✅ All tests passing (20/20)

- ✅ Zero compile errorsPrevents medication administration if patient has conflicting allergies:- Repository operations

- ✅ Clean architecture verified

- ✅ OOP principles applied```dart

- ✅ SOLID principles followed

- ✅ Production-ready codeSafetyService.hasAllergyConflict(patient, medication)### Safety Tests



---```- High severity allergy detection



## 🎯 Learning Outcomes- Medium severity allergy detection



This project demonstrates:### Stock Management- No conflict scenarios



1. ✅ **Clean 3-Layer Architecture** - Proper separation of concerns- Validates stock before administration- Allergy detail retrieval

2. ✅ **OOP Principles** - Encapsulation, Inheritance, Polymorphism

3. ✅ **Design Patterns** - Repository, Factory, Strategy, Template Method- Prevents negative stock levels

4. ✅ **SOLID Principles** - Professional software engineering standards

5. ✅ **Testing** - Comprehensive unit test coverage- Tracks low stock items (< 20 units)### Prescription Tests

6. ✅ **Type Safety** - Generic types with constraints

7. ✅ **Data Persistence** - JSON serialization and file I/O- Auto-incrementing ID generation

8. ✅ **Business Logic** - Safety validation, stock management

---- Active/inactive status management

---

- Prescription filtering

## 📝 Requirements Met

## 🧪 Testing- JSON serialization/deserialization

✅ **3-Layer Architecture** - Domain, Data, UI clearly separated  

✅ **Auto-Incrementing IDs** - P001, M001, RX001... (no manual entry)  

✅ **JSON Persistence** - All data saved/loaded from JSON  

✅ **Allergy Safety Check** - Automatic conflict detection  Run all tests:## 📁 Project Structure

✅ **Encapsulation** - Private fields with controlled access  

✅ **Inheritance** - Entity base class + Staff hierarchy  ```bash

✅ **Polymorphism** - Repository<T> interface implementation  

✅ **Unit Tests** - 20 comprehensive tests, all passing  dart test```



---```ProjectDart_OOP/



## 🤝 Future Enhancements├── lib/



Possible extensions:Test coverage includes:│   ├── domain/

- Database integration (SQLite, PostgreSQL)

- REST API layer- ✅ Auto-incrementing ID generation│   │   ├── entities/

- Flutter mobile app frontend

- Web dashboard- ✅ Patient allergy management│   │   │   ├── allergy.dart

- Report generation (PDF)

- Multi-language support- ✅ Medication stock validation│   │   │   ├── medical_staff.dart

- Email notifications

- Audit logging- ✅ Prescription status management│   │   │   ├── medication.dart



---- ✅ Safety service functionality│   │   │   ├── patient.dart



## 📄 License- ✅ JSON serialization/deserialization│   │   │   └── prescription.dart



Educational project for learning OOP and Clean Architecture principles.│   │   └── enums/



------│   │       ├── allergy_severity.dart



## 👨‍💻 Author│   │       ├── medication_form.dart



Created as a comprehensive demonstration of professional Dart application architecture.## 💾 Data Persistence│   │       └── staff_role.dart



**Last Updated**: November 7, 2025│   ├── data/



---### File Storage│   │   ├── medication_repository.dart



**Ready to run!** 🚀All data is stored in JSON format:│   │   ├── patient_repository.dart



```bash- `data/patients.json` - Patient records│   │   ├── prescription_repository.dart

dart run lib/ui/main.dart

```- `data/medications.json` - Medication inventory│   │   ├── safety_service.dart


- `data/prescriptions.json` - Active prescriptions│   │   └── staff_repository.dart

- `data/staff.json` - Medical staff records│   └── ui/

│       └── main.dart

### Auto-Load├── test/

Data is automatically loaded on application startup from JSON files.│   └── domain/

│       ├── medication_test.dart

### Auto-Save│       ├── patient_test.dart

Any changes are automatically saved to JSON files.│       ├── prescription_test.dart

│       └── safety_test.dart

---├── data/                    # Auto-generated JSON files

├── .gitignore

## 🔄 Workflow├── pubspec.yaml

└── README.md

### Doctor Workflow```

1. Login as Doctor

2. View patient records## 👥 Team Collaboration

3. Create new prescriptions

4. Check medication availability### Git Workflow

The project is configured for team collaboration:

### Nurse Workflow- All source code is tracked in Git

1. Login as Nurse- JSON data files can be recreated automatically

2. View active prescriptions- Clean `.gitignore` prevents unnecessary files from being committed

3. Administer medications to patients

4. Safety system prevents allergic reactions### Recommended Workflow

1. Create feature branches for new features

---2. Run tests before committing

3. Use meaningful commit messages

## 📋 Entity Relationships4. Merge to main after code review



```## 🔧 Default Data

Patient

  └── Allergies (List<Allergy>)The system comes with pre-configured sample data:



Prescription### Staff

  ├── Patient (via patientId)- **D001**: Dr. Smith (Doctor)

  ├── Doctor (via doctorId)- **D002**: Dr. Johnson (Doctor)

  └── Medication (via medicationId)- **N001**: Nurse Wilson (Nurse)

- **N002**: Nurse Brown (Nurse)

MedicalStaff

  ├── Doctor (specialized staff)### Patients

  └── Nurse (specialized staff)- **P001**: John Doe (Allergic to Penicillin - High)

```- **P002**: Jane Smith (No allergies)

- **P003**: Bob Wilson (Allergic to Aspirin - Medium)

---

### Medications

## 🎓 Design Patterns Used- **M001**: Paracetamol 500mg (Tablet) - Stock: 100

- **M002**: Amoxicillin 250mg (Tablet) - Stock: 50

| Pattern | Location | Purpose |- **M003**: Ibuprofen 200mg (Tablet) - Stock: 75

|---------|----------|---------|- **M004**: Cough Syrup 100ml (Liquid) - Stock: 30

| **Repository** | `lib/data/repository.dart` | Polymorphic data access |

| **Factory** | `fromJson()` constructors | Object creation from JSON |## 🛠️ Technology Stack

| **Template Method** | `Entity` base class | Common interface for entities |

| **Strategy** | `SafetyService` | Pluggable safety checking |- **Language**: Dart 3.0+

- **Testing**: package:test

---- **Data Storage**: JSON files

- **Architecture**: 3-Layer (Domain, Data, UI)

## ✅ SOLID Principles

## 📝 Design Decisions

- **S**ingle Responsibility - Each class has one reason to change

- **O**pen/Closed - Open for extension, closed for modification1. **3-Layer Architecture**: Clean separation of concerns

- **L**iskov Substitution - Repositories are interchangeable2. **Auto-Incrementing IDs**: No manual ID input required

- **I**nterface Segregation - Focused interfaces3. **JSON Storage**: Simple file-based persistence in data layer

- **D**ependency Inversion - Depend on abstractions, not concretions4. **Repository Pattern**: Centralized data management

5. **Service Layer**: Business logic separation

---6. **Console UI**: Simple, interactive interface



## 🚦 Status## 🚦 Future Enhancements



- ✅ All features implementedPotential improvements for future versions:

- ✅ All tests passing (20/20)- Database integration (SQLite, PostgreSQL)

- ✅ Code analysis passed (no issues)- GUI interface (Flutter)

- ✅ OOP principles applied- Advanced medication interactions

- ✅ Clean architecture maintained- Patient medical history

- Reporting and analytics

---- Multi-user authentication

- Audit trail logging

## 📝 Usage Example

## 📄 License

### Create a Patient with Allergies

```dartThis is an educational project created for learning purposes.

final patient = Patient(

  id: 'P001',## 👨‍💻 Authors

  name: 'John Doe',

  allergies: [- **Project Team**: CADT Y3T1 Students

    Allergy(substance: 'Penicillin', severity: AllergySeverity.high),- **Repository**: [github.com/Tsn168/ProjectDart_OOP](https://github.com/Tsn168/ProjectDart_OOP)

  ],

);## 🙏 Acknowledgments

```

- Cambodia Academy of Digital Technology (CADT)

### Create a Medication- Flutter & Dart Community

```dart

final medication = Medication(---

  id: 'M001',

  name: 'Aspirin',**Built with ❤️ using Dart**

  strength: '500mg',
  form: MedicationForm.tablet,
  stockQuantity: 100,
);
```

### Create a Prescription
```dart
final prescription = Prescription(
  id: 'RX001',
  patientId: 'P001',
  doctorId: 'D001',
  medicationId: 'M001',
  dosage: '2 tablets daily',
);
```

### Check for Safety
```dart
if (SafetyService.hasAllergyConflict(patient, medication)) {
  print('⚠️ Allergy conflict detected!');
} else {
  medication.administrate();  // Safe to administer
}
```

---

## 🤝 Contributing

This project demonstrates professional software engineering practices. Feel free to extend it with additional features:

- Additional entity types
- Database integration
- REST API layer
- Mobile app frontend
- Enhanced reporting

---

## 📄 License

Educational project for learning OOP and design patterns.

---

## 👨‍💻 Author

Created as a comprehensive example of professional Dart application architecture.

**Last Updated**: November 7, 2025

---

## 🎯 Key Takeaways

✅ **Clean 3-Layer Architecture** - Domain, Data, UI separation  
✅ **OOP Principles** - Encapsulation, Inheritance, Polymorphism  
✅ **Design Patterns** - Repository, Factory, Strategy, Template Method  
✅ **SOLID Principles** - Professional code standards  
✅ **Comprehensive Testing** - 20 passing tests  
✅ **Type Safety** - Generic repositories with constraints  
✅ **Data Persistence** - JSON storage with auto-save  
✅ **Safety System** - Automatic conflict detection  

---

**Ready to use! Run `dart run lib/ui/main.dart` to start.** 🚀
