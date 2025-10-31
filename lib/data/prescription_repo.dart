import 'dart:convert';
import 'dart:io';
import '../domain/prescription.dart';
import '../domain/doctor.dart';
import '../domain/patient.dart';

class PrescriptionRepository {
  List<Prescription> _prescriptions = [];
  final String _filePath = 'prescriptions.json';

  // Initialize repository and load from JSON
  void initialize() {
    _loadFromJson();
  }

  // Add a prescription
  void addPrescription(Prescription prescription) {
    _prescriptions.add(prescription);
    _saveToJson();
    print('✓ Prescription added to repository');
  }

  // Get all prescriptions for a specific patient
  List<Prescription> getPrescriptionsByPatientId(String patientId) {
    return _prescriptions.where((p) => p.patient.id == patientId).toList();
  }

  // Get all prescriptions for a specific doctor
  List<Prescription> getPrescriptionsByDoctorId(String doctorId) {
    return _prescriptions.where((p) => p.doctor.id == doctorId).toList();
  }

  // Get all prescriptions
  List<Prescription> getAllPrescriptions() => _prescriptions;

  // Get valid prescriptions only (not expired, status is active)
  List<Prescription> getValidPrescriptions() {
    return _prescriptions.where((p) => p.isValid()).toList();
  }

  // Get prescription by ID
  Prescription? getPrescriptionById(String prescriptionId) {
    try {
      return _prescriptions.firstWhere(
        (p) => p.prescriptionId == prescriptionId,
      );
    } catch (e) {
      return null;
    }
  }

  // Update prescription status (active, completed, expired, cancelled)
  bool updatePrescriptionStatus(String prescriptionId, String newStatus) {
    try {
      final index = _prescriptions.indexWhere(
        (p) => p.prescriptionId == prescriptionId,
      );
      if (index != -1) {
        final oldPrescription = _prescriptions[index];
        _prescriptions[index] = Prescription(
          prescriptionId: oldPrescription.prescriptionId,
          doctor: oldPrescription.doctor,
          patient: oldPrescription.patient,
          medicines: oldPrescription.medicines,
          issuedDate: oldPrescription.issuedDate,
          expiryDate: oldPrescription.expiryDate,
          notes: oldPrescription.notes,
          status: newStatus,
        );
        _saveToJson();
        print('✓ Prescription status updated to $newStatus');
        return true;
      }
      print('✗ Prescription not found');
      return false;
    } catch (e) {
      print('✗ Error updating prescription: $e');
      return false;
    }
  }

  // Delete prescription
  bool deletePrescription(String prescriptionId) {
    try {
      final initialLength = _prescriptions.length;
      _prescriptions.removeWhere((p) => p.prescriptionId == prescriptionId);
      if (_prescriptions.length < initialLength) {
        _saveToJson();
        print('✓ Prescription deleted');
        return true;
      }
      print('✗ Prescription not found');
      return false;
    } catch (e) {
      print('✗ Error deleting prescription: $e');
      return false;
    }
  }

  // Get prescription count
  int getPrescriptionCount() => _prescriptions.length;

  // Get active prescriptions count
  int getActivePrescriptionCount() {
    return _prescriptions
        .where((p) => p.status == 'active' && !p.isExpired())
        .length;
  }

  // Get expired prescriptions
  List<Prescription> getExpiredPrescriptions() {
    return _prescriptions.where((p) => p.isExpired()).toList();
  }

  // Get prescriptions by status
  List<Prescription> getPrescriptionsByStatus(String status) {
    return _prescriptions.where((p) => p.status == status).toList();
  }

  // Save to JSON file
  void _saveToJson() {
    try {
      final file = File(_filePath);
      final jsonList = _prescriptions.map((p) => p.toMap()).toList();
      final jsonString = jsonEncode(jsonList);
      file.writeAsStringSync(jsonString);
      print('✓ Prescriptions saved to JSON');
    } catch (e) {
      print('✗ Error saving prescriptions to JSON: $e');
    }
  }

  // Load from JSON file
  void _loadFromJson() {
    try {
      final file = File(_filePath);
      if (file.existsSync()) {
        final jsonString = file.readAsStringSync();
        final jsonList = jsonDecode(jsonString) as List;
        print('✓ Loaded ${jsonList.length} prescriptions from JSON');
      } else {
        print('ℹ No existing JSON file found. Starting with empty repository.');
      }
    } catch (e) {
      print('✗ Error loading prescriptions from JSON: $e');
    }
  }

  // Export all prescriptions as JSON string
  String exportAsJson() {
    try {
      final jsonList = _prescriptions.map((p) => p.toMap()).toList();
      return jsonEncode(jsonList);
    } catch (e) {
      print('✗ Error exporting prescriptions: $e');
      return '[]';
    }
  }

  // Export prescriptions to file with custom path
  bool exportToFile(String filePath) {
    try {
      final file = File(filePath);
      final jsonList = _prescriptions.map((p) => p.toMap()).toList();
      final jsonString = jsonEncode(jsonList);
      file.writeAsStringSync(jsonString);
      print('✓ Prescriptions exported to $filePath');
      return true;
    } catch (e) {
      print('✗ Error exporting prescriptions to file: $e');
      return false;
    }
  }

  // Clear all prescriptions
  void clearAll() {
    _prescriptions.clear();
    _saveToJson();
    print('✓ All prescriptions cleared');
  }

  // Search prescriptions by patient name
  List<Prescription> searchByPatientName(String patientName) {
    return _prescriptions
        .where(
          (p) =>
              p.patient.name.toLowerCase().contains(patientName.toLowerCase()),
        )
        .toList();
  }

  // Search prescriptions by doctor name
  List<Prescription> searchByDoctorName(String doctorName) {
    return _prescriptions
        .where(
          (p) => p.doctor.name.toLowerCase().contains(doctorName.toLowerCase()),
        )
        .toList();
  }

  // Get prescription statistics
  Map<String, dynamic> getStatistics() {
    return {
      'totalPrescriptions': _prescriptions.length,
      'activePrescriptions': _prescriptions
          .where((p) => p.status == 'active')
          .length,
      'completedPrescriptions': _prescriptions
          .where((p) => p.status == 'completed')
          .length,
      'expiredPrescriptions': _prescriptions.where((p) => p.isExpired()).length,
      'averageMedicinesPerPrescription': _prescriptions.isEmpty
          ? 0
          : (_prescriptions.fold<int>(0, (sum, p) => sum + p.medicines.length) /
                    _prescriptions.length)
                .toStringAsFixed(2),
    };
  }

  // Get file path
  String getFilePath() => _filePath;

  // Check if file exists
  bool fileExists() => File(_filePath).existsSync();

  // Get file size in bytes
  int getFileSize() {
    try {
      final file = File(_filePath);
      if (file.existsSync()) {
        return file.lengthSync();
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }
}
