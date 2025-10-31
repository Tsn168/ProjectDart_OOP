import 'dart:io';
import '../domain/patient.dart';
import '../domain/doctor.dart';
import '../domain/nurse.dart';
import '../domain/medicine.dart';
import '../domain/tablet.dart';
import '../domain/injection.dart';
import '../domain/syrup.dart';
import '../domain/prescription_service.dart';
import '../data/prescription_repo.dart';

class HospitalConsole {
  final PrescriptionRepository prescriptionRepository;
  final PrescriptionService prescriptionService;
  final List<Doctor> doctors = [];
  final List<Nurse> nurses = [];
  final List<Patient> patients = [];
  final List<Medicine> medicines = [];

  HospitalConsole(this.prescriptionRepository, this.prescriptionService);

  void displayMainMenu() {
    print('\n╔════════════════════════════════════════════╗');
    print('║   Hospital Management System - Main Menu   ║');
    print('╠════════════════════════════════════════════╣');
    print('║  1. Manage Staff (Doctors & Nurses)        ║');
    print('║  2. Manage Patients                        ║');
    print('║  3. Manage Medicines                       ║');
    print('║  4. Manage Prescriptions                   ║');
    print('║  5. View Reports                           ║');
    print('║  6. Export Data                            ║');
    print('║  7. Exit                                   ║');
    print('╚════════════════════════════════════════════╝');
    print('Enter your choice: ');
  }

  void displayStaffMenu() {
    print('\n╔════════════════════════════════════════════╗');
    print('║          Staff Management Menu             ║');
    print('╠════════════════════════════════════════════╣');
    print('║  1. View All Doctors                       ║');
    print('║  2. View All Nurses                        ║');
    print('║  3. Back to Main Menu                      ║');
    print('╚════════════════════════════════════════════╝');
    print('Enter your choice: ');
  }

  void displayPatientMenu() {
    print('\n╔════════════════════════════════════════════╗');
    print('║        Patient Management Menu             ║');
    print('╠════════════════════════════════════════════╣');
    print('║  1. Add Patient                            ║');
    print('║  2. View All Patients                      ║');
    print('║  3. Back to Main Menu                      ║');
    print('╚════════════════════════════════════════════╝');
    print('Enter your choice: ');
  }

  void displayMedicineMenu() {
    print('\n╔════════════════════════════════════════════╗');
    print('║       Medicine Management Menu             ║');
    print('╠════════════════════════════════════════════╣');
    print('║  1. Add Tablet                             ║');
    print('║  2. Add Injection                          ║');
    print('║  3. Add Syrup                              ║');
    print('║  4. View All Medicines                     ║');
    print('║  5. Back to Main Menu                      ║');
    print('╚════════════════════════════════════════════╝');
    print('Enter your choice: ');
  }

  void displayPrescriptionMenu() {
    print('\n╔════════════════════════════════════════════╗');
    print('║      Prescription Management Menu          ║');
    print('╠════════════════════════════════════════════╣');
    print('║  1. Create Prescription                    ║');
    print('║  2. View All Prescriptions                 ║');
    print('║  3. View Patient Prescriptions             ║');
    print('║  4. Validate Prescription                  ║');
    print('║  5. Back to Main Menu                      ║');
    print('╚════════════════════════════════════════════╝');
    print('Enter your choice: ');
  }

  // STAFF MANAGEMENT
  void addDoctor() {
    print('\n--- Add New Doctor ---');
    print('Enter Doctor ID: ');
    final id = stdin.readLineSync() ?? '';
    print('Enter Name: ');
    final name = stdin.readLineSync() ?? '';
    print('Enter Age: ');
    final age = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
    print('Enter Email: ');
    final email = stdin.readLineSync() ?? '';
    print('Enter Phone Number: ');
    final phone = stdin.readLineSync() ?? '';
    print('Enter Address: ');
    final address = stdin.readLineSync() ?? '';
    print('Enter Specialization: ');
    final specialization = stdin.readLineSync() ?? '';
    print('Enter Salary: ');
    final salary = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;
    print('Enter License Number: ');
    final license = stdin.readLineSync() ?? '';
    print('Enter Department: ');
    final department = stdin.readLineSync() ?? '';
    print('Enter Years of Experience: ');
    final yearsExp = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
    print('Enter Certifications (comma-separated): ');
    final certInput = stdin.readLineSync() ?? '';
    final certifications = certInput.split(',').map((e) => e.trim()).toList();

    final doctor = Doctor(
      id: id,
      name: name,
      age: age,
      email: email,
      phoneNumber: phone,
      address: address,
      specialization: specialization,
      isAvailable: true,
      salary: salary,
      licenseNumber: license,
      certifications: certifications,
      yearsOfExperience: yearsExp,
      department: department,
    );

    doctors.add(doctor);
    print('✓ Doctor added successfully!');
  }

