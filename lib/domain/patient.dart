import 'person.dart';

/// Patient class - Extends Person with medical information
class Patient extends Person {
  final String _medicalHistory;
  final String _allergies;

  Patient({
    required String id,
    required String name,
    required int age,
    required String gender,
    required String medicalHistory,
    required String allergies,
  })  : _medicalHistory = medicalHistory,
        _allergies = allergies,
        super(id: id, name: name, age: age, gender: gender);

  /// Getters - Encapsulation
  String get medicalHistory => _medicalHistory;
  String get allergies => _allergies;

  /// Polymorphism - Override abstract method from Person
  @override
  String getRole() => 'Patient';

  /// JSON Serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'medicalHistory': medicalHistory,
      'allergies': allergies,
      'role': 'Patient',
    };
  }

  /// Factory constructor
  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'] as String,
      name: map['name'] as String,
      age: map['age'] as int,
      gender: map['gender'] as String,
      medicalHistory: map['medicalHistory'] as String? ?? '',
      allergies: map['allergies'] as String? ?? '',
    );
  }

  @override
  String toString() =>
      'Patient(ID: $id, Name: $name, Medical History: $medicalHistory)';
}
