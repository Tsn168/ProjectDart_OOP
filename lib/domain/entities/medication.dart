import '../enums/enums.dart';
import 'entity.dart';

class Medication extends Entity {
  final String _id;
  final String _name;
  final String _strength;
  final MedicationForm _form;
  int _stockQuantity;

  Medication({
    required String id,
    required String name,
    required String strength,
    required MedicationForm form,
    required int stockQuantity,
  })  : _id = id,
        _name = name,
        _strength = strength,
        _form = form,
        _stockQuantity = stockQuantity {
    if (stockQuantity < 0) {
      throw ArgumentError('Stock quantity cannot be negative');
    }
  }

  String get id => _id;
  String get name => _name;
  String get strength => _strength;
  MedicationForm get form => _form;
  int get stockQuantity => _stockQuantity;

  bool get isInStock => _stockQuantity > 0;
  bool get isLowStock => _stockQuantity < 20;
  bool get isCriticalStock => _stockQuantity < 5;

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

  void addStock(int quantity) {
    if (quantity < 0) {
      throw ArgumentError('Quantity cannot be negative');
    }
    _stockQuantity += quantity;
  }

  bool removeStock(int quantity) {
    if (quantity < 0) {
      throw ArgumentError('Quantity cannot be negative');
    }
    if (quantity > _stockQuantity) {
      return false;
    }
    _stockQuantity -= quantity;
    return true;
  }

  void resetStock() {
    _stockQuantity = 0;
  }

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
      'id': _id,
      'name': _name,
      'strength': _strength,
      'form': _form.name,
      'stockQuantity': _stockQuantity,
    };
  }

  @override
  String toString() {
    String stockDisplay;
    if (isCriticalStock) {
      stockDisplay = '🔴 $_stockQuantity (CRITICAL)';
    } else if (isLowStock) {
      stockDisplay = '🟡 $_stockQuantity (LOW)';
    } else {
      stockDisplay = '🟢 $_stockQuantity';
    }
    return '[$_id] $_name $_strength (${_form.name}) - Stock: $stockDisplay';
  }
}
