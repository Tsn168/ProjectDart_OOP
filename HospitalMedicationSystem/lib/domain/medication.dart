import 'medication_form.dart';

/// Medication entity
class Medication {
  final String _id;
  final String _name;
  final String _strength;
  final MedicationForm _form;
  int _stockQuantity;

  Medication(
    this._id,
    this._name,
    this._strength,
    this._form,
    this._stockQuantity,
  ) {
    if (_stockQuantity < 0) {
      throw ArgumentError('Stock quantity cannot be negative');
    }
  }

  String get id => _id;
  String get name => _name;
  String get strength => _strength;
  MedicationForm get form => _form;
  int get stockQuantity => _stockQuantity;

  /// Check if medication is in stock
  bool get isInStock => _stockQuantity > 0;

  /// Check if sufficient quantity available
  bool hasSufficientStock(int quantity) {
    return _stockQuantity >= quantity;
  }

  /// Dispense medication (reduce stock)
  void dispense(int quantity) {
    if (quantity <= 0) {
      throw ArgumentError('Quantity must be positive');
    }
    if (!hasSufficientStock(quantity)) {
      throw StateError(
        'Insufficient stock. Available: $_stockQuantity, Requested: $quantity'
      );
    }
    _stockQuantity -= quantity;
  }

  /// Restock medication (increase stock)
  void restock(int quantity) {
    if (quantity <= 0) {
      throw ArgumentError('Quantity must be positive');
    }
    _stockQuantity += quantity;
  }

  /// JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'strength': _strength,
      'form': _form.toJson(),
      'stockQuantity': _stockQuantity,
    };
  }

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      json['id'] as String,
      json['name'] as String,
      json['strength'] as String,
      MedicationForm.fromString(json['form'] as String),
      json['stockQuantity'] as int,
    );
  }

  @override
  String toString() =>
      '$_name $_strength (${_form.displayName}) - Stock: $_stockQuantity';
}
