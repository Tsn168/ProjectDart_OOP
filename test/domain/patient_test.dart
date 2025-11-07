import 'package:test/test.dart';
import 'package:medication_manager/domain/entities/patient.dart';
import 'package:medication_manager/domain/entities/allergy.dart';
import 'package:medication_manager/domain/enums/enums.dart';
import 'package:medication_manager/data/patient_repository.dart';

void main() {
  group('Patient Tests', () {
    test('Patient ID should auto-increment P001, P002, P003', () {
      var repo = PatientRepository(testMode: true);
      var patients = repo.getAllPatients();
      
      // Check default patients have correct IDs
      expect(patients[0].id, 'P001');
      expect(patients[1].id, 'P002');
      expect(patients[2].id, 'P003');
      
      // Create new patient and check auto-increment
      var newPatient = repo.createPatient('Test Patient', []);
      expect(newPatient.id, 'P004');
    });

    test('Patient should store allergies correctly', () {
      var allergy = Allergy(
        substance: 'Penicillin',
        severity: AllergySeverity.high,
      );
      
      var patient = Patient(
        id: 'P001',
        name: 'John Doe',
        allergies: [allergy],
      );

      expect(patient.allergies.length, 1);
      expect(patient.allergies[0].substance, 'Penicillin');
      expect(patient.allergies[0].severity, AllergySeverity.high);
    });

    test('Patient with no allergies should have empty list', () {
      var patient = Patient(
        id: 'P002',
        name: 'Jane Smith',
        allergies: [],
      );

      expect(patient.allergies.isEmpty, true);
    });

    test('Patient JSON serialization should work correctly', () {
      var allergy = Allergy(
        substance: 'Aspirin',
        severity: AllergySeverity.medium,
      );
      
      var patient = Patient(
        id: 'P003',
        name: 'Bob Wilson',
        allergies: [allergy],
      );

      // Convert to JSON and back
      var json = patient.toJson();
      var restored = Patient.fromJson(json);

      expect(restored.id, patient.id);
      expect(restored.name, patient.name);
      expect(restored.allergies.length, 1);
      expect(restored.allergies[0].substance, 'Aspirin');
      expect(restored.allergies[0].severity, AllergySeverity.medium);
    });
  });
}
