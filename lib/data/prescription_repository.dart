import 'dart:io';
import 'dart:convert';
import '../domain/entities/prescription.dart';

/// Repository for managing prescriptions with auto-incrementing IDs
class PrescriptionRepository {
  final List<Prescription> _prescriptions = [];
  final String _dataFile = 'data/prescriptions.json';
  final bool _testMode;

  PrescriptionRepository({bool testMode = false}) : _testMode = testMode {
    if (!_testMode) {
      _loadFromFile();
    }
  }

  /// Generate next auto-incrementing prescription ID (RX001, RX002, RX003...)
  String _generateNextId() {
    return 'RX${(_prescriptions.length + 1).toString().padLeft(3, '0')}';
  }

  /// Create a new prescription with auto-generated ID
  Prescription createPrescription(
    String patientId,
    String doctorId,
    String medicationId,
    String dosage,
  ) {
    final id = _generateNextId();
    final prescription = Prescription(
      id: id,
      patientId: patientId,
      doctorId: doctorId,
      medicationId: medicationId,
      dosage: dosage,
      isActive: true,
    );
    _prescriptions.add(prescription);
    _saveToFile();
    return prescription;
  }

  /// Get all prescriptions
  List<Prescription> getAllPrescriptions() {
    return List.unmodifiable(_prescriptions);
  }

  /// Get active prescriptions only
  List<Prescription> getActivePrescriptions() {
    return _prescriptions.where((p) => p.isActive).toList();
  }

  /// Get prescription by ID
  Prescription? getPrescriptionById(String id) {
    try {
      return _prescriptions.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Mark prescription as inactive (after medication is administered)
  void deactivatePrescription(String prescriptionId) {
    final prescription = getPrescriptionById(prescriptionId);
    if (prescription != null) {
      prescription.deactivate();
      _saveToFile();
    }
  }

  /// Load prescriptions from JSON file
  void _loadFromFile() {
    try {
      final file = File(_dataFile);
      if (file.existsSync()) {
        final jsonString = file.readAsStringSync();
        final List<dynamic> jsonList = json.decode(jsonString);
        _prescriptions.clear();
        _prescriptions.addAll(jsonList.map((j) => Prescription.fromJson(j)).toList());
      }
    } catch (e) {
      // Start with empty prescriptions
    }
  }

  /// Save prescriptions to JSON file
  void _saveToFile() {
    try {
      final file = File(_dataFile);
      file.createSync(recursive: true);
      final jsonString = json.encode(_prescriptions.map((p) => p.toJson()).toList());
      file.writeAsStringSync(jsonString);
    } catch (e) {
      print('Error saving prescriptions: $e');
    }
  }
}
