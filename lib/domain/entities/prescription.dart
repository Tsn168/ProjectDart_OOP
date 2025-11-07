/// Entity representing a prescription
class Prescription {
  final String id;
  final String patientId;
  final String doctorId;
  final String medicationId;
  final String dosage;
  bool isActive;

  Prescription({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.medicationId,
    required this.dosage,
    this.isActive = true,
  });

  /// Convert from JSON
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
      'isActive': isActive,
    };
  }
}
