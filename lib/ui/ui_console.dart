import 'dart:io';
import '../domain/patient.dart';
import '../domain/staff.dart';
import '../domain/medicine.dart';
import '../domain/prescription.dart';
import '../data/prescription_repo.dart';

class ConsoleUI {
  PrescriptionRepository repository = PrescriptionRepository();

  void start() {
    print("=== Hospital Prescription System ===");

    // Sample staff and patient
    Staff doctor = Staff(
      staffId: 'D001',
      name: 'Dr. Somnang',
      role: 'Doctor',
      specialization: 'General',
      contact: '012345678',
    );

    Patient patient = Patient(
      patientId: 'P001',
      name: 'Chenda',
      age: 30,
      gender: 'Female',
      sicknessType: 'Flu',
      enterDate: DateTime.now(),
    );

    while (true) {
      print("\n1. Create Prescription");
      print("2. List Medicines in Prescription");
      print("3. Add Medicine");
      print("4. Remove Medicine");
      print("5. Show All Prescriptions for Patient");
      print("0. Exit");
      stdout.write("Choose option: ");
      String? input = stdin.readLineSync();

      switch (input) {
        case '1':
          _createPrescription(doctor, patient);
          break;
        case '2':
          _listPrescriptionMedicines(patient);
          break;
        case '3':
          _addMedicineToPrescription(patient);
          break;
        case '4':
          _removeMedicineFromPrescription(patient);
          break;
        case '5':
          _showAllPrescriptions(patient);
          break;
        case '0':
          print("Exiting...");
          return;
        default:
          print("Invalid option!");
      }
    }
  }

  void _createPrescription(Staff doctor, Patient patient) {
    Medicine med1 = Medicine(
      name: 'Paracetamol',
      dosage: '500mg',
      frequency: 'Twice a day',
      durationDays: 5,
    );

    // Create prescription
    Prescription presc = doctor.createPrescription(patient, [med1]);

    // Add prescription to patient and repository
    patient.prescriptions.add(presc);
    repository.addPrescription(presc);

    print("Prescription created successfully.");
  }

  void _listPrescriptionMedicines(Patient patient) {
    if (patient.prescriptions.isEmpty) {
      print("No prescriptions found.");
      return;
    }
    patient.prescriptions.last.listMedicines();
  }

  void _addMedicineToPrescription(Patient patient) {
    if (patient.prescriptions.isEmpty) {
      print("No prescriptions found.");
      return;
    }

    stdout.write("Medicine Name: ");
    String? name = stdin.readLineSync();
    stdout.write("Dosage: ");
    String? dosage = stdin.readLineSync();
    stdout.write("Frequency: ");
    String? freq = stdin.readLineSync();
    stdout.write("Duration (days): ");
    int? duration = int.tryParse(stdin.readLineSync() ?? "0");

    if (name != null && dosage != null && freq != null && duration != null) {
      Medicine med = Medicine(
        name: name,
        dosage: dosage,
        frequency: freq,
        durationDays: duration,
      );
      patient.prescriptions.last.addMedicine(med);
      print("Medicine added.");
    } else {
      print("Invalid input.");
    }
  }

  void _removeMedicineFromPrescription(Patient patient) {
    if (patient.prescriptions.isEmpty) {
      print("No prescriptions found.");
      return;
    }

    stdout.write("Medicine Name to remove: ");
    String? name = stdin.readLineSync();
    if (name != null) {
      patient.prescriptions.last.removeMedicine(name);
      print("Medicine removed if it existed.");
    }
  }

  void _showAllPrescriptions(Patient patient) {
    var prescs = repository.getPrescriptionsByPatientId(patient.patientId);
    if (prescs.isEmpty) {
      print("No prescriptions found.");
      return;
    }
    for (var p in prescs) {
      print("- Prescription ID: ${p.prescriptionId}, Doctor: ${p.doctor.name}");
    }
  }
}
