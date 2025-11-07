import 'dart:io';
import 'dart:convert';
import '../domain/entities/patient.dart';
import '../domain/entities/allergy.dart';
import '../domain/enums/allergy_severity.dart';

/// Repository for managing patients with auto-incrementing IDs
class PatientRepository {
  final List<Patient> _patients = [];
  final String _dataFile = 'data/patients.json';
  final bool _testMode;

  PatientRepository({bool testMode = false}) : _testMode = testMode {
    if (!_testMode) {
      _loadFromFile();
    } else {
      _initializeDefaultData();
    }
  }

  /// Generate next auto-incrementing patient ID (P001, P002, P003...)
  String _generateNextId() {
    return 'P${(_patients.length + 1).toString().padLeft(3, '0')}';
  }

  /// Create a new patient with auto-generated ID
  Patient createPatient(String name, List<Allergy> allergies) {
    final id = _generateNextId();
    final patient = Patient(id: id, name: name, allergies: allergies);
    _patients.add(patient);
    _saveToFile();
    return patient;
  }

  /// Get all patients
  List<Patient> getAllPatients() {
    return List.unmodifiable(_patients);
  }

  /// Get patient by ID
  Patient? getPatientById(String id) {
    try {
      return _patients.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Load patients from JSON file
  void _loadFromFile() {
    try {
      final file = File(_dataFile);
      if (file.existsSync()) {
        final jsonString = file.readAsStringSync();
        final List<dynamic> jsonList = json.decode(jsonString);
        _patients.clear();
        _patients.addAll(jsonList.map((j) => Patient.fromJson(j)).toList());
      } else {
        _initializeDefaultData();
      }
    } catch (e) {
      _initializeDefaultData();
    }
  }

  /// Save patients to JSON file
  void _saveToFile() {
    try {
      final file = File(_dataFile);
      file.createSync(recursive: true);
      final jsonString = json.encode(_patients.map((p) => p.toJson()).toList());
      file.writeAsStringSync(jsonString);
    } catch (e) {
      print('Error saving patients: $e');
    }
  }

  /// Initialize with default sample data
  void _initializeDefaultData() {
    _patients.clear();
    _patients.add(Patient(
      id: 'P001',
      name: 'John Doe',
      allergies: [Allergy(substance: 'Penicillin', severity: AllergySeverity.high)],
    ));
    _patients.add(Patient(
      id: 'P002',
      name: 'Jane Smith',
      allergies: [],
    ));
    _patients.add(Patient(
      id: 'P003',
      name: 'Bob Wilson',
      allergies: [Allergy(substance: 'Aspirin', severity: AllergySeverity.medium)],
    ));
    _saveToFile();
  }
}
