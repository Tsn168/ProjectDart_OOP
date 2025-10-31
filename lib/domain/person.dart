abstract class Person {
  final String id;
  final String name;
  final int age;
  final String email;
  final String phoneNumber;
  final String address;

  Person({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  // Abstract method to be implemented by subclasses
  String getRole();

  // Display person information
  void displayInfo() {
    print('ID: $id');
    print('Name: $name');
    print('Age: $age');
    print('Email: $email');
    print('Phone: $phoneNumber');
    print('Address: $address');
    print('Role: ${getRole()}');
  }

  @override
  String toString() =>
      'Person(id: $id, name: $name, age: $age, role: ${getRole()})';
}
