import 'dart:io';
import 'dart:convert';
import '../domain/entities/entity.dart';
import '../domain/entities/patient.dart';
import '../domain/entities/medication.dart';
import '../domain/entities/prescription.dart';
import '../domain/entities/medical_staff.dart';
import '../domain/entities/allergy.dart';
import '../domain/enums/enums.dart';

// ============================================================
// BASE REPOSITORY - Shared functionality for all repositories
// ============================================================
abstract class BaseJsonRepository<T extends Entity> {
  final List<T> items = [];
  late String dataFile;

  void loadFromFile() {
    try {
      final file = File(dataFile);
      if (file.existsSync()) {
        final jsonString = file.readAsStringSync();
        final List<dynamic> jsonList = json.decode(jsonString);
        items.clear();
        items.addAll(jsonList.map((j) => fromJson(j as Map<String, dynamic>)).toList());
      } else {
        initializeDefaultData();
      }
    } catch (e) {
      initializeDefaultData();
    }
  }

  void saveToFile() {
    try {
      final file = File(dataFile);
      file.createSync(recursive: true);
      final jsonString = json.encode(items.map((item) => item.toJson()).toList());
      file.writeAsStringSync(jsonString);
    } catch (e) {
      print('Error saving to $dataFile: $e');
    }
  }

  List<T> getAll() => List.unmodifiable(items);

