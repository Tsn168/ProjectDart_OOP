import 'package:test/test.dart';
import 'package:medication_manager/domain/entities/patient.dart';
import 'package:medication_manager/domain/entities/medication.dart';
import 'package:medication_manager/domain/entities/allergy.dart';
import 'package:medication_manager/domain/enums/enums.dart';
import 'package:medication_manager/data/safety_service.dart';

void main() {
  group('Safety Service Tests', () {
    test('Should detect high severity allergy conflict', () {
      var patient = Patient(
        id: 'P001',
        name: 'John Doe',
        allergies: [
          Allergy(substance: 'Penicillin', severity: AllergySeverity.high),
        ],
      );

      var medication = Medication(
        id: 'M001',
        name: 'Penicillin',
        strength: '250mg',
        form: MedicationForm.tablet,
        stockQuantity: 50,
      );

      expect(SafetyService.hasAllergyConflict(patient, medication), true);
      expect(SafetyService.isHighSeverity(patient, medication), true);
    });

    test('Should detect medium severity allergy conflict', () {
      var patient = Patient(
        id: 'P002',
        name: 'Jane Smith',
        allergies: [
          Allergy(substance: 'Aspirin', severity: AllergySeverity.medium),
        ],
      );

      var medication = Medication(
        id: 'M002',
        name: 'Aspirin',
        strength: '100mg',
        form: MedicationForm.tablet,
        stockQuantity: 100,
      );

      expect(SafetyService.hasAllergyConflict(patient, medication), true);
      expect(SafetyService.isHighSeverity(patient, medication), false);
    });

    test('Should not detect conflict when no allergy exists', () {
      var patient = Patient(
        id: 'P003',
        name: 'Bob Wilson',
        allergies: [],
      );

      var medication = Medication(
        id: 'M003',
        name: 'Paracetamol',
        strength: '500mg',
        form: MedicationForm.tablet,
        stockQuantity: 100,
      );

      expect(SafetyService.hasAllergyConflict(patient, medication), false);
      expect(SafetyService.isHighSeverity(patient, medication), false);
    });

    test('Should not detect conflict when medication is different', () {
      var patient = Patient(
        id: 'P004',
        name: 'Alice Brown',
        allergies: [
          Allergy(substance: 'Penicillin', severity: AllergySeverity.high),
        ],
      );

      var medication = Medication(
        id: 'M004',
        name: 'Paracetamol',
        strength: '500mg',
        form: MedicationForm.tablet,
        stockQuantity: 100,
      );

      expect(SafetyService.hasAllergyConflict(patient, medication), false);
    });

    test('Should return correct allergy details when conflict exists', () {
      var patient = Patient(
        id: 'P005',
        name: 'Charlie Green',
        allergies: [
          Allergy(substance: 'Ibuprofen', severity: AllergySeverity.low),
        ],
      );

      var medication = Medication(
        id: 'M005',
        name: 'Ibuprofen',
        strength: '200mg',
        form: MedicationForm.tablet,
        stockQuantity: 75,
      );

      var details = SafetyService.getAllergyDetails(patient, medication);
      expect(details, isNotNull);
      expect(details, contains('Ibuprofen'));
      expect(details, contains('LOW'));
    });

    test('Should return null when no conflict exists', () {
      var patient = Patient(
        id: 'P006',
        name: 'Diana White',
        allergies: [],
      );

      var medication = Medication(
        id: 'M006',
        name: 'Paracetamol',
        strength: '500mg',
        form: MedicationForm.tablet,
        stockQuantity: 100,
      );

      var details = SafetyService.getAllergyDetails(patient, medication);
      expect(details, isNull);
    });
  });
}
