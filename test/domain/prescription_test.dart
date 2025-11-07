import 'package:test/test.dart';
import 'package:medication_manager/domain/entities/prescription.dart';
import 'package:medication_manager/data/prescription_repository.dart';

void main() {
  group('Prescription Tests', () {
    test('Prescription ID should auto-increment RX001, RX002, RX003', () {
      var repo = PrescriptionRepository(testMode: true);
      
      // Create prescriptions
      var rx1 = repo.createPrescription('P001', 'D001', 'M001', '1 tablet');
      var rx2 = repo.createPrescription('P002', 'D001', 'M002', '2 tablets');
      var rx3 = repo.createPrescription('P003', 'D002', 'M003', '1 spoon');
      
      expect(rx1.id, 'RX001');
      expect(rx2.id, 'RX002');
      expect(rx3.id, 'RX003');
    });

    test('New prescription should be active by default', () {
      var repo = PrescriptionRepository(testMode: true);
      var prescription = repo.createPrescription('P001', 'D001', 'M001', '1 tablet');
      
      expect(prescription.isActive, true);
    });

    test('Should deactivate prescription after administration', () {
      var repo = PrescriptionRepository(testMode: true);
      var prescription = repo.createPrescription('P001', 'D001', 'M001', '1 tablet');
      
      expect(prescription.isActive, true);
      
      repo.deactivatePrescription(prescription.id);
      var updated = repo.getPrescriptionById(prescription.id);
      
      expect(updated!.isActive, false);
    });

    test('Should filter active prescriptions correctly', () {
      var repo = PrescriptionRepository(testMode: true);
      
      var rx1 = repo.createPrescription('P001', 'D001', 'M001', '1 tablet');
      var rx2 = repo.createPrescription('P002', 'D001', 'M002', '2 tablets');
      var rx3 = repo.createPrescription('P003', 'D002', 'M003', '1 spoon');
      
      // Deactivate one
      repo.deactivatePrescription(rx2.id);
      
      var activePrescriptions = repo.getActivePrescriptions();
      expect(activePrescriptions.length, 2);
      expect(activePrescriptions.any((p) => p.id == rx1.id), true);
      expect(activePrescriptions.any((p) => p.id == rx3.id), true);
      expect(activePrescriptions.any((p) => p.id == rx2.id), false);
    });

    test('Prescription JSON serialization should work correctly', () {
      var prescription = Prescription(
        id: 'RX001',
        patientId: 'P001',
        doctorId: 'D001',
        medicationId: 'M001',
        dosage: '1 tablet',
        isActive: true,
      );

      // Convert to JSON and back
      var json = prescription.toJson();
      var restored = Prescription.fromJson(json);

      expect(restored.id, prescription.id);
      expect(restored.patientId, prescription.patientId);
      expect(restored.doctorId, prescription.doctorId);
      expect(restored.medicationId, prescription.medicationId);
      expect(restored.dosage, prescription.dosage);
      expect(restored.isActive, prescription.isActive);
    });
  });
}
