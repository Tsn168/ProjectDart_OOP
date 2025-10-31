abstract class Medicine {
  final String id;
  final String name;
  final String dosage;
  final int quantity;
  final String manufacturer;
  final DateTime expiryDate;

  Medicine({
    required this.id,
    required this.name,
    required this.dosage,
    required this.quantity,
    required this.manufacturer,
    required this.expiryDate,
  });

  // Abstract method to be implemented by subclasses
  String getMedicineType();

  // Check if medicine is expired
  bool isExpired() {
    return DateTime.now().isAfter(expiryDate);
  }

  // Get medicine information
  String getMedicineInfo() {
    return '${getMedicineType()} - $name ($dosage)';
  }

  @override
  String toString() =>
      'Medicine(id: $id, name: $name, type: ${getMedicineType()}, dosage: $dosage, quantity: $quantity)';
}
