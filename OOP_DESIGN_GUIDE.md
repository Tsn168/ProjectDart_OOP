# OOP Design Patterns Implementation Guide

## ✅ **Project Now Implements Proper OOP Design**

Your medication manager project has been enhanced with **professional-grade OOP design patterns**. Here's what has been implemented:

---

## 🏗️ **LAYER SEPARATION**

### **Domain Layer (Pure Business Logic)**
```
lib/domain/
├── entities/
│   ├── entity.dart          # Base abstract class (Polymorphism)
│   ├── patient.dart         # Extends Entity (Inheritance)
│   ├── medication.dart      # Extends Entity (Inheritance)
│   ├── prescription.dart    # Extends Entity (Inheritance)
│   ├── medical_staff.dart   # BaseMedicalStaff + Doctor + Nurse (Inheritance)
│   └── allergy.dart         # Extends Entity (Inheritance)
├── enums/
│   ├── staff_role.dart
│   ├── medication_form.dart
│   └── allergy_severity.dart
```

### **Data Layer (Business Logic + Persistence)**
```
lib/data/
├── repository.dart                # Base abstract class (Interface pattern)
├── patient_repository.dart        # Implements Repository<Patient>
├── medication_repository.dart     # Implements Repository<Medication>
├── prescription_repository.dart   # Implements Repository<Prescription>
├── staff_repository.dart          # Implements Repository<MedicalStaff>
└── safety_service.dart            # Business logic service
```

### **UI Layer (Presentation)**
```
lib/ui/
└── main.dart                      # Console interface
```

---

## 🎯 **1. ENCAPSULATION**

### **What is it?**
Hiding internal data and exposing only necessary interfaces.

### **Examples in Your Code:**

#### **Private Stock Management (Medication Entity)**
```dart
class Medication extends Entity {
  /// Private variable - Cannot access directly from outside
  int _stockQuantity;

  /// Public getter - Controlled access
  int get stockQuantity => _stockQuantity;
  
  /// Public setter - With validation (Encapsulation)
  set stockQuantity(int value) {
    if (value < 0) {
      throw ArgumentError('Stock quantity cannot be negative');
    }
    _stockQuantity = value;
  }
  
  /// Business logic encapsulated - Users don't directly modify stock
  bool administrate() {
    if (_stockQuantity > 0) {
      _stockQuantity--;
      return true;
    }
    return false;
  }
}
```

**Benefits:**
✅ Prevents invalid stock values (negative)
✅ Business logic centralized
✅ Can add validation later without changing interface

#### **Immutable Allergies List (Patient Entity)**
```dart
class Patient extends Entity {
  /// Private immutable list - Cannot be modified
  final List<Allergy> _allergies;

  Patient({...}) : _allergies = List.unmodifiable(allergies);

  /// Getter provides read-only access
  List<Allergy> get allergies => _allergies;
  
  /// Methods encapsulate allergy logic
  bool hasAllergies() => _allergies.isNotEmpty;
  String getAllergyInfo() { ... }
}
```

**Benefits:**
✅ Prevents accidental modification
✅ Allergy management logic is controlled
✅ Thread-safe by default

#### **Private Prescription Status (Prescription Entity)**
```dart
class Prescription extends Entity {
  /// Private state - Controlled access only
  bool _isActive;

  /// Public getter
  bool get isActive => _isActive;
  
  /// Controlled deactivation method
  void deactivate() {
    _isActive = false;
  }
}
```

**Benefits:**
✅ Prescription status can only change through defined methods
✅ Cannot accidentally set invalid states
✅ Audit trail possible in future

---

## 👨‍👩‍👦 **2. INHERITANCE**

### **What is it?**
Deriving classes from a base class to reuse and extend functionality.

### **Examples in Your Code:**

#### **Entity Base Class (Domain Layer)**
```dart
/// All entities inherit from this base
abstract class Entity {
  String get id;
  Map<String, dynamic> toJson();
}

/// Specific implementations
class Patient extends Entity { ... }
class Medication extends Entity { ... }
class Prescription extends Entity { ... }
class Allergy extends Entity { ... }
```

**Benefits:**
✅ Common interface for all domain objects
✅ Guaranteed `toJson()` and `id` for persistence
✅ Polymorphic collections: `List<Entity> entities`

