import 'dart:convert';
import 'dart:io';
import '../domain/prescription.dart';

/// Repository for managing prescriptions with auto-increment ID
class PrescriptionRepository {
  final String filePath = 'data/prescriptions.json';
  late List<Prescription> prescriptions;
  late int _nextId;

  PrescriptionRepository() {
    prescriptions = [];
    _nextId = 1;
    _loadFromJson();
  }

  /// Get next prescription ID (auto-increment)
  int getNextId() {
    return _nextId++;
  }

  /// Load prescriptions from JSON
  void _loadFromJson() {
    try {
      final file = File(filePath);
      if (file.existsSync()) {
        final jsonString = file.readAsStringSync();
        final jsonList = jsonDecode(jsonString) as List;
        prescriptions = jsonList.map((item) {
          return Prescription.fromMap(item as Map<String, dynamic>);
        }).toList();

        // Find max ID to continue auto-increment
        if (prescriptions.isNotEmpty) {
          _nextId = prescriptions
                  .map((p) => p.prescriptionId)
                  .reduce((a, b) => a > b ? a : b) +
              1;
        }
        print('[OK] Loaded ${prescriptions.length} prescriptions from file');
      } else {
        print('[INFO] No existing prescriptions file. Starting fresh.');
        prescriptions = [];
        _nextId = 1;
      }
    } catch (e) {
      print('[ERROR] Error loading prescriptions: $e');
      prescriptions = [];
      _nextId = 1;
    }
  }

  /// Save prescriptions to JSON
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
      print('[OK] Prescriptions saved to file');
    } catch (e) {
      print('[ERROR] Error saving prescriptions: $e');
    }
  }

  /// Add new prescription
  void addPrescription(Prescription prescription) {
    prescriptions.add(prescription);
    _saveToJson();
    print('[OK] Prescription #${prescription.prescriptionId} added');
  }

  /// Get all prescriptions
  List<Prescription> getAllPrescriptions() => prescriptions;

  /// Get prescription by ID
  Prescription? getPrescriptionById(int id) {
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

  /// Delete prescription by ID
  bool deletePrescriptionById(int id) {
    final initialLength = prescriptions.length;
    prescriptions.removeWhere((p) => p.prescriptionId == id);
    if (prescriptions.length < initialLength) {
      _saveToJson();
      print('[OK] Prescription #$id deleted');
      return true;
    }
    return false;
  }

  /// Delete prescriptions by patient name
  int deleteByPatientName(String name) {
    final initialLength = prescriptions.length;
    prescriptions
        .removeWhere((p) => p.patient.name.toLowerCase() == name.toLowerCase());
    final deleted = initialLength - prescriptions.length;
    if (deleted > 0) {
      _saveToJson();
      print('[OK] $deleted prescription(s) deleted for patient: $name');
    }
    return deleted;
  }

  /// Update prescription
  bool updatePrescription(int id, Prescription updatedData) {
    try {
      final index = prescriptions.indexWhere((p) => p.prescriptionId == id);
      if (index != -1) {
        prescriptions[index] = updatedData;
        _saveToJson();
        print('[OK] Prescription #$id updated');
        return true;
      }
      return false;
    } catch (e) {
      print('[ERROR] Error updating prescription: $e');
      return false;
    }
  }

  /// Get total number of prescriptions
  int getTotal() => prescriptions.length;
}
