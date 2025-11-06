import 'dart:io';
import '../data/prescription_repository.dart';
import '../domain/prescription.dart';
import '../domain/doctor.dart';
import '../domain/patient.dart';

/// Simple UI for prescription management
class PrescriptionUI {
  final PrescriptionRepository repository;
  final List<Doctor> defaultDoctors;

  PrescriptionUI(this.repository)
      : defaultDoctors = [
          Doctor(
            id: 'DOC001',
            name: 'Dr. Tep Somnang',
            age: 45,
            gender: 'Male',
            specialization: 'General Medicine',
          ),
          Doctor(
            id: 'DOC002',
            name: 'Dr. Tet Elite',
            age: 38,
            gender: 'Female',
            specialization: 'Child Specialist',
          ),
          Doctor(
            id: 'DOC003',
            name: 'Dr. Choeng Rayu',
            age: 52,
            gender: 'Male',
            specialization: 'Heart Pressure',
          ),
        ];

  /// Start the UI menu
  void start() {
    bool isRunning = true;
    while (isRunning) {
      _displayMenu();
      final choice = stdin.readLineSync() ?? '';

      switch (choice.trim()) {
        case '1':
          _addNewPrescription();
          break;
        case '2':
          _deletePrescription();
          break;
        case '3':
          _viewPrescriptions();
          break;
        case '4':
          _editPrescription();
          break;
        case '5':
          isRunning = false;
          print('\n✓ Exiting. Thank you!');
          break;
        default:
          print('✗ Invalid choice. Please enter 1-5.\n');
      }
    }
  }

  /// Display main menu
  void _displayMenu() {
    print('\n╔═══════════════════════════════════════════╗');
    print('║   PRESCRIPTION MANAGEMENT SYSTEM        ║');
    print('╠═══════════════════════════════════════════╣');
    print('║ 1. Add New Prescription                  ║');
    print('║ 2. Delete Prescription                   ║');
    print('║ 3. View Prescriptions                    ║');
    print('║ 4. Edit Prescription                     ║');
    print('║ 5. Exit                                  ║');
    print('╚═══════════════════════════════════════════╝');
    stdout.write('Enter choice (1-5): ');
  }

  /// Add new prescription
  void _addNewPrescription() {
    print('\n╔═══════════════════════════════════════════╗');
    print('║       ADD NEW PRESCRIPTION              ║');
    print('╚═══════════════════════════════════════════╝');

    // Prescription ID (auto-increment)
    final prescriptionId = repository.getNextId();
    print('\n✓ Prescription ID: $prescriptionId (auto-generated)');

    // Date
    print('Enter date (YYYY-MM-DD): ');
    final dateStr =
        stdin.readLineSync() ?? DateTime.now().toString().split(' ')[0];
    DateTime date;
    try {
      date = DateTime.parse(dateStr);
    } catch (e) {
      date = DateTime.now();
      print('ℹ Using today\'s date: ${date.toString().split(' ')[0]}');
    }

    // Patient name
    stdout.write('Enter patient name: ');
    final patientName = stdin.readLineSync() ?? '';
    if (patientName.isEmpty) {
      print('✗ Patient name cannot be empty.\n');
      return;
    }

    // Type of sickness
    stdout.write('Enter type of sickness: ');
    final sicknessType = stdin.readLineSync() ?? '';
    if (sicknessType.isEmpty) {
      print('✗ Sickness type cannot be empty.\n');
      return;
    }

    // Age
    stdout.write('Enter patient age: ');
    final ageStr = stdin.readLineSync() ?? '0';
    final age = int.tryParse(ageStr) ?? 0;
    if (age <= 0) {
      print('✗ Invalid age.\n');
      return;
    }

    // Gender
    stdout.write('Enter patient gender (M/F): ');
    final genderInput = stdin.readLineSync()?.toUpperCase() ?? 'M';
    final gender =
        (genderInput == 'F' || genderInput == 'Female') ? 'Female' : 'Male';

    // Select doctor
    print('\n--- SELECT DOCTOR ---');
    for (int i = 0; i < defaultDoctors.length; i++) {
      print(
          '${i + 1}. ${defaultDoctors[i].name} (${defaultDoctors[i].specialization})');
    }
    stdout.write('Choose doctor (1-${defaultDoctors.length}): ');
    final doctorChoice = stdin.readLineSync() ?? '1';
    final doctorIndex = (int.tryParse(doctorChoice) ?? 1) - 1;
    final doctor = (doctorIndex >= 0 && doctorIndex < defaultDoctors.length)
        ? defaultDoctors[doctorIndex]
        : defaultDoctors[0];
    print('✓ Selected: ${doctor.name}');

    // Medicine dosage
    stdout.write('Enter medicine dosage (e.g., 500mg x2): ');
    final medicineDosage = stdin.readLineSync() ?? '';
    if (medicineDosage.isEmpty) {
      print('✗ Medicine dosage cannot be empty.\n');
      return;
    }

    // Advice
    stdout.write('Enter doctor\'s advice: ');
    final advice = stdin.readLineSync() ?? '';
    if (advice.isEmpty) {
      print('✗ Advice cannot be empty.\n');
      return;
    }

    // Create prescription
    try {
      // Create Patient object
      final patient = Patient(
        id: 'PAT${DateTime.now().millisecondsSinceEpoch}',
        name: patientName,
        age: age,
        gender: gender,
        medicalHistory: '', // Could be added in future enhancements
        allergies: '', // Could be added in future enhancements
      );

      final prescription = Prescription(
        prescriptionId: prescriptionId,
        date: date,
        patient: patient,
        sicknessType: sicknessType,
        doctor: doctor,
        medicineDosage: medicineDosage,
        advice: advice,
      );

      repository.addPrescription(prescription);
      print(prescription.displayInfo());
    } catch (e) {
      print('✗ Error: $e\n');
    }
  }

