import 'person.dart';

/// Doctor class - Extends Person (INHERITANCE)
/// Demonstrates polymorphism through getRole()
class Doctor extends Person {
  final String _specialization;

  Doctor({
    required String id,
    required String name,
    required int age,
    required String gender,
    required String specialization,
  })  : _specialization = specialization,
        super(
          id: id,
          name: name,
          age: age,
          gender: gender,
        );

  /// Getters - Encapsulation
  String get specialization => _specialization;

  /// Polymorphic implementation
  @override
  String getRole() => 'Doctor';

  /// JSON serialization
  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'specialization': specialization,
      'type': 'Doctor',
    };
  }

  /// Factory constructor
  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'] as String,
      name: map['name'] as String,
      age: map['age'] as int,
      gender: map['gender'] as String,
      specialization: map['specialization'] as String,
    );
  }

  @override
  String toString() => 'Dr. $name ($specialization)';
}
