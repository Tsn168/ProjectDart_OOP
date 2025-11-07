import 'dart:io';
import 'dart:convert';
import '../domain/entities/medical_staff.dart';
import '../domain/enums/staff_role.dart';

/// Repository for managing medical staff
class StaffRepository {
  final List<MedicalStaff> _staff = [];
  final String _dataFile = 'data/staff.json';

  StaffRepository() {
    _loadFromFile();
  }

  /// Get all staff members
  List<MedicalStaff> getAllStaff() {
    return List.unmodifiable(_staff);
  }

  /// Get staff by ID
  MedicalStaff? getStaffById(String id) {
    try {
      return _staff.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get all doctors
  List<MedicalStaff> getDoctors() {
    return _staff.where((s) => s.role == StaffRole.doctor).toList();
  }

  /// Get all nurses
  List<MedicalStaff> getNurses() {
    return _staff.where((s) => s.role == StaffRole.nurse).toList();
  }

  /// Load staff from JSON file
  void _loadFromFile() {
    try {
      final file = File(_dataFile);
      if (file.existsSync()) {
        final jsonString = file.readAsStringSync();
        final List<dynamic> jsonList = json.decode(jsonString);
        _staff.clear();
        _staff.addAll(jsonList.map((j) => MedicalStaff.fromJson(j)).toList());
      } else {
        _initializeDefaultData();
      }
    } catch (e) {
      _initializeDefaultData();
    }
  }

  /// Save staff to JSON file
  void _saveToFile() {
    try {
      final file = File(_dataFile);
      file.createSync(recursive: true);
      final jsonString = json.encode(_staff.map((s) => s.toJson()).toList());
      file.writeAsStringSync(jsonString);
    } catch (e) {
      print('Error saving staff: $e');
    }
  }

  /// Initialize with default staff data
  void _initializeDefaultData() {
    _staff.clear();
    _staff.add(MedicalStaff(
      id: 'D001',
      name: 'Dr. Smith',
      role: StaffRole.doctor,
    ));
    _staff.add(MedicalStaff(
      id: 'D002',
      name: 'Dr. Johnson',
      role: StaffRole.doctor,
    ));
    _staff.add(MedicalStaff(
      id: 'N001',
      name: 'Nurse Wilson',
      role: StaffRole.nurse,
    ));
    _staff.add(MedicalStaff(
      id: 'N002',
      name: 'Nurse Brown',
      role: StaffRole.nurse,
    ));
    _saveToFile();
  }
}
