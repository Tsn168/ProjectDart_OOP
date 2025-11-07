import '../domain/entities/patient.dart';
import '../domain/entities/medication.dart';
import '../domain/enums/allergy_severity.dart';

/// Service for checking medication safety (allergy conflicts)
class SafetyService {
  /// Check if patient has allergy conflict with medication
  /// Returns true if there is a conflict
  static bool hasAllergyConflict(Patient patient, Medication medication) {
    for (var allergy in patient.allergies) {
      if (medication.name
              .toLowerCase()
              .contains(allergy.substance.toLowerCase()) ||
          allergy.substance
              .toLowerCase()
              .contains(medication.name.toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  static String? getAllergyDetails(Patient patient, Medication medication) {
    for (var allergy in patient.allergies) {
      if (medication.name
              .toLowerCase()
              .contains(allergy.substance.toLowerCase()) ||
          allergy.substance
              .toLowerCase()
              .contains(medication.name.toLowerCase())) {
        return '${allergy.substance} (${allergy.severity.name.toUpperCase()})';
      }
    }
    return null;
  }

  static bool isHighSeverity(Patient patient, Medication medication) {
    for (var allergy in patient.allergies) {
      if (medication.name
              .toLowerCase()
              .contains(allergy.substance.toLowerCase()) ||
          allergy.substance
              .toLowerCase()
              .contains(medication.name.toLowerCase())) {
        return allergy.severity == AllergySeverity.high;
      }
    }
    return false;
  }
}
