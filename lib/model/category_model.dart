import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MedicalCategory {
  final String name;
  final IconData icon;
  final String specialtyKey; // Add this field for database matching
  
  MedicalCategory({ 
    required this.name, 
    required this.icon,
    required this.specialtyKey, // Map to doctor's specialty field
  });
}

final List<MedicalCategory> categories = [
  
  MedicalCategory(
    name: 'All', 
    icon: FontAwesomeIcons.mapPin, 
    specialtyKey: 'All' 
  ),
  MedicalCategory(name: 'Cardiology', icon: FontAwesomeIcons.heartPulse, specialtyKey: 'Cardiologist'),
  MedicalCategory(name: 'Pulmonology', icon: FontAwesomeIcons.lungs, specialtyKey: 'Pulmonologist'),
  MedicalCategory(name: 'Neurology', icon: FontAwesomeIcons.brain, specialtyKey: 'Neurologist'),
  MedicalCategory(name: 'Dentistry', icon: FontAwesomeIcons.tooth, specialtyKey: 'Dentist'),
  MedicalCategory(name: 'Pediatrics', icon: FontAwesomeIcons.baby, specialtyKey: 'Pediatrician'),
  MedicalCategory(name: 'Orthopedics', icon: FontAwesomeIcons.bone, specialtyKey: 'Orthopedic Surgeon'),
  MedicalCategory(name: 'Ophthalmology', icon: FontAwesomeIcons.eye, specialtyKey: 'Ophthalmologist'),
  MedicalCategory(name: 'Dermatology', icon: FontAwesomeIcons.handSparkles, specialtyKey: 'Dermatologist'),
  MedicalCategory(name: 'ENT', icon: FontAwesomeIcons.earListen, specialtyKey: 'ENT Specialist'),
];