

import 'package:flutter/material.dart';
import 'package:medical_app/model/category_model.dart';

class CategoryController extends ChangeNotifier {

final List<MedicalCategory> _category = categories;

 int _selectedIndex = 0;


List<MedicalCategory> get category => _category;
int get selectedIndex => _selectedIndex;

void selectCategory (int index){
  _selectedIndex=index;
  notifyListeners();
}

}