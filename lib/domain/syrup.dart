import 'medicine.dart';

class Syrup extends Medicine {
  final String flavor;
  final double volumeMl;
  final bool sugarFree;

  Syrup({
    required String id,
    required String name,
    required String dosage,
    required int quantity,
    required String manufacturer,
    required DateTime expiryDate,
    required String frequency,
    required String instructions,  
    required this.flavor,
    required this.volumeMl,
    this.sugarFree = false,
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
  String getMedicineType() => 'Syrup';

  String getSyrupInfo() {
    return '${getMedicineInfo()} - Flavor: $flavor, Volume: ${volumeMl}ml, SugarFree: $sugarFree';
  }

  @override
  String toString() =>
      'Syrup(id: $id, name: $name, flavor: $flavor, volumeMl: $volumeMl, isExpired: ${isExpired()})';
}
