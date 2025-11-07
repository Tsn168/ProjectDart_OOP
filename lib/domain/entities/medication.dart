import '../enums/enums.dart';
import 'entity.dart';

/// Entity representing a medication
/// Demonstrates: Inheritance, encapsulation of stock management
class Medication extends Entity {
  final String id;
  final String name;
  final String strength;
  final MedicationForm form;

  int _stockQuantity;

  Medication({
    required this.id,
    required this.name,
    required this.strength,
    required this.form,
    required int stockQuantity,
  }) : _stockQuantity = stockQuantity;

  int get stockQuantity => _stockQuantity;

  set stockQuantity(int value) {
    if (value < 0) {
      throw ArgumentError('Stock quantity cannot be negative');
    }
    _stockQuantity = value;
  }

  bool administrate() {
    if (_stockQuantity > 0) {
      _stockQuantity--;
      return true;
    }
    return false;
  }

  bool isInStock() => _stockQuantity > 0;
  bool isLowStock() => _stockQuantity < 20;
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
