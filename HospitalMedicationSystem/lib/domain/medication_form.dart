/// Medication form enumeration
enum MedicationForm {
  tablet,
  liquid,
  injection,
  ointment,
  inhaler;

  String get displayName {
    switch (this) {
      case MedicationForm.tablet:
        return 'Tablet';
      case MedicationForm.liquid:
        return 'Liquid';
      case MedicationForm.injection:
        return 'Injection';
      case MedicationForm.ointment:
        return 'Ointment';
      case MedicationForm.inhaler:
        return 'Inhaler';
    }
  }

  static MedicationForm fromString(String value) {
    switch (value.toLowerCase()) {
      case 'tablet':
        return MedicationForm.tablet;
      case 'liquid':
        return MedicationForm.liquid;
      case 'injection':
        return MedicationForm.injection;
      case 'ointment':
        return MedicationForm.ointment;
      case 'inhaler':
        return MedicationForm.inhaler;
      default:
        throw ArgumentError('Invalid medication form: $value');
    }
  }

  String toJson() => name;
}