  T? getById(String id) {
    try {
      return items.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  T create(T entity) {
    items.add(entity);
    saveToFile();
    return entity;
  }

  void update(T entity) {
    final index = items.indexWhere((item) => item.id == entity.id);
    if (index != -1) {
      items[index] = entity;
      saveToFile();
    }
  }

  void delete(String id) {
    items.removeWhere((item) => item.id == id);
    saveToFile();
  }

  T fromJson(Map<String, dynamic> json);
  void initializeDefaultData();
}

// ============================================================
// PATIENT REPOSITORY
// ============================================================
class PatientRepository extends BaseJsonRepository<Patient> {
  PatientRepository({bool testMode = false}) {
    dataFile = 'data/patients.json';
    if (!testMode) {
      loadFromFile();
    } else {
      initializeDefaultData();
    }
  }

  String generateNextId() {
    return 'P${(items.length + 1).toString().padLeft(3, '0')}';
  }

  Patient createPatient(String name, List<Allergy> allergies) {
    final patient = Patient(
      id: generateNextId(),
      name: name,
      allergies: allergies,
    );
    create(patient);
    return patient;
  }

  List<Patient> getAllPatients() => getAll();
  Patient? getPatientById(String id) => getById(id);

  @override
  Patient fromJson(Map<String, dynamic> json) => Patient.fromJson(json);

  @override
  void initializeDefaultData() {
    items.clear();
    items.add(Patient(
      id: 'P001',
      name: 'John Doe',
      allergies: [Allergy(substance: 'Penicillin', severity: AllergySeverity.high)],
    ));
    items.add(Patient(
      id: 'P002',
      name: 'Jane Smith',
      allergies: [],
    ));
    items.add(Patient(
      id: 'P003',
      name: 'Bob Wilson',
      allergies: [Allergy(substance: 'Aspirin', severity: AllergySeverity.medium)],
    ));
    saveToFile();
  }
}

// ============================================================
// MEDICATION REPOSITORY
// ============================================================
class MedicationRepository extends BaseJsonRepository<Medication> {
  MedicationRepository({bool testMode = false}) {
    dataFile = 'data/medications.json';
    if (!testMode) {
      loadFromFile();
    } else {
      initializeDefaultData();
    }
  }

  String generateNextId() {
    return 'M${(items.length + 1).toString().padLeft(3, '0')}';
  }

  Medication createMedication(
    String name,
    String strength,
    MedicationForm form,
    int stockQuantity,
  ) {
    final medication = Medication(
      id: generateNextId(),
      name: name,
      strength: strength,
      form: form,
      stockQuantity: stockQuantity,
    );
    create(medication);
    return medication;
  }

  List<Medication> getAllMedications() => getAll();
  Medication? getMedicationById(String id) => getById(id);

  void updateStock(String medicationId, int newStock) {
    final medication = getById(medicationId);
    if (medication != null) {
      medication.stockQuantity = newStock;
      update(medication);
    }
  }

  @override
  Medication fromJson(Map<String, dynamic> json) => Medication.fromJson(json);

  @override
  void initializeDefaultData() {
    items.clear();
    items.add(Medication(
      id: 'M001',
      name: 'Paracetamol',
      strength: '500mg',
      form: MedicationForm.tablet,
      stockQuantity: 100,
    ));
    items.add(Medication(
      id: 'M002',
      name: 'Amoxicillin',
      strength: '250mg',
      form: MedicationForm.tablet,
      stockQuantity: 50,
    ));
    items.add(Medication(
      id: 'M003',
      name: 'Ibuprofen',
      strength: '200mg',
      form: MedicationForm.tablet,
      stockQuantity: 75,
    ));
    items.add(Medication(
      id: 'M004',
      name: 'Cough Syrup',
      strength: '100ml',
      form: MedicationForm.liquid,
      stockQuantity: 30,
    ));
    saveToFile();
  }
}

// ============================================================
// PRESCRIPTION REPOSITORY
// ============================================================
class PrescriptionRepository extends BaseJsonRepository<Prescription> {
  PrescriptionRepository({bool testMode = false}) {
    dataFile = 'data/prescriptions.json';
    if (!testMode) {
      loadFromFile();
    }
  }

  String generateNextId() {
    return 'RX${(items.length + 1).toString().padLeft(3, '0')}';
  }

  Prescription createPrescription(
    String patientId,
    String doctorId,
    String medicationId,
    String dosage,
  ) {
    final prescription = Prescription(
      id: generateNextId(),
      patientId: patientId,
      doctorId: doctorId,
      medicationId: medicationId,
      dosage: dosage,
      isActive: true,
    );
    create(prescription);
    return prescription;
  }

  List<Prescription> getAllPrescriptions() => getAll();
  List<Prescription> getActivePrescriptions() => items.where((p) => p.isActive).toList();
  Prescription? getPrescriptionById(String id) => getById(id);

  void deactivatePrescription(String prescriptionId) {
    final prescription = getById(prescriptionId);
    if (prescription != null) {
      prescription.deactivate();
      update(prescription);
    }
  }

  @override
  Prescription fromJson(Map<String, dynamic> json) => Prescription.fromJson(json);

  @override
  void initializeDefaultData() {
    items.clear();
    saveToFile();
  }
}

// ============================================================
// STAFF REPOSITORY
// ============================================================
class StaffRepository extends BaseJsonRepository<MedicalStaff> {
  StaffRepository({bool testMode = false}) {
    dataFile = 'data/staff.json';
    if (!testMode) {
      loadFromFile();
    } else {
      initializeDefaultData();
    }
  }

  List<MedicalStaff> getAllStaff() => getAll();
  MedicalStaff? getStaffById(String id) => getById(id);
  List<MedicalStaff> getDoctors() => items.where((s) => s.role == StaffRole.doctor).toList();
  List<MedicalStaff> getNurses() => items.where((s) => s.role == StaffRole.nurse).toList();

  @override
  MedicalStaff fromJson(Map<String, dynamic> json) => MedicalStaff.fromJson(json);

  @override
  void initializeDefaultData() {
    items.clear();
    items.add(MedicalStaff(
      id: 'D001',
      name: 'Dr. Smith',
      role: StaffRole.doctor,
    ));
    items.add(MedicalStaff(
      id: 'D002',
      name: 'Dr. Johnson',
      role: StaffRole.doctor,
    ));
    items.add(MedicalStaff(
      id: 'N001',
      name: 'Nurse Wilson',
      role: StaffRole.nurse,
    ));
    items.add(MedicalStaff(
      id: 'N002',
      name: 'Nurse Brown',
      role: StaffRole.nurse,
    ));
    saveToFile();
  }
}

// ============================================================
// SAFETY SERVICE - Business logic for safety checks
// ============================================================
class SafetyService {
  static bool hasAllergyConflict(Patient patient, Medication medication) {
    for (var allergy in patient.allergies) {
      if (_isRelatedSubstance(medication.name, allergy.substance)) {
        return true;
      }
    }
    return false;
  }

  static AllergySeverity? getAllergyConflictSeverity(
    Patient patient,
    Medication medication,
  ) {
    for (var allergy in patient.allergies) {
      if (_isRelatedSubstance(medication.name, allergy.substance)) {
        return allergy.severity;
      }
    }
    return null;
  }

  static bool _isRelatedSubstance(String medicationName, String allergySubstance) {
    final m = medicationName.toLowerCase();
    final a = allergySubstance.toLowerCase();
    return m.contains(a) || a.contains(m);
  }

  static void displayAllergyWarning(AllergySeverity severity, String substance) {
    switch (severity) {
      case AllergySeverity.high:
        print('🛑 CRITICAL ALLERGY WARNING!');
        print('   Patient has HIGH severity allergy to $substance');
        print('   This could be life-threatening!');
        break;
      case AllergySeverity.medium:
        print('⚠️  ALLERGY WARNING!');
        print('   Patient has MEDIUM severity allergy to $substance');
        print('   Use with caution');
        break;
      case AllergySeverity.low:
        print('ℹ️  Allergy Notice:');
        print('   Patient has LOW severity allergy to $substance');
        break;
    }
  }

  static bool isHighSeverity(Patient patient, Medication medication) {
    final severity = getAllergyConflictSeverity(patient, medication);
    return severity == AllergySeverity.high;
  }

  static String? getAllergyDetails(Patient patient, Medication medication) {
    for (var allergy in patient.allergies) {
      if (_isRelatedSubstance(medication.name, allergy.substance)) {
        return '${allergy.substance} (${allergy.severity.name.toUpperCase()})';
      }
    }
    return null;
  }
}
