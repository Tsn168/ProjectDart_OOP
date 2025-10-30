import '../domain/prescription.dart';

class PrescriptionRepository {
  List<Prescription> _prescriptions = [];

  // Add a prescription
  void addPrescription(Prescription prescription) {
    _prescriptions.add(prescription);
  }

  // Get all prescriptions for a specific patient
  List<Prescription> getPrescriptionsByPatientId(String patientId) {
    return _prescriptions
        .where((p) => p.patient.patientId == patientId)
        .toList();
  }

  // Get all prescriptions
  List<Prescription> getAllPrescriptions() => _prescriptions;
}
