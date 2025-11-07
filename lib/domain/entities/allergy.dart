import '../enums/allergy_severity.dart';
import 'entity.dart';

class Allergy extends Entity {
  final String substance;
  final AllergySeverity severity;

  Allergy({
    required this.substance,
    required this.severity,
  });

  @override
  String get id => substance;

  factory Allergy.fromJson(Map<String, dynamic> json) {
    return Allergy(
      substance: json['substance'] as String,
      severity: AllergySeverity.values.firstWhere(
        (e) => e.name == json['severity'],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'substance': substance,
      'severity': severity.name,
    };
  }
}
