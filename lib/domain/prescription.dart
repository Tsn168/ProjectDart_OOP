import 'staff.dart';
import 'patient.dart';
import 'medicine.dart';

class Prescription {
  String prescriptionId;
  Staff doctor;
  Patient patient;
  List<Medicine> medicines;
  DateTime date;

  Prescription({
    required this.prescriptionId,
    required this.doctor,
    required this.patient,
    required this.medicines,
    required this.date,
  });

  void addMedicine(Medicine medicine) {
    medicines.add(medicine);
  }

  void removeMedicine(String medicineName) {
    medicines.removeWhere((m) => m.name == medicineName);
  }

  void listMedicines() {
    print("Prescription for ${patient.name} by Dr. ${doctor.name}:");
    for (var med in medicines) {
      print(
        "- ${med.name}, ${med.dosage}, ${med.frequency}, ${med.durationDays} days",
      );
    }
  }
}
