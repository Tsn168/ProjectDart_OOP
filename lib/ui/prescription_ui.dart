import 'dart:io';
import '../data/prescription_repository.dart';
import '../domain/prescription.dart';
import '../domain/doctor.dart';
import '../domain/patient.dart';
import '../domain/tablet.dart';

/// UI Layer for managing prescriptions
class PrescriptionUI {
  final PrescriptionRepository repository;

  PrescriptionUI(this.repository);

  void start() {
    bool isRunning = true;
    while (isRunning) {
      _displayMainMenu();
      final choice = stdin.readLineSync() ?? '';

      switch (choice.trim()) {
        case '1':
          _addNewPrescription();
          break;
        case '2':
          _viewAllPrescriptions();
          break;
        case '3':
          _searchByPatient();
          break;
        case '4':
          _searchByDoctor();
          break;
        case '5':
          _viewActivePrescriptions();
          break;
        case '6':
          _deletePrescription();
          break;
        case '7':
          isRunning = false;
          print('\n✓ Exiting Prescription Management System. Goodbye!');
          break;
        default:
          print('✗ Invalid choice. Please enter a number between 1 and 7.\n');
      }
    }
  }

  void _displayMainMenu() {
    print('\n╔════════════════════════════════════════════╗');
    print('║   PRESCRIPTION MANAGEMENT SYSTEM         ║');
    print('╠════════════════════════════════════════════╣');
    print('║ 1. Add New Prescription                   ║');
    print('║ 2. View All Prescriptions                ║');
    print('║ 3. Search by Patient Name                ║');
    print('║ 4. Search by Doctor Name                 ║');
    print('║ 5. View Active Prescriptions             ║');
    print('║ 6. Delete Prescription                   ║');
    print('║ 7. Exit                                  ║');
    print('╚════════════════════════════════════════════╝');
    stdout.write('Enter your choice (1-7): ');
  }

