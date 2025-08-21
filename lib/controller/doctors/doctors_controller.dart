
/*import 'package:flutter/material.dart';
import 'package:medical_app/model/doctors/doctors_model.dart';
import 'package:medical_app/services/supabase_service.dart';

class DoctorController extends ChangeNotifier{
  final SupabaseService _supabaseService = SupabaseService();

  List<Doctor> _allDoctors = [];
  List<Doctor> _filteredDoctors = [];
  List<Doctor> _doctorsByCategory = [];
  bool _isLoading = false;
  String? _error ;
  String _currentCategory = 'All';
   
  List<Doctor> get allDoctors => _allDoctors;
  List<Doctor> get filteredDoctors => _filteredDoctors;
  List<Doctor> get doctorsByCategory => _doctorsByCategory;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get currentCategory => _currentCategory;


  Future<void> loadAllDoctors ()async{
    _isLoading=true;
    _error=null;
    notifyListeners();

    try{
       _allDoctors= await _supabaseService.getAllDoctors();
      _filteredDoctors= _allDoctors;
      _doctorsByCategory= _allDoctors;
      _isLoading=false;
      notifyListeners();

    } catch (e){
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> filterDoctorsBySpecialty(String specialty)async{
    _isLoading=true;
    _error=null;
    _currentCategory=specialty;
    notifyListeners();

    try{
      if(specialty=='All'){
        _filteredDoctors=_allDoctors;
        _doctorsByCategory=_allDoctors;
      } else{
        _filteredDoctors= await _supabaseService.getDoctorsBySpecialty(specialty);
        _doctorsByCategory=_filteredDoctors;
      
      }
        _isLoading = false;
        notifyListeners();
    } catch (e){
        _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }

  }

  Future<void> filterDoctorByCategory(String categoryName)async{
    _isLoading=true;
    _currentCategory=categoryName;
    _error=null;
    notifyListeners();
    try{
      _doctorsByCategory= await _supabaseService.getDoctorsByCategoryName(categoryName);
      _filteredDoctors= _doctorsByCategory;
       _isLoading = false;
      notifyListeners();
    } catch(e){
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}*/