import 'allergy.dart';
import 'entity.dart';

/// Entity representing a patient
/// Demonstrates: Inheritance, encapsulation of allergies
class Patient extends Entity {
  final String id;
  final String name;
  
  /// Private variable with getter - Encapsulation
  final List<Allergy> _allergies;

  Patient({
    required this.id,
    required this.name,
    required List<Allergy> allergies,
  }) : _allergies = List.unmodifiable(allergies); // Immutable list

  /// Getter for allergies - Encapsulation
  List<Allergy> get allergies => _allergies;
  
  /// Check if patient has any allergies - Business logic encapsulated
  bool hasAllergies() => _allergies.isNotEmpty;
  
  /// Get allergy details as string - Encapsulation
  String getAllergyInfo() {
    if (_allergies.isEmpty) return 'No allergies';
    return _allergies.map((a) => '${a.substance}-${a.severity.name}').join(', ');
  }

  /// Factory constructor - Polymorphism
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      name: json['name'] as String,
      allergies: (json['allergies'] as List<dynamic>)
          .map((a) => Allergy.fromJson(a as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'allergies': _allergies.map((a) => a.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return '[$id] $name (Allergies: ${getAllergyInfo()})';
  }
}
