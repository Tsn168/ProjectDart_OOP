import 'medicine.dart';

/// Syrup class extending Medicine (demonstrates polymorphism)
class Syrup extends Medicine {
  final String _volume; // e.g., "200ml", "100ml"
  final String _flavor;
  final bool _sugarFree;

  /// Constructor
  Syrup({
    required String medicineId,
    required String name,
    required String description,
    required double price,
    required int stock,
    required String volume,
    required String flavor,
    required bool sugarFree,
  })  : _volume = volume,
        _flavor = flavor,
        _sugarFree = sugarFree,
        super(
          medicineId: medicineId,
          name: name,
          description: description,
          price: price,
          stock: stock,
        ) {
    _validateSyrup();
  }

  /// Getters
  String get volume => _volume;
  String get flavor => _flavor;
  bool get sugarFree => _sugarFree;

  /// Validation
  void _validateSyrup() {
    if (_volume.isEmpty) throw ArgumentError('Volume required');
    if (_flavor.isEmpty) throw ArgumentError('Flavor required');
  }

  /// Polymorphic implementation
  @override
  String getMedicineType() => 'Syrup';

  @override
  String getForm() => 'Liquid (Oral Syrup)';

  @override
  String getDosage() => _volume;

  /// JSON Serialization
  @override
  Map<String, dynamic> toMap() {
    return {
      'medicineId': medicineId,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'volume': volume,
      'flavor': flavor,
      'sugarFree': sugarFree,
      'type': 'Syrup',
    };
  }

  /// Factory constructor
  factory Syrup.fromMap(Map<String, dynamic> map) {
    return Syrup(
      medicineId: map['medicineId'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      stock: map['stock'] as int,
      volume: map['volume'] as String,
      flavor: map['flavor'] as String,
      sugarFree: map['sugarFree'] as bool,
    );
  }

  @override
  String toString() => 'Syrup(ID: $medicineId, Name: $name, Flavor: $flavor)';
}
