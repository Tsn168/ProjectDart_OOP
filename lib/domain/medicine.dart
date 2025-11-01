/// Abstract superclass for all medicine types
/// Demonstrates encapsulation and polymorphism
abstract class Medicine {
  final String _medicineId;
  final String _name;
  final String _description;
  final double _price;
  final int _stock;

  /// Constructor with validation
  Medicine({
    required String medicineId,
    required String name,
    required String description,
    required double price,
    required int stock,
  })  : _medicineId = medicineId,
        _name = name,
        _description = description,
        _price = price,
        _stock = stock {
    _validateMedicine();
  }

  /// Getters (encapsulation)
  String get medicineId => _medicineId;
  String get name => _name;
  String get description => _description;
  double get price => _price;
  int get stock => _stock;

  /// Validation method
  void _validateMedicine() {
    if (_name.isEmpty) throw ArgumentError('Medicine name cannot be empty');
    if (_price < 0) throw ArgumentError('Price cannot be negative');
    if (_stock < 0) throw ArgumentError('Stock cannot be negative');
  }

  /// Abstract polymorphic method
  String getMedicineType();

  /// Abstract method for form
  String getForm();

  /// Abstract method for dosage
  String getDosage();

  /// Abstract JSON serialization
  Map<String, dynamic> toMap();

  /// Display medicine information
  String displayInfo() {
    return '''
    ID: $medicineId | Name: $name | Type: ${getMedicineType()} | Form: ${getForm()} | Price: \$$price | Stock: $stock
    ''';
  }

  @override
  String toString() =>
      'Medicine(ID: $medicineId, Name: $name, Type: ${getMedicineType()})';
}
