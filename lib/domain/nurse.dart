import 'staff.dart';

class Nurse extends Staff {
  final String licenseNumber;
  final String shiftType;
  final List<String> certifications;
  final String department;

  Nurse({
    required String id,
    required String name,
    required int age,
    required String email,
    required String phoneNumber,
    required String address,
    required String specialization,
    required bool isAvailable,
    required double salary,
    required this.licenseNumber,
    required this.shiftType,
    required this.certifications,
    required this.department,
  }) : super(
         id: id,
         name: name,
         age: age,
         email: email,
         phoneNumber: phoneNumber,
         address: address,
         specialization: specialization,
         isAvailable: isAvailable,
         salary: salary,
       );

  @override
  String getRole() => 'Nurse';

  // Check if nurse is certified
  bool isCertified() {
    return certifications.isNotEmpty;
  }

  // Get nurse assignment info
  String getAssignmentInfo() {
    return '$name - $specialization ($shiftType shift) in $department';
  }

  // Check if nurse is on duty based on shift
  bool isOnDuty(String currentShift) {
    return shiftType == currentShift && isAvailable;
  }

  Nurse copyWith({bool? isAvailable, String? shiftType, String? department}) {
    return Nurse(
      id: id,
      name: name,
      age: age,
      email: email,
      phoneNumber: phoneNumber,
      address: address,
      specialization: specialization,
      isAvailable: isAvailable ?? this.isAvailable,
      salary: salary,
      licenseNumber: licenseNumber,
      shiftType: shiftType ?? this.shiftType,
      certifications: certifications,
      department: department ?? this.department,
    );
  }

  @override
  String toString() =>
      'Nurse(id: $id, name: $name, shift: $shiftType, department: $department, isAvailable: $isAvailable, isCertified: ${isCertified()})';
}
