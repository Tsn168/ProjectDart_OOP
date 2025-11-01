import 'data/prescription_repository.dart';
import 'ui/prescription_ui.dart';

void main() {
  // Initialize repository (loads prescriptions from JSON)
  final repository = PrescriptionRepository();

  // Display welcome message
  print('\n╔════════════════════════════════════════════╗');
  print('║  WELCOME TO PRESCRIPTION MANAGEMENT SYSTEM║');
  print('║              Version 1.0                  ║');
  print('╚════════════════════════════════════════════╝');
  print('✓ System initialized successfully');
  print('✓ Default Doctor: Dr. John Doe');

  // Initialize and start UI
  final ui = PrescriptionUI(repository);
  ui.start();
}
