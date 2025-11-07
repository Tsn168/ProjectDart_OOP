import 'package:test/test.dart';
import 'package:medication_manager/domain/entities/medication.dart';
import 'package:medication_manager/domain/enums/enums.dart';
import 'package:medication_manager/data/medication_repository.dart';

void main() {
  group('Medication Tests', () {
    test('Medication ID should auto-increment M001, M002, M003', () {
      var repo = MedicationRepository(testMode: true);
      var medications = repo.getAllMedications();
      
      // Check default medications have correct IDs
      expect(medications[0].id, 'M001');
      expect(medications[1].id, 'M002');
      expect(medications[2].id, 'M003');
      expect(medications[3].id, 'M004');
      
      // Create new medication and check auto-increment
      var newMed = repo.createMedication(
        'Test Medicine',
        '100mg',
        MedicationForm.tablet,
        50,
      );
      expect(newMed.id, 'M005');
    });

    test('Medication stock should decrease when administered', () {
      var medication = Medication(
        id: 'M001',
        name: 'Paracetamol',
        strength: '500mg',
        form: MedicationForm.tablet,
        stockQuantity: 100,
      );

      expect(medication.stockQuantity, 100);
      
      // Simulate administering medication
      medication.stockQuantity -= 1;
      expect(medication.stockQuantity, 99);
      
      medication.stockQuantity -= 1;
      expect(medication.stockQuantity, 98);
    });

    test('Medication should have correct form', () {
      var tablet = Medication(
        id: 'M001',
        name: 'Paracetamol',
        strength: '500mg',
        form: MedicationForm.tablet,
        stockQuantity: 100,
      );

      var liquid = Medication(
        id: 'M002',
        name: 'Cough Syrup',
        strength: '100ml',
        form: MedicationForm.liquid,
        stockQuantity: 30,
      );

      expect(tablet.form, MedicationForm.tablet);
      expect(liquid.form, MedicationForm.liquid);
    });

    test('Medication JSON serialization should work correctly', () {
      var medication = Medication(
        id: 'M003',
        name: 'Ibuprofen',
        strength: '200mg',
        form: MedicationForm.tablet,
        stockQuantity: 75,
      );

      // Convert to JSON and back
      var json = medication.toJson();
      var restored = Medication.fromJson(json);

      expect(restored.id, medication.id);
      expect(restored.name, medication.name);
      expect(restored.strength, medication.strength);
      expect(restored.form, medication.form);
      expect(restored.stockQuantity, medication.stockQuantity);
    });

    test('Repository should update stock correctly', () {
      var repo = MedicationRepository(testMode: true);
      var medication = repo.getMedicationById('M001');
      
      expect(medication, isNotNull);
      var initialStock = medication!.stockQuantity;
      
      // Update stock
      repo.updateStock('M001', initialStock - 5);
      
      var updatedMed = repo.getMedicationById('M001');
      expect(updatedMed!.stockQuantity, initialStock - 5);
    });
  });
}