  /// Delete prescription
  void _deletePrescription() {
    print('\n╔═══════════════════════════════════════════╗');
    print('║       DELETE PRESCRIPTION               ║');
    print('╚═══════════════════════════════════════════╝');

    print('\nDelete by:');
    print('1. Prescription ID');
    print('2. Patient Name');
    stdout.write('Choose (1-2): ');
    final choice = stdin.readLineSync() ?? '1';

    if (choice == '1') {
      // Delete by ID
      stdout.write('Enter prescription ID: ');
      final idStr = stdin.readLineSync() ?? '';
      final id = int.tryParse(idStr);
      if (id == null) {
        print('✗ Invalid ID.\n');
        return;
      }

      final success = repository.deletePrescriptionById(id);
      if (!success) {
        print('✗ Prescription #$id not found.\n');
      }
    } else if (choice == '2') {
      // Delete by patient name
      stdout.write('Enter patient name: ');
      final name = stdin.readLineSync() ?? '';
      if (name.isEmpty) {
        print('✗ Patient name cannot be empty.\n');
        return;
      }

      final deleted = repository.deleteByPatientName(name);
      if (deleted == 0) {
        print('✗ No prescriptions found for: $name\n');
      }
    } else {
      print('✗ Invalid choice.\n');
    }
  }

  /// View prescriptions
  void _viewPrescriptions() {
    print('\n╔═══════════════════════════════════════════╗');
    print('║       VIEW PRESCRIPTIONS                ║');
    print('╚═══════════════════════════════════════════╝');

    print('\nView:');
    print('1. All Prescriptions');
    print('2. Search by Patient Name');
    stdout.write('Choose (1-2): ');
    final choice = stdin.readLineSync() ?? '1';

    List<Prescription> results = [];

    if (choice == '1') {
      results = repository.getAllPrescriptions();
    } else if (choice == '2') {
      stdout.write('Enter patient name: ');
      final name = stdin.readLineSync() ?? '';
      if (name.isEmpty) {
        print('✗ Patient name cannot be empty.\n');
        return;
      }
      results = repository.searchByPatientName(name);
    } else {
      print('✗ Invalid choice.\n');
      return;
    }

    if (results.isEmpty) {
      print('ℹ No prescriptions found.\n');
      return;
    }

    print('\n✓ Found ${results.length} prescription(s):\n');
    for (final prescription in results) {
      print(prescription.displayInfo());
    }
  }

