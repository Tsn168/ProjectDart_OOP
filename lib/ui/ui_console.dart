import 'dart:io';
import '../domain/doctor.dart';
import '../domain/patient.dart';
import '../domain/medicine.dart';
import '../domain/prescription_service.dart';
import '../data/prescription_repo.dart';
import '../utils/input_validator.dart';

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
    print('\n╔════════════════════════════════════════════════════╗');
    print('║   Hospital Prescription Management System v2.0    ║');
    print('║   🏥 Safe • Reliable • Patient-Centered          ║');
    print('╚════════════════════════════════════════════════════╝');
    print('');
    print('┌─────────────────────────────────────────────────┐');
    print('│  PRESCRIPTION MANAGEMENT                        │');
    print('├─────────────────────────────────────────────────┤');
    print('│  1. 📝 Create New Prescription                  │');
    print('│  2. 📋 View All Prescriptions                   │');
    print('│  3. 👤 View Patient Prescriptions               │');
    print('│  4. ✅ Validate Prescription                     │');
    print('│  5. 📊 View Statistics                          │');
    print('│  6. 💾 Export Data                              │');
    print('│  0. 🚪 Exit                                      │');
    print('└─────────────────────────────────────────────────┘');
  }

  void createPrescription() {
    print('\n╔════════════════════════════════════════════════════╗');
    print('║  📝 CREATE NEW PRESCRIPTION                        ║');
    print('╚════════════════════════════════════════════════════╝');

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

    // Generate unique prescription ID
    final prescriptionId = prescriptionRepository.generateUniquePrescriptionId();
    print('Generated Prescription ID: $prescriptionId');

    print('\n┌─────────────────────────────────────────────────┐');
    print('│  STEP 1: SELECT DOCTOR                          │');
    print('└─────────────────────────────────────────────────┘');
    print('\nAvailable Doctors:');
    for (var i = 0; i < doctors.length; i++) {
      final doc = doctors[i];
      print('  ${i + 1}. ${doc.name} (${doc.specialization})');
      print('     Experience: ${doc.yearsOfExperience} years');
      print('     Qualified: ${doc.isQualified() ? "✅ Yes" : "❌ No"}');
    }
    
    final doctorIdx = InputValidator.readIntInRange(
      '\nSelect Doctor (1-${doctors.length}): ',
      1,
      doctors.length,
    ) - 1;
    final doctor = doctors[doctorIdx];
    print('✅ Selected: ${doctor.name}');

    print('\n┌─────────────────────────────────────────────────┐');
    print('│  STEP 2: SELECT PATIENT                         │');
    print('└─────────────────────────────────────────────────┘');
    print('\nAvailable Patients:');
    for (var i = 0; i < patients.length; i++) {
      final pat = patients[i];
      print('  ${i + 1}. ${pat.name} (Age: ${pat.age}, Blood: ${pat.bloodType})');
      if (pat.allergies.isNotEmpty) {
        print('     ⚠️  Allergies: ${pat.allergies.join(", ")}');
      }
      if (pat.medicalHistory.isNotEmpty) {
        print('     📋 History: ${pat.medicalHistory}');
      }
    }
    
    final patientIdx = InputValidator.readIntInRange(
      '\nSelect Patient (1-${patients.length}): ',
      1,
      patients.length,
    ) - 1;
    final patient = patients[patientIdx];
    print('✅ Selected: ${patient.name}');

    print('\n┌─────────────────────────────────────────────────┐');
    print('│  STEP 3: SELECT MEDICINES                       │');
    print('└─────────────────────────────────────────────────┘');
    
    final selectedMedicines = <Medicine>[];
    while (true) {
      print('\nAvailable Medicines:');
      for (var i = 0; i < medicines.length; i++) {
        final med = medicines[i];
        print('  ${i + 1}. ${med.name} (${med.getMedicineType()})');
        print('     💊 Dosage: ${med.dosage}');
        print('     ⏰ Frequency: ${med.frequency}');
        print('     📅 Expires: ${med.expiryDate.toString().split(' ')[0]}');
        if (med.isExpired()) {
          print('     ❌ EXPIRED!');
        }
      }
      
      print('\nCurrently selected: ${selectedMedicines.length} medicine(s)');
      if (selectedMedicines.isNotEmpty) {
        for (var med in selectedMedicines) {
          print('  • ${med.name}');
        }
      }
      
      print('\nEnter medicine number (1-${medicines.length}, or 0 to finish): ');
      final choice = InputValidator.readIntInRange('Choice: ', 0, medicines.length);
      
      if (choice == 0) {
        if (selectedMedicines.isEmpty) {
          print('❌ You must select at least one medicine!');
          continue;
        }
        break;
      }
      
      final selectedMed = medicines[choice - 1];
      if (selectedMedicines.contains(selectedMed)) {
        print('⚠️  This medicine is already selected!');
      } else {
        selectedMedicines.add(selectedMed);
        print('✅ Added: ${selectedMed.name}');
      }
    }

    print('\n┌─────────────────────────────────────────────────┐');
    print('│  STEP 4: PRESCRIPTION DETAILS                   │');
    print('└─────────────────────────────────────────────────┘');
    
    final notes = InputValidator.readOptionalString('\nEnter Notes/Instructions (optional): ');
    final validityDays = InputValidator.readPositiveInt(
      'Enter Validity (days, default 30): ',
      min: 1,
      max: 365,
    );

    print('\n┌─────────────────────────────────────────────────┐');
    print('│  STEP 5: REVIEW & CONFIRM                       │');
    print('└─────────────────────────────────────────────────┘');
    print('\nPrescription Summary:');
    print('  ID: $prescriptionId');
    print('  Doctor: ${doctor.name}');
    print('  Patient: ${patient.name}');
    print('  Medicines: ${selectedMedicines.length}');
    print('  Validity: $validityDays days');
    
    if (!InputValidator.readConfirmation('\nCreate this prescription?')) {
      print('❌ Prescription cancelled.');
      return;
    }

    try {
      final prescription = prescriptionService.createPrescription(
        prescriptionId: prescriptionId,
        doctor: doctor,
        patient: patient,
        medicines: selectedMedicines,
        notes: notes,
        validityDays: validityDays,
      );

      if (prescription != null) {
        prescriptionRepository.addPrescription(prescription);
        print('\n✅ PRESCRIPTION CREATED SUCCESSFULLY!');
        print('${prescription.getPrescriptionInfo()}');
      } else {
        print('\n❌ Prescription creation cancelled due to safety concerns.');
      }
    } catch (e) {
      print('\n❌ Error creating prescription: $e');
    }
  }

  void viewAllPrescriptions() {
    print('\n╔════════════════════════════════════════════════════╗');
    print('║  📋 ALL PRESCRIPTIONS                              ║');
    print('╚════════════════════════════════════════════════════╝');
    
    final prescriptions = prescriptionRepository.getAllPrescriptions();
    if (prescriptions.isEmpty) {
      print('\nNo prescriptions found.');
      return;
    }
    
    print('\nTotal: ${prescriptions.length} prescription(s)\n');
    
    for (var i = 0; i < prescriptions.length; i++) {
      final prescription = prescriptions[i];
      print('┌─────────────────────────────────────────────────┐');
      print('│  Prescription #${i + 1}');
      print('├─────────────────────────────────────────────────┤');
      print('│  ID: ${prescription.prescriptionId}');
      print('│  👨‍⚕️ Doctor: ${prescription.doctor.name}');
      print('│  👤 Patient: ${prescription.patient.name}');
      print('│  📅 Issued: ${prescription.issuedDate.toString().split(' ')[0]}');
      print('│  📅 Expires: ${prescription.expiryDate.toString().split(' ')[0]}');
      print('│  Status: ${prescription.status.toUpperCase()}');
      print('│');
      print('│  💊 MEDICINES (${prescription.medicines.length}):');
      for (var med in prescription.medicines) {
        print('│    • ${med.name} (${med.getMedicineType()})');
        print('│      Dosage: ${med.dosage}');
        print('│      Frequency: ${med.frequency}');
        print('│      Instructions: ${med.instructions}');
      }
      if (prescription.notes.isNotEmpty) {
        print('│');
        print('│  📝 Notes: ${prescription.notes}');
      }
      print('└─────────────────────────────────────────────────┘');
      print('');
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
      final choice = InputValidator.readIntInRange(
        '\nEnter your choice (0-6): ',
        0,
        6,
      );

      switch (choice) {
        case 1:
          createPrescription();
          break;
        case 2:
          viewAllPrescriptions();
          break;
        case 3:
          viewPatientPrescriptions();
          break;
        case 4:
          validatePrescription();
          break;
        case 5:
          viewStatistics();
          break;
        case 6:
          exportData();
          break;
        case 0:
          running = false;
          print('\n✅ Data saved successfully!');
          print('✅ Thank you for using Hospital Prescription Management System!');
          print('👋 Goodbye!');
          break;
        default:
          print('❌ Invalid choice. Please try again.');
      }
      
      if (running) {
        print('\nPress Enter to continue...');
        stdin.readLineSync();
      }
    }
  }

  void viewStatistics() {
    print('\n╔════════════════════════════════════════════════════╗');
    print('║  📊 PRESCRIPTION STATISTICS & ANALYTICS            ║');
    print('╚════════════════════════════════════════════════════╝');
    
    final stats = prescriptionRepository.getStatistics();
    final total = stats['totalPrescriptions'] as int;
    final active = stats['activePrescriptions'] as int;
    final completed = stats['completedPrescriptions'] as int;
    final expired = stats['expiredPrescriptions'] as int;
    
    print('\n┌─────────────────────────────────────────────────┐');
    print('│  📈 OVERVIEW                                    │');
    print('├─────────────────────────────────────────────────┤');
    print('│  Total Prescriptions: $total');
    
    if (total > 0) {
      final activePercent = ((active / total) * 100).toStringAsFixed(1);
      final completedPercent = ((completed / total) * 100).toStringAsFixed(1);
      final expiredPercent = ((expired / total) * 100).toStringAsFixed(1);
      
      print('│  Active: $active ($activePercent%)');
      print('│  Completed: $completed ($completedPercent%)');
      print('│  Expired: $expired ($expiredPercent%)');
      print('│');
      print('│  Average Medicines per Prescription:');
      print('│    ${stats['averageMedicinesPerPrescription']}');
    } else {
      print('│  No prescriptions in system yet.');
    }
    
    print('└─────────────────────────────────────────────────┘');
  }
}
