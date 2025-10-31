import 'package:test/test.dart';
import '../lib/domain/patient.dart';
import '../lib/domain/doctor.dart';
import '../lib/domain/nurse.dart';

void main() {
  group('Person Hierarchy Tests', () {
    test('Patient extends Person correctly', () {
      final patient = Patient(
        id: 'pat1',
        name: 'Ahmed Mohamed',
        age: 30,
        email: 'ahmed@email.com',
        phoneNumber: '+966501234567',
        address: 'Riyadh',
        medicalHistory: 'Hypertension',
        allergies: ['Penicillin'],
        bloodType: 'O+',
      );

      expect(patient.getRole(), 'Patient');
      expect(patient.name, 'Ahmed Mohamed');
      expect(patient.age, 30);
      expect(patient.medicalHistory, 'Hypertension');
      expect(patient.allergies.length, 1);
    });

    test('Doctor extends Staff and Person correctly', () {
      final doctor = Doctor(
        id: 'doc1',
        name: 'Dr. Fatima Ahmed',
        age: 45,
        email: 'fatima@email.com',
        phoneNumber: '+966501234567',
        address: 'Jeddah',
        specialization: 'Cardiology',
        isAvailable: true,
        salary: 15000.0,
        licenseNumber: 'LIC001',
        certifications: ['Board Certified', 'Advanced Cardiology'],
        yearsOfExperience: 10,
        department: 'Cardiology',
      );

      expect(doctor.getRole(), 'Doctor');
      expect(doctor.isQualified(), true);
      expect(
        doctor.getExpertise(),
        'Dr. Fatima Ahmed - Cardiology (Cardiology)',
      );
    });

    test('Nurse extends Staff and Person correctly', () {
      final nurse = Nurse(
        id: 'nurse1',
        name: 'Aisha Mohammed',
        age: 28,
        email: 'aisha@email.com',
        phoneNumber: '+966501234567',
        address: 'Medina',
        specialization: 'ICU Nursing',
        isAvailable: true,
        salary: 8000.0,
        licenseNumber: 'NURSE001',
        shiftType: 'Morning',
        certifications: ['BScN', 'ICU Certification'],
        department: 'ICU',
      );

      expect(nurse.getRole(), 'Nurse');
      expect(nurse.isCertified(), true);
      expect(nurse.isOnDuty('Morning'), true);
      expect(nurse.isOnDuty('Evening'), false);
    });
  });

  group('Doctor Qualification Tests', () {
    test(
      'Doctor with sufficient experience and certifications is qualified',
      () {
        final qualifiedDoctor = Doctor(
          id: 'doc2',
          name: 'Dr. Mohammad',
          age: 50,
          email: 'mohammad@email.com',
          phoneNumber: '+966501234567',
          address: 'Dammam',
          specialization: 'Surgery',
          isAvailable: true,
          salary: 18000.0,
          licenseNumber: 'LIC002',
          certifications: ['Board Certified Surgery'],
          yearsOfExperience: 15,
          department: 'General Surgery',
        );

        expect(qualifiedDoctor.isQualified(), true);
        expect(qualifiedDoctor.yearsOfExperience, 15);
      },
    );

    test('Doctor with insufficient experience is not qualified', () {
      final unqualifiedDoctor = Doctor(
        id: 'doc3',
        name: 'Dr. Sara',
        age: 28,
        email: 'sara@email.com',
        phoneNumber: '+966501234567',
        address: 'Riyadh',
        specialization: 'Pediatrics',
        isAvailable: true,
        salary: 10000.0,
        licenseNumber: 'LIC003',
        certifications: [],
        yearsOfExperience: 1,
        department: 'Pediatrics',
      );

      expect(unqualifiedDoctor.isQualified(), false);
    });
  });

  group('Nurse Shift Tests', () {
    test('Nurse on morning shift and available is on duty', () {
      final nurse = Nurse(
        id: 'nurse2',
        name: 'Noura Ahmed',
        age: 26,
        email: 'noura@email.com',
        phoneNumber: '+966501234567',
        address: 'Riyadh',
        specialization: 'General Nursing',
        isAvailable: true,
        salary: 7500.0,
        licenseNumber: 'NURSE002',
        shiftType: 'Morning',
        certifications: ['BScN'],
        department: 'General Ward',
      );

      expect(nurse.isOnDuty('Morning'), true);
      expect(nurse.isOnDuty('Evening'), false);
      expect(nurse.isOnDuty('Night'), false);
    });

    test('Nurse not available is not on duty', () {
      final nurse = Nurse(
        id: 'nurse3',
        name: 'Layla Hassan',
        age: 29,
        email: 'layla@email.com',
        phoneNumber: '+966501234567',
        address: 'Jeddah',
        specialization: 'Emergency Nursing',
        isAvailable: false,
        salary: 8500.0,
        licenseNumber: 'NURSE003',
        shiftType: 'Evening',
        certifications: ['BScN', 'Emergency Certification'],
        department: 'Emergency',
      );

      expect(nurse.isOnDuty('Evening'), false);
    });
  });
}
