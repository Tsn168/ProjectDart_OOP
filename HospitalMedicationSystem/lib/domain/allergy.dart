import 'allergy_severity.dart';

/// Allergy value object
class Allergy {
  final String _substance;
  final AllergySeverity _severity;

  Allergy(this._substance, this._severity);

  String get substance => _substance;
  AllergySeverity get severity => _severity;

  /// Check if this allergy conflicts with a medication
  bool conflictsWith(String medicationName) {
    return medicationName.toLowerCase().contains(_substance.toLowerCase());
  }

  /// JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'substance': _substance,
      'severity': _severity.toJson(),
    };
  }

  factory Allergy.fromJson(Map<String, dynamic> json) {
    return Allergy(
      json['substance'] as String,
      AllergySeverity.fromString(json['severity'] as String),
    );
  }

  @override
  String toString() => '$_substance (${_severity.displayName})';
}
