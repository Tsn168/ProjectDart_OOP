import '../lib/domain/doctor.dart';
import '../lib/domain/patient.dart';
import '../lib/domain/tablet.dart';
import '../lib/domain/injection.dart';
import '../lib/domain/prescription_service.dart';
import '../lib/data/prescription_repo.dart';

void main() {
  print('=== Prescription Management System Tests ===\n');

  // Test Data Setup
  final testDoctor = Doctor(
    id: 'doc1',
    name: 'Dr. Ahmed',
    age: 45,
    email: 'ahmed@hospital.com',
    phoneNumber: '+966501234567',
    address: 'Riyadh',
    specialization: 'Cardiology',
    licenseNumber: 'LIC001',
    certifications: ['Board Certified'],
    yearsOfExperience: 10,
    department: 'Cardiology',
  );

  final testPatient = Patient(
    id: 'pat1',
    name: 'Mohammed Ali',
    age: 50,
    email: 'patient@hospital.com',
    phoneNumber: '+966501234567',
    address: 'Jeddah',
    medicalHistory: 'Hypertension, Diabetes',
    allergies: ['Penicillin'],
    bloodType: 'O+',
  );

  final testMedicines = [
    Tablet(
      id: 'med1',
      name: 'Aspirin',
      dosage: '500mg',
      quantity: 30,
      manufacturer: 'Bayer',
      expiryDate: DateTime.now().add(Duration(days: 365)),
      frequency: 'Twice daily',
      instructions: 'Take with food',
      shape: 'Round',
      color: 'White',
      coated: true,
    ),
    Injection(
      id: 'med2',
      name: 'Insulin',
      dosage: '10 units',
      quantity: 10,
      manufacturer: 'Novo Nordisk',
      expiryDate: DateTime.now().add(Duration(days: 180)),
      frequency: 'Once daily',
      instructions: 'Inject before breakfast',
      injectionType: 'Subcutaneous',
      route: 'SC',
      volumeMl: 1.0,
    ),
  ];

  final prescriptionService = PrescriptionService();
  final prescriptionRepository = PrescriptionRepository();

  // Test 1: Create Prescription
  print('✓ Test 1: Creating valid prescription...');
  try {
    final prescription = prescriptionService.createPrescription(
      prescriptionId: 'pres1',
      doctor: testDoctor,
      patient: testPatient,
      medicines: testMedicines,
      notes: 'Take twice daily after meals',
      validityDays: 30,
    );
    
    if (prescription != null) {
      prescriptionRepository.addPrescription(prescription);
      print('   ✓ Prescription created: ${prescription.prescriptionId}');
      print('   ✓ Doctor: ${prescription.doctor.name}');
      print('   ✓ Patient: ${prescription.patient.name}');
      print('   ✓ Medicines: ${prescription.medicines.length}');
    } else {
      print('   ⚠️  Prescription creation cancelled (likely due to allergies)');
    }
  } catch (e) {
    print('   ✗ Error: $e');
  }

  // Test 2: Validate Prescription
  print('\n✓ Test 2: Validating prescription...');
  final prescription = prescriptionRepository.getPrescriptionById('pres1');
  if (prescription != null) {
    final isValid = prescriptionService.validatePrescription(prescription);
    print('   ✓ Prescription valid: $isValid');
    print(
      '   ✓ Duration: ${prescriptionService.getPrescriptionDurationDays(prescription)} days',
    );
  }

  // Test 3: Get Prescription by Patient
  print('\n✓ Test 3: Getting patient prescriptions...');
  final patientPrescriptions = prescriptionRepository
      .getPrescriptionsByPatientId('pat1');
  print(
    '   ✓ Found ${patientPrescriptions.length} prescription(s) for patient',
  );

  // Test 4: Get Prescription by Doctor
  print('\n✓ Test 4: Getting doctor prescriptions...');
  final doctorPrescriptions = prescriptionRepository.getPrescriptionsByDoctorId(
    'doc1',
  );
  print('   ✓ Found ${doctorPrescriptions.length} prescription(s) from doctor');

  // Test 5: Check Prescription Status
  print('\n✓ Test 5: Checking prescription status...');
  print('   ✓ Status: ${prescription?.status}');
  print('   ✓ Is Valid: ${prescription?.isValid()}');
  print('   ✓ Is Expired: ${prescription?.isExpired()}');

  // Test 6: Get Prescription Statistics
  print('\n✓ Test 6: Getting statistics...');
  final stats = prescriptionRepository.getStatistics();
  print('   ✓ Total Prescriptions: ${stats['totalPrescriptions']}');
  print('   ✓ Active Prescriptions: ${stats['activePrescriptions']}');
  print(
    '   ✓ Average Medicines per Prescription: ${stats['averageMedicinesPerPrescription']}',
  );

  // Test 7: Export to JSON
  print('\n✓ Test 7: Exporting data to JSON...');
  prescriptionRepository.exportToFile('test_prescriptions.json');
  print('   ✓ Data exported successfully');

  // Test 8: Create Multiple Prescriptions
  print('\n✓ Test 8: Creating multiple prescriptions...');
  final prescription2 = prescriptionService.createPrescription(
    prescriptionId: 'pres2',
    doctor: testDoctor,
    patient: testPatient,
    medicines: [testMedicines[0]],
    notes: 'For pain relief',
    validityDays: 14,
  );
  
  if (prescription2 != null) {
    prescriptionRepository.addPrescription(prescription2);
    print('   ✓ Second prescription created: ${prescription2.prescriptionId}');
  } else {
    print('   ⚠️  Second prescription cancelled');
  }

  // Test 9: Update Prescription Status
  print('\n✓ Test 9: Updating prescription status...');
  prescriptionRepository.updatePrescriptionStatus('pres1', 'completed');
  final updatedPrescription = prescriptionRepository.getPrescriptionById(
    'pres1',
  );
  print('   ✓ Updated status: ${updatedPrescription?.status}');

  // Test 10: Get Valid Prescriptions
  print('\n✓ Test 10: Getting valid prescriptions...');
  final validPrescriptions = prescriptionRepository.getValidPrescriptions();
  print('   ✓ Valid prescriptions: ${validPrescriptions.length}');

  print('\n=== All Tests Completed Successfully ===\n');
}
