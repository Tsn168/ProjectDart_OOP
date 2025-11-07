# Quick Start Guide

## 🚀 Running the Application

### Step 1: Install Dependencies
```bash
dart pub get
```

### Step 2: Run the Application
```bash
dart run lib/ui/main.dart
```

### Step 3: Login
Choose option 1 (Doctor) or 2 (Nurse) and enter a staff ID:
- **Doctors**: D001, D002
- **Nurses**: N001, N002

## 📝 Example Usage Flow

### As a Doctor (Creating a Prescription)

1. **Login**
   ```
   Choice: 1
   Enter Doctor ID: D001
   ```

2. **Create Prescription**
   ```
   Choice: 2
   Select Patient ID: P002    (Jane Smith - no allergies)
   Select Medication ID: M001  (Paracetamol)
   Enter dosage: 1 tablet
   ```

3. **View the Result**
   ```
   ✅ Prescription created successfully!
   Prescription ID: RX001
   Patient: Jane Smith
   Medication: Paracetamol 500mg
   Dosage: 1 tablet
   ```

### As a Nurse (Administering Medication)

1. **Login**
   ```
   Choice: 2
   Enter Nurse ID: N001
   ```

2. **Record Medication Given**
   ```
   Choice: 2
   Select Prescription ID: RX001
   ```

3. **View the Result**
   ```
   ✅ Medication administered successfully!
   Paracetamol stock updated: 100 → 99
   ```

## 🧪 Running Tests

### Run All Tests
```bash
dart test
```

### Run Specific Test File
```bash
dart test test/domain/patient_test.dart
```

### Expected Test Results
```
00:00 +20: All tests passed!
```

## 📊 Pre-loaded Sample Data

### Medical Staff
| ID   | Name           | Role   |
|------|----------------|--------|
| D001 | Dr. Smith      | Doctor |
| D002 | Dr. Johnson    | Doctor |
| N001 | Nurse Wilson   | Nurse  |
| N002 | Nurse Brown    | Nurse  |

### Patients
| ID   | Name        | Allergies           |
|------|-------------|---------------------|
| P001 | John Doe    | Penicillin (High)   |
| P002 | Jane Smith  | None                |
| P003 | Bob Wilson  | Aspirin (Medium)    |

### Medications
| ID   | Name           | Strength | Form      | Stock |
|------|----------------|----------|-----------|-------|
| M001 | Paracetamol    | 500mg    | Tablet    | 100   |
| M002 | Amoxicillin    | 250mg    | Tablet    | 50    |
| M003 | Ibuprofen      | 200mg    | Tablet    | 75    |
| M004 | Cough Syrup    | 100ml    | Liquid    | 30    |

## ⚠️ Testing Allergy Safety

Try creating a prescription for Patient P001 (John Doe) with Medication M002 (Amoxicillin):

```
Select Patient ID: P001
Select Medication ID: M002

🛑 SAFETY ALERT: Patient allergic to Penicillin (HIGH)!
Create prescription anyway? (y/n): n

❌ Prescription cancelled.
```

## 🔄 Resetting Data

To reset to default data, simply delete the `data/` folder:

```bash
rm -rf data/
```

The application will recreate it with sample data on next run.

## 📂 Project Structure

```
ProjectDart_OOP/
├── lib/
│   ├── domain/        # Entities & Enums
│   ├── data/          # Repositories & Services
│   └── ui/            # Console Interface
├── test/              # Unit Tests
├── data/              # JSON Storage (auto-generated)
└── README.md          # Full Documentation
```

## 🎯 Key Features to Test

1. ✅ **Auto-incrementing IDs** - Create new patients/prescriptions
2. ✅ **Allergy Checking** - Try prescribing to patient P001
3. ✅ **Stock Management** - Administer medications and check stock
4. ✅ **Role-based Access** - Doctor creates, Nurse administers
5. ✅ **Data Persistence** - Data saves to JSON automatically

## 🐛 Troubleshooting

### "Target of URI doesn't exist" error
Run:
```bash
dart pub get
```

### No data showing
Delete the `data/` folder and restart the application.

### Tests failing
Make sure you're in the project root directory:
```bash
cd /path/to/ProjectDart_OOP
dart test
```

## 📚 Next Steps

1. Try creating multiple prescriptions
2. Test the allergy safety system
3. Administer medications and watch stock decrease
4. Explore the JSON files in the `data/` folder
5. Run the unit tests to understand the code

---

**Happy coding! 🎉**
