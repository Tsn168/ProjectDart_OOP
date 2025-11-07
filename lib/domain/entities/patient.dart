import 'allergy.dart';
import 'entity.dart';

class Patient extends Entity {
  final String id;
  final String name;

  final List<Allergy> _allergies;

  Patient({
    required this.id,
    required this.name,
    required List<Allergy> allergies,
  }) : _allergies = List.unmodifiable(allergies); // Immutable list

  List<Allergy> get allergies => _allergies;

  bool hasAllergies() => _allergies.isNotEmpty;

  String getAllergyInfo() {
    if (_allergies.isEmpty) return 'No allergies';
    return _allergies
        .map((a) => '${a.substance}-${a.severity.name}')
        .join(', ');
  }

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