#### **Staff Hierarchy (Medical Staff Classes)**
```dart
/// Base class with abstract method
abstract class BaseMedicalStaff extends Entity {
  String getPermission(); // Must be implemented
}

/// Specific implementation for Doctor
class Doctor extends BaseMedicalStaff {
  @override
  String getPermission() => 'Can create prescriptions and view patient records';
}

/// Specific implementation for Nurse
class Nurse extends BaseMedicalStaff {
  @override
  String getPermission() => 'Can administer medications and view prescriptions';
}

/// Legacy support
class MedicalStaff extends BaseMedicalStaff {
  // Flexible role-based logic
}
```

**Benefits:**
✅ Code reuse - common fields/methods in base class
✅ Type safety - can use `BaseMedicalStaff` polymorphically
✅ Easy to add new staff types (Pharmacist, Physician)

---

## 🔄 **3. POLYMORPHISM**

### **What is it?**
Using objects through their common interface while behaving differently.

### **Examples in Your Code:**

#### **Factory Pattern (Polymorphism via Factory Constructors)**
```dart
class Medication extends Entity {
  /// Factory constructor - can return different implementations
  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'],
      name: json['name'],
      // ... auto-magically converts JSON to Medication
    );
  }
}

class Allergy extends Entity {
  factory Allergy.fromJson(Map<String, dynamic> json) {
    return Allergy(
      substance: json['substance'],
      severity: AllergySeverity.values.firstWhere(...),
    );
  }
}

// Usage - works for any Entity!
List<Entity> entities = [
  Medication.fromJson(medJson),
  Patient.fromJson(patientJson),
  Prescription.fromJson(prescriptionJson),
];
```

#### **Abstract Methods (Polymorphism via Abstraction)**
```dart
abstract class BaseMedicalStaff extends Entity {
  /// Abstract method - must be overridden
  String getPermission();
}

class Doctor extends BaseMedicalStaff {
  @override
  String getPermission() => 'Doctor permissions...';
}

class Nurse extends BaseMedicalStaff {
  @override
  String getPermission() => 'Nurse permissions...';
}

// Polymorphic usage
void showPermissions(BaseMedicalStaff staff) {
  print(staff.getPermission()); // Calls correct version!
}

showPermissions(Doctor(id: 'D001', name: 'Smith'));
showPermissions(Nurse(id: 'N001', name: 'Wilson'));
```

#### **Repository Pattern (Polymorphism via Interface)**
```dart
abstract class Repository<T extends Entity> {
  List<T> getAll();
  T? getById(String id);
  T create(T entity);
  void update(T entity);
  void delete(String id);
}

class PatientRepository implements Repository<Patient> {
  @override
  List<Patient> getAll() { ... }
  
  @override
  Patient? getById(String id) { ... }
  // ... implement all methods
}

class MedicationRepository implements Repository<Medication> {
  @override
  List<Medication> getAll() { ... }
  // ... implement all methods
}

// Polymorphic data access!
Repository<Patient> patientRepo = PatientRepository();
Repository<Medication> medicationRepo = MedicationRepository();
```

---

## 📊 **LAYER SEPARATION DETAILS**

### **Domain Layer - Pure Business**
```dart
// ✅ Contains only entities and enums
// ✅ NO database access
// ✅ NO external dependencies
// ✅ Fully testable and reusable

import 'package:meditation_manager/domain/entities/patient.dart';
import 'package:meditation_manager/domain/enums/staff_role.dart';

var patient = Patient(
  id: 'P001',
  name: 'John',
  allergies: [Allergy(substance: 'Penicillin', severity: AllergySeverity.high)],
);
```

### **Data Layer - Business Logic + Persistence**
```dart
// ✅ Contains repositories (data access)
// ✅ Contains services (business logic)
// ✅ Handles JSON persistence
// ✅ Uses domain entities

import 'package:medication_manager/data/patient_repository.dart';

var repo = PatientRepository();
var patient = repo.getPatientById('P001');
// Handles JSON loading/saving internally
```

### **UI Layer - Presentation Only**
```dart
// ✅ Contains console interface
// ✅ No business logic
// ✅ Uses domain entities and data repositories
// ✅ Handles user input/output

var repo = PatientRepository();
var patients = repo.getAll();
for (var patient in patients) {
  print(patient); // Uses Entity.toString()
}
```

---

## 🎓 **OOP PRINCIPLES CHECKLIST**

✅ **Encapsulation**
- Private members with controlled access
- Validation in setters
- Business logic encapsulated in methods

✅ **Inheritance**
- Entity base class for all domain objects
- BaseMedicalStaff for staff hierarchy
- Repository base class for data access

✅ **Polymorphism**
- Factory methods for object creation
- Abstract methods for behavior contracts
- Interface implementation for repositories