  void addNurse() {
    print('\n--- Add New Nurse ---');
    print('Enter Nurse ID: ');
    final id = stdin.readLineSync() ?? '';
    print('Enter Name: ');
    final name = stdin.readLineSync() ?? '';
    print('Enter Age: ');
    final age = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
    print('Enter Email: ');
    final email = stdin.readLineSync() ?? '';
    print('Enter Phone Number: ');
    final phone = stdin.readLineSync() ?? '';
    print('Enter Address: ');
    final address = stdin.readLineSync() ?? '';
    print('Enter Specialization: ');
    final specialization = stdin.readLineSync() ?? '';
    print('Enter Salary: ');
    final salary = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;
    print('Enter License Number: ');
    final license = stdin.readLineSync() ?? '';
    print('Enter Department: ');
    final department = stdin.readLineSync() ?? '';
    print('Enter Shift Type (Morning/Evening/Night): ');
    final shift = stdin.readLineSync() ?? 'Morning';
    print('Enter Certifications (comma-separated): ');
    final certInput = stdin.readLineSync() ?? '';
    final certifications = certInput.split(',').map((e) => e.trim()).toList();

    final nurse = Nurse(
      id: id,
      name: name,
      age: age,
      email: email,
      phoneNumber: phone,
      address: address,
      specialization: specialization,
      isAvailable: true,
      salary: salary,
      licenseNumber: license,
      shiftType: shift,
      certifications: certifications,
      department: department,
    );

    nurses.add(nurse);
    print('✓ Nurse added successfully!');
  }

  void viewAllDoctors() {
    print('\n--- All Doctors ---');
    if (doctors.isEmpty) {
      print('No doctors found.');
      return;
    }
    for (var doctor in doctors) {
      print(
        '${doctor.id} | ${doctor.name} | ${doctor.specialization} | Available: ${doctor.isAvailable}',
      );
    }
  }

  void viewAllNurses() {
    print('\n--- All Nurses ---');
    if (nurses.isEmpty) {
      print('No nurses found.');
      return;
    }
    for (var nurse in nurses) {
      print(
        '${nurse.id} | ${nurse.name} | ${nurse.shiftType} | Available: ${nurse.isAvailable}',
      );
    }
  }

  // PATIENT MANAGEMENT
  void addPatient() {
    print('\n--- Add New Patient ---');
    print('Enter Patient ID: ');
    final id = stdin.readLineSync() ?? '';
    print('Enter Name: ');
    final name = stdin.readLineSync() ?? '';
    print('Enter Age: ');
    final age = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
    print('Enter Email: ');
    final email = stdin.readLineSync() ?? '';
    print('Enter Phone Number: ');
    final phone = stdin.readLineSync() ?? '';
    print('Enter Address: ');
    final address = stdin.readLineSync() ?? '';
    print('Enter Medical History: ');
    final history = stdin.readLineSync() ?? '';
    print('Enter Blood Type (A+, A-, B+, B-, AB+, AB-, O+, O-): ');
    final bloodType = stdin.readLineSync() ?? 'O+';
    print('Enter Allergies (comma-separated, or leave blank): ');
    final allergiesInput = stdin.readLineSync() ?? '';
    final allergies = allergiesInput.isEmpty
        ? <String>[]
        : allergiesInput.split(',').map((e) => e.trim()).toList();

    final patient = Patient(
      id: id,
      name: name,
      age: age,
      email: email,
      phoneNumber: phone,
      address: address,
      medicalHistory: history,
      allergies: allergies,
      bloodType: bloodType,
    );

    patients.add(patient);
    print('✓ Patient added successfully!');
  }

