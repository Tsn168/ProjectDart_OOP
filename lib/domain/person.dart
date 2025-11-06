/// Abstract Person class - Base class (INHERITANCE)
/// Demonstrates encapsulation with private attributes
abstract class Person {
  final String _id;
  final String _name;
  final int _age;
  final String _gender;

  Person({
    required String id,
    required String name,
    required int age,
    required String gender,
  })  : _id = id,
        _name = name,
        _age = age,
        _gender = gender {
    // Validate age
    if (age < 0) {
      throw ArgumentError('Age cannot be negative. Received: $age');
    }
    if (age > 150) {
      throw ArgumentError('Age cannot be greater than 150. Received: $age');
    }
  }

  /// Getters - Encapsulation
  String get id => _id;
  String get name => _name;
  int get age => _age;
  String get gender => _gender;

  /// Polymorphic method
  String getRole();

  /// JSON serialization
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'age': age,
        'gender': gender,
      };
}
