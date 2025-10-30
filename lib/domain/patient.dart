import 'prescription.dart';

class Patient {
  String patientId;
  String name;
  int age;
  String gender;
  String sicknessType;
  DateTime enterDate;
  List<Prescription> prescriptions = [];

  Patient({
    required this.patientId,
    required this.name,
    required this.age,
    required this.gender,
    required this.sicknessType,
    required this.enterDate,
  });
}
