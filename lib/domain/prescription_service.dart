import 'dart:io';
import 'prescription.dart';
import 'doctor.dart';
import 'patient.dart';
import 'medicine.dart';

class PrescriptionService {
  // Check for patient allergies against medicines
  List<String> checkPatientAllergies(Patient patient, List<Medicine> medicines) {
    List<String> allergyWarnings = [];
    
    for (var medicine in medicines) {
      for (var allergy in patient.allergies) {
        // Check if medicine name contains the allergy (case-insensitive)
        if (medicine.name.toLowerCase().contains(allergy.toLowerCase())) {
          allergyWarnings.add(
            '⚠️ ALLERGY WARNING: Patient is allergic to $allergy. Medicine: ${medicine.name}'
          );
        }
      }
    }
    
    return allergyWarnings;
  }

  // Create a new prescription with allergy checking
  Prescription? createPrescription({
    required String prescriptionId,
    required Doctor doctor,
    required Patient patient,
    required List<Medicine> medicines,
    required String notes,
    required int validityDays,
  }) {
    if (medicines.isEmpty) {
      throw Exception('Prescription must contain at least one medicine');
    }

    if (!doctor.isQualified()) {
      throw Exception('Doctor is not qualified to issue prescriptions');
    }

    // CRITICAL: Check for allergies
    List<String> allergyWarnings = checkPatientAllergies(patient, medicines);
    
    if (allergyWarnings.isNotEmpty) {
      print('\n╔════════════════════════════════════════════════════╗');
      print('║  ⚠️  ALLERGY WARNING!                              ║');
      print('╚════════════════════════════════════════════════════╝');
      print('Patient: ${patient.name}');
      print('Allergies: ${patient.allergies.join(", ")}');
      print('');
      
      for (var warning in allergyWarnings) {
        print(warning);
      }
      
      print('\n⚠️  Prescribing these medicines may cause allergic reactions!');
      print('This action will be LOGGED for audit purposes.');
      
      stdout.write('\nDo you want to continue with this prescription? (yes/no): ');
      String? response = stdin.readLineSync()?.trim().toLowerCase();
      
      if (response != 'yes' && response != 'y') {
        print('✅ Prescription cancelled. Patient safety maintained.');
        return null;
      }
      
      print('⚠️  Allergy override logged. Prescription created with warnings.');
    }

    return Prescription(
      prescriptionId: prescriptionId,
      doctor: doctor,
      patient: patient,
      medicines: medicines,
      issuedDate: DateTime.now(),
      expiryDate: DateTime.now().add(Duration(days: validityDays)),
      notes: notes,
      status: 'active',
    );
  }

  // Validate prescription
  bool validatePrescription(Prescription prescription) {
    if (prescription.medicines.isEmpty) return false;
    if (prescription.doctor.id.isEmpty) return false;
    if (prescription.patient.id.isEmpty) return false;

    // Check if any medicine is expired
    for (var medicine in prescription.medicines) {
      if (medicine.isExpired()) return false;
    }

    return prescription.isValid();
  }

  // Check for medicine allergies
  bool checkMedicineAllergies(Prescription prescription) {
    // Simple check - you can expand this with a medicine-allergy database
    return true;
  }

  // Get prescription duration in days
  int getPrescriptionDurationDays(Prescription prescription) {
    return prescription.expiryDate.difference(prescription.issuedDate).inDays;
  }
}
