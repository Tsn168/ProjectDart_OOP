/// Prescription status enumeration
enum PrescriptionStatus {
  active,
  completed,
  cancelled;

  String get displayName {
    switch (this) {
      case PrescriptionStatus.active:
        return 'Active';
      case PrescriptionStatus.completed:
        return 'Completed';
      case PrescriptionStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get indicator {
    switch (this) {
      case PrescriptionStatus.active:
        return '[ACTIVE]';
      case PrescriptionStatus.completed:
        return '[COMPLETED]';
      case PrescriptionStatus.cancelled:
        return '[CANCELLED]';
    }
  }

  bool get isActive => this == PrescriptionStatus.active;

  static PrescriptionStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'active':
        return PrescriptionStatus.active;
      case 'completed':
        return PrescriptionStatus.completed;
      case 'cancelled':
        return PrescriptionStatus.cancelled;
      default:
        throw ArgumentError('Invalid prescription status: $value');
    }
  }

  String toJson() => name;
}