  void viewAllPatients() {
    print('\n--- All Patients ---');
    if (patients.isEmpty) {
      print('No patients found.');
      return;
    }
    for (var patient in patients) {
      print(
        '${patient.id} | ${patient.name} | Age: ${patient.age} | Blood Type: ${patient.bloodType}',
      );
    }
  }

  // MEDICINE MANAGEMENT
  void addTablet() {
    print('\n--- Add New Tablet ---');
    print('Enter Medicine ID: ');
    final id = stdin.readLineSync() ?? '';
    print('Enter Medicine Name: ');
    final name = stdin.readLineSync() ?? '';
    print('Enter Dosage (e.g., 500mg): ');
    final dosage = stdin.readLineSync() ?? '';
    print('Enter Quantity: ');
    final quantity = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
    print('Enter Manufacturer: ');
    final manufacturer = stdin.readLineSync() ?? '';
    print('Enter Expiry Date (yyyy-mm-dd): ');
    final expiryStr = stdin.readLineSync() ?? '';
    final expiryDate =
        DateTime.tryParse(expiryStr) ?? DateTime.now().add(Duration(days: 365));
    print('Enter Shape: ');
    final shape = stdin.readLineSync() ?? '';
    print('Enter Color: ');
    final color = stdin.readLineSync() ?? '';
    print('Is Coated? (y/n): ');
    final coated = (stdin.readLineSync() ?? 'n').toLowerCase() == 'y';

    final tablet = Tablet(
      id: id,
      name: name,
      dosage: dosage,
      quantity: quantity,
      manufacturer: manufacturer,
      expiryDate: expiryDate,
      shape: shape,
      color: color,
      coated: coated,
    );

    medicines.add(tablet);
    print('✓ Tablet added successfully!');
  }

  void addInjection() {
    print('\n--- Add New Injection ---');
    print('Enter Medicine ID: ');
    final id = stdin.readLineSync() ?? '';
    print('Enter Medicine Name: ');
    final name = stdin.readLineSync() ?? '';
    print('Enter Dosage: ');
    final dosage = stdin.readLineSync() ?? '';
    print('Enter Quantity: ');
    final quantity = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
    print('Enter Manufacturer: ');
    final manufacturer = stdin.readLineSync() ?? '';
    print('Enter Expiry Date (yyyy-mm-dd): ');
    final expiryStr = stdin.readLineSync() ?? '';
    final expiryDate =
        DateTime.tryParse(expiryStr) ?? DateTime.now().add(Duration(days: 365));
    print('Enter Injection Type (e.g., Intramuscular): ');
    final injType = stdin.readLineSync() ?? '';
    print('Enter Route (e.g., IM, IV, SC): ');
    final route = stdin.readLineSync() ?? '';
    print('Enter Volume (ml): ');
    final volume = double.tryParse(stdin.readLineSync() ?? '') ?? 1.0;

    final injection = Injection(
      id: id,
      name: name,
      dosage: dosage,
      quantity: quantity,
      manufacturer: manufacturer,
      expiryDate: expiryDate,
      injectionType: injType,
      route: route,
      volumeMl: volume,
    );

    medicines.add(injection);
    print('✓ Injection added successfully!');
  }

  void addSyrup() {
    print('\n--- Add New Syrup ---');
    print('Enter Medicine ID: ');
    final id = stdin.readLineSync() ?? '';
    print('Enter Medicine Name: ');
    final name = stdin.readLineSync() ?? '';
    print('Enter Dosage: ');
    final dosage = stdin.readLineSync() ?? '';
    print('Enter Quantity: ');
    final quantity = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
    print('Enter Manufacturer: ');
    final manufacturer = stdin.readLineSync() ?? '';
    print('Enter Expiry Date (yyyy-mm-dd): ');
    final expiryStr = stdin.readLineSync() ?? '';
    final expiryDate =
        DateTime.tryParse(expiryStr) ?? DateTime.now().add(Duration(days: 365));
    print('Enter Flavor: ');
    final flavor = stdin.readLineSync() ?? '';
    print('Enter Volume (ml): ');
    final volume = double.tryParse(stdin.readLineSync() ?? '') ?? 100.0;
    print('Is Sugar Free? (y/n): ');
    final sugarFree = (stdin.readLineSync() ?? 'n').toLowerCase() == 'y';

    final syrup = Syrup(
      id: id,
      name: name,
      dosage: dosage,
      quantity: quantity,
      manufacturer: manufacturer,
      expiryDate: expiryDate,
      flavor: flavor,
      volumeMl: volume,
      sugarFree: sugarFree,
    );

    medicines.add(syrup);
    print('✓ Syrup added successfully!');
  }

