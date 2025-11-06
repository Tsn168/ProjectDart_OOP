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
          print('\n[OK] Exiting. Thank you!');
          break;
        default:
          print('[ERROR] Invalid choice. Please enter 1-5.\n');
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
    print('\n[OK] Prescription ID: $prescriptionId (auto-generated)');

    // Date
    print('Enter date (YYYY-MM-DD): ');
    final dateStr =
        stdin.readLineSync() ?? DateTime.now().toString().split(' ')[0];
    DateTime date;
    try {
      date = DateTime.parse(dateStr);
    } catch (e) {
      date = DateTime.now();
      print('[INFO] Using today\'s date: ${date.toString().split(' ')[0]}');
    }

    // Patient name
    stdout.write('Enter patient name: ');
    final patientName = stdin.readLineSync() ?? '';
    if (patientName.isEmpty) {
      print('[ERROR] Patient name cannot be empty.\n');
      return;
    }

    // Type of sickness
    stdout.write('Enter type of sickness: ');
    final sicknessType = stdin.readLineSync() ?? '';
    if (sicknessType.isEmpty) {
      print('[ERROR] Sickness type cannot be empty.\n');
      return;
    }

    // Age
    stdout.write('Enter patient age: ');
    final ageStr = stdin.readLineSync() ?? '0';
    final age = int.tryParse(ageStr) ?? 0;
    if (age <= 0) {
      print('[ERROR] Invalid age.\n');
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
    print('[OK] Selected: ${doctor.name}');

    // Medicine dosage
    stdout.write('Enter medicine dosage (e.g., 500mg x2): ');
    final medicineDosage = stdin.readLineSync() ?? '';
    if (medicineDosage.isEmpty) {
      print('[ERROR] Medicine dosage cannot be empty.\n');
      return;
    }

    // Advice
    stdout.write('Enter doctor\'s advice: ');
    final advice = stdin.readLineSync() ?? '';
    if (advice.isEmpty) {
      print('[ERROR] Advice cannot be empty.\n');
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
      print('[ERROR] Error: $e\n');
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
    print('3. Show Patients First'); // NEW OPTION
    stdout.write('Choose (1-3): ');
    final choice = stdin.readLineSync() ?? '1';

    if (choice == '1') {
      // Delete by ID
      stdout.write('Enter prescription ID: ');
      final idStr = stdin.readLineSync() ?? '';
      final id = int.tryParse(idStr);
      if (id == null) {
        print('[ERROR] Invalid ID.\n');
        return;
      }

      final success = repository.deletePrescriptionById(id);
      if (!success) {
        print('[ERROR] Prescription #$id not found.\n');
      }
    } else if (choice == '2') {
      // Delete by patient name
      stdout.write('Enter patient name: ');
      final name = stdin.readLineSync() ?? '';
      if (name.isEmpty) {
        print('[ERROR] Patient name cannot be empty.\n');
        return;
      }

      final deleted = repository.deleteByPatientName(name);
      if (deleted == 0) {
        print('[ERROR] No prescriptions found for: $name\n');
      }
    } else if (choice == '3') {
      // Show patients first, then delete
      _showPatientList();
      
      stdout.write('\nEnter patient name to delete prescriptions (or press Enter to cancel): ');
      final name = stdin.readLineSync() ?? '';
      if (name.isEmpty) {
        print('[ERROR] Deletion cancelled.\n');
        return;
      }

      final deleted = repository.deleteByPatientName(name);
      if (deleted == 0) {
        print('[ERROR] No prescriptions found for: $name\n');
      }
    } else {
      print('[ERROR] Invalid choice.\n');
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
    print('3. Show All Patients First'); // NEW OPTION
    stdout.write('Choose (1-3): ');
    final choice = stdin.readLineSync() ?? '1';

    List<Prescription> results = [];

    if (choice == '1') {
      results = repository.getAllPrescriptions();
    } else if (choice == '2') {
      // Show patient list before search
      _showPatientList();
      
      stdout.write('\nEnter patient name to search: ');
      final name = stdin.readLineSync() ?? '';
      if (name.isEmpty) {
        print('[ERROR] Patient name cannot be empty.\n');
        return;
      }
      results = repository.searchByPatientName(name);
    } else if (choice == '3') {
      // Just show patient list
      _showPatientList();
      
      stdout.write('\nEnter patient name to view prescriptions (or press Enter to cancel): ');
      final name = stdin.readLineSync() ?? '';
      if (name.isEmpty) {
        return;
      }
      results = repository.searchByPatientName(name);
    } else {
      print('[ERROR] Invalid choice.\n');
      return;
    }

    if (results.isEmpty) {
      print('[INFO] No prescriptions found.\n');
      return;
    }

    print('\n[OK] Found ${results.length} prescription(s):\n');
    for (final prescription in results) {
      print(prescription.displayInfo());
    }
  }

  /// Show list of all patients with prescriptions
  void _showPatientList() {
    final allPrescriptions = repository.getAllPrescriptions();
    
    if (allPrescriptions.isEmpty) {
      print('\n[INFO] No patients found in the system.\n');
      return;
    }

    // Get unique patients
    final patientNames = <String>{};
    final patientData = <Map<String, dynamic>>[];
    
    for (final prescription in allPrescriptions) {
      final patientName = prescription.patient.name;
      if (!patientNames.contains(patientName)) {
        patientNames.add(patientName);
        patientData.add({
          'name': patientName,
          'id': prescription.patient.id,
          'age': prescription.patient.age,
          'gender': prescription.patient.gender,
          'prescriptions': allPrescriptions
              .where((p) => p.patient.name == patientName)
              .length,
        });
      }
    }

    print('\n╔═══════════════════════════════════════════════════════════╗');
    print('║              PATIENTS IN SYSTEM (${patientData.length})                     ║');
    print('╠═══════════════════════════════════════════════════════════╣');
    
    for (var i = 0; i < patientData.length; i++) {
      final patient = patientData[i];
      print('║ ${(i + 1).toString().padRight(2)}. ${patient['name'].toString().padRight(25)} │ Age: ${patient['age'].toString().padLeft(3)} │ ${patient['gender']} │');
      print('║     ID: ${patient['id'].toString().padRight(15)} │ Prescriptions: ${patient['prescriptions']} │');
      if (i < patientData.length - 1) {
        print('╠───────────────────────────────────────────────────────────╣');
      }
    }
    print('╚═══════════════════════════════════════════════════════════╝');
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
        print('[ERROR] Invalid ID.\n');
        return;
      }
      prescription = repository.getPrescriptionById(id);
      if (prescription == null) {
        print('[ERROR] Prescription #$id not found.\n');
        return;
      }
    } else if (choice == '2') {
      stdout.write('Enter patient name: ');
      final name = stdin.readLineSync() ?? '';
      final results = repository.searchByPatientName(name);
      if (results.isEmpty) {
        print('[ERROR] No prescriptions found for: $name\n');
        return;
      }
      if (results.length > 1) {
        print(
            'Found ${results.length} prescriptions. Editing the first one...\n');
      }
      prescription = results[0];
    } else {
      print('[ERROR] Invalid choice.\n');
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
        print('[OK] Edit cancelled.\n');
        return;
      default:
        print('[ERROR] Invalid choice.\n');
        return;
    }

    // Save updated prescription
    repository.updatePrescription(prescription.prescriptionId, prescription);
    print('\n[OK] Updated:');
    print(prescription.displayInfo());
  }
}
