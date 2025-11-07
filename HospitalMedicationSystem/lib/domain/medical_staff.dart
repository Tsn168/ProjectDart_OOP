import 'staff_role.dart';

/// Medical staff entity
class MedicalStaff {
  final String _id;
  final String _name;
  final StaffRole _role;

  MedicalStaff(this._id, this._name, this._role);

  String get id => _id;
  String get name => _name;
  StaffRole get role => _role;

  bool get isDoctor => _role == StaffRole.doctor;
  bool get isNurse => _role == StaffRole.nurse;

  /// JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'role': _role.toJson(),
    };
  }

  factory MedicalStaff.fromJson(Map<String, dynamic> json) {
    return MedicalStaff(
      json['id'] as String,
      json['name'] as String,
      StaffRole.fromString(json['role'] as String),
    );
  }

  @override
  String toString() => '$_name (${_role.displayName})';
}