  void viewAllMedicines() {
    print('\n--- All Medicines ---');
    if (medicines.isEmpty) {
      print('No medicines found.');
      return;
    }
    for (var medicine in medicines) {
      print(
        '${medicine.id} | ${medicine.name} | ${medicine.getMedicineType()} | Qty: ${medicine.quantity} | Expired: ${medicine.isExpired()}',
      );
    }
  }

  // PRESCRIPTION MANAGEMENT
  void createPrescription() {
    print('\n--- Create New Prescription ---');

    if (doctors.isEmpty) {
      print('✗ No doctors available. Please add a doctor first.');
      return;
    }
    if (patients.isEmpty) {
      print('✗ No patients available. Please add a patient first.');
      return;
    }
    if (medicines.isEmpty) {
      print('✗ No medicines available. Please add medicines first.');
      return;
    }

    print('Enter Prescription ID: ');
    final prescriptionId = stdin.readLineSync() ?? '';

    print('\nAvailable Doctors:');
    for (var i = 0; i < doctors.length; i++) {
      print('${i + 1}. ${doctors[i].name} (${doctors[i].specialization})');
    }
    print('Select Doctor (number): ');
    final doctorIdx = (int.tryParse(stdin.readLineSync() ?? '') ?? 1) - 1;
    if (doctorIdx < 0 || doctorIdx >= doctors.length) {
      print('✗ Invalid doctor selection.');
      return;
    }
    final doctor = doctors[doctorIdx];

    print('\nAvailable Patients:');
    for (var i = 0; i < patients.length; i++) {
      print('${i + 1}. ${patients[i].name} (Age: ${patients[i].age})');
    }
    print('Select Patient (number): ');
    final patientIdx = (int.tryParse(stdin.readLineSync() ?? '') ?? 1) - 1;
    if (patientIdx < 0 || patientIdx >= patients.length) {
      print('✗ Invalid patient selection.');
      return;
    }
    final patient = patients[patientIdx];

    print('\nAvailable Medicines:');
    for (var i = 0; i < medicines.length; i++) {
      print(
        '${i + 1}. ${medicines[i].name} (${medicines[i].getMedicineType()})',
      );
    }
    print('Enter Medicine indices to prescribe (comma-separated): ');
    final medIndicesStr = stdin.readLineSync() ?? '';
    final medIndices = medIndicesStr
        .split(',')
        .map((e) => (int.tryParse(e.trim()) ?? 1) - 1)
        .toList();

    final selectedMedicines = <Medicine>[];
    for (var idx in medIndices) {
      if (idx >= 0 && idx < medicines.length) {
        selectedMedicines.add(medicines[idx]);
      }
    }

    if (selectedMedicines.isEmpty) {
      print('✗ No valid medicines selected.');
      return;
    }

    print('Enter Notes/Instructions: ');
    final notes = stdin.readLineSync() ?? '';
    print('Enter Validity (days): ');
    final validityDays = int.tryParse(stdin.readLineSync() ?? '') ?? 30;

    try {
      final prescription = prescriptionService.createPrescription(
        prescriptionId: prescriptionId,
        doctor: doctor,
        patient: patient,
        medicines: selectedMedicines,
        notes: notes,
        validityDays: validityDays,
      );

      prescriptionRepository.addPrescription(prescription);
      print('✓ Prescription created successfully!');
      print('${prescription.getPrescriptionInfo()}');
    } catch (e) {
      print('✗ Error creating prescription: $e');
    }
  }

  void viewAllPrescriptions() {
    print('\n--- All Prescriptions ---');
    final prescriptions = prescriptionRepository.getAllPrescriptions();
    if (prescriptions.isEmpty) {
      print('No prescriptions found.');
      return;
    }
    for (var prescription in prescriptions) {
      print(
        '${prescription.prescriptionId} | ${prescription.doctor.name} → ${prescription.patient.name} | Medicines: ${prescription.medicines.length} | Status: ${prescription.status}',
      );
    }
  }

