import 'medicine.dart';

/// Injection class extending Medicine (demonstrates polymorphism)
class Injection extends Medicine {
  final String _volume; // e.g., "10ml", "500mg/5ml"
  final String _type; // Intravenous, Intramuscular, Subcutaneous

  /// Constructor
  Injection({
    required String medicineId,
    required String name,
    required String description,
    required double price,
    required int stock,
    required String volume,
    required String type,
  })  : _volume = volume,
        _type = type,
        super(
          medicineId: medicineId,
          name: name,
          description: description,
          price: price,
          stock: stock,
        ) {
    _validateInjection();
  }

  /// Getters
  String get volume => _volume;
  String get type => _type;

  /// Validation
  void _validateInjection() {
    if (_volume.isEmpty) throw ArgumentError('Volume required');
    const validTypes = ['Intravenous', 'Intramuscular', 'Subcutaneous'];
    if (!validTypes.contains(_type))
      throw ArgumentError('Invalid injection type');
  }

  /// Polymorphic implementation
  @override
  String getMedicineType() => 'Injection';

  @override
  String getForm() => 'Liquid (Injectable)';

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
      'type': type,
      'injectionType': type,
      'medicineType': 'Injection',
    };
  }

  /// Factory constructor
  factory Injection.fromMap(Map<String, dynamic> map) {
    return Injection(
      medicineId: map['medicineId'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      stock: map['stock'] as int,
      volume: map['volume'] as String,
      type: map['type'] as String? ?? map['injectionType'] as String,
    );
  }

  @override
  String toString() => 'Injection(ID: $medicineId, Name: $name, Type: $type)';
}
