import 'prescription.dart';
import 'doctor.dart';
import 'patient.dart';
import 'medicine.dart';

class PrescriptionService {
  // Create a new prescription
  Prescription createPrescription({
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
