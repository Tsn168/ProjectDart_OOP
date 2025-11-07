import 'prescription_status.dart';

/// Prescription entity
class Prescription {
  final String _id;
  final String _patientId;
  final String _doctorId;
  final String _medicationId;
  final String _dosage;
  final String _frequency;
  final DateTime _startDate;
  final int _durationDays;
  PrescriptionStatus _status;

  Prescription(
    this._id,
    this._patientId,
    this._doctorId,
    this._medicationId,
    this._dosage,
    this._frequency,
    this._startDate,
    this._durationDays,
    this._status,
  ) {
    if (_durationDays <= 0) {
      throw ArgumentError('Duration must be positive');
    }
  }

  String get id => _id;
  String get patientId => _patientId;
  String get doctorId => _doctorId;
  String get medicationId => _medicationId;
  String get dosage => _dosage;
  String get frequency => _frequency;
  DateTime get startDate => _startDate;
  int get durationDays => _durationDays;
  PrescriptionStatus get status => _status;

  /// Calculate end date
  DateTime get endDate => _startDate.add(Duration(days: _durationDays));

  /// Check if prescription is still valid
  bool get isValid {
    return _status.isActive && DateTime.now().isBefore(endDate);
  }

  /// Get days remaining
  int get daysRemaining {
    if (!isValid) return 0;
    return endDate.difference(DateTime.now()).inDays;
  }

  /// Cancel prescription
  void cancel() {
    _status = PrescriptionStatus.cancelled;
  }

  /// Complete prescription
  void complete() {
    _status = PrescriptionStatus.completed;
  }

  /// JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'patientId': _patientId,
      'doctorId': _doctorId,
      'medicationId': _medicationId,
      'dosage': _dosage,
      'frequency': _frequency,
      'startDate': _startDate.toIso8601String(),
      'durationDays': _durationDays,
      'status': _status.toJson(),
    };
  }

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      json['id'] as String,
      json['patientId'] as String,
      json['doctorId'] as String,
      json['medicationId'] as String,
      json['dosage'] as String,
      json['frequency'] as String,
      DateTime.parse(json['startDate'] as String),
      json['durationDays'] as int,
      PrescriptionStatus.fromString(json['status'] as String),
    );
  }

  @override
  String toString() =>
      'Prescription $_id - Patient: $_patientId, Status: ${_status.displayName}';
}
