import 'doctor.dart';
import 'patient.dart';
import 'medicine.dart';

/// Prescription class (composition pattern)
/// Represents a medical prescription issued by a doctor to a patient
class Prescription {
  final String _prescriptionId;
  final Doctor _doctor;
  final Patient _patient;
  final List<Medicine> _medicines;
  final String _diagnosis;
  final DateTime _issuedDate;
  final DateTime? _expiryDate;
  final String _notes;

  /// Constructor
  Prescription({
    required String prescriptionId,
    required Doctor doctor,
    required Patient patient,
    required List<Medicine> medicines,
    required String diagnosis,
    required DateTime issuedDate,
    required DateTime? expiryDate,
    required String notes,
  })  : _prescriptionId = prescriptionId,
        _doctor = doctor,
        _patient = patient,
        _medicines = medicines,
        _diagnosis = diagnosis,
        _issuedDate = issuedDate,
        _expiryDate = expiryDate,
        _notes = notes {
    _validatePrescription();
  }

  /// Getters (encapsulation)
  String get prescriptionId => _prescriptionId;
  Doctor get doctor => _doctor;
  Patient get patient => _patient;
  List<Medicine> get medicines => List.unmodifiable(_medicines);
  String get diagnosis => _diagnosis;
  DateTime get issuedDate => _issuedDate;
  DateTime? get expiryDate => _expiryDate;
  String get notes => _notes;

  /// Validation
  void _validatePrescription() {
    if (_prescriptionId.isEmpty)
      throw ArgumentError('Prescription ID required');
    if (_medicines.isEmpty)
      throw ArgumentError('Prescription must have at least one medicine');
    if (_diagnosis.isEmpty) throw ArgumentError('Diagnosis required');
  }

  /// Check if prescription is expired
  bool isExpired() {
    final expiry = _expiryDate;
    if (expiry == null) return false;
    return DateTime.now().isAfter(expiry);
  }

  /// Get total prescription cost
  double getTotalCost() {
    return _medicines.fold(0.0, (sum, medicine) => sum + medicine.price);
  }

  /// Get medicines count
  int getMedicinesCount() {
    return _medicines.length;
  }

  /// Display prescription information
  String displayInfo() {
    final status = isExpired() ? 'EXPIRED' : 'ACTIVE';
    return '''
    ╔════════════════════════════════════════════╗
    ║           PRESCRIPTION #$_prescriptionId
    ╠════════════════════════════════════════════╣
    ║ Status: $status
    ║ Doctor: ${_doctor.name} (${_doctor.specialization})
    ║ Patient: ${_patient.name} | Age: ${_patient.age}
    ║ Blood Type: ${_patient.bloodType}
    ║ Diagnosis: $_diagnosis
    ║ Issued Date: ${_issuedDate.toLocal().toString().split('.')[0]}
    ║ Expiry Date: ${_expiryDate?.toLocal().toString().split('.')[0] ?? 'No expiry'}
    ║ Medicines: ${_medicines.length}
    ║ Total Cost: \$${getTotalCost().toStringAsFixed(2)}
    ║ Notes: $_notes
    ╚════════════════════════════════════════════╝
    ''';
  }

  /// JSON Serialization
  Map<String, dynamic> toMap() {
    return {
      'prescriptionId': prescriptionId,
      'doctor': doctor.toMap(),
      'patient': patient.toMap(),
      'medicines': medicines.map((m) => m.toMap()).toList(),
      'diagnosis': diagnosis,
      'issuedDate': issuedDate.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'notes': notes,
    };
  }

  /// Factory constructor - requires medicine factory mapping
  factory Prescription.fromMap(
    Map<String, dynamic> map, {
    required Map<String, dynamic> Function(Map<String, dynamic>)
        medicineFactory,
  }) {
    return Prescription(
      prescriptionId: map['prescriptionId'] as String,
      doctor: Doctor.fromMap(map['doctor'] as Map<String, dynamic>),
      patient: Patient.fromMap(map['patient'] as Map<String, dynamic>),
      medicines: (map['medicines'] as List)
          .map((m) => medicineFactory(m as Map<String, dynamic>))
          .cast<Medicine>()
          .toList(),
      diagnosis: map['diagnosis'] as String,
      issuedDate: DateTime.parse(map['issuedDate'] as String),
      expiryDate: map['expiryDate'] != null
          ? DateTime.parse(map['expiryDate'] as String)
          : null,
      notes: map['notes'] as String? ?? '',
    );
  }

  @override
  String toString() =>
      'Prescription(ID: $prescriptionId, Doctor: ${doctor.name}, Patient: ${patient.name})';
}
