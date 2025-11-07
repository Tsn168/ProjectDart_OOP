/// Allergy severity enumeration
enum AllergySeverity {
  low,
  medium,
  high;

  String get displayName {
    switch (this) {
      case AllergySeverity.low:
        return 'Low';
      case AllergySeverity.medium:
        return 'Medium';
      case AllergySeverity.high:
        return 'High';
    }
  }

  String get indicator {
    switch (this) {
      case AllergySeverity.low:
        return '[LOW]';
      case AllergySeverity.medium:
        return '[MEDIUM]';
      case AllergySeverity.high:
        return '[HIGH RISK]';
    }
  }

  int get level {
    switch (this) {
      case AllergySeverity.low:
        return 1;
      case AllergySeverity.medium:
        return 2;
      case AllergySeverity.high:
        return 3;
    }
  }

  static AllergySeverity fromString(String value) {
    switch (value.toLowerCase()) {
      case 'low':
        return AllergySeverity.low;
      case 'medium':
        return AllergySeverity.medium;
      case 'high':
        return AllergySeverity.high;
      default:
        throw ArgumentError('Invalid allergy severity: $value');
    }
  }

  String toJson() => name;
}
