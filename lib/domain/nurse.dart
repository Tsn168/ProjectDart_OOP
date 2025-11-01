import 'staff.dart';

/// Nurse class extending Staff (demonstrates multi-level inheritance)
class Nurse extends Staff {
  final String _certification;
  final String _shift; // Morning, Afternoon, Night
  final List<String> _skills;

  /// Constructor with all inheritance chain
  Nurse({
    required String id,
    required String name,
    required int age,
    required String email,
    required String phone,
    required String staffId,
    required String department,
    required double salary,
    required DateTime joinDate,
    required String certification,
    required String shift,
    required List<String> skills,
  })  : _certification = certification,
        _shift = shift,
        _skills = skills,
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
    _validateNurse();
  }

  /// Getters for Nurse-specific attributes
  String get certification => _certification;
  String get shift => _shift;
  List<String> get skills => List.unmodifiable(_skills);

  /// Validation method
  void _validateNurse() {
    if (_certification.isEmpty) throw ArgumentError('Certification required');
    if (!['Morning', 'Afternoon', 'Night'].contains(_shift)) {
      throw ArgumentError('Invalid shift');
    }
    if (_skills.isEmpty) throw ArgumentError('Skills list cannot be empty');
  }

  /// Polymorphic method implementation
  @override
  String getRole() => 'Nurse';

  /// Polymorphic method implementation
  @override
  String getStaffInfo() {
    return '$name - Certification: $certification, Shift: $shift';
  }

  /// Check if nurse has specific skill
  bool hasSkill(String skill) {
    return _skills.any((s) => s.toLowerCase() == skill.toLowerCase());
  }

  /// Add skill (encapsulation)
  void addSkill(String skill) {
    if (skill.isNotEmpty && !_skills.contains(skill)) {
      _skills.add(skill);
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
      'certification': certification,
      'shift': shift,
      'skills': skills,
      'type': 'Nurse',
    };
  }

  /// Factory constructor for JSON deserialization
  factory Nurse.fromMap(Map<String, dynamic> map) {
    return Nurse(
      id: map['id'] as String,
      name: map['name'] as String,
      age: map['age'] as int,
      email: map['email'] as String,
      phone: map['phone'] as String,
      staffId: map['staffId'] as String,
      department: map['department'] as String,
      salary: (map['salary'] as num).toDouble(),
      joinDate: DateTime.parse(map['joinDate'] as String),
      certification: map['certification'] as String,
      shift: map['shift'] as String,
      skills: List<String>.from(map['skills'] as List),
    );
  }

  @override
  String toString() => 'Nurse(ID: $id, Name: $name, Shift: $shift)';
}
