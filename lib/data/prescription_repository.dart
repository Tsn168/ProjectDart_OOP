import 'dart:convert';
import 'dart:io';
import '../domain/prescription.dart';

/// Repository for managing prescriptions with JSON persistence
class PrescriptionRepository {
  final String filePath = 'data/prescriptions.json';
  late List<Prescription> prescriptions;

  PrescriptionRepository() {
    prescriptions = [];
    _loadFromJson();
  }

  /// Load prescriptions from JSON file
  void _loadFromJson() {
    try {
      final file = File(filePath);
      if (file.existsSync()) {
        final jsonString = file.readAsStringSync();
        final jsonList = jsonDecode(jsonString) as List;
        prescriptions = jsonList.map((item) {
          return Prescription.fromMap(
            item as Map<String, dynamic>,
            medicineFactory: _medicineFactory,
          );
        }).toList();
        print('✓ Loaded ${prescriptions.length} prescriptions from file');
      } else {
        print('ℹ No existing prescriptions file. Starting fresh.');
        prescriptions = [];
      }
    } catch (e) {
      print('✗ Error loading prescriptions: $e');
      prescriptions = [];
    }
  }

  /// Save prescriptions to JSON file
  void _saveToJson() {
    try {
      final dir = Directory('data');
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }

      final file = File(filePath);
      final jsonList = prescriptions.map((p) => p.toMap()).toList();
      final jsonString = jsonEncode(jsonList);
      file.writeAsStringSync(jsonString);
      print('✓ Prescriptions saved to file');
    } catch (e) {
      print('✗ Error saving prescriptions: $e');
    }
  }

  /// Factory for deserializing medicine objects
  Map<String, dynamic> _medicineFactory(Map<String, dynamic> map) {
    return map;
  }

  /// Add a new prescription
  void addPrescription(Prescription prescription) {
    prescriptions.add(prescription);
    _saveToJson();
    print('✓ Prescription added: ${prescription.prescriptionId}');
  }

  /// Get all prescriptions
  List<Prescription> getAllPrescriptions() => prescriptions;

  /// Get prescription by ID
  Prescription? getPrescriptionById(String id) {
    try {
      return prescriptions.firstWhere((p) => p.prescriptionId == id);
    } catch (e) {
      return null;
    }
  }

  /// Search prescriptions by patient name
  List<Prescription> searchByPatientName(String name) {
    return prescriptions
        .where((p) => p.patient.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  /// Search prescriptions by doctor name
  List<Prescription> searchByDoctorName(String name) {
    return prescriptions
        .where((p) => p.doctor.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  /// Delete a prescription
  bool deletePrescription(String id) {
    final initialLength = prescriptions.length;
    prescriptions.removeWhere((p) => p.prescriptionId == id);
    if (prescriptions.length < initialLength) {
      _saveToJson();
      print('✓ Prescription deleted: $id');
      return true;
    }
    return false;
  }

  /// Get total number of prescriptions
  int getTotal() => prescriptions.length;

  /// Get expired prescriptions
  List<Prescription> getExpiredPrescriptions() {
    return prescriptions.where((p) => p.isExpired()).toList();
  }

  /// Get active prescriptions
  List<Prescription> getActivePrescriptions() {
    return prescriptions.where((p) => !p.isExpired()).toList();
  }
}
