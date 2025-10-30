import 'medicine.dart';
import 'prescription.dart';
import 'patient.dart';

class Staff {
  String staffId;
  String name;
  String role; // Doctor
  String specialization;
  String contact;

  Staff({
    required this.staffId,
    required this.name,
    required this.role,
    required this.specialization,
    required this.contact,
  });

  Prescription createPrescription(Patient patient, List<Medicine> medicines) {
    Prescription presc = Prescription(
      prescriptionId: DateTime.now().millisecondsSinceEpoch.toString(),
      doctor: this,
      patient: patient,
      medicines: medicines,
      date: DateTime.now(),
    );
    return presc;
  }
}
