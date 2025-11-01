import 'person.dart';

class Doctor extends Person {
  final String specialization;
  final String licenseNumber;
  final List<String> certifications;
  final int yearsOfExperience;
  final String department;

  Doctor({
    required String id,
    required String name,
    required int age,
    required String email,
    required String phoneNumber,
    required String address,
    required this.specialization,
    required this.licenseNumber,
    required this.certifications,
    required this.yearsOfExperience,
    required this.department,
  }) : super(
        id: id,
        name: name,
        age: age,
        email: email,
        phoneNumber: phoneNumber,
        address: address,
      );

  @override
  String getRole() => 'Doctor';

  // Check if doctor is qualified
  bool isQualified() {
    return yearsOfExperience >= 2 && certifications.isNotEmpty;
  }

  // Get doctor expertise
  String getExpertise() {
    return 'Dr. $name - $specialization ($department)';
  }

  Doctor copyWith({
    String? department,
    int? yearsOfExperience,
  }) {
    return Doctor(
      id: id,
      name: name,
      age: age,
      email: email,
      phoneNumber: phoneNumber,
      address: address,
      specialization: specialization,
      licenseNumber: licenseNumber,
      certifications: certifications,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      department: department ?? this.department,
    );
  }

  @override
  String toString() =>
      'Doctor(id: $id, name: $name, specialization: $specialization, department: $department, experience: $yearsOfExperience years, qualified: ${isQualified()})';
}
