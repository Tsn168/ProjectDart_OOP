import '../enums/medication_form.dart';
import 'entity.dart';

/// Entity representing a medication
/// Demonstrates: Inheritance, encapsulation of stock management
class Medication extends Entity {
  final String id;
  final String name;
  final String strength;
  final MedicationForm form;
  
  /// Private stock with getter/setter - Encapsulation
  int _stockQuantity;

  Medication({
    required this.id,
    required this.name,
    required this.strength,
    required this.form,
    required int stockQuantity,
  }) : _stockQuantity = stockQuantity;

  /// Getter for stock quantity
  int get stockQuantity => _stockQuantity;
  
  /// Setter with validation - Encapsulation
  set stockQuantity(int value) {
    if (value < 0) {
      throw ArgumentError('Stock quantity cannot be negative');
    }
    _stockQuantity = value;
  }
  
  /// Business logic: Decrease stock when medication is administered
  /// Demonstrates: Encapsulation of business rules
  bool administrate() {
    if (_stockQuantity > 0) {
      _stockQuantity--;
      return true;
    }
    return false;
  }
  
  /// Check if medication is in stock
  bool isInStock() => _stockQuantity > 0;
  
  /// Check if stock is low (less than 20 units)
  bool isLowStock() => _stockQuantity < 20;

  /// Factory constructor - Polymorphism
  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'] as String,
      name: json['name'] as String,
      strength: json['strength'] as String,
      form: MedicationForm.values.firstWhere(
        (e) => e.name == json['form'],
      ),
      stockQuantity: json['stockQuantity'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'strength': strength,
      'form': form.name,
      'stockQuantity': _stockQuantity,
    };
  }

  @override
  String toString() {
    final stock = isLowStock() ? '⚠️ $_stockQuantity' : _stockQuantity;
    return '[$id] $name $strength (${form.name}) - Stock: $stock';
  }
}
