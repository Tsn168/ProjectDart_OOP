import 'medicine.dart';

/// Tablet class extending Medicine (demonstrates polymorphism)
class Tablet extends Medicine {
  final String _strength; // e.g., "500mg"
  final int _tabletsPerStrip;

  /// Constructor
  Tablet({
    required String medicineId,
    required String name,
    required String description,
    required double price,
    required int stock,
    required String strength,
    required int tabletsPerStrip,
  })  : _strength = strength,
        _tabletsPerStrip = tabletsPerStrip,
        super(
          medicineId: medicineId,
          name: name,
          description: description,
          price: price,
          stock: stock,
        ) {
    _validateTablet();
  }

  /// Getters
  String get strength => _strength;
  int get tabletsPerStrip => _tabletsPerStrip;

  /// Validation
  void _validateTablet() {
    if (_strength.isEmpty) throw ArgumentError('Strength required');
    if (_tabletsPerStrip <= 0)
      throw ArgumentError('Tablets per strip must be positive');
  }

  /// Polymorphic implementation
  @override
  String getMedicineType() => 'Tablet';

  @override
  String getForm() => 'Solid (Tablet)';

  @override
  String getDosage() => _strength;

  /// JSON Serialization
  @override
  Map<String, dynamic> toMap() {
    return {
      'medicineId': medicineId,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'strength': strength,
      'tabletsPerStrip': tabletsPerStrip,
      'type': 'Tablet',
    };
  }

  /// Factory constructor
  factory Tablet.fromMap(Map<String, dynamic> map) {
    return Tablet(
      medicineId: map['medicineId'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      stock: map['stock'] as int,
      strength: map['strength'] as String,
      tabletsPerStrip: map['tabletsPerStrip'] as int,
    );
  }

  @override
  String toString() =>
      'Tablet(ID: $medicineId, Name: $name, Strength: $strength)';
}
