/// Base abstract class for all domain entities
/// Demonstrates: Encapsulation + common interface
abstract class Entity {
  String get id;
  Map<String, dynamic> toJson();
  static Entity? fromJson(Map<String, dynamic> json, String type) {
    return null;
  }
}
