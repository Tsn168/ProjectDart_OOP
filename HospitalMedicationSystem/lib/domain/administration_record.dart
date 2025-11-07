import 'administration_status.dart';

/// Administration record entity
class AdministrationRecord {
  final String _id;
  final String _prescriptionId;
  final String _nurseId;
  final DateTime _scheduledTime;
  DateTime? _administeredAt;
  AdministrationStatus _status;
  String? _notes;

  AdministrationRecord(
    this._id,
    this._prescriptionId,
    this._nurseId,
    this._scheduledTime,
    this._status, {
    DateTime? administeredAt,
    String? notes,
  })  : _administeredAt = administeredAt,
        _notes = notes;

  String get id => _id;
  String get prescriptionId => _prescriptionId;
  String get nurseId => _nurseId;
  DateTime get scheduledTime => _scheduledTime;
  DateTime? get administeredAt => _administeredAt;
  AdministrationStatus get status => _status;
  String? get notes => _notes;

  /// Check if administration is overdue
  bool get isOverdue {
    return _status == AdministrationStatus.pending &&
        DateTime.now().isAfter(_scheduledTime);
  }

  /// Mark as administered
  void markAsAdministered({String? notes}) {
    if (_status != AdministrationStatus.pending) {
      throw StateError('Can only administer pending records');
    }
    _status = AdministrationStatus.administered;
    _administeredAt = DateTime.now();
    _notes = notes;
  }

  /// Mark as missed
  void markAsMissed({String? notes}) {
    if (_status != AdministrationStatus.pending) {
      throw StateError('Can only mark pending records as missed');
    }
    _status = AdministrationStatus.missed;
    _notes = notes;
  }

  /// Cancel administration
  void cancel({String? notes}) {
    _status = AdministrationStatus.cancelled;
    _notes = notes;
  }

  /// JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'prescriptionId': _prescriptionId,
      'nurseId': _nurseId,
      'scheduledTime': _scheduledTime.toIso8601String(),
      'administeredAt': _administeredAt?.toIso8601String(),
      'status': _status.toJson(),
      'notes': _notes,
    };
  }

  factory AdministrationRecord.fromJson(Map<String, dynamic> json) {
    return AdministrationRecord(
      json['id'] as String,
      json['prescriptionId'] as String,
      json['nurseId'] as String,
      DateTime.parse(json['scheduledTime'] as String),
      AdministrationStatus.fromString(json['status'] as String),
      administeredAt: json['administeredAt'] != null
          ? DateTime.parse(json['administeredAt'] as String)
          : null,
      notes: json['notes'] as String?,
    );
  }

  @override
  String toString() =>
      'Administration $_id - ${_status.displayName} - Scheduled: $_scheduledTime';
}
