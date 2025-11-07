import '../enums/staff_role.dart';

/// Entity representing medical staff (Doctor or Nurse)
class MedicalStaff {
  final String id;
  final String name;
  final StaffRole role;

  MedicalStaff({
    required this.id,
    required this.name,
    required this.role,
  });

  /// Convert from JSON
  factory MedicalStaff.fromJson(Map<String, dynamic> json) {
    return MedicalStaff(
      id: json['id'] as String,
      name: json['name'] as String,
      role: StaffRole.values.firstWhere(
        (e) => e.name == json['role'],
      ),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role.name,
    };
  }

  @override
  String toString() {
    return '[$id] $name (${role.name})';
  }
}
