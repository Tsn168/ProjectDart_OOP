import '../enums/enums.dart';
import 'entity.dart';

class Allergy extends Entity {
  final String _substance;
  final AllergySeverity _severity;

  Allergy({
    required String substance,
    required AllergySeverity severity,
  })  : _substance = substance,
        _severity = severity;
  String get substance => _substance;
  AllergySeverity get severity => _severity;
  bool get isHighSeverity => _severity == AllergySeverity.high;
  bool get isMediumSeverity => _severity == AllergySeverity.medium;
  bool get isLowSeverity => _severity == AllergySeverity.low;

  @override
  String get id => _substance;

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
      'substance': _substance,
      'severity': _severity.name,
    };
  }

  @override
  String toString() => '$_substance (${_severity.name})';
}
