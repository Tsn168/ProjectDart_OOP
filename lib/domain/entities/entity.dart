/// Base abstract class for all domain entities
/// Demonstrates: Encapsulation + common interface
abstract class Entity {
  /// Every entity must have a unique identifier
  String get id;

  /// Convert entity to JSON for persistence
  Map<String, dynamic> toJson();

  /// Create entity from JSON
  /// This uses factory pattern for polymorphism
  static Entity? fromJson(Map<String, dynamic> json, String type) {
    // This will be implemented by concrete classes
    return null;
  }
}
