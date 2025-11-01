import 'person.dart';

/// Patient class extending Person (demonstrates inheritance)
class Patient extends Person {
  final String _patientId;
  final String _bloodType;
  final List<String> _medicalHistory;
  final List<String> _allergies;

  /// Constructor with inheritance
  Patient({
    required String id,
    required String name,
    required int age,
    required String email,
    required String phone,
    required String patientId,
    required String bloodType,
    required List<String> medicalHistory,
    required List<String> allergies,
  })  : _patientId = patientId,
        _bloodType = bloodType,
        _medicalHistory = medicalHistory,
        _allergies = allergies,
        super(id: id, name: name, age: age, email: email, phone: phone) {
    _validatePatient();
  }

  /// Getters for Patient attributes (encapsulation)
  String get patientId => _patientId;
  String get bloodType => _bloodType;
  List<String> get medicalHistory => List.unmodifiable(_medicalHistory);
  List<String> get allergies => List.unmodifiable(_allergies);

  /// Validation method
  void _validatePatient() {
    const validBloodTypes = ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'];
    if (!validBloodTypes.contains(_bloodType)) {
      throw ArgumentError('Invalid blood type');
    }
  }

  /// Polymorphic method implementation
  @override
  String getRole() => 'Patient';

  /// Add to medical history
  void addMedicalHistory(String condition) {
    if (condition.isNotEmpty && !_medicalHistory.contains(condition)) {
      _medicalHistory.add(condition);
    }
  }

  /// Add allergy
  void addAllergy(String allergy) {
    if (allergy.isNotEmpty && !_allergies.contains(allergy)) {
      _allergies.add(allergy);
    }
  }

  /// Check if patient has allergy
  bool hasAllergy(String allergy) {
    return _allergies.any((a) => a.toLowerCase() == allergy.toLowerCase());
  }

  /// JSON Serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'email': email,
      'phone': phone,
      'patientId': patientId,
      'bloodType': bloodType,
      'medicalHistory': medicalHistory,
      'allergies': allergies,
      'type': 'Patient',
    };
  }

  /// Factory constructor for JSON deserialization
  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'] as String,
      name: map['name'] as String,
      age: map['age'] as int,
      email: map['email'] as String,
      phone: map['phone'] as String,
      patientId: map['patientId'] as String,
      bloodType: map['bloodType'] as String,
      medicalHistory: List<String>.from(map['medicalHistory'] as List),
      allergies: List<String>.from(map['allergies'] as List),
    );
  }

  @override
  String toString() => 'Patient(ID: $id, Name: $name, BloodType: $bloodType)';
}
