/// Staff role enumeration
enum StaffRole {
  doctor,
  nurse;

  String get displayName {
    switch (this) {
      case StaffRole.doctor:
        return 'Doctor';
      case StaffRole.nurse:
        return 'Nurse';
    }
  }

  static StaffRole fromString(String value) {
    switch (value.toLowerCase()) {
      case 'doctor':
        return StaffRole.doctor;
      case 'nurse':
        return StaffRole.nurse;
      default:
        throw ArgumentError('Invalid staff role: $value');
    }
  }

  String toJson() => name;
}
