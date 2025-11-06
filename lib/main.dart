import 'data/prescription_repository.dart';
import 'ui/prescription_ui.dart';

void main() {
  // Initialize repository
  final repository = PrescriptionRepository();

  // Display welcome message
  print('\n╔═══════════════════════════════════════════╗');
  print('║  PRESCRIPTION MANAGEMENT SYSTEM        ║');
  print('║              Version 2.0                ║');
  print('╚═══════════════════════════════════════════╝');
  print('✓ System initialized');
  print('✓ 3 Default Doctors Available');
  print('  1. Dr. Tep Somnang (General Medicine)');
  print('  2. Dr. Tet Elite (Child Specialist)');
  print('  3. Dr. Choeng Rayu (Heart Pressure)');

  // Start UI
  final ui = PrescriptionUI(repository);
  ui.start();
}
