import 'package:test/test.dart';
import '../lib/domain/patient.dart';
import '../lib/domain/doctor.dart';

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
        licenseNumber: 'LIC003',
        certifications: [],
        yearsOfExperience: 1,
        department: 'Pediatrics',
      );

      expect(unqualifiedDoctor.isQualified(), false);
    });
  });
}

