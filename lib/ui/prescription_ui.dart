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

    // Get Doctor info
    stdout.write('Enter doctor ID: ');
    final doctorId = stdin.readLineSync() ?? 'DOC001';

    stdout.write('Enter doctor name: ');
    final doctorName = stdin.readLineSync() ?? '';
    if (doctorName.isEmpty) {
      print('✗ Doctor name cannot be empty.\n');
      return;
    }

    stdout.write('Enter doctor age: ');
    final ageStr = stdin.readLineSync() ?? '30';
    final age = int.tryParse(ageStr) ?? 30;

    stdout.write('Enter doctor email: ');
    final email = stdin.readLineSync() ?? 'doctor@hospital.com';

    stdout.write('Enter doctor phone: ');
    final phone = stdin.readLineSync() ?? '123456789';

    stdout.write('Enter staff ID: ');
    final staffId = stdin.readLineSync() ?? 'STAFF001';

    stdout.write('Enter department: ');
    final department = stdin.readLineSync() ?? 'General';

    stdout.write('Enter salary: ');
    final salaryStr = stdin.readLineSync() ?? '50000';
    final salary = double.tryParse(salaryStr) ?? 50000.0;

    stdout.write('Enter specialization: ');
    final specialization = stdin.readLineSync() ?? 'General Practice';

    stdout.write('Enter license number: ');
    final license = stdin.readLineSync() ?? 'LIC001';

    stdout.write('Enter expertise (comma-separated): ');
    final expertiseStr = stdin.readLineSync() ?? 'Internal Medicine';
    final expertise = expertiseStr.split(',').map((e) => e.trim()).toList();

    try {
      final doctor = Doctor(
        id: doctorId,
        name: doctorName,
        age: age,
        email: email,
        phone: phone,
        staffId: staffId,
        department: department,
        salary: salary,
        joinDate: DateTime.now(),
        specialization: specialization,
        license: license,
        expertise: expertise,
      );

      // Get Patient info
      stdout.write('Enter patient ID: ');
      final patientId = stdin.readLineSync() ?? 'PAT001';

      stdout.write('Enter patient name: ');
      final patientName = stdin.readLineSync() ?? '';
      if (patientName.isEmpty) {
        print('✗ Patient name cannot be empty.\n');
        return;
      }

      stdout.write('Enter patient age: ');
      final patientAgeStr = stdin.readLineSync() ?? '25';
      final patientAge = int.tryParse(patientAgeStr) ?? 25;

      stdout.write('Enter patient email: ');
      final patientEmail = stdin.readLineSync() ?? 'patient@email.com';

      stdout.write('Enter patient phone: ');
      final patientPhone = stdin.readLineSync() ?? '987654321';

      stdout.write(
          'Enter patient blood type (O+, O-, A+, A-, B+, B-, AB+, AB-): ');
      final bloodType = stdin.readLineSync() ?? 'O+';

      stdout.write('Enter medical history (comma-separated): ');
      final historyStr = stdin.readLineSync() ?? 'None';
      final medicalHistory =
          historyStr.split(',').map((e) => e.trim()).toList();

      stdout.write('Enter allergies (comma-separated): ');
      final allergiesStr = stdin.readLineSync() ?? 'None';
      final allergies = allergiesStr.split(',').map((e) => e.trim()).toList();

      final patient = Patient(
        id: patientId,
        name: patientName,
        age: patientAge,
        email: patientEmail,
        phone: patientPhone,
        patientId: patientId,
        bloodType: bloodType,
        medicalHistory: medicalHistory,
        allergies: allergies,
      );

      // Get Prescription details
      stdout.write('Enter prescription ID: ');
      final prescriptionId =
          stdin.readLineSync() ?? 'RX${DateTime.now().millisecondsSinceEpoch}';

      stdout.write('Enter diagnosis: ');
      final diagnosis = stdin.readLineSync() ?? 'General Checkup';

      stdout.write('Enter prescription notes: ');
      final notes = stdin.readLineSync() ?? 'Follow-up in 2 weeks';

      stdout.write('Enter number of medicines: ');
      final numMedicinesStr = stdin.readLineSync() ?? '1';
      final numMedicines = int.tryParse(numMedicinesStr) ?? 1;

      final medicines = <Tablet>[];
      for (int i = 0; i < numMedicines; i++) {
        stdout.write('Enter medicine ${i + 1} ID: ');
        final medId = stdin.readLineSync() ?? 'MED00${i + 1}';

        stdout.write('Enter medicine ${i + 1} name: ');
        final medicineName = stdin.readLineSync() ?? '';

        if (medicineName.isEmpty) continue;

        stdout.write('Enter medicine description: ');
        final description = stdin.readLineSync() ?? 'Standard medicine';

        stdout.write('Enter medicine price: ');
        final priceStr = stdin.readLineSync() ?? '10.0';
        final price = double.tryParse(priceStr) ?? 10.0;

        stdout.write('Enter stock quantity: ');
        final stockStr = stdin.readLineSync() ?? '100';
        final stock = int.tryParse(stockStr) ?? 100;

        stdout.write('Enter tablet strength (e.g., 500mg): ');
        final strength = stdin.readLineSync() ?? '500mg';

        stdout.write('Enter tablets per strip: ');
        final stripStr = stdin.readLineSync() ?? '10';
        final tabletsPerStrip = int.tryParse(stripStr) ?? 10;

        medicines.add(Tablet(
          medicineId: medId,
          name: medicineName,
          description: description,
          price: price,
          stock: stock,
          strength: strength,
          tabletsPerStrip: tabletsPerStrip,
        ));
      }

      if (medicines.isEmpty) {
        print('✗ At least one medicine is required.\n');
        return;
      }

      final prescription = Prescription(
        prescriptionId: prescriptionId,
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
