/// Abstract superclass for all persons in the hospital system
/// Demonstrates encapsulation with private attributes and public getters
abstract class Person {
  final String _id;
  final String _name;
  final int _age;
  final String _email;
  final String _phone;

  /// Constructor with validation using encapsulation
  Person({
    required String id,
    required String name,
    required int age,
    required String email,
    required String phone,
  })  : _id = id,
        _name = name,
        _age = age,
        _email = email,
        _phone = phone {
    _validatePerson();
  }

  /// Getters (read-only access to private fields)
  String get id => _id;
  String get name => _name;
  int get age => _age;
  String get email => _email;
  String get phone => _phone;

  /// Validation method demonstrating encapsulation
  void _validatePerson() {
    if (_name.isEmpty) throw ArgumentError('Name cannot be empty');
    if (_age < 0 || _age > 150) throw ArgumentError('Invalid age');
    if (!_email.contains('@')) throw ArgumentError('Invalid email format');
  }

  /// Abstract method demonstrating polymorphism
  String getRole();

  /// Abstract method for JSON serialization
  Map<String, dynamic> toMap();

  /// Factory constructor for deserialization
  static Person fromMap(Map<String, dynamic> map) {
    throw UnsupportedError('Use concrete subclass factory methods');
  }

  /// Display person information
  String displayInfo() {
    return '''
    ID: $id | Name: $name | Age: $age | Email: $email | Phone: $phone | Role: ${getRole()}
    ''';
  }

  @override
  String toString() => 'Person(ID: $id, Name: $name, Role: ${getRole()})';
}