  void _addNewPrescription() {
    print('\n╔════════════════════════════════════════════╗');
    print('║       ADD NEW PRESCRIPTION               ║');
    print('╚════════════════════════════════════════════╝');

    // Select or create Doctor
    print('\n--- DOCTOR SELECTION ---');
    print('1. Use existing sample doctor (Dr. John Doe)');
    print('2. Enter new doctor details');
    stdout.write('Choose option (1 or 2): ');
    final doctorOption = stdin.readLineSync() ?? '1';

    Doctor doctor;
    if (doctorOption == '1') {
      // Use sample doctor
      doctor = Doctor(
        id: 'DOC001',
        name: 'Dr. John Doe',
        age: 45,
        email: 'john.doe@hospital.com',
        phone: '555-0101',
        staffId: 'STAFF001',
        department: 'Internal Medicine',
        salary: 85000.0,
        joinDate: DateTime(2015, 1, 15),
        specialization: 'Internal Medicine',
        license: 'LIC-2015-001',
        expertise: ['Cardiology', 'Hypertension', 'Diabetes'],
      );
      print('✓ Using Dr. John Doe');
    } else {
      // Enter new doctor
      stdout.write('Enter doctor name: ');
      final doctorName = stdin.readLineSync() ?? '';
      if (doctorName.isEmpty) {
        print('✗ Doctor name cannot be empty.\n');
        return;
      }

      stdout.write('Enter specialization: ');
      final specialization = stdin.readLineSync() ?? 'General Practice';

      stdout.write('Enter license number: ');
      final license = stdin.readLineSync() ?? 'LIC001';

      try {
        doctor = Doctor(
          id: 'DOC${DateTime.now().millisecondsSinceEpoch}',
          name: doctorName,
          age: 35,
          email: 'doctor@hospital.com',
          phone: '555-0000',
          staffId: 'STAFF${DateTime.now().millisecondsSinceEpoch}',
          department: 'General',
          salary: 70000.0,
          joinDate: DateTime.now(),
          specialization: specialization,
          license: license,
          expertise: ['General Practice'],
        );
        print('✓ New doctor added: $doctorName');
      } catch (e) {
        print('✗ Error creating doctor: $e\n');
        return;
      }
    }

    // Select or create Patient
    print('\n--- PATIENT SELECTION ---');
    print('1. Use sample patient (John Smith)');
    print('2. Enter new patient details');
    stdout.write('Choose option (1 or 2): ');
    final patientOption = stdin.readLineSync() ?? '1';

    Patient patient;
    if (patientOption == '1') {
      // Use sample patient
      patient = Patient(
        id: 'PAT001',
        name: 'John Smith',
        age: 52,
        email: 'john.smith@email.com',
        phone: '555-1001',
        patientId: 'PAT001',
        bloodType: 'O+',
        medicalHistory: ['Hypertension', 'Type 2 Diabetes'],
        allergies: ['Penicillin'],
      );
      print('✓ Using John Smith');
    } else {
      // Enter new patient
      stdout.write('Enter patient name: ');
      final patientName = stdin.readLineSync() ?? '';
      if (patientName.isEmpty) {
        print('✗ Patient name cannot be empty.\n');
        return;
      }

      stdout.write('Enter blood type (O+, O-, A+, A-, B+, B-, AB+, AB-): ');
      final bloodType = stdin.readLineSync() ?? 'O+';

      try {
        patient = Patient(
          id: 'PAT${DateTime.now().millisecondsSinceEpoch}',
          name: patientName,
          age: 30,
          email: 'patient@email.com',
          phone: '555-2000',
          patientId: 'PAT${DateTime.now().millisecondsSinceEpoch}',
          bloodType: bloodType,
          medicalHistory: [],
          allergies: [],
        );
        print('✓ New patient added: $patientName');
      } catch (e) {
        print('✗ Error creating patient: $e\n');
        return;
      }
    }

    // Add medicines for prescription
    print('\n--- MEDICINES ---');
    stdout.write('Enter number of medicines (1-5): ');
    final numMedicinesStr = stdin.readLineSync() ?? '1';
    final numMedicines = int.tryParse(numMedicinesStr) ?? 1;

    final medicines = <Tablet>[];
    for (int i = 0; i < numMedicines; i++) {
      stdout.write('Medicine ${i + 1} name: ');
      final medicineName = stdin.readLineSync() ?? '';

      if (medicineName.isEmpty) continue;

      stdout.write('Strength (e.g., 500mg): ');
      final strength = stdin.readLineSync() ?? '500mg';

      stdout.write('Price: ');
      final priceStr = stdin.readLineSync() ?? '10.0';
      final price = double.tryParse(priceStr) ?? 10.0;

      medicines.add(Tablet(
        medicineId: 'MED${DateTime.now().millisecondsSinceEpoch}$i',
        name: medicineName,
        description: '$medicineName - $strength',
        price: price,
        stock: 100,
        strength: strength,
        tabletsPerStrip: 10,
      ));
    }

    if (medicines.isEmpty) {
      print('✗ At least one medicine is required.\n');
      return;
    }

    // Prescription details
    print('\n--- PRESCRIPTION DETAILS ---');
    stdout.write('Diagnosis: ');
    final diagnosis = stdin.readLineSync() ?? 'General Checkup';

    stdout.write('Notes: ');
    final notes = stdin.readLineSync() ?? 'Follow-up in 2 weeks';

    try {
      final prescription = Prescription(
        prescriptionId: 'RX${DateTime.now().millisecondsSinceEpoch}',
        doctor: doctor,
        patient: patient,
        medicines: medicines,
        diagnosis: diagnosis,
        issuedDate: DateTime.now(),
        expiryDate: DateTime.now().add(Duration(days: 30)),
        notes: notes,
      );

      repository.addPrescription(prescription);
      print('\n✓ Prescription added successfully!');
      print('Prescription ID: ${prescription.prescriptionId}');
      print('Total Cost: \$${prescription.getTotalCost().toStringAsFixed(2)}');
    } catch (e) {
      print('✗ Error creating prescription: $e\n');
    }
  }

