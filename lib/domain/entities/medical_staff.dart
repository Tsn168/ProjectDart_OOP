import '../enums/enums.dart';
import 'entity.dart';

abstract class BaseMedicalStaff extends Entity {
  final String _id;
  final String _name;
  final StaffRole _role;

  BaseMedicalStaff({
    required String id,
    required String name,
    required StaffRole role,
  })  : _id = id,
        _name = name,
        _role = role;

  String get id => _id;
  String get name => _name;
  StaffRole get role => _role;

  String getPermission();

  @override
  String toString() => '[$_id] $_name (${_role.name})';
}

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
      'id': _id,
      'name': _name,
      'role': _role.name,
    };
  }

  @override
  String toString() => '[$_id] Dr. $_name (${_role.name})';
}

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
      'id': _id,
      'name': _name,
      'role': _role.name,
    };
  }

  @override
  String toString() => '[$_id] $_name (${_role.name})';
}

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
    return _role == StaffRole.doctor
        ? 'Can create prescriptions and view patient records'
        : 'Can administer medications and view prescriptions';
  }

  factory MedicalStaff.fromJson(Map<String, dynamic> json) {
    return MedicalStaff(
      id: json['id'] as String,
      name: json['name'] as String,
      role: StaffRole.values.firstWhere(
        (e) => e.name == json['role'],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'role': _role.name,
    };
  }

  @override
  String toString() => '[$_id] $_name (${_role.name})';
}
