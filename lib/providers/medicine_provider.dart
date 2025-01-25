import 'package:flutter/material.dart';
import '../models/medicine.dart';

class MedicineProvider extends ChangeNotifier {
  final List<Medicine> _medicines = [];

  List<Medicine> get medicines => _medicines;

  void addMedicine(Medicine medicine) {
    _medicines.add(medicine);
    notifyListeners();
  }

  void updateMedicine(String id, Medicine updatedMedicine) {
    final index = _medicines.indexWhere((med) => med.id == id);
    if (index != -1) {
      _medicines[index] = updatedMedicine;
      notifyListeners();
    }
  }

  void deleteMedicine(String id) {
    _medicines.removeWhere((med) => med.id == id);
    notifyListeners();
  }
}
