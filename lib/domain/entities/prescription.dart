import 'entity.dart';

/// Entity representing a prescription
/// Demonstrates: Inheritance, immutability, state management
class Prescription extends Entity {
  final String id;
  final String patientId;
  final String doctorId;
  final String medicationId;
  final String dosage;
  
  /// Private state with getter - Encapsulation
  bool _isActive;

  Prescription({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.medicationId,
    required this.dosage,
    bool isActive = true,
  }) : _isActive = isActive;

  /// Getter for active status - Encapsulation
  bool get isActive => _isActive;
  
  /// Method to deactivate - Business logic encapsulated
  void deactivate() {
    _isActive = false;
  }
  
  /// Check if prescription is valid
  bool isValid() => _isActive;

  /// Factory constructor - Polymorphism
  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      doctorId: json['doctorId'] as String,
      medicationId: json['medicationId'] as String,
      dosage: json['dosage'] as String,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'medicationId': medicationId,
      'dosage': dosage,
      'isActive': _isActive,
    };
  }
}
