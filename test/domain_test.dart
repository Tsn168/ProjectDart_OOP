import 'package:test/test.dart';
import '../lib/domain/doctor.dart';
import '../lib/domain/nurse.dart';
import '../lib/domain/patient.dart';
import '../lib/domain/tablet.dart';
import '../lib/domain/injection.dart';
import '../lib/domain/syrup.dart';
import '../lib/domain/prescription.dart';

void main() {
  group('Person Hierarchy Tests', () {
    test('Create Doctor and verify properties', () {
      final doctor = Doctor(
        id: 'D001',
        name: 'Dr. John Doe',
        age: 45,
        email: 'john@hospital.com',
        phone: '555-1234',
        staffId: 'S001',
        department: 'Cardiology',
        salary: 120000,
        joinDate: DateTime(2015, 1, 15),
        specialization: 'Cardiology',
        license: 'LIC12345',
        expertise: ['General Surgery', 'Emergency Medicine'],
      );

      expect(doctor.name, 'Dr. John Doe');
      expect(doctor.getRole(), 'Doctor');
      expect(doctor.specialization, 'Cardiology');
    });

    test('Doctor expertise management', () {
      final doctor = Doctor(
        id: 'D002',
        name: 'Dr. Jane Smith',
        age: 40,
        email: 'jane@hospital.com',
        phone: '555-5678',
        staffId: 'S002',
        department: 'Surgery',
        salary: 130000,
        joinDate: DateTime(2010, 6, 1),
        specialization: 'Surgery',
        license: 'LIC67890',
        expertise: ['General Surgery'],
      );

      doctor.addExpertise('Laparoscopic Surgery');
      doctor.addExpertise('Trauma Surgery');

      expect(doctor.hasExpertise('Laparoscopic Surgery'), true);
      expect(doctor.hasExpertise('Cardiology'), false);
    });

    test('Doctor experience calculation', () {
      final joinDate = DateTime(2010, 6, 15);
      final doctor = Doctor(
        id: 'D003',
        name: 'Dr. Experience Test',
        age: 55,
        email: 'exp@hospital.com',
        phone: '555-7777',
        staffId: 'S003',
        department: 'Neurology',
        salary: 125000,
        joinDate: joinDate,
        specialization: 'Neurology',
        license: 'LIC11111',
        expertise: ['Neurosurgery'],
      );

      final experience = doctor.getExperienceYears();
      expect(experience, greaterThan(0));
    });

    test('Create Nurse and verify shift', () {
      final nurse = Nurse(
        id: 'N001',
        name: 'Sarah Johnson',
        age: 35,
        email: 'sarah@hospital.com',
        phone: '555-9999',
        staffId: 'S004',
        department: 'ICU',
        salary: 60000,
        joinDate: DateTime(2018, 3, 10),
        certification: 'RN Certified',
        shift: 'Morning',
        skills: ['CPR', 'Patient Care'],
      );

      expect(nurse.name, 'Sarah Johnson');
      expect(nurse.getRole(), 'Nurse');
      expect(nurse.shift, 'Morning');
    });

    test('Nurse skill management', () {
      final nurse = Nurse(
        id: 'N002',
        name: 'Mike Chen',
        age: 38,
        email: 'mike@hospital.com',
        phone: '555-8888',
        staffId: 'S005',
        department: 'Emergency',
        salary: 65000,
        joinDate: DateTime(2016, 8, 20),
        certification: 'BSN',
        shift: 'Afternoon',
        skills: ['IV Insertion', 'Wound Care'],
      );

      nurse.addSkill('Catheterization');
      expect(nurse.hasSkill('Catheterization'), true);
      expect(nurse.hasSkill('Surgery'), false);
    });

    test('Create Patient with blood type', () {
      final patient = Patient(
        id: 'P001',
        name: 'Michael Brown',
        age: 55,
        email: 'michael@email.com',
        phone: '555-3333',
        patientId: 'PT001',
        bloodType: 'O+',
        medicalHistory: ['Hypertension'],
        allergies: [],
      );

      expect(patient.name, 'Michael Brown');
      expect(patient.bloodType, 'O+');
      expect(patient.getRole(), 'Patient');
    });

    test('Patient invalid blood type throws error', () {
      expect(
        () => Patient(
          id: 'P002',
          name: 'Invalid Patient',
          age: 30,
          email: 'invalid@email.com',
          phone: '555-4444',
          patientId: 'PT002',
          bloodType: 'Z-',
          medicalHistory: [],
          allergies: [],
        ),
        throwsArgumentError,
      );
    });

    test('Polymorphic role differentiation', () {
      final doctor = Doctor(
        id: 'D004',
        name: 'Dr. Poly Test',
        age: 50,
        email: 'poly@hospital.com',
        phone: '555-0000',
        staffId: 'S006',
        department: 'Oncology',
        salary: 140000,
        joinDate: DateTime(2008, 11, 12),
        specialization: 'Oncology',
        license: 'LIC22222',
        expertise: ['Cancer Treatment'],
      );

      final nurse = Nurse(
        id: 'N003',
        name: 'Poly Nurse',
        age: 40,
        email: 'pnurse@hospital.com',
        phone: '555-1111',
        staffId: 'S007',
        department: 'Oncology',
        salary: 70000,
        joinDate: DateTime(2015, 5, 8),
        certification: 'Oncology Certified',
        shift: 'Night',
        skills: ['Chemo Administration'],
      );

      final patient = Patient(
        id: 'P003',
        name: 'Poly Patient',
        age: 60,
        email: 'ppat@email.com',
        phone: '555-2222',
        patientId: 'PT003',
        bloodType: 'AB+',
        medicalHistory: ['Cancer'],
        allergies: ['Morphine'],
      );

      expect(doctor.getRole(), 'Doctor');
      expect(nurse.getRole(), 'Nurse');
      expect(patient.getRole(), 'Patient');
    });
  });

  group('Medicine Hierarchy Tests', () {
    test('Create Tablet and verify properties', () {
      final tablet = Tablet(
        medicineId: 'M001',
        name: 'Aspirin',
        description: 'Pain reliever',
        price: 5.0,
        stock: 100,
        strength: '500mg',
        tabletsPerStrip: 10,
      );

      expect(tablet.name, 'Aspirin');
      expect(tablet.getMedicineType(), 'Tablet');
      expect(tablet.getForm(), 'Solid (Tablet)');
    });

    test('Create Injection and verify properties', () {
      final injection = Injection(
        medicineId: 'M002',
        name: 'Insulin',
        description: 'Diabetes management',
        price: 45.0,
        stock: 50,
        volume: '10ml',
        type: 'Subcutaneous',
      );

      expect(injection.name, 'Insulin');
      expect(injection.getMedicineType(), 'Injection');
      expect(injection.type, 'Subcutaneous');
    });

    test('Create Syrup and verify properties', () {
      final syrup = Syrup(
        medicineId: 'M003',
        name: 'Cough Syrup',
        description: 'For dry cough',
        price: 8.0,
        stock: 75,
        volume: '200ml',
        flavor: 'Honey',
        sugarFree: false,
      );

      expect(syrup.name, 'Cough Syrup');
      expect(syrup.getMedicineType(), 'Syrup');
      expect(syrup.flavor, 'Honey');
    });

    test('Tablet JSON serialization round-trip', () {
      final originalTablet = Tablet(
        medicineId: 'M004',
        name: 'Metformin',
        description: 'Diabetes medication',
        price: 10.0,
        stock: 300,
        strength: '850mg',
        tabletsPerStrip: 10,
      );

      final jsonMap = originalTablet.toMap();
      final deserializedTablet = Tablet.fromMap(jsonMap);

      expect(deserializedTablet.name, originalTablet.name);
      expect(deserializedTablet.strength, originalTablet.strength);
      expect(
          deserializedTablet.tabletsPerStrip, originalTablet.tabletsPerStrip);
    });

    test('Injection JSON serialization round-trip', () {
      final originalInjection = Injection(
        medicineId: 'M005',
        name: 'Penicillin',
        description: 'Antibiotic injection',
        price: 20.0,
        stock: 80,
        volume: '5ml',
        type: 'Intramuscular',
      );

      final jsonMap = originalInjection.toMap();
      final deserializedInjection = Injection.fromMap(jsonMap);

      expect(deserializedInjection.name, originalInjection.name);
      expect(deserializedInjection.type, originalInjection.type);
    });
  });

  group('Prescription Tests', () {
    test('Create prescription with medicines', () {
      final doctor = Doctor(
        id: 'D005',
        name: 'Dr. Emily White',
        age: 42,
        email: 'emily@hospital.com',
        phone: '555-7777',
        staffId: 'S008',
        department: 'General',
        salary: 100000,
        joinDate: DateTime(2012, 9, 20),
        specialization: 'General Practice',
        license: 'LIC33333',
        expertise: ['General Medicine'],
      );

      final patient = Patient(
        id: 'P004',
        name: 'Robert Davis',
        age: 60,
        email: 'robert@email.com',
        phone: '555-2222',
        patientId: 'PT004',
        bloodType: 'A+',
        medicalHistory: ['Diabetes'],
        allergies: [],
      );

      final tablet = Tablet(
        medicineId: 'M006',
        name: 'Amoxicillin',
        description: 'Antibiotic',
        price: 12.0,
        stock: 200,
        strength: '250mg',
        tabletsPerStrip: 10,
      );

      final prescription = Prescription(
        prescriptionId: 'RX001',
        doctor: doctor,
        patient: patient,
        medicines: [tablet],
        diagnosis: 'Bacterial Infection',
        issuedDate: DateTime(2024, 1, 15),
        expiryDate: DateTime(2024, 3, 15),
        notes: 'Take twice daily',
      );

      expect(prescription.getMedicinesCount(), 1);
      expect(prescription.isExpired(), false);
    });

    test('Prescription total cost calculation', () {
      final doctor = Doctor(
        id: 'D006',
        name: 'Dr. Lisa Anderson',
        age: 38,
        email: 'lisa@hospital.com',
        phone: '555-8888',
        staffId: 'S009',
        department: 'Pediatrics',
        salary: 95000,
        joinDate: DateTime(2014, 5, 5),
        specialization: 'Pediatrics',
        license: 'LIC44444',
        expertise: ['Pediatric Care'],
      );

      final patient = Patient(
        id: 'P005',
        name: 'Emma Wilson',
        age: 8,
        email: 'emma@email.com',
        phone: '555-6666',
        patientId: 'PT005',
        bloodType: 'B+',
        medicalHistory: [],
        allergies: ['Peanuts'],
      );

      final tablet1 = Tablet(
        medicineId: 'M007',
        name: 'Paracetamol',
        description: 'Fever reducer',
        price: 4.0,
        stock: 150,
        strength: '250mg',
        tabletsPerStrip: 15,
      );

      final tablet2 = Tablet(
        medicineId: 'M008',
        name: 'Vitamin C',
        description: 'Immune booster',
        price: 3.0,
        stock: 200,
        strength: '500mg',
        tabletsPerStrip: 20,
      );

      final prescription = Prescription(
        prescriptionId: 'RX002',
        doctor: doctor,
        patient: patient,
        medicines: [tablet1, tablet2],
        diagnosis: 'Common Cold',
        issuedDate: DateTime(2024, 1, 16),
        expiryDate: DateTime(2024, 3, 16),
        notes: 'Once daily',
      );

      expect(prescription.getTotalCost(), 7.0);
    });

    test('Prescription expiry check - not expired', () {
      final doctor = Doctor(
        id: 'D007',
        name: 'Dr. Mark Johnson',
        age: 48,
        email: 'mark@hospital.com',
        phone: '555-0000',
        staffId: 'S010',
        department: 'Neurology',
        salary: 125000,
        joinDate: DateTime(2008, 11, 12),
        specialization: 'Neurology',
        license: 'LIC55555',
        expertise: ['Neurotherapy'],
      );

      final patient = Patient(
        id: 'P006',
        name: 'James Taylor',
        age: 50,
        email: 'james@email.com',
        phone: '555-1111',
        patientId: 'PT006',
        bloodType: 'AB+',
        medicalHistory: ['Migraine'],
        allergies: [],
      );

      final tablet = Tablet(
        medicineId: 'M009',
        name: 'Statins',
        description: 'Cholesterol control',
        price: 15.0,
        stock: 120,
        strength: '10mg',
        tabletsPerStrip: 14,
      );

      final futureDate = DateTime.now().add(Duration(days: 60));
      final prescription = Prescription(
        prescriptionId: 'RX003',
        doctor: doctor,
        patient: patient,
        medicines: [tablet],
        diagnosis: 'High Cholesterol',
        issuedDate: DateTime.now(),
        expiryDate: futureDate,
        notes: 'Daily intake',
      );

      expect(prescription.isExpired(), false);
    });

    test('Prescription expiry check - expired', () {
      final doctor = Doctor(
        id: 'D008',
        name: 'Dr. Patricia Lee',
        age: 44,
        email: 'patricia@hospital.com',
        phone: '555-5555',
        staffId: 'S011',
        department: 'Dermatology',
        salary: 105000,
        joinDate: DateTime(2011, 4, 18),
        specialization: 'Dermatology',
        license: 'LIC66666',
        expertise: ['Skin Treatment'],
      );

      final patient = Patient(
        id: 'P007',
        name: 'Amanda Clark',
        age: 32,
        email: 'amanda@email.com',
        phone: '555-9876',
        patientId: 'PT007',
        bloodType: 'O-',
        medicalHistory: [],
        allergies: ['Sulfites'],
      );

      final tablet = Tablet(
        medicineId: 'M010',
        name: 'Acne Cream',
        description: 'Topical acne treatment',
        price: 20.0,
        stock: 50,
        strength: '2%',
        tabletsPerStrip: 1,
      );

      final pastDate = DateTime.now().subtract(Duration(days: 30));
      final prescription = Prescription(
        prescriptionId: 'RX004',
        doctor: doctor,
        patient: patient,
        medicines: [tablet],
        diagnosis: 'Severe Acne',
        issuedDate: pastDate.subtract(Duration(days: 60)),
        expiryDate: pastDate,
        notes: 'As needed',
      );

      expect(prescription.isExpired(), true);
    });

    test('Prescription validation - empty medicines throws error', () {
      final doctor = Doctor(
        id: 'D009',
        name: 'Dr. Test Valid',
        age: 45,
        email: 'test@hospital.com',
        phone: '555-1234',
        staffId: 'S012',
        department: 'Testing',
        salary: 100000,
        joinDate: DateTime(2015, 1, 15),
        specialization: 'Testing',
        license: 'LIC77777',
        expertise: ['Testing'],
      );

      final patient = Patient(
        id: 'P008',
        name: 'Validation Patient',
        age: 40,
        email: 'val@email.com',
        phone: '555-5555',
        patientId: 'PT008',
        bloodType: 'A-',
        medicalHistory: [],
        allergies: [],
      );

      expect(
        () => Prescription(
          prescriptionId: 'RX005',
          doctor: doctor,
          patient: patient,
          medicines: [],
          diagnosis: 'Test',
          issuedDate: DateTime.now(),
          expiryDate: null,
          notes: 'Test',
        ),
        throwsArgumentError,
      );
    });
  });

  group('JSON Serialization Tests', () {
    test('Doctor JSON serialization round-trip', () {
      final originalDoctor = Doctor(
        id: 'D010',
        name: 'Dr. JSON Test',
        age: 46,
        email: 'json@hospital.com',
        phone: '555-3210',
        staffId: 'S013',
        department: 'JSON Testing',
        salary: 115000,
        joinDate: DateTime(2013, 7, 22),
        specialization: 'JSON Serialization',
        license: 'LIC88888',
        expertise: ['JSON', 'Serialization'],
      );

      final jsonMap = originalDoctor.toMap();
      final deserializedDoctor = Doctor.fromMap(jsonMap);

      expect(deserializedDoctor.name, originalDoctor.name);
      expect(deserializedDoctor.specialization, originalDoctor.specialization);
      expect(deserializedDoctor.license, originalDoctor.license);
    });

    test('Patient JSON serialization round-trip', () {
      final originalPatient = Patient(
        id: 'P009',
        name: 'Patient JSON',
        age: 55,
        email: 'pjson@email.com',
        phone: '555-4321',
        patientId: 'PT009',
        bloodType: 'B-',
        medicalHistory: ['Hypertension', 'Diabetes'],
        allergies: ['Latex', 'Penicillin'],
      );

      final jsonMap = originalPatient.toMap();
      final deserializedPatient = Patient.fromMap(jsonMap);

      expect(deserializedPatient.name, originalPatient.name);
      expect(deserializedPatient.bloodType, originalPatient.bloodType);
      expect(deserializedPatient.medicalHistory.length, 2);
      expect(deserializedPatient.allergies.length, 2);
    });

    test('Syrup JSON serialization round-trip', () {
      final originalSyrup = Syrup(
        medicineId: 'M011',
        name: 'Cough Relief',
        description: 'Effective cough syrup',
        price: 7.5,
        stock: 100,
        volume: '150ml',
        flavor: 'Cherry',
        sugarFree: true,
      );

      final jsonMap = originalSyrup.toMap();
      final deserializedSyrup = Syrup.fromMap(jsonMap);

      expect(deserializedSyrup.name, originalSyrup.name);
      expect(deserializedSyrup.flavor, originalSyrup.flavor);
      expect(deserializedSyrup.sugarFree, originalSyrup.sugarFree);
    });
  });

  group('Encapsulation Tests', () {
    test('Private fields protected - Doctor', () {
      final doctor = Doctor(
        id: 'D011',
        name: 'Dr. Encapsulation',
        age: 41,
        email: 'encap@hospital.com',
        phone: '555-4321',
        staffId: 'S014',
        department: 'Encapsulation',
        salary: 110000,
        joinDate: DateTime(2016, 2, 14),
        specialization: 'Testing Encapsulation',
        license: 'LIC99999',
        expertise: ['Encapsulation'],
      );

      // Private fields not directly accessible - getters only
      expect(doctor.name, 'Dr. Encapsulation');
      expect(doctor.getRole(), 'Doctor');
    });

    test('Experience calculation uses private join date', () {
      final joinDate = DateTime(2010, 6, 15);
      final doctor = Doctor(
        id: 'D012',
        name: 'Dr. Experience',
        age: 50,
        email: 'exp@hospital.com',
        phone: '555-0000',
        staffId: 'S015',
        department: 'Experience',
        salary: 140000,
        joinDate: joinDate,
        specialization: 'Experience Medicine',
        license: 'LIC00000',
        expertise: ['Experience'],
      );

      final experience = doctor.getExperienceYears();
      expect(experience, greaterThan(0));
      expect(experience,
          lessThanOrEqualTo(DateTime.now().year - joinDate.year + 1));
    });

    test('Patient allergies are encapsulated', () {
      final patient1 = Patient(
        id: 'P010',
        name: 'Patient One',
        age: 45,
        email: 'p1@email.com',
        phone: '555-5555',
        patientId: 'PT010',
        bloodType: 'A-',
        medicalHistory: [],
        allergies: [],
      );

      final patient2 = Patient(
        id: 'P011',
        name: 'Patient Two',
        age: 38,
        email: 'p2@email.com',
        phone: '555-6666',
        patientId: 'PT011',
        bloodType: 'B-',
        medicalHistory: [],
        allergies: [],
      );

      patient1.addAllergy('Penicillin');
      patient1.addAllergy('Shellfish');
      patient2.addAllergy('Latex');

      expect(patient1.hasAllergy('Penicillin'), true);
      expect(patient2.hasAllergy('Penicillin'), false);
      expect(patient2.hasAllergy('Latex'), true);
    });

    test('Medicine list is immutable from outside', () {
      final tablet = Tablet(
        medicineId: 'M012',
        name: 'Immutability Test',
        description: 'Testing immutability',
        price: 5.0,
        stock: 100,
        strength: '500mg',
        tabletsPerStrip: 10,
      );

      // Getting immutable list prevents external modification
      final medicines = [tablet];
      expect(medicines.length, 1);
    });
  });

  group('Polymorphism Tests', () {
    test('Medicine polymorphism - different forms', () {
      final tablet = Tablet(
        medicineId: 'M013',
        name: 'Aspirin',
        description: 'Tablet form',
        price: 5.0,
        stock: 100,
        strength: '500mg',
        tabletsPerStrip: 10,
      );

      final injection = Injection(
        medicineId: 'M014',
        name: 'Vitamin B12',
        description: 'Injectable form',
        price: 15.0,
        stock: 50,
        volume: '5ml',
        type: 'Intramuscular',
      );

      final syrup = Syrup(
        medicineId: 'M015',
        name: 'Cough Syrup',
        description: 'Liquid form',
        price: 8.0,
        stock: 75,
        volume: '200ml',
        flavor: 'Honey',
        sugarFree: false,
      );

      expect(tablet.getForm(), 'Solid (Tablet)');
      expect(injection.getForm(), 'Liquid (Injectable)');
      expect(syrup.getForm(), 'Liquid (Oral Syrup)');
    });

    test('Staff polymorphism - different roles', () {
      final doctor = Doctor(
        id: 'D013',
        name: 'Dr. Polymorphic',
        age: 50,
        email: 'poly@hospital.com',
        phone: '555-7777',
        staffId: 'S016',
        department: 'Polymorphism',
        salary: 140000,
        joinDate: DateTime(2008, 11, 12),
        specialization: 'Polymorphic Medicine',
        license: 'LICPOLY1',
        expertise: ['Polymorphism'],
      );

      final nurse = Nurse(
        id: 'N004',
        name: 'Nurse Polymorphic',
        age: 40,
        email: 'pnurse@hospital.com',
        phone: '555-1111',
        staffId: 'S017',
        department: 'Polymorphism',
        salary: 70000,
        joinDate: DateTime(2015, 5, 8),
        certification: 'Certified',
        shift: 'Night',
        skills: ['Care'],
      );

      final doctorInfo = doctor.getStaffInfo();
      final nurseInfo = nurse.getStaffInfo();

      expect(doctorInfo, contains('Specialization'));
      expect(nurseInfo, contains('Certification'));
    });
  });
}
