import 'doctor.dart';
import 'patient.dart';
import 'medicine.dart';
import 'tablet.dart';
import 'injection.dart';
import 'syrup.dart';

class Prescription {
  final String prescriptionId;
  final Doctor doctor;
  final Patient patient;
  final List<Medicine> medicines;
  final DateTime issuedDate;
  final DateTime expiryDate;
  final String notes;
  final String status; // active, completed, expired

  Prescription({
    required this.prescriptionId,
    required this.doctor,
    required this.patient,
    required this.medicines,
    required this.issuedDate,
    required this.expiryDate,
    required this.notes,
    this.status = 'active',
  });

  // Check if prescription is valid
  bool isValid() {
    return DateTime.now().isBefore(expiryDate) && status == 'active';
  }

  // Check if prescription is expired
  bool isExpired() {
    return DateTime.now().isAfter(expiryDate);
  }

  // Get prescription info
  String getPrescriptionInfo() {
    return 'Prescription #$prescriptionId - Dr. ${doctor.name} → Patient ${patient.name}';
  }

  // Convert to Map for JSON serialization
  Map<String, dynamic> toMap() {
    return {
      'prescriptionId': prescriptionId,
      'doctor': {
        'id': doctor.id,
        'name': doctor.name,
        'specialization': doctor.specialization,
        'department': doctor.department,
      },
      'patient': {
        'id': patient.id,
        'name': patient.name,
        'age': patient.age,
        'bloodType': patient.bloodType,
      },
      'medicines': medicines.map((m) => _medicineToMap(m)).toList(),
      'issuedDate': issuedDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
      'notes': notes,
      'status': status,
    };
  }

  // Helper method to convert medicine to map
  Map<String, dynamic> _medicineToMap(Medicine medicine) {
    final map = {
      'id': medicine.id,
      'name': medicine.name,
      'dosage': medicine.dosage,
      'quantity': medicine.quantity,
      'manufacturer': medicine.manufacturer,
      'expiryDate': medicine.expiryDate.toIso8601String(),
      'frequency': medicine.frequency,
      'instructions': medicine.instructions,
      'type': medicine.getMedicineType(),
    };

    // Add type-specific fields
    if (medicine is Tablet) {
      map['shape'] = medicine.shape;
      map['color'] = medicine.color;
      map['coated'] = medicine.coated;
    } else if (medicine is Injection) {
      map['injectionType'] = medicine.injectionType;
      map['route'] = medicine.route;
      map['volumeMl'] = medicine.volumeMl;
    } else if (medicine is Syrup) {
      map['flavor'] = medicine.flavor;
      map['volumeMl'] = medicine.volumeMl;
      map['sugarFree'] = medicine.sugarFree;
    }

    return map;
  }

  // Create from Map for JSON deserialization
  static Prescription fromMap(
    Map<String, dynamic> map,
    Doctor doctor,
    Patient patient,
  ) {
    final medicines = (map['medicines'] as List).map((m) {
      return _medicineFromMap(m as Map<String, dynamic>);
    }).toList();

    return Prescription(
      prescriptionId: map['prescriptionId'],
      doctor: doctor,
      patient: patient,
      medicines: medicines,
      issuedDate: DateTime.parse(map['issuedDate']),
      expiryDate: DateTime.parse(map['expiryDate']),
      notes: map['notes'],
      status: map['status'] ?? 'active',
    );
  }

  // Helper to convert map back to medicine
  static Medicine _medicineFromMap(Map<String, dynamic> map) {
    final type = map['type'];

    if (type == 'Tablet') {
      return Tablet(
        id: map['id'],
        name: map['name'],
        dosage: map['dosage'],
        quantity: map['quantity'],
        manufacturer: map['manufacturer'],
        expiryDate: DateTime.parse(map['expiryDate']),
        frequency: map['frequency'] ?? 'As directed',
        instructions: map['instructions'] ?? 'Follow doctor\'s instructions',
        shape: map['shape'],
        color: map['color'],
        coated: map['coated'],
      );
    } else if (type == 'Injection') {
      return Injection(
        id: map['id'],
        name: map['name'],
        dosage: map['dosage'],
        quantity: map['quantity'],
        manufacturer: map['manufacturer'],
        expiryDate: DateTime.parse(map['expiryDate']),
        frequency: map['frequency'] ?? 'As directed',
        instructions: map['instructions'] ?? 'Follow doctor\'s instructions',
        injectionType: map['injectionType'],
        route: map['route'],
        volumeMl: map['volumeMl'],
      );
    } else {
      return Syrup(
        id: map['id'],
        name: map['name'],
        dosage: map['dosage'],
        quantity: map['quantity'],
        manufacturer: map['manufacturer'],
        expiryDate: DateTime.parse(map['expiryDate']),
        frequency: map['frequency'] ?? 'As directed',
        instructions: map['instructions'] ?? 'Follow doctor\'s instructions',
        flavor: map['flavor'],
        volumeMl: map['volumeMl'],
        sugarFree: map['sugarFree'],
      );
    }
  }

  @override
  String toString() =>
      'Prescription(id: $prescriptionId, doctor: ${doctor.name}, patient: ${patient.name}, medicines: ${medicines.length}, status: $status)';
}
