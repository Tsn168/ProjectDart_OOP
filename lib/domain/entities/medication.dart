import '../enums/medication_form.dart';

/// Entity representing a medication
class Medication {
  final String id;
  final String name;
  final String strength;
  final MedicationForm form;
  int stockQuantity;

  Medication({
    required this.id,
    required this.name,
    required this.strength,
    required this.form,
    required this.stockQuantity,
  });

  /// Convert from JSON
  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'] as String,
      name: json['name'] as String,
      strength: json['strength'] as String,
      form: MedicationForm.values.firstWhere(
        (e) => e.name == json['form'],
      ),
      stockQuantity: json['stockQuantity'] as int,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'strength': strength,
      'form': form.name,
      'stockQuantity': stockQuantity,
    };
  }

  @override
  String toString() {
    return '[$id] $name $strength (${form.name}) - Stock: $stockQuantity';
  }
}
