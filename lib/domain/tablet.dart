import 'medicine.dart';

class Tablet extends Medicine {
  final String shape;
  final String color;
  final bool coated;

  Tablet({
    required String id,
    required String name,
    required String dosage,
    required int quantity,
    required String manufacturer,
    required DateTime expiryDate,
    required String frequency,
    required String instructions,
    required this.shape,
    required this.color,
    this.coated = false,
  }) : super(
        id: id,
        name: name,
        dosage: dosage,
        quantity: quantity,
        manufacturer: manufacturer,
        expiryDate: expiryDate,
        frequency: frequency,
        instructions: instructions,
      );

  @override
  String getMedicineType() => 'Tablet';

  String getTabletInfo() {
    return '${getMedicineInfo()} - Shape: $shape, Color: $color, Coated: $coated';
  }

  @override
  String toString() =>
      'Tablet(id: $id, name: $name, shape: $shape, color: $color, isExpired: ${isExpired()})';
}
