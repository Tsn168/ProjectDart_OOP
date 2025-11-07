import 'allergy.dart';

/// Patient entity
class Patient {
  final String _id;
  final String _name;
  final DateTime _dateOfBirth;
  final List<Allergy> _allergies;

  Patient(this._id, this._name, this._dateOfBirth, this._allergies);

  String get id => _id;
  String get name => _name;
  DateTime get dateOfBirth => _dateOfBirth;
  List<Allergy> get allergies => List.unmodifiable(_allergies);

  /// Calculate patient age
  int get age {
    final now = DateTime.now();
    int age = now.year - _dateOfBirth.year;
    if (now.month < _dateOfBirth.month ||
        (now.month == _dateOfBirth.month && now.day < _dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  /// Check if patient has any allergies
  bool get hasAllergies => _allergies.isNotEmpty;

  /// Check if patient is allergic to specific substance
  bool isAllergicTo(String substance) {
    return _allergies.any((allergy) => 
      allergy.substance.toLowerCase() == substance.toLowerCase()
    );
  }

  /// Get allergy by substance
  Allergy? getAllergy(String substance) {
    try {
      return _allergies.firstWhere((allergy) =>
        allergy.substance.toLowerCase() == substance.toLowerCase()
      );
    } catch (e) {
      return null;
    }
  }

  /// JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'dateOfBirth': _dateOfBirth.toIso8601String(),
      'allergies': _allergies.map((a) => a.toJson()).toList(),
    };
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      json['id'] as String,
      json['name'] as String,
      DateTime.parse(json['dateOfBirth'] as String),
      (json['allergies'] as List)
          .map((a) => Allergy.fromJson(a as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() => '$_name (Age: $age, ID: $_id)';
}
