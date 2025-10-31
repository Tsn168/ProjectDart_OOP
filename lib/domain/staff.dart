import 'person.dart';

class Staff extends Person {
  final String specialization;
  final bool isAvailable;
  final double salary;

  Staff({
    required String id,
    required String name,
    required int age,
    required String email,
    required String phoneNumber,
    required String address,
    required this.specialization,
    this.isAvailable = true,
    required this.salary,
  }) : super(
         id: id,
         name: name,
         age: age,
         email: email,
         phoneNumber: phoneNumber,
         address: address,
       );

  @override
  String getRole() => 'Staff';

  Staff copyWith({bool? isAvailable}) {
    return Staff(
      id: id,
      name: name,
      age: age,
      email: email,
      phoneNumber: phoneNumber,
      address: address,
      specialization: specialization,
      isAvailable: isAvailable ?? this.isAvailable,
      salary: salary,
    );
  }

  @override
  String toString() =>
      'Staff(id: $id, name: $name, specialization: $specialization, isAvailable: $isAvailable)';
}
