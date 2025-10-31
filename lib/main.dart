import 'domain/prescription_service.dart';
import 'data/prescription_repo.dart';
import 'ui/ui_console.dart';

void main() {
  final prescriptionRepository = PrescriptionRepository();
  final prescriptionService = PrescriptionService();
  final console = HospitalConsole(prescriptionRepository, prescriptionService);

  prescriptionRepository.initialize();
  console.run();
}