  void _viewAllPrescriptions() {
    print('\n╔════════════════════════════════════════════╗');
    print('║       ALL PRESCRIPTIONS                  ║');
    print('╚════════════════════════════════════════════╝');

    final prescriptions = repository.getAllPrescriptions();

    if (prescriptions.isEmpty) {
      print('ℹ No prescriptions found in the system.\n');
      return;
    }

    print('Total Prescriptions: ${prescriptions.length}\n');
    for (final prescription in prescriptions) {
      print(prescription.displayInfo());
    }
  }

  void _searchByPatient() {
    print('\n╔════════════════════════════════════════════╗');
    print('║      SEARCH BY PATIENT NAME              ║');
    print('╚════════════════════════════════════════════╝');

    stdout.write('Enter patient name to search: ');
    final patientName = stdin.readLineSync() ?? '';

    if (patientName.isEmpty) {
      print('✗ Patient name cannot be empty.\n');
      return;
    }

    final results = repository.searchByPatientName(patientName);

    if (results.isEmpty) {
      print('ℹ No prescriptions found for patient: "$patientName"\n');
      return;
    }

    print('Found ${results.length} prescription(s) for "$patientName":\n');
    for (final prescription in results) {
      print(prescription.displayInfo());
    }
  }

  void _searchByDoctor() {
    print('\n╔════════════════════════════════════════════╗');
    print('║       SEARCH BY DOCTOR NAME              ║');
    print('╚════════════════════════════════════════════╝');

    stdout.write('Enter doctor name to search: ');
    final doctorName = stdin.readLineSync() ?? '';

    if (doctorName.isEmpty) {
      print('✗ Doctor name cannot be empty.\n');
      return;
    }

    final results = repository.searchByDoctorName(doctorName);

    if (results.isEmpty) {
      print('ℹ No prescriptions found for doctor: "$doctorName"\n');
      return;
    }

    print('Found ${results.length} prescription(s) by "$doctorName":\n');
    for (final prescription in results) {
      print(prescription.displayInfo());
    }
  }

  void _viewActivePrescriptions() {
    print('\n╔════════════════════════════════════════════╗');
    print('║      ACTIVE PRESCRIPTIONS                ║');
    print('╚════════════════════════════════════════════╝');

    final activePrescriptions = repository.getActivePrescriptions();

    if (activePrescriptions.isEmpty) {
      print('ℹ No active prescriptions found.\n');
      return;
    }

    print('Active Prescriptions: ${activePrescriptions.length}\n');
    for (final prescription in activePrescriptions) {
      print(prescription.displayInfo());
    }
  }

  void _deletePrescription() {
    print('\n╔════════════════════════════════════════════╗');
    print('║      DELETE PRESCRIPTION                 ║');
    print('╚════════════════════════════════════════════╝');

    stdout.write('Enter prescription ID to delete: ');
    final prescriptionId = stdin.readLineSync() ?? '';

    if (prescriptionId.isEmpty) {
      print('✗ Prescription ID cannot be empty.\n');
      return;
    }

    final prescription = repository.getPrescriptionById(prescriptionId);
    if (prescription == null) {
      print('✗ Prescription with ID "$prescriptionId" not found.\n');
      return;
    }

    print('\nPrescription to delete:');
    print(prescription.displayInfo());

    stdout
        .write('Are you sure you want to delete this prescription? (yes/no): ');
    final confirm = stdin.readLineSync()?.toLowerCase() ?? '';

    if (confirm == 'yes' || confirm == 'y') {
      final success = repository.deletePrescription(prescriptionId);
      if (success) {
        print('✓ Prescription deleted successfully.\n');
      } else {
        print('✗ Failed to delete prescription.\n');
      }
    } else {
      print('✓ Deletion cancelled.\n');
    }
  }
}
