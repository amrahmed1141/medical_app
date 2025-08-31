import 'package:flutter/material.dart';
import 'package:medical_app/model/appointment/appointment_model.dart';
import 'package:medical_app/services/supabase_service.dart';

class AppointmentController with ChangeNotifier {
  final SupabaseService _service= SupabaseService();
  String? _currentUserId;
  
  List<Appointment> _appointments = [];
  List<Appointment> _upcomingAppointments = [];
  List<Appointment> _completedAppointments = [];
  bool _isLoading = false;
  String? _error;

  List<Appointment> get appointments => _appointments;
  List<Appointment> get upcomingAppointments => _upcomingAppointments;
  List<Appointment> get completedAppointments => _completedAppointments;
  bool get isLoading => _isLoading;
  String? get error => _error;

 

  void setUserId(String userId) {
    _currentUserId = userId;
  }

  Future<void> loadUserAppointments() async {
    if (_currentUserId == null) return;
    
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _appointments = await _service.getUserAppointments(_currentUserId!);
      _categorizeAppointments();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void _categorizeAppointments() {
    _upcomingAppointments = _appointments.where((appt) => appt.isUpcoming).toList();
    _completedAppointments = _appointments.where((appt) => appt.isCompleted).toList();
  }

  Future<bool> bookAppointment({
  required String doctorId,
  required String doctorName,
  required String doctorSpecialty,
  required String doctorImage,
  required DateTime date,
  required String time,
  required double price,
  String? notes,
  String? paymentId,
}) async {
  if (_currentUserId == null) {
    debugPrint('Cannot book appointment: currentUserId is null');
    return false;
  }
  
  _isLoading = true;
  _error = null;
  notifyListeners();

  try {
    debugPrint('Booking appointment for user: $_currentUserId');
    
    final appointmentData = {
      'user_id': _currentUserId!,
      'doctor_id': doctorId,
      'doctor_name': doctorName,
      'doctor_specialty': doctorSpecialty,
      'doctor_image': doctorImage,
      'date': date.toIso8601String().split('T')[0],
      'time': time,
      'status': 'pending',
      'price': price,
      'notes': notes,
      'payment_id': paymentId,
    };

    debugPrint('Appointment data: $appointmentData');

    final success = await _service.createAppointment(appointmentData);

    if (success) {
      debugPrint('Appointment booked successfully, reloading...');
      await loadUserAppointments();
    } else {
      debugPrint('Failed to book appointment');
      _error = 'Failed to create appointment. Please try again.';
    }
    
    _isLoading = false;
    notifyListeners();
    return success;
    
  } catch (e) {
    debugPrint('Error in bookAppointment: $e');
    _error = 'An unexpected error occurred: ${e.toString()}';
    _isLoading = false;
    notifyListeners();
    return false;
  }
}

  Future<bool> updateAppointmentStatus(String appointmentId, String status) async {
    if (_currentUserId == null) return false;
    
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final success = await _service.updateAppointmentStatus(appointmentId, status);
      if (success) {
        await loadUserAppointments();
      }
      _isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> cancelAppointment(String appointmentId) async {
    return await updateAppointmentStatus(appointmentId, 'cancelled');
  }

  Future<bool> confirmAppointment(String appointmentId) async {
    return await updateAppointmentStatus(appointmentId, 'confirmed');
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
