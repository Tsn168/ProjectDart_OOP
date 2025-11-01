import '../domain/doctor.dart';
import '../domain/patient.dart';
import '../domain/tablet.dart';
import '../domain/injection.dart';
import '../domain/syrup.dart';

class SeedData {
  // Pre-loaded default doctors
  static List<Doctor> getDefaultDoctors() {
    return [
      Doctor(
        id: 'DOC001',
        name: 'Dr. Ahmed Hassan',
        age: 45,
        email: 'ahmed@hospital.com',
        phoneNumber: '+966501234567',
        address: 'Riyadh',
        specialization: 'Cardiology',
        isAvailable: true,
        salary: 15000.0,
        licenseNumber: 'LIC001',
        certifications: ['Board Certified Cardiologist', 'ACLS Certified'],
        yearsOfExperience: 15,
        department: 'Cardiology Department',
      ),
      Doctor(
        id: 'DOC002',
        name: 'Dr. Fatima Al-Dosari',
        age: 38,
        email: 'fatima@hospital.com',
        phoneNumber: '+966502345678',
        address: 'Jeddah',
        specialization: 'Pediatrics',
        isAvailable: true,
        salary: 13000.0,
        licenseNumber: 'LIC002',
        certifications: [
          'Board Certified Pediatrician',
          'Neonatology Specialist'
        ],
        yearsOfExperience: 12,
        department: 'Pediatrics Department',
      ),
      Doctor(
        id: 'DOC003',
        name: 'Dr. Mohammed Khalid',
        age: 50,
        email: 'mohammed@hospital.com',
        phoneNumber: '+966503456789',
        address: 'Dammam',
        specialization: 'Orthopedics',
        isAvailable: true,
        salary: 16000.0,
        licenseNumber: 'LIC003',
        certifications: [
          'Board Certified Orthopedic Surgeon',
          'Trauma Specialist'
        ],
        yearsOfExperience: 20,
        department: 'Orthopedic Surgery',
      ),
      Doctor(
        id: 'DOC004',
        name: 'Dr. Layla Ibrahim',
        age: 42,
        email: 'layla@hospital.com',
        phoneNumber: '+966504567890',
        address: 'Medina',
        specialization: 'General Medicine',
        isAvailable: true,
        salary: 12000.0,
        licenseNumber: 'LIC004',
        certifications: ['Internal Medicine Specialist'],
        yearsOfExperience: 10,
        department: 'General Medicine',
      ),
    ];
  }

  // Pre-loaded default patients
  static List<Patient> getDefaultPatients() {
    return [
      Patient(
        id: 'PAT001',
        name: 'Sarah Johnson',
        age: 35,
        email: 'sarah@email.com',
        phoneNumber: '+966509876543',
        address: 'Riyadh',
        medicalHistory: 'Hypertension, Diabetes Type 2',
        allergies: ['Penicillin', 'Aspirin'],
        bloodType: 'O+',
      ),
      Patient(
        id: 'PAT002',
        name: 'Ali Mohammed',
        age: 42,
        email: 'ali@email.com',
        phoneNumber: '+966508765432',
        address: 'Jeddah',
        medicalHistory: 'Asthma, Allergic Rhinitis',
        allergies: ['Sulfa drugs'],
        bloodType: 'A-',
      ),
      Patient(
        id: 'PAT003',
        name: 'Layla Hassan',
        age: 28,
        email: 'layla@email.com',
        phoneNumber: '+966507654321',
        address: 'Dammam',
        medicalHistory: 'Migraine disorder',
        allergies: [],
        bloodType: 'B+',
      ),
      Patient(
        id: 'PAT004',
        name: 'Omar Abdullah',
        age: 55,
        email: 'omar@email.com',
        phoneNumber: '+966506543210',
        address: 'Medina',
        medicalHistory: 'Heart disease, High cholesterol',
        allergies: ['NSAIDs'],
        bloodType: 'AB-',
      ),
      Patient(
        id: 'PAT005',
        name: 'Nour Al-Rashid',
        age: 32,
        email: 'nour@email.com',
        phoneNumber: '+966505432109',
        address: 'Riyadh',
        medicalHistory: 'No significant medical history',
        allergies: [],
        bloodType: 'O-',
      ),
    ];
  }

  // Pre-loaded default medicines
  static List<dynamic> getDefaultMedicines() {
    return [
      Tablet(
        id: 'MED001',
        name: 'Aspirin',
        dosage: '500mg',
        quantity: 100,
        manufacturer: 'Bayer',
        expiryDate: DateTime(2026, 12, 31),
        shape: 'Round',
        color: 'White',
        coated: true,
      ),
      Tablet(
        id: 'MED002',
        name: 'Ibuprofen',
        dosage: '400mg',
        quantity: 50,
        manufacturer: 'GSK',
        expiryDate: DateTime(2026, 6, 30),
        shape: 'Oval',
        color: 'Yellow',
        coated: false,
      ),
      Tablet(
        id: 'MED003',
        name: 'Metformin',
        dosage: '500mg',
        quantity: 80,
        manufacturer: 'Merck',
        expiryDate: DateTime(2026, 9, 15),
        shape: 'Hexagonal',
        color: 'White',
        coated: true,
      ),
      Injection(
        id: 'MED004',
        name: 'Insulin Glargine',
        dosage: '10 units',
        quantity: 30,
        manufacturer: 'Novo Nordisk',
        expiryDate: DateTime(2026, 3, 15),
        injectionType: 'Subcutaneous',
        route: 'SC',
        volumeMl: 1.0,
      ),
      Injection(
        id: 'MED005',
        name: 'Amoxicillin (Injectable)',
        dosage: '250mg',
        quantity: 20,
        manufacturer: 'Pfizer',
        expiryDate: DateTime(2026, 5, 20),
        injectionType: 'Intramuscular',
        route: 'IM',
        volumeMl: 2.0,
      ),
      Syrup(
        id: 'MED006',
        name: 'Cough Syrup',
        dosage: '5ml per dose',
        quantity: 10,
        manufacturer: 'Pharma Plus',
        expiryDate: DateTime(2026, 8, 20),
        flavor: 'Cherry',
        volumeMl: 100.0,
        sugarFree: false,
      ),
      Syrup(
        id: 'MED007',
        name: 'Allergy Relief Syrup',
        dosage: '5ml per dose',
        quantity: 8,
        manufacturer: 'Bayer',
        expiryDate: DateTime(2026, 10, 10),
        flavor: 'Strawberry',
        volumeMl: 120.0,
        sugarFree: true,
      ),
    ];
  }
}
