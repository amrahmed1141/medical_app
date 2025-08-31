

import 'package:flutter/material.dart';
import 'package:medical_app/model/doctors/doctors_model.dart';

class DetailsController extends ChangeNotifier{
Doctor? _selectedDoctor;

 Doctor? get selectedDoctor => _selectedDoctor;

 void navigateDoctorDetails (Doctor doctor){
  _selectedDoctor=doctor;
  notifyListeners();
 }
}