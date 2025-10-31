import 'medicine.dart';

class Injection extends Medicine {
  final String injectionType;
  final String route;
  final double volumeMl;

  Injection({
    required String id,
    required String name,
    required String dosage,
    required int quantity,
    required String manufacturer,
    required DateTime expiryDate,
    required this.injectionType,
    required this.route,
    required this.volumeMl,
  }) : super(
         id: id,
         name: name,
         dosage: dosage,
         quantity: quantity,
         manufacturer: manufacturer,
         expiryDate: expiryDate,
       );

  @override
  String getMedicineType() => 'Injection';

  String getInjectionInfo() {
    return '${getMedicineInfo()} - Type: $injectionType, Route: $route, Volume: ${volumeMl}ml';
  }

  @override
  String toString() =>
      'Injection(id: $id, name: $name, type: $injectionType, route: $route, isExpired: ${isExpired()})';
}
