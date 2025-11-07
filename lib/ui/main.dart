import 'dart:io';
import '../data/patient_repository.dart';
import '../data/medication_repository.dart';
import '../data/prescription_repository.dart';
import '../data/staff_repository.dart';
import '../data/safety_service.dart';
import '../domain/entities/medical_staff.dart';
import '../domain/enums/enums.dart';

void main() {
  final app = MedicationManagerApp();
  app.run();
}

class MedicationManagerApp {
  final PatientRepository patientRepo = PatientRepository();
  final MedicationRepository medicationRepo = MedicationRepository();
  final PrescriptionRepository prescriptionRepo = PrescriptionRepository();
  final StaffRepository staffRepo = StaffRepository();

  void run() {
    while (true) {
      _showMainMenu();
      final choice = _getInput('Choice: ');

      switch (choice) {
        case '1':
          _loginAsDoctor();
          break;
        case '2':
          _loginAsNurse();
          break;
        case '3':
          print('\n👋 Goodbye!');
          exit(0);
        default:
          print('\n❌ Invalid choice. Please try again.\n');
      }
    }
  }

  void _showMainMenu() {
    print('═' * 40);
    print('    MEDICATION MANAGER SYSTEM');
    print('═' * 40);
    print('1. Login as Doctor');
    print('2. Login as Nurse');
    print('3. Exit');
    print('═' * 40);
  }

  void _loginAsDoctor() {
    print('\n--- Available Doctors ---');
    final doctors = staffRepo.getDoctors();
    for (var doctor in doctors) {
      print(doctor);
    }

    final doctorId = _getInput('\nEnter Doctor ID (or 0 to cancel): ');
    if (doctorId == '0') return;

    final doctor = staffRepo.getStaffById(doctorId);
    if (doctor == null || doctor.role != StaffRole.doctor) {
      print('❌ Invalid doctor ID.\n');
      return;
    }

    _doctorMenu(doctor);
  }

  void _loginAsNurse() {
    print('\n--- Available Nurses ---');
    final nurses = staffRepo.getNurses();
    for (var nurse in nurses) {
      print(nurse);
    }

    final nurseId = _getInput('\nEnter Nurse ID (or 0 to cancel): ');
    if (nurseId == '0') return;

    final nurse = staffRepo.getStaffById(nurseId);
    if (nurse == null || nurse.role != StaffRole.nurse) {
      print('❌ Invalid nurse ID.\n');
      return;
    }

    _nurseMenu(nurse);
  }

  void _doctorMenu(BaseMedicalStaff doctor) {
    while (true) {
      print('\n${'═' * 40}');
      print('👨‍⚕️ Welcome ${doctor.name}!');
      print('═' * 40);
      print('1. View Patients & Medications');
      print('2. Create Prescription');
      print('3. Logout');
      print('═' * 40);

      final choice = _getInput('Choice: ');

      switch (choice) {
        case '1':
          _viewPatientsAndMedications();
          break;
        case '2':
          _createPrescription(doctor);
          break;
        case '3':
          print('\n👋 Logged out.\n');
          return;
        default:
          print('\n❌ Invalid choice. Please try again.');
      }
    }
  }

  void _nurseMenu(BaseMedicalStaff nurse) {
    while (true) {
      print('\n${'═' * 40}');
      print('👩‍⚕️ Welcome ${nurse.name}!');
      print('═' * 40);
      print('1. View Active Prescriptions');
      print('2. Record Medication Given');
      print('3. Logout');
      print('═' * 40);

      final choice = _getInput('Choice: ');

      switch (choice) {
        case '1':
          _viewActivePrescriptions();
          break;
        case '2':
          _recordMedicationGiven();
          break;
        case '3':
          print('\n👋 Logged out.\n');
          return;
        default:
          print('\n❌ Invalid choice. Please try again.');
      }
    }
  }

