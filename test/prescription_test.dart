import 'package:test/test.dart';
import '../lib/domain/prescription.dart';
import '../lib/domain/patient.dart';
import '../lib/domain/doctor.dart';

void main() {
  group('Domain Model Tests', () {
    late Doctor testDoctor;
    late Patient testPatient;

    setUp(() {
      testDoctor = Doctor(
        id: 'D001',
        name: 'Dr. Test Smith',
        age: 40,
        gender: 'Male',
        specialization: 'General Medicine',
      );

      testPatient = Patient(
        id: 'P001',
        name: 'John Doe',
        age: 30,
        gender: 'Male',
        medicalHistory: 'Healthy',
        allergies: 'None',
      );
    });

    test('Should create a prescription with valid data', () {
      final prescription = Prescription(
        prescriptionId: 1,
        date: DateTime.now(),
        patient: testPatient,
        sicknessType: 'Common Cold',
        doctor: testDoctor,
        medicineDosage: 'Paracetamol 500mg, 3 times daily',
        advice: 'Rest and drink plenty of fluids',
      );

      expect(prescription.prescriptionId, equals(1));
      expect(prescription.patient.name, equals('John Doe'));
      expect(prescription.doctor.name, equals('Dr. Test Smith'));
      expect(prescription.sicknessType, equals('Common Cold'));
    });

    test('Patient should identify as minor correctly', () {
      final child = Patient(
        id: 'P002',
        name: 'Child Patient',
        age: 10,
        gender: 'Female',
        medicalHistory: 'N/A',
        allergies: 'None',
      );

      final adult = Patient(
        id: 'P003',
        name: 'Adult Patient',
        age: 30,
        gender: 'Male',
        medicalHistory: 'N/A',
        allergies: 'None',
      );

      expect(child.isMinor(), isTrue);
      expect(adult.isMinor(), isFalse);
    });

    test('Patient should return correct age category', () {
      final infant = Patient(
        id: 'P004',
        name: 'Baby',
        age: 1,
        gender: 'Female',
        medicalHistory: 'N/A',
        allergies: 'None',
      );

      final child = Patient(
        id: 'P005',
        name: 'Child',
        age: 10,
        gender: 'Male',
        medicalHistory: 'N/A',
        allergies: 'None',
      );

      final senior = Patient(
        id: 'P006',
        name: 'Senior',
        age: 70,
        gender: 'Male',
        medicalHistory: 'Diabetes',
        allergies: 'None',
      );

      expect(infant.getAgeCategory(), equals('Infant'));
      expect(child.getAgeCategory(), equals('Child'));
      expect(testPatient.getAgeCategory(), equals('Adult'));
      expect(senior.getAgeCategory(), equals('Senior'));
    });

    test('Doctor should return correct role', () {
      expect(testDoctor.getRole(), equals('Doctor'));
    });

    test('Patient should return correct role', () {
      expect(testPatient.getRole(), equals('Patient'));
    });

    test('Prescription should calculate days since issue correctly', () {
      final oldDate = DateTime.now().subtract(Duration(days: 100));

      final prescription = Prescription(
        prescriptionId: 1,
        date: oldDate,
        patient: testPatient,
        sicknessType: 'Test',
        doctor: testDoctor,
        medicineDosage: 'Test',
        advice: 'Test',
      );

      expect(prescription.getDaysSinceIssue(), greaterThanOrEqualTo(99));
      expect(prescription.getDaysSinceIssue(), lessThanOrEqualTo(101));
    });

    test('Prescription should correctly identify expired status', () {
      final expiredDate = DateTime.now().subtract(Duration(days: 400));
      final activeDate = DateTime.now().subtract(Duration(days: 100));

      final expiredPrescription = Prescription(
        prescriptionId: 1,
        date: expiredDate,
        patient: testPatient,
        sicknessType: 'Old illness',
        doctor: testDoctor,
        medicineDosage: 'Test',
        advice: 'Test',
      );

      final activePrescription = Prescription(
        prescriptionId: 2,
        date: activeDate,
        patient: testPatient,
        sicknessType: 'Recent illness',
        doctor: testDoctor,
        medicineDosage: 'Test',
        advice: 'Test',
      );

      expect(expiredPrescription.isExpired(), isTrue);
      expect(expiredPrescription.getStatus(), equals('EXPIRED'));
      expect(activePrescription.isExpired(), isFalse);
      expect(activePrescription.getStatus(), equals('ACTIVE'));
    });

    test('Prescription should calculate urgency level correctly', () {
      final urgentPrescription = Prescription(
        prescriptionId: 1,
        date: DateTime.now(),
        patient: testPatient,
        sicknessType: 'Emergency heart attack',
        doctor: testDoctor,
        medicineDosage: 'Test',
        advice: 'Test',
      );

      final normalPrescription = Prescription(
        prescriptionId: 2,
        date: DateTime.now(),
        patient: testPatient,
        sicknessType: 'Common cold',
        doctor: testDoctor,
        medicineDosage: 'Test',
        advice: 'Test',
      );

      expect(urgentPrescription.getUrgencyLevel(), equals(3));
      expect(urgentPrescription.getUrgencyText(), equals('HIGH'));
      expect(normalPrescription.getUrgencyLevel(), equals(1));
      expect(normalPrescription.getUrgencyText(), equals('NORMAL'));
    });

    test('Patient should check allergies correctly', () {
      final allergicPatient = Patient(
        id: 'P007',
        name: 'Allergic Patient',
        age: 25,
        gender: 'Female',
        medicalHistory: 'N/A',
        allergies: 'Penicillin, Peanuts',
      );

      expect(allergicPatient.hasAllergies(), isTrue);
      expect(allergicPatient.isAllergicTo('Penicillin'), isTrue);
      expect(allergicPatient.isAllergicTo('Aspirin'), isFalse);
      expect(testPatient.hasAllergies(), isFalse);
    });

    test('Patient should calculate risk level correctly', () {
      final highRiskPatient = Patient(
        id: 'P008',
        name: 'High Risk',
        age: 70,
        gender: 'Male',
        medicalHistory: 'Heart disease',
        allergies: 'Penicillin',
      );

      final lowRiskPatient = Patient(
        id: 'P009',
        name: 'Low Risk',
        age: 30,
        gender: 'Female',
        medicalHistory: 'Healthy',
        allergies: 'None',
      );

      expect(highRiskPatient.getRiskLevel(), equals('HIGH'));
      expect(lowRiskPatient.getRiskLevel(), equals('LOW'));
    });

    test('Doctor should identify if can treat children', () {
      final pediatricDoctor = Doctor(
        id: 'D002',
        name: 'Dr. Child Specialist',
        age: 45,
        gender: 'Female',
        specialization: 'Pediatric Medicine',
      );

      final generalDoctor = Doctor(
        id: 'D003',
        name: 'Dr. General',
        age: 50,
        gender: 'Male',
        specialization: 'General Surgery',
      );

      expect(pediatricDoctor.canTreatChildren(), isTrue);
      expect(generalDoctor.canTreatChildren(), isFalse);
    });
  });

  group('Prescription Business Logic Tests', () {
    test('Should calculate expiry date correctly', () {
      final issueDate = DateTime(2023, 6, 1);
      final prescription = Prescription(
        prescriptionId: 1,
        date: issueDate,
        patient: Patient(
          id: 'P010',
          name: 'Test',
          age: 30,
          gender: 'Male',
          medicalHistory: 'N/A',
          allergies: 'None',
        ),
        sicknessType: 'Test',
        doctor: Doctor(
          id: 'D004',
          name: 'Dr. Test',
          age: 40,
          gender: 'Male',
          specialization: 'General',
        ),
        medicineDosage: 'Test',
        advice: 'Test',
      );

      final expiryDate = prescription.getExpiryDate();
      final daysDiff = expiryDate.difference(issueDate).inDays;
      expect(daysDiff, equals(365));
    });

    test('Minor patient should have medium urgency by default', () {
      final childPatient = Patient(
        id: 'P011',
        name: 'Child',
        age: 8,
        gender: 'Female',
        medicalHistory: 'N/A',
        allergies: 'None',
      );

      final prescription = Prescription(
        prescriptionId: 1,
        date: DateTime.now(),
        patient: childPatient,
        sicknessType: 'Flu',
        doctor: Doctor(
          id: 'D005',
          name: 'Dr. Test',
          age: 40,
          gender: 'Male',
          specialization: 'General',
        ),
        medicineDosage: 'Test',
        advice: 'Test',
      );

      expect(prescription.getUrgencyLevel(), equals(2));
      expect(prescription.getUrgencyText(), equals('MEDIUM'));
    });
  });

  group('Input Validation Tests', () {
    test('Should reject negative age for Patient', () {
      expect(
        () => Patient(
          id: 'P999',
          name: 'Invalid Patient',
          age: -5,
          gender: 'Male',
          medicalHistory: 'N/A',
          allergies: 'None',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Should reject age greater than 150 for Patient', () {
      expect(
        () => Patient(
          id: 'P999',
          name: 'Invalid Patient',
          age: 200,
          gender: 'Male',
          medicalHistory: 'N/A',
          allergies: 'None',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Should reject negative age for Doctor', () {
      expect(
        () => Doctor(
          id: 'D999',
          name: 'Invalid Doctor',
          age: -10,
          gender: 'Male',
          specialization: 'General',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Should accept valid age for Patient', () {
      final patient = Patient(
        id: 'P100',
        name: 'Valid Patient',
        age: 30,
        gender: 'Male',
        medicalHistory: 'Healthy',
        allergies: 'None',
      );

      expect(patient.age, equals(30));
    });

    test('Should accept boundary age values', () {
      // Age 0 should be valid (newborn)
      final newborn = Patient(
        id: 'P101',
        name: 'Newborn',
        age: 0,
        gender: 'Female',
        medicalHistory: 'N/A',
        allergies: 'None',
      );

      // Age 150 should be valid (boundary)
      final oldest = Patient(
        id: 'P102',
        name: 'Oldest',
        age: 150,
        gender: 'Male',
        medicalHistory: 'N/A',
        allergies: 'None',
      );

      expect(newborn.age, equals(0));
      expect(oldest.age, equals(150));
    });
  });
}
