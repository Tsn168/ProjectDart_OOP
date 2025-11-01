import 'person.dart';

/// Abstract class for staff members (extends Person)
/// Demonstrates inheritance and encapsulation
abstract class Staff extends Person {
  final String _staffId;
  final String _department;
  final double _salary;
  final DateTime _joinDate;

  /// Constructor with inheritance
  Staff({
    required String id,
    required String name,
    required int age,
    required String email,
    required String phone,
    required String staffId,
    required String department,
    required double salary,
    required DateTime joinDate,
  })  : _staffId = staffId,
        _department = department,
        _salary = salary,
        _joinDate = joinDate,
        super(id: id, name: name, age: age, email: email, phone: phone) {
    _validateStaff();
  }

  /// Getters for Staff attributes (encapsulation)
  String get staffId => _staffId;
  String get department => _department;
  double get salary => _salary;
  DateTime get joinDate => _joinDate;

  /// Validation method
  void _validateStaff() {
    if (_department.isEmpty) throw ArgumentError('Department cannot be empty');
    if (_salary < 0) throw ArgumentError('Salary cannot be negative');
  }

  /// Calculate experience in years
  int getExperienceYears() {
    return DateTime.now().difference(_joinDate).inDays ~/ 365;
  }

  /// Abstract method to get staffing information
  String getStaffInfo();

  /// Display staff information with base person info
  @override
  String displayInfo() {
    return '''
    ${super.displayInfo()}
    Staff ID: $staffId | Department: $department | Salary: \$$salary | Experience: ${getExperienceYears()} years
    ''';
  }

  /// Override getRole to show polymorphism
  @override
  String getRole() => runtimeType.toString();

  @override
  String toString() =>
      'Staff(StaffID: $staffId, Name: $name, Department: $department)';
}
