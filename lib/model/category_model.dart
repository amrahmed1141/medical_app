 
 import 'package:flutter/material.dart';
 import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MedicalCategory {
  final String name;
  final IconData icon;
  MedicalCategory({ required this.name, required this.icon});
 }

 final List<MedicalCategory> categories =[
    MedicalCategory(name: 'Cardiology', icon: FontAwesomeIcons.heartPulse),
    MedicalCategory(name: 'Pulmonology', icon: FontAwesomeIcons.lungs),
    MedicalCategory(name: 'Neurology', icon: FontAwesomeIcons.brain),
    MedicalCategory(name: 'Dentistry', icon: FontAwesomeIcons.tooth),
    MedicalCategory(name: 'Pediatrics', icon: FontAwesomeIcons.baby),
    MedicalCategory(name: 'Orthopedics', icon: FontAwesomeIcons.bone),
    MedicalCategory(name: 'Ophthalmology', icon: FontAwesomeIcons.eye),
    MedicalCategory(name: 'Dermatology', icon: FontAwesomeIcons.handSparkles),
    MedicalCategory(name: 'ENT', icon: FontAwesomeIcons.earListen),
 ];