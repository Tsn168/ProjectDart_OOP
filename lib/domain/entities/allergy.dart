import '../enums/allergy_severity.dart';

class Allergy {
  final String substance;
  final AllergySeverity severity;

  Allergy({
    required this.substance,
    required this.severity,
  });

  factory Allergy.fromJson(Map<String, dynamic> json) {
    return Allergy(
      substance: json['substance'] as String,
      severity: AllergySeverity.values.firstWhere(
        (e) => e.name == json['severity'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'substance': substance,
      'severity': severity.name,
    };
  }
}
