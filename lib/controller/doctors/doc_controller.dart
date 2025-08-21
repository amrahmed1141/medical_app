import 'package:flutter/material.dart';
import 'package:medical_app/model/doctors/doctors_model.dart';
import 'package:medical_app/services/supabase_service.dart';

class DoctorController extends ChangeNotifier {
  final SupabaseService _service = SupabaseService();

  List<Doctor> _doctors = [];
  bool _isLoading = false;

  List<Doctor> get doctors => _doctors;
  bool get isLoading => _isLoading;


  Future<void> loadAllDoctors()async{
    _isLoading=true;
    notifyListeners();

    _doctors= await _service.getAllDoctors();
    _isLoading=false;
    notifyListeners();
  }

  Future<void> loadDoctorsByCategory(String categoryName) async {
    _isLoading = true;
    notifyListeners();

    if (categoryName == "All") {
      _doctors = await _service.getAllDoctors();
    } else {
      _doctors = await _service.getDoctorsByCategoryName(categoryName);
    }

    _isLoading = false;
    notifyListeners();
  }
}
