import 'dart:io';
import '../domain/doctor.dart';
import '../domain/patient.dart';
import '../domain/medicine.dart';
import '../domain/prescription_service.dart';
import '../data/prescription_repo.dart';

class PrescriptionConsole {
  final PrescriptionRepository prescriptionRepository;
  final PrescriptionService prescriptionService;
  final List<Doctor> doctors;
  final List<Patient> patients;
  final List<Medicine> medicines;

  PrescriptionConsole(
    this.prescriptionRepository,
    this.prescriptionService,
    this.doctors,
    this.patients,
    this.medicines,
  );
// Ai generating
  void displayMainMenu() {
    print('\n╔════════════════════════════════════════════╗');
    print('║  Prescription Management System - Main Menu║');
    print('╠════════════════════════════════════════════╣');
    print('║  1. Create Prescription                    ║');
    print('║  2. View All Prescriptions                 ║');
    print('║  3. View Patient Prescriptions             ║');
    print('║  4. Validate Prescription                  ║');
    print('║  5. View Statistics                        ║');
    print('║  6. Export Data                            ║');
    print('║  7. Exit                                   ║');
    print('╚════════════════════════════════════════════╝');
    print('Enter your choice: ');
  }

  void createPrescription() {
    print('\n--- Create New Prescription ---');

    if (doctors.isEmpty) {
      print('✗ No doctors available. Please add a doctor first.');
      return;
    }
    if (patients.isEmpty) {
      print('✗ No patients available. Please add a patient first.');
      return;
    }
    if (medicines.isEmpty) {
      print('✗ No medicines available. Please add medicines first.');
      return;
    }

    print('Enter Prescription ID: ');
    final prescriptionId = stdin.readLineSync() ?? '';

    print('\nAvailable Doctors:');
    for (var i = 0; i < doctors.length; i++) {
      print('${i + 1}. ${doctors[i].name} (${doctors[i].specialization})');
    }
    print('Select Doctor (number): ');
    final doctorIdx = (int.tryParse(stdin.readLineSync() ?? '') ?? 1) - 1;
    if (doctorIdx < 0 || doctorIdx >= doctors.length) {
      print('✗ Invalid doctor selection.');
      return;
    }
    final doctor = doctors[doctorIdx];

    print('\nAvailable Patients:');
    for (var i = 0; i < patients.length; i++) {
      print('${i + 1}. ${patients[i].name} (Age: ${patients[i].age})');
    }
    print('Select Patient (number): ');
    final patientIdx = (int.tryParse(stdin.readLineSync() ?? '') ?? 1) - 1;
    if (patientIdx < 0 || patientIdx >= patients.length) {
      print('✗ Invalid patient selection.');
      return;
    }
    final patient = patients[patientIdx];

    print('\nAvailable Medicines:');
    for (var i = 0; i < medicines.length; i++) {
      print(
        '${i + 1}. ${medicines[i].name} (${medicines[i].getMedicineType()})',
      );
    }
    print('Enter Medicine indices to prescribe (comma-separated): ');
    final medIndicesStr = stdin.readLineSync() ?? '';
    final medIndices = medIndicesStr
        .split(',')
        .map((e) => (int.tryParse(e.trim()) ?? 1) - 1)
        .toList();

    final selectedMedicines = <Medicine>[];
    for (var idx in medIndices) {
      if (idx >= 0 && idx < medicines.length) {
        selectedMedicines.add(medicines[idx]);
      }
    }

    if (selectedMedicines.isEmpty) {
      print('✗ No valid medicines selected.');
      return;
    }

    print('Enter Notes/Instructions: ');
    final notes = stdin.readLineSync() ?? '';
    print('Enter Validity (days): ');
    final validityDays = int.tryParse(stdin.readLineSync() ?? '') ?? 30;

    try {
      final prescription = prescriptionService.createPrescription(
        prescriptionId: prescriptionId,
        doctor: doctor,
        patient: patient,
        medicines: selectedMedicines,
        notes: notes,
        validityDays: validityDays,
      );

      prescriptionRepository.addPrescription(prescription);
      print('✓ Prescription created successfully!');
      print('${prescription.getPrescriptionInfo()}');
    } catch (e) {
      print('✗ Error creating prescription: $e');
    }
  }

  void viewAllPrescriptions() {
    print('\n--- All Prescriptions ---');
    final prescriptions = prescriptionRepository.getAllPrescriptions();
    if (prescriptions.isEmpty) {
      print('No prescriptions found.');
      return;
    }
    for (var prescription in prescriptions) {
      print(
        '${prescription.prescriptionId} | ${prescription.doctor.name} → ${prescription.patient.name} | Medicines: ${prescription.medicines.length} | Status: ${prescription.status}',
      );
    }
  }

  void viewPatientPrescriptions() {
    print('\nEnter Patient ID: ');
    final patientId = stdin.readLineSync() ?? '';
    final prescriptions = prescriptionRepository.getPrescriptionsByPatientId(
      patientId,
    );

    if (prescriptions.isEmpty) {
      print('No prescriptions found for this patient.');
      return;
    }

    print('\n--- Prescriptions for Patient $patientId ---');
    for (var prescription in prescriptions) {
      print(
        '${prescription.prescriptionId} | Doctor: ${prescription.doctor.name} | Medicines: ${prescription.medicines.length} | Status: ${prescription.status}',
      );
    }
  }

  void validatePrescription() {
    print('\nEnter Prescription ID: ');
    final prescriptionId = stdin.readLineSync() ?? '';
    final prescription = prescriptionRepository.getPrescriptionById(
      prescriptionId,
    );

    if (prescription == null) {
      print(' Prescription not found.');
      return;
    }

    final isValid = prescriptionService.validatePrescription(prescription);
    if (isValid) {
      print(' Prescription is VALID');
      print(
        'Duration: ${prescriptionService.getPrescriptionDurationDays(prescription)} days',
      );
    } else {
      print(' Prescription is INVALID');
    }
  }

  void exportData() {
    print('\n--- Export Data ---');
    final jsonData = prescriptionRepository.exportAsJson();
    final file = File('hospital_data.json');
    file.writeAsStringSync(jsonData);
    print('✓ Data exported to hospital_data.json');
  }

  void run() {
    bool running = true;
    while (running) {
      displayMainMenu();
      final choice = stdin.readLineSync() ?? '';

      switch (choice) {
        case '1':
          createPrescription();
          break;
        case '2':
          viewAllPrescriptions();
          break;
        case '3':
          viewPatientPrescriptions();
          break;
        case '4':
          validatePrescription();
          break;
        case '5':
          viewStatistics();
          break;
        case '6':
          exportData();
          break;
        case '7':
          running = false;
          print('\n✓ Thank you for using Prescription Management System!');
          break;
        default:
          print('✗ Invalid choice. Please try again.');
      }
    }
  }

  void viewStatistics() {
    print('\n--- Prescription Statistics ---');
    final stats = prescriptionRepository.getStatistics();
    print('Total Prescriptions: ${stats['totalPrescriptions']}');
    print('Active Prescriptions: ${stats['activePrescriptions']}');
    print('Completed Prescriptions: ${stats['completedPrescriptions']}');
    print('Expired Prescriptions: ${stats['expiredPrescriptions']}');
    print(
        'Average Medicines per Prescription: ${stats['averageMedicinesPerPrescription']}');
  }
}
