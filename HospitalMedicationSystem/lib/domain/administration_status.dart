/// Administration status enumeration
enum AdministrationStatus {
  pending,
  administered,
  missed,
  cancelled;

  String get displayName {
    switch (this) {
      case AdministrationStatus.pending:
        return 'Pending';
      case AdministrationStatus.administered:
        return 'Administered';
      case AdministrationStatus.missed:
        return 'Missed';
      case AdministrationStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get indicator {
    switch (this) {
      case AdministrationStatus.pending:
        return '[PENDING]';
      case AdministrationStatus.administered:
        return '[DONE]';
      case AdministrationStatus.missed:
        return '[MISSED]';
      case AdministrationStatus.cancelled:
        return '[CANCELLED]';
    }
  }

  static AdministrationStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'pending':
        return AdministrationStatus.pending;
      case 'administered':
        return AdministrationStatus.administered;
      case 'missed':
        return AdministrationStatus.missed;
      case 'cancelled':
        return AdministrationStatus.cancelled;
      default:
        throw ArgumentError('Invalid administration status: $value');
    }
  }

  String toJson() => name;
}
