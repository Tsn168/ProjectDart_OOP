import 'doctor.dart';
import 'patient.dart';

/// Prescription class - Stores prescription details
class Prescription {
  late int _prescriptionId; // Auto-increment
  late DateTime _date;
  late Patient _patient;
  late String _sicknessType;
  late Doctor _doctor;
  late String _medicineDosage;
  late String _advice;

  Prescription({
    int? prescriptionId,
    required DateTime date,
    required Patient patient,
    required String sicknessType,
    required Doctor doctor,
    required String medicineDosage,
    required String advice,
  }) {
    _prescriptionId = prescriptionId ?? 0;
    _date = date;
    _patient = patient;
    _sicknessType = sicknessType;
    _doctor = doctor;
    _medicineDosage = medicineDosage;
    _advice = advice;
  }

  /// Getters - Encapsulation
  int get prescriptionId => _prescriptionId;
  DateTime get date => _date;
  Patient get patient => _patient;
  String get sicknessType => _sicknessType;
  Doctor get doctor => _doctor;
  String get medicineDosage => _medicineDosage;
  String get advice => _advice;

  /// Setters for editing
  set patient(Patient value) => _patient = value;
  set sicknessType(String value) => _sicknessType = value;
  set doctor(Doctor value) => _doctor = value;
  set medicineDosage(String value) => _medicineDosage = value;
  set advice(String value) => _advice = value;

  /// Display prescription info
  String displayInfo() {
    return '''
╔═══════════════════════════════════════════════════╗
║          PRESCRIPTION #$_prescriptionId
╠═══════════════════════════════════════════════════╣
║ Status: ${getStatus()} | Urgency: ${getUrgencyText()}
║ Date: ${_date.toString().split('.')[0]}
║ Days Since Issue: ${getDaysSinceIssue()} | Days Until Expiry: ${getDaysUntilExpiry()}
╠═══════════════════════════════════════════════════╣
║ Patient: ${_patient.name} | Age: ${_patient.age} (${_patient.getAgeCategory()})
║ Gender: ${_patient.gender} | Risk Level: ${_patient.getRiskLevel()}
║ Medical History: ${_patient.medicalHistory}
║ Allergies: ${_patient.allergies}
╠═══════════════════════════════════════════════════╣
║ Sickness: $_sicknessType
║ Doctor: ${_doctor.name} (${_doctor.specialization})
║ Medicine Dosage: $_medicineDosage
║ Advice: $_advice
╚═══════════════════════════════════════════════════╝
    ''';
  }

  /// JSON Serialization
  Map<String, dynamic> toMap() {
    return {
      'prescriptionId': prescriptionId,
      'date': date.toIso8601String(),
      'patient': patient.toMap(),
      'sicknessType': sicknessType,
      'doctor': doctor.toMap(),
      'medicineDosage': medicineDosage,
      'advice': advice,
    };
  }

  /// Factory constructor
  factory Prescription.fromMap(Map<String, dynamic> map) {
    return Prescription(
      prescriptionId: map['prescriptionId'] as int,
      date: DateTime.parse(map['date'] as String),
      patient: Patient.fromMap(map['patient'] as Map<String, dynamic>),
      sicknessType: map['sicknessType'] as String,
      doctor: Doctor.fromMap(map['doctor'] as Map<String, dynamic>),
      medicineDosage: map['medicineDosage'] as String,
      advice: map['advice'] as String,
    );
  }

  @override
  String toString() =>
      'Prescription(ID: $prescriptionId, Patient: ${patient.name}, Doctor: ${doctor.name})';

  // ========================================
  // ALGORITHMS AND COMPUTED DATA
  // ========================================

  /// Algorithm: Calculate days since prescription was issued
  int getDaysSinceIssue() {
    return DateTime.now().difference(_date).inDays;
  }

  /// Algorithm: Check if prescription is expired (>365 days)
  bool isExpired() {
    return getDaysSinceIssue() > 365;
  }

  /// Algorithm: Calculate expiry date (1 year from issue)
  DateTime getExpiryDate() {
    return _date.add(Duration(days: 365));
  }

  /// Algorithm: Get days remaining until expiry
  int getDaysUntilExpiry() {
    if (isExpired()) return 0;
    return getExpiryDate().difference(DateTime.now()).inDays;
  }

  /// Algorithm: Get prescription status
  String getStatus() {
    if (isExpired()) return 'EXPIRED';
    if (getDaysUntilExpiry() < 30) return 'EXPIRING SOON';
    return 'ACTIVE';
  }

  /// Algorithm: Calculate urgency level based on sickness type
  int getUrgencyLevel() {
    final urgentKeywords = [
      'emergency',
      'urgent',
      'critical',
      'severe',
      'acute',
      'high fever',
      'heart',
      'stroke'
    ];

    for (var keyword in urgentKeywords) {
      if (_sicknessType.toLowerCase().contains(keyword)) {
        return 3; // High urgency
      }
    }

    if (_patient.isMinor()) return 2; // Medium for children
    return 1; // Normal
  }

  /// Computed: Get urgency as text
  String getUrgencyText() {
    switch (getUrgencyLevel()) {
      case 3:
        return 'HIGH';
      case 2:
        return 'MEDIUM';
      default:
        return 'NORMAL';
    }
  }

  /// Algorithm: Check if doctor and patient match (pediatric check)
  bool isDoctorPatientMatch() {
    if (_patient.isMinor() && !_doctor.canTreatChildren()) {
      return false; // Child needs pediatric doctor
    }
    return true;
  }
}
