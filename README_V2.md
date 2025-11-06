# 🏥 PRESCRIPTION MANAGEMENT SYSTEM - VERSION 2.0

## ✅ COMPLETED - COMPLETELY REBUILT PROJECT

### 📋 What Was Done:

#### 1. **Domain Layer (OOP Implementation)**
   - **Person.dart** (Abstract Base Class)
     - INHERITANCE: Base class for Doctor and Patient
     - ENCAPSULATION: Private fields (_id, _name, _age, _gender) with getters
     - POLYMORPHISM: Abstract method getRole()
   
   - **Doctor.dart** (Extends Person)
     - INHERITANCE: Extends Person
     - New fields: specialization
     - 3 DEFAULT DOCTORS:
       - Dr. Tep Somnang (General Medicine)
       - Dr. Tet Elite (Child Specialist)  
       - Dr. Choeng Rayu (Heart Pressure)
   
   - **Prescription.dart** (NEW simplified model)
     - Fields:
       - prescriptionId (auto-increment)
       - date
       - patientName
       - sicknessType
       - age
       - gender
       - doctor (Doctor object)
       - medicineDosage
       - advice
     - ENCAPSULATION: Private fields with getters/setters
     - JSON serialization (toMap, fromMap)

#### 2. **Data Layer (Repository Pattern)**
   - **PrescriptionRepository.dart**
     - Auto-increment ID generation (getNextId())
     - CRUD Operations:
       - addPrescription()
       - getAllPrescriptions()
       - getPrescriptionById()
       - searchByPatientName()
       - updatePrescription()
       - deletePrescriptionById()
       - deleteByPatientName()
     - JSON Persistence:
       - _loadFromJson() - Load on startup
       - _saveToJson() - Auto-save on changes

#### 3. **UI Layer (User Interface)**
   - **PrescriptionUI.dart** - 5 Menu Options:
     1. **ADD NEW PRESCRIPTION**
        - Auto-increment ID
        - Input: date, patient_name, sickness_type, age, gender
        - Select from 3 doctors
        - Input: medicine_dosage, advice
     
     2. **DELETE PRESCRIPTION**
        - Delete by Prescription ID
        - Delete by Patient Name
     
     3. **VIEW PRESCRIPTIONS**
        - View all prescriptions
        - Search by Patient Name
     
     4. **EDIT PRESCRIPTION**
        - Find by ID or Patient Name
        - Edit any field:
          - Patient Name
          - Sickness Type
          - Age
          - Gender
          - Doctor (select from 3)
          - Medicine Dosage
          - Advice
     
     5. **EXIT**

   - Default Doctors built-in (no need to create):
     ```
     1. Dr. Tep Somnang (General Medicine)
     2. Dr. Tet Elite (Child Specialist)
     3. Dr. Choeng Rayu (Heart Pressure)
     ```

#### 4. **Main Entry Point**
   - **main_new.dart** - Initializes system with welcome message

---

## 📁 File Structure

```
lib/
├── main_new.dart                          ← START HERE
├── domain/
│   ├── person.dart                        ← Abstract base (INHERITANCE)
│   ├── doctor.dart                        ← Extends Person (INHERITANCE)
│   └── prescription_new.dart              ← Prescription model
├── data/
│   └── prescription_repository_new.dart   ← CRUD + JSON persistence
└── ui/
    └── prescription_ui_new.dart           ← 5-menu interface
data/
└── prescriptions.json                     ← Auto-saved prescriptions
```

---

## 🎓 OOP Concepts Applied

### 1. **INHERITANCE**
   - Person (abstract) → Doctor (concrete)
   - Reuse common properties (id, name, age, gender)

### 2. **ENCAPSULATION**
   - Private fields: _id, _name, _age, _gender, _specialization
   - Public getters: id, name, age, gender, specialization
   - Setters for editable fields in Prescription

### 3. **POLYMORPHISM**
   - Abstract method: getRole()
   - Doctor.getRole() returns "Doctor"
   - Different implementations can return different roles

### 4. **COMPOSITION**
   - Prescription contains Doctor object
   - Prescription contains all patient/medicine details

---

## 💾 JSON Persistence

**Auto-saves to**: `data/prescriptions.json`

**Example format:**
```json
[
  {
    "prescriptionId": 1,
    "date": "2024-11-06T10:30:00.000",
    "patientName": "John Doe",
    "sicknessType": "Fever",
    "age": 25,
    "gender": "Male",
    "doctor": {
      "id": "DOC001",
      "name": "Dr. Tep Somnang",
      "age": 45,
      "gender": "Male",
      "specialization": "General Medicine"
    },
    "medicineDosage": "500mg x2",
    "advice": "Rest and drink water"
  }
]
```

---

## 🚀 How to Run

```bash
cd /Users/macbookpro/Documents/School/year3-term1/Mobile_developement/ProjectDart_OOP
dart run lib/main_new.dart
```

### Menu Options:
```
╔═══════════════════════════════════════════╗
║   PRESCRIPTION MANAGEMENT SYSTEM        ║
╠═══════════════════════════════════════════╣
║ 1. Add New Prescription                  ║
║ 2. Delete Prescription                   ║
║ 3. View Prescriptions                    ║
║ 4. Edit Prescription                     ║
║ 5. Exit                                  ║
╚═══════════════════════════════════════════╝
```

---

## ✅ Features Implemented

✓ Auto-increment Prescription IDs  
✓ 3 Default Doctors (no need to create)  
✓ Add new prescriptions with all fields  
✓ Delete by ID or Patient Name  
✓ View all or search prescriptions  
✓ Edit prescriptions (any field)  
✓ JSON file persistence  
✓ ENCAPSULATION with private/public fields  
✓ INHERITANCE (Person → Doctor)  
✓ POLYMORPHISM (abstract methods)  
✓ COMPOSITION (Prescription has Doctor)  

---

## ✅ Verification

```bash
# Check compilation
dart analyze lib/domain/prescription_new.dart \
              lib/data/prescription_repository_new.dart \
              lib/ui/prescription_ui_new.dart \
              lib/main_new.dart
# Result: No issues found!
```

---

## 📝 Notes

- **Prescription IDs** auto-increment from 1, 2, 3...
- **Doctors** are pre-configured (no need to add them manually)
- **Data** persists in `data/prescriptions.json`
- **All data** is re-loadable on app restart
- **User-friendly** console interface with clear menus

---

**READY TO USE!** 🎉
