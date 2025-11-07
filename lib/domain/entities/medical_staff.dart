import '../enums/staff_role.dart';
import 'entity.dart';

/// Entity representing medical staff (Doctor or Nurse)
import '../enums/staff_role.dart';
import 'entity.dart';

/// Base class for medical staff - Demonstrates: Inheritance
abstract class BaseMedicalStaff extends Entity {
  final String id;
  final String name;
  final StaffRole role;

  BaseMedicalStaff({
    required this.id,
    required this.name,
    required this.role,
  });

  /// Abstract method - Polymorphism
  String getPermission();
}

/// Concrete implementation of Doctor - Demonstrates: Inheritance
class Doctor extends BaseMedicalStaff {
  Doctor({
    required String id,
    required String name,
  }) : super(
    id: id,
    name: name,
    role: StaffRole.doctor,
  );

  @override
  String getPermission() => 'Can create prescriptions and view patient records';

  /// Factory constructor - Polymorphism
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  /// Convert to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role.name,
    };
  }

  @override
  String toString() => '[$id] Dr. $name (${role.name})';
}

/// Concrete implementation of Nurse - Demonstrates: Inheritance
class Nurse extends BaseMedicalStaff {
  Nurse({
    required String id,
    required String name,
  }) : super(
    id: id,
    name: name,
    role: StaffRole.nurse,
  );

  @override
  String getPermission() => 'Can administer medications and view prescriptions';

  /// Factory constructor - Polymorphism
  factory Nurse.fromJson(Map<String, dynamic> json) {
    return Nurse(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  /// Convert to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role.name,
    };
  }

  @override
  String toString() => '[$id] $name (${role.name})';
}

/// Legacy class for backward compatibility
class MedicalStaff extends BaseMedicalStaff {
  MedicalStaff({
    required String id,
    required String name,
    required StaffRole role,
  }) : super(
    id: id,
    name: name,
    role: role,
  );

  @override
  String getPermission() {
    return role == StaffRole.doctor
        ? 'Can create prescriptions'
        : 'Can administer medications';
  }

  /// Factory constructor - Polymorphism
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

/// Concrete implementation of Doctor - Demonstrates: Inheritance
class Doctor extends BaseMedicalStaff {
  Doctor({
    required String id,
    required String name,
  }) : super(
          id: id,
          name: name,
          role: StaffRole.doctor,
        );

  @override
  String getPermission() => 'Can create prescriptions and view patient records';

  /// Factory constructor - Polymorphism
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  /// Convert to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role.name,
    };
  }

  @override
  String toString() => '[$id] Dr. $name (${role.name})';
}

/// Concrete implementation of Nurse - Demonstrates: Inheritance
class Nurse extends BaseMedicalStaff {
  Nurse({
    required String id,
    required String name,
  }) : super(
          id: id,
          name: name,
          role: StaffRole.nurse,
        );

  @override
  String getPermission() => 'Can administer medications and view prescriptions';

  /// Factory constructor - Polymorphism
  factory Nurse.fromJson(Map<String, dynamic> json) {
    return Nurse(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  /// Convert to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role.name,
    };
  }

  @override
  String toString() => '[$id] $name (${role.name})';
}

/// Legacy class for backward compatibility
class MedicalStaff extends BaseMedicalStaff {
  MedicalStaff({
    required String id,
    required String name,
    required StaffRole role,
  }) : super(
          id: id,
          name: name,
          role: role,
        );

  @override
  String getPermission() {
    return role == StaffRole.doctor
        ? 'Can create prescriptions'
        : 'Can administer medications';
  }

  /// Factory constructor - Polymorphism
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