  void viewPatientPrescriptions() {
    print('\nEnter Patient ID: ');
    final patientId = stdin.readLineSync() ?? '';
    final prescriptions = prescriptionRepository.getPrescriptionsByPatientId(
      patientId,
    );

    if (prescriptions.isEmpty) {
      print('No prescriptions found for this patient.');
      return;
    }

    print('\n--- Prescriptions for Patient $patientId ---');
    for (var prescription in prescriptions) {
      print(
        '${prescription.prescriptionId} | Doctor: ${prescription.doctor.name} | Medicines: ${prescription.medicines.length} | Status: ${prescription.status}',
      );
    }
  }

  void validatePrescription() {
    print('\nEnter Prescription ID: ');
    final prescriptionId = stdin.readLineSync() ?? '';
    final prescription = prescriptionRepository.getPrescriptionById(
      prescriptionId,
    );

    if (prescription == null) {
      print('✗ Prescription not found.');
      return;
    }

    final isValid = prescriptionService.validatePrescription(prescription);
    if (isValid) {
      print('✓ Prescription is VALID');
      print(
        'Duration: ${prescriptionService.getPrescriptionDurationDays(prescription)} days',
      );
    } else {
      print('✗ Prescription is INVALID');
    }
  }

  void exportData() {
    print('\n--- Export Data ---');
    final jsonData = prescriptionRepository.exportAsJson();
    final file = File('hospital_data.json');
    file.writeAsStringSync(jsonData);
    print('✓ Data exported to hospital_data.json');
  }

  void run() {
    bool running = true;
    while (running) {
      displayMainMenu();
      final choice = stdin.readLineSync() ?? '';

      switch (choice) {
        case '1':
          staffMenu();
          break;
        case '2':
          patientMenu();
          break;
        case '3':
          medicineMenu();
          break;
        case '4':
          prescriptionMenu();
          break;
        case '5':
          viewReports();
          break;
        case '6':
          exportData();
          break;
        case '7':
          running = false;
          print('\n✓ Thank you for using Hospital Management System!');
          break;
        default:
          print('✗ Invalid choice. Please try again.');
      }
    }
  }

  void staffMenu() {
    bool inMenu = true;
    while (inMenu) {
      displayStaffMenu();
      final choice = stdin.readLineSync() ?? '';

      switch (choice) {
        case '1':
          viewAllDoctors();
          break;
        case '2':
          viewAllNurses();
          break;
        case '3':
          inMenu = false;
          break;
        default:
          print('✗ Invalid choice.');
      }
    }
  }

  void patientMenu() {
    bool inMenu = true;
    while (inMenu) {
      displayPatientMenu();
      final choice = stdin.readLineSync() ?? '';

      switch (choice) {
        case '1':
          addPatient();
          break;
        case '2':
          viewAllPatients();
          break;
        case '3':
          inMenu = false;
          break;
        default:
          print('✗ Invalid choice.');
      }
    }
  }

  void medicineMenu() {
    bool inMenu = true;
    while (inMenu) {
      displayMedicineMenu();
      final choice = stdin.readLineSync() ?? '';

      switch (choice) {
        case '1':
          addTablet();
          break;
        case '2':
          addInjection();
          break;
        case '3':
          addSyrup();
          break;
        case '4':
          viewAllMedicines();
          break;
        case '5':
          inMenu = false;
          break;
        default:
          print('✗ Invalid choice.');
      }
    }
  }

  void prescriptionMenu() {
    bool inMenu = true;
    while (inMenu) {
      displayPrescriptionMenu();
      final choice = stdin.readLineSync() ?? '';

      switch (choice) {
        case '1':
          createPrescription();
          break;
        case '2':
          viewAllPrescriptions();
          break;
        case '3':
          viewPatientPrescriptions();
          break;
        case '4':
          validatePrescription();
          break;
        case '5':
          inMenu = false;
          break;
        default:
          print('✗ Invalid choice.');
      }
    }
  }

  void viewReports() {
    print('\n--- Reports ---');
    print('Total Doctors: ${doctors.length}');
    print('Total Nurses: ${nurses.length}');
    print('Total Patients: ${patients.length}');
    print('Total Medicines: ${medicines.length}');
    print(
      'Total Prescriptions: ${prescriptionRepository.getPrescriptionCount()}',
    );
    print(
      'Valid Prescriptions: ${prescriptionRepository.getValidPrescriptions().length}',
    );
  }
}
