import 'dart:io';
import 'dart:convert';
import '../domain/entities/medication.dart';
import '../domain/enums/enums.dart';

/// Repository for managing medications with auto-incrementing IDs
class MedicationRepository {
  final List<Medication> _medications = [];
  final String _dataFile = 'data/medications.json';
  final bool _testMode;

  MedicationRepository({bool testMode = false}) : _testMode = testMode {
    if (!_testMode) {
      _loadFromFile();
    } else {
      _initializeDefaultData();
    }
  }

  /// Generate next auto-incrementing medication ID (M001, M002, M003...)
  String _generateNextId() {
    return 'M${(_medications.length + 1).toString().padLeft(3, '0')}';
  }

  /// Create a new medication with auto-generated ID
  Medication createMedication(
    String name,
    String strength,
    MedicationForm form,
    int stockQuantity,
  ) {
    final id = _generateNextId();
    final medication = Medication(
      id: id,
      name: name,
      strength: strength,
      form: form,
      stockQuantity: stockQuantity,
    );
    _medications.add(medication);
    _saveToFile();
    return medication;
  }

  /// Get all medications
  List<Medication> getAllMedications() {
    return List.unmodifiable(_medications);
  }

  /// Get medication by ID
  Medication? getMedicationById(String id) {
    try {
      return _medications.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Update medication stock (called when medication is administered)
  void updateStock(String medicationId, int newStock) {
    final medication = getMedicationById(medicationId);
    if (medication != null) {
      medication.stockQuantity = newStock;
      _saveToFile();
    }
  }

  /// Load medications from JSON file
  void _loadFromFile() {
    try {
      final file = File(_dataFile);
      if (file.existsSync()) {
        final jsonString = file.readAsStringSync();
        final List<dynamic> jsonList = json.decode(jsonString);
        _medications.clear();
        _medications
            .addAll(jsonList.map((j) => Medication.fromJson(j)).toList());
      } else {
        _initializeDefaultData();
      }
    } catch (e) {
      _initializeDefaultData();
    }
  }

  void _saveToFile() {
    try {
      final file = File(_dataFile);
      file.createSync(recursive: true);
      final jsonString =
          json.encode(_medications.map((m) => m.toJson()).toList());
      file.writeAsStringSync(jsonString);
    } catch (e) {
      print('Error saving medications: $e');
    }
  }

  void _initializeDefaultData() {
    _medications.clear();
    _medications.add(Medication(
      id: 'M001',
      name: 'Paracetamol',
      strength: '500mg',
      form: MedicationForm.tablet,
      stockQuantity: 100,
    ));
    _medications.add(Medication(
      id: 'M002',
      name: 'Amoxicillin',
      strength: '250mg',
      form: MedicationForm.tablet,
      stockQuantity: 50,
    ));
    _medications.add(Medication(
      id: 'M003',
      name: 'Ibuprofen',
      strength: '200mg',
      form: MedicationForm.tablet,
      stockQuantity: 75,
    ));
    _medications.add(Medication(
      id: 'M004',
      name: 'Cough Syrup',
      strength: '100ml',
      form: MedicationForm.liquid,
      stockQuantity: 30,
    ));
    _saveToFile();
  }
}
