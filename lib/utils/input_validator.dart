import 'dart:io';

/// Utility class for validating and sanitizing user input
class InputValidator {
  /// Read a non-empty string from user input
  static String readNonEmptyString(String prompt) {
    while (true) {
      stdout.write(prompt);
      String? input = stdin.readLineSync()?.trim();
      
      if (input != null && input.isNotEmpty) {
        return input;
      }
      
      print('❌ Error: Input cannot be empty. Please try again.');
    }
  }

  /// Read a positive integer from user input
  static int readPositiveInt(String prompt, {int? min, int? max}) {
    while (true) {
      stdout.write(prompt);
      String? input = stdin.readLineSync()?.trim();
      
      if (input == null || input.isEmpty) {
        print('❌ Error: Input cannot be empty. Please enter a number.');
        continue;
      }
      
      try {
        int value = int.parse(input);
        
        if (value <= 0) {
          print('❌ Error: Number must be positive. Please try again.');
          continue;
        }
        
        if (min != null && value < min) {
          print('❌ Error: Number must be at least $min. Please try again.');
          continue;
        }
        
        if (max != null && value > max) {
          print('❌ Error: Number must not exceed $max. Please try again.');
          continue;
        }
        
        return value;
      } catch (e) {
        print('❌ Error: Invalid number format. Please enter a valid integer.');
      }
    }
  }

  /// Read an integer within a specific range (for menu choices)
  static int readIntInRange(String prompt, int min, int max) {
    while (true) {
      stdout.write(prompt);
      String? input = stdin.readLineSync()?.trim();
      
      if (input == null || input.isEmpty) {
        print('❌ Error: Input cannot be empty. Please enter a number between $min and $max.');
        continue;
      }
      
      try {
        int value = int.parse(input);
        
        if (value < min || value > max) {
          print('❌ Error: Please enter a number between $min and $max.');
          continue;
        }
        
        return value;
      } catch (e) {
        print('❌ Error: Invalid input. Please enter a number between $min and $max.');
      }
    }
  }

  /// Read a yes/no confirmation
  static bool readConfirmation(String prompt) {
    while (true) {
      stdout.write('$prompt (yes/no): ');
      String? input = stdin.readLineSync()?.trim().toLowerCase();
      
      if (input == 'yes' || input == 'y') {
        return true;
      } else if (input == 'no' || input == 'n') {
        return false;
      }
      
      print('❌ Error: Please enter "yes" or "no".');
    }
  }

  /// Read an optional string (can be empty)
  static String readOptionalString(String prompt) {
    stdout.write(prompt);
    return stdin.readLineSync()?.trim() ?? '';
  }

  /// Validate email format
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Validate phone number format
  static bool isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    return phoneRegex.hasMatch(phone.replaceAll(RegExp(r'[\s-]'), ''));
  }
}