✅ **Layer Separation**
- Domain: Pure entities (no dependencies)
- Data: Persistence + business logic
- UI: Presentation only

✅ **SOLID Principles**
- **S**ingle Responsibility: Each class has one reason to change
- **O**pen/Closed: Can extend without modifying (Entity, Repository)
- **L**iskov Substitution: Doctor/Nurse can substitute BaseMedicalStaff
- **I**nterface Segregation: Repository defines clear interface
- **D**ependency Inversion: UI depends on abstractions, not concrete classes

---

## 🔍 **CLASS DIAGRAM**

```
                        ┌─────────────┐
                        │   Entity    │ (Abstract)
                        └──────┬──────┘
                               │
            ┌──────────────────┼──────────────────┐
            │                  │                  │
        ┌───▼────┐      ┌──────▼──────┐    ┌──────▼────┐
        │ Patient│      │ Medication  │    │Allergy    │
        └────────┘      └─────────────┘    └───────────┘
            │                  │
            │                  │
        ┌───▼──────────────────▼────────────┐
        │   Prescription                    │
        └──────────────────────────────────┘
                        │
                        │
        ┌───────────────▼────────────────┐
        │  BaseMedicalStaff (Abstract)   │
        │  + getPermission()             │
        └───────┬──────────────┬─────────┘
                │              │
            ┌───▼───┐      ┌───▼────┐
            │Doctor │      │ Nurse  │
            └───────┘      └────────┘
                └────────┬─────────┘
                    │
                MedicalStaff


                    ┌──────────────────┐
                    │ Repository<T>    │ (Abstract Interface)
                    └────────┬─────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
    ┌───▼──────────┐  ┌──────▼──────┐   ┌────────▼─────┐
    │PatientRepo   │  │MedicationRepo  │  │PrescriptionRepo
    └──────────────┘  └───────────────┘  └───────────────┘

```

---

## 📝 **CODE EXAMPLES - BEFORE vs AFTER**

### **BEFORE (Basic)**
```dart
class Patient {
  String id;
  String name;
  List<Allergy> allergies;  // Public - can be modified anywhere!
}

// Problem: Anyone can break data integrity
patient.allergies = null;  // ❌ Crashes!
```

### **AFTER (OOP)**
```dart
class Patient extends Entity {
  final String id;
  final String name;
  final List<Allergy> _allergies;  // Private
  
  List<Allergy> get allergies => _allergies;  // Read-only
  
  bool hasAllergies() => _allergies.isNotEmpty;  // Business logic
}

// Safe: Cannot break data integrity
patient.allergies = null;  // ❌ Compile-time error!
```

---

## 🚀 **TESTING WITH OOP**

```dart
import 'package:test/test.dart';
import 'package:medication_manager/domain/entities/medication.dart';

void main() {
  test('Encapsulation: Cannot set negative stock', () {
    var med = Medication(
      id: 'M001',
      name: 'Paracetamol',
      strength: '500mg',
      form: MedicationForm.tablet,
      stockQuantity: 100,
    );
    
    expect(() => med.stockQuantity = -1, throwsArgumentError);
  });
  
  test('Polymorphism: Different staff types have different permissions', () {
    BaseMedicalStaff doctor = Doctor(id: 'D001', name: 'Smith');
    BaseMedicalStaff nurse = Nurse(id: 'N001', name: 'Wilson');
    
    expect(doctor.getPermission(), contains('create prescriptions'));
    expect(nurse.getPermission(), contains('administer medications'));
  });
}
```

---

## 📚 **ADDITIONAL OOP PATTERNS IMPLEMENTED**

1. **Repository Pattern** - Abstract data access
2. **Factory Pattern** - Object creation via `fromJson()`
3. **Template Method** - Base classes define structure
4. **Strategy Pattern** - Different staff types with different strategies
5. **Data Transfer Object (DTO)** - Entities act as DTOs

---

## ✨ **SUMMARY**

Your project now demonstrates:

✅ **Encapsulation** - Private members with controlled access
✅ **Inheritance** - Clear class hierarchies (Entity, BaseMedicalStaff, Repository)
✅ **Polymorphism** - Multiple implementations, factory methods, abstract classes
✅ **Layer Separation** - Domain, Data, UI layers clearly separated
✅ **SOLID Principles** - Professional-grade architecture
✅ **Design Patterns** - Repository, Factory, Template Method, Strategy

**This is production-ready OOP design! 🎉**

---

**Questions? Check the code examples in each file!**
