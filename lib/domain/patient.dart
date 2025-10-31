import 'person.dart';

class Patient extends Person {
  final String medicalHistory;
  final String? assignedRoomId;
  final List<String> allergies;
  final String bloodType;

  Patient({
    required String id,
    required String name,
    required int age,
    required String email,
    required String phoneNumber,
    required String address,
    required this.medicalHistory,
    this.assignedRoomId,
    required this.allergies,
    required this.bloodType,
  }) : super(
         id: id,
         name: name,
         age: age,
         email: email,
         phoneNumber: phoneNumber,
         address: address,
       );

  @override
  String getRole() => 'Patient';

  Patient copyWith({
    String? assignedRoomId,
    String? medicalHistory,
    List<String>? allergies,
  }) {
    return Patient(
      id: id,
      name: name,
      age: age,
      email: email,
      phoneNumber: phoneNumber,
      address: address,
      medicalHistory: medicalHistory ?? this.medicalHistory,
      assignedRoomId: assignedRoomId ?? this.assignedRoomId,
      allergies: allergies ?? this.allergies,
      bloodType: bloodType,
    );
  }

  @override
  String toString() =>
      'Patient(id: $id, name: $name, age: $age, bloodType: $bloodType, assignedRoomId: $assignedRoomId)';
}
