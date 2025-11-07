import '../enums/allergy_severity.dart';

/// Entity representing an allergy
class Allergy {
  final String substance;
  final AllergySeverity severity;

  Allergy({
    required this.substance,
    required this.severity,
  });

  /// Convert from JSON
  factory Allergy.fromJson(Map<String, dynamic> json) {
    return Allergy(
      substance: json['substance'] as String,
      severity: AllergySeverity.values.firstWhere(
        (e) => e.name == json['severity'],
      ),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'substance': substance,
      'severity': severity.name,
    };
  }
}
