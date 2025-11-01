import 'staff.dart';

/// Doctor class extending Staff (demonstrates multi-level inheritance)
class Doctor extends Staff {
  final String _specialization;
  final String _license;
  final List<String> _expertise;

  /// Constructor with all inheritance chain
  Doctor({
    required String id,
    required String name,
    required int age,
    required String email,
    required String phone,
    required String staffId,
    required String department,
    required double salary,
    required DateTime joinDate,
    required String specialization,
    required String license,
    required List<String> expertise,
  })  : _specialization = specialization,
        _license = license,
        _expertise = expertise,
        super(
          id: id,
          name: name,
          age: age,
          email: email,
          phone: phone,
          staffId: staffId,
          department: department,
          salary: salary,
          joinDate: joinDate,
        ) {
    _validateDoctor();
  }

  /// Getters for Doctor-specific attributes
  String get specialization => _specialization;
  String get license => _license;
  List<String> get expertise => List.unmodifiable(_expertise);

  /// Validation method
  void _validateDoctor() {
    if (_specialization.isEmpty) throw ArgumentError('Specialization required');
    if (_license.isEmpty) throw ArgumentError('License required');
    if (_expertise.isEmpty) throw ArgumentError('Expertise list cannot be empty');
  }

  /// Polymorphic method implementation
  @override
  String getRole() => 'Doctor';

  /// Polymorphic method implementation
  @override
  String getStaffInfo() {
    return 'Dr. $name - Specialization: $specialization, License: $license';
  }

  /// Check if doctor has specific expertise
  bool hasExpertise(String skill) {
    return _expertise.any((e) => e.toLowerCase() == skill.toLowerCase());
  }

  /// Add expertise (encapsulation - private method)
  void addExpertise(String skill) {
    if (skill.isNotEmpty && !_expertise.contains(skill)) {
      _expertise.add(skill);
    }
  }

  /// JSON Serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'email': email,
      'phone': phone,
      'staffId': staffId,
      'department': department,
      'salary': salary,
      'joinDate': joinDate.toIso8601String(),
      'specialization': specialization,
      'license': license,
      'expertise': expertise,
      'type': 'Doctor',
    };
  }

  /// Factory constructor for JSON deserialization
  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'] as String,
      name: map['name'] as String,
      age: map['age'] as int,
      email: map['email'] as String,
      phone: map['phone'] as String,
      staffId: map['staffId'] as String,
      department: map['department'] as String,
      salary: (map['salary'] as num).toDouble(),
      joinDate: DateTime.parse(map['joinDate'] as String),
      specialization: map['specialization'] as String,
      license: map['license'] as String,
      expertise: List<String>.from(map['expertise'] as List),
    );
  }

  @override
  String toString() =>
      'Doctor(ID: $id, Name: $name, Specialization: $specialization)';
}
