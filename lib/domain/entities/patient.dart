import 'allergy.dart';

/// Entity representing a patient
class Patient {
  final String id;
  final String name;
  final List<Allergy> allergies;

  Patient({
    required this.id,
    required this.name,
    required this.allergies,
  });

  /// Convert from JSON
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
      'allergies': allergies.map((a) => a.toJson()).toList(),
    };
  }

  @override
  String toString() {
    String allergyInfo = allergies.isEmpty 
        ? 'No allergies' 
        : allergies.map((a) => '${a.substance}-${a.severity.name}').join(', ');
    return '[$id] $name (Allergies: $allergyInfo)';
  }
}