  void _viewPatientsAndMedications() {
    print('\n--- PATIENTS ---');
    final patients = patientRepo.getAllPatients();
    for (var patient in patients) {
      print(patient);
    }

    print('\n--- MEDICATIONS ---');
    final medications = medicationRepo.getAllMedications();
    for (var medication in medications) {
      print(medication);
    }
  }

  void _createPrescription(BaseMedicalStaff doctor) {
    _viewPatientsAndMedications();

    final patientId = _getInput('\nSelect Patient ID (or 0 to cancel): ');
    if (patientId == '0') return;

    final patient = patientRepo.getPatientById(patientId);
    if (patient == null) {
      print('❌ Invalid patient ID.\n');
      return;
    }

    final medicationId = _getInput('Select Medication ID (or 0 to cancel): ');
    if (medicationId == '0') return;

    final medication = medicationRepo.getMedicationById(medicationId);
    if (medication == null) {
      print('❌ Invalid medication ID.\n');
      return;
    }

    // Check for allergy conflicts
    if (SafetyService.hasAllergyConflict(patient, medication)) {
      final allergyDetails =
          SafetyService.getAllergyDetails(patient, medication);
      print('\n🛑 SAFETY ALERT: Patient allergic to $allergyDetails!');
      final confirm = _getInput('Create prescription anyway? (y/n): ');
      if (confirm.toLowerCase() != 'y') {
        print('❌ Prescription cancelled.\n');
        return;
      }
    }

    final dosage = _getInput('Enter dosage (e.g., "1 tablet", "2 spoons"): ');

    final prescription = prescriptionRepo.createPrescription(
      patient.id,
      doctor.id,
      medication.id,
      dosage,
    );

    print('\n✅ Prescription created successfully!');
    print('Prescription ID: ${prescription.id}');
    print('Patient: ${patient.name}');
    print('Medication: ${medication.name} ${medication.strength}');
    print('Dosage: $dosage\n');
  }

  void _viewActivePrescriptions() {
    print('\n--- ACTIVE PRESCRIPTIONS ---');
    final prescriptions = prescriptionRepo.getActivePrescriptions();

    if (prescriptions.isEmpty) {
      print('No active prescriptions.\n');
      return;
    }

    for (var prescription in prescriptions) {
      final patient = patientRepo.getPatientById(prescription.patientId);
      final medication =
          medicationRepo.getMedicationById(prescription.medicationId);
      final doctor = staffRepo.getStaffById(prescription.doctorId);

      print('[${prescription.id}] ${patient?.name ?? 'Unknown'} - '
          '${medication?.name ?? 'Unknown'} ${medication?.strength ?? ''} '
          '(${prescription.dosage}) - Prescribed by ${doctor?.name ?? 'Unknown'}');
    }
    print('');
  }

  void _recordMedicationGiven() {
    _viewActivePrescriptions();

    final prescriptionId =
        _getInput('Select Prescription ID (or 0 to cancel): ');
    if (prescriptionId == '0') return;

    final prescription = prescriptionRepo.getPrescriptionById(prescriptionId);
    if (prescription == null) {
      print('❌ Invalid prescription ID.\n');
      return;
    }

    if (!prescription.isActive) {
      print('❌ This prescription is already completed.\n');
      return;
    }

    final medication =
        medicationRepo.getMedicationById(prescription.medicationId);
    if (medication == null) {
      print('❌ Medication not found.\n');
      return;
    }

    // Check stock
    if (medication.stockQuantity <= 0) {
      print('❌ Insufficient stock! Cannot administer medication.\n');
      return;
    }

    // Reduce stock
    medication.stockQuantity -= 1;
    medicationRepo.updateStock(medication.id, medication.stockQuantity);

    // Deactivate prescription
    prescriptionRepo.deactivatePrescription(prescription.id);

    print('\n✅ Medication administered successfully!');
    print(
        '${medication.name} stock updated: ${medication.stockQuantity + 1} → ${medication.stockQuantity}\n');
  }

  String _getInput(String prompt) {
    stdout.write(prompt);
    return stdin.readLineSync()?.trim() ?? '';
  }
}
