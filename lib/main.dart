import 'domain/medicine.dart';
import 'data/seed_data.dart';
import 'domain/prescription_service.dart';
import 'data/prescription_repo.dart';
import 'ui/ui_console.dart';

void main() {
  // Load default/seed data (pre-populated from database)
  final doctors = SeedData.getDefaultDoctors();
  final patients = SeedData.getDefaultPatients();
  final medicines = SeedData.getDefaultMedicines() as List<Medicine>;

  final prescriptionRepository = PrescriptionRepository();
  final prescriptionService = PrescriptionService();

  // Initialize console with pre-loaded data
  final console = PrescriptionConsole(
    prescriptionRepository,
    prescriptionService,
    doctors,
    patients,
    medicines,
  );

  prescriptionRepository.initialize();
  console.run();
}