  /// Edit prescription
  void _editPrescription() {
    print('\n╔═══════════════════════════════════════════╗');
    print('║       EDIT PRESCRIPTION                 ║');
    print('╚═══════════════════════════════════════════╝');

    print('\nFind by:');
    print('1. Prescription ID');
    print('2. Patient Name');
    stdout.write('Choose (1-2): ');
    final choice = stdin.readLineSync() ?? '1';

    Prescription? prescription;

    if (choice == '1') {
      stdout.write('Enter prescription ID: ');
      final idStr = stdin.readLineSync() ?? '';
      final id = int.tryParse(idStr);
      if (id == null) {
        print('✗ Invalid ID.\n');
        return;
      }
      prescription = repository.getPrescriptionById(id);
      if (prescription == null) {
        print('✗ Prescription #$id not found.\n');
        return;
      }
    } else if (choice == '2') {
      stdout.write('Enter patient name: ');
      final name = stdin.readLineSync() ?? '';
      final results = repository.searchByPatientName(name);
      if (results.isEmpty) {
        print('✗ No prescriptions found for: $name\n');
        return;
      }
      if (results.length > 1) {
        print(
            'Found ${results.length} prescriptions. Editing the first one...\n');
      }
      prescription = results[0];
    } else {
      print('✗ Invalid choice.\n');
      return;
    }

    print('\nCurrent prescription:');
    print(prescription.displayInfo());

    print('What to edit?');
    print('1. Patient Name');
    print('2. Sickness Type');
    print('3. Age');
    print('4. Gender');
    print('5. Doctor');
    print('6. Medicine Dosage');
    print('7. Advice');
    print('8. Cancel');
    stdout.write('Choose (1-8): ');
    final editChoice = stdin.readLineSync() ?? '8';

    switch (editChoice) {
      case '1':
        stdout.write('Enter new patient name: ');
        final newName = stdin.readLineSync() ?? '';
        if (newName.isNotEmpty) {
          final updatedPatient = Patient(
            id: prescription.patient.id,
            name: newName,
            age: prescription.patient.age,
            gender: prescription.patient.gender,
            medicalHistory: prescription.patient.medicalHistory,
            allergies: prescription.patient.allergies,
          );
          prescription.patient = updatedPatient;
        }
        break;
      case '2':
        stdout.write('Enter new sickness type: ');
        final newSickness = stdin.readLineSync() ?? '';
        if (newSickness.isNotEmpty) {
          prescription.sicknessType = newSickness;
        }
        break;
      case '3':
        stdout.write('Enter new age: ');
        final newAgeStr = stdin.readLineSync() ?? '';
        final newAge = int.tryParse(newAgeStr);
        if (newAge != null && newAge > 0) {
          final updatedPatient = Patient(
            id: prescription.patient.id,
            name: prescription.patient.name,
            age: newAge,
            gender: prescription.patient.gender,
            medicalHistory: prescription.patient.medicalHistory,
            allergies: prescription.patient.allergies,
          );
          prescription.patient = updatedPatient;
        }
        break;
      case '4':
        stdout.write('Enter new gender (M/F): ');
        final newGenderInput = stdin.readLineSync()?.toUpperCase() ?? 'M';
        final newGender = (newGenderInput == 'F' || newGenderInput == 'Female')
            ? 'Female'
            : 'Male';
        final updatedPatient = Patient(
          id: prescription.patient.id,
          name: prescription.patient.name,
          age: prescription.patient.age,
          gender: newGender,
          medicalHistory: prescription.patient.medicalHistory,
          allergies: prescription.patient.allergies,
        );
        prescription.patient = updatedPatient;
        break;
      case '5':
        print('\n--- SELECT DOCTOR ---');
        for (int i = 0; i < defaultDoctors.length; i++) {
          print(
              '${i + 1}. ${defaultDoctors[i].name} (${defaultDoctors[i].specialization})');
        }
        stdout.write('Choose doctor (1-${defaultDoctors.length}): ');
        final doctorChoice = stdin.readLineSync() ?? '1';
        final doctorIndex = (int.tryParse(doctorChoice) ?? 1) - 1;
        if (doctorIndex >= 0 && doctorIndex < defaultDoctors.length) {
          prescription.doctor = defaultDoctors[doctorIndex];
        }
        break;
      case '6':
        stdout.write('Enter new medicine dosage: ');
        final newDosage = stdin.readLineSync() ?? '';
        if (newDosage.isNotEmpty) {
          prescription.medicineDosage = newDosage;
        }
        break;
      case '7':
        stdout.write('Enter new advice: ');
        final newAdvice = stdin.readLineSync() ?? '';
        if (newAdvice.isNotEmpty) {
          prescription.advice = newAdvice;
        }
        break;
      case '8':
        print('✓ Edit cancelled.\n');
        return;
      default:
        print('✗ Invalid choice.\n');
        return;
    }

    // Save updated prescription
    repository.updatePrescription(prescription.prescriptionId, prescription);
    print('\n✓ Updated:');
    print(prescription.displayInfo());
  }
}
